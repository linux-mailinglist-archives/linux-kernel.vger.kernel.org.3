Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B682530ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiEWHYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiEWHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:23:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE13B7FD;
        Mon, 23 May 2022 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653290155; x=1684826155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ow9j/zlS+nPpHK9uJA1pcMosuC0zmgIRNB3sJevPSyc=;
  b=HgljwizAKTiYr9dKAYh9vOiKP4mytpyZV1edAGT4LOE73k03FR3wSWlu
   sR+uUGzuA6QaBowrDWG6VCdRYrCpa7yqi7bADXIlG1TkbqSHk0GI93aeT
   ftFUd+m+9twKCnLL53mP3KGZSj7oS7vc23CMOYlWoLdbeFqW3GZJsUJJt
   Y0WUisZ2OznYtvhg6NllU8BlmNaORg1XZlfshwzXGPO6rf0k4Ri4sh0mn
   MAGLdNKXexVub8WONKqnkuhcsrLxD3/Z594xUB3oQi1G/6tOXSo2L08jP
   eSv5p2W3ahLPuE/flSJHVNghWYBl3CV+ktaq2mI6tN2jK7UdKwOTHh9CL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="273125107"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="273125107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="600488927"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:15:50 -0700
Message-ID: <79590e32-5505-7a0c-81b4-0efd5c8f156f@intel.com>
Date:   Mon, 23 May 2022 10:15:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V6 4/5] mmc: debugfs: Add debug fs error state entry for
 mmc driver
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
 <1652857340-6040-5-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1652857340-6040-5-git-send-email-quic_c_sbhanu@quicinc.com>
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
> Add debug fs entry error state to query eMMC and SD card errors statistics.
> If any errors occurred in eMMC and SD card driver level then
> err_state value will be set to 1.
> 
> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

Could use debugfs_create_file_unsafe() (see below)

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/debugfs.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 6aa5a60..3c7908d 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -223,6 +223,27 @@ static int mmc_clock_opt_set(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>  	"%llu\n");
>  
> +static int mmc_err_state_get(void *data, u64 *val)
> +{
> +	struct mmc_host *host = data;
> +	int i;
> +
> +	if (!host)
> +		return -EINVAL;
> +
> +	*val = 0;
> +	for (i = 0; i < MMC_ERR_MAX; i++) {
> +		if (host->err_stats[i]) {
> +			*val = 1;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
> +
>  static int mmc_err_stats_show(struct seq_file *file, void *data)
>  {
>  	struct mmc_host *host = (struct mmc_host *)file->private;
> @@ -289,6 +310,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>  	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>  				   &mmc_clock_fops);
>  
> +	debugfs_create_file("err_state", 0600, root, host,
> +			    &mmc_err_state);

This could use debugfs_create_file_unsafe()

>  	debugfs_create_file("err_stats", 0600, root, host,
>  			    &mmc_err_stats_fops);
>  

