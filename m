Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F4495BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbiAUIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:21:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:35657 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234217AbiAUIUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642753223; x=1674289223;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pkOa4YWHDLmUnKc8cIbSXeSpfM0kjB8mYv5kRipwEXQ=;
  b=HzXVqvn7hrmpcWEGXVUt8gJlO7skXrrcEt7mM5n7elwLC9jfDy/C4bvW
   RbcrLHRh7Ydv8kvh8aHqQeoepuTH2Xv3Sn6OE584cx8hpMinDNW5opTt0
   cNroE6pLZhg0VeDNdlubfVrEAtnZDUzz4Dbc0qvrNBfN3FAC2f1oXG+Yw
   snbQasItlafxEmZ6UyHGYp6gIVM+wEuhG50Bjpc0KHxzlOJb5Iab9l1eQ
   X3WQ8jyFiRDEHFdrdn6k8KewnQyHZf7JJ4x56n9GsFHgtq3ERw5Y7M2Us
   sX8pnhEyMe5KPpburgoJrYeSZ5drQADnmooXl2SW2whsdmWvyqGXtOzVn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="225578152"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="225578152"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="694560317"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 00:20:11 -0800
Subject: Re: [PATCH V3 3/4] mmc: core: Capture eMMC and SD card errors
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
 <1642699582-14785-4-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2989ff51-374e-3ab5-f8d4-19e0a1873a66@intel.com>
Date:   Fri, 21 Jan 2022 10:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642699582-14785-4-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 19:26, Shaik Sajida Bhanu wrote:
> Add changes to capture eMMC and SD card errors.
> This is useful for debug and testing.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> ---
>  drivers/mmc/core/core.c  | 8 ++++++++
>  drivers/mmc/core/queue.c | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f104..c586d69 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2242,6 +2242,14 @@ void mmc_rescan(struct work_struct *work)
>  		if (freqs[i] <= host->f_min)
>  			break;
>  	}
> +
> +	/*
> +	 * Ignore the command timeout errors observed during
> +	 * the card init as those are excepted.
> +	 */
> +

Please remove blank line here.

> +	if (host && host->err_stats_enabled)

The condition is not needed.

> +		host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;

Please put this after successful call to mmc_rescan_try_freq

>  	mmc_release_host(host);
>  
>   out:
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index c69b2d9..7dc9dfb 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -100,6 +100,9 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>  	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
>  	bool recovery_needed = false;
>  
> +	if (host->err_stats_enabled)
> +		mmc_debugfs_err_stats_inc(host, MMC_ERR_CMDQ_REQ_TIMEOUT);

Doesn't this get covered by the drivers.  It seems like this should not be needed.

> +
>  	switch (issue_type) {
>  	case MMC_ISSUE_ASYNC:
>  	case MMC_ISSUE_DCMD:
> 

