Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1822B4AA4BD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378694AbiBDX4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46814 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378460AbiBDX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6699BB8397B;
        Fri,  4 Feb 2022 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB08CC34100;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=8MfaDQZPX686Fl4ENxwJRECweixHv3A6rHs+5n3xEhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eieWZxcVwDATKv6gAhhVvQ03P6KI6pEyZpSjhf0kH9gjQSIv/kX0+X6tsf8wfL7Ka
         BK06f3E36JhmP7ap+fpmEeNSLnQT1tOlaB0pPV1OZBAI3HuVsDuR6PSwptlhDKiK40
         KgVgrQ4+V64E4G9vUcupIirxWsXoDAgJ9Mpj6ooAHyn1Qe/g8ZzW5uGuW1m4WvD5E+
         0bWa4u0sIqftXS3bE+Bq4oAxdbKqrP18QvnLRzkz+dJkoJnPnxpo2kad4k8qN81mVZ
         Vc0wLbre73ENVh9iNz+Fchw6LivHRbEaQvC2Czuft5/0urFAsn3aypesNDCvxbSoRc
         FY0L7lb3fJqaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 691425C0E5E; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/13] rcutorture: Test SRCU size transitions
Date:   Fri,  4 Feb 2022 15:56:00 -0800
Message-Id: <20220204235601.3438-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thie commit adds kernel boot parameters to the SRCU-N and SRCU-P
rcutorture scenarios to cause SRCU-N to test contention-based resizing
and SRCU-P to test init_srcu_struct()-time resizing.  Note that this
also tests never-resizing because the contention-based resizing normally
takes some minutes to make the shift.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
index 238bfe3bd0ccc..ce0694fd9b929 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=srcu
+rcutorture.fwd_progress=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
index ce48c7b826734..2db39f298d182 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
@@ -1,2 +1,4 @@
 rcutorture.torture_type=srcud
 rcupdate.rcu_self_test=1
+rcutorture.fwd_progress=3
+srcutree.big_cpu_lim=5
-- 
2.31.1.189.g2e36527f23

