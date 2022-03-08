Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78084D139C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbiCHJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiCHJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:45:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4143A27FE7;
        Tue,  8 Mar 2022 01:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646732680; x=1678268680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AZmaKapkMakeK7sNyeCCno/sGLsAq5h6+En+/piE3b8=;
  b=ScPTqWTGETE113Ftm9Gugu5RIyI4dIeSxyoywhwhjJq8dr4C4rPKIK6c
   Pc/W8PmG0yB5fQj97eS8Ev+ckUo+FoJvEQXaCJNntOLqFXgJgJQl3o3BW
   ifgCX2eZjIoZsSidxT3GtczcMUkthFvOBOzoeBKOwrMwmpheVsXW2M+0t
   53yl12Ltr2/Nf1sxvVp54K31FWpPIchdLxYlTtRI4+TM+OYNsc8yRkT2g
   dG8Civ5S5nLpyQjLQ3hwAyyLJVUxfA03GHhbpqtLy4T2Q3AXg8j6G59FW
   ruVXUoP1K3FNRHX1zUBcAiIPYfpzYJ88bdSMS9nBkghEPoYcsNZfhp/8o
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="242080213"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="242080213"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:44:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="553552146"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.193])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:44:35 -0800
Message-ID: <c33540bc-0466-5a28-c85d-bfc8934b8c15@intel.com>
Date:   Tue, 8 Mar 2022 11:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V4 1/7] mmc: core: Capture eMMC and SD card errors
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
 <1646226227-32429-2-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1646226227-32429-2-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
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
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/mmc/core/core.c  |  6 ++++++
>  include/linux/mmc/host.h | 23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f104..f3679ed 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2242,6 +2242,12 @@ void mmc_rescan(struct work_struct *work)
>  		if (freqs[i] <= host->f_min)
>  			break;
>  	}
> +
> +	/*
> +	 * Ignore the command timeout errors observed during
> +	 * the card init as those are excepted.
> +	 */
> +	host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
>  	mmc_release_host(host);
>  
>   out:
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7afb57c..3b7f1e5 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -93,6 +93,23 @@ struct mmc_clk_phase_map {
>  
>  struct mmc_host;
>  
> +enum mmc_err_stat {
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
>  struct mmc_host_ops {
>  	/*
>  	 * It is optional for the host to implement pre_req and post_req in
> @@ -500,6 +517,7 @@ struct mmc_host {
>  
>  	/* Host Software Queue support */
>  	bool			hsq_enabled;
> +	u32                     err_stats[MMC_ERR_MAX];

This makes it look like err_stats has something to do with Host Software Queue.
Perhaps move it to be with debugfs_root. Also use tabs not spaces

	struct dentry		*debugfs_root;
	u32			err_stats[MMC_ERR_MAX];

>  
>  	unsigned long		private[] ____cacheline_aligned;
>  };
> @@ -635,6 +653,11 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>  	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  }
>  
> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
> +		enum mmc_err_stat stat) {
> +	host->err_stats[stat] += 1;
> +}
> +
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);

