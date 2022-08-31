Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFF5A8819
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiHaV2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiHaV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:28:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72251F72F7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661981284; x=1693517284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=musxV+pJle43WpmKf3ovzZDYsRJYWlBwZEp2XM5jFQA=;
  b=VrBtpBHUu9D3twDekLQzFTgxqCnGNNomqgB0FG1togzXr8bE4r6ru2uL
   HCXYK7XDditK0mFeoSUTFZn9HGJa5jJ21tb1WxnhG81PCTxOV4Jc8Ggfm
   vAIJQfScFht9uGqXmtrO7iErX29MJINejAQ9N9tME6+QMFplhBqKAcgR5
   ttjhHmh5hYAf1Dda4LqQpos+q8BZ76Zvqi/GoX2jHlwH4jugpM5lCOTMm
   kTpaG4B18L0Zu5LDKlKBhMBS8GwOj+kjacf7N00+XvUi05aJ8Yn8YDy6h
   C3EnuE8mK2rEswkRZv35p9FpqG9cerTxI3uGCgSYC4Bd4KvLsmrDZHvb3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="278565983"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="278565983"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:28:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="612236338"
Received: from nkrobins-mobl2.amr.corp.intel.com (HELO [10.212.220.19]) ([10.212.220.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:28:03 -0700
Message-ID: <0dc761fe-3d98-8c80-8ee3-01804843e8f9@intel.com>
Date:   Wed, 31 Aug 2022 14:28:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/acrn: Set up timekeeping
Content-Language: en-US
To:     Fei Li <fei1.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        yu1.wang@intel.com, conghui.chen@intel.com
References: <20220804055903.365211-1-fei1.li@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220804055903.365211-1-fei1.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 22:59, Fei Li wrote:
> +static inline unsigned long acrn_get_tsc_khz(void)
> +{
> +	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
> +}
> +
>  /*
>   * Hypercalls for ACRN
>   *
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index 23f5f27b5a02..485441b7f030 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -28,6 +28,9 @@ static void __init acrn_init_platform(void)
>  {
>  	/* Setup the IDT for ACRN hypervisor callback */
>  	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
> +
> +	x86_platform.calibrate_tsc = acrn_get_tsc_khz;
> +	x86_platform.calibrate_cpu = acrn_get_tsc_khz;
>  }

Could you take a sec and consider what 'static inline' does and means
and also what setting:

	x86_platform.calibrate_cpu = acrn_get_tsc_khz;

does?

Using 'static inline' might compile, but it doesn't make sense.
