Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E35060DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiDSAWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbiDSAWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4631E3DF;
        Mon, 18 Apr 2022 17:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4281C61338;
        Tue, 19 Apr 2022 00:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B44C385A7;
        Tue, 19 Apr 2022 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327608;
        bh=z//3Vy2NpmqTGnANl1UOd6oMhW0y0wQ+i/XCzxBpBBY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Pr1VldJoJjNIug9gb63f2FOjQh5vG3cQV/7YhXawq3nCTCWyRfYPu2PWzidJI/UUY
         NGE5gxuZ4d0F3CkPl2KrcFLr7VVaqtPfEny61ku7qj8A0CtV0qwvnfgFrexTpPMDIn
         gMvLxGKPk6y7TDSy9Hi7Lxo9gKASc0KE1Mio6zLOApy+voAKioRHQ5CX8jZBVS/2bw
         mjD7RRSAEwZCdhsv3zpRxpwWd+2YWjX9vZTucVNM8Ug6gSH7SMWPz1armAF9EcJZyV
         MMac1EnTlcER71TJsTIU1TXKJyD4eIOMwoIjr3+juQKyjtkaHimsIFmYdBMrOPzdQM
         LyS7j9db834XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D8095C04BD; Mon, 18 Apr 2022 17:20:08 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:20:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/2] Expedited grace-period updates for v5.19
Message-ID: <20220419002008.GA3950677@paulmck-ThinkPad-P17-Gen-1>
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

This series contains updates to RCU expedited grace periods, most
notably providing milliseconds-scale soft real-time response from
synchronize_rcu_expedited().  This is also the first time in almost
30 years of RCU that someone other than me has pushed for a reduction
in the RCU CPU stall-warning timeout, in this case by more than three
orders of magnitude from 21 seconds to 20 milliseconds.  This tighter
timeout applies only to expedited grace periods.

1.	Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, courtesy of Uladzislau
	Rezki.

2.	Move expedited grace period (GP) work to RT kthread_worker,
	courtesy of Kalesh Singh.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/stallwarn.rst                 |   18 ++
 b/Documentation/admin-guide/kernel-parameters.txt |    9 +
 b/kernel/rcu/Kconfig                              |   14 ++
 b/kernel/rcu/Kconfig.debug                        |   13 +
 b/kernel/rcu/rcu.h                                |    2 
 b/kernel/rcu/tree.c                               |   51 +++++++
 b/kernel/rcu/tree.h                               |    5 
 b/kernel/rcu/tree_exp.h                           |    4 
 b/kernel/rcu/tree_stall.h                         |   26 +++
 b/kernel/rcu/update.c                             |    2 
 kernel/rcu/rcu.h                                  |    5 
 kernel/rcu/tree_exp.h                             |  147 +++++++++++++++++-----
 12 files changed, 260 insertions(+), 36 deletions(-)
