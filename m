Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1F502954
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352954AbiDOMEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353008AbiDOMEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:04:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D22BD2DF;
        Fri, 15 Apr 2022 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I9T22GM+Ng/opSmsZDxjJjw+hUXdR4RJPukdevZlM64=; b=arsokogJj0I6yMEqWi+ERQFB7B
        K8jmEM7/ICFx4t6wAb0dir/YjFeepTmdRtIfC8BDDcw/L+ySzaoxB3hJcYmHGdIz9Dl1TS8VY3904
        hv2MfvWOMbz0zSuQ108wVGRALTSxL5sLbfGw8ps08zW+ePaIyx4aJAuTmL7/AJ8jE9xx7KeHirV5g
        k0FhtOmWoJK7/Jr+GXAPSMjLJ6DqqLNZXHfI6MCFjh+1NrBNldZBrwYotaXU4hLhQnjxDb70zA9uU
        9UQTz7Fuv2KzzBiB1sZ21vVhjdb8UryhQugu6OCr6ahBE5GmFFmJySdTHGDSYVWX770X6VbVV8Zxg
        bJmDaa9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKe1-00G62u-KA; Fri, 15 Apr 2022 12:01:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17C0C3001AD;
        Fri, 15 Apr 2022 14:01:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0750730A3B961; Fri, 15 Apr 2022 14:01:44 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:01:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
References: <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415105755.GA15217@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:57:56PM +0200, Oleg Nesterov wrote:
> On 04/15, Oleg Nesterov wrote:
> >
> > OK, so far it seems that this patch needs a couple of simple fixes you
> > pointed out, but before I send V2:
> >
> > 	- do you agree we can avoid JOBCTL_TRACED_FROZEN in 1-2 ?
> >
> > 	- will you agree if I change ptrace_freeze_traced() to rely
> > 	  on __state == TASK_TRACED rather than task_is_traced() ?
> >
> 
> Forgot to say, I think 1/5 needs some changes in any case...
> 
> ptrace_resume() does  wake_up_state(child, __TASK_TRACED) but doesn't
> clear JOBCTL_TRACED. The "else" branch in ptrace_stop() leaks this flag
> too.

Urgh, yes, I seemed to have missed that one :-(

