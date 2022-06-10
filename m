Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F54546AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349783AbiFJQio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349839AbiFJQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:38:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12B5995C;
        Fri, 10 Jun 2022 09:38:36 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08E4D660172B;
        Fri, 10 Jun 2022 17:38:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654879114;
        bh=hp2gpcoxc1L1t8wOVnHFtGzaBF7lMMf2WNxZjV6zYgM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F41jVeJokGk1hhiSW1+tW6PCI1j3GAOJWAJfYoahkz5x45dk4JR4jJ+qXu5P8wNHT
         3IAfU69kP4ohOwsn45pMzXodDXDNuQH61UOqQ+hJifk9GWe/uN9au8uiHfqrE/VLMM
         c0U21ESFIzCPrFJT9m5Iyqbd5NFQECUKGNm+oMj53FZzHwnWqA9t1tkLs3IWfklACm
         ZbP5ujWXI35j9SimuIbhj6pXU1a8WrJFBUgJWTDRcrd3LMP2znB4DYHnjyGuROro6M
         uDpBSNg3V40ET4zsMLpP7bVi2FVBJPORORz+RUsV47Ost1ChlF9nc7Sv9H/IKGLAqF
         YVEL81r24tCDg==
Message-ID: <16e50526255d585bcd5c863755ebb423466d53ff.camel@collabora.com>
Subject: Re: [PATCH v1 4/5] media: rkvdec: Re-enable H.264 error detection
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Jun 2022 12:38:24 -0400
In-Reply-To: <CAAEAJfAdPt59oCi4wPybwn0a4zHq_3x66L5mRSQ54yQezz+ZZA@mail.gmail.com>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
         <20220610125215.240539-5-nicolas.dufresne@collabora.com>
         <CAAEAJfAdPt59oCi4wPybwn0a4zHq_3x66L5mRSQ54yQezz+ZZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 10 juin 2022 =C3=A0 12:01 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> Hi Nicolas,
>=20
> Great stuff! See below for some ideas how to expose errors.
>=20
> On Fri, Jun 10, 2022 at 9:52 AM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >=20
> > This re-enables H.264 error detection, but using the other error mode.
> > In that mode, the decoder will skip over the error macro-block or
> > slices and complete the decoding. As a side effect, the error status
> > is not set in the interrupt status register, and instead errors are
> > detected per format. Using this mode workaround the issue that the
> > HW get stuck in error stated and allow reporting that some corruption
> > may be present in the buffer returned to userland.
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/stagi=
ng/media/rkvdec/rkvdec-h264.c
> > index 55596ce6bb6e..60a89918e2c1 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -1175,14 +1175,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *c=
tx)
> >=20
> >         schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(=
2000));
> >=20
> > -       writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > -       writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> > +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> >         writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
> >         writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
> >=20
> >         /* Start decoding! */
> >         writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
> > -              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
> > +              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
> > +              RKVDEC_H264ORVP9_ERR_MODE,
> >                rkvdec->regs + RKVDEC_REG_INTERRUPT);
> >=20
> >         return 0;
> > @@ -1196,10 +1197,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_c=
tx *ctx, struct v4l2_ctrl *ctrl)
> >         return 0;
> >  }
> >=20
> > +static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
> > +{
> > +       struct rkvdec_dev *rkvdec =3D ctx->dev;
> > +       int err;
> > +
> > +       err =3D readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
> > +       if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
> > +               pr_debug("Decoded picture have %i/%i slices with errors=
.\n",
> > +                        RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(e=
rr));
>=20
> It's more useful friendly to just keep a counter somewhere. In the past,
> we've created a user control, which has the advantage of leveraging
> an existing mechanism, and already being per-fd.
>=20
> See:
>=20
> commit b2d3bef1aa7858b2ae5e0d01adb214121ba00b9f
> "media: coda: Add a V4L2 user for control error macroblocks count".
>=20
> I would drop the pr_debug, or if you think it's really useful for users
> and developers, go with v4l2_dbg. In which case, how do you ensure
> a corrupted stream won't flood the logs?

There is no use case to make this a control, but yes, a corrupted stream ca=
n
flood, but isn't the point of pr_debug() that it won't show if you don't en=
abled
it ?

As for v4l2_dbg I'm not familiar with that and its not used in this driver =
for
traces. I've use pr_debug for reference list tracing previously and floodin=
g was
not considered a problem despite being a per-frame trace. You can even out-
compile these if you need to.

Let me know if you have further rationale in the suggestion direction. The
rationale in my coding for such trace is that if I read 1 bit of a register=
, and
trace the surrounding value, I can validate (as a human) that the rest of t=
he
register isn't complete garbage, and that I'm not basically reading a rando=
m
bit. Leaving the trace there, allow other developer on other variant of the=
se
SoC to also notice if that register becomes garbage. This is in contrast of=
 just
telling others "trust me, I tested it".

Nicolas

>=20
> Thanks,
> Ezequiel
>=20
>=20
> > +               return VB2_BUF_STATE_ERROR;
> > +       }
> > +
> > +       return VB2_BUF_STATE_DONE;
> > +}
> > +
> >  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops =3D {
> >         .adjust_fmt =3D rkvdec_h264_adjust_fmt,
> >         .start =3D rkvdec_h264_start,
> >         .stop =3D rkvdec_h264_stop,
> >         .run =3D rkvdec_h264_run,
> >         .try_ctrl =3D rkvdec_h264_try_ctrl,
> > +       .check_error_info =3D rkvdec_h264_check_error_info,
> >  };
> > --
> > 2.36.1
> >=20

