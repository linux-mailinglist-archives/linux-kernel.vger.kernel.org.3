Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955725A855F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiHaSUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiHaSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D3F47D6;
        Wed, 31 Aug 2022 11:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B153E61C81;
        Wed, 31 Aug 2022 18:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4159C433C1;
        Wed, 31 Aug 2022 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969677;
        bh=ECPhDnSbN1XcKN9Q0Qw11HM6nYqQWLTqOmnBbwnm2wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlqlE+gN3jlWxLyOau1CN8cJrP5tJvc+9SmxgKJ0WAItUKC2Yhpgcx3MhXhGehY5s
         fWYnUzo4PdVwvDExM2J9lT5T2T0+XxiQ1ZjNiwv++pwiNY/qJMkObovwv0fTD6d/qa
         tu2gwIWw2oUZC/X4EZiAMej13JYgoyTnw1HADQniqM5KLC8XbsHdL7CoDSziSxiKmC
         F1EV41PUW/aR+YyNPvI/14ETpspWNFi0gemr7Lw59TLNKu6QpxD9kHe16Vxz2GHrPl
         PsOblV5EDXXbsiCRz5cOoUJ3+Dzg8yCUtuBi5qF/DFpc7YkPSlzPxM6IO2OSwYs2vs
         aku6TfXCgN5oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 769AC5C019C; Wed, 31 Aug 2022 11:14:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/4] srcu: Add GP and maximum requested GP to Tiny SRCU rcutorture output
Date:   Wed, 31 Aug 2022 11:14:33 -0700
Message-Id: <20220831181435.2695936-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181349.GA2695341@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the ->srcu_idx and ->srcu_max_idx fields to the Tiny
SRCU rcutorture output for additional diagnostics.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 6cfaa0a9a9b96..4fcec6f5af908 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -82,10 +82,12 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 	int idx;
 
 	idx = ((data_race(READ_ONCE(ssp->srcu_idx)) + 1) & 0x2) >> 1;
-	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd)\n",
+	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd) gp: %hu->%hu\n",
 		 tt, tf, idx,
 		 data_race(READ_ONCE(ssp->srcu_lock_nesting[!idx])),
-		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])));
+		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])),
+		 data_race(READ_ONCE(ssp->srcu_idx)),
+		 data_race(READ_ONCE(ssp->srcu_idx_max)));
 }
 
 #endif
-- 
2.31.1.189.g2e36527f23

