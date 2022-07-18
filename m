Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7DC577EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiGRJcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGRJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:32:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB11A837
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pxfVjTQqn7wXOhd19YJZCe2q/E6thx+T7hFS++QNFGY=; b=J/Wdxo7flkH5R3dt6FdOfdLkyw
        z88k6QfT96wjtD+EOU52Ud/RBvkUiQ6vNLaH8HpsslKUp88SBmAgAeJcMpxGaAFSx0OUZ94TmcsYF
        9hg0uFdbyaScdpVo8U45KoZR4qHNDjDxdhZ/9PzZ/czHnOWQb1x5u3f9dJkp+0Db0+c9sjTL2ijft
        Tnts2loDpTJdVleFGrNdDs3ZUXX8c+My6ZYc+AJb3YUo+Dvi9WDZeF9TYU5OeVeFewUa8Eb6i5XiM
        cle2wuyymwy8gSHMvSbD/K9O2l8KxYqDaeiUCgd7/ZZAZ+7QJ1zOvv3xRIGEqP8ptyGQSuLH9Ynbh
        ebuUqScA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDN6F-004nQL-7Z; Mon, 18 Jul 2022 09:31:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE46D980222; Mon, 18 Jul 2022 11:31:33 +0200 (CEST)
Date:   Mon, 18 Jul 2022 11:31:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <YtUodTM53de5vVxO@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com>
 <87zgh7wo91.ffs@tglx>
 <87tu7fwlhr.ffs@tglx>
 <87r12jwl9l.ffs@tglx>
 <87o7xnwgl3.ffs@tglx>
 <70b03d06-6ab9-1693-f811-f784a7dced76@suse.com>
 <87lesqx64u.ffs@tglx>
 <87ilnux0ji.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilnux0ji.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:55:29AM +0200, Thomas Gleixner wrote:
> On Mon, Jul 18 2022 at 08:54, Thomas Gleixner wrote:
> > On Mon, Jul 18 2022 at 07:11, Juergen Gross wrote:
> >>> -	switch_to_new_gdt(cpu);
> >>> +	switch_to_real_gdt(cpu);
> >>
> >> ... can't you use the paravirt variant of load_gdt in switch_to_real_gdt() ?
> >
> > That does not solve the problem of having a disagreement between GDT and
> > GS_BASE. Let me dig into this some more.
> 
> Bah. The real problem is __loadsegment_simple(gs, 0). After that GS_BASE
> is 0. So any per CPU access before setting MSR_GS_BASE back to working
> state is going into lala land.
> 
> So it's not the GDT. It's the mov 0, %gs which makes stuff go south, but
> as %gs is already 0, we can keep the paravirt load_gdt() and use
> native_write_msr() and everything should be happy.

How is the ret from xen_load_gdt() not going to explode?
