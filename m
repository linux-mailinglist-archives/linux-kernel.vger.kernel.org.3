Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512135AF28C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiIFRa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiIFR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:29:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B74220F0;
        Tue,  6 Sep 2022 10:24:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t14so9213038wrx.8;
        Tue, 06 Sep 2022 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4MKG+RwmqiMdozxqJtzrhz7rSI72kj6Ks/XRJ6On4Vs=;
        b=PMoTJmA/IX7ee3qm18YMEm3NgZT5PKJxyXALkXrbg2kzlhTxrDSK68ao8nMpI8UJ3o
         8kgHFrJHbaPb2I1CqFYLeeqZYIfpEaelWf5HX0amDkhtQGaNeI4uA214YB3OQjrMx0Kz
         cw2yN8xd2VpgfZhHuE/jM9Izm4+xTM4gIbhdra/MyJ8PKPozgU2t9oJ2dAzv6KQyYnFp
         PLZtlLTTcmg7C5Uq8NWMOHIyJj1ZciWH4tAUWV7xrfE8CCtCJCg/6/IZyQYJZ44BDKXU
         2JCTSLixyRcJPDTjn3KJAf/R04piDl3SzJD6biEKgAA66y9b7Ce/wIDE/621ucIamjJZ
         /NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4MKG+RwmqiMdozxqJtzrhz7rSI72kj6Ks/XRJ6On4Vs=;
        b=XDIh49Z3G/pL8+FGySAGu2vR0oyl/PU/9Xgs8D7cICwE7PpAcWNh1G0Ca02KxKZv4C
         VTHmJSgm5bTYyqDZbqluM9OvkUN3XtC5kYrg7iWy/TuxfimbJURoKJODRnItivdyLP6i
         j6mOo/Z5Zjijm09ymrEKy+gm49jKH7ykQ1kHeIfur+BV0ZxkecWLu5BnOKE+CtuapfY3
         7x1eKTb/eOsBbs1qwzn6oaink4/4jeg3RnWnST6yOjlR8KwLbzbRCgt1Sei2n9y/lZnU
         BQA0H8M/hB7R87MMrSKbaMj4jVcGryT5lV2HexaQzSU3mK+KLuV71+CO4NWl564VRkzb
         06Rw==
X-Gm-Message-State: ACgBeo16/1TZS/NHEbFnVd1ykxtbZ7b2XlGoxZOdSa5IZM/WJmyCir7d
        Gq8uJvD3nCcoCbF9zpR2aro=
X-Google-Smtp-Source: AA6agR5Thw4hKGO3gxsQInlXJHRXciJ41hwlr/Ih+db6GLVPwekfXpt9W90whIp1OkzdXv7aR0NJwA==
X-Received: by 2002:adf:fe06:0:b0:228:db6f:41ae with SMTP id n6-20020adffe06000000b00228db6f41aemr2222245wrr.577.1662485043648;
        Tue, 06 Sep 2022 10:24:03 -0700 (PDT)
Received: from arch-thunder (a109-49-33-111.cpe.netcabo.pt. [109.49.33.111])
        by smtp.gmail.com with ESMTPSA id t15-20020adff60f000000b00228d7078c4esm3931715wrp.4.2022.09.06.10.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:24:02 -0700 (PDT)
Date:   Tue, 6 Sep 2022 18:24:00 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <20220906172400.4oxeefxhmesl2spi@arch-thunder>
References: <20220906104437.4095745-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906104437.4095745-1-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

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

Thanks a lot for this patch, and spending time commenting the issue in
the code, and the good changelog.

LGTM.

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

Cheers,
  Rui

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
> +	 * buffer that we are fast-tracking into fb0 should be programmed in
> +	 * time to be captured into. If the irq for fb1 already happened, then
> +	 * buf_num would be 1, and we would fast-track the buffer into fb1
> +	 * instead. This guarantees that we won't try to fast-track into fb0
> +	 * and race against the start-of-capture into fb0.
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
>  
>  	spin_lock_irqsave(&csi->q_lock, flags);
>  
> -- 
> 2.30.2
> 
