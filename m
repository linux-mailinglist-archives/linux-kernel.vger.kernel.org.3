Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813C047BF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbhLUMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:06:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:39565 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234070AbhLUMGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640088398; x=1671624398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U/WOkGr5BYeL7TPyqZEIOXMu2gqejtYukgr7Rxu83DU=;
  b=OhL+my49Jk36HdTIMTckeiEX+IQSHVMslfRO5WHkAlInTbeJV+b6nx0T
   MsgtgkUP+yiJirlCVkmt126xC1PqygGLKj8r+FqTzq2AuWsaDOXaepXpA
   VsHCCEDcAhFGG73h9FEDfqfdpRDGds/Zv/SKFk3OzoOlhiZohyJBUXjvs
   5VenQasxSpCjhd1Q+8hI7lwXYDdRPadqZ4pLNUlHD3Py5OLoJACAOZcke
   X0rcv23P+YxiURV0UHuaWFNlbN6+c2zfDVWNvVmUGQNBuSkGQaFLV9Br9
   W85z2OdMH6HZVdO57I+w+BjAzNCBdPd7CSQAA5BAgX9th6be8wafRJOct
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227231644"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="227231644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 04:06:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="570193030"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 04:06:29 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 7FA4F203BA;
        Tue, 21 Dec 2021 14:06:27 +0200 (EET)
Date:   Tue, 21 Dec 2021 14:06:27 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     hugues.fruchet@st.com, Eugen.Hristev@microchip.com
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, jacopo+renesas@jmondi.org,
        laurent.pinchart@ideasonboard.com, slongerbeam@gmail.com,
        paul.kocialkowski@bootlin.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        biju.das.jz@bp.renesas.com, prabhakar.csengg@gmail.com,
        mchehab@kernel.org
Subject: Re: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
Message-ID: <YcHDQ1hwPLNnH0CN@paasikivi.fi.intel.com>
References: <20200904201835.5958-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200904201835.5958-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8b5d4928-2921-b876-7d1e-04bb42eff4fa@st.com>
 <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
 <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues, Eugen,

On Tue, Dec 21, 2021 at 07:37:47AM +0000, Eugen.Hristev@microchip.com wrote:
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

Hugues: any thoughts on this?

Without knowing much about the sensor, the stated intent of the patch seems
reasonable. But if it breaks things, then reverting it sounds like a good
idea until a proper fix is available.

-- 
Kind regards,

Sakari Ailus
