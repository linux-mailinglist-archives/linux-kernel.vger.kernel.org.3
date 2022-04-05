Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949EA4F418B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347770AbiDEOgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiDEJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:35:21 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABA88B27
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:24:13 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-df22f50e0cso13785054fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lxRDcdRQ5w1Q2jCVMX+xvmqdaWkgW8uu97T4fHS8x4=;
        b=E7utYSEQMMriUu3qMfwO6HZ+45PXmrgq9OM+1s//K6zpWGIFlVpV9kYS7Tmb7YhWlD
         NkBhw6QH+PA6UFcYFNsQg+mT3l+j/b3yiMV0z5OgJqRnaezfoO6hggNnTdTjEqHTI0zV
         2wAOmzOy1RGhDB2wL/45uzYgskBCHCu8iM08c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lxRDcdRQ5w1Q2jCVMX+xvmqdaWkgW8uu97T4fHS8x4=;
        b=W313WGgMHesyXX2zRaa1FBp5pohdc0eBNcctyIKBeONwep+uN69NXiRsPjZdUvmrhw
         F6ZcI7lDl5pxit8X35qoPo1Ls0bPMFqrnclKmbAT9bANCi36Cjxd2rJmLj3CRHlfz+Fs
         5oCZp6GCq1pUupa3dUX4GP1jMDBntQLHgFnGFsS0+4cQUkClUFjxGHrNtBNA05GeNg57
         weJntVWuzzf0SFfXntxpUJhXrBaNxAh7xhu1s0LELVctDoepAqfKeqQIUw3zFTIdGz/y
         t+0xzBIlUeC0fjSkCbjnT7wlx0znDjh7SRQJREcrfxRfqhwV+BPxfFoEsx+HWZEE81lM
         qjmQ==
X-Gm-Message-State: AOAM531JWrfMCpFhdri0ECiwq/RGxyAf6EAAHxvGKBgqXWXgJ1WPWMjI
        gqRK/4nYCWTLZmfSoc5/K2t5Ycdi5jYm3/h7jRfGPw==
X-Google-Smtp-Source: ABdhPJyzL3zZzTHLZEn2qSsiB+5Zic+Cf7QVJB23RMBqDKq8SPt6RfSyxRU86S94alZw81SeHDZ6ususLht4Jn/mafs=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr1132529oap.228.1649150653253; Tue, 05
 Apr 2022 02:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-19-daniel.vetter@ffwll.ch> <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
 <Ykv/k/WoVemoCJJA@phenom.ffwll.local> <YkwAhSt9HlbxcuZo@phenom.ffwll.local> <408ffe9b-f09f-dc7e-7f5e-a93b311a06fa@redhat.com>
In-Reply-To: <408ffe9b-f09f-dc7e-7f5e-a93b311a06fa@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 5 Apr 2022 11:24:01 +0200
Message-ID: <CAKMK7uHf6H8mhSm6eDHUruWK5Xc2cSPkJUX6v-jpeQfjS19dKw@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
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

On Tue, 5 Apr 2022 at 11:19, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Daniel,
>
> On 4/5/22 10:40, Daniel Vetter wrote:
> > On Tue, Apr 05, 2022 at 10:36:35AM +0200, Daniel Vetter wrote:
> >> On Wed, Feb 09, 2022 at 01:19:26AM +0100, Javier Martinez Canillas wrote:
> >>> On 2/8/22 22:08, Daniel Vetter wrote:
> >>>> This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.
> >>>>
> >>>> With
> >>>>
> >>>> commit 27599aacbaefcbf2af7b06b0029459bbf682000d
> >>>> Author: Thomas Zimmermann <tzimmermann@suse.de>
> >>>> Date:   Tue Jan 25 10:12:18 2022 +0100
> >>>>
> >>>>     fbdev: Hot-unplug firmware fb devices on forced removal
> >>>>
> >>>> this should be fixed properly and we can remove this somewhat hackish
> >>>> check here (e.g. this won't catch drm drivers if fbdev emulation isn't
> >>>> enabled).
> >>>>
> >>>
> >>> Unfortunately this hack can't be reverted yet. Thomas' patch solves the issue
> >>> of platform devices matched with fbdev drivers to be properly unregistered if
> >>> a DRM driver attempts to remove all the conflicting framebuffers.
> >>>
> >>> But the problem that fb561bf9abde ("fbdev: Prevent probing generic drivers if
> >>> a FB is already registered") worked around is different. It happens when the
> >>> DRM driver is probed before the {efi,simple}fb and other fbdev drivers, the
> >>> kicking out of conflicting framebuffers already happened and these drivers
> >>> will be allowed to probe even when a DRM driver is already present.
> >>>
> >>> We need a clearer way to prevent it, but can't revert fb561bf9abde until that.
> >>
> >> Yeah that entire area is a mess still, ideally we'd have something else
> >> creating the platform devices, and efifb/offb and all these would just
> >> bind against them.
> >>
> >> Hm one idea that just crossed my mind: Could we have a flag in fb_info for
> >> fw drivers, and check this in framebuffer_register? Then at least all the
> >> logic would be in the fbdev core.
> >
>
> I can't answer right away since I've since forgotten this part of the code
> and will require to do a detailed read to refresh my memory.
>
> I'll answer later but preferred to mention the other question ASAP.
>
> > Ok coffee just kicked in, how exactly does your scenario work?
> >
> > This code I'm reverting here is in the platform_dev->probe function.
> > Thomas' patch removes the platform_dev. How exactly can you still probe
> > against a platform dev if that platform dev is gone?
> >
>
> Because the platform was not even registered by the time the DRM driver
> probed and all the devices for the conflicting drivers were unregistered.
>
> > Iow, now that I reponder your case after a few weeks I'm no longer sure
> > things work like you claim.
> >
>
> This is how I think that work, please let me know if you see something
> wrong in my logic:
>
> 1) A PCI device of OF device is registered for the GPU, this attempt to
>    match a registered driver but no driver was registered that match yet.
>
> 2) The efifb driver is built-in, will be initialized according to the link
>    order of the objects under drivers/video and the fbdev driver is registered.
>
>    There is no platform device or PCI/OF device registered that matches.
>
> 3) The DRM driver is built-in, will be initialized according to the link
>    order of the objects under drivers/gpu and the DRM driver is registered.
>
>    This matches the device registered in (1) and the DRM driver probes.
>
> 4) The DRM driver .probe kicks out any conflicting DRM drivers and pdev
>    before registering the DRM device.
>
>    There are no conflicting drivers or platform device at this point.
>
> 5) Latter at some point the drivers/firmware/sysfb.c init function is
>    executed, and this registers a platform device for the generic fb.
>
>    This device matches the efifb driver registered in (2) and the fbdev
>    driver probes.
>
>    Since that happens *after* the DRM driver already matched, probed
>    and registered the DRM device, that is a bug and what the reverted
>    patch worked around.
>
> So we need to prevent (5) if (1) and (3) already happened. Having a flag
> set in the fbdev core somewhere when remove_conflicting_framebuffers()
> is called could be a solution indeed.
>
> That is, the fbdev core needs to know that a DRM driver already probed
> and make register_framebuffer() fail if info->flag & FBINFO_MISC_FIRMWARE
>
> I can attempt to write a patch for that.

Ah yeah that could be an issue. I think the right fix is to replace
the platform dev unregister with a sysfb_unregister() function in
sysfb.c, which is synced with a common lock with the sysfb_init
function and a small boolean. I think I can type that up quickly for
v3.
-Daniel

>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
