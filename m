Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F04AE5D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiBIATf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiBIATc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FEE4C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644365970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YfCnyxSCyr5vTP3YrAazeA9ULAGVzys2UZvocNOmGA=;
        b=Ts/dEPbO4woQGpfsghSDXDVZZcF6vJYScE/pVW/51pxVWgkGludc3wgQWCim0q/6VARIWO
        //IsO0R22hcVMmGJGw6bOrtlvUM8FOQzmwFq6C4vBVrrkJ2RJUZbD1KdvXAig1aum1Fs68
        AM0FISoNSkHLVZYrMzzRTmDy32FLsoQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-F14GMPfyNCeYq927upUyKg-1; Tue, 08 Feb 2022 19:19:29 -0500
X-MC-Unique: F14GMPfyNCeYq927upUyKg-1
Received: by mail-wm1-f69.google.com with SMTP id m20-20020a05600c3b1400b003539593ea39so43536wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 16:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+YfCnyxSCyr5vTP3YrAazeA9ULAGVzys2UZvocNOmGA=;
        b=yaiH2TZzOuEaULBoDoSFZXjaPc2UXem+iF1E2JOQT9y6Z06t8YOL50G+RTrGUWncS2
         pbV7qQtqynmT/uGPsW+U3rI4i8zvFYOsVCKOQ8pOQ+8wUAFsOv0wGDDJKsQoYx7DJfUm
         7Qrt79HgWCY/bdx9ZXcmZkClKcHgoRucZKt3hq7uTSQjpY5aB8i2OYP2qJfutTS+wzCR
         8fOI3pMpOEfs78Vix1Ej/uM/eVJdwJ8NOL2/lXlIMEsX4s53BHgxsXgbEJ5F8+VwYg+Q
         y17owQYu/xEUzNnw+GLpxIaTPxjlNMmjFgfylQKevRDStakVDanek2TtlhF/EuzEfTsY
         194w==
X-Gm-Message-State: AOAM532BwLPUohQKn7i3Rq1OTnUsoBOlG3AM+MYvxOQuOWjm4DRhX20W
        MraSTqe2yl4TVri2Qg/clSHrC1bkcnZlsOFMB+FwFn0F9QbftFcZkOIdHWokprIB1cw/t4dczoU
        Cg9CZr/k0BSuFsYUli2Bh55mE
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr272607wrz.468.1644365968097;
        Tue, 08 Feb 2022 16:19:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwA2Lg39k9Sbo0xLJ5uWj2LvpSd71eFqK97Wop1ro0TUcBQLjaot/weyoE5zyFF03j8y59UbA==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr272596wrz.468.1644365967877;
        Tue, 08 Feb 2022 16:19:27 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n26sm3877837wms.13.2022.02.08.16.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 16:19:27 -0800 (PST)
Message-ID: <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
Date:   Wed, 9 Feb 2022 01:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-19-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220208210824.2238981-19-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 22:08, Daniel Vetter wrote:
> This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.
> 
> With
> 
> commit 27599aacbaefcbf2af7b06b0029459bbf682000d
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Date:   Tue Jan 25 10:12:18 2022 +0100
> 
>     fbdev: Hot-unplug firmware fb devices on forced removal
> 
> this should be fixed properly and we can remove this somewhat hackish
> check here (e.g. this won't catch drm drivers if fbdev emulation isn't
> enabled).
>

Unfortunately this hack can't be reverted yet. Thomas' patch solves the issue
of platform devices matched with fbdev drivers to be properly unregistered if
a DRM driver attempts to remove all the conflicting framebuffers.

But the problem that fb561bf9abde ("fbdev: Prevent probing generic drivers if
a FB is already registered") worked around is different. It happens when the
DRM driver is probed before the {efi,simple}fb and other fbdev drivers, the
kicking out of conflicting framebuffers already happened and these drivers
will be allowed to probe even when a DRM driver is already present.

We need a clearer way to prevent it, but can't revert fb561bf9abde until that.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

