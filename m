Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDA2505C79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbiDRQeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346373AbiDRQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920A31370
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB498612B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2EEC385A1;
        Mon, 18 Apr 2022 16:31:17 +0000 (UTC)
Date:   Mon, 18 Apr 2022 12:31:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zgpeng <zgpeng.linux@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix the scene where group's imbalance is
 set incorrectly
Message-ID: <20220418123116.2e4f6b1e@gandalf.local.home>
In-Reply-To: <1649566716-24687-1-git-send-email-zgpeng@tencent.com>
References: <1649566716-24687-1-git-send-email-zgpeng@tencent.com>
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

On Sun, 10 Apr 2022 12:58:36 +0800
zgpeng <zgpeng.linux@gmail.com> wrote:

> The specific trigger scenarios are as follows. In the
> load_balance function, the first loop picks out the busiest
> cpu. During the process of pulling the process from the
> busiest cpu, it is found that all tasks cannot be run on the
> DST cpu. At this time, both LBF_SOME_PINNED andLBF_ALL_PINNED
> of env.flags are set. Because balance fails and LBF_SOME_PINNED
> is set, the parent group's mbalance flag will be set to 1. At
> the same time, because LBF_ALL_PINNED is set, it will re-enter
> the second cycle to select another busiest cpu to pull the process.
> Because the busiest CPU has changed, the process can be pulled to
> DST cpu, so it is possible to reach a balance state.

But is the next cpu selected really the busiest CPU? Or is the original
still the busiest but doesn't have any tasks that can migrate to the dst
CPU? Does it really mean the parent is now unbalanced?

-- Steve


> 
> But at this time, the parent group's imbalance flag is not set
> correctly again. As a result, the load balance is successfully
> achieved, but the parent group's imbalance flag is incorrectly
> set to 1. In this case, the upper-layer load balance will
> erroneously select this domain as the busiest group, thereby
> breaking the balance.
