Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56F4DB389
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356814AbiCPOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349287AbiCPOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:44:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035321E12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0B16157E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439B7C340F0;
        Wed, 16 Mar 2022 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647441782;
        bh=Btxl5/3u4gskbSG4b4/bNPaMjoqQkhs9Zqi5gM6zYuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7L6ywOzJGQ2utyWu78gOXP+PxjR/PLmPS90laso5pyGHal9pMDd13p5qdC6LoQ2h
         q9B3FOVK2bTW1zoFOvRM/TRE0Ysw1B55RsYek8FgHzviftqmZZwpPvX1JamBsiBK01
         sk50SEEKPX9IAgqvwcariiobAf0LVVbdB/8qso0YiZ/X5Cr7/A2HjIo7rkHyR+0fZo
         65bRkAYATjY9upSLZrWbPrcMUdt0fXVktswB9C5MDE1rLD5GoCjN/RKSCJ8x1P8s7U
         hgAuSstLvXO94sLozcxaf7vVRna5wEFF/pn1Dy1b60lkMko1tXKrq0wa0Y27Ta1gNJ
         7qNPPjn3QgHsw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/4] rcu: Remove needless polling work requeue for further waiter
Date:   Wed, 16 Mar 2022 15:42:52 +0100
Message-Id: <20220316144255.336021-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316144255.336021-1-frederic@kernel.org>
References: <20220316144255.336021-1-frederic@kernel.org>
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

If another expedited polling site is waiting for the next grace period,
there is no need to requeue the work because it is guaranteed to be
either already queued or executing the actual polling upon completion.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a6cb02a4d27c..b6fd857f34ba 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -919,9 +919,7 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
 		__synchronize_rcu_expedited(true);
 	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	s = rnp->exp_seq_poll_rq;
-	if (!(s & 0x1) && !sync_exp_work_done(s))
-		queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
-	else
+	if (!(s & 0x1) && sync_exp_work_done(s))
 		rnp->exp_seq_poll_rq |= 0x1;
 	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
 }
-- 
2.25.1

