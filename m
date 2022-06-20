Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2313C5526DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244304AbiFTWSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiFTWSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:18:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAB10FCE;
        Mon, 20 Jun 2022 15:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83111B81648;
        Mon, 20 Jun 2022 22:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35772C341C5;
        Mon, 20 Jun 2022 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763479;
        bh=TnT5Hnafq9jyhnw4TzUBgKnKEH4dMuHcHnyemvZrAqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgAc8BTGyhyMrzWYbRRbvhA0BsOU9zKLGqtyj5mnZPSwwp/U/uN8FprNP33TUYZev
         eiASH0aIC/XbcztAmk1qFBv+OsiK8x6DAnzZPKt5NFPoohP1sv46j6+PqC4F4pv4yi
         Ixir82ZRgruDOHRiiNmbPa29g5LupNaV4HaeOVmzFkpWHWZeoTefJKb7kQRcUapNMo
         fYBw0cqiB9/UBkCMHUkk2O3ewheCsly5Til+PMstjYJC+TIQ2KQ9n7wE23xBhdg34i
         KLHxONwIAO1iCQ8paSNobtAhg7DBkHmhRDGfBEBTpfshVP6BZoeunNsPpm3749LA6y
         vJhiuVa89AZLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DA37B5C0A15; Mon, 20 Jun 2022 15:17:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu 3/3] doc: Document rcutree.nocb_nobypass_lim_per_jiffy kernel parameter
Date:   Mon, 20 Jun 2022 15:17:57 -0700
Message-Id: <20220620221757.3839212-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
References: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
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

This commit provides documentation for the kernel parameter controlling
RCU's handling of callback floods on offloaded (rcu_nocbs) CPUs.
This parameter might be obscure, but it is always there when you need it.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdf431bdbfdc4..a30890141b1a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4681,6 +4681,19 @@
 			invoked in the context of an rcuoc kthread, which
 			scheduler will preempt as it does any other task.
 
+	rcutree.nocb_nobypass_lim_per_jiffy= [KNL]
+			On callback-offloaded (rcu_nocbs) CPUs,
+			RCU reduces the lock contention that would
+			otherwise be caused callback floods through
+			use of the ->nocb_bypass list.	However, in the
+			common non-flooded case, RCU queues directly to
+			the main ->cblist in order to avoid the extra
+			overhead of the ->nocb_bypass list and its lock.
+			But if there are too many callbacks queued during
+			a single jiffy, RCU pre-queues the callbacks into
+			the ->nocb_bypass queue.  The definition of "too
+			many" is supplied by this kernel boot parameter.
+
 	rcutree.rcu_nocb_gp_stride= [KNL]
 			Set the number of NOCB callback kthreads in
 			each group, which defaults to the square root
-- 
2.31.1.189.g2e36527f23

