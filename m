Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427457C9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiGULYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiGULYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72C43E75;
        Thu, 21 Jul 2022 04:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7302CB823C7;
        Thu, 21 Jul 2022 11:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC544C3411E;
        Thu, 21 Jul 2022 11:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658402643;
        bh=+dJJG/Fz6PNcC2CDlBQWkdUmE3PRlfKqkXqAIbwf1qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ev4AEEhiYwhgnUj4NSRQbF00ZpzPaVoz/yfDFPRpacLC32tByaHfCFGt/IbAyvcc3
         PYRlxggKLohTE0RBoC9dEvlILl7IPT7+dwpxe1VUd2dxVeE7Vih/bBig9/yog7LW4B
         W5HhaqNTAMLqB/TlwGw3Cn7PtMFOt667mI/N12e6wIVtEHOQiKMhuIVMymsNucfwk1
         JXwauIStNSFjUPCaiacUg6M61wu06I7sQVXUIeJ4/4pUWaybftxUDDdsu3iZIN+fQe
         wsM6IfZr8fduChlpH/skV9TO8D+zALxvzE+79t+/SU8g6lDnakaUwtklOmZpDkRJij
         Htbx+4PDa1x4A==
Date:   Thu, 21 Jul 2022 16:53:48 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com
Subject: Re: [PATCH v2 1/1] bus: mhi: host: Fix up null pointer access in
 mhi_irq_handler
Message-ID: <20220721112348.GD36189@thinkpad>
References: <1658369754-87005-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1658369754-87005-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:15:54AM +0800, Qiang Yu wrote:
> The irq handler for a shared IRQ ought to be prepared for running
> even now it's being freed. So let's check the pointer used by
> mhi_irq_handler to avoid null pointer access since it is probably
> released before freeing IRQ.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
> v1->v2: change dev_err to dev_dbg
> 
>  drivers/bus/mhi/host/main.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index f3aef77a..25ea1f8 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -430,12 +430,20 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
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

It'd be good to add a comment here on why we are checking for the NULL pointer.
Something like,

"If CONFIG_DEBUG_SHIRQ is set, the IRQ handler will get invoked during
__free_irq() and by that time mhi_ctxt() would've freed. So check for the
existence of mhi_ctxt before handling the IRQs."

Thanks,
Mani

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

-- 
மணிவண்ணன் சதாசிவம்
