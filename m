Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD251175D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiD0Mgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiD0Mgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:36:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8B24D26F;
        Wed, 27 Apr 2022 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651062819; x=1682598819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ryq+7hnciz42oDnnoJDat6cjPpO2/tvSMzKzL6pYH1I=;
  b=QSlfyvG9LwCfQBOgsYMDLpT6r5yFO8opt0V+XrL1+e9KbnFPYhOv/reB
   tXRj2AFG2oadqErfyjZXX2Lx+fxvvoDTif6zqADdRLsbjXF++On/WIOW+
   wFPiXIIPy+Sn/mv/IbIuzv03iix6G9z5UkrTOPflwmXFFyCnjynr4N3Tc
   bzDsUSzmwxSIJvYpF3yeskjCnYJJRG2Y1Q6fltbnbYM9hRjhcXUcMmbh9
   GIPbnzIifK5WxQhL+n5zI5OmxVpw8aLwbzwaSDEd5oRRm+Maym8B9G94+
   28tMbSyVuFv8rywok697cxn6vRlf/GPayQK1mURumKfcBpM7Ykt3MtrJy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264757648"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="264757648"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 05:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="580570529"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 05:33:35 -0700
Message-ID: <7db46c19-a92a-a13a-eb63-38e5ed31580f@intel.com>
Date:   Wed, 27 Apr 2022 15:33:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V1] mmc: core: Enable force hw reset
Content-Language: en-US
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>,
        ulf.hansson@linaro.org, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, axboe@kernel.dk, avri.altman@wdc.com,
        kch@nvidia.com, CLoehle@hyperstone.com, swboyd@chromium.org,
        digetx@gmail.com, bigeasy@linutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kamasali <quic_kamasali@quicinc.com>
References: <1650961818-13452-1-git-send-email-quic_spathi@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1650961818-13452-1-git-send-email-quic_spathi@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/22 11:30, Srinivasarao Pathipati wrote:
> From: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> 
> During error recovery set need hw reset to handle
> ICE error where cqe reset is must.

How do you get ICE errors?  Doesn't it mean either the hardware
is broken or the configuration is broken?

> 
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
> ---
>  drivers/mmc/core/block.c      | 8 +++++---
>  drivers/mmc/host/cqhci-core.c | 7 +++++--
>  include/linux/mmc/host.h      | 1 +
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b35e7a9..f63bf33 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1482,10 +1482,12 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
>  	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
>  
>  	err = mmc_cqe_recovery(host);
> -	if (err)
> +	if (err || host->need_hw_reset) {
>  		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
> -	else
> -		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
> +		if (host->need_hw_reset)
> +			host->need_hw_reset = false;
> +	}
> +	mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
>  
>  	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
>  }
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index b0d30c3..311b510 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -812,18 +812,21 @@ static void cqhci_finish_mrq(struct mmc_host *mmc, unsigned int tag)
>  irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>  		      int data_error)
>  {
> -	u32 status;
> +	u32 status, ice_err;
>  	unsigned long tag = 0, comp_status;
>  	struct cqhci_host *cq_host = mmc->cqe_private;
>  
>  	status = cqhci_readl(cq_host, CQHCI_IS);
>  	cqhci_writel(cq_host, status, CQHCI_IS);
> +	ice_err = status & (CQHCI_IS_GCE | CQHCI_IS_ICCE);
>  
>  	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc), status);
>  
>  	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
> -	    cmd_error || data_error)
> +	    cmd_error || data_error || ice_err){
> +		mmc->need_hw_reset = true;
>  		cqhci_error_irq(mmc, status, cmd_error, data_error);
> +	}
>  
>  	if (status & CQHCI_IS_TCC) {
>  		/* read TCN and complete the request */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c193c50..3d00bcf 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -492,6 +492,7 @@ struct mmc_host {
>  	int			cqe_qdepth;
>  	bool			cqe_enabled;
>  	bool			cqe_on;
> +	bool                    need_hw_reset;
>  
>  	/* Inline encryption support */
>  #ifdef CONFIG_MMC_CRYPTO

