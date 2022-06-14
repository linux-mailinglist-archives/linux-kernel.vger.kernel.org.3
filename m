Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C984854B5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiFNQPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357081AbiFNQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:15:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE2C393D1;
        Tue, 14 Jun 2022 09:14:58 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0749866015D7;
        Tue, 14 Jun 2022 17:14:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655223297;
        bh=v1oVMG8D/TcLecVQ+c4GKl6+Ukw1Is0dn6GvtnEkISg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W4VeWv0nm+oDDfqZcEv6yfok1w2Hs2fCLK9Ii52uXYaSGHd0trXIq40lS2QB+W7XV
         w+1UbfMWtydh/+IdJkElC07injuWO/FOQ1KD6nkRYrBW/mR2BbqCK2WkzxScUqJNnd
         o3cqeAsIJaMFaY8q9Q4f5eL7wh5r6rQALkmzzPrXKyXBt3HZEbAmuOzMIgDjf/I04U
         qO8DeoLY0AGLA41mvyj9VbmjoJinqsBndmsK/ik1qddG+L/z0wETtE8kyAzUSxhKW5
         0IkdtonfvXbnz1Prl+urYtL0JQnM3t0uDFIBn4DYwG3zHEFrgG3HIEiNChwX2qNlR+
         tvDyQZZ3s1FAA==
Message-ID: <46211420a76c7608c34cd6b3569f41accdfd08a1.camel@collabora.com>
Subject: Re: [PATCH v1 2/5] media: rkvdec: Add an ops to check for decode
 errors
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jun 2022 12:14:47 -0400
In-Reply-To: <fed8b2cf-3098-0690-dc40-796dbe0ff424@xs4all.nl>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
         <20220610125215.240539-3-nicolas.dufresne@collabora.com>
         <fed8b2cf-3098-0690-dc40-796dbe0ff424@xs4all.nl>
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

Le mardi 14 juin 2022 =C3=A0 16:44 +0200, Hans Verkuil a =C3=A9crit=C2=A0:
> On 6/10/22 14:52, Nicolas Dufresne wrote:
> > This optional internal ops allow each codec to do their own
> > error status checking. The presence of an error is reported
> > using the ERROR buffer state. This patch have no functional
> > changes.
>=20
> If a buffer is returned with state ERROR, then that means that it is
> seriously corrupt and userspace is expected to drop it. You might still
> want to show it for debugging purposes, but the normal action is to drop =
it.

The discussion should be around the ERROR flag, and not the error state. Er=
ror
state is just an internal thing that have no meaning API wise, but turns ou=
t to
be the only way to get the ERROR flag to be set. With that in mind, this is=
 not
what V4L2_BUF_FLAG_ERROR specification says:

> When this flag is set, the buffer has been dequeued successfully, althoug=
h
> the data might have been corrupted. This is recoverable, streaming may
> continue as normal and the buffer may be reused normally. Drivers set=C2=
=A0
> this flag when the VIDIOC_DQBUF ioctl is called.

For me "seriously corrupt" and "might have been corrupted" is very differen=
t.

>=20
> So this is not a valid approach for a decoder that can still produce a
> decent picture, albeit with macroblock artifacts.
>=20
> A separate control that can be returned as part of the request and contai=
ns
> some sort of error indication would be more appropriate.
>=20
> Buffer state ERROR is really meant for e.g. DMA errors and it shouldn't
> be mixed with decode errors that still produce a valid picture.

The ERROR flag has been used for many years by the UVC driver to indicate a
partially received image (possibly due to DMA error). That driver went even
further and set the bytesused to the amount of bytes that was received. How=
 this
have been interpreted (mostly due to how the spec around ERROR flag is writ=
ten)
in GStreamer is that the buffer contains "some valid" data unless payload s=
ize
is 0.

As explained earlier, the decision to display "some valid" data is not some=
thing
we should decided for our users. This should be left to the application to
decide. Same goes for GStreamer, if a buffer exist but has "some valid data=
", we
have a GST_BUFFER_FLAG_CORRUPTED flag for it. It is then up for the applica=
tion
to drop if needed for the application. I'm pretty sure some stateful decode=
rs
also behaves like this (simply because an error is an error, regardless of =
the
nature of it).

It might be different today, but few years ago, dropping or not dropping wa=
s the
main difference between Apple Facetime (dropping) and the other video strea=
ming
applications. One would freeze, the other would show "some valid data".

If you look at the outcome of a partially corrupted decoded images and the
outcome of a mid-frame DMA error (typically from a camera stream), you'll f=
ind
that these are visually the same. So it is unfair to consider these two err=
or so
different that a new mechanism must be added. In my opinion, adding RO cont=
rols
to signal these corruption only make sense if the hardware can provide deta=
iled
reports of what is corrupted (list/range of macro-blocks, or CTU that are
affected). Then you could measure the level of corruption, but in reality, =
I
doubt there would be a vast usage of this, specially that the report will l=
ikely
be inconsistent due to limited HW support.

Finally, in the bitstream decoder world, including all software decoders I'=
ve
worked with, the decode is a success only if all bits are perfectly decoded=
.
This is the baseline for good vs bad. Userland expected an image, and whate=
ver
happened, in real-time scenario, it must send an image. Sending a corrupted
image, or sending the previously good image remains a decision to be made b=
y
application. As application exist around the implemented mechanism here, I'=
d
prefer to go for that rather then adding a new API.

Nicolas

>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++----
> >  drivers/staging/media/rkvdec/rkvdec.h |  2 ++
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/me=
dia/rkvdec/rkvdec.c
> > index 7bab7586918c..7e76f8b72885 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec.c
> > @@ -950,6 +950,7 @@ static void rkvdec_v4l2_cleanup(struct rkvdec_dev *=
rkvdec)
> >  static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
> >  {
> >  	struct rkvdec_dev *rkvdec =3D priv;
> > +	struct rkvdec_ctx *ctx;
> >  	enum vb2_buffer_state state;
> >  	u32 status;
> > =20
> > @@ -958,12 +959,13 @@ static irqreturn_t rkvdec_irq_handler(int irq, vo=
id *priv)
> >  		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
> > =20
> >  	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
> > -	if (cancel_delayed_work(&rkvdec->watchdog_work)) {
> > -		struct rkvdec_ctx *ctx;
> > +	ctx =3D v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
> > =20
> > -		ctx =3D v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
> > +	if (ctx->coded_fmt_desc->ops->check_error_info)
> > +		state =3D ctx->coded_fmt_desc->ops->check_error_info(ctx);
> > +
> > +	if (cancel_delayed_work(&rkvdec->watchdog_work))
> >  		rkvdec_job_finish(ctx, state);
> > -	}
> > =20
> >  	return IRQ_HANDLED;
> >  }
> > diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/me=
dia/rkvdec/rkvdec.h
> > index 633335ebb9c4..4ae8e6c6b03c 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec.h
> > +++ b/drivers/staging/media/rkvdec/rkvdec.h
> > @@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
> >  		     struct vb2_v4l2_buffer *dst_buf,
> >  		     enum vb2_buffer_state result);
> >  	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
> > +	/* called from IRQ handler */
> > +	int (*check_error_info)(struct rkvdec_ctx *ctx);
> >  };
> > =20
> >  struct rkvdec_coded_fmt_desc {
>=20

