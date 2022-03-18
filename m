Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D264A4DD635
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiCRIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiCRIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:31:44 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058727CE0E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:30:24 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id v20so2686887uat.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ogp3OEFkwZj8QEMXIkrMCD+Y2owy7GvkEn/U8LOX0o=;
        b=Pf+BOEhya9aXXbYBUeUOBRRU7JhM5PstNvwRvh4CwFFLDHwwrqRxswcdt7fceLlQ9h
         SbVt99hG/N/i2Yg1eI/N/pWGYA9GiLlX6qOIAZDvSYRQRWu4G4Uag0C3btZqkT4cjcZV
         PKWRNnFOICcYpYs0aSRQn9QSo4YoxNA0h7fi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ogp3OEFkwZj8QEMXIkrMCD+Y2owy7GvkEn/U8LOX0o=;
        b=4huRNitQCN/Dbp/pte0biPIZXUR1l5oyJwyOQcxTRwgv+1JPA3z5JxWBr6fKD89Dk3
         qWrQt4QwrYEtxa+tC9kDqWV45ywNb0gFcnNb4nHQJMne7ZkXvsa7Uu98+S4Zy82wceui
         TjuO1DRCnroM/nVpkLVXOPawx6fUGIglgIkYMpZHyVL1+ZM+idTjkglHSF2oKeVHYni/
         O1r1xnuRvhPVGZaNW6ftORIqf5FEQ5nQGY2/jmM8gyJMDX+ObzpdXzJWbcxrhKBVWYnQ
         DCUFwc2tUpzIRZLAW/Q4E5t00NR1WNvEuTRTCpTwxAHmelkz6E+exTF94VOUwAlQ/KsQ
         udyA==
X-Gm-Message-State: AOAM5327zNjr44N7DQuuKx9ZWhLpcIUzpszfzRhq04aNV9lmvrTv3a0Y
        7sziTYfh7aqPvj1ggEho6f5pzLg/jDygOftKUTp7zz7oWomYmA==
X-Google-Smtp-Source: ABdhPJz/KhorT3W/2hHA0L0YLN68M/lGOSgV2CAcFuel9OThQYS6ptUz2+hFO2ZOAyCDuApFRoXn3SWHOfIQdBeL9ps=
X-Received: by 2002:ab0:2619:0:b0:354:ccac:32f with SMTP id
 c25-20020ab02619000000b00354ccac032fmr578951uao.46.1647592223830; Fri, 18 Mar
 2022 01:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220208084234.1684930-1-hsinyi@chromium.org> <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com>
 <KW6DNh6IRRgVJx9DfOFBnEqc4a0x-AnDXEbMxwpfEbk8dOn_KGVzAfo-slJWq-4nWW728Uc-OVpFh2w4fDE4-bxfkDuz1hFILRVvbcuXqaw=@emersion.fr>
 <CACvgo532-pC+7DLFCo=DWTX-OnJEJvSoTmQnt3_qLhiT4cqEMg@mail.gmail.com>
 <GYG6EVT1MqtmfKiPpMhDG9mpuATnmwVDq2PuE_dpDat5oQW_t1tUfm39lSWHj32D5r7mrog27sL4dkgdMYQ5BN830TfVOrgQ4Ts8LcO8Hcs=@emersion.fr>
 <CACvgo52+o9_ETC+1RKzqKkyw3ZJ28RjH0BqC9DfmNAKqByud8Q@mail.gmail.com>
 <d3f0cc20-d226-ee42-cc98-b469949cec9e@redhat.com> <YV87l-2XXzmZ2i6GuGd__uf85s2JQkbXt_qTQDYlbBh1kW2COJoNLUDinmLCokKyy-_0ZnIMUcZeW0GdJ8zF690iYi4ThKrjc09omNMe-0g=@emersion.fr>
 <d4f5e101-3dd5-2f3a-6c14-6b32ee37c223@redhat.com> <DM7TzJ-fZEHjoGXvMG8XLfJ2VxohRxotL40_0Vb4cAUvrELgV9BvPGbK6HAwOYOBCx8qXtY2LQ0xnZ-nlH_IVCyne7tMKfvkqxtoWI6MkTw=@emersion.fr>
 <16c1886f-d130-b299-9d09-ad11556f3bfd@amd.com>
In-Reply-To: <16c1886f-d130-b299-9d09-ad11556f3bfd@amd.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 18 Mar 2022 16:29:57 +0800
Message-ID: <CAJMQK-iW6zu7+cjSPHHDcLCj5Zj086qZ+oY62_onOzZcsXtTWQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v8 1/3] gpu: drm: separate panel orientation
 property creating and value setting
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Simon Ser <contact@emersion.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
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
        Alex Deucher <alexander.deucher@amd.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:57 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-02-18 07:12, Simon Ser wrote:
> > On Friday, February 18th, 2022 at 12:54, Hans de Goede <hdegoede@redhat.com> wrote:
> >
> >> On 2/18/22 12:39, Simon Ser wrote:
> >>> On Friday, February 18th, 2022 at 11:38, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>>> What I'm reading in the above is that it is being considered to allow
> >>>> changing the panel-orientation value after the connector has been made
> >>>> available to userspace; and let userspace know about this through a uevent.
> >>>>
> >>>> I believe that this is a bad idea, it is important to keep in mind here
> >>>> what userspace (e.g. plymouth) uses this prorty for. This property is
> >>>> used to rotate the image being rendered / shown on the framebuffer to
> >>>> adjust for the panel orientation.
> >>>>
> >>>> So now lets assume we apply the correct upside-down orientation later
> >>>> on a device with an upside-down mounted LCD panel. Then on boot the
> >>>> following could happen:
> >>>>
> >>>> 1. amdgpu exports a connector for the LCD panel to userspace without
> >>>> setting panel-orient=upside-down
> >>>> 2. plymouth sees this and renders its splash normally, but since the
> >>>> panel is upside-down it will now actually show upside-down
> >>>
> >>> At this point amdgpu hasn't probed the connector yet. So the connector
> >>> will be marked as disconnected, and plymouth shouldn't render anything.
> >>
> >> If before the initial probe of the connector there is a /dev/dri/card0
> >> which plymouth can access, then plymouth may at this point decide
> >> to disable any seemingly unused crtcs, which will make the screen go black...
> >>
> >> I'm not sure if plymouth will actually do this, but AFAICT this would
> >> not be invalid behavior for a userspace kms consumer to do and I
> >> believe it is likely that mutter will disable unused crtcs.
> >>
> >> IMHO it is just a bad idea to register /dev/dri/card0 with userspace
> >> before the initial connector probe is done. Nothing good can come
> >> of that.
> >>
> >> If all the exposed connectors initially are going to show up as
> >> disconnected anyways what is the value in registering /dev/dri/card0
> >> with userspace early ?
> >
> > OK. I'm still unsure how I feel about this, but I think I agree with
> > you. That said, the amdgpu architecture is quite involved with multiple
> > abstraction levels, so I don't think I'm equipped to write a patch to
> > fix this...
> >
>
> amdgpu_dm's connector registration already triggers a detection. See the
> calls to dc_link_detect and amdgpu_dm_update_connector_after_detect in
> amdgpu_dm_initialize_drm_device.
>
> dc_link_detect is supposed to read the edid via
> dm_helpers_read_local_edid and amdgpu_dm_update_connector_after_detect
> will update the EDID on the connector via a
> drm_connector_update_edid_property call.
>
> This all happens at driver load.
>
> I don't know why you're seeing the embedded connector as disconnected
> unless the DP-MIPI bridge for some reason doesn't indicate that the panel
> is connected at driver load.
>
> Harry
>
> > cc Daniel Vetter: can you confirm probing all connectors is a good thing
> > to do on driver module load?
> >
> >>>> I guess the initial modeline is inherited from the video-bios, but
> >>>> what about the physical size? Note that you cannot just change the
> >>>> physical size later either, that gets used to determine the hidpi
> >>>> scaling factor in the bootsplash, and changing that after the initial
> >>>> bootsplash dislay will also look ugly
> >>>>
> >>>> b) Why you need the edid for the panel-orientation property at all,
> >>>> typically the edid prom is part of the panel and the panel does not
> >>>> know that it is mounted e.g. upside down at all, that is a property
> >>>> of the system as a whole not of the panel as a standalone unit so
> >>>> in my experience getting panel-orient info is something which comes
> >>>> from the firmware /video-bios not from edid ?
> >>>
> >>> This is an internal DRM thing. The orientation quirks logic uses the
> >>> mode size advertised by the EDID.
> >>
> >> The DMI based quirking does, yes. But e.g. the quirk code directly
> >> reading this from the Intel VBT does not rely on the mode.
> >>
> >> But if you are planning on using a DMI based quirk for the steamdeck
> >> then yes that needs the mode.
> >>
> >> Thee mode check is there for 2 reasons:
> >>
> >> 1. To avoid also applying the quirk to external displays, but
> >> I think that that is also solved in most drivers by only checking for
> >> a quirk at all on the eDP connector
> >>
> >> 2. Some laptop models ship with different panels in different badges
> >> some of these are portrait (so need a panel-orient) setting and others
> >> are landscape.
> >
> > That makes sense. So yeah the EDID mode based matching logic needs to
> > stay to accomodate for these cases.
> >
> >>> I agree that at least in the Steam
> >>> Deck case it may not make a lot of sense to use any info from the
> >>> EDID, but that's needed for the current status quo.
> >>
> >> We could extend the DMI quirk mechanism to allow quirks which don't
> >> do the mode check, for use on devices where we can guarantee neither
> >> 1 nor 2 happens, then amdgpu could call the quirk code early simply
> >> passing 0x0 as resolution.
> >
> > Yeah. But per the above amdgpu should maybe probe connectors on module
> > load. If/when amdgpu is fixed to do this, then we don't need to disable
> > the mode matching logic in panel-orientation quirks anymore.
>

Hi all,

Thanks for all of the discussion. I'm not sure about how amd drm
works, but for some SoC, the panel orientation is set in panel[1].
The goal of this patch is to separate the property creation, so some
drm can optionally create it earlier before drm_dev_register().

I've sent the v9 to address some issues in v8, but the basic idea is
still the same. It has no effect to
drm_connector_set_panel_orientation_with_quirk() used in amdgpu and
i915, they work the same as before. Do you think this is reasonable?

[1]  https://elixir.bootlin.com/linux/v5.17-rc7/source/drivers/gpu/drm/panel/panel-edp.c#L556
