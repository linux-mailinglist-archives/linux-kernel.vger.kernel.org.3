Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD524E9BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiC1P6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiC1P6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:58:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821B522C4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aKsjxMkQENAOBUkPYTl6YfQjAOa0EjF3Forn4KcmeIs=; b=o2E2mD5H64SFW9YBYGELehzcyb
        fTnokIKJraQFZ21HK66pMe6+4uwIZP8RV6u0C92e2agwqgLXBtEZxUqQf7GrBIpk8KpNUswKENh+H
        PhC1cgATQSkz66qkqbs2QkAyd9agkMxkLoloP6E+GRfdyCSarlVJe+8iY57BHpcYNp66Uk2/9Dqv/
        BSnSgnxTZ9wVSqbvZjIh6oa+7VxMUCgHKNVVoDRmBLKkjwo976GFEgnh/P18ya9bxMxTCSeq9rxd+
        enyd2FicPRbful63X0182I8mmBTXXzcVr18Wsp75aBG3XcwG92ogE67bwqkGZPYewOhLqcLReb9AJ
        WI+0Oa3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYriz-005Tzh-9z; Mon, 28 Mar 2022 15:56:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C954300454;
        Mon, 28 Mar 2022 17:56:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F42B206D95DB; Mon, 28 Mar 2022 17:56:07 +0200 (CEST)
Date:   Mon, 28 Mar 2022 17:56:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Message-ID: <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
 <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
 <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
 <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:40:25PM +0800, Chengming Zhou wrote:

> > NOHZ_FULL is for use-cases that 'never' intend to go into the kernel,
> > your use-case actively relies on going into the kernel. Hence the
> > confusion.
> 
> In fact, I put a testcase at the end of git message, in which only run
> a userspace loop workload:
> 
> cd /sys/fs/cgroup
> echo "+cpu" > cgroup.subtree_control
> 
> mkdir test
> echo "105000 100000" > test/cpu.max
> 
> echo $$ > test/cgroup.procs
> taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled

Ofcourse.. I'm arguing that bandiwdth control and NOHZ_FULL are somewhat
mutually exclusive, use-case wise. So I really don't get why you'd want
them both.

NOHZ_FULL says, "I 'never' intend to go to the kernel"

bandwidth control says: "I expect to be sharing the system and must be
interrupted to not consume too much time", which very much implies: "I
will go into the kernel".

The trade-off we make to make NOHZ_FULL work, makes system enter/exit
*far* more expensive. There's also people asking to outright kill a task
that causes entry under NOHZ_FULL.

So yes, you can configure it, but why does it make sense?
