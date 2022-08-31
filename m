Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5285A8507
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiHaSIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiHaSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09295E396C;
        Wed, 31 Aug 2022 11:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98B2DB82012;
        Wed, 31 Aug 2022 18:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443AAC4347C;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=VSLfzxIxzjNIGO2+Wdg4oAuIvSgu0DsDoavaH3Q4Te4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ms2NOJdXRA75zhlq+5y+vkC2qiJDRLx4i6jvKaigRKsqTdjH+Spxh6EZjsthBrHC3
         SMFMeHSBDMkvA1FvD/fjrAzO81MFv+NGEYzsJgbPfWurOewIvU2PG+kSCyLHCZ2Ec9
         OSbdcCz3jH28BheGzxAPp/3EP4ERKU7NM07WSvEnZXWqgrxWfCmB19rg+WoN8R+fpP
         ZV/TPUPAXL/ZKyMiXJLZz8uYyjLJhAsXEjNkRamn1cCpzLliHjsGpL3nYfB0r5fexS
         aaf16vAqsKXxzNSNWfPj9IymKt4WRWskQRikj5VEy4G9y7BaY+p4RLcSq5MxBZqTk2
         ryvVYG/9RnWRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F2A6D5C06A7; Wed, 31 Aug 2022 11:08:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 05/10] rcu: Document reason for rcu_all_qs() call to preempt_disable()
Date:   Wed, 31 Aug 2022 11:08:00 -0700
Message-Id: <20220831180805.2693546-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
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

Given that rcu_all_qs() is in non-preemptible kernels, why on earth should
it invoke preempt_disable()?  This commit adds the reason, which is to
work nicely with debugging enabled in CONFIG_PREEMPT_COUNT=y kernels.

Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4152816dd29f6..c46b3c74dad1f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -870,7 +870,7 @@ void rcu_all_qs(void)
 
 	if (!raw_cpu_read(rcu_data.rcu_urgent_qs))
 		return;
-	preempt_disable();
+	preempt_disable();  // For CONFIG_PREEMPT_COUNT=y kernels
 	/* Load rcu_urgent_qs before other flags. */
 	if (!smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		preempt_enable();
-- 
2.31.1.189.g2e36527f23

