Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41C507AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbiDSURt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351891AbiDSURc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:17:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0D2A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jvOFqMFAlj4tb7RNdnHBLTW8NkLhW9U0AcHSUvRhDGQ=; b=aoIubLIauB+2yUS1p6X7DsG1oH
        qjNi4484kyQhPO6+MzhLgcXTrJnz79St6EzEj1+SrRf28zcqL2n+IwnAYiVedFuOiyi5wi6vLCM3J
        9pN58YR92eq9OkYO3KIPj1QMYEjktfqKiNw41OaR+28mdCnowvoDog31aJaT2ndYZGJ6rNHIFdRKw
        4ym/alg0zdLJn/Xr9RHy9Si+h0rrMK/aTzW7NGbMCaEYdWfsvk0z6hp2NmTkrx/h+zQSI0rZKPw3Q
        n7G6sbkKf9QwOQAvIA8mDGD5ibNOAnQi/TBzzsGU/E35tpyMFD3+LriLtt7QK3BF4RLqoQetbK0vu
        O1EZ7dSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nguFC-006uYU-A5; Tue, 19 Apr 2022 20:14:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E65ED9861A4; Tue, 19 Apr 2022 22:14:35 +0200 (CEST)
Date:   Tue, 19 Apr 2022 22:14:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] scripts: Create objdump-func helper script
Message-ID: <20220419201435.GY2731@worktop.programming.kicks-ass.net>
References: <fe61d8835ba60ef20920d2d0e6493748c80e4d7e.1650384661.git.jpoimboe@redhat.com>
 <Yl8SaZbqXPJQyoXB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8SaZbqXPJQyoXB@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:50:01PM +0200, Borislav Petkov wrote:
> On Tue, Apr 19, 2022 at 09:12:23AM -0700, Josh Poimboeuf wrote:
> > Add a simple script which disassembles a single function from an object
> > file.  Comes in handy for objtool warnings and kernel stack traces.
> > 
> > Originally-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> > v2:
> > - require gawk
> > 
> >  scripts/objdump-func | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100755 scripts/objdump-func
> 
> Was that supposed to be user-friendly too?
> 
> $ ./scripts/objdump-func -h
> ./scripts/objdump-func: line 16: $1: unbound variable
> 
> :-)
> 
> 
> It works tho:
> 
> $ ./scripts/objdump-func vmlinux rewind_stack_and_make_dead
> 0000 ffffffff81001c00 <rewind_stack_and_make_dead>:
> 0000 ffffffff81001c00:  31 ed                   xor    %ebp,%ebp
> 0000 ffffffff81001c02:  65 48 8b 04 25 d0 ec 01 00      mov    %gs:0x1ecd0,%rax
> 0000 ffffffff81001c0b:  48 8d a0 58 ff ff ff    lea    -0xa8(%rax),%rsp
> 0000 ffffffff81001c12:  e8 39 24 07 00          call   ffffffff81074050 <make_task_dead>
> ^^^^
> 
> I guess those zeros at the beginning are supposed to mean something...

Use the .o file and it'll work:

$ ./objdump-func.sh defconfig-build/vmlinux.o rewind_stack_and_make_dead
0000 0000000000001380 <rewind_stack_and_make_dead>:
0000     1380:  31 ed                   xor    %ebp,%ebp
0002     1382:  65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     1387: R_X86_64_32S      cpu_current_top_of_stack
000b     138b:  48 8d a0 58 ff ff ff    lea    -0xa8(%rax),%rsp
0012     1392:  e8 00 00 00 00          call   1397 <preempt_schedule_thunk>    1393: R_X86_64_PLT32    make_task_dead-0x4


Now the first coloumn is the symbol relative offset, while the second
column is the section relative offset objdump normally gives you.
