Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF73580E76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiGZIFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiGZIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:05:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B321253;
        Tue, 26 Jul 2022 01:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA076B8122C;
        Tue, 26 Jul 2022 08:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E26BC341C0;
        Tue, 26 Jul 2022 08:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658822741;
        bh=AuSXlGXkPcDkuhy4cIR2vtHDpg/jer5nbJzf7kZ8fcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/jb5CsETxT0qcotIYIMSfXjAxsypMdq9EZIa9Iwl6DxU6FlTg1WpjrgCZnN+J0AA
         IML2WWN2ZCoyhz/lPyYZ7EM6Sg3zapcaEX2gx7z1Gt+YmD+xxfKIL8n4Bs05UKF1qr
         rgeEuPYQO0Wen5ks6sbvz0iO7/1BFuMcwBNBAyqUB0G4Ggto9tlf5L8zpbzf62L8vj
         aTLv3KEN5o8AAZZR1ugZBj4hBHaROiTff9aZFAowgD02P2eSsHbD8Tajp8Z/6/ZSbh
         L4SnT5gLmfpThWKazRJZyITtTzc71fbJIul8esYVtPiGT+BCrep6Um5Lwcc/RixDvY
         4L6fUwKtvZmrQ==
Date:   Tue, 26 Jul 2022 13:35:33 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com
Subject: Re: [PATCH v3 1/1] bus: mhi: host: Fix up null pointer access in
 mhi_irq_handler
Message-ID: <20220726080533.GD5522@workstation>
References: <1658459838-30802-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658459838-30802-1-git-send-email-quic_qianyu@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ath11k, Kalle

On Fri, Jul 22, 2022 at 11:17:18AM +0800, Qiang Yu wrote:
> The irq handler for a shared IRQ ought to be prepared for running
> even now it's being freed. So let's check the pointer used by
> mhi_irq_handler to avoid null pointer access since it is probably
> released before freeing IRQ.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> v2->v3: add comments
> v1->v2: change dev_err to dev_dbg
> 
>  drivers/bus/mhi/host/main.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index f3aef77a..df0fbfe 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -430,12 +430,25 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>  {
>  	struct mhi_event *mhi_event = dev;
>  	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
> -	struct mhi_event_ctxt *er_ctxt =
> -		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> +	struct mhi_event_ctxt *er_ctxt;
>  	struct mhi_ring *ev_ring = &mhi_event->ring;
> -	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
> +	dma_addr_t ptr;
>  	void *dev_rp;
>  
> +	/*
> +	 * If CONFIG_DEBUG_SHIRQ is set, the IRQ handler will get invoked during __free_irq()
> +	 * and by that time mhi_ctxt() would've freed. So check for the existence of mhi_ctxt
> +	 * before handling the IRQs.
> +	 */
> +	if (!mhi_cntrl->mhi_ctxt) {
> +		dev_dbg(&mhi_cntrl->mhi_dev->dev,
> +			"mhi_ctxt has been freed\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> +	ptr = le64_to_cpu(er_ctxt->rp);
> +
>  	if (!is_valid_ring_ptr(ev_ring, ptr)) {
>  		dev_err(&mhi_cntrl->mhi_dev->dev,
>  			"Event ring rp points outside of the event ring\n");
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
