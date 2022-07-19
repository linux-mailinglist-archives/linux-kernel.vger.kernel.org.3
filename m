Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA257A8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiGSVRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGSVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:17:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C045E828
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:17:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658265433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVIl7iEgu0ZdY7jzgIhRNKikR8k+UskPQ9rWSyQBgZw=;
        b=jTFSS6ba7q8vnrgnUmytiGDAUnoMiM92ED6bISL6vLHf99+v4RzYDxziE2vZgh+AhQul38
        E6AdU5gGQAD3X5pjU2N2GCOI99Ix8PbjDVx935U9m9Vdxln2LcHuF3iBz5kUxnZkNJiELK
        vetI9vEWFRuHjHEnSO3OE0PtCJ4i7XDx+DV3eLnLyKMa3ARaLaYtngkZ98DmnbJHq9M8Kq
        1SHL4enZ0Clluxgk2Qya7kK8Rt9kYC7jBIj1YLQOrxwyMv4McQtjhjvpKxj5zO1N8F5wCU
        mnmJkWRveTH4Pj0dO+OJrkEgOAk24/+8TwCHClRNuhELlHrlZ8JnHPOIr6Jx8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658265433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVIl7iEgu0ZdY7jzgIhRNKikR8k+UskPQ9rWSyQBgZw=;
        b=2EVBfOisCwF4hyEr/7qNgCkqdpuAMkpKPL7+LzJEqpzEsFrtSj1uU9nRaeB6aBJnD3MNZ2
        BXCYTl+neKe8uPDg==
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
In-Reply-To: <261e141a-7e7f-ce26-60fe-df1957e393df@citrix.com>
References: <20220716230344.239749011@linutronix.de>
 <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com> <87a695ur5v.ffs@tglx>
 <261e141a-7e7f-ce26-60fe-df1957e393df@citrix.com>
Date:   Tue, 19 Jul 2022 23:17:12 +0200
Message-ID: <877d48vm3r.ffs@tglx>
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

On Tue, Jul 19 2022 at 16:23, Andrew Cooper wrote:
> On 19/07/2022 15:13, Thomas Gleixner wrote:
>> Well, that makes the guest side "safe", but isn't a deep hypercall > 16
>> already underflowing in the hypervisor code before it returns to the
>> guest?
>
> Yeah, but that's the hypervisor's problem to deal with, in whatever
> manner it sees fit.
>
> And if the hypervisor is using IBeeRS then the first ret in guest
> context will underflow.

I have a look tomorrow.

>>> That said, after a return from the hypervisor, Linux has no idea what
>>> state the RSB is in, so the only safe course of action is to re-stuff.
>> Indeed.
>>
>> Another proof for my claim that virt creates more problems than it
>> solves.
>
> So how did you like debugging the gsbase crash on native hardware. :)

First of all I said it's creating more problems than it solves, which
means it solves some problems.

But more important, I'm not a wimp.

Thanks,

        tglx
