Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6C4EF889
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbiDARDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiDARDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:03:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE6C15D3BC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ubrQWMJ1uk1qCVEaNU5C2Zro8EhwB8oevnnpqgA4914=; b=P8OPWdRlRLUHuHDjNg/AEpbeSW
        8lDIDtxENtgnP3j0mnwrc4UpN30iC8l0480E2xJlIqvFDT/9tLnNZ4kIkTGDKco8e25z4qbqBNyYS
        T37IqOFNe64r7yf9dN/FYoVdNv+HXNSLlHhChTAAaHX3Y7tgj3yl5/yPbSNYwSU4Gwo6SlDxmUV/D
        Z1jrDMzNDL6A2KJm5oONP4rAIjlrJzA3I7Q/oErDE05f1OkcIO/ZcR0YWokAFFlbt1YpdykHGZnws
        5RkiZd9bA8Iki7it0/BNlmqEH3t/F7gJvzrzWLnQjtFGRKam9FW/vszqamqlwghy8vwio9l3k41Eh
        f6xU3dug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naKeP-003OVv-FC; Fri, 01 Apr 2022 17:01:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3DBB9861EF; Fri,  1 Apr 2022 19:01:26 +0200 (CEST)
Date:   Fri, 1 Apr 2022 19:01:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youquan Song <youquan.song@linux.intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/uaccess: restore get_user exception type to
 EX_TYPE_UACCESS
Message-ID: <20220401170126.GY8939@worktop.programming.kicks-ass.net>
References: <20220328201748.1864491-1-tony.luck@intel.com>
 <20220330123205.GL8939@worktop.programming.kicks-ass.net>
 <20220331113125.GA2628@linux-youquan.bj.intel.com>
 <20220331175113.GV8939@worktop.programming.kicks-ass.net>
 <20220401124519.GA6935@linux-youquan.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401124519.GA6935@linux-youquan.bj.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 08:45:19PM +0800, Youquan Song wrote:
> On Thu, Mar 31, 2022 at 07:51:13PM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 31, 2022 at 07:31:25PM +0800, Youquan Song wrote:
> > > > Did you do your testing on RHEL or something daft like that?
> > > Tested on RHEL8.x
> > 
> > Right; the home of obsolete software.. :-)
> > 
> > > > Something like the below can also work, I suppose. But please, add
> > > > coherent comments to the extable code with useful references to the MCE
> > > > code that does this abuse.
> > > Here is the full fix patch depending on your suggestion. Thanks a lot!
> > 
> > Did you verify this was indeed the only UACCESS I lost?
> 
> The full fix patch has included a change in error_context to identify
> this case to be MCE_IN_KERNEL_COPYIN. I verfied it fix the issue.

That's not what I asked... :-(

What that means is that you go look at the commits that reworked all
this; starting here:

  https://lore.kernel.org/all/20211110100102.250793167@infradead.org/

and check how many UACCESS's got removed:

$ git diff 3411506550b1..82a8954acd93 | grep "^-.*UA" | wc -l
33

And then verify they're all good now and that we don't find another
missing instance in a few weeks or later...

Because when I look at that, stuff like:

--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -17,13 +17,9 @@ do {                                                         \
        int oldval = 0, ret;                                    \
        asm volatile("1:\t" insn "\n"                           \
                     "2:\n"                                     \
-                    "\t.section .fixup,\"ax\"\n"               \
-                    "3:\tmov\t%3, %1\n"                        \
-                    "\tjmp\t2b\n"                              \
-                    "\t.previous\n"                            \
-                    _ASM_EXTABLE_UA(1b, 3b)                    \
+                    _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %1) \
                     : "=r" (oldval), "=r" (ret), "+m" (*uaddr) \
-                    : "i" (-EFAULT), "0" (oparg), "1" (0));    \
+                    : "0" (oparg), "1" (0));   \
        if (ret)                                                \
                goto label;                                     \
        *oval = oldval;                                         \


makes me think this isn't the last of it... Hmmm?
