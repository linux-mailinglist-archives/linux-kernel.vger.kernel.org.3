Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E700052AE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiEQWWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiEQWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:22:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64231239;
        Tue, 17 May 2022 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zJ7P6nHs2FXSAb1pKwGZ7xLH373p2maGUR8oSzVpxUw=; b=kwM0BNWqe5MFtQJCfKqAJFNLMB
        C5LqwMbIXLMLBvAP6fC64Hb6XNjmqPE7MV4GvZYDPOrC66WlMlXeujvXY5epxbqRptdnK/gwfgEwz
        j0zVVlqSk7+OQSdKdOBAicPkMx4xdM+PRXzxqNQW+hfxWqEGSjn5oW7TYYTBubXuDSr1oeFDD3FPd
        y9MssC1+ZwEc75ZkpwH+Q/zfgYcgOlm27uoD9h8A5RMQ37RK4YAXaBqVplYMyoAo9NNYib7w9Vqs0
        U3afd275t9+fcLeiRQ4SlQ8u6HzQdLIzcBCa+D6/Zj9qo1mJzaMfxGg2qm+Y2G/IqpBgW62aXnFna
        oRDRRMrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr5aE-00BDOq-Q9; Tue, 17 May 2022 22:22:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B6E6980DFD; Wed, 18 May 2022 00:22:24 +0200 (CEST)
Date:   Wed, 18 May 2022 00:22:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Address classes via __begin_sched_classes
Message-ID: <20220517222224.GS76023@worktop.programming.kicks-ass.net>
References: <20220517030024.3388355-1-keescook@chromium.org>
 <202205162032.5161269A45@keescook>
 <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
 <202205170952.A5251F141@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205170952.A5251F141@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:35:44AM -0700, Kees Cook wrote:

> What you've got below is almost exactly what I had in my first attempt
> at this (that I never posted). What I was missing and couldn't track
> down were the places you used sched_class_above(). I should have sent
> _that_ patch and asked where the comparisons were that I couldn't find.
> I think what you've got is much cleaner, as it makes the for loop use
> the normal iterator idiom.

Don't feel too bad; I forgot about the comparison in
check_preempt_curr() myself and cursed a while trying to figure out why
it stopped booting.

Anyway; I suppose I'll go queue the thing in sched/core so we can forget
about all this again.
