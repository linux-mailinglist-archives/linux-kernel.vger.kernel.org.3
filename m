Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3934D8613
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbiCNNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiCNNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD152AFD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D65F261188
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364F2C340EC;
        Mon, 14 Mar 2022 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647265073;
        bh=Xewr86FT1fxMXD/lR5Uk6hSR4R6PnTnxz6+DRYq4q9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=DztILwG16Y+xQGFHYcMh6Dd47J05+4UC61DIPOHiT+8V/xB0cVScURQGIXu5qxhe7
         beOMtD160iKkmUG7T3mGHWCCqkommUH7y6zRdL1GpvcUMt6SlZT6cnjmTZjHB2Zdc4
         Or1sgZKCxDVQuL0qC2HtPUwOZLu+ymfmN7lrXtnrPjdKqmEGtgHiHNCL6XqBGchDhM
         PZtd+x7cypyW/o4rgjF0apr1A8KO5L70R+Ytbpg7ydc/wUIqCkQ90Boahl9QM8E0el
         Z8L9SKrEWLf5HB3o6JGA3/F4anDXtf+fHf8HyEYSuuoaiyTnhOtN791aJNOe3IprkO
         nE/rL8zJl0sCQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/3] rcu: synchronize_rcu[_expedited]() related fixes
Date:   Mon, 14 Mar 2022 14:37:35 +0100
Message-Id: <20220314133738.269522-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A few fixes especially for expedited GP polling causing a stall on TREE07,
as reported by Paul.

We may still want to optimize start_poll_synchronize_rcu_expedited() on
UP-no-preempt but I think Paul may be implying this while doing other
fixes.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 6e5fd7e614fd5c8f0fffeaa140b7ea697bfeb096

Thanks,
	Frederic
---

Frederic Weisbecker (2):
      rcu: Fix expedited GP polling against UP/no-preempt environment
      rcu: Fix preemption mode check on synchronize_rcu[_expedited]()

Valentin Schneider (1):
      preempt/dynamic: Introduce preempt mode accessors


 include/linux/sched.h | 16 +++++++++++++++
 kernel/rcu/tree.c     |  2 +-
 kernel/rcu/tree_exp.h | 57 +++++++++++++++++++++++++++++++--------------------
 kernel/sched/core.c   | 11 ++++++++++
 4 files changed, 63 insertions(+), 23 deletions(-)
