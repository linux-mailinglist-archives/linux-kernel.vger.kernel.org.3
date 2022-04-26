Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4B50F327
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiDZH6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbiDZH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:57:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5F140A6;
        Tue, 26 Apr 2022 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650959685; x=1682495685;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I/IrGjNSloRWfQdKijiSV6qHBVDCc7ACt5r9Nt18Sak=;
  b=c4W0Hiy9upzYIUrcGqFay6fsFl8REo/BQQcEoLAZ9+leS7Fa/LjVWvKs
   LdRyo60EO0nRycVreTCX9DXlgbs510V5LEGeCA+x0kgcUnBEuDRsSK02p
   hLC7khSqDEdCASbqBKm/9nO3aWzqFJ2hCV37HCiqjuZtiF9zLdXbObGDf
   YF3nkdVZ77bX6Rpk7Es2ZAC5rBHscMuVhE3ZnVAc8npGbSjWEyiTyMWyL
   0ouG8/8/L9DhDIUOSSbaxdhJAPaCX3KFAH1GrI+GKx+C90AyYXFP/NMIQ
   +4T6/0Mg8Mja++rjI5cktEK6ZAkDqK8mhiRETpXUbo4H83kP2MLWY9TwR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245412652"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="245412652"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:54:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="558172149"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.98])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:54:37 -0700
Message-ID: <ce5582e3-0d8d-f1cf-0d23-8fbf17226775@intel.com>
Date:   Tue, 26 Apr 2022 10:54:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V5 4/5] mmc: debugfs: Add debug fs error state entry for
 mmc driver
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        yoshihiro.shimoda.uh@renesas.com, linus.walleij@linaro.org,
        digetx@gmail.com, briannorris@chromium.org,
        quic_riteshh@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1650902443-26357-5-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1650902443-26357-5-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/22 19:00, Shaik Sajida Bhanu wrote:
> Add debug fs entry error state to query eMMC and SD card errors statistics.
> If any errors occurred in eMMC and SD card driver level then
> err_state value will be set to 1.
> 
> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/mmc/core/debugfs.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 6aa5a60..2f5b63f 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -222,6 +222,29 @@ static int mmc_clock_opt_set(void *data, u64 val)
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>  	"%llu\n");

A blank line would be nice here

> +static int mmc_err_state_get(void *data, u64 *val)
> +{
> +	struct mmc_host *host = data;
> +
> +	if (!host)
> +		return -EINVAL;
> +

I am not sure why you have left out some err_stats[].
Why not all of them?  At least, it needs a comment to explain.

> +	*val = host->err_stats[MMC_ERR_REQ_TIMEOUT] ||
> +	       host->err_stats[MMC_ERR_ADMA] ||
> +	       host->err_stats[MMC_ERR_CTRL_TIMEOUT] ||
> +	       host->err_stats[MMC_ERR_UNEXPECTED_IRQ] ||
> +	       host->err_stats[MMC_ERR_CMDQ_RED] ||
> +	       host->err_stats[MMC_ERR_CMDQ_GCE] ||
> +	       host->err_stats[MMC_ERR_CMDQ_ICCE] ||
> +	       host->err_stats[MMC_ERR_DAT_TIMEOUT] ||
> +	       host->err_stats[MMC_ERR_DAT_CRC] ||
> +	       host->err_stats[MMC_ERR_CMD_CRC] ||
> +	       host->err_stats[MMC_ERR_CMD_TIMEOUT];
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
>  
>  static int mmc_err_stats_show(struct seq_file *file, void *data)
>  {
> @@ -289,6 +312,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>  	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>  				   &mmc_clock_fops);
>  
> +	debugfs_create_file("err_state", 0600, root, host,
> +			    &mmc_err_state);
>  	debugfs_create_file("err_stats", 0600, root, host,
>  			    &mmc_err_stats_fops);
>  

