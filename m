Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4D520E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiEJG7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiEJG7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:59:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD59263DBD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1M4hiY36ZXy+YQMJbN4a9TufNa6xmj19bJZyuQtqeG4=; b=VNcj3kIw8Hgi2NDwb7+XvCnHdH
        3r3rEzBldxqpAakYVbTyghtvPSonlrWCFRP3CwiVhVJr6RRRIjBHYvngOScCjPw7thXLfioMDBhBk
        U04f919ecuZZFMS0+5owQ+qeDFlOXcJ4OUGjV40ecuzb3LaLAfZtBoFe6U0S6PTzrUBb+n0yT/DvR
        cW1qZANE9bQhqITRBTzAD2TBSPdtSjdu7PYg2vkol/K2+T8Ka3RyLSrkvbZ4eoo37b5OOwXzlIEwT
        GJHkgWYMy+s3vw7QahQG435lDJ4QjPVRC919t9mJqkmlNufF7fsW+MSjdIXUHsqbVoF30wwbiMbZd
        b/KBEvHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noJls-00ClLd-Ah; Tue, 10 May 2022 06:55:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B37BA981010; Tue, 10 May 2022 08:54:57 +0200 (CEST)
Date:   Tue, 10 May 2022 08:54:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Folllowing up on LSF/MM RCU/idle discussion
Message-ID: <20220510065457.GI76023@worktop.programming.kicks-ass.net>
References: <20220509155633.GA93071@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509155633.GA93071@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:56:33AM -0700, Paul E. McKenney wrote:
> Hello, Jiri!
> 
> It was good chatting with you last week, and I hope that travels went
> well!
> 
> Just wanted to follow up on the non-noinstr code between the call
> to rcu_idle_enter() and rcu_idle_exit().  Although the most correct
> approach is to never have non-noinstr code in arch_cpu_idle(), for all I
> know there might well be architectures for which this is not feasible.
> If so, one workaround would be to supply a flag set by each arch (or
> subarch) that says that rcu_idle_enter() and rcu_idle_exit() are invoked
> within arch_cpu_idle().
> 
> CCing Peter, who just might have an opinion on this.  ;-)

Definitely have an opinion; just lack the tools to enforce these rules.
I cleaned up the worst of it for x86 but it's a shit-show for most
others. ARM in particular has some 'issues'.

But yeah, noinstr only when you do rcu_idle_enter.

The problem with validating all this is that cpuidle is a rats nest of
indirect calls; in order to validate the noinstr'ness of something like
that we need compiler support for pointer address spaces such that we
can stick pointers to noinstr functions in a different address space and
get complaints etc..
