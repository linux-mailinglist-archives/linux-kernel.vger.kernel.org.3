Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A47555270B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiFTWo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFTWo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957713F95;
        Mon, 20 Jun 2022 15:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F57661361;
        Mon, 20 Jun 2022 22:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFA9C3411C;
        Mon, 20 Jun 2022 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765095;
        bh=ZzEW3HE/befBeO1gRL9xk9tWJ4Oo+dEA974frfnP8kA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=XvGsuXPYBtXC0xBAKozXOPvYdbWTdQLJPvfKJSAYaaa+ylnHrZuyw/8+A7KEH05hw
         8cKNVaiQR7nP/RSpnc3yo1h0ZjeH3t+et3a5CNIsgiZ6g+qDqv8RLJFjN78uj90idz
         L+nSoO1n6So6j16yhBQjgVhbxzOgWjDEvPN67+D3hfRCe9VlbLyNx6jPpqtcjn63HS
         DQaQWnTaw72X8LxoiI2Dx2sfs6CgD/ZicFAvpmnhtTu6C3bQK/eGpGi3OhBxx6MQNy
         fjyXl0UeZe3hyi6Xu3Ndi18KzC36DR/I7z5Bxin/WHoFgxUnCECwMpfclaAVz0ZcIE
         aQsRTFkxHgPeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 43E715C05B9; Mon, 20 Jun 2022 15:44:55 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:44:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Callback-offload (nocb) updates for v5.20
Message-ID: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides NOCB-CPU updates:

1.	Add/del rdp to iterate from rcuog itself, courtesy of Frederic
	Weisbecker.

2.	Invert rcu_state.barrier_mutex VS hotplug lock locking order,
	courtesy of Zqiang.

3.	Fix NOCB kthreads spawn failure with rcu_nocb_rdp_deoffload()
	direct call, courtesy of Zqiang.

4.	Add an option to offload all CPUs on boot, courtesy of Joel
	Fernandes.

5.	Add nocb_cb_kthread check to rcu_is_callbacks_kthread(), courtesy
	of Zqiang.

6.	Add option to opt rcuo kthreads out of RT priority, courtesy of
	"Uladzislau Rezki (Sony)".

7.	Avoid polling when my_rdp->nocb_head_rdp list is empty, courtesy
	of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    6 
 b/kernel/rcu/Kconfig                              |   13 ++
 b/kernel/rcu/tree.c                               |    4 
 b/kernel/rcu/tree.h                               |    1 
 b/kernel/rcu/tree_nocb.h                          |  138 +++++++++++-----------
 b/kernel/rcu/tree_plugin.h                        |   33 +++--
 kernel/rcu/Kconfig                                |   16 ++
 kernel/rcu/tree.c                                 |    6 
 kernel/rcu/tree.h                                 |    2 
 kernel/rcu/tree_nocb.h                            |  130 ++++++++++++++++----
 10 files changed, 236 insertions(+), 113 deletions(-)
