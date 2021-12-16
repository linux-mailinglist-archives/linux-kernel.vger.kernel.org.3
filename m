Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0A4772BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbhLPNKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbhLPNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:10:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F215C061574;
        Thu, 16 Dec 2021 05:10:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so86591040edd.0;
        Thu, 16 Dec 2021 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psqq8AxoCtsUWk+9+3wi7F1REcnczjIneOZP6k7X4Bw=;
        b=l4/fnlsaIWrU7XKiQ7Y1Xotl89tt0lQGwCgppt2kzLRde0Zmvr3uL/Twu8Q7HJmzBR
         h4+y76Vejnslwze2Z+R8qRc4gxovJ/kYrOq7ftE7Y9OdEMUi4w8BXAZots4MkDbo6uNt
         5BZfMIA14nVRhnyWayWC4kykR9tqSlO4q9yYaNPdWpqtfzwWnkCKsaxiPU0ydjvc4WtN
         iD/9tLaLxnFTHnLTxvOiOsLKVvImmerZK+VlpUahAATlZQZ8TkrZKYFQewtGRxQ4AgiM
         zGCJX9iDSYqMQcqCaFNJz6Nth6NbTQ2TahaYIJVvz3oOXl8EEmGVcYJA9YilTEaNnPYR
         UpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psqq8AxoCtsUWk+9+3wi7F1REcnczjIneOZP6k7X4Bw=;
        b=o1DA6htD9O2Pszo9DNUCfHD/owiimET5I314FtPN3X4/bIsBXQjieLlE1gfVBfgAsT
         HGEgUK6HRkzh59mKhBBSzjzDO1qBm/U0cWa2QvjicCV81C/Yx1Wz8rxnph8U+zh/9MWK
         ZdEiw8VCwFQNVZN4C5NU84GlQRmDcZkv4hKg7GTBZorXPHNpboRiEI3c4SEv8Pi2mRPV
         mdgO9OIdH8ljO7xDw1GnVVRTbIBbwm/7LDwU7LgC6Ir/hbAHkvV9hwMnnCSmXj2VjBrD
         fxyRmA2nDn5/4c/YN8WPzeMKAUKoGIiwvYYCbGhGbGwYl+/h+1BuH/IE+UdIqvk0SzYk
         CiRg==
X-Gm-Message-State: AOAM530KCeQTWmoqiOSRHnICUQihb2ecXr8is8O4flFfY8DdlKG2qiRY
        e9VeAX+8wvqLo1uTjrz5X3EFdqHjeY97NKCzF2k=
X-Google-Smtp-Source: ABdhPJyJ7BpFsLTq0XQBuilAPWj5q7Udd6T7s6oVqbuEeN+5S7fO/uyVzU/41WmJNvE51tkKZn15ArvhQa/v+6Od+xc=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr3229632ejc.198.1639660205253;
 Thu, 16 Dec 2021 05:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20211216111256.2362683-1-aford173@gmail.com> <Ybsyd9/nRrszJ5f8@eze-laptop>
In-Reply-To: <Ybsyd9/nRrszJ5f8@eze-laptop>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 16 Dec 2021 07:09:53 -0600
Message-ID: <CAHCN7xJGpjCw5TLOXJ1r-KtcRNcUVqwa2qhmwCrLuTf4aJqBkQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/10] media: hantro: imx8mq/imx8mm: Let VPU decoders
 get controlled by vpu-blk-ctrl
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 6:35 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Hi Adam,
>
> The series looks really great.
>
> On Thu, Dec 16, 2021 at 05:12:45AM -0600, Adam Ford wrote:
> > Both the i.MX8MQ and i.MX8MM have G1 and G2 decoders.
> > The two decoders are similar, but the imx8mm lacks the
> > post-processor, so they will have distinct compatible flags.
> >
> > From what I can tell, the G2 decoder wasn't working, so splitting
> > the i.MX8MQ VPU into G1 and G2 makes it easier to control them
> > independently since the TRM of both the i.MX8MQ and
> > i.MX8MM list them as distinct IP blocks. This also allowed G2 to
> > become available.
> >
> > With them being split, the power-domain can shift to the
> > vpu-blk-ctrl which is available on both i.MX8MQ and i.MX8MM,
> > but some of bits are different, so they'll have separate bindings.
> >
> > Lastly, with the G1 and G2 operational, enable the i.MX8MM.
> > On the i.MX8MM, the clock speed of 600MHz was chosen to match
> > the default of the kernel repo from NXP and can be overwritten
> > by board files for anyone who under/over volts the power rail.
> >
> > There seems to be some disagreement between the TRM and the Datasheet
> > for the imx8mq as to whether the speed should be 300MHz (TRM) or
> > 600MHz (datasheet), so feedback from NXP would be very much
> > appreciated.
> >
> > The repo used as the starting point was:
> > git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
> >
>
> I believe you should be able to rebase on top of
> media_tree master. As far as I can see, it contains the VP9
> support you need.
>
> Also, please cherry-pick the following fix from Benjamin
>
> https://patchwork.linuxtv.org/project/linux-media/patch/20211208164418.848790-1-benjamin.gaignard@collabora.com/
>
> This is queued and should land on the master branch very soon.
>
> > Fluster was run on both i.MX8MM and i.MX8MQ
> >
> > At 600 MHz, the i.MX8MM had the following:
> >
> > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > Ran 55/61 tests successfully               in 8.299 secs
> >
> > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > Ran 90/135 tests successfully               in 71.200 secs
> >
> > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > Ran 139/303 tests successfully               in 218.079 secs
>
> I imagine the reason H264 and VP9 tests take so long
> is some pixelformat conversion somewhere. It would be great
> if Fluster could have test vectors ready in the pixelformat
> the hardware produces :-)
>
> >
> > The i.MX8MQ had the following:
> >
> > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > Ran 55/61 tests successfully               in 7.732 secs
> >
> > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > Ran 90/135 tests successfully               in 58.558 secs
> >
> > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > Ran 144/303 tests successfully               in 271.373 secs
> >
>
> ... in any case, the fact that fluster is passing is already
> telling us the driver is in good shape. How many jobs is the above
> running in parallel?
>
> If you want to do some other tests, you can build a gstreamer
> pipeline, with sync=false, and decode a few 1080p video, e.g.
> https://jell.yfish.us/.
>
> Something like gst-launch-1.0 filesrc ! decodebin ! fakevideosink, or
> so.
>
> Then, you can run the pipeline in parallel as many times as you want:
>
> gst-launch-1.0 filesrc ! decodebin ! fakevideosink filesrc ! decodebin ! fakevideosink filesrc ! decodebin ! fakevideosink ...
>
> (GStreamer lets you concatenate src ! sink src ! sink, in the same
> gst-launch-1.0 invocation).
>
> > V2:  Remove references to legacy dt-binding from YAML, but keep
> >      it in the driver so older device trees can still be used.
> >      Fix typos in YAML
> >      Remove reg-names, interrupt-names, and clock-names from YAML,
> >      since each node will only have one of each, they're not necessary
> >      Add Fluster scores to cover letter for i.MX8MQ
> >
>
> Looks great.

Any change you could give your acked-by or reviewed-by to the patches?
 Even if they need some work, I can carry those along to the next
revision when I do the work you request.

adam



>
> Thanks,
> Ezequiel
>
> > Adam Ford (7):
> >   dt-bindings: media: nxp,imx8mq-vpu: Split G1 and G2 nodes
> >   media: hantro: Allow i.MX8MQ G1 and G2 to run independently
> >   arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl
> >   arm64: dts: imx8mm: Fix VPU Hanging
> >   dt-bindings: media: nxp,imx8mq-vpu: Add support for G1 and G2 on
> >     imx8mm
> >   media: hantro: Add support for i.MX8MM
> >   arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders
> >
> > Lucas Stach (3):
> >   dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
> >   dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
> >   soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
> >
> >  .../bindings/media/nxp,imx8mq-vpu.yaml        | 93 +++++++++++--------
> >  .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      | 71 ++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 23 ++++-
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 63 ++++++++-----
> >  drivers/soc/imx/imx8m-blk-ctrl.c              | 68 +++++++++++++-
> >  drivers/staging/media/hantro/hantro_drv.c     |  3 +
> >  drivers/staging/media/hantro/hantro_hw.h      |  3 +
> >  drivers/staging/media/hantro/imx8m_vpu_hw.c   | 75 ++++++++++++---
> >  include/dt-bindings/power/imx8mq-power.h      |  3 +
> >  9 files changed, 324 insertions(+), 78 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
> >
> >
> > base-commit: d1888b0bfd2ddef2e8a81505ffa200b92cc32e0c
> > --
> > 2.32.0
> >
