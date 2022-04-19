Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08450609A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiDSAJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbiDSAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094D55FAE;
        Mon, 18 Apr 2022 17:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 933E36123D;
        Tue, 19 Apr 2022 00:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048F3C385A1;
        Tue, 19 Apr 2022 00:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326742;
        bh=80RmKPO7qR7Jhi+2GHCJ3qCRjzWLY69Zf9hVz16E/jY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=U3UXeJD0ksm5YuJZfMrI18wsAuoUBj7eFZlqdceIysliJ2yo7M0FcMq3T9N5R1ZOx
         x19PbPwuWX3GgX62QMUGY548JhxbhSWlf50ESLqgw+mJpYDVPwBYrkt//GUJ4ZxuJK
         JGOt4XLXCcSCQGPNBfAJZVmnh0eCgOCvsR2WVvtyB0CdCAAKl/ZzPoMaKl1m3yzxRE
         EbG/TOvx+fKECEQxgDz9JTRG7DVsIm4CdXAswRqaj4xdwzsuCE04Z+p96hbl7AXJRk
         nXRce+1vyGlMWGzaMWOzQ0pIvZPGECwFGfo7/C5UK00M/SgvUI7+AMuqAN31nfRuZN
         u78KAWtntMJ4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A540B5C04BD; Mon, 18 Apr 2022 17:05:41 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:05:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/6] Torture-test updates for v5.19
Message-ID: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
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

This series contains torture-test updates fixing some bugs in tests and
closing some testing holes.

1.	Add rcu_normal and rcu_expedited runs to torture.sh.

2.	Suppress debugging grace period delays during flooding.

3.	Fix distribution of short handler delays.

4.	Avoid corner-case #DE with nsynctypes check, courtesy of David
	Vernet.

5.	Add missing return and use __func__ in warning, courtesy of
	David Vernet.

6.	Call preempt_schedule() through static call/key, courtesy of
	Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/torture.h                           |    2 -
 b/kernel/rcu/rcu.h                                  |    4 ++
 b/kernel/rcu/rcutorture.c                           |    4 ++
 b/kernel/rcu/tree.c                                 |   32 ++++++++++++++++++--
 b/kernel/scftorture.c                               |    5 +--
 b/tools/testing/selftests/rcutorture/bin/torture.sh |   18 +++++++++++
 kernel/rcu/rcutorture.c                             |   14 ++++++++
 7 files changed, 72 insertions(+), 7 deletions(-)
