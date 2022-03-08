Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F994D1381
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbiCHJhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiCHJhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:37:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BDF4133F;
        Tue,  8 Mar 2022 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646732198; x=1678268198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BxPsLJHS5alNB7VSsM5DbXKGOuljbmNd6UkTwCrW2SQ=;
  b=G7BaDG+3eZ4vxmCrxMb0KSu+wrY/+FT+AAsXjKjPZZmCR2BsJd2WjKAQ
   sbsNkZdUidEtL5GwqPX2j2cDffP+X0wNP80FUjgm0QRU8ldd5fkT4FkYo
   Hr7yUP1woduRiyJws4PvQQ78fBfgSAx3rJRVchqO0Qug6+4pohewZz9vR
   Xkhp+6zjWlxVGQYzNBwWaQtSGHr/giC4bXKsaNmHfYRLiqBAayiZBobhR
   ZLCKd6E9eWCoSisPcU/t5oRURscOMwV4T3jsDdeuMgyJ0Ui4q3di5ouV0
   doHt+fuTbISUukCA1mDeLhetwq43UnbKUQ6Tn5fLA8SY3yl1DvEN+LAwK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279353669"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="279353669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:36:38 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="553550142"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.193])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:36:33 -0800
Message-ID: <18f80dee-56e6-3715-6649-34a5aa87bd27@intel.com>
Date:   Tue, 8 Mar 2022 11:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V4 2/7] mmc: sdhci: Capture eMMC and SD card errors
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        quic_riteshh@quicinc.com, asutoshd@quicinc.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-3-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1646226227-32429-3-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.3.2022 15.03, Shaik Sajida Bhanu wrote:
> Add changes to capture eMMC and SD card errors.
> This is useful for debug and testing.
> 
> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/mmc/host/sdhci.c | 52 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 07c6da1..741fb06 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3159,6 +3159,7 @@ static void sdhci_timeout_timer(struct timer_list *t)
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);

Let's make a macro for this:

#define sdhci_err_stats_inc(host, err_name) \
	mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ ## err_name)

>  		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>  		       mmc_hostname(host->mmc));

Please move the err_stats_inc here after the error message i.e.

		sdhci_err_stats_inc(host, REQ_TIMEOUT);

>  		sdhci_dumpregs(host);
> @@ -3181,6 +3182,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
>  
>  	if (host->data || host->data_cmd ||
>  	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>  		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>  		       mmc_hostname(host->mmc));

Please move the err_stats_inc here after the error message i.e.

		sdhci_err_stats_inc(host, REQ_TIMEOUT);

>  		sdhci_dumpregs(host);
> @@ -3240,11 +3242,15 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  
>  	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
>  		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
> -		if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_TIMEOUT) {
>  			host->cmd->error = -ETIMEDOUT;
> -		else
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
> +		} else {
>  			host->cmd->error = -EILSEQ;
> -
> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)

That should be && not ||

Please add a helper as below, then this can be:

			if (!mmc_op_tuning(host->cmd->opcode))
				sdhci_err_stats_inc(host, CMD_CRC);


diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..d809bdfcc59b 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -99,6 +99,12 @@ static inline bool mmc_op_multi(u32 opcode)
 	       opcode == MMC_READ_MULTIPLE_BLOCK;
 }
 
+static inline bool mmc_op_tuning(u32 opcode)
+{
+	return opcode == MMC_SEND_TUNING_BLOCK ||
+	       opcode == MMC_SEND_TUNING_BLOCK_HS200;
+}
+
 /*
  * MMC_SWITCH argument format:
  *



> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
> +		}
>  		/* Treat data command CRC error the same as data CRC error */
>  		if (host->cmd->data &&
>  		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
> @@ -3265,6 +3271,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  		int err = (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
>  			  -ETIMEDOUT :
>  			  -EILSEQ;

Should be a blank line here after the local variable declarations.

> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_AUTO_CMD);
>  
>  		if (sdhci_auto_cmd23(host, mrq)) {
>  			mrq->sbc->error = err;
> @@ -3342,6 +3349,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  				host->data_cmd = NULL;
>  				data_cmd->error = -ETIMEDOUT;
> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>  				__sdhci_finish_mrq(host, data_cmd->mrq);
>  				return;
>  			}
> @@ -3375,18 +3383,25 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		return;
>  	}
>  
> -	if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		host->data->error = -ETIMEDOUT;
> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
> +	}

The parenthesis should be with the 'else'.  Please use checkpatch with the --strict option
and fix the issues.

>  	else if (intmask & SDHCI_INT_DATA_END_BIT)
>  		host->data->error = -EILSEQ;
>  	else if ((intmask & SDHCI_INT_DATA_CRC) &&
>  		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
> -			!= MMC_BUS_TEST_R)
> +			!= MMC_BUS_TEST_R) {
>  		host->data->error = -EILSEQ;
> +		if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +				host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);

As previously:

		if (!mmc_op_tuning(host->cmd->opcode))
			sdhci_err_stats_inc(host, DAT_CRC);

> +	}
>  	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>  		       intmask);
>  		sdhci_adma_show_error(host);
> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
>  		host->data->error = -EIO;
>  		if (host->ops->adma_workaround)
>  			host->ops->adma_workaround(host, intmask);
> @@ -3905,20 +3920,33 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  	if (!host->cqe_on)
>  		return false;
>  
> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>  		*cmd_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_CRC) {
> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)

Please count INDEX and END_BIT errors same as CRC errors i.e. just

		if (!mmc_op_tuning(host->cmd->opcode))
			sdhci_err_stats_inc(host, CMD_CRC);

> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
> +		}
> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>  		*cmd_error = -ETIMEDOUT;
> -	else
> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
> +	} else
>  		*cmd_error = 0;
>  
> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>  		*data_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +		if (intmask & SDHCI_INT_DATA_CRC) {
> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)

Please count END_BIT error same as CRC error i.e. just

		if (!mmc_op_tuning(host->cmd->opcode))
			sdhci_err_stats_inc(host, DAT_CRC);

> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
> +		}
> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		*data_error = -ETIMEDOUT;
> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		*data_error = -EIO;
> -	else
> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
> +	} else
>  		*data_error = 0;
>  
>  	/* Clear selected interrupts. */

