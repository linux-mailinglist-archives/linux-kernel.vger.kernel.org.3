Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5804D129A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbiCHIrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbiCHIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:47:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53C3FDB3;
        Tue,  8 Mar 2022 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646729199; x=1678265199;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Wb16vbWejhLrJiinHdbgfIvF0UmIay8cdh4wYFbX2jM=;
  b=CTr2TcMmLXv40N0AVOIdokz1Lf44VqR4IaGBQlwqKO78vAH5aC4KxOFk
   NgEHRW+ah7OwdN7NIpMWYtn680a8YM8iGLV/BivOTTWj4rLLRsAJNzQz0
   GVY7w52t7lNUkwwrmCdpuLcmwW+1a6tZljSw+vKVx/7htVsoGD+u9Fiug
   /3W+0DpFOQajBSXHTQ7Tc523qH8pn98YlWwfF26rNjFZyUJyQ8Caz4PVg
   MplDZTV6rP7BxVi6gqB0Khf/GFRTej48JiuwYp7Jf0Fi/tFUQQWgZ6LDH
   8o3vFWVY/9PxENm20Ur79r4HgdRPxg7s/j14glsIMS03yHjLlwkVgsV3h
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252204021"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="252204021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 00:46:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="553536539"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.193])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 00:46:34 -0800
Message-ID: <b2909fd3-fa5b-9471-fb9c-6f068a1ab871@intel.com>
Date:   Tue, 8 Mar 2022 10:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] scsi: ufs: exclude UECxx from SFR dump list
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com,
        vkumar.1997@samsung.com
References: <CGME20220308081304epcas2p4e7279fb51babf93fdf0bf0a3aacf9f68@epcas2p4.samsung.com>
 <1646727118-87159-1-git-send-email-kwmad.kim@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1646727118-87159-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.3.2022 10.11, Kiwoong Kim wrote:
> v1 -> v2: does skipping only for zero offset
> 
> These are ROC type things that means their values
> are cleared when the SFRs are read.
> They are usually read in ISR when an UIC error occur.
> Thus, their values would be zero at many cases. And
> there might be a little bit risky when they are read to
> be cleared before the ISR reads them, e.g. the case that
> a command is timed-out, ufshcd_dump_regs is called in
> ufshcd_abort and an UIC error occurs at the nearly
> same time. In this case, ISR will be called but UFS error handler
> will not be scheduled.
> This patch is to make UFS driver not read those SFRs in the
> dump function, i.e. ufshcd_dump_regs.

This is essentially a fix, so perhaps a fixes tag?

Wouldn't hurt to wrap the commit description more nicely.

> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 460d2b4..7f2a1ed 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -115,8 +115,13 @@ int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
>  	if (!regs)
>  		return -ENOMEM;
>  
> -	for (pos = 0; pos < len; pos += 4)
> +	for (pos = 0; pos < len; pos += 4) {
> +		if (offset == 0 &&

So it will still read them if the offset is not zero.  That seems unexpectedly inconsistent.

> +		    pos >= REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER &&
> +		    pos <= REG_UIC_ERROR_CODE_DME)
> +			continue;
>  		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
> +	}
>  
>  	ufshcd_hex_dump(prefix, regs, len);
>  	kfree(regs);

