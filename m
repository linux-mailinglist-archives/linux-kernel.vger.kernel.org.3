Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17F549A45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbiFMRl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343663AbiFMRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:40:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF424BF5;
        Mon, 13 Jun 2022 06:10:08 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 042A26601651;
        Mon, 13 Jun 2022 14:10:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655125806;
        bh=6vF8s+UbRt6Gj72cipVKdeSnrHKaavGuFSFrj0y8Qyk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gYaFL4YV1hbahCLrfOYCLs8VE06FaI00oHYOg6l67EH7Rewz9HUMeeSqjs3TbBJVD
         GQwgzsplZ26MDGkDPqZhpu0EPDWNTQuBRDj6WZrF1QgzQXJwBMo3CL/nUARBREV5ij
         55L2ycdQJGmu7hopOtMCu+6yJ8+opBNMTneFL11TuJLQccJ3TiRgav7HXWq5nG8273
         7uw7HPR8U02+ctrUfm/x7mdok6xl0eIrfSsFgDRVdadclxMklgqHhXV4Y9OMje6yLO
         luAQqoXEK+aUl25/rtqiycd9L4Y2rPj4OkoU2npTPAva5+DAXGTinIy2AZjSODVKQ8
         wfpm2F3Pn/Xng==
Message-ID: <c9ecb36f3490326f67ff84515a8aee4d264e4361.camel@collabora.com>
Subject: Re: [PATCH v1 4/5] media: rkvdec: Re-enable H.264 error detection
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Alex Bee <knaerzche@gmail.com>, linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jun 2022 09:09:56 -0400
In-Reply-To: <8efa6811-ee17-4dd2-23a7-e0471af8c0a6@gmail.com>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
         <20220610125215.240539-5-nicolas.dufresne@collabora.com>
         <8efa6811-ee17-4dd2-23a7-e0471af8c0a6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 11 juin 2022 =C3=A0 14:08 +0200, Alex Bee a =C3=A9crit=C2=A0:
> Am 10.06.22 um 14:52 schrieb Nicolas Dufresne:
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
> > =20
> >  	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000))=
;
> > =20
> > -	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > -	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> > +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> >  	writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
> >  	writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
> > =20
> >  	/* Start decoding! */
> >  	writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
> > -	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
> > +	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
> > +	       RKVDEC_H264ORVP9_ERR_MODE,
> >  	       rkvdec->regs + RKVDEC_REG_INTERRUPT);
> > =20
> >  	return 0;
> > @@ -1196,10 +1197,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_c=
tx *ctx, struct v4l2_ctrl *ctrl)
> >  	return 0;
> >  }
> > =20
> > +static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
> > +{
> > +	struct rkvdec_dev *rkvdec =3D ctx->dev;
> > +	int err;
> > +
> > +	err =3D readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
> > +	if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
> > +		pr_debug("Decoded picture have %i/%i slices with errors.\n",
> > +			 RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(err));
> > +		return VB2_BUF_STATE_ERROR;
> > +	}
> > +
> > +	return VB2_BUF_STATE_DONE;
> > +}
> > +
> >  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops =3D {
> >  	.adjust_fmt =3D rkvdec_h264_adjust_fmt,
> >  	.start =3D rkvdec_h264_start,
> >  	.stop =3D rkvdec_h264_stop,
> >  	.run =3D rkvdec_h264_run,
> >  	.try_ctrl =3D rkvdec_h264_try_ctrl,
> > +	.check_error_info =3D rkvdec_h264_check_error_info,
> >  };
>=20
> Actually I'm not sure I fully understand what you are expecting the
> userspace to do with the information that there was an (HW!) error,
> which might or might not be bitstrean related. Resending the
> corrupted(?) frame until the HW fully hangs?
> As the interrupt reports an HW error it should (at least also) be
> handled driver-side and the HW is known not to be able to fully reset
> itself in case of an error.
> I think this will make behavior worse than it is now (for real-life
> users) where errors are eventually just ignored.

I've changed the decoding mode, see bit 19 or swreg1. In that mode, the dec=
oder
will behave just like if error detection was off. It will just keep going a=
nd
produce "something". With the set of corrupted streams we had, we found tha=
t the
decoder no longer get stuck, and we are aware of the possibly corrupted buf=
fers.
In current mode, the decoder tries to stop as soon as an error is met, whic=
h
most of the time means nothing is every written to the buffer. And as you
mention, it often fail at "self reset".

In streaming there is two style of handling corrupted buffers, one is to sk=
ip
until valid state, and the other is to show them even if corrupted. In stac=
k
like GStreamer we just flag the corrupted frames based on the ERROR flag (u=
nless
payload size is 0) and let the user chose to drop them or not.


> I think this will make behavior worse than it is now (for real-life users=
)
where errors are eventually just ignored.

Just ignoring the errors is way better then an infinite row of errors. At t=
he
moment, FFMPEG/Chromium and GStreamer ignores errors indeed. I got some wor=
k in
progress patch in GStreamer I've used to test this, but its not ready yet. =
In
the current behaviour, if you hit an error, you basically have 9 chances ou=
t of
10 to keep replaying ancient buffers in loop till the end of time. This is
because the self reset never completes, and you get the same error over and=
 over
regardless what you pass to the decoder.

regards,
Nicolas

p.s. the tests should land (if not already) in ChromeOS taste suite.

>=20
> Alex

