Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E94DB38B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356836AbiCPOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356572AbiCPOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE85FF9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D3D561583
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49447C340F1;
        Wed, 16 Mar 2022 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647441784;
        bh=lHeihKp98S9nAlrutKy8Jq1rETYQC/dxIy6QH3t9vAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2szZO8x3DJqWy2wda/Vbq6jPT3EaU6raecAs28R0PCkU6cFabavYkx1Xpw9fxc1v
         Q4M7qJDzdIwZUP94V8HzUdYENuyZZoOcYo6c8jejCV7QNgYvcw1SMAbbGf5zbxon0+
         ydPeRkiMXOaQ0VjjwDAHYS3WdO3VGE9gUzuMX2ucPJ607JnaMHSDNnKyxiFC3QIS1J
         bNXRxZeMo9s6VbffV+GtjjBJmMUf87yWbR1wJZHpV/FAeyhq5MWeCEUZtyziw1vmAG
         +tN85AFFV2GXYPYu/I2OMex4k4k33ycpbaNo76kMvB7kq3BXqtJcvTH6hqrp/1pcxf
         KCzpv/Qfo2yrw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/4] rcu: No need to reset the poll request flag before completion
Date:   Wed, 16 Mar 2022 15:42:53 +0100
Message-Id: <20220316144255.336021-3-frederic@kernel.org>
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

The flag allowing to requeue the polling work is reset before the
polling even starts. However there is no point in having two competing
polling on the same grace period. Just reset the flag once we have
completed the grace period only.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index b6fd857f34ba..763ec35546ed 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -911,7 +911,6 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
 
 	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	s = rnp->exp_seq_poll_rq;
-	rnp->exp_seq_poll_rq |= 0x1;
 	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
 	if (s & 0x1)
 		return;
-- 
2.25.1

