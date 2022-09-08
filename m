Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361D5B1742
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIHIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiIHIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:38:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF0DFF7E;
        Thu,  8 Sep 2022 01:38:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9A766CC;
        Thu,  8 Sep 2022 10:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662626284;
        bh=5foHTCrN9iWRme3YP8ot2BtLEUEWucPK0kXYEAE/S1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKLwjiMpcQjnVcXbsSB4LpqgP/B57xtn+Emlq0IjLQW6QO16foezTkmjL9kF/88gJ
         /gMsn+80WuoAUgQCrEw/mIwuH7YLUHd/EeLFJ0o56ufTNzbOhqiGduadXnJgYAxT1O
         GVXssp+Q/zTQnc9FE/qD8qFKRnaTFsKRt/YxqzOU=
Date:   Thu, 8 Sep 2022 11:37:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     paul.elder@ideasonboard.com
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
Subject: Re: [PATCH v2] media: imx7-media-csi: Add support for fast-tracking
 queued buffers
Message-ID: <Yxmp2xCy8t+eO1+k@pendragon.ideasonboard.com>
References: <20220907114737.1127612-1-paul.elder@ideasonboard.com>
 <YxjgkAjvsaZkS2cY@pendragon.ideasonboard.com>
 <20220908030321.GA1140330@pyrite.rasen.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908030321.GA1140330@pyrite.rasen.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 12:03:21PM +0900, paul.elder@ideasonboard.com wrote:
> Hi Laurent,
> 
> On Wed, Sep 07, 2022 at 09:18:56PM +0300, Laurent Pinchart wrote:
> > Hi Paul,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Sep 07, 2022 at 08:47:37PM +0900, Paul Elder wrote:
> > > The CSI hardware compatible with this driver handles buffers using a
> > > ping-pong mechanism with two sets of destination addresses. Normally,
> > > when an interrupt comes in to signal the completion of one buffer, say
> > > FB0, it assigns the next buffer in the queue to the next FB0, and the
> > > hardware starts to capture into FB1 in the meantime.
> > 
> > Could you replace FB0 and FB1 with FB1 and FB2 respectively, to match
> > the naming of the registers ?
> 
> Oops, I forgot to do it in the commit message.
> 
> > 
> > > In a buffer underrun situation, in the above example without loss of
> > > generality, if a new buffer is queued before the interrupt for FB0 comes
> > > in, we can program the buffer into FB1 (which is programmed with a dummy
> > > buffer, as there is a buffer underrun).
> > > 
> > > This of course races with the interrupt that signals FB0 completion, as
> > > once that interrupt comes in, we are no longer guaranteed that the
> > > programming of FB1 was in time and must assume it was too late. This
> > > race is resolved partly by locking the programming of FB1. If it came
> > > after the interrupt for FB0, then the variable that is used to determine
> > > which FB to program would have been swapped by the interrupt handler.
> > > 
> > > This alone isn't sufficient, however, because the interrupt could still
> > > be generated (thus the hardware starts capturing into the other fb)
> > > while the fast-tracking routine has the irq lock. Thus, after
> > > programming the fb register to fast-track the buffer, the isr also must
> > > be checked to confirm that an interrupt didn't come in the meantime. If
> > > it has, we must assume that programming the register for the
> > > fast-tracked buffer was not in time, and queue the buffer normally.
> > > 
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
> > > 
> > > ---
> > > Changes in v2:
> > > - fix the potential race condition where the interrupt comes in while
> > >   the fast tracking routine has the irqlock
> > > - change return value from int to bool
> > > ---
> > >  drivers/staging/media/imx/imx7-media-csi.c | 63 ++++++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > > 
> > > diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> > > index a0553c24cce4..0ebef44a7627 100644
> > > --- a/drivers/staging/media/imx/imx7-media-csi.c
> > > +++ b/drivers/staging/media/imx/imx7-media-csi.c
> > > @@ -1296,12 +1296,75 @@ static int imx7_csi_video_buf_prepare(struct vb2_buffer *vb)
> > >  	return 0;
> > >  }
> > >  
> > > +static bool imx7_csi_fast_track_buffer(struct imx7_csi *csi,
> > > +				       struct imx7_csi_vb2_buffer *buf)
> > > +{
> > > +	unsigned long flags;
> > > +	dma_addr_t phys;
> > > +	int buf_num;
> > > +	u32 isr;
> > > +
> > > +	if (!csi->is_streaming)
> > > +		return false;
> > > +
> > > +	phys = vb2_dma_contig_plane_dma_addr(&buf->vbuf.vb2_buf, 0);
> > > +
> > > +	/*
> > > +	 * buf_num holds the fb id of the most recently (*not* the next
> > > +	 * anticipated) triggered interrupt. Without loss of generality, if
> > > +	 * buf_num is 0 and we get to this section before the irq for fb2, the
> > 
> > s/fb2/FB2/ to match hardware registers and the commit message ?
> 
> ack
> 
> > 
> > > +	 * buffer that we are fast-tracking into fb1 should be programmed in
> > > +	 * time to be captured into. If the irq for fb2 already happened, then
> > > +	 * buf_num would be 1, and we would fast-track the buffer into fb2
> > > +	 * instead. This guarantees that we won't try to fast-track into fb1
> > > +	 * and race against the start-of-capture into fb1.
> > > +	 *
> > > +	 * We only fast-track the buffer if the currently programmed buffer is
> > > +	 * a dummy buffer. We can check the active_vb2_buf instead as it is
> > > +	 * always modified along with programming the fb[1,2] registers via the
> > > +	 * lock (besides setup and cleanup).
> > > +	 */
> > 
> > I think this needs to be updated, it still indicates we handle the race
> > just by checking buf_num. How about the following ?
> > 
> > 	/*
> > 	 * buf_num holds the framebuffer ID of the most recently (*not* the next
> > 	 * anticipated) triggered interrupt. Without loss of generality, if
> > 	 * buf_num is 0, the hardware is capturing to FB2. If FB1 has been
> > 	 * programmed with a dummy buffer (as indicated by active_vb2_buf[0]
> > 	 * being NULL), then we can fast-track the new buffer by programming its
> > 	 * address in FB1 before the hardware completes FB2, instead of adding
> > 	 * it to the buffer queue and incurring a delay of one additional frame.
> 
> Okay that's a lot easier to follow than the one that I wrote.
> 
> > 	 *
> > 	 * The irqlock prevents races with the interrupt handler that queues the
> 
> The interrupt handler doesn't /queue/ the buffer, it programs the FB
> register with the buffer at the front of the buffer queue. That's why I
> said "programs the next buffer" in my original text.
> 
> Although I don't think racing with the interrupt handler for
> programming the next buffer is important in this context, since the
> interrupt handler is going to program FB2, while we're trying to program FB1
> before that that interrupt comes in.
> 
> It's mainly buf_num that's relevant to locking the irqlock.
> 
> > 	 * next buffer and updates buf_num, but we can still race with the
> > 	 * hardware if we program the buffer in FB1 just after the hardware
> > 	 * completes FB2 and switches to FB1 and before we notice the buf_num
> > 	 * change.
> 
> buf_num won't actually be changed because we have the lock. Maybe
> "before buf_num can be updated by the interrupt handler for FB2"?
> 
> > The fast-tracked buffer would then be ignored by the hardware
> > 	 * while the driver would think it has successfully been processed.
> > 	 *
> > 	 * To avoid this problem, if we can't avoid the race, we can detect that
> > 	 * we have lost it by checking, after programming the buffer in FB1, if
> > 	 * the interrupt flag indicated completion of FB2 has been raised. If
> 
> s/indicated/indicating/
> 
> > 	 * that is not the case, fast-tracking succeeded, and we can update
> > 	 * active_vb2_buf[0]. Otherwise, we may or may not have lost the race
> > 	 * (as the interrupt flag may have been raised just after programming
> > 	 * FB1 and before we read the interrupt status register), and we need to
> > 	 * assume the worst case of a race loss and queue the buffer through the
> > 	 * slow path.
> > 	 */
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > If you're fine with these changes there's no need to submit a v3, I'll
> > update the comment and the commit message locally.
> 
> Yeah I'm fine with these.
> 
> > 
> > > +
> > > +	spin_lock_irqsave(&csi->irqlock, flags);
> > > +
> > > +	buf_num = csi->buf_num;
> > > +	if (csi->active_vb2_buf[buf_num]) {
> > > +		spin_unlock_irqrestore(&csi->irqlock, flags);
> > > +		return false;
> > > +	}
> > > +
> > > +	imx7_csi_update_buf(csi, phys, buf_num);
> > > +
> > > +	isr = imx7_csi_reg_read(csi, CSI_CSISR);
> > > +	/*
> > > +	 * The interrupt for the /other/ fb just came (the isr hasn't run yet
> > > +	 * though, because we have the lock here); we can't be sure we've
> > > +	 * programmed buf_num fb in time, so queue the buffer to the buffer
> > > +	 * queue normally. No need to undo writing the fb register, since we
> > > +	 * won't return it as active_vb2_buf is NULL, so it's okay to
> > > +	 * potentially write it to both fb1 and fb2; only the one where it was
> 
> I guess there should be s/fb/FB/ throughout this block too.
> 
> > > +	 * queued normally will be returned.
> > > +	 */
> 
> (You mention this in your other reply)
> 
> Yeah I guess this block should go inside the if. I didn't really
> aesthetically like a huge block of text inside a tiny if block but maybe
> that's more correct.
> 
> 
> Thanks,
> 
> Paul
> 
> > > +	if (isr & (buf_num ? BIT_DMA_TSF_DONE_FB1 : BIT_DMA_TSF_DONE_FB2)) {
> > > +		spin_unlock_irqrestore(&csi->irqlock, flags);
> > > +		return false;
> > > +	}
> > > +
> > > +	csi->active_vb2_buf[buf_num] = buf;
> > > +
> > > +	spin_unlock_irqrestore(&csi->irqlock, flags);
> > > +	return true;
> > > +}
> > > +
> > >  static void imx7_csi_video_buf_queue(struct vb2_buffer *vb)
> > >  {
> > >  	struct imx7_csi *csi = vb2_get_drv_priv(vb->vb2_queue);
> > >  	struct imx7_csi_vb2_buffer *buf = to_imx7_csi_vb2_buffer(vb);
> > >  	unsigned long flags;
> > >  
> > > +	if (imx7_csi_fast_track_buffer(csi, buf))
> > > +		return;
> > > +
> > >  	spin_lock_irqsave(&csi->q_lock, flags);
> > >  
> > >  	list_add_tail(&buf->list, &csi->ready_q);

-- 
Regards,

Laurent Pinchart
