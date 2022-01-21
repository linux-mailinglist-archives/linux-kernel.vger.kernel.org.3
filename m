Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC1495BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349400AbiAUIWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:22:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:17782 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbiAUIWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642753356; x=1674289356;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KfpvKj/MrNut9hreQD0qctHDDKEvUkpRiuwVdo7nBV8=;
  b=SQXG+2G84UEyLqsnGcJ87ChpgxPsn/cVbNkG3B+BCb/XNk/zTts5ZCzj
   UdjlTUeOMv4DJlxaDVJWbnoqlyVIAf3yenE7MNCx4rm4mNHejvtcYIM26
   AuQNopA2y+tx8+F5P5PpeXvYAVwbe4ATL/rsml52BxB2c6owWKK+rJ8Q8
   4xXrWtPHjgopE6N30AvWQlHpkfjFjoQTlhF8O8zD38723CEH5GEbuIl7r
   3MYGM8b4+1uGWy/DPJrTFJI5A7VaCwyw0tNw6OjHd5sDVIoOG68FOHvo8
   sWpz88ScY0Zz1OQIsUnpAiOm/XtRo6F3Ra6iY+OJwWaHtqSggBTuHJlRi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245384540"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="245384540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="694561490"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 00:22:30 -0800
Subject: Re: [PATCH V3 4/4] mmc: cqhci: Capture eMMC and SD card errors
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
 <1642699582-14785-5-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ba814e99-6c36-04a2-ca8d-0ba8473309d8@intel.com>
Date:   Fri, 21 Jan 2022 10:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642699582-14785-5-git-send-email-quic_c_sbhanu@quicinc.com>
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
>  drivers/mmc/host/cqhci-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index b0d30c3..2908d30 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -822,8 +822,15 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>  	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc), status);
>  
>  	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
> -	    cmd_error || data_error)
> +	    cmd_error || data_error) {
> +		if ((status & CQHCI_IS_RED) && mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_RED);
> +		if ((status & CQHCI_IS_GCE) && (mmc->err_stats_enabled))
> +			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_GCE);
> +		if ((status & CQHCI_IS_ICCE) && mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(mmc, MMC_ERR_CMDQ_ICCE);

Please don't check mmc->err_stats_enabled

>  		cqhci_error_irq(mmc, status, cmd_error, data_error);
> +	}
>  
>  	if (status & CQHCI_IS_TCC) {
>  		/* read TCN and complete the request */
> 

