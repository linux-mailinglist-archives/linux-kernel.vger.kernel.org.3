Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC0B51BA65
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348839AbiEEIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348833AbiEEIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:32:20 -0400
X-Greylist: delayed 2986 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 01:28:41 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D44E36339
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651739320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYz81dg5bl4ZI+KnAy5BTdapmYRz85hkJ+vnJKUIBv8=;
        b=fivHICWK/gUz2f7XbdrMLu6felcT82wmih4yoJnr8JLM+iTsTxP3sNPdlipR3iZToSLIrf
        0Chz+b3V/unfMWWitCa4DYVr+nR9b59Kl90udUSXiKcN/u0D7e0RFs6gkVC0GzLhKXw3Yd
        tBQo3sdMK21716s+4qaDUeDhVyCRUQY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-gjwtx1l5NH6z_NURXktBAA-1; Thu, 05 May 2022 04:28:39 -0400
X-MC-Unique: gjwtx1l5NH6z_NURXktBAA-1
Received: by mail-wm1-f72.google.com with SMTP id r9-20020a1c4409000000b0039468585269so384924wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYz81dg5bl4ZI+KnAy5BTdapmYRz85hkJ+vnJKUIBv8=;
        b=3uHA6W349ndDTiIvGo6A1lU1c8tqWqkE0BSc+JvjViHzC/Ryh5dTuEY3TTvpSTjCF7
         1/VSG4Ho/W32IAeMyez81jFRHNF+bXC9l8w5P94CGTino1cfqGpGZkReDdFkVwFhdRll
         APHIOfrEmBt3sYBR2ecV3nXpVSNl6tPHKZv8DFbIct0M9/R/B4pLVzCuEnDzj9jP6gIB
         20rAJIOLY1+1adD6FRYaHyY3BH5cuxi6rce2BanTc0qT+GipeMmdbnxndBZhfDyOgo9y
         NKU0qpS0cFIHRsqsvIL30a4dytWen0iA9/oVQKv1c9fa9g290TyqT1DejA7FmOsOjFN0
         kLdA==
X-Gm-Message-State: AOAM531FLkQf3wZAcKI5z/kp6ZvdQToOvJJ56NPc6U+bBLzayIUo0wuI
        3jYGHH3NLVscbAaIgumT3rs5aSb4kfoJ85+cIeESsbjd2ftVGrWNDB0Uj+zYAGmX3brIYq6ifHh
        H5dLRX8GvdXDXDcZpGg8PcTCN
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr3533239wmp.22.1651739318024;
        Thu, 05 May 2022 01:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh1HtWVDlzxjatPu/Dr4igigwNhESv1m4aEdiiTXztX7nlntl2xMWkAVAnsZwrAbZbONwhTw==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr3533215wmp.22.1651739317617;
        Thu, 05 May 2022 01:28:37 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c21cc00b003942a244f42sm5800022wmj.27.2022.05.05.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:28:37 -0700 (PDT)
Message-ID: <237c7fa0-744d-97c2-2bba-3f714d6c2e9d@redhat.com>
Date:   Thu, 5 May 2022 10:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather
 than .remove
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <20220504215722.56970-1-javierm@redhat.com>
 <974f4d00-89bc-a2da-6d65-ca4207300794@suse.de>
 <d9a5cb30-2d9b-50b5-d287-0ead0fe252f3@redhat.com>
 <78167587-fd2e-354c-485b-db4ee9251178@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <78167587-fd2e-354c-485b-db4ee9251178@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/5/22 10:05, Thomas Zimmermann wrote:

[snip]

>>
>> In other words, in most cases (i.e: only fbcon bound to the fbdev)
>> the driver's removal/ device unbind and the memory release will be
>> at the same time.
>>
> 
> We're one the same page here, but it's still sort of a mystery to me why 
> this works in practice.
> 
> I'm specifically talking about pci_request_regions() in vmwgfx [1]. IIRC 
> this would fail if simplefb still owns the framebuffer region. Lots of 
> systems run Plymouth during boot and this should result in failures 
> occasionally. Still, we never heard about anything.
>

Yes, I think is because Plymouth IIUC waits for a /dev/dri/card? to be
present and only uses a /dev/fb? as a fallback if a timeout expires.

At least in Fedora (even before the efifb -> simpledrm change) it will
use KMS/DRM since the DRM kernel module for the graphics device in the
machine would be in the intird.

So efifb was only used for fbcon and plymouth would only use DRM/KMS
and not its fbdev backend.

This seems to be sort of a corner case when you have {efi,simple}fb
in the early boot but the real DRM module only in the rootfs after the
initrd has done a pivot_root(2).
 
> Of course, it's always been broken (even long before real fbdev 
> hotunplugging). Switching to simpledrm resolves the problem.
>

Indeed. My opinion after dealing with these fbdev problems is that we
shouldn't try to fix all possible corner cases and just try to get rid
of fbdev as soon as possible.
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

