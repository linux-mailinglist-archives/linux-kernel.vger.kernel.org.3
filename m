Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5651A4AA46F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378228AbiBDXjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiBDXjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203DCE025B1E;
        Fri,  4 Feb 2022 15:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD7DAB838EB;
        Fri,  4 Feb 2022 23:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E6CC004E1;
        Fri,  4 Feb 2022 23:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017938;
        bh=+HaRJ6tKdg7Lo/ikTwIrxa09KYNzLZvPNomKsueEx/w=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=OyY7iix577ACnhoT8F+cVw5/arCXHBWY85X949Aj3o71eZL7nIgXV5IqFwmgKhuJm
         F9cgDi06fRVbjmBixRKGaRQitUJFeZP0/FL8tKvm//JvOgFzMS8wMHnz+4pRQlYwoK
         Yt28pwG4Y7FX5qiblfjvOATcL1SYPS5+wDQerHHvqrrbLy5aSvOvahibJ1CR4jPXwY
         1JOzw9Yl8jSBKjYNCO4mSFv8kPvt1U0n6QUsn5sltG+zE1/uG8xhSBx15Qo4wcC+qy
         JkMM3BLZuP1f3kfVWPM/82MxnUjWPvUPy9H9diWBw82+QxflsmQ3jZwLpdEgxy9+e4
         ezKgrbxiviTfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 277FB5C0418; Fri,  4 Feb 2022 15:38:58 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:38:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/19] SRCU updates for v5.18
Message-ID: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides SRCU updates, perhaps most notably some changes
that greatly reduce the size of the srcu_struct structure in kernels
built with large values for the CONFIG_NR_CPUS Kconfig option.

1.	Tighten cleanup_srcu_struct() GP checks.

2.	Fix s/is/if/ typo in srcu_node comment.

3.	Make srcu_funnel_gp_start() cache ->mynode in snp_leaf.

4.	Dynamically allocate srcu_node array.

5.	Make Tree SRCU able to operate without snp_node array.

6.	Add size-state transitioning code.

7.	Make rcutorture dump the SRCU size state.

8.	Add boot-time control over srcu_node array allocation.

9.	Use export for srcu_struct defined by DEFINE_STATIC_SRCU(),
	courtesy of Alexander Aring.

10.	Compute snp_seq earlier in srcu_funnel_gp_start().

11.	Use invalid initial value for srcu_node GP sequence numbers.

12.	Avoid NULL dereference in srcu_torture_stats_print().

13.	Prevent cleanup_srcu_struct() from freeing non-dynamic ->sda.

14.	Explain srcu_funnel_gp_start() call to list_add() is safe.

15.	Create concurrency-safe helper for initiating size transition.

16.	Add contention-triggered addition of srcu_node tree.

17.	Make srcu_size_state_name static, courtesy of Jiapeng Chong.

18.	Automatically determine size-transition strategy at boot.

19.	Add contention check to call_srcu() srcu_data ->lock acquisition.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    9 
 b/Documentation/admin-guide/kernel-parameters.txt |   22 
 b/include/linux/srcutree.h                        |    8 
 b/kernel/rcu/srcutree.c                           |    6 
 include/linux/srcutree.h                          |   20 
 kernel/rcu/srcutree.c                             |  644 +++++++++++++++-------
 6 files changed, 500 insertions(+), 209 deletions(-)
