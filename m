Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE2A5776E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiGQPHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiGQPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:07:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FC013CF3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:07:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658070432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVhjvDfDQixKqcv7rbnVPiugVbLq2QvYm/mTkodge1I=;
        b=yO+R1k7IAmxmGLlwA3VaJhLrNu0rmPQcohqXTZe7Eqw7dJcbBtJUjGRppfDIe8NMCH2+Wb
        B82IuhY/pAqUaw+JuWbiEqIyqf7VLK/xR+/t5aRyb4M3laweRxGJKlmozA45Spd8ALBWQ3
        ANb/3I+GWvAUk1w9zOpV6A7TUIjPYNU8fqR7tA1u2oK1uvNpz8f6og0kK27NzsrwfMQ7XH
        G5RY0m5RP13PfTCH0mOTk8LQwvMQwe26D9s37v051ai9FYXXBE8BnjfS+6V26WaKUDA+IM
        5njKtKUbuCD09Pv2jHNMXO4aCUqPEBxle38r2rc0bG3+4WzXhIEbJTicwQcQFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658070432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVhjvDfDQixKqcv7rbnVPiugVbLq2QvYm/mTkodge1I=;
        b=1aQOwYHwSGUsFr2pCujcNBrOw+S0gHyiAfH4CiOePnc5RhtApUfP78EZ5/z5YZ486EniRy
        QY6U9PXYGe9DttDA==
To:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <f9fd86acac4f49bc8f90b403978e9df3@AcuMS.aculab.com>
References: <20220716230344.239749011@linutronix.de>
 <f9fd86acac4f49bc8f90b403978e9df3@AcuMS.aculab.com>
Date:   Sun, 17 Jul 2022 17:07:11 +0200
Message-ID: <8735ezye00.ffs@tglx>
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

On Sun, Jul 17 2022 at 09:45, David Laight wrote:
> From: Thomas Gleixner
>> 
>>  3) Utilize the retbleed return thunk mechanism by making the jump
>>     target run-time configurable. Add the accounting counterpart and
>>     stuff RSB on underflow in that alternate implementation.
>
> What happens to indirect calls?
> The above would imply that they miss the function entry thunk, but
> get the return one.
> Won't this lead to mis-counting of the RSB?

That's accounted in the indirect call thunk. This mitigation requires
retpolines enabled.

> I also thought that retpolines would trash the return stack?

No. They prevent that the CPU misspeculates an indirect call due to a
mistrained BTB.

> Using a single retpoline thunk would pretty much ensure that
> they are never correctly predicted from the BTB, but it only
> gives a single BTB entry that needs 'setting up' to get mis-
> prediction.

  BTB != RSB

The intra function call in the retpoline is of course adding a RSB entry
which points to the speculation trap, but that gets popped immediately
after that by the return which goes to the called function.

But that does not prevent the RSB underflow problem. As I described the
RSB is a stack with depth 16. Call pushs, ret pops. So if speculation is
ahead and emptied the RSB while speculating down the rets then the next
speculated RET will fall back to other prediction mechanism which is
what the SKL specific retbleed variant exploits via BHB mistraining.

> I'm also sure I managed to infer from a document of instruction
> timings and architectures that some x86 cpu actually used the BTB
> for normal conditional jumps?

That's relevant to the problem at hand in which way?

Thanks,

        tglx
