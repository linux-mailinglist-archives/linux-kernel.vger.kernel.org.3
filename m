Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F884E9291
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiC1KiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbiC1Khx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:37:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00636169
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7qKdtgITMOnvqGN+zt/ifdsol9K+eKOtDUuRZKr9tCQ=; b=eLlJYWnlSbKcvsify0sDO5jqPJ
        1LTXl9Nt20LBpkJoOGcsy5axp/4KmNVb2x/aANkkgvcGvDZGoese1MJIBdon/n5+adG+Fgpv/YhMb
        arnjcB86Gv9drCo3b5cjXMXixTKVbOLnBEm4CNU1Px5wP1Q+7DpL990y+qAsvvUnW1/MPRnURJK/6
        E7V38MPCpCdQgD7HAjG2a4E69lnjgxW7YD5leV8+j3d55GV5N5i/UZPXR2lX53fSZcSyYvxgrUuW1
        qtg8PGp71iwx1zzULFT+Jae/Lrkrl0i30Cz9IK3DM0um4hAMcqdXjT15lVT8S0FZcevMxFjS1ookp
        UWuU99mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYmj5-005Pnc-Ti; Mon, 28 Mar 2022 10:35:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD5269861E7; Mon, 28 Mar 2022 12:35:51 +0200 (CEST)
Date:   Mon, 28 Mar 2022 12:35:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Message-ID: <20220328103551.GY8939@worktop.programming.kicks-ass.net>
References: <20220322220757.8607-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322220757.8607-1-namit@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:07:57PM +0000, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> On extreme TLB shootdown storms, the mm's tlb_gen cacheline is highly
> contended and reading it should (arguably) be avoided as much as
> possible.
> 
> Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
> even when it is not necessary (e.g., the mm was already switched).
> This is wasteful.
> 
> Moreover, one of the existing optimizations is to read mm's tlb_gen to
> see if there are additional in-flight TLB invalidations and flush the
> entire TLB in such a case. However, if the request's tlb_gen was already
> flushed, the benefit of checking the mm's tlb_gen is likely to be offset
> by the overhead of the check itself.
> 
> Running will-it-scale with tlb_flush1_threads show a considerable
> benefit on 56-core Skylake (up to +24%):
> 
> threads		Baseline (v5.17+)	+Patch
> 1		159960			160202
> 5		310808			308378 (-0.7%)
> 10		479110			490728
> 15		526771			562528
> 20		534495			587316
> 25		547462			628296
> 30		579616			666313
> 35		594134			701814
> 40		612288			732967
> 45		617517			749727
> 50		637476			735497
> 55		614363			778913 (+24%)
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
