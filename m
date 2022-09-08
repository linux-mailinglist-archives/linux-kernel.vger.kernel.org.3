Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBED5B1E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiIHNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiIHNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:17:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408AA11A2E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D3q2kBPBoNRfb4tzwlAxKN9FDcdEZ2kJXehUeC88WqE=; b=V879NoRNWfH7qekWEGQKYigzS4
        M851kniVibQwsZBJnsaH8gIA7KN0lG1omIH+YxjehNsG2ddtSUdDEBzRor8H8ysVu0nBBRyN7nBYb
        O07fjFsEfFpiBqIguRYgrzdPbav/+6Xj2dN97oHYL4bwYZMvYEpzlvnkaXdnV2MVRHikbdJV22RNL
        s4J7COiR52OO0ymYj1lRKNl1EW9MKN5GwggH8Jkgu9OXdViW8tBwmTtfF5Jq5uuo/1K33VHLWhKts
        3bMjuIsEIl2tzWcgsuIk0a2gB2oCWphYj6Enm8tHriXtupBBNkWq6e4s6LzsAqEgDCNLchtzo3Dzr
        6lCj+6hw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWHOx-00CMgr-T9; Thu, 08 Sep 2022 13:17:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7628300074;
        Thu,  8 Sep 2022 15:17:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 614C22B9B99DF; Thu,  8 Sep 2022 15:17:01 +0200 (CEST)
Date:   Thu, 8 Sep 2022 15:17:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rohit Jain <rohit.k.jain@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix misuse of available_idle_cpu()
Message-ID: <YxnrTdwA493gIHS8@hirez.programming.kicks-ass.net>
References: <20220908080702.58938-1-wuyun.abel@bytedance.com>
 <20220908103632.yzm5boxrr3nmvhpm@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908103632.yzm5boxrr3nmvhpm@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 11:36:32AM +0100, Mel Gorman wrote:
> On Thu, Sep 08, 2022 at 04:07:02PM +0800, Abel Wu wrote:
> > The function available_idle_cpu() was introduced to distinguish
> > between the code paths that cares if the vCPU is preempted and
> > the ones don't care. In general, available_idle_cpu() is used in
> > selecting cpus for immediate use, e.g. ttwu. While idle_cpu() is
> > used in the paths that only cares about the cpu is idle or not,
> > and __update_idle_core() is one of them.
> > 
> > Use idle_cpu() instead in the idle path to make has_idle_core
> > a better hint.
> > 
> > Fixes: 943d355d7fee (sched/core: Distinguish between idle_cpu() calls based on desired effect, introduce available_idle_cpu())
> > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> Seems fair. As vCPU preemption is specific to virtualisation, it is very
> unlikely that SMT is exposed to the guest so the impact of the patch is

Right; only pinned guests typically expose such topology information
(anything else would be quite broken).

> minimal but I still think it's right so;

I'm not convinced; all of select_idle_sibling() seems to use
available_idle_cpu(), and that's the only consumer of
__update_idle_core(), so in that respect the current state makes sense.
