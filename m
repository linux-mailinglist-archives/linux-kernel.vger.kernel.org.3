Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442704F4E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588994AbiDFASG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbiDEPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:09:24 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64ABF53A;
        Tue,  5 Apr 2022 06:24:55 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id o15so9548925qtv.8;
        Tue, 05 Apr 2022 06:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBCPhJo5YyS6XSPC6qSR2NczndtrlVmfcRjGORmxI/A=;
        b=EURQlCOo5uMFEGKK2235tNRMwsSYU4ycAr5/uhPDmTcoSJCkr8q77DmULI8+dVOW5U
         Fg7viLWjfIf1GxbKzHhSy8AKiAPf6VDLy1xXfw3rursUbek92oSIzViv4fPQjPHzdr7d
         jaUtdJqPR9E2OASW/5/NJDGSfve0eZuRloVN7orFTDRo9ZqZIjpgqoBV47kRr8XBlEF5
         DBSJvbtiC8QZHXkFkGkOa/+xzlHUsCCYAMQEfdB5PEsocbn0WFnpQAJyildu0Z9iCJf6
         dMcHtyWUSDyfvFf8JlKs0RIL3xmyQQMGaGgw2ge9PphTnIBJyHYGS2CYbimZOlSOFR7R
         w8Uw==
X-Gm-Message-State: AOAM532MwIr22564AApN9joJnKtRsUPWxOKaFbNhNz+kXkMnLLdHcwGf
        bb8LHeKzxXqDM3m0M8Xve7qgwnBIIFuSDg==
X-Google-Smtp-Source: ABdhPJxcBvIz7X+nnZAVOil6lfBgF9PLhnvtD+5MKWMfgMIX6lMCA+qxVOSaeGGfGYm7B+vKsP9Hgg==
X-Received: by 2002:a05:622a:120a:b0:2e1:c9ba:e99b with SMTP id y10-20020a05622a120a00b002e1c9bae99bmr2867850qtx.685.1649165092828;
        Tue, 05 Apr 2022 06:24:52 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id a129-20020a376687000000b0067d186d953bsm7960042qkc.121.2022.04.05.06.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:24:52 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2eb888cf7e7so47571727b3.13;
        Tue, 05 Apr 2022 06:24:52 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr2679880ywb.132.1649165091759; Tue, 05
 Apr 2022 06:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-19-daniel.vetter@ffwll.ch> <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
 <Ykv/k/WoVemoCJJA@phenom.ffwll.local> <YkwAhSt9HlbxcuZo@phenom.ffwll.local>
 <408ffe9b-f09f-dc7e-7f5e-a93b311a06fa@redhat.com> <CAKMK7uHf6H8mhSm6eDHUruWK5Xc2cSPkJUX6v-jpeQfjS19dKw@mail.gmail.com>
 <e124af06-4f24-277a-543a-82b383f48cea@redhat.com> <CAKMK7uH4GgDQJZguT-k0QmgEAHYHuDEbBtjYje51_Rtqzud0yw@mail.gmail.com>
In-Reply-To: <CAKMK7uH4GgDQJZguT-k0QmgEAHYHuDEbBtjYje51_Rtqzud0yw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Apr 2022 15:24:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWr0L0r+MVU-=+_yeHKwK8BjF7_EJQxiJT5jMqS9FJUeQ@mail.gmail.com>
Message-ID: <CAMuHMdWr0L0r+MVU-=+_yeHKwK8BjF7_EJQxiJT5jMqS9FJUeQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Apr 5, 2022 at 1:48 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, 5 Apr 2022 at 11:52, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> > On 4/5/22 11:24, Daniel Vetter wrote:
> > > On Tue, 5 Apr 2022 at 11:19, Javier Martinez Canillas
> > >> This is how I think that work, please let me know if you see something
> > >> wrong in my logic:
> > >>
> > >> 1) A PCI device of OF device is registered for the GPU, this attempt to
> > >>    match a registered driver but no driver was registered that match yet.
> > >>
> > >> 2) The efifb driver is built-in, will be initialized according to the link
> > >>    order of the objects under drivers/video and the fbdev driver is registered.
> > >>
> > >>    There is no platform device or PCI/OF device registered that matches.
> > >>
> > >> 3) The DRM driver is built-in, will be initialized according to the link
> > >>    order of the objects under drivers/gpu and the DRM driver is registered.
> > >>
> > >>    This matches the device registered in (1) and the DRM driver probes.
> > >>
> > >> 4) The DRM driver .probe kicks out any conflicting DRM drivers and pdev
> > >>    before registering the DRM device.
> > >>
> > >>    There are no conflicting drivers or platform device at this point.
> > >>
> > >> 5) Latter at some point the drivers/firmware/sysfb.c init function is
> > >>    executed, and this registers a platform device for the generic fb.
> > >>
> > >>    This device matches the efifb driver registered in (2) and the fbdev
> > >>    driver probes.
> > >>
> > >>    Since that happens *after* the DRM driver already matched, probed
> > >>    and registered the DRM device, that is a bug and what the reverted
> > >>    patch worked around.
> > >>
> > >> So we need to prevent (5) if (1) and (3) already happened. Having a flag
> > >> set in the fbdev core somewhere when remove_conflicting_framebuffers()
> > >> is called could be a solution indeed.
> > >>
> > >> That is, the fbdev core needs to know that a DRM driver already probed
> > >> and make register_framebuffer() fail if info->flag & FBINFO_MISC_FIRMWARE
> > >>
> > >> I can attempt to write a patch for that.
> > >
> > > Ah yeah that could be an issue. I think the right fix is to replace
> > > the platform dev unregister with a sysfb_unregister() function in
> > > sysfb.c, which is synced with a common lock with the sysfb_init
> > > function and a small boolean. I think I can type that up quickly for
> > > v3.
> >
> > It's more complicated than that since sysfb is just *one* of the several
> > places where platform devices can be registered for video devices.
> >
> > For instance, the vga16fb driver registers its own platform device in
> > its module_init() function so that can also happen after the conflicting
> > framebuffers (and associated devices) were removed by a DRM driver probe.
> >
> > I tried to minimize the issue for that particular driver with commit:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0499f419b76f
> >
> > But the point stands, it all boils down to the fact that you have two
> > different subsystems registering video drivers and they don't know all
> > about each other to take a proper decision.
> >
> > Right now the drm_aperture_remove_conflicting_framebuffers() call signals
> > in one direction from DRM to fbdev but there isn't a communication in the
> > other direction, from fbdev to DRM.
> >
> > I believe the correct fix would be for the fbdev core to keep a list of
> > the apertures struct that are passed to remove_conflicting_framebuffers(),
> > that way it will know what apertures are not available anymore and prevent
> > to register any fbdev framebuffer that conflicts with one already present.
>
> Hm that still feels like reinventing a driver model, badly.
>
> I think there's two cleaner solutions:
> - move all the firmware driver platform_dev into sysfb.c, and then
> just bind the special cases against that (e.g. offb, vga16fb and all
> these). Then we'd have one sysfb_try_unregister(struct device *dev)
> interface that fbmem.c uses.
> - let fbmem.c call into each of these firmware device providers, which
> means some loops most likely (like we can't call into vga16fb), so
> probably need to move that into fbmem.c and it all gets a bit messy.
>
> > Let me know if you think that makes sense and I can attempt to write a fix.
>
> I still think unregistering the platform_dev properly makes the most

That doesn't sound very driver-model-aware to me. The device is what
the driver binds to; it does not cease to exist.

> sense, and feels like the most proper linux device model solution
> instead of hacks on top - if the firmware fb is unuseable because a
> native driver has taken over, we should nuke that. And also the
> firmware fb driver would then just bind to that platform_dev if it
> exists, and only if it exists. Also I think it should be the
> responsibility of whichever piece of code that registers these
> platform devices to ensure that platform_dev actually still exists.
> That's why I think pushing all that code into sysfb.c is probably the
> cleanest solution.

Can't you unbind the generic driver first, and bind the specific driver
afterwards? Alike writing to sysfs unbind/driver_override/bind,
but from code?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
