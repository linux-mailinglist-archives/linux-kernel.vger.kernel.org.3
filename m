Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549A75028E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352651AbiDOLgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbiDOLgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:36:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087513D2D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UXAScB/7dXiIcZZ+SfTsfL5JTQZXS0Nu46DcE+Qd/Sg=; b=ZMLBAUGxpS298vNajAPNIIBo38
        x9FlOEmikFX4DvHYFcI5v2+SYCw3y3IK9bV36jEd0VBTYan1pLe2TQjTJ6x2LzsmJQEX6O9m8kj0z
        0st6BBRpHes0AiQm/DEqGNpoqPKwYesFxoJQx74ZUmjEqvlpKuXk04bN/zKIM1wrzq934aWru5oRX
        DgtNL4+9SD+mR5/krYUOec7cZR6s1prkm/V37lzqrk2rB7am3qDlrogwAVMFnmOyrau4S3Qzq8Hon
        Oy4I05eDnmLNrfJsiySthPFkzBOiiV3WYqEhxIEdHjQwmAifpdasx8oSz3+8NbsSuJ+uGkMAUJqz3
        oyIYIb/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKD4-005MnD-3Z; Fri, 15 Apr 2022 11:33:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82ADA3001AD;
        Fri, 15 Apr 2022 13:33:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 381C92D206192; Fri, 15 Apr 2022 13:33:53 +0200 (CEST)
Date:   Fri, 15 Apr 2022 13:33:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V1 RESEND]: sched/fair: Revise comment about lb decision
 matrix
Message-ID: <YllYIQXmpqHM0+Wp@hirez.programming.kicks-ass.net>
References: <20220415022246.14902-1-tao.zhou@linux.dev>
 <CAKfTPtAbxAerbV-LBcpm_qHAphhD3uU47k0hu=DDX3k6LS-Aow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAbxAerbV-LBcpm_qHAphhD3uU47k0hu=DDX3k6LS-Aow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:32:09AM +0200, Vincent Guittot wrote:
> On Fri, 15 Apr 2022 at 04:22, Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > If busiest group type is group_misfit_task, the local
> > group type must be group_has_spare according to below
> > code in update_sd_pick_busiest():
> >
> > if (sgs->group_type == group_misfit_task &&
> >     (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
> >      sds->local_stat.group_type != group_has_spare))
> >          return false;
> >
> > group type imbalanced and overloaded and fully_busy are filtered in here.
> > misfit and asym are filtered before in update_sg_lb_stats().
> 
> The behavior has changed with
> cad68e552e77 ("sched/fair: Consider misfit tasks when load-balancing")
> But we haven't updated the matrix
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks (I took the later version and stuck your Rb on)!
