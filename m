Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F74BB864
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiBRLkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:40:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiBRLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:40:28 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BE3101F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:39:59 -0800 (PST)
Date:   Fri, 18 Feb 2022 11:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1645184396;
        bh=SoHk44i+hSrhGCWSov+A62f5mQ4gQxdPxK6xjt+fVz8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ChUDHjrsfiukE7xWvak5fl+9SyIK7pibGyeOyRknvdnWxOVzG99VSWcQsJSiPUt6f
         9grvADHYFpp6DuC3gpQxTA69WdKAKyR7Mo/nwEB5QUyrC/dx+/CtDZF2YWNhQPW2Tl
         6+PnGc7RYTUjB1yibcvsbposFqs/0AkGQWJQfO//UxykAiqHXBvIPFzDz0UEkfa/fp
         MPDl3GjdqU9eTZAdYmjZdoFqdVxzIO9C1MOXcv02MRUgupJ5WQim3ZWvjshZxNREVr
         Dea5zfYRhicyLTflwxZeX0A1AFnYhkSLuejA6v53Ic38Uw3A/A2lg1P0Tvxx56g9q5
         bAYyZ4KyBzgvQ==
To:     Hans de Goede <hdegoede@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [Intel-gfx] [PATCH v8 1/3] gpu: drm: separate panel orientation property creating and value setting
Message-ID: <YV87l-2XXzmZ2i6GuGd__uf85s2JQkbXt_qTQDYlbBh1kW2COJoNLUDinmLCokKyy-_0ZnIMUcZeW0GdJ8zF690iYi4ThKrjc09omNMe-0g=@emersion.fr>
In-Reply-To: <d3f0cc20-d226-ee42-cc98-b469949cec9e@redhat.com>
References: <20220208084234.1684930-1-hsinyi@chromium.org> <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com> <KW6DNh6IRRgVJx9DfOFBnEqc4a0x-AnDXEbMxwpfEbk8dOn_KGVzAfo-slJWq-4nWW728Uc-OVpFh2w4fDE4-bxfkDuz1hFILRVvbcuXqaw=@emersion.fr> <CACvgo532-pC+7DLFCo=DWTX-OnJEJvSoTmQnt3_qLhiT4cqEMg@mail.gmail.com> <GYG6EVT1MqtmfKiPpMhDG9mpuATnmwVDq2PuE_dpDat5oQW_t1tUfm39lSWHj32D5r7mrog27sL4dkgdMYQ5BN830TfVOrgQ4Ts8LcO8Hcs=@emersion.fr> <CACvgo52+o9_ETC+1RKzqKkyw3ZJ28RjH0BqC9DfmNAKqByud8Q@mail.gmail.com> <d3f0cc20-d226-ee42-cc98-b469949cec9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 18th, 2022 at 11:38, Hans de Goede <hdegoede@redhat.com=
> wrote:

> What I'm reading in the above is that it is being considered to allow
> changing the panel-orientation value after the connector has been made
> available to userspace; and let userspace know about this through a ueven=
t.
>
> I believe that this is a bad idea, it is important to keep in mind here
> what userspace (e.g. plymouth) uses this prorty for. This property is
> used to rotate the image being rendered / shown on the framebuffer to
> adjust for the panel orientation.
>
> So now lets assume we apply the correct upside-down orientation later
> on a device with an upside-down mounted LCD panel. Then on boot the
> following could happen:
>
> 1. amdgpu exports a connector for the LCD panel to userspace without
> setting panel-orient=3Dupside-down
> 2. plymouth sees this and renders its splash normally, but since the
> panel is upside-down it will now actually show upside-down

At this point amdgpu hasn't probed the connector yet. So the connector
will be marked as disconnected, and plymouth shouldn't render anything.

> 3. amdgpu adjusts the panel-orient prop to upside-down, sends out
> uevents

That's when amdgpu marks the connector as connected. So everything
should be fine I believe, no bad frame.

> 4. Lets assume plymouth handles this well (i) and now adjust its
> rendering and renders the next frame of the bootsplash 180=C2=B0 rotated
> to compensate for the panel being upside down. Then from now on
> the user will see the splash normally
>
> So this means that the user will briefly see the bootsplash rendered
> upside down which IMHO is not acceptable behavior. Also see my footnote
> about how I seriously doubt plymouth will see the panel-orient change
> at all.
>
> I'm also a bit unsure about:
>
> a) How you can register the panel connector with userspace before
> reading the edid, don't you need the edid to give the physical size +
> modeline to userspace, which you cannot just leave out ?

Yup. The KMS EDID property is created before the EDID is read, and is set
to zero (NULL blob). The width/height in mm and other info are also zero.
You can try inspecting the state printed by drm_info on any disconnected
connector to see for yourself.

> I guess the initial modeline is inherited from the video-bios, but
> what about the physical size? Note that you cannot just change the
> physical size later either, that gets used to determine the hidpi
> scaling factor in the bootsplash, and changing that after the initial
> bootsplash dislay will also look ugly
>
> b) Why you need the edid for the panel-orientation property at all,
> typically the edid prom is part of the panel and the panel does not
> know that it is mounted e.g. upside down at all, that is a property
> of the system as a whole not of the panel as a standalone unit so
> in my experience getting panel-orient info is something which comes
> from the firmware /video-bios not from edid ?

This is an internal DRM thing. The orientation quirks logic uses the
mode size advertised by the EDID. I agree that at least in the Steam
Deck case it may not make a lot of sense to use any info from the
EDID, but that's needed for the current status quo.

Also note, DisplayID has a bit to indicate the panel orientation IIRC.
Would be nice to support parsing this at some point.
