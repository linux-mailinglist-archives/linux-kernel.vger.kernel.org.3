Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAE4656DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352871AbhLAUIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352798AbhLAUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:07:58 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF42C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:04:36 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g19so25652652pfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsiTKNzeT17zlcGBPEflu0BoPiL6YOvxqxu/DTkED3c=;
        b=p8SsnBedrs0pmpdP+PRCtrcFW88LibHugJKnafYAMXVev9lcICnPaVSkqTREFVdw3Z
         pTx7W6JKls/ESN2H6v6TdkB2aHX8RDmMxhIDLKxP9huqGq+tHRFKHakhmJXNhY1shzzE
         jJwyaEznLXvggJcqQYNbE/qEuXKY/fW6nz+que4qcDiDQ0hAoBUoSzTOQm37e2PXVF4f
         Wc9fSNe3ItT+xrQ5cX+wfniWd4qN8DErB6P6JMuGXsL9XIzBNCuOGzXN/NQF912hpdnB
         R7iDGGuVIrutad7jTVRwWTJghwCxygv3+aL8B8uFoTBKM8C0NEPYJBSJJxFza8WJxhN8
         UUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsiTKNzeT17zlcGBPEflu0BoPiL6YOvxqxu/DTkED3c=;
        b=HA/MiP1pRDPPCXEXSV8fzqNqH5SKjl8gHTCrLKngBn78/+1PdQY2zphvhJGW1IMyGK
         +fu+SwTrV7tYp4IW6tQgiZCyWeYqhXFBFT2Y/DtNXADMiehdk44CNekdANXYHJu8i1pC
         2lfZEGijFq6g4Iwq9liwkCcmUx0TpLw5E2Zs9xnjfoUlTtI7ES2oBKAFACY7ilQ5rE4u
         F7A1MU2A6BaEvzz3UyUqIX65/kYqFSUuML2XL/j/9fAgRfzpg6VZKV7t414VKgWyhSPG
         vQZqX5ZWYg+3/sPPcXcbeE21AjEIIUrOA0M2WEJzGeHK2Z7YlDwWCCAOaCu/saptAopG
         WCXA==
X-Gm-Message-State: AOAM530GMCGVtEwnu6uzEeBe6aQ9MpRiIva7402vZF4wIFnNqOB0hWXc
        TedF38YZ1uXdiOvMLpFWP/IlFaBkuk2Alzs+qvwqRQ==
X-Google-Smtp-Source: ABdhPJy+3CvqU/GPcenNmXENaMK9b6wwBTCbzk8227jknk4mSAb04PfrkSVC1bSF+DRQVYH5SMp0/0bSPgg4P7dEmIQ=
X-Received: by 2002:a05:6a00:22c3:b0:4a0:605:6446 with SMTP id
 f3-20020a056a0022c300b004a006056446mr8526530pfj.27.1638389075912; Wed, 01 Dec
 2021 12:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20211201013329.15875-1-aford173@gmail.com> <CAJ+vNU1jENmWAR_5E98Vgb53ctxjxSWJewPW0YC4Yp4DuYTn3g@mail.gmail.com>
 <7216bc863d89faa9fdc5cd8d44c319f7a6d88159.camel@pengutronix.de>
 <CAJ+vNU2PxgdN414Ufd4NAG5CJgnftNSAHDGpt9Nj+RfgkNmxaw@mail.gmail.com> <ccfc08bbb6ec0debd523bd106e7eff4a747aaa23.camel@pengutronix.de>
In-Reply-To: <ccfc08bbb6ec0debd523bd106e7eff4a747aaa23.camel@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 1 Dec 2021 12:04:24 -0800
Message-ID: <CAJ+vNU3GgwW02VCiqQJhpR_D_fFse42zyWHrB-ETj6V+c4KqtA@mail.gmail.com>
Subject: Re: [RFC V2 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Adam Ford <aford173@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 10:37 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, dem 01.12.2021 um 10:16 -0800 schrieb Tim Harvey:
> > On Wed, Dec 1, 2021 at 9:32 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > Hi Tim,
> > >
> > > Am Mittwoch, dem 01.12.2021 um 09:23 -0800 schrieb Tim Harvey:
> > > > On Tue, Nov 30, 2021 at 5:33 PM Adam Ford <aford173@gmail.com> wrote:
> > > > >
> > > > > The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> > > > > to be related to the video decoders used on the i.MX8MQ, but because of
> > > > > how the Mini handles the power domains, the VPU driver does not need to
> > > > > handle all the functions, nor does it support the post-processor,
> > > > > so a new compatible flag is required.
> > > > >
> > > > > With the suggestion from Hans Verkuil, I was able to get the G2 splat to go away
> > > > > with changes to FORCE_MAX_ZONEORDER, but I found I could also set cma=512M, however
> > > > > it's unclear to me if that's an acceptable alternative.
> > > > >
> > > > > At the suggestion of Ezequiel Garcia and Nicolas Dufresne I have some
> > > > > results from Fluster. However, the G2 VPU appears to fail most tests.
> > > > >
> > > > > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > > > > Ran 90/135 tests successfully               in 76.431 secs
> > > > >
> > > > >  ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > > > > Ran 55/61 tests successfully               in 21.454 secs
> > > > >
> > > > > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > > > > Ran 0/303 tests successfully               in 20.016 secs
> > > > >
> > > > > Each day seems to show more and more G2 submissions, and gstreamer seems to be
> > > > > still working on the VP9, so I am not sure if I should drop G2 as well.
> > > > >
> > > > >
> > > > > Adam Ford (2):
> > > > >   media: hantro: Add support for i.MX8M Mini
> > > > >   arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
> > > > >
> > > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi   | 41 +++++++++++++++
> > > > >  drivers/staging/media/hantro/hantro_drv.c   |  2 +
> > > > >  drivers/staging/media/hantro/hantro_hw.h    |  2 +
> > > > >  drivers/staging/media/hantro/imx8m_vpu_hw.c | 57 +++++++++++++++++++++
> > > > >  4 files changed, 102 insertions(+)
> > > > >
> > > >
> > > > Adam,
> > > >
> > > > That's for the patches!
> > > >
> > > > I tested just this series on top of v5.16-rc3 on an
> > > > imx8mm-venice-gw73xx-0x and found that if I loop fluster I can end up
> > > > getting a hang within 10 to 15 mins or so when imx8m_blk_ctrl_power_on
> > > > is called for VPUMIX pd :
> > > > while [ 1 ]; do uptime; ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0; done
> > > > ...
> > > > [  618.838436] imx-pgc imx-pgc-domain.6: failed to command PGC
> > > > [  618.844407] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
> > > >
> > > > I added prints in imx_pgc_power_{up,down} and
> > > > imx8m_blk_ctrl_power_{on,off} to get some more context
> > > > ...
> > > > Ran 55/61 tests successfully               in 8.685 secs
> > > >  17:16:34 up 17 min,  0 users,  load average: 3.97, 2.11, 0.93
> > > > ********************************************************************************
> > > > ********************
> > > > Running test suite VP8-TEST-VECTORS with decoder GStreamer-VP8-V4L2SL-Gst1.0
> > > > Using 4 parallel job(s)
> > > > ********************************************************************************
> > > > ********************
> > > >
> > > > [TEST SUITE      ] (DECODER                    ) TEST VECTOR               ... R
> > > > ESULT
> > > > ----------------------------------------------------------------------
> > > > [ 1023.114806] imx8m_blk_ctrl_power_on vpublk-g1
> > > > [ 1023.119669] imx_pgc_power_up vpumix
> > > > [ 1023.124307] imx-pgc imx-pgc-domain.6: failed to command PGC
> > > > [ 1023.130006] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
> > > >
> > > > While this wouldn't be an issue with this series it does indicate we
> > > > still have something racy in blk-ctrl. Can you reproduce this (and if
> > > > not what kernel are you based on)? Perhaps you or Lucas have some
> > > > ideas?
> > > >
> > > Did you have "[PATCH] soc: imx: gpcv2: Synchronously suspend MIX
> > > domains" applied when running those tests? It has only recently been
> > > picked up by Shawn and may have an influence on the bus domain
> > > behavior.
> > >
> >
> > Lucas,
> >
> > Good point. I did have that originally before I started pruning down
> > to the bare minimum to reproduce the issue.
> >
> > I added it back and now I have the following:
> > arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
> > media: hantro: Add support for i.MX8M Mini
> > soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
> > soc: imx: gpcv2: Synchronously suspend MIX domains
> > Linux 5.16-rc3
> >
> > Here's the latest with that patch:
> > ...
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-007 ... Success
> > [  316.632373] imx8m_blk_ctrl_power_off vpublk-g1
> > [  316.636908] imx_pgc_power_down vpu-g1
> > [  316.640983] imx_pgc_power_down vpumix
> > [  316.756869] imx8m_blk_ctrl_power_on vpublk-g1
> > [  316.761360] imx_pgc_power_up vpumix
> > [  316.765985] imx-pgc imx-pgc-domain.6: failed to command PGC
> > [  316.772743] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain
> > ^^^ hang
>
> Hm, I wonder if there's some broken error handling here somewhere, as a
> failure to power up a domain shouldn't lead to a hang.
>
> However, that doesn't explain why the PGC isn't completing the request.
> Can you try to extend the timeout some more. Even though I think that
> 1msec should already be generous. Can you dump the content of the
> GPC_PU_PGC_SW_PUP_REQ and GPC_A53_PU_PGC_PUP_STATUSn (all 3 of them)
> registers, when the failure condition is hit?
>

Adam,

Adding keep_clocks=true to VPUG1/VPUG2 domains did not help

Lucas,

I bumped the regmap_read_poll_timeout timeouts from 1m to 100ms and
still saw the same issue.

Here's some added debugging to show the regs:
[  648.037903] imx8m_blk_ctrl_power_on vpublk-g1
[  648.042346] imx_pgc_power_up vpumix
[  648.146178] imx-pgc imx-pgc-domain.6: imx_pgc_power_up: failed to command PGC
[  648.153355] imx-pgc imx-pgc-domain.6: GPC_PU_PGC_SW_PUP_REQ(0x0f8)=0x00000100
[  648.162339] imx-pgc imx-pgc-domain.6:
GPC_A53_PU_PGC_PUP_STATUS0(0x14c)=0x00000000
[  648.169988] imx-pgc imx-pgc-domain.6:
GPC_A53_PU_PGC_PUP_STATUS1(0x150)=0x00000000
[  648.177618] imx-pgc imx-pgc-domain.6:
GPC_A53_PU_PGC_PUP_STATUS2(0x154)=0x00000000
[  648.185281] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 8176380b02e6..8124a3434655 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -67,6 +67,9 @@

 #define GPC_PU_PGC_SW_PUP_REQ          0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ          0x104
+#define GPC_A53_PU_PGC_PUP_STATUS0     0x14c
+#define GPC_A53_PU_PGC_PUP_STATUS1     0x150
+#define GPC_A53_PU_PGC_PUP_STATUS2     0x154

 #define IMX7_USB_HSIC_PHY_SW_Pxx_REQ           BIT(4)
 #define IMX7_USB_OTG2_PHY_SW_Pxx_REQ           BIT(3)
@@ -224,6 +227,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
        u32 reg_val, pgc;
        int ret;

+printk("%s %s\n", __func__, genpd->name);
        ret = pm_runtime_get_sync(domain->dev);
        if (ret < 0) {
                pm_runtime_put_noidle(domain->dev);
@@ -258,9 +262,17 @@ static int imx_pgc_power_up(struct
generic_pm_domain *genpd)
                ret = regmap_read_poll_timeout(domain->regmap,
                                               GPC_PU_PGC_SW_PUP_REQ, reg_val,
                                               !(reg_val & domain->bits.pxx),
-                                              0, USEC_PER_MSEC);
+                                              0, 100 * USEC_PER_MSEC);
                if (ret) {
-                       dev_err(domain->dev, "failed to command PGC\n");
+                       dev_err(domain->dev, "%s: failed to command
PGC\n", __func__);
+                       if (!regmap_read(domain->regmap,
GPC_PU_PGC_SW_PUP_REQ, &reg_val))
+                               dev_err(domain->dev,
"GPC_PU_PGC_SW_PUP_REQ(0x%03x)=0x%08x\n", GPC_PU_PGC_SW_PUP_REQ,
reg_val);
+                       if (!regmap_read(domain->regmap,
GPC_A53_PU_PGC_PUP_STATUS0, &reg_val))
+                               dev_err(domain->dev,
"GPC_A53_PU_PGC_PUP_STATUS0(0x%03x)=0x%08x\n",
GPC_A53_PU_PGC_PUP_STATUS0, reg_val);
+                       if (!regmap_read(domain->regmap,
GPC_A53_PU_PGC_PUP_STATUS1, &reg_val))
+                               dev_err(domain->dev,
"GPC_A53_PU_PGC_PUP_STATUS1(0x%03x)=0x%08x\n",
GPC_A53_PU_PGC_PUP_STATUS1, reg_val);
+                       if (!regmap_read(domain->regmap,
GPC_A53_PU_PGC_PUP_STATUS2, &reg_val))
+                               dev_err(domain->dev,
"GPC_A53_PU_PGC_PUP_STATUS2(0x%03x)=0x%08x\n",
GPC_A53_PU_PGC_PUP_STATUS2, reg_val);
                        goto out_clk_disable;
                }

@@ -318,6 +330,7 @@ static int imx_pgc_power_down(struct
generic_pm_domain *genpd)
        u32 reg_val, pgc;
        int ret;

+printk("%s %s\n", __func__, genpd->name);
        /* Enable reset clocks for all devices in the domain */
        if (!domain->keep_clocks) {
                ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
@@ -335,7 +348,7 @@ static int imx_pgc_power_down(struct
generic_pm_domain *genpd)
                ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
                                               reg_val,
                                               !(reg_val & domain->bits.hskack),
-                                              0, USEC_PER_MSEC);
+                                              0, 100 * USEC_PER_MSEC);
                if (ret) {
                        dev_err(domain->dev, "failed to power down ADB400\n");
                        goto out_clk_disable;
@@ -359,9 +372,9 @@ static int imx_pgc_power_down(struct
generic_pm_domain *genpd)
                ret = regmap_read_poll_timeout(domain->regmap,
                                               GPC_PU_PGC_SW_PDN_REQ, reg_val,
                                               !(reg_val & domain->bits.pxx),
-                                              0, USEC_PER_MSEC);
+                                              0, 100 * USEC_PER_MSEC);
                if (ret) {
-                       dev_err(domain->dev, "failed to command PGC\n");
+                       dev_err(domain->dev, "%s: failed to command
PGC\n", __func__);
                        goto out_clk_disable;
                }
        }
@@ -712,6 +725,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
                        .map = IMX8MM_VPUG1_A53_DOMAIN,
                },
                .pgc   = BIT(IMX8MM_PGC_VPUG1),
+               .keep_clocks = true,
        },

        [IMX8MM_POWER_DOMAIN_VPUG2] = {
@@ -723,6 +737,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
                        .map = IMX8MM_VPUG2_A53_DOMAIN,
                },
                .pgc   = BIT(IMX8MM_PGC_VPUG2),
+               .keep_clocks = true,
        },

        [IMX8MM_POWER_DOMAIN_VPUH1] = {
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 519b3651d1d9..028f38d45892 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -68,6 +68,7 @@ static int imx8m_blk_ctrl_power_on(struct
generic_pm_domain *genpd)
        struct imx8m_blk_ctrl *bc = domain->bc;
        int ret;

+printk("%s %s\n", __func__, genpd->name);
        /* make sure bus domain is awake */
        ret = pm_runtime_get_sync(bc->bus_power_dev);
        if (ret < 0) {
@@ -119,6 +120,7 @@ static int imx8m_blk_ctrl_power_off(struct
generic_pm_domain *genpd)
        const struct imx8m_blk_ctrl_domain_data *data = domain->data;
        struct imx8m_blk_ctrl *bc = domain->bc;

+printk("%s %s\n", __func__, genpd->name);
        /* put devices into reset and disable clocks */
        regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
        regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);

Tim
