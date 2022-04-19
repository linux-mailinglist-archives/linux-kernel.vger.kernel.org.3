Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D847750629E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346797AbiDSDeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiDSDeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:34:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E672B247;
        Mon, 18 Apr 2022 20:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61F0CB81054;
        Tue, 19 Apr 2022 03:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C74EC385A7;
        Tue, 19 Apr 2022 03:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650339087;
        bh=Y9YnLiCzTlOrqwy67zpMaCNpDpR2OnRmXkKOP+LieOI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jaWlx2QFnwgI6MutLn+BZNBtCk3WXrbAToibCmh4nNzI4g1W6/Vn8evsVzJSY5Spa
         RcVPBcjTVKAlHI4DbD6LRaCMD8dItQqaVNBqFPkkTmmzQkn3be5ZZG9NyRA6k8zg3W
         9vNEX7gxJkM7Lc7pn7f0ozo8ZQ2qEY05k/cLD44jrZERfFVlB+AkrhzfAH+Vk4L62k
         VHoNCC1LhIbtcauwV1zkk1NZQAI1+Zjsmtdlo0WXoPwFc1sRIQOoi++mIDkCKEOz7V
         /Q5V9OZ2VVMBqXG7RBTeUkpfcXhE7uruT2COrj2bNi5BopqN4aJ90tBMbqAdWjG8cQ
         YorwvC3TRzmfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A40325C0A23; Mon, 18 Apr 2022 20:31:26 -0700 (PDT)
Date:   Mon, 18 Apr 2022 20:31:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <20220419033126.GB4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220419123624.12c57642@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419123624.12c57642@canb.auug.org.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 12:36:24PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> In file included from kernel/rcu/tree.c:5031:
> kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
> kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared (first use in this function); did you mean 'rcu_nocb_setup'?
>  1162 |         if (!rcu_nocb_is_setup) {
>       |              ^~~~~~~~~~~~~~~~~
>       |              rcu_nocb_setup
> kernel/rcu/tree_nocb.h:1162:14: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   d6932dca19b1 ("rcu/nocb: Add an option to offload all CPUs on boot")
> 
> interacting with commit
> 
>   8d2aaa9b7c29 ("rcu/nocb: Move rcu_nocb_is_setup to rcu_state")
> 
> I have used the rcu tree from next-20220414 for today.

Again, apologies!

I have dropped that commit from -rcu and am retesting, and will update
rcu/next accordingly.

							Thanx, Paul
