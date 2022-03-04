Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D04CDE47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiCDUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiCDUXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:23:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348AD1D06E5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uVPrSHaqLF9b3ORXlMh5Qj9V4zOmWj8SncI5qbaLawc=; b=ZySsesB8Tuo0Fb1eYIXWq5nFbA
        bObP7Pnz7h8twGUphf7sKoXp5ybJxhj/q7W8OZvVKDEIEzmULQKSpj/4pF9WAfO7p3g2U+UzRsB2r
        eDE2VG5gYqZwGsD8uqy47SISepW457EcJDvVNCdC35/I8yEeSKsucLvHm5+RC2PDBKVmBQdx9jXy3
        4YO9xaJK+rZXZTbWhtN+M0y6ezpGhIdeCCp+t8AeAvgxr/RAN6hmeiKXrGoJ0YTEyI/u2CtS2MxLz
        +ncRkx/hsMMuuWW64MZqfR1VPEWYcizNzvPkverh2buh9Hc7hiZVvf4dy8UAsqQfGLOtZEr+cCFKZ
        u4em/8ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQERW-00Cz2o-Ff; Fri, 04 Mar 2022 20:22:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D2E198624E; Fri,  4 Mar 2022 21:22:25 +0100 (CET)
Date:   Fri, 4 Mar 2022 21:22:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 00/39] x86: Kernel IBT
Message-ID: <20220304202225.GO11184@worktop.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220304190958.comlw5wt7zdgeakc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304190958.comlw5wt7zdgeakc@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:09:58AM -0800, Josh Poimboeuf wrote:

> I'm getting some warnings with CONFIG_X86_KERNEL_IBT=n:
> 
>   arch/x86/entry/entry_64.o: warning: objtool: irq_entries_start()+0x7: unreachable instruction
>   arch/x86/kernel/ftrace_64.o: warning: objtool: return_to_handler()+0x2a: unreachable instruction

Urgh, lemme go chase that.

> And a warning with CONFIG_X86_KERNEL_IBT=y:
> 
>   vmlinux.o: warning: objtool: .text+0xaf0: unreachable instruction

This is that weak symbol issue :/ We talked about it on IRC, but i've
not yet come around to fixing it.

This is mostly a pre-existing issue, only uncovered because we run on
vmlinux more..
