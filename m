Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4334B7090
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiBOQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:37:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiBOQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:37:34 -0500
X-Greylist: delayed 9703 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 08:37:23 PST
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D2A4184;
        Tue, 15 Feb 2022 08:37:23 -0800 (PST)
Date:   Tue, 15 Feb 2022 16:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1644943039;
        bh=f1kG4y1Pad9UaeKLlKedqj/sm+OCsoIlrgJXYL6aSeI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=E9V91jN86xK6pzcMltPM69/bOQFFQNJV14lQwmcL2FYT3foga5gLBN44BK4oxAPri
         Vd8zuw1PuCIPGRg2//vtiVX9F2F6j/JTJL3odWwNmjV4QndYJ/cNzlL994kRk5oss4
         t+oB5svlaOh0xBX9GF7yyVj1AjeFwDYEvnfX4LlK0wXUUANzluIiX7MMssmf+EtKXg
         j3TEQWNZHHEFFnC96soVMV8mnPbtAkLt2VhY0qKE/ctXlMHsckdPLAA5vi0D16WsVW
         ELSgf6c8NzeavnNPc22BI1Gvf+qHdGR5FmKWYe1aX8Wak2lhTUG3wpbv4id1Yx/OtQ
         5XOlTjjx0fyLA==
To:     Emil Velikov <emil.l.velikov@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [Intel-gfx] [PATCH v8 1/3] gpu: drm: separate panel orientation property creating and value setting
Message-ID: <GYG6EVT1MqtmfKiPpMhDG9mpuATnmwVDq2PuE_dpDat5oQW_t1tUfm39lSWHj32D5r7mrog27sL4dkgdMYQ5BN830TfVOrgQ4Ts8LcO8Hcs=@emersion.fr>
In-Reply-To: <CACvgo532-pC+7DLFCo=DWTX-OnJEJvSoTmQnt3_qLhiT4cqEMg@mail.gmail.com>
References: <20220208084234.1684930-1-hsinyi@chromium.org> <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com> <KW6DNh6IRRgVJx9DfOFBnEqc4a0x-AnDXEbMxwpfEbk8dOn_KGVzAfo-slJWq-4nWW728Uc-OVpFh2w4fDE4-bxfkDuz1hFILRVvbcuXqaw=@emersion.fr> <CACvgo532-pC+7DLFCo=DWTX-OnJEJvSoTmQnt3_qLhiT4cqEMg@mail.gmail.com>
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

On Tuesday, February 15th, 2022 at 15:38, Emil Velikov <emil.l.velikov@gmai=
l.com> wrote:

> On Tue, 15 Feb 2022 at 13:55, Simon Ser <contact@emersion.fr> wrote:
> >
> > On Tuesday, February 15th, 2022 at 13:04, Emil Velikov <emil.l.velikov@=
gmail.com> wrote:
> >
> > > Greetings everyone,
> > >
> > > Padron for joining in so late o/
> > >
> > > On Tue, 8 Feb 2022 at 08:42, Hsin-Yi Wang <hsinyi@chromium.org> wrote=
:
> > > >
> > > > drm_dev_register() sets connector->registration_state to
> > > > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > > > drm_connector_set_panel_orientation() is first called after
> > > > drm_dev_register(), it will fail several checks and results in foll=
owing
> > > > warning.
> > > >
> > > > Add a function to create panel orientation property and set default=
 value
> > > > to UNKNOWN, so drivers can call this function to init the property =
earlier
> > > > , and let the panel set the real value later.
> > > >
> > >
> > > The warning illustrates a genuine race condition, where userspace wil=
l
> > > read the old/invalid property value/state. So this patch masks away
> > > the WARNING without addressing the actual issue.
> > > Instead can we fix the respective drivers, so that no properties are
> > > created after drm_dev_register()?
> > >
> > > Longer version:
> > > As we look into drm_dev_register() it's in charge of creating the
> > > dev/sysfs nodes (et al). Note that connectors cannot disappear at
> > > runtime.
> > > For panel orientation, we are creating an immutable connector
> > > properly, meaning that as soon as drm_dev_register() is called we mus=
t
> > > ensure that the property is available (if applicable) and set to the
> > > correct value.
> >
> > Unfortunately we can't quite do this. To apply the panel orientation qu=
irks we
> > need to grab the EDID of the eDP connector, and this happened too late =
in my
> > testing.
> >
> > What we can do is create the prop early during module load, and update =
it when
> > we read the EDID (at the place where we create it right now). User-spac=
e will
> > receive a hotplug event after the EDID is read, so will be able to pick=
 up the
> > new value if any.
>
> Didn't quite get that, are you saying that a GETPROPERTY for the EDID,
> the ioctl blocks or that we get an empty EDID?

I'm not referring to GETPROPERTY, I'm referring to the driver getting the E=
DID
from the sink (here, the eDP panel). In my experimentations with amdgpu I
noticed that the driver module load finished before the EDID was available =
to
the driver. Maybe other drivers behave differently and probe connectors whe=
n
loaded, not sure.

> The EDID hotplug even thing is neat - sounds like it also signals on
> panel orientation, correct?
> On such an event, which properties userspace should be re-fetching -
> everything or guess randomly?
>
> Looking through the documentation, I cannot see a clear answer :-\

User-space should re-fetch *all* properties. In practice some user-space ma=
y
only be fetching some properties, but that should get fixed in user-space.

Also the kernel can indicate that only a single connector changed via the
"CONNECTOR" uevent prop, or even a single connector property via "PROPERTY"=
.
See [1] for a user-space implementation. But all of this is purely an optio=
nal
optimization. Re-fetching all properties is a bit slower (especially if som=
e
drmModeGetConnector calls force-probe connectors) but works perfectly fine.

It would be nice to document, if you have the time feel free to send a patc=
h
and CC danvet, pq and me.

[1]: https://gitlab.freedesktop.org/wlroots/wlroots/-/blob/252b2348bd62170d=
97c4e81fb2050f757b56d67e/backend/session/session.c#L144
