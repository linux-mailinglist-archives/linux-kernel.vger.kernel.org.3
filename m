Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73684E4939
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiCVWju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCVWjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:39:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31913F76
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nnK2btu49wvOygYhvin+ssedZfS2Vh7uEre25vsBTaA=; b=o39RB9IC/Jf3KUjUpNEvzVNKgw
        LR9iQoyf/1ZARh6A4e2lAPC/7nxdSV+BKYO8BRL3j1EhOl4xedRewR4m+DQVN5Lk4s5355PdzwwYZ
        yPnseCzxu8F/utLJ2ByOFQ5wr1KXBR7qafWCwr7s49q3CCp4CuBrzh2SRsnl4k/OMoBYZAkBD1byl
        8vd+OMqQHM95YcOTAzCCUZ0n+e16vekGIQFZBsSY6v+SgJIy2LIHDIHsAEFZ3/dQ7dZDgrBvC9WuZ
        qslwdczfOMBobhg8v1MGYTJowliN+xztqo/r8Me/GV/8y/N1V8i89ELJWUv4pQC1R7XQPmLWD6HUr
        m8PCbjrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWn8j-003aMA-L4; Tue, 22 Mar 2022 22:38:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E30F3986226; Tue, 22 Mar 2022 23:38:07 +0100 (CET)
Date:   Tue, 22 Mar 2022 23:38:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <20220322223807.GV8939@worktop.programming.kicks-ass.net>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 03:05:39PM -0700, Linus Torvalds wrote:

> I thought -tip had started checking with clang, but apparently not.

Yeah, sorry. I do indeed not regularly build with clang and somewhat
rely on the robots to yell at me.

Every time I try clang, it just takes so long.. build times are
significantly longer. On top of that our build system hasn't, until
recently [1], much liked how Debian packages clang.

[1] https://lkml.kernel.org/r/20220304170813.1689186-1-nathan@kernel.org
