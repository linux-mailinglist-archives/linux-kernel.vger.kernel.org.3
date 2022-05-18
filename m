Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107F152BF78
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiERPl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiERPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:41:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073057177;
        Wed, 18 May 2022 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652888481; x=1684424481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=02mEOdEenFaDxhJfvBWh5KieQnIcJ6sG7CwO5VjZO1M=;
  b=DUAawwWOZmml2kWLLyfhwj6E2dQf1akugoRX9deJideVkA1qPVl1DfUo
   9M2EemQf1QVv1kdeB1LWzU4NpzrW2cdSl0ZiRixCIjDPl2i0NZYEboFPX
   RVwyxxEdgvwcL028PrmQ6LhRcR4UjPXX6wEW06UcUrgEzRqE+S6FznGNJ
   TLbs0puwUBik8ckffj0iq957AuZijIYeZ0cF3rSK1X4AsUhjYGSHPvyp5
   LDbXjarnsgLqU37DoPYypl34vbVbkvfb0Fgz/oum4n/OifRSLrJfdhRYp
   eYRSD2tzzTVJeP8vJyOz+2AKPOsqedudusq5+BODt/nDFL+6V8RkDd9HE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="297028437"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="297028437"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 08:41:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="817496990"
Received: from kackerma-mobl2.amr.corp.intel.com (HELO [10.209.69.102]) ([10.209.69.102])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 08:41:12 -0700
Message-ID: <25a2a82f-b5e5-0fce-86c8-03d7da5fcdd1@intel.com>
Date:   Wed, 18 May 2022 08:41:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com
References: <20220517222430.24524-1-chang.seok.bae@intel.com>
 <20220517222430.24524-2-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220517222430.24524-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 15:24, Chang S. Bae wrote:
> +/*
> + * Initialize register state that may prevent from entering low-power idle.
> + * This function will be invoked from the cpuidle driver only when needed.
> + */
> +void fpu_idle_fpregs(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_XGETBV1) &&
> +	    (xfeatures_in_use() & XFEATURE_MASK_XTILE)) {
> +		tile_release();
> +		fpregs_deactivate(&current->thread.fpu);
> +	}
> +}

This is a pretty minor nit, but:

X86_FEATURE_XFD depends on X86_FEATURE_XGETBV1

and

X86_FEATURE_AMX_TILE depends on X86_FEATURE_XFD

via cpu_deps[].  So there is an implicit dependency all the way from AMX
to XGETBV1.  It's also not patently obvious what X86_FEATURE_XGETBV1 has
to do with the rest of the if().

Would this make more logical sense to folks?

	/* Note: AMX_TILE being enabled implies XGETBV1 support */
	if (cpu_feature_enabled(X86_FEATURE_AMX_TILE) &&
	    (xfeatures_in_use() & XFEATURE_MASK_XTILE)) {
		tile_release();
		fpregs_deactivate(&current->thread.fpu);
	}

That also has a nice side effect that non-AMX systems will get to use a
static branch and can also skip over the XGETBV1 entirely.

The downside is that there's no explicit XGETBV1 check before calling
xfeatures_in_use().  But, I don't really expect the AMX->XGETBV1
dependency to go away either.
