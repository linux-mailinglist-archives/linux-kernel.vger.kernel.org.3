Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2584051455A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356519AbiD2J0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356518AbiD2J01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 135EFC4038
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651224189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZBpHvY6ZYQxOxDMB34W2/6DBju5lgDw8kQdarO8pfI=;
        b=MoYCcivrAL0WwnpkAgIkHZ9qEQMgKzTacnJbGsUOQ0M42spKasM9vbgfr8VE9axmMCaM+q
        DhOFzStOvwIG0uFsqtC2mqW0/RCC4FwMZyF8Tb8nB1eFVhSu3A2ibaHnw3u5iqA8795Z0P
        IqpQMx1LOrsLzeLnFK+Gfx9bmYUEPGI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-RnR_XYEIPY2uPTia8DoJnQ-1; Fri, 29 Apr 2022 05:23:07 -0400
X-MC-Unique: RnR_XYEIPY2uPTia8DoJnQ-1
Received: by mail-wr1-f72.google.com with SMTP id d28-20020adf9b9c000000b0020ad4a50e14so2853433wrc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iZBpHvY6ZYQxOxDMB34W2/6DBju5lgDw8kQdarO8pfI=;
        b=FsP35ZYjGJBdMZtDdkii8pEeMLc5QzlOC+ii4yvmRMnQtQqP5tlZZ6gXm/UFEhfq+y
         1/ZL96cqk4OTzlpkylCBji8nBROfxxvXmwGFuMBJLQPuuEOPRuGtyNBj9fGQqhnOgag6
         iGAEuyOcBDxIJKGWe5EkxNK+4olhgmynvtfnB9JaDYxyk3yhtlcEDwQc/FxzLS1+a7cO
         q5WhrNUjGsCEhXk4XA4HqH8PbfdQjEX69OIHUbyfG8C4K8JAl5tVNkjJHzXXXMO/41qO
         0es69d7pG1+GtptifFUB+6cdxp0PswuJegKZynuvYD/QsCvP5Z5t2aFb18+CBKI+rYeX
         Px1Q==
X-Gm-Message-State: AOAM532e9XAm6cCsG101NFjjMGiu4rL1SI2NphxlCJnrDjKklJ7Mbsw8
        g9O803pdSkJr63C/kdPkVg5BYuFZnhdS4NxEIkZ55D2XIPn3gbiKHJMoqfCQfoCgJZslAEnHqP1
        s3g15vdqx/QnP49GjRGH0uDXj
X-Received: by 2002:a5d:5284:0:b0:20a:d859:3d6a with SMTP id c4-20020a5d5284000000b0020ad8593d6amr21037364wrv.403.1651224186191;
        Fri, 29 Apr 2022 02:23:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzM9Kw7u0Y6NciFxMlSl1ar6JMt7qq9Xhix3AmpT6YAzzVEjfV07s1Es4bMZUziOtUFGATvQ==
X-Received: by 2002:a5d:5284:0:b0:20a:d859:3d6a with SMTP id c4-20020a5d5284000000b0020ad8593d6amr21037352wrv.403.1651224185968;
        Fri, 29 Apr 2022 02:23:05 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k23-20020adfb357000000b0020ad7c36332sm1918444wrd.110.2022.04.29.02.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:23:05 -0700 (PDT)
Message-ID: <476d57e5-69dd-94b5-779f-230e091ae62f@redhat.com>
Date:   Fri, 29 Apr 2022 11:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH v4 02/11] drm/fb-helper: Set FBINFO_MISC_FIRMWARE flag
 for DRIVER_FIRMWARE fb
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220429084253.1085911-1-javierm@redhat.com>
 <20220429084253.1085911-3-javierm@redhat.com>
 <7ce2f8e1-9cf2-4d89-99c2-b4280e4758ba@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <7ce2f8e1-9cf2-4d89-99c2-b4280e4758ba@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 4/29/22 11:14, Thomas Zimmermann wrote:
> Hi
> 
> Am 29.04.22 um 10:42 schrieb Javier Martinez Canillas:
>> The DRIVER_FIRMWARE flag denotes that a DRM driver uses a framebuffer
>> that was initialized and provided by the system firmware for scanout.
>>
>> Indicate to the fbdev subsystem that the registered framebuffer is a
>> FBINFO_MISC_FIRMWARE, so that it can handle accordingly. For example,
>> wold hot-unplug the associated device if asked to remove conflicting
>> framebuffers.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/gpu/drm/drm_fb_helper.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index d265a73313c9..76dd11888621 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -1891,6 +1891,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
>>   		/* don't leak any physical addresses to userspace */
>>   		info->flags |= FBINFO_HIDE_SMEM_START;
>>   
>> +	/* Indicate that the framebuffer is provided by the firmware */
>> +	if (drm_core_check_feature(dev, DRIVER_FIRMWARE))
>> +		info->flags |= FBINFO_MISC_FIRMWARE;
>> +
> 
> Patches 1 to 3 should be squashed into one before landing.
>

I actually considered this but then decided to go with the each change
goes into its own patch approach. But I'll squash it in next revisions.
 
> We can do this with DRIVER_FIRMWARE. Alternatively, I'd suggest to we 
> could also used the existing final parameter of 
> drm_fbdev_generic_setup() to pass a flag that designates a firmware device.
> 

By existing final parameter you mean @preferred_bpp ? That doesn't seem
correct. I also like that by using DRIVER_FIRMWARE it is completely data
driven and transparent to the DRM driver.

Or do you envision a case where a driver would be DRIVER_FIRMWARE but we
wouldn't want the emulated fbdev to also be FBINFO_MISC_FIRMWARE ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

