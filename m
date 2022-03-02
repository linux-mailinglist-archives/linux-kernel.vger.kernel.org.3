Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184D64CAEDD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbiCBTk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbiCBTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:40:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537B5C55B3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QhltOUDlJxC8ltF2HbQFI8+ZrdiigruHgZquqQqDwQQ=; b=VhPuSfmMaK958MrW/CrCjL0EAA
        cJoWTKNIG0pLmT5k7gabXZyz1Vg+E8q1Sffzmh3L437cSES81Gr+VszCuLte20gVO8Dc7zkhOtJ6G
        LiB0pSb2YAlsQFTHRvXyEWRFbnMGER323Fm5AmUkcqaBKW/BxZkw3fBOc6aEljXj6zDVn95ym6kTd
        6osmgQ7/dQ7mK72MpSHsxTLY08IcCWcry6Tl1L0x2b8407bq+RDV5jxh2uRNvjaTVceL+F1p7Hohk
        vyjZINVQm0Sy8ivc/oc2MEv8x1fIWyR66mjs0+ciE9sIvKp4f/0fvOtJ8yS9MFiKqMZDD0HVbBX6b
        uIhV6hFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPUp0-00Egof-Ni; Wed, 02 Mar 2022 19:39:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30B073001EA;
        Wed,  2 Mar 2022 20:39:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E14FA203C59BD; Wed,  2 Mar 2022 20:39:36 +0100 (CET)
Date:   Wed, 2 Mar 2022 20:39:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <Yh/H+IyKnnC0w5TN@hirez.programming.kicks-ass.net>
References: <20220224151322.892372059@infradead.org>
 <20220228150705.aab2d654b973109bab070ffe@kernel.org>
 <20220228232513.GH11184@worktop.programming.kicks-ass.net>
 <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
 <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
 <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
 <20220301191245.GI11184@worktop.programming.kicks-ass.net>
 <20220301200547.GK11184@worktop.programming.kicks-ass.net>
 <1646236764.vx04n8yp12.naveen@linux.ibm.com>
 <Yh/GXaqzDNfp93Jd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/GXaqzDNfp93Jd@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:32:45PM +0100, Peter Zijlstra wrote:
> I wonder if you also want to tighten up on_func_entry? Wouldn't the
> above suggest something like:
> 
> kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
> 					 bool *on_func_entry)
> {
> #ifdef PPC64_ELF_ABI_V2
> 	unsigned long entry = ppc_function_entry((void *)addr) - addr;
> 	*on_func_entry = !offset || offset == entry;
> 	if (*on_func_entry)
> 		offset = entry;
> #else
> 	*on_func_entry = !offset;
> #endif
> 	return (void *)(addr + offset);
> }

One question though; the above seems to work for +0 or +8 (IIRC your
instructions are 4 bytes each and the GEP is 2 instructions).

But what do we want to happen for +4 ?
