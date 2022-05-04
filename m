Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD45199B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbiEDIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiEDIaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA94D7652
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651652796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+C/4yoNKEEGV6PoJ/pGUW0PpRiFTb33UcshUyLm1xTM=;
        b=TgDsyBK15+09B2YWVs6XdzSS9RFJhvNTUb2EEtdNW/iJP8nt1eQ11QNn+xSnbQnDZsGX4N
        N47209sMFs5EwjkTttWtb23IDVbWed+i7HqrwRPulMEe4WkW2F/ECPPe5Fw+qH2kCByXAg
        n+xuoDZGMP91VZ1ADTJwiYJPppD2si8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-c3vjZPF8Osi7i8plm3djlg-1; Wed, 04 May 2022 04:26:32 -0400
X-MC-Unique: c3vjZPF8Osi7i8plm3djlg-1
Received: by mail-wr1-f71.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso131985wrd.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+C/4yoNKEEGV6PoJ/pGUW0PpRiFTb33UcshUyLm1xTM=;
        b=wzl53qf4xAmCZOyWcCF8Ew5S2vI8Gim19cWtgsAmKGtpXbAJ+AoPuhwh4XM1eYFdDs
         KzRdZeyKaOww3b1HyI/hpxak9FCUXTV7sGpronieiicFenAZWklRTQwFug+hF8Fly1F5
         2o08bUZp+kIkDIX01K4FTCV61520W9Hb1GCggbxZQ6cqSHbSVG+7TSqTSO5zmyL5YP+B
         tH4DHfyYQ/wZG8SCNY3AKLb8+olJwpq9kvG5TcaTR+RAUQmb/hh/VlwLeV4yDWkZl5OB
         ItSkhOdqXBM4kh4Fenv4hfZpsNFS27E92SfEptd690wJQFAooJ9KkzyKZ5wDSl927CYG
         s7qQ==
X-Gm-Message-State: AOAM533qGu+CxUazbV8LoXhHkIu0NOrgpnPxKajaK5u5JBnO6kQN7uZu
        SaPmfoj5vYSnpTih0u0lvdbmRYPhHqPTPw5ChOFFdj2OLslKqEze8Hh74FWg5Q9XsZKvabYobEN
        BVdAVpicZmSeQoXttoRHoOraL
X-Received: by 2002:a1c:2942:0:b0:392:3aff:4fcd with SMTP id p63-20020a1c2942000000b003923aff4fcdmr6702214wmp.0.1651652791571;
        Wed, 04 May 2022 01:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwf5liG5UOSbg9cbpMtmv/D9VHVe+DIqeuq8o0WbDy3DvVW1qvmg350Q24IdSh6Jmk4iyNgg==
X-Received: by 2002:a1c:2942:0:b0:392:3aff:4fcd with SMTP id p63-20020a1c2942000000b003923aff4fcdmr6702197wmp.0.1651652791294;
        Wed, 04 May 2022 01:26:31 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id be13-20020a05600c1e8d00b003942a244ee6sm3856611wmb.43.2022.05.04.01.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 01:26:30 -0700 (PDT)
Message-ID: <3f8f697f-7b85-cb8c-445a-8d7c40a062f8@redhat.com>
Date:   Wed, 4 May 2022 10:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] fbdev: Use helper to get fb_info in all file
 operations
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <maxime@cerno.tech>,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220503201934.681276-1-javierm@redhat.com>
 <d0555181-6e36-044c-b747-c08dbeb3a89e@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d0555181-6e36-044c-b747-c08dbeb3a89e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/4/22 10:15, Thomas Zimmermann wrote:
> Hi
> 
> Am 03.05.22 um 22:19 schrieb Javier Martinez Canillas:
>> A reference to the framebuffer device struct fb_info is stored in the file
>> private data, but this reference could no longer be valid and must not be
>> accessed directly. Instead, the file_fb_info() accessor function must be
>> used since it does sanity checking to make sure that the fb_info is valid.
>>
>> This can happen for example if the registered framebuffer device is for a
>> driver that just uses a framebuffer provided by the system firmware. In
>> that case, the fbdev core would unregister the framebuffer device when a
>> real video driver is probed and ask to remove conflicting framebuffers.
>>
>> Most fbdev file operations already use the helper to get the fb_info but
>> get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.
>>
>> Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
>> exported. Rename it and add a fb_ prefix to denote that is public now.
>>
>> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks.
 
> Please see my comment below.

[snip]

>>   
>> +	if (!info)
>> +		return -ENODEV;
>> +
> 
> This is consistent with other functions, but it's probably not the 
> correct errno code. It means that a device is not available for opening.
> 
> But the situation here is rather as with close() on a 
> disconnected-network file. The call to close() returns EIO in this case. 
> Maybe we should consider changing this in a separate patch.
>

Indeed. Agree that -EIO makes more sense here.
 
> Best regards
> Thomas
> 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

