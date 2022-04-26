Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA150F92E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiDZJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbiDZJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:49:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB11AD3F5;
        Tue, 26 Apr 2022 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650963935; x=1682499935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7rLDl2p4/VTZazRPC6IkxodREfnunclbnMNaItgAgxA=;
  b=jPSxzXaL+vnJqsyjQo7m5JyNxqrIxD8y/7xL9TNXLNZ1LpIVOfIO8BKp
   YiVuPxTPQg/kb8su/jmyzUBEW68KDhxhR+gOdJeRVdoi+7cLB4CgsAEIQ
   eaCv/6dRf/nv74R7MGaSc0H5guU51O9r++VNq03JW1sDDnd7lQq0r2TQY
   c2gMWRvM6mMJ+ZKvIS3bi6u/RLGs9Gt55YIrwXjv9lkX4gVtHbRI53tzq
   LELXQvhtoHiKA8a3M6KBWuGW8VizlMZlXSB29dRpnKXcj+Uj77xpN81MV
   19fWLtxoK5iT1kkEyeYDtrEMHXQSYuaXlPChOlOrePefpbS8jrJXqmoeu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247440661"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="247440661"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:05:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="558203556"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.98])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:05:04 -0700
Message-ID: <ddedd476-eb78-229a-e028-eabb046bf22a@intel.com>
Date:   Tue, 26 Apr 2022 12:05:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V1] sdhci-msm: Add err_stat's in CQE path
Content-Language: en-US
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>,
        ulf.hansson@linaro.org, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, colyli@suse.de, axboe@kernel.dk,
        kch@nvidia.com, cw9316.lee@samsung.com, sbhanu@codeaurora.org,
        joel@jms.id.au, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kamasali <quic_kamasali@quicinc.com>
References: <1650963481-11139-1-git-send-email-quic_spathi@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1650963481-11139-1-git-send-email-quic_spathi@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/22 11:58, Srinivasarao Pathipati wrote:
> From: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> 
> Add err_stat's in CQE path for eMMC.
> 
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>

How does this relate to the V5 patches:

	https://lore.kernel.org/linux-mmc/1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com/T/#u


> ---
>  drivers/mmc/core/queue.c      |  4 ++++
>  drivers/mmc/host/cqhci-core.c |  7 +++++++
>  drivers/mmc/host/sdhci.c      | 21 ++++++++++++++-------
>  include/linux/mmc/host.h      | 22 ++++++++++++++++++++++
>  4 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index a3d4460..7b07520 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -100,6 +100,10 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>  	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
>  	bool recovery_needed = false;
>  
> +	host->err_stats[MMC_ERR_CMDQ_REQ_TIMEOUT]++;
> +	mmc_log_string(host,
> +	"Request timed out! Active reqs: %d Req: %p Tag: %d\n",
> +	mmc_cqe_qcnt(mq), req, req->tag);
>  	switch (issue_type) {
>  	case MMC_ISSUE_ASYNC:
>  	case MMC_ISSUE_DCMD:
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 311b510..03d4064 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -825,6 +825,13 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>  	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
>  	    cmd_error || data_error || ice_err){
>  		mmc->need_hw_reset = true;
> +		if (status & CQHCI_IS_RED)
> +			mmc->err_stats[MMC_ERR_CMDQ_RED]++;
> +		if (status & CQHCI_IS_GCE)
> +			mmc->err_stats[MMC_ERR_CMDQ_GCE]++;
> +		if (status & CQHCI_IS_ICCE)
> +			mmc->err_stats[MMC_ERR_CMDQ_ICCE]++;
> +
>  		cqhci_error_irq(mmc, status, cmd_error, data_error);
>  	}
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2215202..a76c514 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3905,20 +3905,27 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  	if (!host->cqe_on)
>  		return false;
>  
> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>  		*cmd_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_CRC)
> +			host->mmc->err_stats[MMC_ERR_CMD_CRC]++;
> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>  		*cmd_error = -ETIMEDOUT;
> -	else
> +		host->mmc->err_stats[MMC_ERR_CMD_TIMEOUT]++;
> +	} else
>  		*cmd_error = 0;
>  
> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>  		*data_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +		if (intmask & SDHCI_INT_DATA_CRC)
> +			host->mmc->err_stats[MMC_ERR_DAT_CRC]++;
> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		*data_error = -ETIMEDOUT;
> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
> +		host->mmc->err_stats[MMC_ERR_DAT_TIMEOUT]++;
> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		*data_error = -EIO;
> -	else
> +		host->mmc->err_stats[MMC_ERR_ADMA]++;
> +	} else
>  		*data_error = 0;
>  
>  	/* Clear selected interrupts. */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 3d00bcf..c38072e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -80,6 +80,9 @@ struct mmc_ios {
>  	bool enhanced_strobe;			/* hs400es selection */
>  };
>  
> +#define NUM_LOG_PAGES           10
> +#define mmc_log_string(mmc_host, fmt, ...)      do { } while (0)
> +
>  struct mmc_clk_phase {
>  	bool valid;
>  	u16 in_deg;
> @@ -93,6 +96,24 @@ struct mmc_clk_phase_map {
>  
>  struct mmc_host;
>  
> +enum {
> +	MMC_ERR_CMD_TIMEOUT,
> +	MMC_ERR_CMD_CRC,
> +	MMC_ERR_DAT_TIMEOUT,
> +	MMC_ERR_DAT_CRC,
> +	MMC_ERR_AUTO_CMD,
> +	MMC_ERR_ADMA,
> +	MMC_ERR_TUNING,
> +	MMC_ERR_CMDQ_RED,
> +	MMC_ERR_CMDQ_GCE,
> +	MMC_ERR_CMDQ_ICCE,
> +	MMC_ERR_REQ_TIMEOUT,
> +	MMC_ERR_CMDQ_REQ_TIMEOUT,
> +	MMC_ERR_ICE_CFG,
> +	MMC_ERR_MAX,
> +};
> +
> +
>  struct mmc_host_ops {
>  	/*
>  	 * It is optional for the host to implement pre_req and post_req in
> @@ -471,6 +492,7 @@ struct mmc_host {
>  	struct mmc_supply	supply;
>  
>  	struct dentry		*debugfs_root;
> +	u32                     err_stats[MMC_ERR_MAX];
>  
>  	/* Ongoing data transfer that allows commands during transfer */
>  	struct mmc_request	*ongoing_mrq;

