Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC264B677B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiBOJYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:24:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiBOJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:24:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291586CA40
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:23:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8D3931F43B3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644917034;
        bh=hcFgN+kiCWyV67UTRX3dStpLJO5sEXbV1LYXA+9D5z8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S7jfbAdb/5nprt+0wj2VMT0eCmVD1a3pkyqXisfTHz2JX2wH/4aNjS9IJDrcXQxUk
         kn3fd++81y+RbTiEiKwetSJ9OsX0Kk2526HQL+baoenLf8wi+W2BuIzcSmUOCtPma/
         zW4YKSeDZRrgtgFKk2TD9LFg0j6GCYuNwtQoE5i+q1zjFr8CRwa/jPdjVHqYMv9ilS
         z3q7rQnlaxfPrc1KFDjMi26kMNO9guQF9SEXSeFtIHrA3hinlZrIYQR14ur0dIxnS9
         YdSEjLTqp6kdASK9c0K0SMK3a1SxQC9xx/gwt+zktVba1joLR3+yzs1U+w7mZ8wFgM
         h7dhyw/b1JrhA==
Message-ID: <5119045c-3c30-3625-d7ba-3100eda3ccbd@collabora.com>
Date:   Tue, 15 Feb 2022 10:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/panfrost: Dynamically allocate pm_domains
Content-Language: en-US
To:     Alyssa Rosenzweig <alyssa@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
 <YgrBwwT37DpOOkt5@maud>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YgrBwwT37DpOOkt5@maud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/02/22 21:55, Alyssa Rosenzweig ha scritto:
> mali_kbase hardcodes MAX_PM_DOMAINS (=5 for the mt8192 kernel). I have
> no real objection to it but Angelo did. Maybe should've marked this RFC.

Clarifying, the suggested patch was not a big objection, but I think that it
would be a nice preventive cleanup that is useful for the power tree that has
to be managed on MT8192 and possibly on other SoCs.

I would expect to see a variable amount of PM domains to take care of as time
goes by (with new SoCs, not necessarily only MediaTek) due to granular power
optimizations but, at the same time, dynamically allocating the pm_domain_devs
and links structures makes this driver to also be nice with older platforms,
where memory is a little more constrained, allowing Linux to have a lighter
footprint, even if not by much.

Logic for this footprint saving is "a little here, a little there, becomes a
bit more considerable" (of course, being aware of both upsides and downsides
in dynamically allocating things, and avoiding to write gigabytes of text to
explain common knowledge).

P.S.: Thank you all!

Regards,
Angelo

> 
> On Mon, Feb 14, 2022 at 03:31:32PM -0500, Alyssa Rosenzweig wrote:
>> MT8192 requires 5 power domains. Rather than bump MAX_PM_DOMAINS and
>> waste memory on every supported Panfrost chip, instead dynamically
>> allocate pm_domain_devs and pm_domain_links. This adds some flexibility;
>> it seems inevitable a new MediaTek device will require more than 5
>> domains.
>>
>> On non-MediaTek devices, this saves a small amount of memory.
>>
>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_device.c | 14 ++++++++++----
>>   drivers/gpu/drm/panfrost/panfrost_device.h |  5 ++---
>>   2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
>> index ee612303f076..661cdec320af 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
>> @@ -127,7 +127,10 @@ static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
>>   {
>>   	int i;
>>   
>> -	for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
>> +	if (!pfdev->pm_domain_devs || !pfdev->pm_domain_links)
>> +		return;
>> +
>> +	for (i = 0; i < pfdev->comp->num_pm_domains; i++) {
>>   		if (!pfdev->pm_domain_devs[i])
>>   			break;
>>   
>> @@ -161,9 +164,12 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (WARN(num_domains > ARRAY_SIZE(pfdev->pm_domain_devs),
>> -			"Too many supplies in compatible structure.\n"))
>> -		return -EINVAL;
>> +	pfdev->pm_domain_devs = devm_kcalloc(pfdev->dev, num_domains,
>> +					     sizeof(*pfdev->pm_domain_devs),
>> +					     GFP_KERNEL);
>> +	pfdev->pm_domain_links = devm_kcalloc(pfdev->dev, num_domains,
>> +					      sizeof(*pfdev->pm_domain_links),
>> +					      GFP_KERNEL);
>>   
>>   	for (i = 0; i < num_domains; i++) {
>>   		pfdev->pm_domain_devs[i] =
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
>> index 8b25278f34c8..98e3039696f9 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
>> @@ -22,7 +22,6 @@ struct panfrost_job;
>>   struct panfrost_perfcnt;
>>   
>>   #define NUM_JOB_SLOTS 3
>> -#define MAX_PM_DOMAINS 3
>>   
>>   struct panfrost_features {
>>   	u16 id;
>> @@ -87,8 +86,8 @@ struct panfrost_device {
>>   	struct regulator_bulk_data *regulators;
>>   	struct reset_control *rstc;
>>   	/* pm_domains for devices with more than one. */
>> -	struct device *pm_domain_devs[MAX_PM_DOMAINS];
>> -	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
>> +	struct device **pm_domain_devs;
>> +	struct device_link **pm_domain_links;
>>   	bool coherent;
>>   
>>   	struct panfrost_features features;
>> -- 
>> 2.34.1
>>
