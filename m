Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340AF4F4E76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384397AbiDFAUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572964AbiDERbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:31:33 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDD23156
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:29:34 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-de3ca1efbaso90989fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTmLNze/fum3lYDHZs7Sj1aLnDxMurPjlCcI6KAPtQw=;
        b=LbJpKtmNLFfmBBa8hI73mA0q3CBsHxWD5rGAH/a5zDNcSjWuPrutm69VA3/geneB9G
         pP2pvW/JddNsdNKYKSfjHiWncHsb3XxG9GZThdgfhubL/HZ4IB51n2b1YDm90xWG0GfZ
         Nqp2GVyKJQMxrGftECRmUpJYaBDF8o2XFRYtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTmLNze/fum3lYDHZs7Sj1aLnDxMurPjlCcI6KAPtQw=;
        b=jriFtN5MsbJWk0bwhmTphT4X7jwe+6i1Lre3/XHM76OS8uEc1PHm34uSQw2J5JL8OM
         vqebTZuYALCF9mmldkb1oTXn+27Jjh7GWXOBoonwxU4InVT6YxwgxmkXIUyTtgk42sV4
         o+fDMtXbdFJR5LNCJqzoJ8G0TGgxdJeDU6Mv1g3MwBVPjlD/gYn6Umt5CeKuFhI8Gpp5
         QPoGDNjcAluEzpb/vTKQV7LHXwljsOhx6HTJ+rZBQnTcBWkkEuCYWDCBAAYhfgPlZnmG
         cEUGruA/FZj9W6V7kU/PUF6gAjNjomAiJBAwdTN/QUX0TKSjQc617bw2L8dX1zVIjBLq
         JI6Q==
X-Gm-Message-State: AOAM530G0YTofAdpgySmQlYXnUvRa+KU4dK9rr5caO2HAc7/+3HMaW5w
        DIXE6TdPQ5TrQU5KH6fAv0x18iiiueF7DBAqGRlUYJH1b5UKmQ==
X-Google-Smtp-Source: ABdhPJz2hTIFazRR9MY8eLnHVlZ8caoGqxdFkjJVbRqRI2qhGE2WqsCDNkD6KwqVkoKmjggVmMcy5elsAsbz0Y7u4AU=
X-Received: by 2002:a05:6870:ec9e:b0:dd:e1fd:d76c with SMTP id
 eo30-20020a056870ec9e00b000dde1fdd76cmr2156223oab.7.1649179773446; Tue, 05
 Apr 2022 10:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
 <Ykv/k/WoVemoCJJA@phenom.ffwll.local> <YkwAhSt9HlbxcuZo@phenom.ffwll.local>
 <408ffe9b-f09f-dc7e-7f5e-a93b311a06fa@redhat.com> <CAKMK7uHf6H8mhSm6eDHUruWK5Xc2cSPkJUX6v-jpeQfjS19dKw@mail.gmail.com>
 <e124af06-4f24-277a-543a-82b383f48cea@redhat.com> <CAKMK7uH4GgDQJZguT-k0QmgEAHYHuDEbBtjYje51_Rtqzud0yw@mail.gmail.com>
 <CAMuHMdWr0L0r+MVU-=+_yeHKwK8BjF7_EJQxiJT5jMqS9FJUeQ@mail.gmail.com>
 <YkxFHUdm/YeiVY+D@kroah.com> <Ykxqi82sOEd2Zg1K@phenom.ffwll.local> <YkxyBt8Zee8qrEbT@kroah.com>
In-Reply-To: <YkxyBt8Zee8qrEbT@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 5 Apr 2022 19:29:22 +0200
Message-ID: <CAKMK7uEWMDZoB_OLLu7desVVPXEAgDiCEjVDJ3FrSeSTBoYtGQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 18:45, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 05, 2022 at 06:12:59PM +0200, Daniel Vetter wrote:
> > On Tue, Apr 05, 2022 at 03:33:17PM +0200, Greg KH wrote:
> > > On Tue, Apr 05, 2022 at 03:24:40PM +0200, Geert Uytterhoeven wrote:
> > > > Hi Daniel,
> > > >
> > > > On Tue, Apr 5, 2022 at 1:48 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > On Tue, 5 Apr 2022 at 11:52, Javier Martinez Canillas
> > > > > <javierm@redhat.com> wrote:
> > > > > > On 4/5/22 11:24, Daniel Vetter wrote:
> > > > > > > On Tue, 5 Apr 2022 at 11:19, Javier Martinez Canillas
> > > > > > >> This is how I think that work, please let me know if you see something
> > > > > > >> wrong in my logic:
> > > > > > >>
> > > > > > >> 1) A PCI device of OF device is registered for the GPU, this attempt to
> > > > > > >>    match a registered driver but no driver was registered that match yet.
> > > > > > >>
> > > > > > >> 2) The efifb driver is built-in, will be initialized according to the link
> > > > > > >>    order of the objects under drivers/video and the fbdev driver is registered.
> > > > > > >>
> > > > > > >>    There is no platform device or PCI/OF device registered that matches.
> > > > > > >>
> > > > > > >> 3) The DRM driver is built-in, will be initialized according to the link
> > > > > > >>    order of the objects under drivers/gpu and the DRM driver is registered.
> > > > > > >>
> > > > > > >>    This matches the device registered in (1) and the DRM driver probes.
> > > > > > >>
> > > > > > >> 4) The DRM driver .probe kicks out any conflicting DRM drivers and pdev
> > > > > > >>    before registering the DRM device.
> > > > > > >>
> > > > > > >>    There are no conflicting drivers or platform device at this point.
> > > > > > >>
> > > > > > >> 5) Latter at some point the drivers/firmware/sysfb.c init function is
> > > > > > >>    executed, and this registers a platform device for the generic fb.
> > > > > > >>
> > > > > > >>    This device matches the efifb driver registered in (2) and the fbdev
> > > > > > >>    driver probes.
> > > > > > >>
> > > > > > >>    Since that happens *after* the DRM driver already matched, probed
> > > > > > >>    and registered the DRM device, that is a bug and what the reverted
> > > > > > >>    patch worked around.
> > > > > > >>
> > > > > > >> So we need to prevent (5) if (1) and (3) already happened. Having a flag
> > > > > > >> set in the fbdev core somewhere when remove_conflicting_framebuffers()
> > > > > > >> is called could be a solution indeed.
> > > > > > >>
> > > > > > >> That is, the fbdev core needs to know that a DRM driver already probed
> > > > > > >> and make register_framebuffer() fail if info->flag & FBINFO_MISC_FIRMWARE
> > > > > > >>
> > > > > > >> I can attempt to write a patch for that.
> > > > > > >
> > > > > > > Ah yeah that could be an issue. I think the right fix is to replace
> > > > > > > the platform dev unregister with a sysfb_unregister() function in
> > > > > > > sysfb.c, which is synced with a common lock with the sysfb_init
> > > > > > > function and a small boolean. I think I can type that up quickly for
> > > > > > > v3.
> > > > > >
> > > > > > It's more complicated than that since sysfb is just *one* of the several
> > > > > > places where platform devices can be registered for video devices.
> > > > > >
> > > > > > For instance, the vga16fb driver registers its own platform device in
> > > > > > its module_init() function so that can also happen after the conflicting
> > > > > > framebuffers (and associated devices) were removed by a DRM driver probe.
> > > > > >
> > > > > > I tried to minimize the issue for that particular driver with commit:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0499f419b76f
> > > > > >
> > > > > > But the point stands, it all boils down to the fact that you have two
> > > > > > different subsystems registering video drivers and they don't know all
> > > > > > about each other to take a proper decision.
> > > > > >
> > > > > > Right now the drm_aperture_remove_conflicting_framebuffers() call signals
> > > > > > in one direction from DRM to fbdev but there isn't a communication in the
> > > > > > other direction, from fbdev to DRM.
> > > > > >
> > > > > > I believe the correct fix would be for the fbdev core to keep a list of
> > > > > > the apertures struct that are passed to remove_conflicting_framebuffers(),
> > > > > > that way it will know what apertures are not available anymore and prevent
> > > > > > to register any fbdev framebuffer that conflicts with one already present.
> > > > >
> > > > > Hm that still feels like reinventing a driver model, badly.
> > > > >
> > > > > I think there's two cleaner solutions:
> > > > > - move all the firmware driver platform_dev into sysfb.c, and then
> > > > > just bind the special cases against that (e.g. offb, vga16fb and all
> > > > > these). Then we'd have one sysfb_try_unregister(struct device *dev)
> > > > > interface that fbmem.c uses.
> > > > > - let fbmem.c call into each of these firmware device providers, which
> > > > > means some loops most likely (like we can't call into vga16fb), so
> > > > > probably need to move that into fbmem.c and it all gets a bit messy.
> > > > >
> > > > > > Let me know if you think that makes sense and I can attempt to write a fix.
> > > > >
> > > > > I still think unregistering the platform_dev properly makes the most
> > > >
> > > > That doesn't sound very driver-model-aware to me. The device is what
> > > > the driver binds to; it does not cease to exist.
> > >
> > > I agree, that sounds odd.
> > >
> > > The device should always stick around (as the bus creates it), it's up
> > > to the driver to bind to the device as needed.
> >
> > The device actually disappears when the real driver takes over.
> >
> > The firmware fb is a special thing which only really exists as long as the
> > firmware is in charge of the display hardware. As soon as a real driver
> > takes over, it stops being a thing.
> >
> > And since a driver without a device is a bit a funny thing, we have been
> > pushing towards a model where the firmware code sets up a platform_device
> > for this fw interface, and the fw driver (efifb, simplefb and others like
> > that) bind against it. And then we started to throw out that
> > platform_device (which unbinds the fw driver and prevents it from ever
> > rebinding), except in the wrong layer so there's a few races.
> >
> > Should we throw out all that code and replace it with something else? What
> > would that be like?
>
> Ah, no, sorry, I didn't know that at all.
>
> That sounds semi-sane, just fix the races by moving the layer elsewhere?

Yeah essentially move it all into drivers/firmware/sysfb.c, for all
drivers, both the registering and the nuking, and warp that into a
local mutex. Currently parts is in there, parts is in fbmem.c, parts
in some of the drivers like vga16fb, and some drivers (iirc only offb)
still don't even have any platform_dev underneath their driver. So
ideally the drivers would all just have their platform_driver probe
functions, and that's it. It does mean though that some of that stuff
needs to be moved to sysfb.c or into the relevant fw code that sets
stuff up.

It'll take some, so really just a direction check before we move
further. You should get cc'ed on the patches (like with the sysfb
stuff) anyway. Sounds roughly right?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
