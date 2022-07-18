Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386CA578E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiGRXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiGRXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:19:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA42CCA4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:19:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658186373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZSpOTDestuFHoUeoXRQFtReCw+twh88oerHixDKi5U=;
        b=euqTh/FFDOit4+8O7vcor/ydhHgIRcJBqk+XMcwF7TVPkPkd8ItPG3x3zN2q7K8pu159SN
        q4VJt7JHNgfnK63lfROQD2ipqlbtTb9/dhVtPP+DEszkae7NmbFgoNnP48BbDrZ+0P34f/
        2IZ36TwZQStkGdbl89P4rbou1xT9QDmwVbcWRFsYlkrKTsTfAjMgu84WyTbZWIWkiH/GRG
        WGUPsLbyPFU7jwi7j7jSKOTWlACD68e4tIoDynqueD2+U1sEF+0iXBrKH54GlIOO5ztJk/
        DLrXZII6hygYeLBaqWLNQB1hAAxrIXFT7BFwE5tbV2390TilJisz87zRdevp2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658186373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZSpOTDestuFHoUeoXRQFtReCw+twh88oerHixDKi5U=;
        b=IHBwpJ5ObJ0cwe/woJNYdLuxKXTt/NMUiN2PY7SfIbx0B31YCVGjm50Y7XPCt0Z2FTBrkZ
        iBcqzAjhkTLq8WBg==
To:     Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
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
        Peter Collingbourne <pcc@google.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx>
 <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
Date:   Tue, 19 Jul 2022 01:19:32 +0200
Message-ID: <87fsiyuhyz.ffs@tglx>
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

On Mon, Jul 18 2022 at 15:55, Sami Tolvanen wrote:
> On Mon, Jul 18, 2022 at 3:47 PM Joao Moreira <joao@overdrivepizza.com> wrote:
>> Thus the hash will be 6 bytes before the function entry point. Then we
>> can get the compiler to emit a padding area before the __cfi_\func
>> snippet and, during boot, if the CPU needs the call depth tracking
>> mitigation, we:
>> - move the __cfi_func into the padding area
>> - patch the call depth tracking snippet ahead of it (overwriting the old
>> __cfi_\func:)
>> - fix the cmpl offset in the caller
>>
>> func_whatever:
>>         ...
>>         cmpl $0x\hash, -FIXED_OFFSET(%rax)
>>         je 1f
>>         ud2
>> 1:
>>         call *%rax
>>         ...
>
> The problem with this is that the cmpl instruction contains the full
> type hash, which means that any instruction that's FIXED_OFFSET from
> the cmpl is a valid indirect call target as far as KCFI is concerned.
> -6 was chosen specifically to make the ud2 the only possible target.

But that's an implementation detail, right? Whatever we put in between
will still be a fixed offset, no? It's a different offset, but that's
what patching can deal with.

Thanks,

        tglx
