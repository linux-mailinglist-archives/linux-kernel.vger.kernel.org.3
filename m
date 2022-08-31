Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B335A84F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiHaSGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiHaSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D01DDB40;
        Wed, 31 Aug 2022 11:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7001B8220A;
        Wed, 31 Aug 2022 18:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D401C433D7;
        Wed, 31 Aug 2022 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969177;
        bh=+CfWjPMA0Nv5E41raf6tOMWa2RrjlQkNCsevqXDJvqo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=d5blKCGrPJYdZeCkwEQpVzc7E+rxnJFdTt2fOYPObi4ggkW+S9aHUHswrJPu4f91w
         zX13ozvAUUDjzq2GeJsyE9PodRXMtkKMHu66NFuDEG+z6yyBuQn9sZAZX8NmnqmS5u
         3/HvjO3KAIoA8ImG5WXVLcyorZxDdtRIiXXRFlivSV3bnKDOdVKKfQiEQkbuu4x6S9
         VcN/kARMCOJpNZsVuy/az97Hz9sU/DAjP9iLQ2ZC6Wk/j8wEbmEVz8Ej+cEugdRw2K
         lollWveXpjHsn8ZS2tDgm3Qb+fiEPktwbTfbHEmhEdKR1pXIfBAbj076lRDtyAvNc7
         G450gC8rtAHDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0EF1A5C015D; Wed, 31 Aug 2022 11:06:17 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:06:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] RCU documentation updates for v6.1
Message-ID: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains documentation updates:

1.	Emphasize the need for explicit RCU read-side markers.

2.	Call out queue_rcu_work() for blocking RCU callbacks.

3.	Use rcu_barrier() to rate-limit RCU callbacks.

4.	Fix list: rcu_access_pointer() is not lockdep-checked.

5.	Update rcu_access_pointer() advice in rcu_dereference.rst.

6.	SLAB_TYPESAFE_BY_RCU uses cannot rely on spinlocks.

7.	Update LWN article URLs and add 2019 article, courtesy of
	Shao-Tse Hung.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/checklist.rst         |    6 ++++-
 Documentation/RCU/whatisRCU.rst         |   35 +++++++++++++++++++-------------
 b/Documentation/RCU/checklist.rst       |    9 ++++++--
 b/Documentation/RCU/rcu_dereference.rst |   14 +++++++++---
 b/Documentation/RCU/whatisRCU.rst       |   12 ++++++++--
 5 files changed, 52 insertions(+), 24 deletions(-)
