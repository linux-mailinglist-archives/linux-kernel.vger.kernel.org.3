Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00DF578D72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiGRWWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGRWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:22:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293825581
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:22:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658182946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUn0maBUx5ugE7Mgwb1+6jXU+G6FA5SFjDCLa91ltLA=;
        b=cEKHYnwSGG0s4A2JV+dyUMQS9sne0IbbRh+3x4d5kzaN4Lj5KGNij85Yz85nr7q/Z3cST+
        9bfBLjT3NcXgITKYl4a9QTjcsJHu0ejZi/uma31074A/+/iSRI+tTz/9Aiw55L2gEyKSar
        TfXyvV5HjoeZvrzzortEBuBsV9ztIbPyNEigEz7SJ5YiMIE7LgTGTzmoPJqxov9leyaV9d
        32AcJtJPuP4EeojwdGg7gnEzg5PpyDFjOx6CylwIkLYAJcOGVXUgPS7NhmPal4dIVBO960
        JU5vPYWL5BfM/Rws/nKkzkheBipqoxJDJlA4baOQQLUK7m+8uYbwZM8yH6welQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658182946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUn0maBUx5ugE7Mgwb1+6jXU+G6FA5SFjDCLa91ltLA=;
        b=TPqogNFBsbv2Irz8Nar57WgWb8eWWgHuX85i7riYrtw1PGR4UFYop1hUDWL/7IhApoPfNI
        QmZjNlnPmN93MjAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, samitolvanen@google.com
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
Date:   Tue, 19 Jul 2022 00:22:26 +0200
Message-ID: <87lesqukm5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18 2022 at 23:18, Peter Zijlstra wrote:
> On Mon, Jul 18, 2022 at 10:44:14PM +0200, Thomas Gleixner wrote:
>> And we need input from the Clang folks because their CFI work also puts
>> stuff in front of the function entry, which nicely collides.
>
> Right, I need to go look at the latest kCFI patches, that sorta got
> side-tracked for working on all the retbleed muck :/
>
> Basically kCFI wants to preface every (indirect callable) function with:
>
> __cfi_\func:
> 	int3
>         movl $0x12345678, %rax
>         int3
>         int3
> \func:
>         endbr
> \func_direct:
>
> Ofc, we can still put the whole:
>
> 	sarq	$5, PER_CPU_VAR(__x86_call_depth);
> 	jmp	\func_direct
>
> thing in front of that. But it does somewhat destroy the version I had
> that only needs the 10 bytes padding for the sarq.

Right, because it needs the jump. I was just chatting with Jaoa about
that over IRC.

The jump slow things down. Jaoa has ideas and will reply soonish.

Thanks,

        tglx
