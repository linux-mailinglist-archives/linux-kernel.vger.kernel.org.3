Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC814B5BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiBNU47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:56:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiBNU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:56:50 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47E110EEF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:56:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 0684A1F43F8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644872138;
        bh=FhWthb7qNxu03PTR+1xu680Z2C1ejB/i7ZmEdzpMulc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7bvmDJKC/KLr4wErTlMsyAfKeEyGqSN6gQTzua8c952ikB5zzidLyuqZj/TmEacs
         y0YqIAKrwnY7a2hNH1aCH5UuWsRK3+1SOs/aH/NXsIA7MJy9fDzCmfK+sun84KWgX+
         sywl+KZvKaya4FjMpVwt6+yvpC3l68VBJp11/y3VLGMxzojyzM0KR6LDs05abIasap
         UN1GWUHQpLTOh8bSLc92ByJyQ3ejdBHgFfb3lD8f/sF3BryDEsMrZAVgH7XTQu5TN4
         ymmZSQTxVGkaaV0g1kdEbkROA2OYHVmxI92OptcZPPM25ICEcvkcUufskkBr+GBBt4
         EP48qKEq6heJw==
Date:   Mon, 14 Feb 2022 15:55:31 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/panfrost: Dynamically allocate pm_domains
Message-ID: <YgrBwwT37DpOOkt5@maud>
References: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mali_kbase hardcodes MAX_PM_DOMAINS (=5 for the mt8192 kernel). I have
no real objection to it but Angelo did. Maybe should've marked this RFC.

On Mon, Feb 14, 2022 at 03:31:32PM -0500, Alyssa Rosenzweig wrote:
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
>  drivers/gpu/drm/panfrost/panfrost_device.c | 14 ++++++++++----
>  drivers/gpu/drm/panfrost/panfrost_device.h |  5 ++---
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index ee612303f076..661cdec320af 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -127,7 +127,10 @@ static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
> +	if (!pfdev->pm_domain_devs || !pfdev->pm_domain_links)
> +		return;
> +
> +	for (i = 0; i < pfdev->comp->num_pm_domains; i++) {
>  		if (!pfdev->pm_domain_devs[i])
>  			break;
>  
> @@ -161,9 +164,12 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
>  		return -EINVAL;
>  	}
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
>  
>  	for (i = 0; i < num_domains; i++) {
>  		pfdev->pm_domain_devs[i] =
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 8b25278f34c8..98e3039696f9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -22,7 +22,6 @@ struct panfrost_job;
>  struct panfrost_perfcnt;
>  
>  #define NUM_JOB_SLOTS 3
> -#define MAX_PM_DOMAINS 3
>  
>  struct panfrost_features {
>  	u16 id;
> @@ -87,8 +86,8 @@ struct panfrost_device {
>  	struct regulator_bulk_data *regulators;
>  	struct reset_control *rstc;
>  	/* pm_domains for devices with more than one. */
> -	struct device *pm_domain_devs[MAX_PM_DOMAINS];
> -	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
> +	struct device **pm_domain_devs;
> +	struct device_link **pm_domain_links;
>  	bool coherent;
>  
>  	struct panfrost_features features;
> -- 
> 2.34.1
> 
