Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F34ECC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350056AbiC3SmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350353AbiC3Sl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:41:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE176CA4D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FB0BB81E21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428F5C340EC;
        Wed, 30 Mar 2022 18:37:50 +0000 (UTC)
Date:   Wed, 30 Mar 2022 14:37:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Message-ID: <20220330143748.37f4804c@gandalf.local.home>
In-Reply-To: <20220330182327.GO8939@worktop.programming.kicks-ass.net>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
        <20220328132047.GD8939@worktop.programming.kicks-ass.net>
        <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
        <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
        <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
        <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
        <20220328124454.08ab6126@gandalf.local.home>
        <20220330182327.GO8939@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 20:23:27 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Chengming brought up VMs. That's a case to want to control the bandwidth,
> > but also not interrupt them with timer interrupts when they are running as
> > the top priority task on a CPU.  
> 
> It's CFS, there is nothing top priority about that.

If there's only one task running on a CPU, even with CFS, why do we need a
tick?

Look, we have a host that is doing nothing but running VMs. Could be a
single VM. The host doesn't even have disk, it just runs on from initrd,
and the user is actually just logging into a guest.

Why should the host be triggering a tick when running this VM, which is the
only thing that is running on the host? Yeah, it's CFS, or does CFS have to
have a tick? even when there's nothing else on the CPU?

-- Steve
