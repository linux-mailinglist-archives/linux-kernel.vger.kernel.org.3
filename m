Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BEB50701E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348755AbiDSOVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346632AbiDSOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317F643F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB86E6164E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C5EC385A5;
        Tue, 19 Apr 2022 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377928;
        bh=TOSmMe6VRJA13En4Niwv/PYtsIFaR2wHyfCU+bnpsGU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=abJ5qDpEvGhr1N+dWDMtWAWJLTE5y54/X5VhcciYVny+4kYuwrWSQM7WJvyfZcTYJ
         A1L610jbtegDeFxDAZsHyxjieGfGHUF6EslYTo6VIUhNK2pcHZqHgAKNVdeWVCajG1
         ST/25vXBB4c+B5udX/Jot8WQ0S67JP2pvix62Gs6ENNyhyskm78nKwaTyLtK3zmieF
         ts5zqsPrtdvmwk1IcdGhomnrXhNZQuO6wh3zWuO//QFYn7JMZMAfQcN9msXkGbwBJL
         42/UUbacL+TvTvewZeweC2eRDE3ihixZQLjgR8JpzjjGAZSQjD6kkmVhsh2cFra62+
         9QgiDLwJnm1SQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B3A245C031F; Tue, 19 Apr 2022 07:18:47 -0700 (PDT)
Date:   Tue, 19 Apr 2022 07:18:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/3] rcu/nocb: Fixes and simplification
Message-ID: <20220419141847.GH4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220419122320.2060902-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419122320.2060902-1-frederic@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 02:23:17PM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> Some updates for the nocb side:
> 
> * 1st patch is a simplification on adding/deleting an rdp to a nocb group
> 
> * 2nd and 3rd are fixes for the kthread's creation failure path
> 
> Frederic Weisbecker (1):
>   rcu/nocb: Add/del rdp to iterate from rcuog itself

A very welcome simplification!

> Zqiang (2):
>   rcu: Invert rcu_state.barrier_mutex VS hotplug lock locking order
>   rcu/nocb: Fix NOCB kthreads spawn failure with
>     rcu_nocb_rdp_deoffload() direct call

And here is to added robustness!

I queued these for review and testing, thank you!  By default, these
would go into the v5.20 (or will it be v6.0?) pile.  Please let me know
if they are more urgent and need to go into v5.19 instead.

							Thanx, Paul

>  kernel/rcu/tree.h      |   1 +
>  kernel/rcu/tree_nocb.h | 226 +++++++++++++++++++++++++----------------
>  2 files changed, 139 insertions(+), 88 deletions(-)
> 
> -- 
> 2.25.1
> 
