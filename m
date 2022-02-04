Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BF54AA4A4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378411AbiBDXxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378388AbiBDXx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F2C104923;
        Fri,  4 Feb 2022 15:53:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEAE861CB0;
        Fri,  4 Feb 2022 23:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE2CC004E1;
        Fri,  4 Feb 2022 23:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018802;
        bh=XfmKRHLTLryQMNUezoJ9clX2FfTd/ChaZpko8a+g9jE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=fmXwwLFC8ketbM8aX+Nwx8dvKuyLy/5L1xWXHLZAF9aSBQXPg34RKlRyk6UAXcMD+
         Wpp+HanQhNZdL7xCDF8fnDGU3d4gI4EEGJ9FlLVYJuHXXgomseO0qz9dicbJR2Q1fH
         VsIOPORMc/Dl5gHrPx6e+KqrDd5wtPGjLIbC83DmhOh7z6kl9YmXsTMW20CeTdMcto
         VumiJqIhcpaFrx2a8b8tMDNtgnAuW18SN1Ukux1h76sQSIf3dtKkAt15iuMIiCBlHw
         M1v+IdyrOj9V7S6kcVW0b7xEkCU871z3nROpapLX1Zowe8jS6mQh0WwwZ7Asopa15h
         cP/tbageDlL2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CCF045C0418; Fri,  4 Feb 2022 15:53:21 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:53:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/8] Torture-test updates for v5.18
Message-ID: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
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

This series provides torture-test updates.

1.	Print message before invoking ->cb_barrier().

2.	Distinguish kthread stopping and being asked to stop.

3.	Increase visibility of forward-progress hangs.

4.	Make rcu_fwd_cb_nodelay be a counter.

5.	Add end-of-test check to rcu_torture_fwd_prog() loop.

6.	Fix rcu_fwd_mutex deadlock.

7.	Wake up kthreads after storing task_struct pointer.

8.	Enable limited callback-flooding tests of SRCU.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c |    8 ++++++--
 b/kernel/torture.c        |    2 +-
 kernel/rcu/rcutorture.c   |   26 ++++++++++++++++----------
 kernel/torture.c          |    4 +++-
 4 files changed, 26 insertions(+), 14 deletions(-)
