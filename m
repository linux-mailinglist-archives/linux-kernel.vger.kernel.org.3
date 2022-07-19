Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4557A16F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiGSO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbiGSO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:27:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABEC58865
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:13:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658239997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxbgGSEbEmVEKhaiEAclRG678MbyReuZv1istdnUhXM=;
        b=Qu/X6ZmclEB5rhXNORnQVzFvwU4V75dHkcZZ0kRkqVzOIyqqPab7WS+20+AXT8bGgS4Cm8
        Nm1HWXamkDIcySY4jr2a68+icv6A9iXLDhLSorLcrLi8CR3ekUcIAv2ICkohhRU0ab1iFO
        +DOHULxlBnxJSeIPVI9RHHJQxIgJ7D3uLRB7Pg0YzFGIRoO8JQUYj2g826SBvivO12Onme
        FuEmlmwFOM70oyKbDKNIOJzGqOEHHIybQoCJlOtdnZMC3Jp1w2mPcSjS9bIrlZ+Xu8mXYL
        SG8qqWKFFFYBJc4STfaIWemQPvT96ej2qa3LVyjtKypfekGbUyZqv8u6ocOQIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658239997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxbgGSEbEmVEKhaiEAclRG678MbyReuZv1istdnUhXM=;
        b=uvhkK3BiofREZ9FA6Sb2G4x0mONbagVf3ZAboefO12Q2JrLEhUIhNSu7PBusw+Oad8kqaX
        bcue/gHLj4lMl2AQ==
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Daniel Borkmann <daniel@iogearbox.net>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: Virt Call depth tracking mitigation
In-Reply-To: <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com>
References: <20220716230344.239749011@linutronix.de>
 <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com>
Date:   Tue, 19 Jul 2022 16:13:16 +0200
Message-ID: <87a695ur5v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19 2022 at 10:24, Andrew Cooper wrote:
> On 17/07/2022 00:17, Thomas Gleixner wrote:
>> As IBRS is a performance horror show, Peter Zijstra and me revisited the
>> call depth tracking approach and implemented it in a way which is hopefu=
lly
>> more palatable and avoids the downsides of the original attempt.
>>
>> We both unsurprisingly hate the result with a passion...
>
> And I hate to add more problems, but here we go.
>
> Under virt, it's not just SMI's which might run behind your back.=C2=A0
> Regular interrupts/etc can probably be hand-waved away in the same way
> that SMIs are.

You mean host side interrupts, right?

> Hypercalls however are a different matter.
>
> Xen and HyperV both have hypercall pages, where the hypervisor provides
> some executable code for the guest kernel to use.
>
> Under the current scheme, the calls into the hypercall pages get
> accounted, as objtool can see them, but the ret's don't.=C2=A0 This imbal=
ance
> is exasperated because some hypercalls are called in loops.

Bah.

> Worse however, it opens a hole where branch history is calculable and
> the ret can reliably underflow.=C2=A0 This occurs when there's a minimal =
call
> depth in Linux to get to the hypercall, and then a call depth of >16 in
> the hypervisor.
>
> The only variable in these cases is how much user control there is of
> the registers, and I for one am not feeling lucky in face of the current
> research.
>
> The only solution I see here is for Linux to ret-thunk the hypercall
> page too.=C2=A0 Under Xen, the hypercall page is mutable by the guest and
> there is room to turn every ret into a jmp, but obviously none of this
> is covered by any formal ABI, and this probably needs more careful
> consideration than the short time I've put towards it.

Well, that makes the guest side "safe", but isn't a deep hypercall > 16
already underflowing in the hypervisor code before it returns to the
guest?

> That said, after a return from the hypervisor, Linux has no idea what
> state the RSB is in, so the only safe course of action is to re-stuff.

Indeed.

Another proof for my claim that virt creates more problems than it
solves.

Thanks,

        tglx
