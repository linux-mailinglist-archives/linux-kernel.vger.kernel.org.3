Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733B159CB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbiHVWb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHVWbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:31:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AF150733
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661207482; x=1692743482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gwgkmAh1m4dxY9h21mXik/a1rHa0oTuFFeRyk4XA4BM=;
  b=aSk/fiDPRheOdZYsfg6l38MhMV3XBDjK+poDbrNqW6ft8fsCEr68Hf+f
   4Gt41zUJvlA8427o1AZOlnnlrTCfEpTX7sJBH3Vyy4T9A9hlamXounsNu
   Yjcv+Lfe61AHqRCqgoxltF41i5UuaIpTBByS1YW+k5NV/EV2KpHwHFfZb
   zCZB5ya32/IWl/vjLXeM6B48HWUBpJDb8W91JsLO6kjxKUs6GFqyxE9D4
   RqlFBA6Ngud15/42dFle29cZ7rBpuPwswFemCMIdt5+sE49qa/TpuHMuE
   n//ZEjDVyzUpZLSejyWKN9bHDrcbHe0nJpgTPUbcISAXVB+AEW48nenTj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355266571"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="355266571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:31:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751455019"
Received: from jcsarker-mobl.amr.corp.intel.com (HELO [10.212.204.203]) ([10.212.204.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:31:21 -0700
Message-ID: <09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
Date:   Mon, 22 Aug 2022 15:31:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
 <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 13:12, Jacob Pan wrote:
> @@ -394,7 +395,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>  	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
>  			PASID_FLAG_SUPERVISOR_MODE : 0;
>  	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
> -	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
> +
> +	pgd = static_cpu_has(X86_FEATURE_PTI) ? kernel_to_user_pgdp(mm->pgd) : mm->pgd;
> +	ret = intel_pasid_setup_first_level(iommu, dev, pgd, mm->pasid,
>  					    FLPT_DEFAULT_DID, sflags);

This X86_FEATURE_PTI should really be done within a helper.

I'd probably do this with a *new* helper since all of the existing
kernel_to_user_pgdp() users seem to be within a PTI #ifdef.

Maybe something like:

pgd_t *mm_user_pgd(struct mm_struct *mm)
{
#ifdef CONFIG_PAGE_TABLE_ISOLATION
	if (cpu_feature_enabled(X86_FEATURE_PTI))
		return kernel_to_user_pgdp(mm->pgd);
#endif
	return mm->pgd;
}

That #ifdef could even go away if your kernel_to_user_pgdp() stub from
patch 1/2 was available.  I'm not sure it's worth it though.
