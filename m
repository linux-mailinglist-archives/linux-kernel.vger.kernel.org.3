Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0B465B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354955AbhLBAua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:50:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60190 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354732AbhLBAuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0711CE213A;
        Thu,  2 Dec 2021 00:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD642C53FD5;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405996;
        bh=IiFyND/82UhwIXCfYBWx9MEfAtdk2WtmcSQHnxahXRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPa+ydE2coHP6IjhbGwMIxpgBW6LkyVWrFODSK1dpw1/XjJNzju3LxLVyVqibHfv1
         7YkVNUCkhUAcyfRpLZY37XBxWLOWC33eNj5vg8DTnUfbDSSp2FGXeNF9LZUT2XcYXv
         YNLJyyEPEoLW5f6nsm6Zx1qsGlUTQca/9T85psFsVTJbQpKF4Wg0014sLOKlIDRcZH
         R7KqdvhTrdeSdRWLFJKtP9nO89aOhbBIf1FeDWxBUN9WrWTLzkYMMn1Gsg9mtRY8MV
         ImiOGgrj1l472MXRBJkkQvyu9/xpqLrXwXZvivDvRUgmUIduiCUXAhelyplLGYHZo4
         mJxuayCsMyU+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6DA655C1180; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 6/8] rcutorture: Test RCU Tasks lock-contention detection
Date:   Wed,  1 Dec 2021 16:46:32 -0800
Message-Id: <20211202004634.3130489-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adjusts the TRACE02 scenario to use a pair of callback-flood
kthreads.  This in turn forces lock contention on the single RCU Tasks
Trace callback queue, which forces use of all CPUs' queues, thus testing
this transition.  (No, there is not yet any way to transition back.

Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
index 9675ad632dcc2..c70b5db6c2ae0 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=tasks-tracing
+rcutorture.fwd_progress=2
-- 
2.31.1.189.g2e36527f23

