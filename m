Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF71506086
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiDSAGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiDSAGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB723159;
        Mon, 18 Apr 2022 17:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01DC4B81141;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE32C385A9;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326604;
        bh=R6yVW5CkBqUs8J0Ergawy2eOvj41C2+kBPhfDbE3hE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkMpzHDdAA+7YDs/T/Qxc2I6UxKpodNNxSXtwLiIghxU/AIQrR6Ze9HLlBI6ZMGpN
         7Pi/SGf6aW8KJi9DpDx9eKBTF5RcI10YRi6n3J2kN/POvrGCAoc8wfrmXjyHsim35f
         arDWx/p8lH5AHDSxInfBRZd2g0JzTNASDDHJpObN7SuWKNAfHrqFn1M/jRuVFVVWhA
         XoDGYveepKAbeqiP884rkT2mfNmYwIK7fxz/gqft3CDMZMAlsECJucBriFGmv/RBuh
         /chylE04iSy1qjvXA/4+vCzGARUCsrosKip7Hc0GUAzsUR1ZJD3dF/ypfjRWkH4Kmd
         M2mvH3AXXSaTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 501265C04C6; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/21] srcu: Fix s/is/if/ typo in srcu_node comment
Date:   Mon, 18 Apr 2022 17:03:03 -0700
Message-Id: <20220419000322.3948903-2-paulmck@kernel.org>
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

This commit fixed a typo in the srcu_node structure's ->srcu_have_cbs
comment.  While in the area, redo a couple of comments to take advantage
of 100-character line lengths.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index cb1f4351e8ba..4025840ba9a3 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -47,11 +47,9 @@ struct srcu_data {
  */
 struct srcu_node {
 	spinlock_t __private lock;
-	unsigned long srcu_have_cbs[4];		/* GP seq for children */
-						/*  having CBs, but only */
-						/*  is > ->srcu_gq_seq. */
-	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs */
-						/*  have CBs for given GP? */
+	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
+						/*  if greater than ->srcu_gq_seq. */
+	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	struct srcu_node *srcu_parent;		/* Next up in tree. */
 	int grplo;				/* Least CPU for node. */
-- 
2.31.1.189.g2e36527f23

