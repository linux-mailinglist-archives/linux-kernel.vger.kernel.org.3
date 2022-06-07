Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108445422D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387523AbiFHApb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452815AbiFGXOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A5D310EA51
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654635722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmWx/HtcjqYi7JTMOK9VA2Mvf2gZ14LWzJ8rqY3sV7Y=;
        b=cVCGFu1KO3xFXjvbm+LEp8rE33mnFpHVVs8RV3Zp98FiLDD0n+pTOX6WdhIsk+Ic9dF0eR
        Dozg79zKJcqyxJkFKCwrls1DjLwWcbo2sfV2atnKtt3bO3QYidTWWEyJVoyxL4EoVVRano
        XssJQQe8U7e7FJWyH8HJnZRGyPg/V+A=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-bkyCK4D8PxCXloTZQJCCRQ-1; Tue, 07 Jun 2022 17:01:54 -0400
X-MC-Unique: bkyCK4D8PxCXloTZQJCCRQ-1
Received: by mail-il1-f197.google.com with SMTP id i16-20020a056e021d1000b002d3bbe39232so14508688ila.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DmWx/HtcjqYi7JTMOK9VA2Mvf2gZ14LWzJ8rqY3sV7Y=;
        b=5r+Uht7mxw88e+i/Ol9yX6YLbWsLusNr1DG2SUfsT2VIWmQlLhHGOQn9/NQ+9ct/6a
         4Xpc5y+Trr7+2zqLjW7jSKd/kJCsvwjlGBbnp2MpN5BthYDJBNuZWhy29GF5rJHTz8Ks
         N9mpeHRfaL6HUGn2SVFnA0Mpy6/FjCiSQ9VUYchQP9d+M/gJ1AsTG4xRd3F0W9sC5XhX
         /CEGlqXz4TP9JhOyJiRGTAFKDMp26xJHGknANLzFvzj4Yd/vTfb87sIHieZccOEi/plm
         wgEhfZG2p4+EOHDpCmVsjjaIBGvxO0DRY1+YqDBJFvul3POR8cl9oRR35BBk9sSiNx4O
         R3Xw==
X-Gm-Message-State: AOAM533NJ3T0nwzc1ORdX5DPrGzeeEyCMn9rH8BRM4lwNPvsTILhBHI4
        613o6tV9iK2Zax0UbFrJOuDwjN6FI81/rCz8bx8HTKoA20NugOEbHopvp2CU02uXziiTZ9sHash
        hSfNyIT4+EYf1c6EYWkiGcWib
X-Received: by 2002:a05:6638:2404:b0:331:48f:bac0 with SMTP id z4-20020a056638240400b00331048fbac0mr15750898jat.306.1654635713365;
        Tue, 07 Jun 2022 14:01:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz8j3m6BGhMI89N/Xkj0XEQSk7cnDz7RN7p+Q2qYByc9Z8m7/k4hnjD+DhU7yc8TOyDhvgxg==
X-Received: by 2002:a05:6638:2404:b0:331:48f:bac0 with SMTP id z4-20020a056638240400b00331048fbac0mr15750891jat.306.1654635713144;
        Tue, 07 Jun 2022 14:01:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b38-20020a0295a9000000b0032e271a558csm7025990jai.168.2022.06.07.14.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:01:52 -0700 (PDT)
Date:   Tue, 7 Jun 2022 15:01:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        kvm@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Improve vfio-pci primary GPU assignment behavior
Message-ID: <20220607150151.11c7d2f6.alex.williamson@redhat.com>
In-Reply-To: <badc8e91-f843-2c96-9c02-4fbb59accdc4@redhat.com>
References: <165453797543.3592816.6381793341352595461.stgit@omen>
        <badc8e91-f843-2c96-9c02-4fbb59accdc4@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 19:40:40 +0200
Javier Martinez Canillas <javierm@redhat.com> wrote:

> Hello Alex,
> 
> On 6/6/22 19:53, Alex Williamson wrote:
> > Users attempting to enable vfio PCI device assignment with a GPU will
> > often block the default PCI driver from the device to avoid conflicts
> > with the device initialization or release path.  This means that
> > vfio-pci is sometimes the first PCI driver to bind to the device.  In 
> > the case of assigning the primary graphics device, low-level console
> > drivers may still generate resource conflicts.  Users often employ
> > kernel command line arguments to disable conflicting drivers or
> > perform unbinding in userspace to avoid this, but the actual solution
> > is often distribution/kernel config specific based on the included
> > drivers.
> > 
> > We can instead allow vfio-pci to copy the behavior of
> > drm_aperture_remove_conflicting_pci_framebuffers() in order to remove
> > these low-level drivers with conflicting resources.  vfio-pci is not
> > however a DRM driver, nor does vfio-pci depend on DRM config options,
> > thus we split out and export the necessary DRM apterture support and
> > mirror the framebuffer and VGA support.
> > 
> > I'd be happy to pull this series in through the vfio branch if
> > approved by the DRM maintainers.  Thanks,
> >  
> 
> I understand your issue but I really don't think that using this helper
> is the correct thing to do. We already have some races with the current
> aperture infrastructure As an example you can look at [0].
> 
> The agreement on the mentioned thread is that we want to unify the fbdev
> and DRM drivers apertures into a single list, and ideally moving all to
> the Linux device model to handle the removal of conflicting devices.
> 
> That's why I don't feel that leaking the DRM aperture helper to another
> is desirable since it would make even harder to cleanup this later.

OTOH, this doesn't really make the problem worse and it identifies
another stakeholder to a full solution.
 
> But also, this issue isn't something that only affects graphic devices,
> right? AFAIU from [1] and [2], the same issue happens if a PCI device
> has to be bound to vfio-pci but already was bound to a host driver.

When we're shuffling between PCI drivers, we expect the unbind of the
previous driver to have released all the claimed resources.  If there
were a previously attached PCI graphics driver, then the code added in
patch 2/ is simply redundant since that PCI graphics driver must have
already performed similar actions.  The primary use case of this series
is where there is no previous PCI graphics driver and we have no
visibility to platform drivers carving chunks of the PCI resources into
different subsystems.  AFAIK, this is unique to graphics devices.

> The fact that DRM happens to have some infrastructure to remove devices
> that conflict with an aperture is just a coincidence. Since this is used
> to remove devices bound to drivers that make use of the firmware-provided
> system framebuffer.

It seems not so much a coincidence as an artifact of the exact problem
both PCI graphics drivers and now vfio-pci face.  We've created
platform devices to manage sub-ranges of resources, where the actual
parent of those resources is only discovered later and we don't
automatically resolve the resource conflict between that parent device
and these platform devices when binding the parent driver.
 
> The series [0] mentioned above, adds a sysfb_disable() that disables the
> Generic System Framebuffer logic that is what registers the framebuffer
> devices that are bound to these generic video drivers. On disable, the
> devices registered by sysfb are also unregistered.
> 
> Would be enough for your use case to use that helper function if it lands
> or do you really need to look at the apertures? That is, do you want to
> remove the {vesa,efi,simple}fb and simpledrm drivers or is there a need
> to also remove real fbdev and DRM drivers?

It's not clear to me how this helps.  I infer that sysfb_disable() is
intended to be used by, for example, a PCI console driver which would be
taking over the console and can therefore make a clear decision to end
sysfb support.  The vfio-pci driver is not a console driver so we can't
make any sort of blind assertion regarding sysfb.  We might be binding
to a secondary graphics card which has no sysfb drivers attached.  I'm
a lot more comfortable wielding an interface that intends to disable
drivers/devices relative to the resources of a given device rather than
a blanket means to disable a subsystem.

I wonder if the race issues aren't better solved by avoiding to create
platform devices exposing resource conflicts with known devices,
especially when those existing devices have drivers attached.  Thanks,

Alex

