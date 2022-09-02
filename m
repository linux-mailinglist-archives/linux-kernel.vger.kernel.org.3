Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC52A5AAA75
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiIBIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiIBIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:46:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFEA3AB06
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gCOBdo7zAEmukPCNnbpFJ0kFOV/vY2ppqcuTznwgHw0=; b=m1A6sqelp6znbxuo8roNLDNImd
        HlSj/k+OUh65U04sqkjA2/5S/B7hJEBqI+9yzqzrknUKbmmWok6oF6hSv5FpWnCfW08wawcytC5mX
        Anlxq+nxd7OJnuJJrY8ZzdzC9NL0Mv8+s6r+J+AAzI+HKyrz1WPiFcdmeqVhLB3DVByQh6wHsVnd0
        EvfqRCBsNhPWwhMOvDEijer6sXjjcYK9W6yI7KKRL44VX0rg/zqibJNouvjunWiOcEKt8KziLxQv1
        +oTrscpO8hgRqB/cPQfGtNi23Po7/iDghWTk5LD1WvnlQbEg2/bRbzbdn5wn42ZQ1QvZ6h6mg5ftw
        sodii03A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU2IZ-006sgQ-8s; Fri, 02 Sep 2022 08:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 900033002A3;
        Fri,  2 Sep 2022 10:45:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E2E32077EEBC; Fri,  2 Sep 2022 10:45:08 +0200 (CEST)
Date:   Fri, 2 Sep 2022 10:45:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Message-ID: <YxHClIhy1RPLT8P4@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
 <6281126b-3b93-86fa-25d6-d637b6c7dd87@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6281126b-3b93-86fa-25d6-d637b6c7dd87@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 09:53:22AM +0200, Dietmar Eggemann wrote:
> >  void update_rq_clock(struct rq *rq)
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -101,3 +101,6 @@ SCHED_FEAT(LATENCY_WARN, false)
> >  
> >  SCHED_FEAT(ALT_PERIOD, true)
> >  SCHED_FEAT(BASE_SLICE, true)
> > +
> > +SCHED_FEAT(PELT_M2, false)
> > +SCHED_FEAT(PELT_M4, false)
> 
> The sched features interface would definitely be much less official but
> I think it's not useful for Android since they don't mount debugfs anymore.

Well, they can haz a small patch that sets either one or both to true,
no?
