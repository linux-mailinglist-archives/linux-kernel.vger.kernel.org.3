Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6581751B967
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbiEEHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiEEHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:49:41 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 00:46:02 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6C131D311
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651736761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhRL0x5JxNjh9559awUlQzavmJp0VQ+2PFdUhFoZcIo=;
        b=YE+E/wMfI2VAHzwS4wt9hBWFmSJMW6bOb5ymBor3H2Eh+YanaxSYowGJ86DyBQOJhbUGDJ
        s5WBtXI7TmrIkg4YHRS4Me57SqZW+zdzySknhArvP3TWC4PguZqXQQH63bekkxr+BcARWS
        CKWsRUbPYqCzAh0CZ7/v03NKWVbnqtc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-0JGUhcPYOGeqyfqyywo4kA-1; Thu, 05 May 2022 03:38:52 -0400
X-MC-Unique: 0JGUhcPYOGeqyfqyywo4kA-1
Received: by mail-wm1-f69.google.com with SMTP id o24-20020a05600c379800b003943412e81dso1418207wmr.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NhRL0x5JxNjh9559awUlQzavmJp0VQ+2PFdUhFoZcIo=;
        b=qyxLnIAB3MTsJQzhp8zKUeNVK6kAmD6ChZv7zM6oqywB0vLi/ElFdhoqXKG0vgwYtf
         uK8Aj2eQ+yAZlkFGCZgkF1d+Pf2Ak5agjHIA7hKGaYUw4T3XrK3al7z5J841mkCQMX+g
         N3koTyBh+gQcCgbEKq0tkiEIQV+lj+jmDC9ghDWpRmP+D4I/TnPaGXm4/dIo6hwUhSfY
         xdfVb1hUY1JlyJjLrpuxNsdSqccVBSk/zN6Qgs+GpSzaQvh0AqwRYwKzgkje2fA/2Qg+
         OM0eIG+9HFdvK1TrLDTib9Np5mbP/vngBpbRFOoG6sOqS4NbaZ5/XKHiROGyG0kp4qJN
         eIig==
X-Gm-Message-State: AOAM530YshU6Tj/63bjdx0L1RI0tJWDapPvODPlf5LH+RuPkP+qDbBfQ
        e5N+LyYDEZqbgdAK2DmKVA0M2ovak2JQxEe3/Ac2j4GG7IPP/pH6LpXyihz1TNLoLynlnlIVSjV
        mQ57K+o53BpGhWxvmZLcyIMRV
X-Received: by 2002:a5d:4585:0:b0:20a:da03:7131 with SMTP id p5-20020a5d4585000000b0020ada037131mr19047527wrq.693.1651736331459;
        Thu, 05 May 2022 00:38:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOiVrqfx6icK3c6hK4kQWSA8M7R4dWtYNn2w4VZryyBpTxL+R3XPp9/Z57KoRlU/8Sy+vNog==
X-Received: by 2002:a5d:4585:0:b0:20a:da03:7131 with SMTP id p5-20020a5d4585000000b0020ada037131mr19047508wrq.693.1651736331173;
        Thu, 05 May 2022 00:38:51 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x8-20020a7bc768000000b003942a244f2fsm5546131wmk.8.2022.05.05.00.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 00:38:50 -0700 (PDT)
Message-ID: <d9a5cb30-2d9b-50b5-d287-0ead0fe252f3@redhat.com>
Date:   Thu, 5 May 2022 09:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather
 than .remove
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <20220504215722.56970-1-javierm@redhat.com>
 <974f4d00-89bc-a2da-6d65-ca4207300794@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <974f4d00-89bc-a2da-6d65-ca4207300794@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/5/22 09:29, Thomas Zimmermann wrote:

[snip]

>>   static void simplefb_destroy(struct fb_info *info)
>>   {
>>   	struct simplefb_par *par = info->par;
>> @@ -94,6 +98,8 @@ static void simplefb_destroy(struct fb_info *info)
>>   	if (info->screen_base)
>>   		iounmap(info->screen_base);
>>   
>> +	framebuffer_release(info);
>> +
>>   	if (mem)
>>   		release_mem_region(mem->start, resource_size(mem));
> 
> The original problem with fbdev hot-unplug was that vmwgfx needed the 
> framebuffer region to be released. If we release it only after userspace 
> closed it's final file descriptor, vmwgfx could have already failed.
> 
> I still don't fully get why this code apparently works or at least 
> doesn't blow up occasionally. Any ideas?
>

I believe that vmwgfx doesn't fail to probe (or any other DRM driver)
only when there are not user-space processes with a fbdev node opened
since otherwise as you said the memory wouldn't be released yet.

unregister_framebuffer() is called from the driver's .remove handler
and that decrement the fb_info refcount, so if reaches zero it will
call to the fb fops .destroy() handler and release the I/O memory.

In other words, in most cases (i.e: only fbcon bound to the fbdev)
the driver's removal/ device unbind and the memory release will be
at the same time.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

