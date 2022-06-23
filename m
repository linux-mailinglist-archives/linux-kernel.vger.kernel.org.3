Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4C557D16
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiFWNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiFWNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:33:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45462614B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:33:01 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:32:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655991178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPpbqzf1BMiD81JZxOepu7Hhw2rNGkoV4SkcaOUH470=;
        b=bhzhdgFjtpj6ZJw5NGp3VY241MHfHBFFbf+ikiogLwkcYiRK9KNDHu76vPemiOMdggWgIH
        aqIb0jlf3hePhub1ZhQ5yhWaW2Bp7lyHv/eq8k2DgZYu0FYWjH8nguzT8L4UEH/3Y79IDL
        d2tJDgdDzrgnpPpMeSwxBYMUf+bvN7zv8m3NyhhWr+TEoAUMzx496Ouk+LpUllrzMvt+Rh
        U0pxVZAEW1H6qbDiEYTvWxKAnd8jamMZtLK9ED/tXViiSnDWEhd+gba8CU1lGZDgJvlzOT
        O7fG21B/UNp05SSS3+nDTwJ5+4rEzTGVkXEZMb8UsiQ6Ae0x2BvI2vihsv58pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655991178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPpbqzf1BMiD81JZxOepu7Hhw2rNGkoV4SkcaOUH470=;
        b=1esfgTMKP9dynFug7befiS0pxt9OuAs3G7tAE2Ysn0MBMYZSL8y5k58TTbCRsfYby+wgRb
        mey6UHURoY+0gqBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH v2] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Message-ID: <YrRriHsAdxPwEnWW@linutronix.de>
References: <20220621193641.609712-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621193641.609712-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-21 15:36:41 [-0400], Waiman Long wrote:
> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
> stealing") allows unlimited number of lock stealing's for non-RT
> tasks. That can lead to lock starvation of non-RT top waiter tasks if
> there is a constant incoming stream of non-RT lockers. This can cause
> task lockup in PREEMPT_RT kernel. For example,
> 
> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
> [ 1872.984225] INFO: task kworker/6:4:63401 blocked for more than 622 seconds.
> 
> Avoiding this problem and ensuring forward progress by limiting the
> number of times that a lock can be stolen from each waiter. This patch
> sets a threshold of 10. That number is arbitrary and can be changed
> if needed.
> 
> With that change, the task lockups previously observed when running
> stressful workloads on PREEMPT_RT kernel disappeared.

Do you have more insight on how this was tested/ created? Based on that,
systemd and a random kworker waited on a lock for more than 10 minutes.

I added a trace-printk each time a non-RT waiter got the lock stolen,
kicked a kernel build and a package upgrade and took a look at the stats
an hour later:
- sh got its lock stolen 3416 times. I didn't lock the pid so I can't
  look back and check how long it waited since the first time.
- the median average of stolen locks is 173.

> Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
> Reported-by: Mike Stowell <mstowell@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Sebastian
