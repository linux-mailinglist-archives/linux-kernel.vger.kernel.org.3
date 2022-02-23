Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA214C1967
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbiBWRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiBWRGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:06:07 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB3541B0;
        Wed, 23 Feb 2022 09:05:38 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4E5B7E0013;
        Wed, 23 Feb 2022 17:05:35 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:05:33 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH v5 01/13] media: atmel: atmel-isc-base: use streaming
 status when queueing buffers
Message-ID: <20220223170533.mgzbkg2v45bhahqd@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-2-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217135645.1427466-2-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Thu, Feb 17, 2022 at 03:56:33PM +0200, Eugen Hristev wrote:
> During experiments with libcamera, it looks like vb2_is_streaming returns
> true before our start streaming is called.
> Order of operations is streamon -> queue -> start_streaming
> ISC would have started the DMA immediately when a buffer is being added
> to the vbqueue if the queue is streaming.
> It is more safe to start the DMA after the start streaming of the driver is
> called.
> Thus, even if vb2queue is streaming, add the buffer to the dma queue of the
> driver instead of actually starting the DMA process, if the start streaming
> has not been called yet.
> Tho achieve this, we have to use vb2_start_streaming_called instead of
> vb2_is_streaming.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j
> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index db15770d5b88..d2cc6c99984f 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -442,7 +442,7 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
>
>  	spin_lock_irqsave(&isc->dma_queue_lock, flags);
>  	if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
> -		vb2_is_streaming(vb->vb2_queue)) {
> +		vb2_start_streaming_called(vb->vb2_queue)) {
>  		isc->cur_frm = buf;
>  		isc_start_dma(isc);
>  	} else
> --
> 2.25.1
>
