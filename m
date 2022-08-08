Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2E58CBF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiHHQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiHHQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:16:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727FE2F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659975402; x=1691511402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AHKOSJfx9sfhymH+KWHGEArl0fFEYk4Nl4ovAS9MYK8=;
  b=TAQrf5eWU/5whIrhsW0fvkcGEtkfGefEVfUS9qmecTmHEJgJNxq3NnLQ
   ujfA8XmjeQfl/JLm6SmtLzclKhuJ2X65yOoig8Sz/rdtFHwMe9/G11b8+
   AXNKmRLOzzxVKsFYD5d/m54kX1DFl8RIuLI6HfOwbYP4w57248SodyBMv
   ItLU65ed1ChhAf/0s0GiZ8i8odiq0rEnlh8suTRRICc8sbRPKkI6Cu+3U
   +3cQu4Ly/5d3NOvf6zvXqe/oJ5rzfYN56LOQtdAuMhiXuKXFedeCeAqrG
   PslfSMpVanmRTS0r6QjJQokPJVLLZfHmvXKdvAdYjgSGAC4er6EG904Rr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="354633146"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="354633146"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:16:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="604424900"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO [10.212.251.15]) ([10.212.251.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:16:42 -0700
Message-ID: <01768c70-a012-0d08-cfa5-a7a87ff0a19c@intel.com>
Date:   Mon, 8 Aug 2022 09:16:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com> <Yu4t0jkpIY4grgxL@gmail.com>
 <Yu4wON0MRGH7h5Jv@zn.tnic> <Yu+Nwbn4CZUmyD14@gmail.com>
 <Yu+VV8xFTYRh0D0a@zn.tnic> <YvAaXet3sBg3mRDe@iweiny-desk3>
 <YvDtfKRyMGenRMU5@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YvDtfKRyMGenRMU5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 04:03, Ingo Molnar wrote:
>> Again, I don't believe this is too much overhead but I don't want people 
>> to say it was not discussed.
> Is it necessary to do this, what are the alternatives, can this overhead be 
> avoided?

One thing Andy mentioned is that we _could_ get it down to two instructions:

	rdgsbase $reg
	push $reg

This could be hidden in:

	PUSH_PTREGS_AUXILIARY

where, today, it would only net add a single instruction.  But, if we
ever add more stuff to PUSH_PTREGS_AUXILIARY, it would move back to
needing two instructions since we'd need both the:

	subq $PTREGS_AUX_SIZE, %rsp

and something to write gsbase to the stack.

That doesn't get us the smp_processor_id() directly, but we can derive
it later on from the gsbase value.

The downside is that we're doing it in assembly.  We'd also have
something additional which is a bit uglier and that reads memory on
!X86_FEATURE_FSGSBASE, probably:
	
	movq    PER_CPU_VAR(cpu_number), %reg
	push %reg

Which would require some different code to decode what was there:

int read_exception_cpu_number(ext_pt_regs *e)
{
	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE))
		return gsbase_to_cpu_number(e->ext_cpu_nr);
	else
		return e->ext_cpu_nr;
}

I'm thinking that the whole racy smp_processor_id() thing wasn't so bad
in the first place.
