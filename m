Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E24C0EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbiBWJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiBWJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:12:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6712BB04
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YzWp859QLM0F1Z+CN1RXxzkI9faaSC2BqekLPikm1Wc=; b=BEQd1gs4yHWgljJXVA+DDLNUZM
        Fa4LujvFmuK9wji2e5CUW8C94KzvIFwEgLTQHtPYDf6TpDdKfzBd+BpPZvyLs1tkrmxL7zZokax28
        w63vMUQ8bA/v9/O5Rga54VGFeZ1amaHDN3Kz22iOKwuknu1OmUhqLLVxMV1iyDFrBa3zZI4wjHx+l
        BWvNjk9YxlUJ+8rER9UB8Q1KJgN2pXO+RCDrgVcc/E9VgX1d980hN2RNFXox2FVWamEfxDR4tzXg4
        2a6u/sqnljHLBUTS14RCqIIUVq6wmJawsMvXx3/P6kr5CQ1Fr5vblYox7e75rBW2rX31hWkKRGocs
        nW4BbjGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMngG-00CDI5-F7; Wed, 23 Feb 2022 09:11:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACD3730045A;
        Wed, 23 Feb 2022 10:11:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4129E265BA142; Wed, 23 Feb 2022 10:11:26 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:11:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        Minye Zhu <zhuminye@bytedance.com>
Subject: Re: [PATCH v3 1/3] sched/cpuacct: fix charge percpu cpuusage
Message-ID: <YhX6Pg67eYf1jrOG@hirez.programming.kicks-ass.net>
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <YhUlD+NUMYdKB40J@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhUlD+NUMYdKB40J@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:01:51AM -1000, Tejun Heo wrote:
> On Sun, Feb 20, 2022 at 01:14:24PM +0800, Chengming Zhou wrote:
> > The cpuacct_account_field() is always called by the current task
> > itself, so it's ok to use __this_cpu_add() to charge the tick time.
> > 
> > But cpuacct_charge() maybe called by update_curr() in load_balance()
> > on a random CPU, different from the CPU on which the task is running.
> > So __this_cpu_add() will charge that cputime to a random incorrect CPU.
> > 
> > Fixes: 73e6aafd9ea8 ("sched/cpuacct: Simplify the cpuacct code")
> > Reported-by: Minye Zhu <zhuminye@bytedance.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> For all three patches,
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks!
