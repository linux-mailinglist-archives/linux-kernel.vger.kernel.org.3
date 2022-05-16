Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40065527F53
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiEPIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiEPIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:12:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177836B72
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eiYtkPr379tjgIeHrhL5b7a25VnUHqGENKulJkuEAMo=; b=AcVK5kk5wt8NmqoWdQ+P+MH6x2
        cygyLNNaVD7VcF6OD/SIPxYwnt3E47B04DUAMJmVeFzrw4q2Aze+usNYypwL3npyDaoXgyOo/63wG
        gzQPFEnGFCjC+gdfXdc6EeCVCj/zoHKF6ljvxXlv+okTEKPl42oSVg8k+HFxoEf0xgzePIVKjn9/N
        GTYwOZ5w0RpaOhKRAMze2e65hpCGBtg9ekN+uKcGPKa0aV25aS9wjYjJyX1jTXGP66oY9YGOl9HSK
        6+wWxLHMJaA+zhNIjw08kNjKXxdqsXKtX9ItBtNHnMxnhzDuoDhtQa98DfRLVmqydPcqOX2wst268
        2sQkfbvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqVpx-000u7S-MG; Mon, 16 May 2022 08:12:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E12C230018E;
        Mon, 16 May 2022 10:12:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFF35202674C4; Mon, 16 May 2022 10:12:14 +0200 (CEST)
Date:   Mon, 16 May 2022 10:12:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3 0/2] locking/atomic/x86: Introduce arch_try_cmpxchg64
Message-ID: <YoIHXlmsso70rxne@hirez.programming.kicks-ass.net>
References: <20220515184205.103089-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515184205.103089-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 08:42:02PM +0200, Uros Bizjak wrote:
> Uros Bizjak (2):
>   locking/atomic: Add generic try_cmpxchg64 support
>   locking/atomic/x86: Introduce arch_try_cmpxchg64
> 
>  arch/x86/include/asm/cmpxchg_32.h           | 21 ++++++
>  arch/x86/include/asm/cmpxchg_64.h           |  6 ++
>  include/linux/atomic/atomic-arch-fallback.h | 72 ++++++++++++++++++++-
>  include/linux/atomic/atomic-instrumented.h  | 40 +++++++++++-
>  scripts/atomic/gen-atomic-fallback.sh       | 31 +++++----
>  scripts/atomic/gen-atomic-instrumented.sh   |  2 +-
>  6 files changed, 156 insertions(+), 16 deletions(-)

Thanks!
