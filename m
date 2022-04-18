Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C717A504C76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiDRGLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiDRGLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:11:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CB17AB7;
        Sun, 17 Apr 2022 23:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 932CDB80E40;
        Mon, 18 Apr 2022 06:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECABC385AC;
        Mon, 18 Apr 2022 06:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650262105;
        bh=XNZr/IKeGY/pGlzCIWto86GY7XWEV0Np1gDcwopi1Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lysp/owBXLrObu8oZX/jv3OR7J3MTz+Ji1yeSgbxa5CiTMoYhoVEEb192Qt+8nf4g
         /QP7VfXAVglQTvXMG1AQMBOx8gv5wizHkAwJNJAsr7tgf4jS21aGQ4EFTAXoB2khbv
         YWiZEL7BPukNyb9GLBGI9bWJ3s+cCYqyW+5EKRW7WsHTunAUBXN6Q7syxOYKsAlXbr
         E5tFGUQh3h76fZQf0Z78KweCQgj0QGptZNhBsWXZE4784Hpu22ElUuRIBuoC13PstZ
         EGHU9oi2v4/uxKrfVuFpPUzG1p2zvuORhsX5wXXSFJRspcMfdW24xZabXZpS9SUD72
         yI69d+S5vZhUA==
Date:   Mon, 18 Apr 2022 11:38:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     loic.poulain@linaro.org, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: Re: [PATCH v3 2/2] bus: mhi: host: Optimize and update MMIO register
 write method
Message-ID: <20220418060818.GF7431@thinkpad>
References: <1649865406-30198-1-git-send-email-quic_jhugo@quicinc.com>
 <1649865406-30198-3-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649865406-30198-3-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:56:46AM -0600, Jeffrey Hugo wrote:
> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> As of now, MMIO writes done after ready state transition use the
> mhi_write_reg_field() API even though the whole register is being
> written in most cases. Optimize this process by using mhi_write_reg()
> API instead for those writes and use the mhi_write_reg_field()
> API for MHI config registers only.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  drivers/bus/mhi/host/init.c | 62 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 9ac93b7..04c409b 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -425,74 +425,65 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	struct {
>  		u32 offset;
> -		u32 mask;
>  		u32 val;
>  	} reg_info[] = {
>  		{
> -			CCABAP_HIGHER, U32_MAX,
> +			CCABAP_HIGHER,
>  			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
>  		},
>  		{
> -			CCABAP_LOWER, U32_MAX,
> +			CCABAP_LOWER,
>  			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
>  		},
>  		{
> -			ECABAP_HIGHER, U32_MAX,
> +			ECABAP_HIGHER,
>  			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
>  		},
>  		{
> -			ECABAP_LOWER, U32_MAX,
> +			ECABAP_LOWER,
>  			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
>  		},
>  		{
> -			CRCBAP_HIGHER, U32_MAX,
> +			CRCBAP_HIGHER,
>  			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
>  		},
>  		{
> -			CRCBAP_LOWER, U32_MAX,
> +			CRCBAP_LOWER,
>  			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
>  		},
>  		{
> -			MHICFG, MHICFG_NER_MASK,
> -			mhi_cntrl->total_ev_rings,
> -		},
> -		{
> -			MHICFG, MHICFG_NHWER_MASK,
> -			mhi_cntrl->hw_ev_rings,
> -		},
> -		{
> -			MHICTRLBASE_HIGHER, U32_MAX,
> +			MHICTRLBASE_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHICTRLBASE_LOWER, U32_MAX,
> +			MHICTRLBASE_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHIDATABASE_HIGHER, U32_MAX,
> +			MHIDATABASE_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHIDATABASE_LOWER, U32_MAX,
> +			MHIDATABASE_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHICTRLLIMIT_HIGHER, U32_MAX,
> +			MHICTRLLIMIT_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_stop),
>  		},
>  		{
> -			MHICTRLLIMIT_LOWER, U32_MAX,
> +			MHICTRLLIMIT_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_stop),
>  		},
>  		{
> -			MHIDATALIMIT_HIGHER, U32_MAX,
> +			MHIDATALIMIT_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_stop),
>  		},
>  		{
> -			MHIDATALIMIT_LOWER, U32_MAX,
> +			MHIDATALIMIT_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_stop),
>  		},
> -		{ 0, 0, 0 }
> +		{0, 0}
>  	};
>  
>  	dev_dbg(dev, "Initializing MHI registers\n");
> @@ -533,13 +524,22 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
>  
>  	/* Write to MMIO registers */
> -	for (i = 0; reg_info[i].offset; i++) {
> -		ret = mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
> -					  reg_info[i].mask, reg_info[i].val);
> -		if (ret) {
> -			dev_err(dev, "Unable to write to MMIO registers");
> -			return ret;
> -		}
> +	for (i = 0; reg_info[i].offset; i++)
> +		mhi_write_reg(mhi_cntrl, base, reg_info[i].offset,
> +			      reg_info[i].val);
> +
> +	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NER_MASK,
> +				  mhi_cntrl->total_ev_rings);
> +	if (ret) {
> +		dev_err(dev, "Unable to read MHICFG register\n");

"Unable to write"?

> +		return ret;
> +	}
> +
> +	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NHWER_MASK,
> +				  mhi_cntrl->hw_ev_rings);
> +	if (ret) {
> +		dev_err(dev, "Unable to read MHICFG register\n");

Same here.

Thanks,
Mani

> +		return ret;
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
> 
