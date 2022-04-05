Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193FD4F4EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836127AbiDFAfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357922AbiDEPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C6DD16B15B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649165150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVwNzNitG33HKNZ/ddogzhAKEzWphu605lg3oK1brLg=;
        b=hMf5rBNxfkMM2V8frQoa1xQ8stqOCpjX7Nhjn/HWhQpP39KXUcegOzd0COkdGLEUibLiAw
        yKggbuHrgRVdvhGLrEp0CxBsjdkyDawFuCaCZsx3nzVBZSyoxeTnmvYXnhuziI8HS1/Fp2
        NPGdOxRULn2Ge6P6vvi0cf6MdLJ/y5Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-rn-Am5DtMuOZoRgnZETPfQ-1; Tue, 05 Apr 2022 09:25:49 -0400
X-MC-Unique: rn-Am5DtMuOZoRgnZETPfQ-1
Received: by mail-wm1-f72.google.com with SMTP id x8-20020a7bc768000000b0038e73173886so1248185wmk.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AVwNzNitG33HKNZ/ddogzhAKEzWphu605lg3oK1brLg=;
        b=qJ+fcSLJCUJ0lZWq5+W8/jK1xxJDGrv4r9HPn/vGn2cZn5W2RyfDZg5qKoqDZnHz7Z
         TrMcH243RT3+7ofZPOC2ZEobmYIyBcg8ft7UCNLaxqInp0nGkM0oFdILjrFx5TGQ6l9F
         EF11nhKMOTbQ9a9mwYnDiCQprK8vYcG7oRKpApOmC+5hTfYZ27RDNInmteBXDXbywkvP
         zD1U7IMjMsu9Q4nWN/5HvbmpgwR7JxABK5jQ4BfKk/pgjTr3eJzed2TQPaJPAU4l3kYD
         93+TG28EXlKHKcy5ybF9mgIhVXm6xBNozvSiQCQJX7NETe6U9aAqte+Sdkz7+2dCsN3I
         goeg==
X-Gm-Message-State: AOAM532fB+vJB05a62xGjaVnI+CiGtRlDkxkdIbboKJyRxKTzIMVjxiX
        8ET/mK8u0dHK1kyfn0f8QkxNAlLAghd3/xq6QayJYizLTb04vW1muYUIE/G0hECmu1itKEki1fa
        Om6QFIaDuOwm1h2qo2AKJbzBi
X-Received: by 2002:adf:a394:0:b0:206:1cfd:13f6 with SMTP id l20-20020adfa394000000b002061cfd13f6mr2933797wrb.604.1649165148406;
        Tue, 05 Apr 2022 06:25:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywL4YFUMFLKEGNJyDnDhZAXs0fvhVQ+PmfmqjWs4+T5znYDxv/BEV3ZRmK9KLv1H6lO/13xA==
X-Received: by 2002:adf:a394:0:b0:206:1cfd:13f6 with SMTP id l20-20020adfa394000000b002061cfd13f6mr2933768wrb.604.1649165148093;
        Tue, 05 Apr 2022 06:25:48 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm2294778wmq.41.2022.04.05.06.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:25:47 -0700 (PDT)
Message-ID: <54f4cb72-1640-939d-0b7b-9a1b989cd5eb@redhat.com>
Date:   Tue, 5 Apr 2022 15:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-19-daniel.vetter@ffwll.ch>
 <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
 <Ykv/k/WoVemoCJJA@phenom.ffwll.local> <YkwAhSt9HlbxcuZo@phenom.ffwll.local>
 <408ffe9b-f09f-dc7e-7f5e-a93b311a06fa@redhat.com>
 <CAKMK7uHf6H8mhSm6eDHUruWK5Xc2cSPkJUX6v-jpeQfjS19dKw@mail.gmail.com>
 <e124af06-4f24-277a-543a-82b383f48cea@redhat.com>
 <CAKMK7uH4GgDQJZguT-k0QmgEAHYHuDEbBtjYje51_Rtqzud0yw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAKMK7uH4GgDQJZguT-k0QmgEAHYHuDEbBtjYje51_Rtqzud0yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 12:34, Daniel Vetter wrote:
> On Tue, 5 Apr 2022 at 11:52, Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[snip]

>>
>> I believe the correct fix would be for the fbdev core to keep a list of
>> the apertures struct that are passed to remove_conflicting_framebuffers(),
>> that way it will know what apertures are not available anymore and prevent
>> to register any fbdev framebuffer that conflicts with one already present.
> 
> Hm that still feels like reinventing a driver model, badly.
>

Yeah, you are correct.
 
> I think there's two cleaner solutions:
> - move all the firmware driver platform_dev into sysfb.c, and then
> just bind the special cases against that (e.g. offb, vga16fb and all
> these). Then we'd have one sysfb_try_unregister(struct device *dev)
> interface that fbmem.c uses.

I think this is the cleaner option. And makes sense to consolidate all
the firmware drivers platform device registration to sysfb.c.

Already does for VIDEO_TYPE_EFI ("efi-framebuffer") and VIDEO_TYPE_VLFB
("vesa-framebuffer"), so need to also make it cope with VIDEO_TYPE_EGAC
and VIDEO_TYPE_VGAC ("vga16fb").

For offb is less clear since currently the offb driver does not really
use the Linux device model, that is the driver does not match a device
that's registered, there's no device which is the bug that was reported
to Thomas in the other thread.

It's unclear how to properly fix that since we will need to convert the
offb driver to register a platform driver and match against a device that
is registered by some platform code that parses the OF...

> - let fbmem.c call into each of these firmware device providers, which
> means some loops most likely (like we can't call into vga16fb), so
> probably need to move that into fbmem.c and it all gets a bit messy.
> 

Yup, that would get messy indeed so not a good option.

>> Let me know if you think that makes sense and I can attempt to write a fix.
> 
> I still think unregistering the platform_dev properly makes the most
> sense, and feels like the most proper linux device model solution
> instead of hacks on top - if the firmware fb is unuseable because a
> native driver has taken over, we should nuke that. And also the
> firmware fb driver would then just bind to that platform_dev if it
> exists, and only if it exists. Also I think it should be the
> responsibility of whichever piece of code that registers these
> platform devices to ensure that platform_dev actually still exists.
> That's why I think pushing all that code into sysfb.c is probably the
> cleanest solution.
>

Agreed. Not registering the platform devices if there is already a DRM
driver for the same device is what makes the most sense. What I don't
understand is how sysfb would know that if run after a DRM registration.

The only way that could know is if sysfb would keep a list of apertures
for all the DRM drivers registered or if the DRM core somewhat notifies
to sysfb that a native driver was already registered.

Another option and probably the cleanest although the harder solution is
to finally bite the bullet and make all the DRM drivers to request their
memory region.

Or as you mentioned in the past, to move that logic into the device model
and then not allow to register devices that require an overlapping region.

And there could be a request_mem_region_remove_conflicting() or something
that real DRM drivers could use to force a memory region request and make
the device model to unregister any device that may already have that mem.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

