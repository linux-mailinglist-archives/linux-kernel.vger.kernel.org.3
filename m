Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC874B6BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiBOMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:09:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiBOMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:09:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60D6EEF0B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:09:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A9B1480;
        Tue, 15 Feb 2022 04:09:21 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFF733F718;
        Tue, 15 Feb 2022 04:09:20 -0800 (PST)
Message-ID: <f408da05-a825-c392-6484-3a665cc0dbd6@arm.com>
Date:   Tue, 15 Feb 2022 12:09:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] drm/panfrost: Dynamically allocate pm_domains
Content-Language: en-GB
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 20:31, Alyssa Rosenzweig wrote:
> MT8192 requires 5 power domains. Rather than bump MAX_PM_DOMAINS and
> waste memory on every supported Panfrost chip, instead dynamically
> allocate pm_domain_devs and pm_domain_links. This adds some flexibility;
> it seems inevitable a new MediaTek device will require more than 5
> domains.
> 
> On non-MediaTek devices, this saves a small amount of memory.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_device.c | 14 ++++++++++----
>   drivers/gpu/drm/panfrost/panfrost_device.h |  5 ++---
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index ee612303f076..661cdec320af 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -127,7 +127,10 @@ static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
>   {
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
> +	if (!pfdev->pm_domain_devs || !pfdev->pm_domain_links)
> +		return;
> +
> +	for (i = 0; i < pfdev->comp->num_pm_domains; i++) {
>   		if (!pfdev->pm_domain_devs[i])
>   			break;
>   
> @@ -161,9 +164,12 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
>   		return -EINVAL;
>   	}
>   
> -	if (WARN(num_domains > ARRAY_SIZE(pfdev->pm_domain_devs),
> -			"Too many supplies in compatible structure.\n"))
> -		return -EINVAL;
> +	pfdev->pm_domain_devs = devm_kcalloc(pfdev->dev, num_domains,
> +					     sizeof(*pfdev->pm_domain_devs),
> +					     GFP_KERNEL);
> +	pfdev->pm_domain_links = devm_kcalloc(pfdev->dev, num_domains,
> +					      sizeof(*pfdev->pm_domain_links),
> +					      GFP_KERNEL);

Since we're not really doing any detailed management of our device 
links, could we get away with using AUTOREMOVE_CONSUMER instead of 
STATELESS to avoid having to explicitly keep track of them ourselves?

Robin.

>   
>   	for (i = 0; i < num_domains; i++) {
>   		pfdev->pm_domain_devs[i] =
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 8b25278f34c8..98e3039696f9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -22,7 +22,6 @@ struct panfrost_job;
>   struct panfrost_perfcnt;
>   
>   #define NUM_JOB_SLOTS 3
> -#define MAX_PM_DOMAINS 3
>   
>   struct panfrost_features {
>   	u16 id;
> @@ -87,8 +86,8 @@ struct panfrost_device {
>   	struct regulator_bulk_data *regulators;
>   	struct reset_control *rstc;
>   	/* pm_domains for devices with more than one. */
> -	struct device *pm_domain_devs[MAX_PM_DOMAINS];
> -	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
> +	struct device **pm_domain_devs;
> +	struct device_link **pm_domain_links;
>   	bool coherent;
>   
>   	struct panfrost_features features;
