Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0255859A349
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354698AbiHSRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350894AbiHSRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C958C131A2A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660928494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hsc4yRhAhZ4DbPHQFkOZPha0cv9GZ3AkjwFlq+dmc4w=;
        b=QBoDO7sKvFahY+oIP7USeWCVRKtLoRIgVnsWontc7SOVl94zvo8MwY27OUFfERmyQljMPe
        lMTEds0jZglE43FylZwZxBVVmsLufK+mH/7lH7FotLy0JtOdmOZ3RUVDqzgCJh+u6B4ry7
        OmxmgMYJoZfdRc1sbZc2STbjel5sDmo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-vz29oyJdPXmtj3wY1RzSVw-1; Fri, 19 Aug 2022 13:01:31 -0400
X-MC-Unique: vz29oyJdPXmtj3wY1RzSVw-1
Received: by mail-qt1-f199.google.com with SMTP id fy12-20020a05622a5a0c00b00344569022f7so3822104qtb.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Hsc4yRhAhZ4DbPHQFkOZPha0cv9GZ3AkjwFlq+dmc4w=;
        b=aS6T02+qBWa9fLiDhtTwkOe6mWQrGYska9NNtFKE/YtcgPx+aHHFz/swfoxIEVYp+Z
         FgrLf7cCIX5sd3NUHgbW65KVM/I42Xl0HjCzBksIX4UQwNBiMDJRW5PxnKQZuF+sPfEh
         nmHew4JS16Z5iZ2cHFv7y2MfjPEX1Giw1Yrb4zg8PMJD1f31Bm9dFW/BpT7yXQpGRU9y
         hdVendvbaEo8sd1TiSPq1W5kqtbLtYw7GYf5zafMyiuJb9YgOZmF+1bLtQGk/pXaEvFO
         gnQd0Q0z9NLA1+Z2v75JaBTD5YE4KbPutdYhj0JlSxD1iZcbRuQjrvreoQJp0AvbraF5
         ugEQ==
X-Gm-Message-State: ACgBeo0Y6beQmqdknbsSajbuYTr+V4CeVc7hoKC4VYwN/IccqQDgprjM
        tlSJAC6o1VwEsM5u7XKQz5J5kdnqBNCBb5bIX293PORl0GjdCGn1uscI7qu761UwDUnQjnWHRcQ
        /Qs1yWYexwpvk+pU4pFq/ohv8YK3TkC7F6RmdPW1n
X-Received: by 2002:a05:6214:2588:b0:477:22bd:e1e6 with SMTP id fq8-20020a056214258800b0047722bde1e6mr6941503qvb.105.1660928490869;
        Fri, 19 Aug 2022 10:01:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5adLa5ufq8xv5MSitmP52SMGWicDFV/f3YeImHZmgqosweVM0PWafCWIvK9R7y6580EaMkBmHeuxCslplaa6M=
X-Received: by 2002:a05:6214:2588:b0:477:22bd:e1e6 with SMTP id
 fq8-20020a056214258800b0047722bde1e6mr6941464qvb.105.1660928490528; Fri, 19
 Aug 2022 10:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
 <87leror4sl.fsf@intel.com> <20220818115338.GA26586@wunner.de>
In-Reply-To: <20220818115338.GA26586@wunner.de>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Aug 2022 19:01:19 +0200
Message-ID: <CACO55ts1T9x++gjbvb-4gxOhLfKTeVVEjpm4L4uav-qRBsxmZg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        tvrtko.ursulin@linux.intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rodrigo.vivi@intel.com, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 2:09 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Aug 16, 2022 at 11:06:18AM +0300, Jani Nikula wrote:
> > On Tue, 16 Aug 2022, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > > dGFX so external monitors are routed to dGFX, and more monitors can be
> > > supported as result.
> > >
> > > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > > on intel_dsm_guid2. This method is described in Intel document 632107.
> >
> > Is this the policy decision that we want to unconditionally make,
> > though?
>
> In general, we handle switching of outputs between GPUs in vga_switcheroo.c
> upon a request from user space via sysfs (well, debugfs currently).
> It's up to users to decide which policy suits their needs best.
>
> That said, we never grew support to allow different switching policies for
> the built-in panel and external outputs.  Laptops supporting this are
> rare.  Older MacBook Pros introduced between 2008 and 2010 are among them:
> They have separate muxes for the panel and external DP port.  Our policy
> is documented in a code comment in drivers/platform/x86/apple-gmux.c:
>
>  * The external DP port is only fully switchable on the first two unibody
>  * MacBook Pro generations, MBP5 2008/09 and MBP6 2010. This is done by an
>  * `NXP CBTL06141`_ which is controlled by gmux.
>  [...]
>  * Our switching policy for the external port is that on those generations
>  * which are able to switch it fully, the port is switched together with the
>  * panel when IGD / DIS commands are issued to vga_switcheroo. It is thus
>  * possible to drive e.g. a beamer on battery power with the integrated GPU.
>  * The user may manually switch to the discrete GPU if more performance is
>  * needed.
>  *
>  * On all newer generations, the external port can only be driven by the
>  * discrete GPU. If a display is plugged in while the panel is switched to
>  * the integrated GPU, *both* GPUs will be in use for maximum performance.
>  * To decrease power consumption, the user may manually switch to the
>  * discrete GPU, thereby suspending the integrated GPU.
>
> In other words, on these older MacBook Pros, we switch the panel and
> external DP port in unison, thus always allowing one of the two GPUs
> to runtime suspend and save power.
>
> Thanks,
>
> Lukas
>

sure, but this is changing now. I do have a laptop with a muxable
internal display. But this is considered to be a dynamic on demand
switching thing not a boot time switch.

Anyway, I am still not convinced that doing that unconditionally is
what we want, especially as userspace has to support dynamic switching
regardless.

