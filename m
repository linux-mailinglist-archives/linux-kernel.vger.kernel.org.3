Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B614DB388
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiCPOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356572AbiCPOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D421E12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E17E61585
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D839C340E9;
        Wed, 16 Mar 2022 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647441780;
        bh=o0roD4ZBsEokwd+y6YJx5uI4mHLLQzXII32jM5J1HYU=;
        h=From:To:Cc:Subject:Date:From;
        b=A7p0hbPuGpnnb71a109WPF0UxXxtJjd75KJK525l/NOK2AtkW02H5akP95aYa4tmV
         aTblbI+I3KTgvHkMyvW3A7VXmS291oIfFTixKysk7qIiWmws0w/K7R77kSQbNij5O7
         n0gOmvp5ix1JUklAQKrPUawUdCaQ4Aeex53oqBaxEzBzbXQDJhwdEgr7OILBZMXxvY
         nYnUDD1HsLM+jUHd5N5OsuWtH7nyRSmieoPd+ZTBMQUsoXSCAqadRJ/jyYU5hdpfgh
         bdOMflBAQkpYdAhCllq5jW1b51FJOFp2wsRKhIcCnQdLWthgH3mWewh2M3L0Bztp2M
         2bmAplaYiGzwA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH 0/4] rcu: Expedited GP polling improvements
Date:   Wed, 16 Mar 2022 15:42:51 +0100
Message-Id: <20220316144255.336021-1-frederic@kernel.org>
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

I initially wanted to shape that into the form of reviews or questions
but I thought I might as well send patches.

Be careful, it's fairly possible I misunderstood some things and those
patches are completely off the track.

At least TREE07 looks happy.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: dd1f68246e04fe03fde46cd55f1c87ea92a6c57e

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      rcu: Remove needless polling work requeue for further waiter
      rcu: No need to reset the poll request flag before completion
      rcu: Perform early sequence fetch for polling locklessly
      rcu: Name internal polling flag


 kernel/rcu/rcu.h      |  5 +++++
 kernel/rcu/tree.c     |  2 +-
 kernel/rcu/tree_exp.h | 18 +++++++-----------
 3 files changed, 13 insertions(+), 12 deletions(-)
