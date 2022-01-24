Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479C74984B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbiAXQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:25:54 -0500
Received: from foss.arm.com ([217.140.110.172]:39568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241096AbiAXQZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:25:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D73E0D6E;
        Mon, 24 Jan 2022 08:25:52 -0800 (PST)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC9683F793;
        Mon, 24 Jan 2022 08:25:51 -0800 (PST)
Message-ID: <61e0804c-fd09-a16d-8080-c06b1eb3c5aa@foss.arm.com>
Date:   Mon, 24 Jan 2022 16:25:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/arm: arm hdlcd select DRM_GEM_CMA_HELPER
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
References: <20220124151357.2467149-1-carsten.haitzler@foss.arm.com>
 <b302b8f4-40de-7b88-fbf5-933707476cdb@arm.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <b302b8f4-40de-7b88-fbf5-933707476cdb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent an updated patch with the Fixes:

On 1/24/22 16:13, Steven Price wrote:
> On 24/01/2022 15:13, carsten.haitzler@foss.arm.com wrote:
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> Without DRM_GEM_CMA_HELPER HDLCD won't build. This needs to be there too.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> To add the context, DRM_HDLCD used to select DRM_KMS_CMA_HELPER but that
> was removed in commit 09717af7d13d ("drm: Remove
> CONFIG_DRM_KMS_CMA_HELPER option"). DRM_KMS_CMA_HELPER would select
> DRM_GEM_CMA_HELPER but that transitive dependency was lost and
> apparently the fixup was missed in that commit.
> 
> So we need a:
> 
> Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
> 
> and with that...
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Steve
> 
>> ---
>>   drivers/gpu/drm/arm/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
>> index 58a242871b28..6e3f1d600541 100644
>> --- a/drivers/gpu/drm/arm/Kconfig
>> +++ b/drivers/gpu/drm/arm/Kconfig
>> @@ -6,6 +6,7 @@ config DRM_HDLCD
>>   	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
>>   	depends on COMMON_CLK
>>   	select DRM_KMS_HELPER
>> +	select DRM_GEM_CMA_HELPER
>>   	help
>>   	  Choose this option if you have an ARM High Definition Colour LCD
>>   	  controller.
>>
> 
