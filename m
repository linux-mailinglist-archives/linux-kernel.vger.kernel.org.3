Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2083957811E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiGRLm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRLmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:42:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35666656B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:42:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658144571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PS21eztK5aF+C+ShkdTlSeCwoba12LKY/CMfYEzSG4Q=;
        b=2sMpgRCpmeEPBylJN+vve/u0B7DeXyMXxYRP39T/28XjJfxNBECJZRhvc02e7mQ1pNXfIp
        Yajn7Hdji9FyizG20w9tC5AytTkqXFudqAjY0On4aM2NSLdKylBbmx9kcwjjBXF3/v+v6j
        WfmPPYVq+qBcS+B/gZBzrzWMv71oyZNQB9jhjHhi+vu//VB8Ruy6aX4b1FdXlngntxbwfj
        FZBQyJGNV/2qFjxBTuo2T0SuN4//rbnIe55X5FsBvL70VDNxxPvjAmhTMTdWza2mRXGZw0
        cqKZIySyqXab5R4BOzGRTnWCke8yXZAYuwfOuA55YGOc5HGGb9LRlwjO1UB5tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658144571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PS21eztK5aF+C+ShkdTlSeCwoba12LKY/CMfYEzSG4Q=;
        b=uFWN6EPtznjuNWhM60TorPLI7k5ZJZ4chje5dpqNSue94iq9RWHMWxUyk3KUh1gVgoarmz
        2IeU1fD7agDsGvCw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
In-Reply-To: <87fsiyww0l.ffs@tglx>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com> <87zgh7wo91.ffs@tglx>
 <87tu7fwlhr.ffs@tglx> <87r12jwl9l.ffs@tglx> <87o7xnwgl3.ffs@tglx>
 <70b03d06-6ab9-1693-f811-f784a7dced76@suse.com> <87lesqx64u.ffs@tglx>
 <87ilnux0ji.ffs@tglx> <YtUodTM53de5vVxO@worktop.programming.kicks-ass.net>
 <87fsiyww0l.ffs@tglx>
Date:   Mon, 18 Jul 2022 13:42:50 +0200
Message-ID: <87cze2wssl.ffs@tglx>
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

On Mon, Jul 18 2022 at 12:33, Thomas Gleixner wrote:
> On Mon, Jul 18 2022 at 11:31, Peter Zijlstra wrote:
>> On Mon, Jul 18, 2022 at 10:55:29AM +0200, Thomas Gleixner wrote:
>>> On Mon, Jul 18 2022 at 08:54, Thomas Gleixner wrote:
>>> > On Mon, Jul 18 2022 at 07:11, Juergen Gross wrote:
>>> >>> -	switch_to_new_gdt(cpu);
>>> >>> +	switch_to_real_gdt(cpu);
>>> >>
>>> >> ... can't you use the paravirt variant of load_gdt in switch_to_real=
_gdt() ?
>>> >
>>> > That does not solve the problem of having a disagreement between GDT =
and
>>> > GS_BASE. Let me dig into this some more.
>>>=20
>>> Bah. The real problem is __loadsegment_simple(gs, 0). After that GS_BASE
>>> is 0. So any per CPU access before setting MSR_GS_BASE back to working
>>> state is going into lala land.
>>>=20
>>> So it's not the GDT. It's the mov 0, %gs which makes stuff go south, but
>>> as %gs is already 0, we can keep the paravirt load_gdt() and use
>>> native_write_msr() and everything should be happy.
>>
>> How is the ret from xen_load_gdt() not going to explode?
>
> This is only for the early boot _before_ all the patching happens. So
> that goes through the default retthunk.
>
> Secondary CPUs do not need that as they set up GDT and GS_BASE in the
> low level asm code before coming out to C.
>
> I'm still trying to figure out how this works on XENPV and on 32bit.

On 32bit the CPU comes out with GDT and FS correctly set too.

For XEN_PV it looks like cpu_initialize_context() hands down GDT and
GSBASE info to the hypercall which kicks the CPU so we should be
good there as well. Emphasis on should. J=C3=BCrgen?

Thanks,

        tglx
