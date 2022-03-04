Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF70A4CD3A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiCDLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCDLkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:40:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6FFE1B4A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=soYLqIaabrojJTsdxVxq7SKnvZyWr2ESfZBpZ/MSOIM=; b=ldSSjBN6xi5Dv2O2I+P4B4NsgB
        LhdNpQ4gXpormFHR4jxrp3KDBCQQzfIakm4LZzmDMmjU5pCERn4ieQYiqRQB+NrG+pQ8jHg9ciSq/
        UY6FpyVEn23umt20IuCTqnc/92WWVa22FxrYuiWIz816/TjKygSx5FL1hf0Z48o0mwkLQv4onCFlA
        fxQPsydbX5tCziDYjm5tTLwK8s0nDsMSDQ2ZYPSDqOlqb2/vMblaa4WJoChvH8+Ua0YhcdbvIwvhG
        RK7doZxRPOCeTh/CbWvDugBJZiR9a2AkaD9kp7l1KfiF7ks61bnOvfy1bJZl1e2ejgesxHsQoOk0g
        4KtuwZAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ6HF-00FBIZ-W6; Fri, 04 Mar 2022 11:39:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A95483001EA;
        Fri,  4 Mar 2022 12:39:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3902C2C7FBE92; Fri,  4 Mar 2022 12:39:15 +0100 (CET)
Date:   Fri, 4 Mar 2022 12:39:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] sched/deadline, (rt): Sched class cleanups
Message-ID: <YiH6Y5NYgRlZJHua@hirez.programming.kicks-ass.net>
References: <20220302183433.333029-1-dietmar.eggemann@arm.com>
 <YiHaLT39YcsjPeTB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiHaLT39YcsjPeTB@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:21:49AM +0100, Juri Lelli wrote:
> Hi,
> 
> On 02/03/22 19:34, Dietmar Eggemann wrote:
> > While trying to improve the Deadline sched class behaviour for
> > asymmetric CPU capacity systems I came across some possible
> > cleanups for DL (and RT).
> > 
> > Overview:
> > 
> > [PATCH 1/6] - Remove `struct dl_bandwidth def_dl_bandwidth`.
> > 
> > [PATCH 2/6] - Move functions into DL sched class which don't have to
> >               be exported.
> > 
> > [PATCH 3/6] - Merge two DL admission control functions which provide
> >               very similar functionality.
> > 
> > [PATCH 4/6] - Use DL rb_entry() macros and cached rbtree wrapper
> >               `rb_first_cached()` consistently.
> > 
> > [PATCH 5/6] - Remove unused !CONFIG_SMP function definitions in DL/RT.
> > 
> > [PATCH 6/6] - Remove redundant function parameter in DL/RT.
> > 
> > Dietmar Eggemann (6):
> >   sched/deadline: Remove unused def_dl_bandwidth
> >   sched/deadline: Move bandwidth mgmt and reclaim functions into sched
> >     class source file
> >   sched/deadline: Merge dl_task_can_attach() and dl_cpu_busy()
> >   sched/deadline: Use __node_2_[pdl|dle]() and rb_first_cached()
> >     consistently
> >   sched/deadline,rt: Remove unused functions for !CONFIG_SMP
> >   sched/deadline,rt: Remove unused parameter from
> >     pick_next_[rt|dl]_entity()
> > 
> >  kernel/sched/core.c     |  14 ++--
> >  kernel/sched/deadline.c | 141 ++++++++++++++++++++--------------------
> >  kernel/sched/rt.c       |  16 +----
> >  kernel/sched/sched.h    |  53 +--------------
> >  4 files changed, 84 insertions(+), 140 deletions(-)
> 
> These look ok to me. Thanks for the cleanups!
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
