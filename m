Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9072E546D13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346502AbiFJTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:14:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F77654;
        Fri, 10 Jun 2022 12:14:17 -0700 (PDT)
Received: from localhost (unknown [94.134.91.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE838660171F;
        Fri, 10 Jun 2022 20:14:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654888456;
        bh=6GXcmorL5zNXiebjSNEfJIyYSLvMDnksHIFtCZk5Tow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIq37SN3oFbZFxM5JjGcBaERVUJj6Ua9iqJagSoqLJDGAUR45CSOdSGBQlD9858tU
         lap4CDD0sJ49xIuNZVGpdLLjRMm7tOlkRNrv9t4Sqs1VP4XoRazkY6iYw/ENXBB1BA
         Lcu6ElJFG3Tl6760KXW8XXJ5tfxp+GB9KMgzcsz4THPq6N6edCLYxqoNlia1edXTVC
         B+6iZm0HtbBHDfd5ca5jEfy7k7rKZ9XAGFKsdW5CKu+2yqda7dVzeqiiNP2nGyn49w
         CXJ366NeC9SCjIqjK3v2HK89kGBENqrQcTZj4rPPeaYXL12UKDHFbmnVebrMW3k/f0
         039zdkvBOEIiQ==
Date:   Fri, 10 Jun 2022 21:14:13 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] media: rkvdec: Improve error handling
Message-ID: <20220610191413.xgwfw5n6snje3khj@basti-XPS-13-9310>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
 <20220610125215.240539-6-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220610125215.240539-6-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

Tested with: python3 fluster.py run -d GStreamer-H.264-V4L2SL-Gst1.0 -ts JVT-AVC_
V1 -so /tmp/h264_test.csv -f csv -j1

Ran 129/135 tests successfully               in 82.280 secs

On 10.06.2022 08:52, Nicolas Dufresne wrote:
>There is two way decode errors can occur. In one case, the ready

s/There is two way decode/There are two ways decoding/


>status is not set and nothing have been written into the destination,

s/nothing have been/nothing has been/

>while in the other case, the buffer is written but may contain a
>certain amount of errors. In order to differentiate these, we set
>the payload for the first case to 0.
>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/staging/media/rkvdec/rkvdec.c | 26 ++++++++++++++++++++++----
> 1 file changed, 22 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>index 7e76f8b72885..27f1f7276dd2 100644
>--- a/drivers/staging/media/rkvdec/rkvdec.c
>+++ b/drivers/staging/media/rkvdec/rkvdec.c
>@@ -954,14 +954,32 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
> 	enum vb2_buffer_state state;
> 	u32 status;
>
>+	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
> 	status = readl(rkvdec->regs + RKVDEC_REG_INTERRUPT);
>-	state = (status & RKVDEC_RDY_STA) ?
>-		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
>+
>+	if (!(status & RKVDEC_RDY_STA)) {
>+		struct vb2_v4l2_buffer *dst_buf = NULL;
>+
>+		if (status & RKVDEC_TIMEOUT_STA)
>+			pr_debug("Decoder stopped due to internal timeout.");
>+		else
>+			pr_debug("Decoder stopped due to internal error.");

(Just personal preference.. I would prefer "due to an internal" over
"due to internal")

>+
>+		/*
>+		 * When this happens, the buffer is left unmodified. As it
>+		 * contains no meaningful data we mark is a empty.

s/is a empty/it as empty/

The rest looks nice. Thanks.

Greetings,
Sebastian

>+		 */
>+		dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
>+		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
>+		state = VB2_BUF_STATE_ERROR;
>+	} else {
>+		state = VB2_BUF_STATE_DONE;
>+	}
>
> 	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
>-	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
>
>-	if (ctx->coded_fmt_desc->ops->check_error_info)
>+	if (ctx->coded_fmt_desc->ops->check_error_info &&
>+	    state == VB2_BUF_STATE_DONE)
> 		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
>
> 	if (cancel_delayed_work(&rkvdec->watchdog_work))
>-- 
>2.36.1
>
