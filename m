Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CA504C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiDRG3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiDRG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:29:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D41834E;
        Sun, 17 Apr 2022 23:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 408EFCE0F09;
        Mon, 18 Apr 2022 06:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC30C385A7;
        Mon, 18 Apr 2022 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650263211;
        bh=EsGNBU+sg7NMQeCrmziT8Zc9i2e1ClCCLAxrjPCfMy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqPmGnI1+Iu4R3IluEubsmJlov0GF9yhR//+LPqfnmTr4RW5CduKqNpQurgi89ZHA
         5EJsh2gf3XZKnv9CHlx2GQQmGf+blouY3h1tbDcTehWgGo6rPuBr22v8hikY5YEdyT
         qwk/t29cFrXl2bosUSUodopPalVEm4wUeYAEy1SbbKlo1Wxj4JKV4lAdiJDI30LNSD
         AFB7exqu08WJrwUpCdptyZjQAcb82cg/8o6/fgpNG5Hk5KpQuqOR5HUbujPjuVG4I1
         8QQ5/po5HEwhGzJBnXyd65KBJ9yTxwvDXAnmPgqROchE3Tdr6EafIkfblDErB7YmkM
         O7fC4S3rT7uQw==
Date:   Mon, 18 Apr 2022 11:56:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v3] bus: mhi: host: Wait for ready state after reset
Message-ID: <20220418062645.GI7431@thinkpad>
References: <1649875946-32516-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649875946-32516-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:52:26PM -0600, Jeffrey Hugo wrote:
> From: Jeffrey Hugo <jhugo@codeaurora.org>
> 
> After the device has signaled the end of reset by clearing the reset bit,
> it will automatically reinit MHI and the internal device structures.  Once
> That is done, the device will signal it has entered the ready state.
> 
> Signaling the ready state involves sending an interrupt (MSI) to the host
> which might cause IOMMU faults if it occurs at the wrong time.
> 
> If the controller is being powered down, and possibly removed, then the
> reset flow would only wait for the end of reset.  At which point, the host
> and device would start a race.  The host may complete its reset work, and
> remove the interrupt handler, which would cause the interrupt to be
> disabled in the IOMMU.  If that occurs before the device signals the ready
> state, then the IOMMU will fault since it blocked an interrupt.  While
> harmless, the fault would appear like a serious issue has occurred so let's
> silence it by making sure the device hits the ready state before the host
> completes its reset processing.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

I was about to apply this patch but wanted to check with you on using the
double signed-off by tags. If the patch get's handed over between multiple
developers then multiple signed-off by's make sense. But since it is you that
handled the earlier patch also, I think one tag is enough with your new domain.

One more thing is, using codeaurora domain will bounce now. So, please use the
quicinc domain for Hemant also.

Thanks,
Mani

> ---
> 
> v3:
> Rebase and use dev_err over dev_warn
> 
> v2: 
> Fix subject and remove use of cur_state
> 
>  drivers/bus/mhi/host/pm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index a0e91bd..f46158e 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -483,6 +483,15 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  		 * hence re-program it
>  		 */
>  		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
> +
> +		if (!MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
> +			/* wait for ready to be set */
> +			ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs,
> +						 MHISTATUS,
> +						 MHISTATUS_READY_MASK, 1, 25000);
> +			if (ret)
> +				dev_err(dev, "Device failed to enter READY state\n");
> +		}
>  	}
>  
>  	dev_dbg(dev,
> -- 
> 2.7.4
> 
