Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D0504C92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiDRGZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiDRGZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:25:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037DE1837C;
        Sun, 17 Apr 2022 23:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0591B80D86;
        Mon, 18 Apr 2022 06:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A64C385A7;
        Mon, 18 Apr 2022 06:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650262964;
        bh=PWcIy8PGxkF0B7GrimYoVIiNDzZ6HuGk+0nj59uVwWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPIT16FMh/HuoCjW4PrvD4bNzAzj3sVuMlxMcDK6jPCSk5PToFgRbH+UAb0Z21NgA
         FhODQYe+3zH7k7cdt6C/cAGBlfvHkceHJ/d1CwOwaIA0e5zwdgPjn1/7VqRajOmrHT
         W+bogzXOAm5wAfgRHjwNFKiDMXyJhfKLQ/HWBnA95WJV1iwAmYMASrT7IduVBo+Gwd
         WZlvZAHP2CjuGZ6JTenh4YAqRMCZrky5XOswC1xitDem9l7Ejsko4xygEG6zIsyiKs
         O5a5eMeQa8SLDen4LfnZH0ZeTI1uWKn6JCtlkX2Kw3P0U5XDElEKbmLuVlQFm6Tt7T
         APsYb23vBVWTQ==
Date:   Mon, 18 Apr 2022 11:52:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: host: Use cached values for calculating the
 shared write pointer
Message-ID: <20220418062238.GH7431@thinkpad>
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

Applied to mhi-next!

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
