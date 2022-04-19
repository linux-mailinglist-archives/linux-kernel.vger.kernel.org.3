Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE45060C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiDSAPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiDSAPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B262F2;
        Mon, 18 Apr 2022 17:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96DD7612F5;
        Tue, 19 Apr 2022 00:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F71C385BC;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327155;
        bh=2rsmoyYg8DaXulWvIo0cGGWC9KNJr2PKGgQmzDpNBpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtYjcVnNCmyGf7RM3Wm4fBNIMDVHl5msm1uPyP8Kmw1V4ewhO0ZWTIhCLokbOhTF/
         xTx9XIC0+05wozytWwQ6zjd3r1gImZlkUooylnGwYZfdTB01Qt9U0qOVrXifeVMw32
         lCaR2EFOpNHmgFR/jXLfOJHaXa00bWWSZyJSNkmuvAzIJAyD6a9xJdZL7xry5ssa/M
         BsHsFOqFsS4qMEec0okPfbWYKprPnBS3L7rqZHP+9S67jnmGmxJiqUBx64ytErn5ZW
         gY+UMV+cs6RLEeblVATVD7H8zysgvaZiH5gHc5z5kbK3jrzvhzbvCvzL3ELuT2ySBK
         5Bh+ox66UJP6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 540C95C1369; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/12] scftorture: Adjust for TASKS_RCU Kconfig option being selected
Date:   Mon, 18 Apr 2022 17:12:33 -0700
Message-Id: <20220419001233.3950188-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
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

This commit adjusts the scftorture PREEMPT and NOPREEMPT scenarios to
account for the TASKS_RCU Kconfig option being explicitly selected rather
than computed in isolation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT | 2 ++
 tools/testing/selftests/rcutorture/configs/scf/PREEMPT   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
index b8429d6c6ebc..3a59346b3de7 100644
--- a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
@@ -7,3 +7,5 @@ CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
+CONFIG_KPROBES=n
+CONFIG_FTRACE=n
diff --git a/tools/testing/selftests/rcutorture/configs/scf/PREEMPT b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT
index ae4992b141b0..cb37e08037d6 100644
--- a/tools/testing/selftests/rcutorture/configs/scf/PREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT
@@ -7,3 +7,4 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
+CONFIG_RCU_EXPERT=y
-- 
2.31.1.189.g2e36527f23

