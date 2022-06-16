Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71254EA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378437AbiFPTzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378250AbiFPTzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A03E546B0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655409337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ys2keuyjGOnYxAsZaMh0khOvW2SYs1SLvLOIoAesU54=;
        b=QPXrXy59CdnLK6BWUx0REgMLEVs/UqsAnze/pjnVy/GeMWWRK9U3nGkSRa1hREcdIYcwux
        UAH5yBUz9LGGuljJTgxeoFsIg/O0pDbq4L6sExZzpFhvZYkUTLuScHy8ti8TzI8sjgxPUW
        5LUqSPynYjCQdnt2pS0aIU/RXL0DGXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-UfauTu3bNUavHFULq72eSw-1; Thu, 16 Jun 2022 15:55:28 -0400
X-MC-Unique: UfauTu3bNUavHFULq72eSw-1
Received: by mail-wm1-f70.google.com with SMTP id l17-20020a05600c4f1100b0039c860db521so1318229wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ys2keuyjGOnYxAsZaMh0khOvW2SYs1SLvLOIoAesU54=;
        b=1QRM5/6QVWUa99eLi7ud/rsxklqR1iTm+Uz7lyLsbCZqVuCUm88kySJTNGepDJirNh
         +hQp/OoW083F7qYctgcL0S9Nh+YAQ9eGcndslGzZTToR1IdY4rcBihnX7PPmTcpAeZwn
         5vVM0cKGh1t2o6XL48d56eKFoNw3doj5E3UE3svx2MoGlsXv4QqWIsgSkrB34zqkXW5F
         ipmLdWS4C0i4ZLUeMxoIW0hK8gOOR+AdeJ5sFSC6Jj8RKPrZnO8MsPspd/IZsD0ErOUD
         vO04vv+hYsTvLGa36nSJBfK9phq1a5lMnFqABV9AP/4UvibhT50RdoCygLYoCN1Ep8RM
         xrDw==
X-Gm-Message-State: AOAM5300PxaTl3czGA/0BC6RrJJ7RuSV+AKP9nkuH/sao/8iAilCLhLH
        0A1sssyd+P+W1F0ZTddHdXm8PLw+9W8T6VM3oPEJqW+IxsNJ1QPzekfJYuo8Pm24A59uZYJ+gFW
        cujrDLxfaFNgkt33NKcJY2cba
X-Received: by 2002:a05:600c:294a:b0:39c:4df5:f825 with SMTP id n10-20020a05600c294a00b0039c4df5f825mr17322082wmd.55.1655409326636;
        Thu, 16 Jun 2022 12:55:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR8ZU9QDRz515iHBXgPuPCog+HviQMDV3yKwqceawwks+wUtwyLzvQ0pWFkTp40mYRTIYHHg==
X-Received: by 2002:a05:600c:294a:b0:39c:4df5:f825 with SMTP id n10-20020a05600c294a00b0039c4df5f825mr17322057wmd.55.1655409326396;
        Thu, 16 Jun 2022 12:55:26 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d6351000000b0020fee88d0f2sm3262351wrw.0.2022.06.16.12.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 12:55:25 -0700 (PDT)
Message-ID: <38473dcd-0666-67b9-28bd-afa2d0ce434a@redhat.com>
Date:   Thu, 16 Jun 2022 21:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 3/5] fbdev: Disable sysfb device registration when
 removing conflicting FBs
Content-Language: en-US
To:     Zack Rusin <zackr@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "lersek@redhat.com" <lersek@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "deller@gmx.de" <deller@gmx.de>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
References: <20220607182338.344270-1-javierm@redhat.com>
 <20220607182338.344270-4-javierm@redhat.com>
 <de83ae8cb6de7ee7c88aa2121513e91bb0a74608.camel@vmware.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <de83ae8cb6de7ee7c88aa2121513e91bb0a74608.camel@vmware.com>
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

Hello Zack,

On 6/16/22 21:29, Zack Rusin wrote:
> On Tue, 2022-06-07 at 20:23 +0200, Javier Martinez Canillas wrote:
>> The platform devices registered by sysfb match with firmware-based DRM or
>> fbdev drivers, that are used to have early graphics using a framebuffer
>> provided by the system firmware.
>>

[snip]

> 
> Hi, Javier.
> 
> This change broke arm64 with vmwgfx. We get a kernel oops at boot (let me know if
> you'd like .config or just have us test something directly for you):
>

Yes please share your .config and I'll try to reproduce on an arm64 machine.

> 
>  Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000008
>  Mem abort info:
>    ESR = 0x96000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004
>    CM = 0, WnR = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=00000001787ee000
>  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 96000004 [#1] SMP
>  Modules linked in: vmwgfx(+) e1000e(+) nvme ahci(+) xhci_pci drm_ttm_helper ttm
> sha256_arm64 sha1_ce nvme_core xhci_pci_renesas aes_neon_bs aes_neon_blk aes>
>  CPU: 3 PID: 215 Comm: systemd-udevd Tainted: G     U            5.18.0-rc5-vmwgfx
> #12

I'm confused, your kernel version seems to be 5.18.0-rc5 but this patch
is only in drm-misc-next now and will land in 5.20...

Did you backport it? Can you please try to reproduce with latest drm-tip ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

