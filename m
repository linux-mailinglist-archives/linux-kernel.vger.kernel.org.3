Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7FC4E3FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiCVNxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiCVNwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:52:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF9650B07;
        Tue, 22 Mar 2022 06:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D0CACE1E18;
        Tue, 22 Mar 2022 13:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D78C340EC;
        Tue, 22 Mar 2022 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647957084;
        bh=+PcSzqlfSr4quKABCcRJgSwsi7LZhav0meRk6eGzyQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FdatOK5EsCCKNSnd0SFBfhCB1ogmnUyN25HzjzgibJkE8MGgn40+e8L/IOlsBXcEJ
         HMrA0modxfnFK4pVridEsoQREyNK44MG/If1ZkUJh1d+8MYgKmupFlpE3rY//nXs0K
         ZvQ+DZfvR6W2vDeaCzZ9QCJqkTpRsj1ZqKBXFS8rxAu8MBIYQDsXEyGq7ssz3WENOU
         8DSxM+7R10paiWeViNMFJbu5uU0Ulj0GswYgV+N4JJPnJBH+rf9AljCATLTAE9YUUX
         XiJMzjq03TNToclXEXlkhNm9G+E2juwvKLEPI0p4V6UnVnTPiCNz8d9K8EaVBRA6H4
         SzRxDhwH0LBFQ==
Date:   Tue, 22 Mar 2022 22:51:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rostedt@goodmis.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-Id: <20220322225118.ec33bf93e19d40f27d73c8d1@kernel.org>
In-Reply-To: <YjnMDlS/6a4UWFQm@FVFF77S0Q05N>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
        <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
        <YjnMDlS/6a4UWFQm@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 13:15:58 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Mar 22, 2022 at 02:31:36PM +0900, Masami Hiramatsu wrote:
> > On Mon, 21 Mar 2022 17:48:54 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Mon, Mar 21, 2022 at 02:04:05PM +0100, Peter Zijlstra wrote:
> > > > On Mon, Mar 21, 2022 at 01:55:49PM +0100, Peter Zijlstra wrote:
> > > > > On Mon, Mar 21, 2022 at 02:03:27PM +1100, Stephen Rothwell wrote:
> > > > > > Hi all,
> > > > > > 
> > > > > > After merging the tip tree, today's linux-next build (x864 allmodconfig)
> > > > > > produced these new warnings:
> > > > > > 
> > > > > > vmlinux.o: warning: objtool: arch_rethook_prepare()+0x55: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: arch_rethook_trampoline_callback()+0x3e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x93e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x5f2: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x4a7: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x81: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x90: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x8c: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x9b: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > 
> > > > > Hurmph, lemme go figure out where that code comes from, I've not seen
> > > > > those.
> > > > 
> > > > Ahh, something tracing. I'll go do some patches on top of it.
> > > 
> > > The below gets rid of the objtool warnings.
> > 
> > Yes, I confirmed that.
> > 
> > > But I still think it's fairly terrible to get a (flawed) carbon copy of
> > > the kretprobe code.
> > 
> > Indeed. I would like to replace the trampoline code of kretprobe with
> > rethook, eventually. There is no reason why we keep the clone.
> > (But I need more arch maintainers help for that, there are too many
> >  archs implemented kretprobes)
> 
> FWIW, I'm more than happy to help on the arm64 side if you could Cc me for
> that; I'm aware of other things in this area I'd like to clean up for
> backtracing, too.

Thank you for your warm help. OK, let me update and submit the rethook
for arm64 :-)

Thanks.

-- 
Masami Hiramatsu <mhiramat@kernel.org>
