Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E5495A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378857AbiAUHKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:10:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:4714 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378849AbiAUHKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642749023; x=1674285023;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cM6sqe1tElQ75X6OU6MbVxnvuy1jBR7apqeVeis91xo=;
  b=aFlt8xfE+nQ8If20tCm2aIPGiAuIk+hgBRwpo9fsCZaCTwZiNdJFLS2A
   1u6HoPRZU55mz7gdHRsJt5JRuXtnK33Wt+tnfweg4Pdj4ivXm1vtwDh1W
   zmklA3eJy8IE3GB5V8J5kXc4KtnoJ2A0o5HrMJKERq3lKQat9KBknh78o
   0keSK/zoKOhjiejvdy+yXeTGS5B6+FLRp0q2JSTCs3vfFqnwehpKd+j2I
   49xjNokR5HGfvv82JFVplVvWBVOOCIkfos5RdY2USLnLZwNZczV+NK5gP
   B7EjPW28a+8Cmr3tUvnrLuODA2uOeI8NG6DWyDOzMhO8EZ2bdGWY/wQ3g
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="243179422"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="243179422"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 23:10:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="694541074"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2022 23:10:18 -0800
Subject: Re: [PATCH V3 2/4] mmc: debugfs: Add debug fs entry for mmc driver
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        quic_asutoshd@quicinc.com, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org, nitirawa@codeaurora.org,
        sayalil@codeaurora.org, Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-3-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0886f705-562f-6c8d-f396-60c2244b6375@intel.com>
Date:   Fri, 21 Jan 2022 09:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642699582-14785-3-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 19:26, Shaik Sajida Bhanu wrote:
> Add debug fs entry to query eMMC and SD card errors statistics
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/mmc/core/debugfs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 3fdbc80..f4cb594 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -223,6 +223,82 @@ static int mmc_clock_opt_set(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>  	"%llu\n");
>  
> +static int mmc_err_state_get(void *data, u64 *val)
> +{
> +	struct mmc_host *host = data;
> +
> +	if (!host)
> +		return -EINVAL;
> +
> +	*val = host->err_state ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
> +
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
> +
> +	if (!host->err_stats_enabled) {
> +		seq_printf(file, "Not supported by driver\n");
> +		return 0;
> +	}
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
> @@ -236,6 +312,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>  	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>  				   &mmc_clock_fops);
>  
> +	debugfs_create_file("err_state", 0600, root, host,
> +		&mmc_err_state);

Please, let's drop err_state for now

> +	debugfs_create_file("err_stats", 0600, root, host,
> +		&mmc_err_stats_fops);
> +
>  #ifdef CONFIG_FAIL_MMC_REQUEST
>  	if (fail_request)
>  		setup_fault_attr(&fail_default_attr, fail_request);
> 

