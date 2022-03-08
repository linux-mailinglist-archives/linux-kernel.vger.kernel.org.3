Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C904D0EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbiCHFQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiCHFQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:16:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908036B41;
        Mon,  7 Mar 2022 21:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646716534; x=1678252534;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gG7N1W4Kxhwbbk1jZERSsHzsE69OmsTBNUffQnkDmK8=;
  b=nLvLdwXuSa3pb74zDIuEUmUelkSu7nMD3fCqbVhdzeJsdPjUHcVc7T1T
   fjG+kNLzb4r3V8CUdywpRmQf4jjreu8Zjt0SHPyX68DYfkuHfVuG2KGEU
   JGOtl2eSlt7+UmmAe5CiTUASjS19LBSfVIPGEJyD4POyyC5Men5vyWwXy
   s7VdEAHL2Dkgm5ZRHnxdM8htoz/tbjIhMRZYmdHgihK+rd5PTCAqSo40U
   uLHUn3Owsf+Y1oeKoavYvqfpExt8mR0/uKDSzUo7m46SbqAYRztEp95UP
   4sipcE4dTnY4ZeAQqQAU+NKIOgFps3gcPZxTuBaccSJHzQiVU2fTuynUd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="242030981"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="242030981"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553475743"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2022 21:15:29 -0800
Message-ID: <52bbbd92-17d4-a5ea-150e-28cf56bb0a67@intel.com>
Date:   Tue, 8 Mar 2022 07:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH v1] scsi: ufs: exclude UECxx from SFR dump list
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com,
        vkumar.1997@samsung.com
References: <CGME20220307024436epcas2p1cb5b07d5149b37610819fa3d70af59ea@epcas2p1.samsung.com>
 <1646621010-118886-1-git-send-email-kwmad.kim@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1646621010-118886-1-git-send-email-kwmad.kim@samsung.com>
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

On 07/03/2022 04:43, Kiwoong Kim wrote:
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
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 460d2b4..8b65c081 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -115,8 +115,12 @@ int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
>  	if (!regs)
>  		return -ENOMEM;
>  
> -	for (pos = 0; pos < len; pos += 4)
> +	for (pos = 0; pos < len; pos += 4) {
> +		if (pos >= REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER	&&
> +		    pos <= REG_UIC_ERROR_CODE_DME)

Doesn't that need to be 'pos + offset' not just 'pos'

> +			continue;
>  		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
> +	}
>  
>  	ufshcd_hex_dump(prefix, regs, len);
>  	kfree(regs);

