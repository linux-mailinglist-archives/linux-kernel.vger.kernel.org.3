Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6F55272E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbiFTWvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbiFTWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C81C11F;
        Mon, 20 Jun 2022 15:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A9B6613E9;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF0AC341D4;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=5nXnXcn/7Cx6CdVUvIae4nmvKh4NJIrq5+suCvH1FbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyQXt5lAylGn56kqrTCmdHYoQ7V8v+ipu+nYtrYZx1ATKPSE7xo89KzFc4SaQGMkY
         HLY8/AAQrjueBViIapyuIe/tPAqLoEU/9fFvC+D0PYHroHUaMyttSCRrk+O13VPNt4
         iNnrQdsBqLbM9woVUGwpag4wBBzkcfxEivqfCpgKV1N3zB4Q3ohqafOEqHN43Js/Uk
         WvirNSSh4jFf52JZKDht+dQvdAg56tfVezPyX/RJinByg0vEXjnXGG9MfluVgskZhJ
         XCQHAfTuYr4ea61/dIHbMaP2vbIOGu10tohvBG7VMHjPWF8LkkkQyMc6W1KXThKFIK
         0qXjxe6NHbSkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A55E35C0DAC; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/12] rcu: Put panic_on_rcu_stall() after expedited RCU CPU stall warnings
Date:   Mon, 20 Jun 2022 15:51:26 -0700
Message-Id: <20220620225128.3842050-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
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

From: Zqiang <qiang1.zhang@intel.com>

When a normal RCU CPU stall warning is encountered with the
panic_on_rcu_stall sysfs variable is set, the system panics only after
the stall warning is printed.  But when an expedited RCU CPU stall
warning is encountered with the panic_on_rcu_stall sysfs variable is
set, the system panics first, thus never printing the stall warning.
This commit therefore brings the expedited stall warning into line with
the normal stall warning by printing first and panicking afterwards.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 571b0a700cced..f05a15b11fa0c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -623,7 +623,6 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
-		panic_on_rcu_stall();
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
@@ -671,6 +670,7 @@ static void synchronize_rcu_expedited_wait(void)
 			}
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+		panic_on_rcu_stall();
 	}
 }
 
-- 
2.31.1.189.g2e36527f23

