Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53334D13D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiCHJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbiCHJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:50:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B7344E5;
        Tue,  8 Mar 2022 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646732979; x=1678268979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qS7NRU3y0mPGTQHX2B4ljPRVEixQqYfSMWZPORyjxOw=;
  b=QsSCtZBlutyNoJuZAGP1SOYlnOZmJZ8j3XYRMVTHq/5+NeVh+YaYsZDA
   HMKnvZtkBepxZ/aAEfkuBRB9lXf3BpEa2Jq9Q5455LmwFcmRPoYsnMfjK
   w6cy9yIOhKSOqMyRBxdNvwNMiosDsiAkCL4SbIqx27SGorq6VATUm6oY5
   fqvqoBb1kZgz9CKxR2QxJOkiFLbl257Ux/uggTKQCtVFw9Q4C8iit1BTb
   AgXBsH3u7xKefJjLXfy/DV+ptOHGxLRDoTK1IamVbpN+y0h6Dh1W27j2L
   IpbVnLVSdgtH3biXJNHhgfqhrRfFhpidvkMhBmiHbuzjUitxwQ8Qp4Ptl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234597253"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="234597253"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:49:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="553553451"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.193])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:49:35 -0800
Message-ID: <29a1a50c-bb65-25a4-b09e-7a869490231e@intel.com>
Date:   Tue, 8 Mar 2022 11:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V4 3/7] mmc: debugfs: Add debug fs entry for mmc driver
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        asutoshd@quicinc.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-4-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1646226227-32429-4-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.3.2022 15.03, Shaik Sajida Bhanu wrote:
> Add debug fs entry to query eMMC and SD card errors statistics
> 
> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/mmc/core/debugfs.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 3fdbc80..db0988c 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -223,6 +223,63 @@ static int mmc_clock_opt_set(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>  	"%llu\n");
>  
> +static int mmc_err_stats_show(struct seq_file *file, void *data)
> +{
> +	struct mmc_host *host = (struct mmc_host *)file->private;
> +	const char *desc[MMC_ERR_MAX] = {
> +		[MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
> +		[MMC_ERR_CMD_CRC] = "Command CRC Errors Occurred",
> +		[MMC_ERR_DAT_TIMEOUT] = "Data Timeout Occurred",
> +		[MMC_ERR_DAT_CRC] = "Data CRC Errors Occurred",
> +		[MMC_ERR_AUTO_CMD] = "Auto-Cmd Error Occurred",
> +		[MMC_ERR_ADMA] = "ADMA Error Occurred",
> +		[MMC_ERR_TUNING] = "Tuning Error Occurred",
> +		[MMC_ERR_CMDQ_RED] = "CMDQ RED Errors",
> +		[MMC_ERR_CMDQ_GCE] = "CMDQ GCE Errors",
> +		[MMC_ERR_CMDQ_ICCE] = "CMDQ ICCE Errors",
> +		[MMC_ERR_REQ_TIMEOUT] = "Request Timedout",
> +		[MMC_ERR_CMDQ_REQ_TIMEOUT] = "CMDQ Request Timedout",
> +		[MMC_ERR_ICE_CFG] = "ICE Config Errors",
> +	};
> +	int i;
> +
> +	if (!host)
> +		return -EINVAL;

Do not need to check host here

> +
> +	for (i = 0; i < MMC_ERR_MAX; i++) {
> +		if (desc[i])
> +			seq_printf(file, "# %s:\t %d\n",
> +					desc[i], host->err_stats[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mmc_err_stats_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, mmc_err_stats_show, inode->i_private);
> +}
> +
> +static ssize_t mmc_err_stats_write(struct file *filp, const char __user *ubuf,
> +				   size_t cnt, loff_t *ppos)
> +{
> +	struct mmc_host *host = filp->f_mapping->host->i_private;
> +
> +	if (!host)
> +		return -EINVAL;

Do not need to check host here

> +
> +	pr_debug("%s: Resetting MMC error statistics\n", __func__);
> +	memset(host->err_stats, 0, sizeof(host->err_stats));
> +
> +	return cnt;
> +}
> +
> +static const struct file_operations mmc_err_stats_fops = {
> +	.open	= mmc_err_stats_open,
> +	.read	= seq_read,
> +	.write	= mmc_err_stats_write,
> +};
> +
>  void mmc_add_host_debugfs(struct mmc_host *host)
>  {
>  	struct dentry *root;
> @@ -236,6 +293,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>  	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>  				   &mmc_clock_fops);
>  
> +	debugfs_create_file("err_stats", 0600, root, host,
> +		&mmc_err_stats_fops);
> +
>  #ifdef CONFIG_FAIL_MMC_REQUEST
>  	if (fail_request)
>  		setup_fault_attr(&fail_default_attr, fail_request);

