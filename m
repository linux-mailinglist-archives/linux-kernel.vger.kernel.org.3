Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A356552F0ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351780AbiETQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiETQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:44:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2B717DDD9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653065066; x=1684601066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ciO0kBoZZmdwy8SM6NT74DC/ofmCkiIKcxaKmJyLWk=;
  b=cdtBIu070VNSig9gjmasyocWM5LmPQHHZS3WLN3pwqFH+jrL2unuTQyA
   K/yv+98D5nw0MbvD3xffVuf5YcEeGaQIkhmoKSXjxCR5KFQDL1YNEFl08
   K58r3g4zWGmrVbg+eQJOoOzzISBI2iRu/jQ9uQbdZyRT05dbTcV1ZT9Yv
   /aSR5+ksv39UrCFDhgIgnFqoB8Z01LXfiP4f/0M9lMLgKoNEuSRUENU0n
   Q6AqMlQA1o6fU38gSxvAu/C2xQ4mqDVxRagCMlILAc6fm/gytSxVnksxT
   PkCd+tNb71BFbXslrPbNq/HISvTsEeIi0DwH6sR8F5AV5B0han+VsU2eL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="254716852"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="254716852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 09:44:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="570893664"
Received: from luislore-desk2.amr.corp.intel.com (HELO [10.212.196.93]) ([10.212.196.93])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 09:44:25 -0700
Message-ID: <7dffbd70-d7db-6d58-abbb-19006cd9e4a2@intel.com>
Date:   Fri, 20 May 2022 09:44:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] x86: fix platform info detection in frequency
 invariance
Content-Language: en-US
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220520161022.5972-1-ggherdovich@suse.cz>
 <20220520161022.5972-2-ggherdovich@suse.cz>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220520161022.5972-2-ggherdovich@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 09:10, Giovanni Gherdovich wrote:
>  	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
>  		goto out;
>  
> -	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
> -	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> +	if (x86_match_cpu(has_glm_turbo_ratio_limits)) {
> +		skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1);
>  		goto out;
> +	}
>  
> -	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
> -	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> +	if (x86_match_cpu(has_knl_turbo_ratio_limits)) {
> +		knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1);
>  		goto out;
> +	}
>  
> -	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
> -	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
> +	if (x86_match_cpu(has_skx_turbo_ratio_limits)) {
> +		skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4);
>  		goto out;
> +	}
>  
>  	if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
>  		goto out;

But didn't the last patch in the series carefully change the return
value for knl_set_max_freq_ratio()?  Now, the only call site is ignoring
the return value?  That seems odd.

Also, this is a mess.  These constructs:

static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
        X86_MATCH(XEON_PHI_KNL),
        X86_MATCH(XEON_PHI_KNM),
        {}
};

static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
        X86_MATCH(SKYLAKE_X),
        {}
};

static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
        X86_MATCH(ATOM_GOLDMONT),
        X86_MATCH(ATOM_GOLDMONT_D),
        X86_MATCH(ATOM_GOLDMONT_PLUS),
        {}
};

are rather goofy.  A single array like rapl_ids[] that points to the
handler function would do us a lot more good here, say:

static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
        X86_MATCH(XEON_PHI_KNL, 	&knl_set_max_freq_ratio),
        X86_MATCH(XEON_PHI_KNM, 	&knl_set_max_freq_ratio),
        X86_MATCH(SKYLAKE_X,		&skx_set_max_freq_ratio),
        X86_MATCH(ATOM_GOLDMONT, 	&skx_set_max_freq_ratio),
        X86_MATCH(ATOM_GOLDMONT_D,	&skx_set_max_freq_ratio),
        X86_MATCH(ATOM_GOLDMONT_PLUS,	&skx_set_max_freq_ratio),
	X86_MATCH(ANY,			&core_set_max_freq_ratio),
        {}
};

That would get rid of all the goofy gotos and actually puts all the
logic in one place.  BTW, I'm not 100% sure about the 'ANY' line.  I
think that's how those work, but please double-check me on it.

While it's generally best to keep bug fixes to a minimum, I think this
one is worth a bit of a cleanup because it will remove a bunch of spaghetti.
