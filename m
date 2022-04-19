Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73041506085
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiDSAG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiDSAGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9AF13F97;
        Mon, 18 Apr 2022 17:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0A6AB81128;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09EDC385A8;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326604;
        bh=y1siE5tC9sWo5al2WNPETNUZe9pTnoQcxs2YYb0TG44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYMb70gCftj/SsILItuVHxmEewLDfc6FeqyqAXtBKC8MvCtkwglw+Xzurk3oZs7nn
         fKDQnG4PFKzHayisRHaTsqF6f82yllXla7fY5TkFtSkHwQu+6M88eaLQYU8mvhWwbf
         WOULLvIe7At2sgO3iUWvK8+8BXh7FFK0DRa9ojlZzhT5M2Zysp0zDFRqtCPcpyvZtY
         f0mybrPKp1Qhg8IR13wfTSjg+0VE6JdJCqRQWosQBPRVKn4xJAYkPNiDgZ5ChJyNSb
         YxC/y31NghQpOFfLyLIlShOuDDc0jI8GHPeXvjSAwoVX/Ker43nvNMlGxvFsryp8+T
         WEFwz+B9mm3Vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D08B5C04BD; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/21] srcu: Tighten cleanup_srcu_struct() GP checks
Date:   Mon, 18 Apr 2022 17:03:02 -0700
Message-Id: <20220419000322.3948903-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, cleanup_srcu_struct() checks for a grace period in progress,
but it does not check for a grace period that has not yet started but
which might start at any time.  Such a situation could result in a
use-after-free bug, so this commit adds a check for a grace period that
is needed but not yet started to cleanup_srcu_struct().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6833d8887181..d30e4db04506 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -382,9 +382,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
+	    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
-		pr_info("%s: Active srcu_struct %p state: %d\n",
-			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)));
+		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
+			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
+			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
 	free_percpu(ssp->sda);
-- 
2.31.1.189.g2e36527f23

