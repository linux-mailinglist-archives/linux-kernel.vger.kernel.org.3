Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A694AA47A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378319AbiBDXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47886 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378233AbiBDXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51AB261CAC;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BA7C340FB;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=mqSCacukpi9DpKBNP6/4XacTjUfOTHmgmq5c2Vhl5ZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBmISx4QN//uuEdE2VRV5qNtIRRsOl3IlYaNRvJs1cxaJkRfLBlr/4TvnHTxHxu89
         O+fKSxbW2cmNpCg2irPWVfgMOwgwhwzSVzNXF4BJ1KlZ9TswEAfqAAmKSmLjYLdRDM
         HDjh+gf7S8oADOw0MZEYePQn5ExQPOGdocKzjfY2AutOlXNfsAjZStwpVCpmHs1aKh
         Gtgi5wySQCAkxu2jPF1p/Mj4L8Wn8KApm1NrMICOoSSWxisMl+ZhOuWl6uIFUQ8O8d
         Mzc+ZkWK6OlrztM1PJJ0vTwJuhWZ/l1p5MDxvzysWNBMEp0QtMb66MkGC+efyad1c/
         yA5qZCa4m4n5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 032305C0AEF; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Alexander Aring <aahringo@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/19] srcu: Use export for srcu_struct defined by DEFINE_STATIC_SRCU()
Date:   Fri,  4 Feb 2022 15:38:52 -0800
Message-Id: <20220204233902.1902-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 8501b6b459411..44e998643f483 100644
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

