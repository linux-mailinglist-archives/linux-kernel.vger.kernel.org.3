Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FAB4E2C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiCUPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiCUPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:30:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E12E1BEA8;
        Mon, 21 Mar 2022 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UyKGNPRJVlIvheq4jU1rLk5JNu+mEKTOtDjzTm/ZAJI=; b=IqMbTkNPmyDhOp01Kt71uKWkRG
        pTXa2lvC67MwA8fCnHFDUh23ZO8um8PQZrjGj8iJ7hheZ5pfagN0CWwZFezN+0WPouSHIyZ9IswxZ
        GS3IGKrQbooHa39gGIsfANvHEuVB6jHmq77PSzvIKHi2eVk2es7DX5Ao3DnkQ9yi+7FqwEzrWkeAy
        byunx7F3df7RXr+qj/6to68s3OFwMRsnfa2mEkfMYcpcPCC3rLAl+lfKAxU9IJqoIbu0+098cJX6U
        GF1w5NMXwTn1CYRzH+bWQ7WGkUJbpQszoy64K+EbNXXgSnDZ4m9jq8TdybvlIpb94Oha01g9c5H4D
        osVe41oQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWJx4-00AhJS-Is; Mon, 21 Mar 2022 15:28:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 966373001CD;
        Mon, 21 Mar 2022 16:28:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FE3C203A88CA; Mon, 21 Mar 2022 16:28:06 +0100 (CET)
Date:   Mon, 21 Mar 2022 16:28:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, rostedt@goodmis.org, ast@kernel.org,
        hjl.tools@gmail.com, rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <YjiZhRelDJeX4dfR@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <Yjh4xzSWtvR+vqst@hirez.programming.kicks-ass.net>
 <YjiBbF+K4FKZyn6T@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjiBbF+K4FKZyn6T@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:45:16PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 21, 2022 at 02:08:23PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 21, 2022 at 02:04:05PM +0100, Peter Zijlstra wrote:
> > > On Mon, Mar 21, 2022 at 01:55:49PM +0100, Peter Zijlstra wrote:
> > > > On Mon, Mar 21, 2022 at 02:03:27PM +1100, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > After merging the tip tree, today's linux-next build (x864 allmodconfig)
> > > > > produced these new warnings:
> > > > > 
> > > > > vmlinux.o: warning: objtool: arch_rethook_prepare()+0x55: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: arch_rethook_trampoline_callback()+0x3e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x93e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x5f2: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x4a7: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x81: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x90: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x8c: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x9b: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > 
> > > > Hurmph, lemme go figure out where that code comes from, I've not seen
> > > > those.
> > > 
> > > Ahh, something tracing. I'll go do some patches on top of it.
> > 
> > Also, that x86 patch has never his x86@kernel.org and doesn't have an
> > ACK from any x86 person :-(((
> 
> Worse, it adds a 3rd return trampoline without replacing any of the
> existing two :-(
> 
> Why was this merged?

It additionally gets ret wrong:

  vmlinux.o: warning: objtool: arch_rethook_trampoline()+0x4a: missing int3 after ret

and afaict regs->ss is garbage (much like kretprobes it appears).

Can we please unmerge this stuff and try again later?
