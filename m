Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2AF47C1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhLUOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:47:37 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6F4C061574;
        Tue, 21 Dec 2021 06:47:37 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v64so39473774ybi.5;
        Tue, 21 Dec 2021 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU6wzEeFNn3YRvVSxXSOJk8zG0NRfB2QGurzvUFCC/8=;
        b=ZviMg9zoyQZ7w4BLqwW383ezcQve57tK3X/iz5L32Jj3mvcljVbdu+Tiaq077PXwAp
         HwhOvKPlU+p1cnN8S9BZJ2xFgRX2Y0AR656TkMqI3FRPqA417fWSEE1y2lQoK4D8L6Mk
         Nu0Ji7UxLtx6nhwp8iomr+BO/yrdxB9OzKkKT6z74pVT22NJkahqeucySNcg88NcgClw
         2hdCYUsj7vpnlstxVw5sq7dLF0yXlwxQEGTpfi+rJm6tp+xf7lAio2n1qg/SkgCIRXyG
         pbDd7UtfWct4/me7OCABkp32FrmX23KE2PqarvyqXIR4YB9MJDGc/nm7lVgu71TfwTUS
         Nt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU6wzEeFNn3YRvVSxXSOJk8zG0NRfB2QGurzvUFCC/8=;
        b=MtOOkWB03cNlbK+0djrI3CM/kYT0oCxK/GmOZFJutae6Vzz+eLtQMCL0HdF2cv7HkT
         f7QahglPG8AHRRfHCfm3iunlDDybTDBUftMY2cPRhpwnqIXQ8WfTtT3bXTXx9JdBasRU
         WPlrCyO5dMBeZgJxGEf9+iQGcfDvZxrAKjTGB28HLBCLu2JN7npJWTPU2HGi4CXuqbQM
         4t2G+vBrIXxHxel+OAlYvodgHpdDtgDn3+NA+UD3iJ8/5RcVBmrRe0mXw40te03AzbJl
         3ibE1WHtwtiH1FUeou69yTw5O42k8DofJJI91sD+7GX+CffRZSVAapfKdDqipc88vCh/
         EyBg==
X-Gm-Message-State: AOAM532A3bAYMcHjUD3e3rSC9I8xJD1ZLfUXmfyCGQ9Nxhu6uhE5Vt9R
        bzG9C53EBJa1bjCehBlX27gXrRuM/eGWyYpO4Kw=
X-Google-Smtp-Source: ABdhPJzs8RuDTRwJ7yxPk2GSySEz8QjBuV5CIoO6G0G2uUZcwRZAQUqw67fI02Vp76SkXeHwSalx2C7m4J4hYhECZzg=
X-Received: by 2002:a25:1004:: with SMTP id 4mr4999916ybq.669.1640098056237;
 Tue, 21 Dec 2021 06:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20200904201835.5958-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200904201835.5958-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8b5d4928-2921-b876-7d1e-04bb42eff4fa@st.com> <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
 <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com>
In-Reply-To: <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 21 Dec 2021 14:47:10 +0000
Message-ID: <CA+V-a8uk3h95aL7n7cDjYdXJBbE6GWF_LkiAVMOFtVzv-83ZpQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
To:     Eugen Hristev <Eugen.Hristev@microchip.com>
Cc:     Hugues Fruchet <hugues.fruchet@st.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Paul <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the delay.

On Tue, Dec 21, 2021 at 7:37 AM <Eugen.Hristev@microchip.com> wrote:
>
> On 6/29/21 1:47 PM, Eugen Hristev - M18282 wrote:
> > On 9/9/20 7:16 PM, Hugues FRUCHET wrote:
> >> Hi Prabhakar,
> >>
> >> As discussed separately I would prefer to better understand issue before
> >> going to this patch.
> >> Nevertheless I have some remarks in code in case we'll need it at the end.
> >>
> >> On 9/4/20 10:18 PM, Lad Prabhakar wrote:
> >>> Keep the sensor in software power down mode and wake up only in
> >>> ov5640_set_stream_dvp() callback.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> >>> Tested-by: Jacopo Mondi <jacopo@jmondi.org>
> >>> ---
> >>>     drivers/media/i2c/ov5640.c | 19 ++++++++++++++++---
> >>>     1 file changed, 16 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> >>> index 2fe4a7ac0592..880fde73a030 100644
> >>> --- a/drivers/media/i2c/ov5640.c
> >>> +++ b/drivers/media/i2c/ov5640.c
> >>> @@ -34,6 +34,8 @@
> >>>     #define OV5640_REG_SYS_RESET02              0x3002
> >>>     #define OV5640_REG_SYS_CLOCK_ENABLE02       0x3006
> >>>     #define OV5640_REG_SYS_CTRL0                0x3008
> >>> +#define OV5640_REG_SYS_CTRL0_SW_PWDN 0x42
> >>> +#define OV5640_REG_SYS_CTRL0_SW_PWUP 0x02
> >>
> >> For the time being this section was only referring to registers
> >> addresses and bit details was explained into a comment right before
> >> affectation, see OV5640_REG_IO_MIPI_CTRL00 for example.
> >>
> >>>     #define OV5640_REG_CHIP_ID          0x300a
> >>>     #define OV5640_REG_IO_MIPI_CTRL00   0x300e
> >>>     #define OV5640_REG_PAD_OUTPUT_ENABLE01      0x3017
> >>> @@ -1120,6 +1122,12 @@ static int ov5640_load_regs(struct ov5640_dev *sensor,
> >>>                 val = regs->val;
> >>>                 mask = regs->mask;
> >>>
> >>> +             /* remain in power down mode for DVP */
> >>> +             if (regs->reg_addr == OV5640_REG_SYS_CTRL0 &&
> >>> +                 val == OV5640_REG_SYS_CTRL0_SW_PWUP &&
> >>> +                 sensor->ep.bus_type != V4L2_MBUS_CSI2_DPHY)
> >>> +                     continue;
> >>> +
> >>
> >> I understand that more or less register OV5640_REG_SYS_CTRL0 (0x3008)
> >> has been partially removed from big init sequence: for power-up part,
> >> but power-dwn remains at very beginning of sequence.
> >> We should completely remove 0x3008 from init sequence, including
> >> power-dwn, and introduce a new function ov5640_sw_powerdown(on/off) that
> >> should be called at the right place instead.
> >>
> >>
> >>>                 if (mask)
> >>>                         ret = ov5640_mod_reg(sensor, reg_addr, mask, val);
> >>>                 else
> >>> @@ -1297,9 +1305,14 @@ static int ov5640_set_stream_dvp(struct ov5640_dev *sensor, bool on)
> >>>          * PAD OUTPUT ENABLE 02
> >>>          * - [7:2]:     D[5:0] output enable
> >>>          */
> >>> -     return ov5640_write_reg(sensor,
> >>> -                             OV5640_REG_PAD_OUTPUT_ENABLE02,
> >>> -                             on ? 0xfc : 0);
> >>> +     ret = ov5640_write_reg(sensor, OV5640_REG_PAD_OUTPUT_ENABLE02,
> >>> +                            on ? 0xfc : 0);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     return ov5640_write_reg(sensor, OV5640_REG_SYS_CTRL0, on ?
> >>> +                             OV5640_REG_SYS_CTRL0_SW_PWUP :
> >>> +                             OV5640_REG_SYS_CTRL0_SW_PWDN);
> >>>     }
> >>>
> >>>     static int ov5640_set_stream_mipi(struct ov5640_dev *sensor, bool on)
> >>>
> >>
> >>
> >> BR,
> >> Hugues.
> >>
> >
> >
> > Hello everyone,
> >
> > When I updated driver in my tree with this patch, I noticed that my
> > setup using the ATMEL isc platform + ov5640 in parallel bus mode stopped
> > working.
> >
> > It looks like the culprit is this patch.
> > I am not sure which is the best way to fix it.
> > It looks like initially things work fine when probing the driver, but
> > when we want to start streaming at a later point, the register SYS_CTRL0
> > cannot be written anymore.
> > Here is an output of the log:
> >
> >    --- Opening /dev/video0...
> >       Trying source module v4l2...
> >       /dev/video0 opened.
> >       No input was specified, using the first.
> >       ov5640 1-003c: ov5640_write_reg: error: reg=3008, val=2
> >       atmel-sama5d2-isc f0008000.isc: stream on failed in subdev -121
> >       Error starting stream.
> >       VIDIOC_STREAMON: Remote I/O error
> >       Unable to use mmap. Using read instead.
> >       Unable to use read.
> >
> > I am using a simple application to read from /dev/video0 (which is
> > registered by the atmel-isc once the sensor probed)
> >
> > I have a feeling that something is wrong related to power, but I cannot
> > tell for sure.
> >
> > Reverting this patch makes it work fine again.
> >
> > Help is appreciated,
> > Thanks,
> > Eugen
> >
>
>
> Gentle ping.
>
> I would like to send a revert patch if nobody cares about this
> driver/patch except me.
>
I powered up the Renesas RZ/G1H connected with an ov5640 sensor and
was able to capture the video data [0] using the yavta application.
I'm fine with reverting the patch too as this works fine as well.

Just some suggestions:
- What is the application you are trying to use for capturing?
- Have you tried reducing the i2c clock speed?
- Can you try and do a dummy write for some other register in
ov5640_set_stream_dvp() to see if i2c writes are failing for all regs?
- Can you add ov5640_read_reg() in ov5640_write_reg() when
i2c_transfer() fails to check if read too is failing.

[0] https://paste.debian.net/1224317/

Cheers,
Prabhakar
