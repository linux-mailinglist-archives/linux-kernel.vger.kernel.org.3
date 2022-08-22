Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1326A59C8C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiHVT0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiHVTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:24:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015F52E62
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661196120; x=1692732120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BXjabKXvUP6pIOQf6cTQSSsp5mRc8PrmGqdNnHdELwo=;
  b=ko22IerKHvVCIslQH3IRkEekm2iP2lawD3D2KXbEYQ0fhesWW2cBiDMC
   1lfiieM9/WFn4t+5mv0IVRmwNYwTxLI/StQpkpO8/N9SzYhnqBO4XyNsQ
   W73nZMYDJ5reKRfQOmet0ZKefYSHT6rUfFCQP9xcwpnvC8AyujeKXErTQ
   5IrvEvjAuRilHK2NS/+UW0O8UuKKMCbhiX6pZOcgsf4tXR2lUMT9IuFs9
   VnqEwLi5EIuNgOsH87zUndxqP+wJVU+9Jz/6ZoJDih5ihOwnnkJXIHp5p
   SMuB2dZct2Aex2AlcvvnHZxHJDRZ5/74oQ4aL7BoU7Wi/O+8em/9/tqrN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355232771"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="355232771"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 12:21:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="585654843"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.228.10]) ([10.255.228.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 12:21:32 -0700
Message-ID: <0362e4e8-ab27-735d-510e-1dc208ccd17f@linux.intel.com>
Date:   Mon, 22 Aug 2022 21:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
 <c09ba37c-f685-15a3-3042-8cb3a0f91282@linux.intel.com>
 <YwOk991q0iBgcQWC@worktop.programming.kicks-ass.net>
 <YwPJJKxKI4vfQEVn@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YwPJJKxKI4vfQEVn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Checking X86_FEATURE_HYPERVISOR in the guest won't handle things like trying to
> run a non-hyrbid vCPU model on a hybrid CPU, because IIUC, the "is_hybrid()" is
> purely based on FMS, i.e. will be false if someone enumerates a big core vCPU on
> a hybrid CPU.
>
> So until KVM gets sane handling, shouldn't this be?
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f969410d0c90..0a8accfc3018 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2999,12 +2999,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>          }
>
>          cap->version            = x86_pmu.version;
> -       /*
> -        * KVM doesn't support the hybrid PMU yet.
> -        * Return the common value in global x86_pmu,
> -        * which available for all cores.
> -        */
> -       cap->num_counters_gp    = x86_pmu.num_counters;
> +       /* KVM doesn't support the hybrid PMU yet. */
> +       cap->num_counters_gp    = is_hybrid() ? 0 : x86_pmu.num_counters;

That's just the PMU. Arguably if you don't handle hybrid affinity you 
shouldn't report the hybrid bit ever to the guest. So need more than that.

But I guess Peter is concerned about the case when an old KVM is the 
host.  I think a short term workaround for that is fine, but I don't 
think it's a good idea to completely disable it since that will break 
future setups with correct hybrid hypervisor too. We already probe the 
PMU MSRs, can't we detect this case there too?

-Andi

