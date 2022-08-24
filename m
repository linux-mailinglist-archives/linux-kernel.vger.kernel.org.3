Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65159FD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiHXOW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiHXOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:22:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDF248FB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:22:25 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2DDA23F5E4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661350944;
        bh=J9dYKqPrhoe4u3rJH7QvuZNoAukmPv3+OODJJ1NRe+k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Fs+GjcOzhivMHLl1lPmJK4H5A2DGWLQc1suzITOOE//odmU73iA3ORqk7oUBOz9VM
         Wk2VxUYKKCJWpMYI6G/qE9RLM5IzcKMBN0cka2YZ1ydANTyhK7q3KHf/fZhAh3yV9e
         aCWHpo0reswyb0w+rDPdWNfeGivuBgR8eeKYaq0jIQsfH21jV+Xc1w301i+1oFzpo/
         LuhnmAMomcmi3l28SyfhbwUvou5rrMG/fcbQQk9hXYpG70wVAmSE1D3Un5kU6bhVm4
         K5xYd4q1kz80GyV3JUGVn2icjtLm3vlLfTCQT0vKoXuAkPk3J9IVGhMQWyhRBhx3hi
         VIKd3HMSYah2g==
Received: by mail-ot1-f70.google.com with SMTP id m15-20020a0568301e6f00b0063729bd5c3eso5906475otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=J9dYKqPrhoe4u3rJH7QvuZNoAukmPv3+OODJJ1NRe+k=;
        b=1gS+cjqHe+nBYCi0A3R4cRNLaDZFw0nfLuSfbb9yJfT2FgcVKfSyaz1gw8Dh3WIm3Q
         gXzMDZBeJesUaTKv/H553CEAiVIkurtQKQytyA32g683Bz96I7BIc4hZpvCPgCRTyDGF
         A/PzRYGg8zZENi0Z1KzOrJaTZUgOvkRD5yYlIHEDqSIWM5vpGapkVLHaUaCmgej5BKhD
         GQ0puUTq9jTmngRAYC+t+D7g9kUmTCQg+N1m0hDYz30AamOBZN68QlbNI6liustmkgZ8
         3REhFlmgrUa1FK9J5MC8vD7Qrhm3YsyofT21r5GexJRV4+aK4bW953SWanQOpV8K0+RF
         1VNA==
X-Gm-Message-State: ACgBeo2n71Iy9EAgjThoSIaIwjBqDbEejTURJ3KgPhokekri8kzU6/OO
        zu80Qz5ux2UGaFqe5Toyjgua3h2aWJ4qcp8vcUTmcdx5BhOVUWFQp0gDEc/dhFYMiFagyHMjU52
        PRolvD9bnyFYNg3B0Qr7DZbuBHmpBZKYC0Jyfjn/KKT7kT/Os+GHYbXecMg==
X-Received: by 2002:a05:6830:56:b0:639:bbb:f0cf with SMTP id d22-20020a056830005600b006390bbbf0cfmr8559393otp.161.1661350942892;
        Wed, 24 Aug 2022 07:22:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR63V8+8gFNrI7lVEFSJFV+xfOibANKda1JA+arSTbap2BtebjqmboH3jp1HI70ac7UiZj5OusMbJeeSZ333niQ=
X-Received: by 2002:a05:6830:56:b0:639:bbb:f0cf with SMTP id
 d22-20020a056830005600b006390bbbf0cfmr8559382otp.161.1661350942625; Wed, 24
 Aug 2022 07:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
 <87leror4sl.fsf@intel.com> <20220818115338.GA26586@wunner.de> <CACO55ts1T9x++gjbvb-4gxOhLfKTeVVEjpm4L4uav-qRBsxmZg@mail.gmail.com>
In-Reply-To: <CACO55ts1T9x++gjbvb-4gxOhLfKTeVVEjpm4L4uav-qRBsxmZg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 24 Aug 2022 22:22:10 +0800
Message-ID: <CAAd53p676POJxo4SGQwLWYVUwhqm3MB98zZkm9enh+uwQEu++g@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        tvrtko.ursulin@linux.intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>, rodrigo.vivi@intel.com,
        Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 1:01 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Thu, Aug 18, 2022 at 2:09 PM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Tue, Aug 16, 2022 at 11:06:18AM +0300, Jani Nikula wrote:
> > > On Tue, 16 Aug 2022, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > > > dGFX so external monitors are routed to dGFX, and more monitors can be
> > > > supported as result.
> > > >
> > > > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > > > on intel_dsm_guid2. This method is described in Intel document 632107.
> > >
> > > Is this the policy decision that we want to unconditionally make,
> > > though?
> >
> > In general, we handle switching of outputs between GPUs in vga_switcheroo.c
> > upon a request from user space via sysfs (well, debugfs currently).
> > It's up to users to decide which policy suits their needs best.
> >
> > That said, we never grew support to allow different switching policies for
> > the built-in panel and external outputs.  Laptops supporting this are
> > rare.  Older MacBook Pros introduced between 2008 and 2010 are among them:
> > They have separate muxes for the panel and external DP port.  Our policy
> > is documented in a code comment in drivers/platform/x86/apple-gmux.c:
> >
> >  * The external DP port is only fully switchable on the first two unibody
> >  * MacBook Pro generations, MBP5 2008/09 and MBP6 2010. This is done by an
> >  * `NXP CBTL06141`_ which is controlled by gmux.
> >  [...]
> >  * Our switching policy for the external port is that on those generations
> >  * which are able to switch it fully, the port is switched together with the
> >  * panel when IGD / DIS commands are issued to vga_switcheroo. It is thus
> >  * possible to drive e.g. a beamer on battery power with the integrated GPU.
> >  * The user may manually switch to the discrete GPU if more performance is
> >  * needed.
> >  *
> >  * On all newer generations, the external port can only be driven by the
> >  * discrete GPU. If a display is plugged in while the panel is switched to
> >  * the integrated GPU, *both* GPUs will be in use for maximum performance.
> >  * To decrease power consumption, the user may manually switch to the
> >  * discrete GPU, thereby suspending the integrated GPU.
> >
> > In other words, on these older MacBook Pros, we switch the panel and
> > external DP port in unison, thus always allowing one of the two GPUs
> > to runtime suspend and save power.
> >
> > Thanks,
> >
> > Lukas
> >
>
> sure, but this is changing now. I do have a laptop with a muxable
> internal display. But this is considered to be a dynamic on demand
> switching thing not a boot time switch.
>
> Anyway, I am still not convinced that doing that unconditionally is
> what we want, especially as userspace has to support dynamic switching
> regardless.
>

According to the doc, there's no MUX in TGL-H DP-IN. The dGPU outputs
are routed through TGL-H TCSS directly.
That's probably the reason why it can't be dynamic.

Kai-Heng
