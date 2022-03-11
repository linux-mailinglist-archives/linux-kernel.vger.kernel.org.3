Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314DE4D699A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiCKUmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiCKUmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:42:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12291D6F63
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647031308; x=1678567308;
  h=message-id:date:mime-version:from:to:cc:references:
   subject:in-reply-to:content-transfer-encoding;
  bh=d+V62j80p7kCm2OV0b4F2QuYNYGrrrxGrbo0cWvMM/A=;
  b=FTPqdbvjah/iYSSgkx4T7C+7/ZTSB1Vzx68gOiB78WCfE3kjRtblFoC7
   bpJYDM2rb5oQHHgTCBXLwRohoI3lWmds2DtQvs1dEaxgqv1jJ/Zsw0M5G
   HMaWnmywSE+yyagSXrFanBuff5d3CrkOsRpkWDvUKiXsBBxAwj5EIJqxc
   ZhdF80uQiWV+z8bxW2hfNqw7Rxh6fEmPJzRINXE1ht70LIcmac9pY0svf
   f8UeFNeoe0Ft3CA0zi2cqNDkNpnivxzs2ALOxOQD5bWg61ZKyQ5W5WlQ4
   lD20gNqe5GdBgDwaAc8N07akv0CItw5qIDZTT6lshjz7YKX2VwnS2VkuR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="235602800"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="235602800"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 12:41:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="645046437"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 12:41:47 -0800
Message-ID: <e5f84691-3475-1cbd-e46c-163bf594a4bc@intel.com>
Date:   Fri, 11 Mar 2022 12:41:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dave Hansen <dave.hansen@intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-6-namit@vmware.com>
Content-Language: en-US
Subject: Re: [RESEND PATCH v3 5/5] mm: avoid unnecessary flush on
 change_huge_pmd()
In-Reply-To: <20220311190749.338281-6-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 11:07, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Calls to change_protection_range() on THP can trigger, at least on x86,
> two TLB flushes for one page: one immediately, when pmdp_invalidate() is
> called by change_huge_pmd(), and then another one later (that can be
> batched) when change_protection_range() finishes.
> 
> The first TLB flush is only necessary to prevent the dirty bit (and with
> a lesser importance the access bit) from changing while the PTE is
> modified. However, this is not necessary as the x86 CPUs set the
> dirty-bit atomically with an additional check that the PTE is (still)
> present. One caveat is Intel's Knights Landing that has a bug and does
> not do so.

First of all, thank you for your diligence here.  This is a super
obscure issue.  I think I put handling for it in the kernel and I'm not
sure I would have even thought about this angle.

That said, I'm not sure this is all necessary.

Yes, the Dirty bit can get set unexpectedly in some PTEs.  But, the
question is whether it is *VALUABLE* and needs to be preserved.  The
current kernel code pretty much just lets the hardware set the Dirty bit
and then ignores it.  If it were valuable, ignoring it would have been a
bad thing.  We'd be losing data on today's kernels because the hardware
told us about a write that happened but that the kernel ignored.

My mental model of what the microcode responsible for the erratum does
is something along these lines:

	if (write)
		pte |= _PAGE_DIRTY;
	if (!pte_present(pte))
		#PF

The PTE is marked dirty, but the write never actually executes.  The
thread that triggered the A/D setting *also* gets a fault.

I'll double-check with some Intel folks to make sure I'm not missing
something.  But, either way, I don't think we should be going to this
much trouble for the good ol' Xeon Phi.  I doubt there are many still
around and I *REALLY* doubt they're running new kernels.

*If* we need this (and I'm not convinced we do), my first instinct would
be to just do this instead:

	clear_cpu_cap(c, X86_FEATURE_PSE);

on KNL systems.  If anyone cares, they know where to find us.
