Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E9466B53
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbhLBVDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhLBVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:03:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181EC06174A;
        Thu,  2 Dec 2021 13:00:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so2951841eda.11;
        Thu, 02 Dec 2021 13:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bh3FkLB+q+IhBnShvoY1GO0GV+nrEdn+PjaCXWUUYOc=;
        b=VJQf+7H+nZE/4Atz54WLI2qgPxceJ4EAgS2M5r3wJnoaUAaq7dBzEl1CDSCJHhvbPG
         Yjcpl+DI5cm+PlzbPSzZ8fwQnjnf9n5h+3yPt0aTT0M0w0G2du+p8G5KPk2Bk7Lpl5ai
         h2ytk6TGndnsA8YXNRN6HicdaaPxWJBD3IrRU2Y20UyZN/kWqVokNzH5AjMZ5KfkPFRS
         r5OYZky0NEGw7CB5hkvPfhdje1cU6cm491NtXzlvgaVuGEvilzwIGg2QyjFdRck6gYvL
         rU8b6l/f3dqbKHTwNy9fT0NyFnZM2++21paFakjDcNSWk8oip8CREB1Jrs32C49e5jTL
         7SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bh3FkLB+q+IhBnShvoY1GO0GV+nrEdn+PjaCXWUUYOc=;
        b=EacNzu0v+6QxLCkzOxvetip03LJyqISflYjBqokWqLH4W81uMAZNCSEQXoM6wpVD+J
         jS5X0PNjs8bD01rph0bX2FzkP/qjHWtPlMRo8TiypDMmsofPbmEFdzB+OO6WdqceFhQN
         6C2cUGoTCheKvhsTjfCI1eF2mbVsSD5O3SRMcZCUTBX/2tVA+5KymWcmZPjZ8b5X5TSy
         ZyeBSrVBtSCVaCCJZGYXq3ouRlLiaYiN0U0U3vpslzQN8F/MenwwZ6lDPhAcmNYSjGfZ
         /fPvTaJQwk1SmzyerlYaJxPg0quQW1MMFIrBXywpLccLD9LkaDL4UGkf0Z8hNMTYzZTe
         J9Yg==
X-Gm-Message-State: AOAM531/72TodwdAqUE3g06EU2J4TJMZzjyDxjtptqwV0hyAlVDB/LTR
        w14/wv+C4w6LrikrBxBTzRuBH83MThglwaAmmME=
X-Google-Smtp-Source: ABdhPJyMPW1OcigW7e9CCbjgXJ/K6L2Wg+y5swFfQKOCkjrdriWNyhtUcXxkvAzdQwnh3K47pPVeqGNW0tUxlyIRmok=
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr21163665edc.398.1638478821295;
 Thu, 02 Dec 2021 13:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20211202041627.291625-1-aford173@gmail.com> <CAHCN7xJHuOFTQBQWk1yKsk3M0iDB7aKc0=L2DisUoSXVeO3xXQ@mail.gmail.com>
 <CAJ+vNU2t7Yp5OGtWj432Y-8hL62nQBbG58zM-gAj5YfuCO__sA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2t7Yp5OGtWj432Y-8hL62nQBbG58zM-gAj5YfuCO__sA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 2 Dec 2021 15:00:10 -0600
Message-ID: <CAHCN7xJXMUHHBACuozY3nUdZ0QqHFLrmwrXnArtCKBG7+P4UZQ@mail.gmail.com>
Subject: Re: [RFC V3 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 12:54 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Dec 2, 2021 at 4:29 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Wed, Dec 1, 2021 at 10:17 PM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> > > to be related to the video decoders used on the i.MX8MQ, but because of
> > > how the Mini handles the power domains, the VPU driver does not need to
> > > handle all the functions, so a new compatible flag is required.
> > >
> > > V3 is rebased from git://linuxtv.org/hverkuil/media_tree.git for-v5.17c
> > > This branch has support for VP9.
> > >
> > > I set cma=512M, but this may not be enough memory as some tests appeard to run out of memory
> > >
> > > V3 of this series has several changes:
> > >
> > > Update imx8m_vpu_hw to add missing 'reg' reference names for G2 and include references to VP9
> > > Update device tree to remove IMX8MQ_VPU_RESET, remove some duplicate vpu clock parenting
> > > Fix missing reg-names from vpu_g2 node.
> > > Apply patch [1] to manage the power domains powering down.
> > > [1] - https://lore.kernel.org/linux-arm-kernel/20211016210547.171717-1-marex@denx.de/t/
> > >
> > > With the above, the following Fluster scores are produced:
> > >
> > > G1:
> > > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > > Ran 90/135 tests successfully               in 74.406 secs
> > >
> > > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > > Ran 55/61 tests successfully               in 8.080 secs
> > >
> > > G2:
> > > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > > Ran 127/303 tests successfully               in 203.873 secs
> > >
> > > Fluster and G-Streamer were both built from their respective git repos using their respective master/main branches.
> > >
> >
> > I should note, that both interrupts appear to be triggering.
> >
> > # cat /proc/interrupts |grep codec
> >  57:      13442          0          0          0     GICv3  39 Level
> >   38300000.video-codec
> >  58:       7815          0          0          0     GICv3  40 Level
> >   38310000.video-codec
> >
>
> Adam,
>
> On another thread you had let me know that you also removed the reset
> from the pgc_vpumix power domain which does appear to resolve the
> hang:
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index eb9dcd9d1a31..31710af544dc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -681,7 +681,6 @@
>                                                 clocks = <&clk
> IMX8MM_CLK_VPU_DEC_ROOT>;
>                                                 assigned-clocks =
> <&clk IMX8MM_CLK_VPU_BUS>;
>                                                 assigned-clock-parents
> = <&clk IMX8MM_SYS_PLL1_800M>;
> -                                               resets = <&src
> IMX8MQ_RESET_VPU_RESET>;
>                                         };
>
>                                         pgc_vpu_g1: power-domain@7 {
>
> That would make such a patch have a 'Fixes commit d39d4bb15310
> ("arm64: dts: imx8mm: add GPC node")' but of course that vpu domain
> isn't active until your series so I'm not sure if we should send this
> separate or squash it with "arm64: dts: imx8mm: Enable VPU-G1 and
> VPU-G2". I'm also not clear if removing the reset requires some
> further discussion with Lucas.

Unless there is objection from Lucas, I'll likely make it the first
patch in the series marking it with a fixes tag so it gets backported,
then the rest of the series would be adding the bindings, update the
driver and adding the G1 and G2 nodes.

adam
>
> Best regards,
>
> Tim
