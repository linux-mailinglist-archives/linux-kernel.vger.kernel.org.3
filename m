Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616DA46BD0C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhLGOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhLGOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:00:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF7C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:56:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1muaxP-0005p8-6r; Tue, 07 Dec 2021 14:56:35 +0100
Message-ID: <6e41beec102951ea057ba1af02ef4aaad40bd0dc.camel@pengutronix.de>
Subject: Re: [RFC V2 5/6] media: hantro: split i.MX8MQ G1 and G2 code
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media <linux-media@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Date:   Tue, 07 Dec 2021 14:56:32 +0100
In-Reply-To: <CAHCN7xL3JgmEf=H9UueFLYpnGqraRYUu3yYSTqn_JNi8tPnOfQ@mail.gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
         <20211207015446.1250854-6-aford173@gmail.com> <Ya9V7Kwa8MICeS34@eze-laptop>
         <CAHCN7xJ9kTdTmhbSwwNCCivRdTULO494CEj0eVkfPfqbPqNPvA@mail.gmail.com>
         <d82868b7dbc2953c6022165488e822699f7240c5.camel@pengutronix.de>
         <CAHCN7xL3JgmEf=H9UueFLYpnGqraRYUu3yYSTqn_JNi8tPnOfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 07.12.2021 um 07:50 -0600 schrieb Adam Ford:
> On Tue, Dec 7, 2021 at 7:41 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Am Dienstag, dem 07.12.2021 um 07:24 -0600 schrieb Adam Ford:
> > > On Tue, Dec 7, 2021 at 6:39 AM Ezequiel Garcia
> > > <ezequiel@vanguardiasur.com.ar> wrote:
> > > > 
> > > > Hi Adam,
> > > > 
> > > > Thanks for the good work! This is looking quite promising.
> > > > 
> > > > On Mon, Dec 06, 2021 at 07:54:44PM -0600, Adam Ford wrote:
> > > > > The VPU in the i.MX8MQ is really the combination of Hantro G1 and
> > > > > Hantro G2. With the updated vpu-blk-ctrl, the power domains system
> > > > > can enable and disable them separately as well as pull them out of
> > > > > reset. This simplifies the code and lets them run independently.
> > > > > 
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > 
> > > > > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > > > > index ab2467998d29..d803252a5aba 100644
> > > > > --- a/drivers/staging/media/hantro/hantro_drv.c
> > > > > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > > > > @@ -608,8 +608,8 @@ static const struct of_device_id of_hantro_match[] = {
> > > > >       { .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
> > > > >  #endif
> > > > >  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> > > > > -     { .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
> > > > > -     { .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
> > > > > +     { .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant, },
> > > > 
> > > > I think it's important to clarify that you are breaking support
> > > > for the previous device-tree binding. Not only because of the compatible
> > > > string change, but because the binding is now quite different.
> > > > 
> > > > Note that in the past Benjamin tried to avoid this.
> > > > IIRC, his proposal was backwards compatible.
> > > 
> > > I was looking at how to do this, but the stand-alone vpu bindings did
> > > the reset and the fuses manually, it causes issues.  When the block
> > > control is enabled those memory locations for the resets and fuses are
> > > assigned to the blk-ctrl driver, so attempting to access them from a
> > > different driver was a violation.
> > > 
> > > When I started looking at this, the stand-alone VPU was trying to be
> > > both G1 and G2, but when I was testing it before I made changes, I
> > > didn't see the G2 function at all. When I was done the G2 seemed to
> > > work, so it seems like this is an improvement.  If you want me to keep
> > > the previous compatible flag, I could rename the nxp,imx8mq-vpu-g1
> > > back to nxp,imx8mq-vpu and remove the reset/fuse controls, but I'd
> > > have to add the blk-ctrl reference, so it seemed to me like a better
> > > alternative to deprecate the old binding/driver and replace it with
> > > the new one because of the significant changes.  Since I'd like to
> > > rebase the i.MX8M Mini I did on this work, it seemed weird to have
> > > nxp,imx8mq-vpu, nxp,imx8mq-vpu-g2, nxp,imx8mm-vpu-g1, and
> > > nxp,imx8mm-vpu-g2 where the only one without a Gx name was the
> > > original 8MQ binding but limited to G1 functionality and the G2
> > > stripped out.
> > 
> > I would very much appreciate if we could keep the driver code for the
> > old binding. It does not need to have any new additional functionality,
> > but just keep the existing G1 h.264 decode when booted on a old DT with
> > the old VPU description and no blk-ctrl, so we don't regress
> > functionality when a new kernel is booted with a old DT.
> > 
> > New functionality with the G2 can depend on the new VPU binding and the
> > blk-ctrl driver.
> 
> How does that work when both the original VPU and the blk-ctrl attempt
> to manipulate the reset and clock lines?  The original binding for the
> vpu was assigned:
> 
> reg = <0x38300000 0x10000>,
>           <0x38310000 0x10000>,
>           <0x38320000 0x10000>;
> reg-names = "g1", "g2", "ctrl";
> 
> If G2 is going to run from 38310000 and vpu-blk-ctrl run from
> 38320000, they'll collide.
> 
It's not going to work, but it also doesn't have to. Either you have a
old DT where the VPU driver will poke the blk-ctrl registers, but no
blk-ctrl driver, or you have a new DT where the VPU driver leaves the
blk-ctrl region alone and the blk-ctrl driver needs to handle it.

Just don't support mixing the old VPU DT binding with the new blk-ctrl
way of doing things. The only thing that needs to keep working is a
unchannged old DT, where the VPU uses the old binding, but no blk-ctrl
is present as a separate node.

Regards,
Lucas
> 
> > 
> > Regards,
> > Lucas
> > 
> > > > 
> > > > If this is unavoidable, due to how the blk-ctrl is handled, then that's
> > > > fine. Given it's a staging driver, we can still play these games.
> > > > 
> > > > Having said that, let's please make this very clear in the commit
> > > > description, to it's clear for developers forward-porting their kernels.
> > > > This applies not only to this commit, but to all commits that affect
> > > > the binding.
> > > 
> > > When I post the formal patch, I will add a note that this explicitly
> > > deprecates the old bindings due to the fact that the G1 and G2 are
> > > separate IP blocks in the reference manual, and blk-ctrl is a
> > > completely separate driver altogether.
> > > 
> > > > 
> > > > Thanks!
> > > > Ezequiel
> > > > 
> > > > > +     { .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant, },
> > > > >  #endif
> > > > >  #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
> > > > >       { .compatible = "microchip,sama5d4-vdec", .data = &sama5d4_vdec_variant, },
> > > > > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> > > > > index cff817ca8d22..122b83a16663 100644
> > > > > --- a/drivers/staging/media/hantro/hantro_hw.h
> > > > > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > > > > @@ -299,8 +299,8 @@ enum hantro_enc_fmt {
> > > > >       ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
> > > > >  };
> > > > > 
> > > > > +extern const struct hantro_variant imx8mq_vpu_g1_variant;
> > > > >  extern const struct hantro_variant imx8mq_vpu_g2_variant;
> > > > > -extern const struct hantro_variant imx8mq_vpu_variant;
> > > > >  extern const struct hantro_variant px30_vpu_variant;
> > > > >  extern const struct hantro_variant rk3036_vpu_variant;
> > > > >  extern const struct hantro_variant rk3066_vpu_variant;
> > > > > diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > > index 1a43f6fceef9..c9f6e8472258 100644
> > > > > --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > > +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > > @@ -13,67 +13,6 @@
> > > > >  #include "hantro_g1_regs.h"
> > > > >  #include "hantro_g2_regs.h"
> > > > > 
> > > > > -#define CTRL_SOFT_RESET              0x00
> > > > > -#define RESET_G1             BIT(1)
> > > > > -#define RESET_G2             BIT(0)
> > > > > -
> > > > > -#define CTRL_CLOCK_ENABLE    0x04
> > > > > -#define CLOCK_G1             BIT(1)
> > > > > -#define CLOCK_G2             BIT(0)
> > > > > -
> > > > > -#define CTRL_G1_DEC_FUSE     0x08
> > > > > -#define CTRL_G1_PP_FUSE              0x0c
> > > > > -#define CTRL_G2_DEC_FUSE     0x10
> > > > > -
> > > > > -static void imx8m_soft_reset(struct hantro_dev *vpu, u32 reset_bits)
> > > > > -{
> > > > > -     u32 val;
> > > > > -
> > > > > -     /* Assert */
> > > > > -     val = readl(vpu->ctrl_base + CTRL_SOFT_RESET);
> > > > > -     val &= ~reset_bits;
> > > > > -     writel(val, vpu->ctrl_base + CTRL_SOFT_RESET);
> > > > > -
> > > > > -     udelay(2);
> > > > > -
> > > > > -     /* Release */
> > > > > -     val = readl(vpu->ctrl_base + CTRL_SOFT_RESET);
> > > > > -     val |= reset_bits;
> > > > > -     writel(val, vpu->ctrl_base + CTRL_SOFT_RESET);
> > > > > -}
> > > > > -
> > > > > -static void imx8m_clk_enable(struct hantro_dev *vpu, u32 clock_bits)
> > > > > -{
> > > > > -     u32 val;
> > > > > -
> > > > > -     val = readl(vpu->ctrl_base + CTRL_CLOCK_ENABLE);
> > > > > -     val |= clock_bits;
> > > > > -     writel(val, vpu->ctrl_base + CTRL_CLOCK_ENABLE);
> > > > > -}
> > > > > -
> > > > > -static int imx8mq_runtime_resume(struct hantro_dev *vpu)
> > > > > -{
> > > > > -     int ret;
> > > > > -
> > > > > -     ret = clk_bulk_prepare_enable(vpu->variant->num_clocks, vpu->clocks);
> > > > > -     if (ret) {
> > > > > -             dev_err(vpu->dev, "Failed to enable clocks\n");
> > > > > -             return ret;
> > > > > -     }
> > > > > -
> > > > > -     imx8m_soft_reset(vpu, RESET_G1 | RESET_G2);
> > > > > -     imx8m_clk_enable(vpu, CLOCK_G1 | CLOCK_G2);
> > > > > -
> > > > > -     /* Set values of the fuse registers */
> > > > > -     writel(0xffffffff, vpu->ctrl_base + CTRL_G1_DEC_FUSE);
> > > > > -     writel(0xffffffff, vpu->ctrl_base + CTRL_G1_PP_FUSE);
> > > > > -     writel(0xffffffff, vpu->ctrl_base + CTRL_G2_DEC_FUSE);
> > > > > -
> > > > > -     clk_bulk_disable_unprepare(vpu->variant->num_clocks, vpu->clocks);
> > > > > -
> > > > > -     return 0;
> > > > > -}
> > > > > -
> > > > >  /*
> > > > >   * Supported formats.
> > > > >   */
> > > > > @@ -209,27 +148,6 @@ static irqreturn_t imx8m_vpu_g2_irq(int irq, void *dev_id)
> > > > >       return IRQ_HANDLED;
> > > > >  }
> > > > > 
> > > > > -static int imx8mq_vpu_hw_init(struct hantro_dev *vpu)
> > > > > -{
> > > > > -     vpu->ctrl_base = vpu->reg_bases[vpu->variant->num_regs - 1];
> > > > > -
> > > > > -     return 0;
> > > > > -}
> > > > > -
> > > > > -static void imx8m_vpu_g1_reset(struct hantro_ctx *ctx)
> > > > > -{
> > > > > -     struct hantro_dev *vpu = ctx->dev;
> > > > > -
> > > > > -     imx8m_soft_reset(vpu, RESET_G1);
> > > > > -}
> > > > > -
> > > > > -static void imx8m_vpu_g2_reset(struct hantro_ctx *ctx)
> > > > > -{
> > > > > -     struct hantro_dev *vpu = ctx->dev;
> > > > > -
> > > > > -     imx8m_soft_reset(vpu, RESET_G2);
> > > > > -}
> > > > > -
> > > > >  /*
> > > > >   * Supported codec ops.
> > > > >   */
> > > > > @@ -237,19 +155,16 @@ static void imx8m_vpu_g2_reset(struct hantro_ctx *ctx)
> > > > >  static const struct hantro_codec_ops imx8mq_vpu_codec_ops[] = {
> > > > >       [HANTRO_MODE_MPEG2_DEC] = {
> > > > >               .run = hantro_g1_mpeg2_dec_run,
> > > > > -             .reset = imx8m_vpu_g1_reset,
> > > > >               .init = hantro_mpeg2_dec_init,
> > > > >               .exit = hantro_mpeg2_dec_exit,
> > > > >       },
> > > > >       [HANTRO_MODE_VP8_DEC] = {
> > > > >               .run = hantro_g1_vp8_dec_run,
> > > > > -             .reset = imx8m_vpu_g1_reset,
> > > > >               .init = hantro_vp8_dec_init,
> > > > >               .exit = hantro_vp8_dec_exit,
> > > > >       },
> > > > >       [HANTRO_MODE_H264_DEC] = {
> > > > >               .run = hantro_g1_h264_dec_run,
> > > > > -             .reset = imx8m_vpu_g1_reset,
> > > > >               .init = hantro_h264_dec_init,
> > > > >               .exit = hantro_h264_dec_exit,
> > > > >       },
> > > > > @@ -258,14 +173,12 @@ static const struct hantro_codec_ops imx8mq_vpu_codec_ops[] = {
> > > > >  static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
> > > > >       [HANTRO_MODE_HEVC_DEC] = {
> > > > >               .run = hantro_g2_hevc_dec_run,
> > > > > -             .reset = imx8m_vpu_g2_reset,
> > > > >               .init = hantro_hevc_dec_init,
> > > > >               .exit = hantro_hevc_dec_exit,
> > > > >       },
> > > > >       [HANTRO_MODE_VP9_DEC] = {
> > > > >               .run = hantro_g2_vp9_dec_run,
> > > > >               .done = hantro_g2_vp9_dec_done,
> > > > > -             .reset = imx8m_vpu_g2_reset,
> > > > >               .init = hantro_vp9_dec_init,
> > > > >               .exit = hantro_vp9_dec_exit,
> > > > >       },
> > > > > @@ -275,7 +188,7 @@ static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
> > > > >   * VPU variants.
> > > > >   */
> > > > > 
> > > > > -static const struct hantro_irq imx8mq_irqs[] = {
> > > > > +static const struct hantro_irq imx8mq_g1_irqs[] = {
> > > > >       { "g1", imx8m_vpu_g1_irq },
> > > > >  };
> > > > > 
> > > > > @@ -283,10 +196,12 @@ static const struct hantro_irq imx8mq_g2_irqs[] = {
> > > > >       { "g2", imx8m_vpu_g2_irq },
> > > > >  };
> > > > > 
> > > > > -static const char * const imx8mq_clk_names[] = { "g1", "g2", "bus" };
> > > > > -static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
> > > > > +static const char * const imx8mq_g1_clk_names[] = { "g1" };
> > > > > +static const char * const imx8mq_g1_reg_names[] = { "g1" };
> > > > > +static const char * const imx8mq_g2_clk_names[] = { "g2" };
> > > > > +static const char * const imx8mq_g2_reg_names[] = { "g2" };
> > > > > 
> > > > > -const struct hantro_variant imx8mq_vpu_variant = {
> > > > > +const struct hantro_variant imx8mq_vpu_g1_variant = {
> > > > >       .dec_fmts = imx8m_vpu_dec_fmts,
> > > > >       .num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
> > > > >       .postproc_fmts = imx8m_vpu_postproc_fmts,
> > > > > @@ -295,14 +210,12 @@ const struct hantro_variant imx8mq_vpu_variant = {
> > > > >       .codec = HANTRO_MPEG2_DECODER | HANTRO_VP8_DECODER |
> > > > >                HANTRO_H264_DECODER,
> > > > >       .codec_ops = imx8mq_vpu_codec_ops,
> > > > > -     .init = imx8mq_vpu_hw_init,
> > > > > -     .runtime_resume = imx8mq_runtime_resume,
> > > > > -     .irqs = imx8mq_irqs,
> > > > > -     .num_irqs = ARRAY_SIZE(imx8mq_irqs),
> > > > > -     .clk_names = imx8mq_clk_names,
> > > > > -     .num_clocks = ARRAY_SIZE(imx8mq_clk_names),
> > > > > -     .reg_names = imx8mq_reg_names,
> > > > > -     .num_regs = ARRAY_SIZE(imx8mq_reg_names)
> > > > > +     .irqs = imx8mq_g1_irqs,
> > > > > +     .num_irqs = ARRAY_SIZE(imx8mq_g1_irqs),
> > > > > +     .clk_names = imx8mq_g1_clk_names,
> > > > > +     .num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
> > > > > +     .reg_names = imx8mq_g1_reg_names,
> > > > > +     .num_regs = ARRAY_SIZE(imx8mq_g1_reg_names),
> > > > >  };
> > > > > 
> > > > >  const struct hantro_variant imx8mq_vpu_g2_variant = {
> > > > > @@ -314,10 +227,10 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
> > > > >       .postproc_ops = &hantro_g2_postproc_ops,
> > > > >       .codec = HANTRO_HEVC_DECODER | HANTRO_VP9_DECODER,
> > > > >       .codec_ops = imx8mq_vpu_g2_codec_ops,
> > > > > -     .init = imx8mq_vpu_hw_init,
> > > > > -     .runtime_resume = imx8mq_runtime_resume,
> > > > >       .irqs = imx8mq_g2_irqs,
> > > > >       .num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
> > > > > -     .clk_names = imx8mq_clk_names,
> > > > > -     .num_clocks = ARRAY_SIZE(imx8mq_clk_names),
> > > > > +     .clk_names = imx8mq_g2_clk_names,
> > > > > +     .num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
> > > > > +     .reg_names = imx8mq_g2_reg_names,
> > > > > +     .num_regs = ARRAY_SIZE(imx8mq_g2_reg_names),
> > > > >  };
> > > > > --
> > > > > 2.32.0
> > > > > 
> > 
> > 


