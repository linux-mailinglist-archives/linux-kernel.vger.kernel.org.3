Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9352BD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiERN7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiERN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:59:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC41A7D28
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=diFgENTszdQUHXAKgwYmdyZMPkaYBZcehcdCuI+8CNI=; b=piMPTHj0XG5LeId6adfAZJaoiu
        gsW2AlDfqunjvacbNZ/xs4ODNR4GizI/LByJtwiD30R11aQIkyOmX3NDkQ+jgnqWMOXc2GtT0LE99
        PnDJ0pGknFeTbCpw1F3+NIjAuuv9Irh5ovdQgb6UNJZjvzQORVnts4X88IrdFjxtgT/dN4UjZy2U4
        Pwcu9m61SgyVlI3lZ4ECgfKR4hlHsnRgSJ0GLCv5J3YLYLJVpHfol+t5/bnuuLbonzVNv0nvliGUw
        p1Nn5EKLXc/vLbBXxIaO9APm0HBwzecwb7RCKeNfiyPB/BGf08Iog1J9oDAQouGohRcGq2u2vAdDR
        urBkCclg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrKD9-001YVZ-N4; Wed, 18 May 2022 13:59:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AFB93003AA;
        Wed, 18 May 2022 15:59:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00C42202391E4; Wed, 18 May 2022 15:59:34 +0200 (CEST)
Date:   Wed, 18 May 2022 15:59:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/numa: Apply imbalance limitations consistently
Message-ID: <YoT7xtVc0f3DVCKL@hirez.programming.kicks-ass.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-4-mgorman@techsingularity.net>
 <20220518093156.GD10117@worktop.programming.kicks-ass.net>
 <20220518104652.GO3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518104652.GO3441@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:46:52AM +0100, Mel Gorman wrote:

> > (Although I do wonder about that 25% figure in the comment; that doesn't
> > seem to relate to any actual code anymore)
> > 
> 
> You're right, by the end of the series it's completely inaccurate and
> currently it's not accurate if there are multiple LLCs per node. I
> adjusted the wording to "Allow a NUMA imbalance if busy CPUs is less
> than the maximum threshold. Above this threshold, individual tasks may
> be contending for both memory bandwidth and any shared HT resources."
> 

Looks good. Meanwhile I saw a 0-day complaint that this regresses
something something unixbench by a bit. Do we care enough? I suppose
this is one of those trade-off patches again, win some, loose some.
