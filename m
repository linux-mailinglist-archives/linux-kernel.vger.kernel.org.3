Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6C5787A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiGRQmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255BADFDC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF93E6151D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE252C341C0;
        Mon, 18 Jul 2022 16:42:28 +0000 (UTC)
Date:   Mon, 18 Jul 2022 12:42:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: schedstat false counting of domain load_balance() tried to move
 one or more tasks failed
Message-ID: <20220718124227.17b3c611@gandalf.local.home>
In-Reply-To: <YtUtHqig/SNka/XO@worktop.programming.kicks-ass.net>
References: <20220712215259.6cb28bed@gandalf.local.home>
        <YtUtHqig/SNka/XO@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 11:51:26 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Do we care? Should it be fixed? Should it be documented?  
> 
> *shrug*, I suppose we can fix. People using this stuff are the sort that
> are likely to read documentation instead of code.

Yep.

> 
> At the same time; I suspect it's been 'broken' like forever, so who
> knows what people are actually expecting today.

As you stated, it's used by people that read documentation more than the
code. My expectation is that they are making wrong decisions because what
they expect those numbers to mean are not what is actually happening.

I think it's better to make the functionality match the documentation, and
if people complain, we can ask them what exactly they expected and why. And
perhaps they might be complaining that a benchmark isn't behaving as
expected because they were interpreting the results incorrectly.

I'll go write up a fix.

Thanks!

-- Steve
