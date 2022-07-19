Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9040857A3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiGSQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:14:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411154C627
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658247295; x=1689783295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ya8p/XqEQDXif9q0doVi81vKSiS2nfdwL0eQcA7VleQ=;
  b=KfrdmgUx83DgPDljNccNQs2HNQULtxPYx9pFvSdFe7LTGFKZ8PwgjX0Y
   TGWys6/lAGduJXfUss/NKIWdHeEGxy6alPtnEtWxbr6H1tjKnaz9C1QfQ
   LDxuELJ0HCHorjdL4iu9pM/hfM4EIVGK4dlMnHYMAEXmLOPUL/h57Q4Xk
   6/RBmO4bi6nKeRB5jELpyimtcO/+VRYOziRs4StBAi/xgVLFAuDb/cJDI
   uOjhutiuANykUHnpq2Y/IdVPL5cm0GqVuEBQx3FDstUEfAoVaNt0ZzncD
   lwhNvaJayhet1XFCrctJ4+T71B1lnh6Yr6rEqMqX6YhzeJwkJhGyJ/5Hf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="350496783"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="350496783"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 09:13:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="572910114"
Received: from twliston-mobl1.amr.corp.intel.com (HELO [10.212.132.190]) ([10.212.132.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 09:13:23 -0700
Message-ID: <1648fbf5-0659-b480-1725-8a30eba51974@intel.com>
Date:   Tue, 19 Jul 2022 09:13:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220710232837.3618-1-namit@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220710232837.3618-1-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 16:28, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
> possible") introduced an optimization of skipping the flush if the TLB
> generation that is flushed (as provided in flush_tlb_info) was already
> flushed.
> 
> However, arch_tlbbatch_flush() does not provide any generation in
> flush_tlb_info. As a result, try_to_unmap_one() would not perform any
> TLB flushes.
> 
> Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
> anyhow is an invalid generation value. To avoid future confusions,
> introduce TLB_GENERATION_INVALID constant and use it properly. Add some
> assertions to check no partial flushes are done with
> TLB_GENERATION_INVALID or when f->mm is NULL, since this does not make
> any sense.
> 
> In addition, add the missing unlikely().

I've applied this:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/mm&id=8f1d56f64f8d6b80dea2d1978d10071132a695c5

Please double-check that my rewording of the commit message looks good
to you.  I also replaced the VM_BUG_ON()'s with warnings.  Screwing up
TLB flushing isn't great, but it's also not worth killing the system.
