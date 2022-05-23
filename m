Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73322530A73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiEWHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiEWHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:23:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B431935;
        Mon, 23 May 2022 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653290106; x=1684826106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vJCMQiIR7liz2b404hqMCKac/tqlSpulijF21UcO9eI=;
  b=g3EOpxy8eNhxB6L1zDDq8fs0cn6ov5nuuKc3dRJ2kdWWVujZT0Hv4ytb
   NCChtkD/vrBQ4n4a5kGZPlx9QKEAMRgZrSyeuf6s8ZZGU6CIl5BFQD2UV
   HfFhI+xPMVcPwY7VA1qXZxIVkw1YLoiZipYcucs8pZ7Iu/BumKtddcTDw
   XnHaU1IDB2j0yjIJaGDYFQL0KHq+mBM1D2sMgKuSXFAN1VDVXvG94M/XV
   gUfc9r97yZY2PqiWoM782mjYU7GQTK+YEyd5fVI6FpM6GPQF3Rt39/pz+
   IMtebzwiFvs9rE3WpHq4TlZauyZF3kIcNY/hc/7/YlQ5F9Ttbm8EfaDGY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="336190510"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="336190510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:14:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="600488440"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:14:46 -0700
Message-ID: <23b27e40-5b6d-22cb-8e87-19e7378db849@intel.com>
Date:   Mon, 23 May 2022 10:14:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V6 1/5] mmc: core: Capture eMMC and SD card errors
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        shawn.lin@rock-chips.com, yoshihiro.shimoda.uh@renesas.com,
        digetx@gmail.com, quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1652857340-6040-2-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1652857340-6040-2-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/22 10:02, Shaik Sajida Bhanu wrote:
> Add changes to capture eMMC and SD card errors.
> This is useful for debug and testing.
> 
> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

Seems to need to be re-based on Ulf's next branch:

	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/core.c  | 10 +++++++++-
>  include/linux/mmc/host.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f104..5db5adf 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -943,9 +943,11 @@ int mmc_execute_tuning(struct mmc_card *card)
>  	}
>  
>  	/* Only print error when we don't check for card removal */
> -	if (!host->detect_change)
> +	if (!host->detect_change) {
>  		pr_err("%s: tuning execution failed: %d\n",
>  			mmc_hostname(host), err);
> +		mmc_debugfs_err_stats_inc(host, MMC_ERR_TUNING);
> +	}
>  
>  	return err;
>  }
> @@ -2242,6 +2244,12 @@ void mmc_rescan(struct work_struct *work)
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
> index 0c0c9a0..0d7c0f7 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -93,6 +93,25 @@ struct mmc_clk_phase_map {
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
> +	MMC_ERR_CTRL_TIMEOUT,
> +	MMC_ERR_UNEXPECTED_IRQ,
> +	MMC_ERR_MAX,
> +};
> +
>  struct mmc_host_ops {
>  	/*
>  	 * It is optional for the host to implement pre_req and post_req in
> @@ -498,6 +517,7 @@ struct mmc_host {
>  	/* Host Software Queue support */
>  	bool			hsq_enabled;
>  
> +	u32			err_stats[MMC_ERR_MAX];
>  	unsigned long		private[] ____cacheline_aligned;
>  };
>  
> @@ -632,6 +652,12 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>  	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  }
>  
> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
> +					     enum mmc_err_stat stat)
> +{
> +	host->err_stats[stat] += 1;
> +}
> +
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  

