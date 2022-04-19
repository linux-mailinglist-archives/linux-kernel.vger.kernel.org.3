Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB95060BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiDSAOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbiDSAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:14:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D49462C8;
        Mon, 18 Apr 2022 17:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10A75B81123;
        Tue, 19 Apr 2022 00:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FBCC385A1;
        Tue, 19 Apr 2022 00:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327083;
        bh=WXnK2gx8qkOLFox4IBN91tTQyMNyq2flQAXHiUplfPo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Lcf84TWwSBe1Mdj7xG+ct6q0aFknKeBNUc/Yvp7TED4b2oTmeg5yyLtjTQ1Z8tQJ+
         UR0MwBgix9URiyTLA2aytwKNl+L1YiYg+vZ2cwgR+6Cae2Le/DYY6HH6D/o+F+Rr3C
         zqoNCED0p0vfp6ngXB24fsxBw9pZEkTFL+nrR6tkdTFq+7a2rEh6Yw0ewrK2beXddK
         trbHCMXCNO1AHw+xReG1D2TDrL7iPzViYn1uvYyU7MmRL0jydCnPlCdD1oTTOpTxev
         EwYZNRaapcz9hh6EFXcK6/kw829n0yYK3vY38B4ku3fcFDyFjxjo07v2aUxoaSZ6F6
         kY8fNkveQN2jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 44C535C04BD; Mon, 18 Apr 2022 17:11:23 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:11:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/12] RCU-tasks torture-test updates
Message-ID: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
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

This series contains torture-tests updates for the RCU tasks flavors,
most notably ensuring that building rcutorture and friends does not
change the RCU-tasks-related Kconfig options.

1.	Make TASKS_RUDE_RCU select IRQ_WORK.

2.	Make the TASKS_RCU Kconfig option be selected.

3.	Allow rcutorture without RCU Tasks Trace.

4.	Allow rcutorture without RCU Tasks.

5.	Allow rcutorture without RCU Tasks Rude.

6.	Add CONFIG_PREEMPT_DYNAMIC=n to TASKS02 scenario.

7.	Allow specifying per-scenario stat_interval.

8.	Allow refscale without RCU Tasks.

9.	Allow refscale without RCU Tasks Rude/Trace.

10.	Allow rcuscale without RCU Tasks.

11.	Allow rcuscale without RCU Tasks Rude/Trace.

12.	Adjust for TASKS_RCU Kconfig option being selected.

						Thanx, Paul

------------------------------------------------------------------------

 b/arch/Kconfig                                                    |    1 
 b/kernel/bpf/Kconfig                                              |    1 
 b/kernel/rcu/Kconfig                                              |    1 
 b/kernel/rcu/Kconfig.debug                                        |    1 
 b/kernel/rcu/rcuscale.c                                           |   12 +
 b/kernel/rcu/rcutorture.c                                         |  101 +++++-----
 b/kernel/rcu/refscale.c                                           |   12 +
 b/kernel/trace/Kconfig                                            |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01           |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N           |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01          |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02          |    3 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02.boot     |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03          |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01          |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02          |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE09           |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh |   16 +
 b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon    |    4 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE        |    2 
 b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon    |    2 
 b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT   |    2 
 b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT        |    2 
 b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT          |    1 
 kernel/rcu/Kconfig                                                |   64 ++++--
 kernel/rcu/Kconfig.debug                                          |    8 
 kernel/rcu/rcuscale.c                                             |   12 +
 kernel/rcu/rcutorture.c                                           |   26 ++
 kernel/rcu/refscale.c                                             |   12 +
 tools/testing/selftests/rcutorture/configs/rcu/TASKS02            |    1 
 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon      |    3 
 tools/testing/selftests/rcutorture/configs/refscale/CFcommon      |    2 
 32 files changed, 219 insertions(+), 85 deletions(-)
