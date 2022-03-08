Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A24D2759
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiCIBUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiCIBT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:19:57 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5D30A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XqYDQ0sO8lLcFH38iNpLV9+za02YSz1bbsT0KsfeIP8=; b=Pjh/y28/PAdf3s2neTwwwFdFwP
        q2hbcI7URxbuj/rRtMJv+J+/zMaLs1xfegdV5hwwbn1TReO6VUZYFQnesEN9d+VS0DOtvRupX2AFL
        /mUpbgjG/CCa7zHYIUoIzvf8WvNFHOqK1IZwm9Di9sCZeI0Lm4LS+hVkMc2BvMzeIGDVh/UahgjdK
        XIoO1f3XX9cgSrxPjX1Flc9HQNbdxAWjNZ//HopeZIxaOmZdaxNOpObW2kc49+SOEWA7BEKrXyQIa
        NF+qhPF3PZU0H16aajB15UWjkI8Sr3HbdSJ+y1e8cUydVc42gBfRxZXIRbCHDaX/Cvi8OTKS226+A
        xqE1CzsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRjJc-00GaWd-EZ; Tue, 08 Mar 2022 23:32:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 149C030027B;
        Wed,  9 Mar 2022 00:32:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE5D0203C81E0; Wed,  9 Mar 2022 00:32:25 +0100 (CET)
Date:   Wed, 9 Mar 2022 00:32:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Message-ID: <YifniVyoJ9NNU+pv@hirez.programming.kicks-ass.net>
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <20220220051426.5274-2-zhouchengming@bytedance.com>
 <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
 <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:20:33AM +0100, Marek Szyprowski wrote:
> On 20.02.2022 06:14, Chengming Zhou wrote:
> > Since cpuacct_charge() is called from the scheduler update_curr(),
> > we must already have rq lock held, then the RCU read lock can
> > be optimized away.
> >
> > And do the same thing in it's wrapper cgroup_account_cputime(),
> > but we can't use lockdep_assert_rq_held() there, which defined
> > in kernel/sched/sched.h.
> >
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> This patch landed recently in linux-next as commit dc6e0818bc9a 
> ("sched/cpuacct: Optimize away RCU read lock"). On my test systems I 
> found that it triggers a following warning in the early boot stage:
> 
> Calibrating delay loop (skipped), value calculated using timer 
> frequency.. 48.00 BogoMIPS (lpj=240000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> CPU: Testing write buffer coherency: ok
> CPU0: Spectre v2: using BPIALL workaround
> 
> =============================
> WARNING: suspicious RCU usage
> 5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
> -----------------------------
> ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!

Arguably, with the flavours folded again, rcu_dereference_check() ought
to default include rcu_read_lock_sched_held() or its equivalent I
suppose.

Paul?
