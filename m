Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA85754F854
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380904AbiFQNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiFQNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:31:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E514D32
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kSD0Hz53mJC34EP3TCGfokG3QT5E0kZOaBd3T7HkYc4=; b=YYcsqLU8LbStVS+t+V5ekzL4aD
        Em8jzEN++MuegQwCGXjquu92aMXAigIVZrCJs3+akeIkc+poGRMGr4l8KrMoLZzGsj8GZ3PE+rzne
        CLydDEQtH+xq8fWsAyqhWzSaTyLqZl91KkZEGcTBmoi/PMEJ3ZOl7woBcc3eZyqjbEZstDT5JFkEy
        Q9e+vTDOG4Yr9Ex29os6rvIVCv5vHTxNNo32z1JtrEX0sJNPjX/HwaRep9cVypGfg0dnZYU79HC5o
        Qi7f2XDanr1YBM0l9Mpqd+NVOQ5uAdX8MNHxOvXDNEpbIB2Q2+YzTuC6gAFMXycI6niIsIBwMxoT7
        lt2zdsdg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2C4K-008hRe-CR; Fri, 17 Jun 2022 13:31:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAA8A9816B5; Fri, 17 Jun 2022 15:31:23 +0200 (CEST)
Date:   Fri, 17 Jun 2022 15:31:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched: Drop outdated compile-optimization comment
Message-ID: <YqyCK+31YgOlBY9U@worktop.programming.kicks-ass.net>
References: <20220615222745.3371892-1-briannorris@chromium.org>
 <xhsmhk09f7dgy.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhk09f7dgy.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:10:05PM +0100, Valentin Schneider wrote:
> On 15/06/22 15:27, Brian Norris wrote:
> > Looks like this exists from way back in 2011 (commit 095c0aa83e52
> > ("sched: adjust scheduler cpu power for stolen time")), when there was a
> > little more aggressive use of #if around these variables. That #if is
> > gone, and the comment just confuses the reader now. (For one, we don't
> > call sched_rt_avg_update() directly any more either.)
> >
> 
> So that sched_rt_avg_update() became update_irq_load_avg() with
> 
>   91c27493e78d ("sched/irq: Add IRQ utilization tracking")
> 
> and then the #ifdef configs were reorganized in
> 
>   11d4afd4ff66 ("sched/pelt: Fix warning and clean up IRQ PELT config")
> 
> I'd argue that comment is still somewhat relevant but it applies to that
> block:
> 
> #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
> 		update_irq_load_avg(rq, irq_delta + steal);
> #endif
> 
> if !CONFIG_HAVE_SCHED_AVG_IRQ then yes you'd expect the compiler to not
> even add a call to update_irq_load_avg() in there, but compilers aren't the
> most trustworthy things :-) If you feel like it, you could play with
> GCC/clang and see what they emit if you remove those #ifdefs.

Mostly I think it was the jump_label stuff getting them confused. I
suspect that's fixed in todays compilers tho, so yeah, it might be good
to get rid of it.
