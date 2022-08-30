Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126A65A6CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiH3TEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiH3TEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:04:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A15FF68;
        Tue, 30 Aug 2022 12:04:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2D2F481;
        Tue, 30 Aug 2022 21:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661886238;
        bh=JM4fSswfevnrMmMIqryIkhvwtBj7r0t++bS4330EkWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wfr9EHiiV+Ma+x3UM+CLS8wVtkv8FoTggX6LCQC7EV89CA7+NwPd2Dti447Xjyj4F
         Rk6AnCYKmWWAlSgRN6Jp17+fV3mKkv3vyJkPhRrgBq3Fp1uCqj/C05VWowNNiAqH+i
         lZWShosWj2/YSHBys8lCDuBbABG/Lb1cKWO3IjXc=
Date:   Tue, 30 Aug 2022 22:03:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
Message-ID: <Yw5fFPPgBuI/9OCF@pendragon.ideasonboard.com>
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yw1ZuKevVXRuyE5m@pendragon.ideasonboard.com>
 <CA+V-a8uGNUkNx=6v+T1gZHmWad+ROADkw2HKk_h+hPrOtqa-DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8uGNUkNx=6v+T1gZHmWad+ROADkw2HKk_h+hPrOtqa-DA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Aug 30, 2022 at 01:42:33PM +0100, Lad, Prabhakar wrote:
> On Tue, Aug 30, 2022 at 1:28 AM Laurent Pinchart wrote:
> > On Mon, Aug 01, 2022 at 10:47:17PM +0100, Lad Prabhakar wrote:
> > > Add MIPI CSI-2 receiver driver for Renesas RZ/G2L. The MIPI
> > > CSI-2 is part of the CRU module found on RZ/G2L family.
> > >
> > > Based on a patch in the BSP by Hien Huynh
> > > <hien.huynh.px@renesas.com>
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > RFC v2 -> v1
> > > * Fixed initialization sequence of DPHY and link
> > > * Exported DPHY and link initialization functions so that the
> > >   CRU core driver can initialize the CRU and CSI2 as per the HW manual.
> > >
> > > RFC v1 -> RFC v2
> > > * new patch (split up as new driver compared to v1)
> > > ---
> > >  drivers/media/platform/renesas/Kconfig        |   1 +
> > >  drivers/media/platform/renesas/Makefile       |   1 +
> > >  .../media/platform/renesas/rzg2l-cru/Kconfig  |  17 +
> > >  .../media/platform/renesas/rzg2l-cru/Makefile |   3 +
> > >  .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 702 ++++++++++++++++++
> > >  .../platform/renesas/rzg2l-cru/rzg2l-csi2.h   |  49 ++
> > >  6 files changed, 773 insertions(+)
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.h

[snip]

> > > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> > > new file mode 100644
> > > index 000000000000..252e33ddb6e8
> > > --- /dev/null
> > > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> > > @@ -0,0 +1,702 @@

[snip]

> > > +/* -----------------------------------------------------------------------------
> > > + * DPHY setting
> > > + */
> > > +
> > > +int rzg2l_csi2_dphy_setting(struct rzg2l_csi2 *csi2, bool on)
> > > +{
> > > +     int lanes, mbps;
> > > +
> > > +     dev_dbg(csi2->dev, "Input size (%ux%u%c)\n",
> > > +             csi2->mf.width, csi2->mf.height,
> > > +             csi2->mf.field == V4L2_FIELD_NONE ? 'p' : 'i');
> > > +
> > > +     /* Checking the maximum lanes support for CSI-2 module */
> > > +     lanes = (rzg2l_csi2_read(csi2, CSI2nMCG) & CSI2nMCG_SDLN) >> 8;
> > > +     if (lanes < csi2->lanes) {
> > > +             dev_err(csi2->dev,
> > > +                     "Failed to support %d data lanes\n", csi2->lanes);
> > > +             return -EINVAL;
> > > +     }
> >
> > You should read and validate the number of lanes at probe time.
> >
> Agreed, I will move this check in probe.
> 
> > > +
> > > +     mbps = rzg2l_csi2_calc_mbps(csi2);
> > > +     if (mbps < 0)
> > > +             return mbps;
> > > +
> > > +     csi2->hsfreq = mbps;
> >
> > This is only needed in the (on) branch.
> >
> Agreed.
> 
> > > +
> > > +     if (on) {
> >
> > The two branches share no code. Split them in two separate functions.
> >
> OK, Ill split it into two separate functions.
> 
> > > +             struct timings dphy_timing;
> >
> > Make this a const pointer.
> >
> Agreed.
> 
> > > +             u32 dphytim0, dphytim1;
> > > +
> > > +             /* Set DPHY timing parameters */
> > > +             if (csi2->hsfreq <= 80)
> > > +                     dphy_timing = global_timings[TRANSMISSION_RATE_80_MBPS];
> > > +             else if (csi2->hsfreq <= 125)
> > > +                     dphy_timing = global_timings[TRANSMISSION_RATE_125_MBPS];
> > > +             else if (csi2->hsfreq <= 250)
> > > +                     dphy_timing = global_timings[TRANSMISSION_RATE_250_MBPS];
> > > +             else if (csi2->hsfreq <= 360)
> > > +                     dphy_timing = global_timings[TRANSMISSION_RATE_360_MBPS];
> > > +             else if (csi2->hsfreq <= 1500)
> > > +                     dphy_timing = global_timings[TRANSMISSION_RATE_360_PLUS_MBPS];
> > > +             else
> > > +                     return -EINVAL;
> > > +
> > > +             /* Set D-PHY timing parameters */
> > > +             dphytim0 = CSIDPHYTIM0_TCLK_MISS(dphy_timing.tclk_miss) |
> > > +                        CSIDPHYTIM0_T_INIT(dphy_timing.t_init);
> > > +             dphytim1 = CSIDPHYTIM1_THS_PREPARE(dphy_timing.ths_prepare) |
> > > +                        CSIDPHYTIM1_TCLK_PREPARE(dphy_timing.tclk_prepare) |
> > > +                        CSIDPHYTIM1_THS_SETTLE(dphy_timing.ths_settle) |
> > > +                        CSIDPHYTIM1_TCLK_SETTLE(dphy_timing.tclk_settle);
> > > +             rzg2l_csi2_write(csi2, CSIDPHYTIM0, dphytim0);
> > > +             rzg2l_csi2_write(csi2, CSIDPHYTIM1, dphytim1);
> > > +
> > > +             /* Enable D-PHY power control 0 */
> > > +             rzg2l_csi2_write(csi2, CSIDPHYSKW0, CSIDPHYSKW0_DEFAULT_SKW);
> > > +
> > > +             /* Set the EN_BGR bit */
> > > +             rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
> > > +
> > > +             /* Delay 20us to be stable */
> > > +             usleep_range(20, 40);
> > > +
> > > +             /* Enable D-PHY power control 1 */
> > > +             rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
> > > +
> > > +             /* Delay 10us to be stable */
> > > +             usleep_range(10, 20);
> > > +
> > > +             /* Start supplying the internal clock for the D-PHY block */
> > > +             pm_runtime_get_sync(csi2->dev);
> >
> > Missing error handling (and use pm_runtime_resume_and_get() to make that
> > easier). But it doesn't seem quite right, you're not supposed to resume
> > the device after writing register, but before.
> >
> > > +     } else {
> > > +             /* Reset the CRU (D-PHY) */
> > > +             reset_control_assert(csi2->rstc);
> > > +
> > > +             /* Stop the D-PHY clock */
> > > +             pm_runtime_put(csi2->dev);
> >
> > Same here, that should to after the register writes.
> >
> > > +
> > > +             /* Cancel the EN_LDO1200 register setting */
> > > +             rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
> > > +
> > > +             /* Cancel the EN_BGR register setting */
> > > +             rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(rzg2l_csi2_dphy_setting);
> >
> > Would it be a problem to also move this call to .s_stream() to avoid
> > direct calls from the CRU driver ?
> >
> Yes it causes a problem, the CSI and CRU setup is as per the sequence
> mentioned in the HW manual. If I move this to .stream() callback I
> sometimes see no buffers being captured on the CSI part.

OK, let's keep it for now and see how it will look like in the next
version.

[snip]

> > > +/* -----------------------------------------------------------------------------
> > > + * Platform Device Driver.
> > > + */
> > > +
> > > +static const struct media_entity_operations rzg2l_csi2_entity_ops = {
> > > +     .link_validate = v4l2_subdev_link_validate,
> > > +};
> > > +
> > > +static int rzg2l_csi2_probe(struct platform_device *pdev)
> > > +{
> > > +     struct rzg2l_csi2 *csi2;
> > > +     struct clk *vclk;
> > > +     unsigned int i;
> > > +     int ret;
> > > +
> > > +     csi2 = devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
> > > +     if (!csi2)
> > > +             return -ENOMEM;
> > > +
> > > +     csi2->base = devm_platform_ioremap_resource(pdev, 0);
> > > +     if (IS_ERR(csi2->base))
> > > +             return PTR_ERR(csi2->base);
> > > +
> > > +     csi2->rstc = devm_reset_control_get(&pdev->dev, "cmn-rstb");
> > > +     if (IS_ERR(csi2->rstc))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(csi2->rstc),
> > > +                                  "failed to get cpg cmn-rstb\n");
> > > +
> > > +     vclk = devm_clk_get(&pdev->dev, "vclk");
> > > +     if (IS_ERR(vclk))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(vclk),
> > > +                                  "failed to get vclk clock\n");
> > > +
> > > +     csi2->vclk_rate = clk_get_rate(vclk);
> > > +     devm_clk_put(&pdev->dev, vclk);
> >
> > Is there no need to ensure at runtime at the clock is on ?
> >
> pm_runtime is used to turn on/off the clocks. Do you think I need to
> add a check here?

If the clock is fully handled by RPM without intervention from the
driver, then this is fine. I would however use clk_get() and clk_put()
instead of the devm_* versions in that case, that would have a lower
overhead.

> > > +
> > > +     csi2->dev = &pdev->dev;
> > > +     mutex_init(&csi2->lock);
> > > +     csi2->stream_count = 0;
> > > +
> > > +     platform_set_drvdata(pdev, csi2);
> > > +
> > > +     ret = rzg2l_csi2_parse_dt(csi2);
> > > +     if (ret)
> > > +             goto error_mutex;
> > > +
> > > +     csi2->subdev.owner = THIS_MODULE;
> >
> > You don't need this, v4l2_subdev_init() handles it.
> 
> OK, I'll drop it.
> 
> > > +     csi2->subdev.dev = &pdev->dev;
> > > +     v4l2_subdev_init(&csi2->subdev, &rzg2l_csi2_subdev_ops);
> > > +     v4l2_set_subdevdata(&csi2->subdev, &pdev->dev);
> > > +     snprintf(csi2->subdev.name, V4L2_SUBDEV_NAME_SIZE, "%s %s",
> >
> > sizeof(csi2->subdev.name) instead of V4L2_SUBDEV_NAME_SIZE, it's less
> > error-prone.
> 
> Agreed.
> 
> > > +              KBUILD_MODNAME, dev_name(&pdev->dev));
> >
> > Don't use KBUILD_MODNAME but set a device name here, for instance use
> > "csi-%s" as the format string. The subdev name shouldn't change if the
> > module is renamed.
> 
> Agreed, I'll update it.
> 
> > > +     csi2->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > +
> > > +     csi2->subdev.entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
> >
> > I think MEDIA_ENT_F_VID_IF_BRIDGE would be more appropriate. The pixel
> > formatter reads or writes pixels from/to memory.
> 
> OK, I'll update it.
> 
> > > +     csi2->subdev.entity.ops = &rzg2l_csi2_entity_ops;
> > > +
> > > +     csi2->pads[RZG2L_CSI2_SINK].flags = MEDIA_PAD_FL_SINK;
> > > +     for (i = RZG2L_CSI2_SOURCE_VC0; i < NR_OF_RZG2L_CSI2_PAD; i++)
> > > +             csi2->pads[i].flags = MEDIA_PAD_FL_SOURCE;
> >
> > One source pad only. Support for multiple virtual channels should be
> > implemented using the stream API that is under development (see
> > https://lore.kernel.org/linux-media/20220810121122.3149086-1-tomi.valkeinen@ideasonboard.com/T/#t).
> 
> My RFCv2 had this, but I dropped it for this version as adding support
> for the multiplex stream was/is moving at a slower pace. So instead I
> thought we can patch this up later.

There's no need to use the streams API for now as it's not ready yet,
but multiple pads isn't an option either. You can hardcode usage of VC 0
for now.

> > > +
> > > +     ret = media_entity_pads_init(&csi2->subdev.entity, NR_OF_RZG2L_CSI2_PAD, csi2->pads);
> > > +     if (ret)
> > > +             goto error_async;
> > > +
> > > +     pm_runtime_enable(&pdev->dev);
> > > +
> > > +     ret = v4l2_subdev_init_finalize(&csi2->subdev);
> > > +     if (ret < 0)
> > > +             goto error_pm;
> > > +
> > > +     ret = v4l2_async_register_subdev(&csi2->subdev);
> > > +     if (ret < 0)
> > > +             goto error_subdev;
> > > +
> > > +     dev_info(csi2->dev, "%d lanes found\n", csi2->lanes);
> > > +
> > > +     return 0;
> > > +
> > > +error_subdev:
> > > +     v4l2_subdev_cleanup(&csi2->subdev);
> > > +error_pm:
> > > +     pm_runtime_disable(&pdev->dev);
> > > +error_async:
> > > +     v4l2_async_nf_unregister(&csi2->notifier);
> > > +     v4l2_async_nf_cleanup(&csi2->notifier);
> > > +error_mutex:
> > > +     mutex_destroy(&csi2->lock);
> > > +
> > > +     return ret;
> > > +}

-- 
Regards,

Laurent Pinchart
