Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5D57E073
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiGVLEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiGVLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:03:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C50BDA03
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s+t+9Vi0tpfxV3Q74dVVAy3AQF79iNwAMp4hPA+2T1A=; b=ksMVr3GZZdqiAN8bDPfkOkJvTY
        yIjVKpnsS8eOb1LfWH3noPuu6p8r1c34KD1crfHTX2hHyp2RofJTrfgycHEoS/0/ttHyn2jCQxBvZ
        sVYjfo00V9WEBguox4ilxq5qb0haRUZhMuBiDl+DH18FADl7U17AncEXGKS0LLGW3WYC+5J49688G
        quQEEb/l0YOHCZqJI5M6KIWDf1/khMY3JXunr9Xv9/YCVpzWNo2Yx+UbU+EStwNHGHrM5/kW3Cqhl
        8SD8Am76MwlYDbyCaPsACHUqPmuMC62RNq2/FRINqZiFSttgjEkSY5jZmkkGLiQc8lzlPbEP3qtGs
        5UOfhwDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEqRF-005q8w-Hr; Fri, 22 Jul 2022 11:03:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1290298029B; Fri, 22 Jul 2022 13:03:20 +0200 (CEST)
Date:   Fri, 22 Jul 2022 13:03:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtqD96Kq4/Wg+LXQ@worktop.programming.kicks-ass.net>
References: <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
 <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
 <d0597f7096344b10bfcd95a0ffdbad17@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0597f7096344b10bfcd95a0ffdbad17@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:01:12PM +0000, David Laight wrote:

> Since: "If the callee is a variadic function, then the number of floating
> point arguments passed to the function in vector registers must be provided
> by the caller in the AL register."
> 
> And that that never happens in the kernel you can use %eax instead
> of %r10d.

Except there's the AMD BTC thing and we should (compiler patch seems
MIA) have an unconditional: 'xor %eax,%eax' in front of every function
call.

(The official mitigation strategy was CALL; LFENCE IIRC, but that's so
horrible nobody is actually considering that)

Yes, the suggested sequence ends with rax being zero, but since we start
the speculation before that result is computed that's not good enough I
suspect.
