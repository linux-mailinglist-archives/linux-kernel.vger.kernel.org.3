Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B6C464F71
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbhLAOST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:18:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38026 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhLAOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:18:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9B18CE1EC9;
        Wed,  1 Dec 2021 14:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF55C53FAD;
        Wed,  1 Dec 2021 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638368082;
        bh=OJsUf98doJbSBg4evWGl0/HDR+em1QuDx1eRkOgFszY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9ZRVA9t237CqkdYExXdsSX0Xzbbh6AV58VFicu5KbdQ/wey4wdmSG0TPaMIgtGW4
         I41ZUhRubg2CfRMT9wy+Evd4h7Xrbtsp6yp6JzevnVkWi/as07Tt4Y66d+y9DUtP93
         zAvLjooxlYG4dLAd52aAxAKZIs7P/7Og65u+7TiKQShs6Y0QaIVXaj3Af4VdFJ1ppc
         JCGtKGJBe9E+qI5hvmVGv1F8VwuCELdIiL0NtdA/uQB0Qm0I6UOpU8vAsOPr/0BU79
         7s+HI0EUJSQIVorX+XvnOCaUZB5DWEWdWf5tomV8GiOoySyQdiopN/YsYxI+aK+ki7
         phdx8hApMxjWQ==
Date:   Wed, 1 Dec 2021 22:14:30 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     pawell@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lznuaa@gmail.com
Subject: Re: [PATCH v2  1/1] usb: cdns3: gadget: fix new urb never complete
 if ep cancel previous requests
Message-ID: <20211201141430.GB3720@Peter>
References: <20211130154239.8029-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130154239.8029-1-Frank.Li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-30 09:42:39, Frank Li wrote:
> This issue was found at android12 MTP.
> 1. MTP submit many out urb request.
> 2. Cancel left requests (>20) when enough data get from host
> 3. Send ACK by IN endpoint.
> 4. MTP submit new out urb request.
> 5. 4's urb never complete.
> 
> TRACE LOG:
> 
> MtpServer-2157    [000] d..3  1287.150391: cdns3_ep_dequeue: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -115, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:1 SID: 0
> MtpServer-2157    [000] d..3  1287.150410: cdns3_gadget_giveback: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -104, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:0 SID: 0
> MtpServer-2157    [000] d..3  1287.150433: cdns3_ep_dequeue: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -115, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:1 SID: 0
> MtpServer-2157    [000] d..3  1287.150446: cdns3_gadget_giveback: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -104, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:0 SID: 0
> 	....
> MtpServer-2157    [000] d..1  1293.630410: cdns3_alloc_request: ep1out: req: 00000000afbccb7d, req buff 0000000000000000, length: 0/0 zsi, status: 0, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
> MtpServer-2157    [000] d..2  1293.630421: cdns3_ep_queue: ep1out: req: 00000000afbccb7d, req buff 00000000871caf90, length: 0/512 zsi, status: -115, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
> MtpServer-2157    [000] d..2  1293.630445: cdns3_wa1: WA1: ep1out set guard
> MtpServer-2157    [000] d..2  1293.630450: cdns3_wa1: WA1: ep1out restore cycle bit
> MtpServer-2157    [000] d..2  1293.630453: cdns3_prepare_trb: ep1out: trb 000000007317b3ee, dma buf: 0xffd5bc00, size: 512, burst: 128 ctrl: 0x00000424 (C=0, T=0, ISP, IOC, Normal) SID:0 LAST_SID:0
> MtpServer-2157    [000] d..2  1293.630460: cdns3_doorbell_epx: ep1out, ep_trbaddr ffd50414
> 	....
> irq/241-5b13000-2154    [000] d..1  1293.680849: cdns3_epx_irq: IRQ for ep1out: 01000408 ISP , ep_traddr: ffd508ac ep_last_sid: 00000000 use_streams: 0
> irq/241-5b13000-2154    [000] d..1  1293.680858: cdns3_complete_trb: ep1out: trb 0000000021a11b54, dma buf: 0xffd50420, size: 16384, burst: 128 ctrl: 0x00001810 (C=0, T=0, CHAIN, LINK) SID:0 LAST_SID:0
> irq/241-5b13000-2154    [000] d..1  1293.680865: cdns3_request_handled: Req: 00000000afbccb7d not handled, DMA pos: 185, ep deq: 88, ep enq: 185, start trb: 184, end trb: 184
> 
> Actually DMA pos already bigger than previous submit request afbccb7d's TRB (184-184). The reason of (not handled) is that deq position is wrong.
> 
> The TRB link is below when irq happen.
> 
> 	DEQ LINK LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).
> 
> Original code check LINK TRB, but DEQ just move one step.
> 
> 	LINK DEQ LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).
> 
> This patch skip all LINK TRB and sync DEQ to trb's start.
> 
> 	LINK LINK LINK LINK LINK .... DEQ = TRB(afbccb7d):START  DMA(EP_TRADDR).
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Jun Li <jun.li@nxp.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
> 
> Change from v1 to v2:
>  * using peter suggest's fix
> 
>  drivers/usb/cdns3/cdns3-gadget.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 1f3b4a1422126..f9af7ebe003d7 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -337,19 +337,6 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
>  	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
>  }
>  
> -static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
> -{
> -	struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
> -	int current_trb = priv_req->start_trb;
> -
> -	while (current_trb != priv_req->end_trb) {
> -		cdns3_ep_inc_deq(priv_ep);
> -		current_trb = priv_ep->dequeue;
> -	}
> -
> -	cdns3_ep_inc_deq(priv_ep);
> -}
> -
>  /**
>   * cdns3_allow_enable_l1 - enable/disable permits to transition to L1.
>   * @priv_dev: Extended gadget object
> @@ -1517,10 +1504,11 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
>  
>  		trb = priv_ep->trb_pool + priv_ep->dequeue;
>  
> -		/* Request was dequeued and TRB was changed to TRB_LINK. */
> -		if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
> +		/* The TRB was changed as link TRB, and the request was handled at ep_dequeue */
> +		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
>  			trace_cdns3_complete_trb(priv_ep, trb);
> -			cdns3_move_deq_to_next_trb(priv_req);
> +			cdns3_ep_inc_deq(priv_ep);
> +			trb = priv_ep->trb_pool + priv_ep->dequeue;
>  		}
>  
>  		if (!request->stream_id) {
> -- 
> 2.24.0.rc1
> 

-- 

Thanks,
Peter Chen

