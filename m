Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6DA51858F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiECNhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiECNhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:37:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35257338BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:33:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E221C1042;
        Tue,  3 May 2022 06:33:30 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC813F774;
        Tue,  3 May 2022 06:33:28 -0700 (PDT)
Date:   Tue, 3 May 2022 14:33:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 10/21] context_tracking: Take idle eqs entrypoints over
 RCU
Message-ID: <YnEvIhNVOEDyS6/A@lakrids>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-11-frederic@kernel.org>
 <YnEL23pd9TDOFvYZ@FVFF77S0Q05N>
 <20220503114225.GA2799075@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503114225.GA2799075@lothringen>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 01:42:25PM +0200, Frederic Weisbecker wrote:
> On Tue, May 03, 2022 at 12:02:51PM +0100, Mark Rutland wrote:
> > Hi Frederic,
> > 
> > On Tue, May 03, 2022 at 12:00:40PM +0200, Frederic Weisbecker wrote:
> > > The RCU dynticks counter is going to be merged into the context tracking
> > > subsystem. Start with moving the idle extended quiescent states
> > > entrypoints to context tracking. For now those are dumb redirections to
> > > existing RCU calls.
> > 
> > I was a bit confused looking at this, because that redirection only exists for
> > CONFIG_CONTEXT_TRACKING, and is empty otherwise.
> > 
> > I see this patch makes TREE_RCU select CONTEXT_TRACKING, which means that
> > works. Since that also means building the rest of the context tracking code, I
> > think it'd be worth mentioning that in the commit message.
> 
> Not exactly, it only builds a minimal version of CONTEXT_TRACKING, which maps
> to roughly the vanilla RCU-idle code.
> 
> The user tracking part (which is the vanilla CONTEXT_TRACKING) now becomes
> CONFIG_CONTEXT_TRACKING_USER

Ah, sorry. That makes sense to me now!

> > Do all architectures which can use TREE_RCU today already support context
> > tracking? If not, do those work by default?
> 
> No need to, the old context tracking becomes CONFIG_CONTEXT_TRACKING_USER
> which is not needed by TREE_RCU.
> 
> Ok you're right, this is all very confusing :o)
> 
> Let's clarify this, I'm going to do the following on the next version:
> 
> * The current CONFIG_CONTEXT_TRACKING becomes CONFIG_CONTEXT_TRACKING_USER.
>   This part needs support from the architecture.
> 
> * The RCU-idle functions that have been moved to context tracking will become
>   CONFIG_CONTEXT_TRACKING_IDLE. This part doesn't need support from the
>   architecture and will be set by TREE_RCU.
> 
> Would that look clearer?

I think so, yes!

It would also help if the prior commit message could be explicit about
the end result: After the Kconfig rework both
CONFIG_CONTEXT_TRACKING_USER and CONFIG_CONTEXT_TRACKING exist, but
CONFIG_CONTEXT_TRACKING will only used to decide whether to build object
files with common context tracking logic.

Thanks,
Mark.
