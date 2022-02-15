Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698C34B76A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbiBOSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:43:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbiBOSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:42:59 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DB927FEA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644950566; x=1676486566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uq3mK2F4oBeJy49d6SR0mO9NdzovVt3JSrPgHEwNGYw=;
  b=W5YTAaFfp7s1FpSHaJ9WNGYT3P2ugleLxF6xKi8I8zrdGd5Vj8hX7AOe
   QxerCg3RQ3Vm37LVgzaFJBmG19y7NGIkqbZkPuemIep89kORBbrnHTTr3
   8CougRYcS/lBM38SHVjwBzYrZ+A1+KSIw6qPaKTGtohR3UFgwFW1TrXWw
   NT+atc1II32rMbbFet12Hq21a0o484tWISodtRPkYZYfVRrRpwdZZz2DL
   wfAzkfk9tJxVfMIcmWtFzU0ZXZwQk/2A6dg91WQQOciZIXRZJ0MDbGe18
   yOWXbed1HRZuRc3dF7VKzn4hnR9cPSkNylRa+72Fc+Kn+oLEARqOj+6y7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311167725"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311167725"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:42:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="624957742"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:42:43 -0800
Date:   Tue, 15 Feb 2022 10:42:42 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Message-ID: <Ygv0IncyBA3pXR7Q@agluck-desk3.sc.intel.com>
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208150945.266978-1-juew@google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 07:09:45AM -0800, Jue Wang wrote:
> +static bool quirk_skylake_repmov(void)
> +{
> +	u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
> +	u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
> +
> +	if ((mcgstatus & MCG_STATUS_LMCES) &&
> +	    unlikely(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
> +		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
> +

Needs a comment that this big blob of logic is checking for a software
recoverable data fetch error.

> +		if ((mc1_status &
> +		     (MCI_STATUS_VAL|MCI_STATUS_OVER|MCI_STATUS_UC|MCI_STATUS_EN|
> +		      MCI_STATUS_ADDRV|MCI_STATUS_MISCV|MCI_STATUS_PCC|
> +		      MCI_STATUS_AR|MCI_STATUS_S)) ==
> +		    (MCI_STATUS_VAL|MCI_STATUS_UC|MCI_STATUS_EN|MCI_STATUS_ADDRV|
> +		     MCI_STATUS_MISCV|MCI_STATUS_AR|MCI_STATUS_S)) {
> +			msr_clear_bit(MSR_IA32_MISC_ENABLE,
> +				      MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);
> +			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
> +			pr_err_once("Errata detected, disable fast string copy instructions.\n");
> +			return true;
> +		}
> +	}
> +	return false;
> +}

Otherwise:

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
