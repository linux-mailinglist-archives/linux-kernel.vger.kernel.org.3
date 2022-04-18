Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A114504C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiDRFxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiDRFx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA46256;
        Sun, 17 Apr 2022 22:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F123E60FCC;
        Mon, 18 Apr 2022 05:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0336C385A7;
        Mon, 18 Apr 2022 05:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650261049;
        bh=c6lztFL55aAMewYOzrJixc2SsJnt77LZCuf+XTgdsDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwp5pedqmew6MW6i/LOGxLnThfNgsmwVJjleBKMWK2ttlaooPkI0JY2uQxwl4Cs1V
         y//hey03+c4l84gsRy9elzEplh2ZX317czDbbfIXj/PRVoSOy2I2jnOg9Jw4G1K8O4
         ZBYGhhrdNnzpg/L5jQXPxlYUL8mwlMGpxDu8IG91PLmYYuxxcrHNz5k/oPkV8+u3Gu
         2u+zlQavm+Af9kx6S4ddd6f9NGCjJKtr7MfU4cmhjpoRie71xwXZy+3DNi2BN+Td1/
         PG6ouFR/KUwgI0jJvCTf3DK6u7MwCUmoWcbxBjf+iGQaujbikuIHMHNKKPCrlvbbJK
         3nIt3XGFXgrYg==
Date:   Mon, 18 Apr 2022 11:20:42 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: host: Use cached values for calculating the
 shared write pointer
Message-ID: <20220418055042.GC7431@thinkpad>
References: <1649868113-18826-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649868113-18826-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:41:53AM -0600, Jeffrey Hugo wrote:
> mhi_recycle_ev_ring() computes the shared write pointer for the ring
> (ctxt_wp) using a read/modify/write pattern where the ctxt_wp value in the
> shared memory is read, incremented, and written back.  There are no checks
> on the read value, it is assumed that it is kept in sync with the locally
> cached value.  Per the MHI spec, this is correct.  The device should only
> read ctxt_wp, never write it.
> 
> However, there are devices in the wild that violate the spec, and can
> update the ctxt_wp in a specific scenario.  This can cause corruption, and
> violate the above assumption that the ctxt_wp is in sync with the cached
> value.
> 
> This can occur when the device has loaded firmware from the host, and is
> transitioning from the SBL EE to the AMSS EE.  As part of shutting down
> SBL, the SBL flushes it's local MHI context to the shared memory since
> the local context will not persist across an EE change.  In the case of
> the event ring, SBL will flush its entire context, not just the parts that
> it is allowed to update.  This means SBL will write to ctxt_wp, and
> possibly corrupt it.
> 
> An example:
> 
> Host				Device
> ----				---
> Update ctxt_wp to 0x1f0
> 				SBL observes 0x1f0
> Update ctxt_wp to 0x0
> 				Starts transition to AMSS EE
> 				Context flush, writes 0x1f0 to ctxt_wp
> Update ctxt_wp to 0x200
> Update ctxt_wp to 0x210
> 				AMSS observes 0x210
> 				0x210 exceeds ring size
> 				AMSS signals syserr
> 
> The reason the ctxt_wp goes off the end of the ring is that the rollover
> check is only performed on the cached wp, which is out of sync with
> ctxt_wp.
> 
> Since the host is the authority of the value of ctxt_wp per the MHI spec,
> we can fix this issue by not reading ctxt_wp from the shared memory, and
> instead compute it based on the cached value.  If SBL corrupts ctxt_wp,
> the host won't observe it, and will correct the value at some point later.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> v3:
> Rebase to -next
> 
> v2:
> Fix typo on the ring base
> 
>  drivers/bus/mhi/host/main.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 142eea1..f3aef77a 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -534,18 +534,13 @@ irqreturn_t mhi_intvec_handler(int irq_number, void *dev)
>  static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
>  					struct mhi_ring *ring)
>  {
> -	dma_addr_t ctxt_wp;
> -
>  	/* Update the WP */
>  	ring->wp += ring->el_size;
> -	ctxt_wp = le64_to_cpu(*ring->ctxt_wp) + ring->el_size;
>  
> -	if (ring->wp >= (ring->base + ring->len)) {
> +	if (ring->wp >= (ring->base + ring->len))
>  		ring->wp = ring->base;
> -		ctxt_wp = ring->iommu_base;
> -	}
>  
> -	*ring->ctxt_wp = cpu_to_le64(ctxt_wp);
> +	*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + (ring->wp - ring->base));
>  
>  	/* Update the RP */
>  	ring->rp += ring->el_size;
> -- 
> 2.7.4
> 
