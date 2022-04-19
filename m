Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0B506076
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiDSAF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiDSAF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342171FA7E;
        Mon, 18 Apr 2022 17:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F3B61297;
        Tue, 19 Apr 2022 00:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEA6C385A7;
        Tue, 19 Apr 2022 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326596;
        bh=CnkqtBA7WJbomLfpEDYYQQ8kyFha02flhX/Blp9xB5c=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=uUY5JHD8glEOtS8i3oy1AnkG6882Iw5V3BQ2Ks3VZ5Y1lEzdORhv7l3U8KJoy9SoW
         p2qFAiysxYYocpp4Q7TcdorK44FiTf9GsbAL7IqAKmF9BfvB0/x3UwJ3xJhv0vyzNV
         1bJAbpIr43JTE5zs0RLYyAGWqMw5HWm5WlDmTnJAfWcUv949869Erx+Zgrt69gTQJ+
         /2GPGu88D18NkK4q9gwijiXryjtGyZqQtg3ZKKDB5BrJVWeBt3cT99IC3xYYq1I8Qe
         u0pXoBE5uGEzbKADUoxmgTXsbgh909qSF6K30oZLH0QUIbABzX7/+tjdLh+vAwbAdS
         ybfddxdF9B77A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC7F15C04BD; Mon, 18 Apr 2022 17:03:15 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:03:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/21] SRCU updates for v5.19
Message-ID: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

This series contains SRCU updates, primarily reducing the srcu_struct
structure's infamous memory footprint.

1.	Tighten cleanup_srcu_struct() GP checks.

2.	Fix s/is/if/ typo in srcu_node comment.

3.	Make srcu_funnel_gp_start() cache ->mynode in snp_leaf.

4.	Make Tree SRCU able to operate without snp_node array.

5.	Dynamically allocate srcu_node array.

6.	Add size-state transitioning code.

7.	Make rcutorture dump the SRCU size state.

8.	Compute snp_seq earlier in srcu_funnel_gp_start().

9.	Use invalid initial value for srcu_node GP sequence numbers.

10.	Ensure snp nodes tree is fully initialized before traversal,
	courtesy of Neeraj Upadhyay.

11.	Add boot-time control over srcu_node array allocation.

12.	Use export for srcu_struct defined by DEFINE_STATIC_SRCU(),
	courtesy of Alexander Aring.

13.	Avoid NULL dereference in srcu_torture_stats_print().

14.	Prevent cleanup_srcu_struct() from freeing non-dynamic ->sda.

15.	Explain srcu_funnel_gp_start() call to list_add() is safe.

16.	Create concurrency-safe helper for initiating size transition.

17.	Add contention-triggered addition of srcu_node tree.

18.	Automatically determine size-transition strategy at boot.

19.	Add contention check to call_srcu() srcu_data ->lock acquisition.

20.	Prevent expedited GPs and blocking readers from consuming CPU.

21.	Drop needless initialization of sdp in srcu_gp_start(), courtesy
	of Lukas Bulwahn.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |   18 
 b/Documentation/admin-guide/kernel-parameters.txt |   13 
 b/include/linux/srcutree.h                        |    8 
 b/kernel/rcu/srcutree.c                           |    6 
 include/linux/srcutree.h                          |   24 
 kernel/rcu/srcutree.c                             |  751 +++++++++++++++-------
 6 files changed, 587 insertions(+), 233 deletions(-)
