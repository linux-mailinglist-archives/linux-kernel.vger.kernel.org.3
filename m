Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD63F518368
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiECLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiECLqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A42E33
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2137F61615
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C84C385A9;
        Tue,  3 May 2022 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651578148;
        bh=hGA2Groz7gQQ/kmnt+I9Tr5rbZd9MlrRBpWEWxGepXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpGxvh0d20K/6UtArbCuUzhFAq7fYvm+TbmiBKBTpGEict/if0lxkTx8lzAVqO4H6
         bLNQ7Y7NQprxCAEaY4NxExedCdhS9uEWeyvJpIevEVbKfmeaaPGIre1LFfy65rY51c
         T5PGdtroK63XI2Y32FfK8XsuUHIlcJGsU18i/qD3NsLGT1KpknOI4jGC3bkyrAHq6A
         pX4bxTU0DQBefHSl3PaVz8VYy4rcYVsz29kegmPJWe8zu7ZbfGGOGnpOWjQOBvjBU4
         I9t/N6xkADnRRG5mEDTXe2WP605jTVs+Ot1Ic3/oPCk3WoLMS1urUdBT8TnJ93kMjM
         3CRv9m0gejEOw==
Date:   Tue, 3 May 2022 13:42:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20220503114225.GA2799075@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-11-frederic@kernel.org>
 <YnEL23pd9TDOFvYZ@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnEL23pd9TDOFvYZ@FVFF77S0Q05N>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 12:02:51PM +0100, Mark Rutland wrote:
> Hi Frederic,
> 
> On Tue, May 03, 2022 at 12:00:40PM +0200, Frederic Weisbecker wrote:
> > The RCU dynticks counter is going to be merged into the context tracking
> > subsystem. Start with moving the idle extended quiescent states
> > entrypoints to context tracking. For now those are dumb redirections to
> > existing RCU calls.
> 
> I was a bit confused looking at this, because that redirection only exists for
> CONFIG_CONTEXT_TRACKING, and is empty otherwise.
> 
> I see this patch makes TREE_RCU select CONTEXT_TRACKING, which means that
> works. Since that also means building the rest of the context tracking code, I
> think it'd be worth mentioning that in the commit message.

Not exactly, it only builds a minimal version of CONTEXT_TRACKING, which maps
to roughly the vanilla RCU-idle code.

The user tracking part (which is the vanilla CONTEXT_TRACKING) now becomes
CONFIG_CONTEXT_TRACKING_USER

> Do all architectures which can use TREE_RCU today already support context
> tracking? If not, do those work by default?

No need to, the old context tracking becomes CONFIG_CONTEXT_TRACKING_USER
which is not needed by TREE_RCU.

Ok you're right, this is all very confusing :o)

Let's clarify this, I'm going to do the following on the next version:

* The current CONFIG_CONTEXT_TRACKING becomes CONFIG_CONTEXT_TRACKING_USER.
  This part needs support from the architecture.

* The RCU-idle functions that have been moved to context tracking will become
  CONFIG_CONTEXT_TRACKING_IDLE. This part doesn't need support from the
  architecture and will be set by TREE_RCU.

Would that look clearer?

Thanks.
