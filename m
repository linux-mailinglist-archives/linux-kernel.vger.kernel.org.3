Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57F75AF86C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIFXeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIFXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:34:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09627B0C;
        Tue,  6 Sep 2022 16:34:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 64711478;
        Wed,  7 Sep 2022 01:34:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662507275;
        bh=if5iI4yHXLRuWp6Q4xiIQMNR6uWLJfH1Ibo5ksqT/yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdzNfyLBGmXFGyU7RezcqP1UWOuGBgm5EzjCIE3J0yBgxkaPrlmXQtGSaHbJUA8LM
         Uj5tXAyFbKTr9P9wh8JBUrxVDJWOx8zocQyysiR1MhHdXWUkbYa6xH7ziYS5TDfQeC
         fWYsJNlmaA6GnT54iSUXJC4pi9UrYA7NJJ+G/RVo=
Date:   Wed, 7 Sep 2022 02:34:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: imx7-media-csi: Add support for fast-tracking
 queued buffers
Message-ID: <YxfY/Iv8jJ6NxHCa@pendragon.ideasonboard.com>
References: <20220906104437.4095745-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906104437.4095745-1-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Tue, Sep 06, 2022 at 07:44:37PM +0900, Paul Elder wrote:
> The CSI hardware compatible with this driver handles buffers using a
> ping-pong mechanism with two sets of destination addresses. Normally,
> when an interrupt comes in to signal the completion of one buffer, say
> FB0, it assigns the next buffer in the queue to the next FB0, and the
> hardware starts to capture into FB1 in the meantime.
> 
> In a buffer underrun situation, in the above example without loss of
> generality, if a new buffer is queued before the interrupt for FB0 comes
> in, we can program the buffer into FB1 (which is programmed with a dummy
> buffer, as there is a buffer underrun).
> 
> This of course races with the interrupt that signals FB0 completion, as
> once that interrupt comes in, we are no longer guaranteed that the
> programming of FB1 was in time and must assume it was too late. This
> race is resolved by locking the programming of FB1. If it came after the
> interrupt for FB0, then the variable that is used to determine which FB
> to program would have been swapped by the interrupt handler, thus
> resolving the race.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  drivers/staging/media/imx/imx7-media-csi.c | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index a0553c24cce4..06e50080ed31 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1296,11 +1296,60 @@ static int imx7_csi_video_buf_prepare(struct vb2_buffer *vb)
>  	return 0;
>  }
>  
> +static int imx7_csi_fast_track_buffer(struct imx7_csi *csi,
> +				      struct imx7_csi_vb2_buffer *buf)
> +{
> +	unsigned long flags;
> +	dma_addr_t phys;

I wanted to say let's name this dma_addr as it's a DMA address, not a
physical address (even if in practice the two will be the same), but the
driver uses phys everywhere. I'll send a patch on top to fix it.

> +	int buf_num;
> +	int ret = -EBUSY;
> +
> +	if (!csi->is_streaming)
> +		return ret;
> +
> +	phys = vb2_dma_contig_plane_dma_addr(&buf->vbuf.vb2_buf, 0);
> +
> +	/*
> +	 * buf_num holds the fb id of the most recently (*not* the next
> +	 * anticipated) triggered interrupt. Without loss of generality, if
> +	 * buf_num is 0 and we get to this section before the irq for fb1, the

As the registers are named CSI_CSIDMASA_FB1 and CSI_CSIDMASA_FB2, I'd
write FB1 and FB2 instead of fb0 and fb1 above. I'll use that
terminology below.

> +	 * buffer that we are fast-tracking into fb0 should be programmed in
> +	 * time to be captured into. If the irq for fb1 already happened, then
> +	 * buf_num would be 1, and we would fast-track the buffer into fb1
> +	 * instead. This guarantees that we won't try to fast-track into fb0
> +	 * and race against the start-of-capture into fb0.


I'm afraid I can't agree with that statement :-( Imagine the following
scenario.

The hardware is currently capturing to FB2, csi->buf_num is thus 0. A
dummy buffer has been queued to FB1 and programmed in the hardware. A
new buffer is queued to be fast tracked by imx7_csi_fast_track_buffer().

	spin_lock_irqsave(&csi->irqlock, flags);

Here the hardware finishes FB2 and raises the BIT_DMA_TSF_DONE_FB2
interrupt flag. The interrupt handler can't run concurrently, as this
function is holding the lock. The hardware however moves to capturing to
the dummy buffer in FB1 by copying FB1's address into the internal
current address register.

	buf_num = csi->buf_num;

buf_num is still 0.

	if (csi->active_vb2_buf[buf_num] == NULL) {

This condition is true.

		csi->active_vb2_buf[buf_num] = buf;
		imx7_csi_update_buf(csi, phys, buf_num);

The new buffer is stored into active_vb2_buf[0] and programmed in FB1.
This doesn't disturb the hardware as the DMA operation uses the internal
current address register, not the CSI_CSIDMASA_FB1 register.

		ret = 0;
	}

	spin_unlock_irqrestore(&csi->irqlock, flags);

Now the interrupt handler runs, and processes the BIT_DMA_TSF_DONE_FB2.
It sets csi->buf_num to 1, and calls imx7_csi_vb2_buf_done(). The
function completes the FB2 buffer that has just been captured and queues
a new buffer to FB2 (either a dummy buffer, or the next buffer from the
queue if there is one). The hardware now has the FB1 register pointing
to the fast-tracked buffer and the FB2 register pointing to the next
buffer for FB2. The hardware is however capturing to the dummy buffer in
slot FB1.

The hardware finishes FB1. It raises BIT_DMA_TSF_DONE_FB1, the interrupt
handler sets csi->buf_num to 0 and calls imx7_csi_vb2_buf_done(). The
function runs the following code:

	done = csi->active_vb2_buf[csi->buf_num];
	if (done) {

This condition is true as active_vb2_buf[0] contains the fast-tracked
buffer.

		done->vbuf.field = csi->vdev_fmt.field;
		done->vbuf.sequence = csi->frame_sequence;
		vb = &done->vbuf.vb2_buf;
		vb->timestamp = ktime_get_ns();
		vb2_buffer_done(vb, VB2_BUF_STATE_DONE);

The fast-tracked buffer completes, even though the hardware hasn't
written to it.

	}

You can't prevent the race with a spinlock. What you can do, however, is
try by calling imx7_csi_update_buf(), and then check if you have lost by
seing if the interrupt flag has been set in the meantime. If it hasn't,
you've won the race, and fast-tracking succeeded, you can set
active_vb2_buf[] to the new buffer. If the interrupt flag has been
raised, you may or may not have lost the race (you may have programmed
the hardware just before the interrupt flag was set, or just after, you
can't tell which one it is as you can't read back the internal address
register to see if it has been updated with the new address, it's not
exposed to the CPU), so you need to assume you've lost and queue
the buffer through the slow path.

When taking the slow path because the race was lost, you also need to
ensure that the fact that you've programmed the hardware by calling
imx7_csi_update_buf() will not cause any problem (both in the case where
you have really lost the race, and the case where you have won it but
you still think you've lost, as explained above). I think it's fine in
this case, but I'll leave it as an exercise to the reader (i.e. you :-))
to prove it, with an analysis of the flow of operations.

> +	 *
> +	 * We only fast-track the buffer if the currently programmed buffer is
> +	 * a dummy buffer. We can check the active_vb2_buf instead as it is
> +	 * always modified along with programming the fb[0,1] registers via the
> +	 * lock (besides setup and cleanup). If it is not a dummy buffer then
> +	 * we queue it normally, as fast-tracking is not an option.
> +	 */
> +
> +	spin_lock_irqsave(&csi->irqlock, flags);
> +
> +	buf_num = csi->buf_num;
> +	if (csi->active_vb2_buf[buf_num] == NULL) {
> +		csi->active_vb2_buf[buf_num] = buf;
> +		imx7_csi_update_buf(csi, phys, buf_num);
> +		ret = 0;
> +	}
> +
> +	spin_unlock_irqrestore(&csi->irqlock, flags);
> +
> +	return ret;
> +}
> +
>  static void imx7_csi_video_buf_queue(struct vb2_buffer *vb)
>  {
>  	struct imx7_csi *csi = vb2_get_drv_priv(vb->vb2_queue);
>  	struct imx7_csi_vb2_buffer *buf = to_imx7_csi_vb2_buffer(vb);
>  	unsigned long flags;
> +	int ret;
> +
> +	ret = imx7_csi_fast_track_buffer(csi, buf);
> +	if (!ret)
> +		return;

Maybe you could return a bool from imx7_csi_fast_track_buffer() and
write

	if (imx7_csi_fast_track_buffer(csi, buf))
		return;

Up to you.

>  
>  	spin_lock_irqsave(&csi->q_lock, flags);
>  

-- 
Regards,

Laurent Pinchart
