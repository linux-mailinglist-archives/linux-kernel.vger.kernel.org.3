Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2A4AC891
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiBGSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiBGSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:24:47 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 10:24:47 PST
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8EC0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644258287; x=1675794287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iEthWzhLhgfla9mBgcMk3I3im8SSm2ybD3uCeC+OHOg=;
  b=OtMqY5kNuqY1LJR4rRnx1fu94LZo54QwNyslFN8+zh+BXH5G5Wx+vdn9
   JE3zxPDZD9yXrN8TqRRJZiWUWUIN+tkEahoOyG54njaJFMJhnbaRE1fg/
   Iww7aU22VAr6Tpul7zLI0w6bAuhnO0J0aX+EtsapqYUE/xrTBBleRpYCL
   bKkYup7mAblW9fLvQ47FsUQioQN7+14h7EXUh3Tz4XbOUAwpqnOnHxvut
   +Zqa3zJRd8UoP2xwfxL8bYaTJ9P4JxkLyadWkqGvB8Q/KjUMnG85Y/xHE
   69y9pM9KsZL2CVSBbuvZxIbYw0vHUly2LYvD77HcgaMdeaRlOpLrvEn2t
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="229427855"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="229427855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:23:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="484514992"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:23:43 -0800
Date:   Mon, 7 Feb 2022 10:23:42 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Message-ID: <YgFjrmFuc/b+0OCE@agluck-desk2.amr.corp.intel.com>
References: <20220207043640.2829295-1-juew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207043640.2829295-1-juew@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 08:36:40PM -0800, Jue Wang wrote:
> +static bool quirk_skylake_repmov(void)
> +{
> +	/*
> +	 * State that represents if an SRAR MCE has already signaled on the DCU bank.
> +	 */
> +	static DEFINE_PER_CPU(bool, srar_dcu_signaled);
> +
> +	if (unlikely(!__this_cpu_read(srar_dcu_signaled))) {
> +		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));

Jue,

When I reviewed this for you off-list, I didn't notice that you
dropped the test for mcgstatus & MCG_STATUS_LMCES as part of
moving to a helper function and expanding the test for more
bits in mc1_status.

I think that test still is still important ... knowing that this is
a *local* machine check before making decision based on just what this
CPU observes makes this a bit more robust.

> +
> +		if (is_intel_srar(mc1_status)) {
> +			__this_cpu_write(srar_dcu_signaled, true);
> +			msr_clear_bit(MSR_IA32_MISC_ENABLE,
> +				      MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);
> +			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
> +			pr_err("First SRAR MCE on DCU, CPU: %d, disable fast string copy.\n",
> +			       smp_processor_id());
> +			return true;
> +		}
> +	}
> +	return false;
> +}

-Tony
