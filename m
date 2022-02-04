Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE24AA407
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377964AbiBDXId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiBDXIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B469FDF99CE8;
        Fri,  4 Feb 2022 15:08:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A5561BBB;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39906C340FA;
        Fri,  4 Feb 2022 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016087;
        bh=qsBtBAeY/gtg63/z/Rr+5Yet5jpG77AmKZjY5rm9uxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbjNU04Akt+g/rq/voKRWHq7twSiZMlDEb2jea7U00UleobVCXNurpdX2oL5LGNWn
         b5owZ3tf5IICDfeWjILkN3OgIfOgutTKlfz8hV4LRIX1JnMVGnKLV5EV8rbdNxJdhj
         gxPbrC/CakS+3nCbUjnYv5tuDnZBZiP1oBgjcdd7kymx/CD15qU5ilzqFGYNx+224e
         6p4+IS10oVataMtjqwdK/BuSIpc6zL8SvTIwkNhTldx3URTetr/Bg+xzQgxR9HILGD
         bwM6uqEcdlICdgv52Wj7DaJw4csP0NW2ymobfrVLkcucSNqNanfGapuIJB47x+UmPW
         MVKe1hJJsB0QA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A41635C0A6A; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/9] rcu: Remove __read_mostly annotations from rcu_scheduler_active externs
Date:   Fri,  4 Feb 2022 15:08:04 -0800
Message-Id: <20220204230805.4193767-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Remove the __read_mostly attributes from the rcu_scheduler_active
extern declarations, because these attributes are ignored for
prototypes and we'd have to include the full <linux/cache.h> header
to gain this functionally pointless attribute defined.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 include/linux/rcutree.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9d7df8d36af07..e7c39c200e2b0 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -84,7 +84,7 @@ static inline int rcu_preempt_depth(void)
 
 /* Internal to kernel */
 void rcu_init(void);
-extern int rcu_scheduler_active __read_mostly;
+extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcutree_migrate_callbacks(int cpu);
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 53209d6694001..76665db179fa1 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -62,7 +62,7 @@ static inline void rcu_irq_exit_check_preempt(void) { }
 void exit_rcu(void);
 
 void rcu_scheduler_starting(void);
-extern int rcu_scheduler_active __read_mostly;
+extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-- 
2.31.1.189.g2e36527f23

