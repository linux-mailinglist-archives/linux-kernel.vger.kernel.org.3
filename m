Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C25A8556
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiHaSRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiHaSRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FDAEC4C1;
        Wed, 31 Aug 2022 11:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E6861C4F;
        Wed, 31 Aug 2022 18:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98617C433C1;
        Wed, 31 Aug 2022 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969629;
        bh=L7TRejKFwJZQ3r4eqXUKz8DxNFpD4zUaV37kHBH0mU0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=EaImZNYubv5UWdPa7NTmJRCaDMNmynv1YaDvkt3J+8e0elQfDH9zv0DRTGGCK9ctR
         CcfzVIsYkBUvw6djN7r7kyxkt0RgWtTY+BiOqGqkPtWj4qaD0As76WjvbJBPYX1uEh
         NDZAzuqfxG2qxxTJgb0gzfylyX/2RAEenLh1MN/xwe0AUzj2+evvomnAFjiOFo6LQH
         goeyZF0I5lLjCowUXUoxeUA3w/pMKHXFduDZsy5L/IOk2tLD15aE4ytdHlV1r2vT3W
         jgOA5CyerGSfNqT3lhMcjN/rP7Gl8JEaTb0/1GJe/h62PdnUmKUfEXEkZCDtIWLtk4
         q3CWn79MyDv/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 439B25C015D; Wed, 31 Aug 2022 11:13:49 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:13:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] SRCU polled grace-period updates for v6.1
Message-ID: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
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

This series provides updates for polled SRCU grace periods, mainly for
Tiny SRCU:

1.	Make "srcud" option also test polled grace-period API.

2.	Add GP and maximum requested GP to Tiny SRCU rcutorture output.

3.	Make Tiny SRCU poll_state_synchronize_srcu() more precise.

4.	Make Tiny SRCU use full-sized grace-period counters.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcutiny.h |    6 ++++--
 b/kernel/rcu/rcutorture.c  |    3 +++
 b/kernel/rcu/srcutiny.c    |    4 ++--
 include/linux/srcutiny.h   |    6 +++---
 kernel/rcu/srcutiny.c      |   14 +++++++-------
 5 files changed, 19 insertions(+), 14 deletions(-)
