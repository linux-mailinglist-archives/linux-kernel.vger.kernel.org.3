Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027CC50607F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiDSAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiDSAGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590323158;
        Mon, 18 Apr 2022 17:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18B93612CF;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C379C385B9;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=g34Kr64bP04pVIhScsqxQ1L3lPX5LIieDgKQrcvhsG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQrwVQdTyviGb8h+us4HSkrVKTnEVhx8x/MCZStonKhk23aEBRyAiz1EhRvAw/5Gt
         6PtwfgJCti971cuCVhl7BP8OLOesQiI50Xw6SvlqKftQFJdNHdskdMc1+P8du12JFy
         gx6+mWLSmfxEgeGf//T9+8YdHLTRSna3EIvvBcoFB2OCuhsu6ysx+c8ZgNLbaRtf7B
         /Ha+BwFkudpw1LOeXX26MrDYFAflxe7dMLZwSN06A2+pC6M1LMK1XMLBAysED2qviu
         qhkwKtEcuRS5DyZNzcYp3vWW2+DyDqALMRKMKHcXqdJrTjBsNAiIEKVWb4BbhNEDL6
         /UMhGE606Xk0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 629A65C1369; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Alexander Aring <aahringo@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/21] srcu: Use export for srcu_struct defined by DEFINE_STATIC_SRCU()
Date:   Mon, 18 Apr 2022 17:03:13 -0700
Message-Id: <20220419000322.3948903-12-paulmck@kernel.org>
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

From: Alexander Aring <aahringo@redhat.com>

If an srcu_struct structure defined by tree SRCU's DEFINE_STATIC_SRCU()
is used by a module, sparse will give the following diagnostic:

sparse: symbol '__srcu_struct_nodes_srcu' was not declared. Should it be static?

The problem is that a within-module DEFINE_STATIC_SRCU() must define
a non-static srcu_struct because it is exported by referencing it in a
special '__section("___srcu_struct_ptrs")'.  This reference is needed
so that module load and unloading can invoke init_srcu_struct() and
cleanup_srcu_struct(), respectively.  Unfortunately, sparse is unaware of
'__section("___srcu_struct_ptrs")', resulting in the above false-positive
diagnostic.  To avoid this false positive, this commit therefore creates
a prototype of the srcu_struct with an "extern" keyword.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8501b6b45941..44e998643f48 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -131,6 +131,7 @@ struct srcu_struct {
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
+	extern struct srcu_struct * const __srcu_struct_##name;		\
 	struct srcu_struct * const __srcu_struct_##name			\
 		__section("___srcu_struct_ptrs") = &name
 #else
-- 
2.31.1.189.g2e36527f23

