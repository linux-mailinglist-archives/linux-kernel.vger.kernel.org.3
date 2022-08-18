Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C725988D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbiHRQ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344786AbiHRQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:28:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2883E0CE;
        Thu, 18 Aug 2022 09:28:06 -0700 (PDT)
Date:   Thu, 18 Aug 2022 18:28:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660840084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRTVq6FMPaQVH3R6PFr1y0wp2p0Fv7JQuFoG/1x21lI=;
        b=pvLLxS8UByH12yyhGrZNKIX6Z4egm2GF22xXz6epuwdCY2eANFlBRxNYd2I++0XNHfyk6w
        rUGiNzWvO+FCAnx5+OqF0WevsL2fFnVLiV+lWCt4vJPyEksSZLXc6AP3LTlZZkDpwjwP1Z
        QMddf0H7+HqmhusyP7zzk9bOy2U17c/a1BOCA4YNI3kP9zvZvpkiI6sAXm1U7L4VQmC8bu
        kWRiV4PgZGCd5Mf1RnzdGKQlaf3Fpsie2NTjNdph9sa75LZP2HhyKuxfgkA/l2RtPTORG/
        2iEsbMHsiuVkMR7ZT9qHhNFoa8vg09tkZw7wBfQeCcGdslnw6IzNl9if8uPk6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660840084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRTVq6FMPaQVH3R6PFr1y0wp2p0Fv7JQuFoG/1x21lI=;
        b=t/Hs/pi1zuC46GhSD96ccovmViwaYG7LaaKKKqn7cCcn97CMr7XEXNvfK+eJgZHP9fIvwW
        6aG+yEmmbUl7QCDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH] irq_work: wakeup irq_workd when queued first rt_lazy
 work
Message-ID: <Yv5okqzH92iPytgl@linutronix.de>
References: <20220711172314.603717-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711172314.603717-1-schspa@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-12 01:23:15 [+0800], Schspa Shi wrote:
> I want to know if this difference is by design.

Yes. type1 (LAZY) does not need immediate action but can't be scheduled
regularly like a workqueue.

> If this is by design, we have a problem that the irq_work of type2
> will not execute as quickly as expected, it may be delayed by the
> irq_work of type1.
> 
> Please consider the following scenarios:
> 
> If the CPU queued a type1 irq_work A, and then a type2 irq_work B.
> But we won't make B executed quickly, because we won't issue the IPI
> interrupt to wakeup irq_workd (the llist_add call will return false).

But those two are different lists. So adding type1 to list1 does not
affect type2 with list2

> This PATCH will issue the IPI_IRQ_WORK to make B execute quickly.
> 
> One thing that needs to be optimized is that we now have
> lazy_list.node.llist and lazy_work_raised which need to be granted
> to be atomicity, disabled the local CPU IRQ to make this atomic.
> There should be a better way to make these two variants to be atomically
> and I can go in deep if this little problem is not by design, and need
> to be fixed.
> 
> If these two types of irq_work should be the same with the priority.
> maybe we should change.
> 
> if (!lazy_work || tick_nohz_tick_stopped()) {
> 	arch_irq_work_raise();
> }
> 
> to
> 
> if (!(lazy_work || rt_lazy_work) || tick_nohz_tick_stopped()) {
> 	arch_irq_work_raise();
> }

but we wait for the timer for the lazy-work. RT has more LAZY items
compared to !RT. So if there is an error then it should be visible
there, too.

Is there a problem with this? Adding (as you call it) type1 item does
not affect type2 items. They will will processed asap.

Sebastian
