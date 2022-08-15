Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE233593003
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiHONeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiHONdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:33:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BCC201B7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2tb0w40Fu2zdCcFs6ZUVcbW7rTOPIDoybVJIh3ibvtw=; b=ax+Wmnu+H069bkg0E2OOoboZVV
        Yhf2AhlnLFbvpIEs1VEenljURmrHzR6KISLtipuGpRZECX+cNYLgVUaCQqMs3Rhe63sWHx0C1E4EZ
        p2eK+C0haavPK72ewv/LS8vfvsudJXL9/tFaN9zMn5E+qPxcZswkA0MKOhwt61ARHb8GK5YSTNfQ3
        G7wclSvc6cJr1jwPzOyiJdxnN48fm5a5s7JuVPxbLGnomHSwrCJ4A2++0qJjf5bF/QsNfAlOOLayN
        PMMeMD1uTGBJluyjd/46WaE6LGHKrVhyIfmdNzRrgXIVpyFH+MQIXta/+zS5kcs3+0XPSJdDGd1gK
        Xrw6eJYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNaDg-005kle-SG; Mon, 15 Aug 2022 13:33:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 168DE980153; Mon, 15 Aug 2022 15:33:28 +0200 (CEST)
Date:   Mon, 15 Aug 2022 15:33:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 04/11] x86/mm: Handle LAM on context switch
Message-ID: <YvpLJ3n0u5KmLPwg@worktop.programming.kicks-ass.net>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815041803.17954-5-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 07:17:56AM +0300, Kirill A. Shutemov wrote:
> @@ -1071,8 +1082,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   */
>  unsigned long __get_current_cr3_fast(void)
>  {
> -	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
> -		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
> +	unsigned long cr3 =
> +		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
> +		this_cpu_read(cpu_tlbstate.loaded_mm_asid),
> +		tlbstate_lam_cr3_mask());

My editor auto indents this as:

	unsigned long cr3 =
		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
			  this_cpu_read(cpu_tlbstate.loaded_mm_asid),
			  tlbstate_lam_cr3_mask());

which (to me) is *much* clearer.

