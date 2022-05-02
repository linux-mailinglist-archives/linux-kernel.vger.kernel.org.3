Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3B517578
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386543AbiEBRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386521AbiEBRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9E8B5FE6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651511361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOc6bJLdhzaHvygq2HwvrbnheC0kFV7hKHsyBw5EeLA=;
        b=ZGn1dRozBNCxlTNUHfrJ+7j+4xLsQd068MsY3iR5h5Adkd5z6xNBQebGiGe+XNtZFJArmF
        hI19c6YFBKYDTOYGfu5YnOMtLYp9jQSeT/mZT3XbSPlKRH/rXqhB+3N+pEtNTkw2zloMgA
        1W3CAArGG5P84WjzZ6gULteg9Dvr1JU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-A_NknHkYMyShPXFte67m7g-1; Mon, 02 May 2022 13:09:20 -0400
X-MC-Unique: A_NknHkYMyShPXFte67m7g-1
Received: by mail-wr1-f72.google.com with SMTP id w4-20020adfbac4000000b0020acba4b779so5526694wrg.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mOc6bJLdhzaHvygq2HwvrbnheC0kFV7hKHsyBw5EeLA=;
        b=XEGLOMMhamF4LqkiOv2XLupVj5mhmkrOFZ0PXF4c+dCJywMtMN/U9Tynd5xEuvHdtk
         GlD879d9gV4vQjmFNswSCvkrm1EJxrHEobUhIM0Vi+JiBEJqAZKA2CYTeVHVOph343zV
         CArR+fiO87Wo5qyDuW91DDGMnz38PwKFqvHblrKGq1jNWBf1WnHkoPRu7FQ0W0/VbgPe
         x7EXAYy7FojU/aEcGdh+xFJgVpvT4hRgal47YqUgNcBEPEWWcEmadqrSrmutuxp10z7s
         wgZjxTnmkv6IixQUrxciCW6Wf3rmkqXuanZ+3hZPPLntF2znv0uaJJen+/5T0cFBnMMq
         6Lvg==
X-Gm-Message-State: AOAM5302CcUsQcI+4KkbyiHHwHGQr3yyBVDI6CSL/+jkULLogzS1B1K6
        FwOeZWRVxTiDgktrkpokZWQKrVjfnjKTwhEjJXRKneTPdH0eicWn+7OT4JP/+zW8QC1XqywyrNb
        8votzu6nS6MQsymnIQZDX67Z4
X-Received: by 2002:a05:600c:3b1b:b0:394:33f2:62ef with SMTP id m27-20020a05600c3b1b00b0039433f262efmr81449wms.69.1651511359571;
        Mon, 02 May 2022 10:09:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD8kvUwaOP/LYdIp3y9tWwzlSjcjMNajFy22460RiURhJLGu+0f+kRklg0gioUgoCGg53/sQ==
X-Received: by 2002:a05:600c:3b1b:b0:394:33f2:62ef with SMTP id m27-20020a05600c3b1b00b0039433f262efmr81438wms.69.1651511359318;
        Mon, 02 May 2022 10:09:19 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003942a244edcsm6713522wma.33.2022.05.02.10.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:09:18 -0700 (PDT)
Message-ID: <9556f080-d309-f396-6d28-1190bc94cc38@redhat.com>
Date:   Mon, 2 May 2022 19:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-4-javierm@redhat.com>
 <YnAEDlikr+d8cvy4@pendragon.ideasonboard.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnAEDlikr+d8cvy4@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On 5/2/22 18:17, Laurent Pinchart wrote:
> Hi Javier,
> 
> Thank you for the patch.
> 
> On Mon, May 02, 2022 at 05:39:00PM +0200, Javier Martinez Canillas wrote:
>> Indicate to fbdev subsystem that the registered framebuffer is provided by
>> the system firmware, so that it can handle accordingly. For example, would
>> unregister the FB devices if asked to remove the conflicting framebuffers.
>>
>> Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
>> Drivers can use this to indicate the FB helper initialization that the FB
>> registered is provided by the firmware, so it can be configured as such.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/gpu/drm/drm_fb_helper.c  |  9 +++++++++
>>  drivers/gpu/drm/tiny/simpledrm.c |  2 +-
>>  include/drm/drm_fb_helper.h      | 10 ++++++++++
>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index fd0084ad77c3..775e47c5de1f 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -1891,6 +1891,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
>>  		/* don't leak any physical addresses to userspace */
>>  		info->flags |= FBINFO_HIDE_SMEM_START;
>>  
>> +	/* Indicate that the framebuffer is provided by the firmware */
>> +	if (fb_helper->firmware)
>> +		info->flags |= FBINFO_MISC_FIRMWARE;
>> +
>>  	/* Need to drop locks to avoid recursive deadlock in
>>  	 * register_framebuffer. This is ok because the only thing left to do is
>>  	 * register the fbdev emulation instance in kernel_fb_helper_list. */
>> @@ -2512,6 +2516,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
>>   *
>>   * * DRM_FB_BPP: bits per pixel for the device. If the field is not set,
>>   *   @dev->mode_config.preferred_depth is used instead.
>> + * * DRM_FB_FW: if the framebuffer for the device is provided by the
>> + *   system firmware.
>>   *
>>   * This function sets up generic fbdev emulation for drivers that supports
>>   * dumb buffers with a virtual address and that can be mmap'ed.
>> @@ -2538,6 +2544,7 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
>>  {
>>  	struct drm_fb_helper *fb_helper;
>>  	unsigned int preferred_bpp = DRM_FB_GET_OPTION(DRM_FB_BPP, options);
>> +	bool firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);
>>  	int ret;
>>  
>>  	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
>> @@ -2570,6 +2577,8 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
>>  		preferred_bpp = 32;
>>  	fb_helper->preferred_bpp = preferred_bpp;
>>  
>> +	fb_helper->firmware = firmware;
> 
> I'd get rid of the local variable and write
>

I actually considered that but then decided to add a local variable to
have both options set in the same place, since I thought that would be
easier to read and also consistent with how preferred_bpp is handled.

Maybe I could go the other way around and rework patch 2/3 to also not
require a preferred_bpp local variable ? That patch won't be as small
as it's now though. -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

