Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572CC465B58
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354929AbhLBAuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354643AbhLBAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF01C061748;
        Wed,  1 Dec 2021 16:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 872EDCE2134;
        Thu,  2 Dec 2021 00:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93D2C53FCC;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405996;
        bh=47Blq6QKlMNNq7abUbLDGHWwcxkJ1Tuzk1GHR/GrX0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jthxBgFUNYuhUE28bay/lRYlmXvPwpWWIcJWOqodfAUTWKrEwdThfYf31OnblUueW
         6Gh/Jp1eYNyKnC1uNVttVvDuy6eB+PG56fieRZzv8rzDwfo+eg96VRIkCsXbOa4ejW
         vCw+xjWhEojUancGIyYQhFpovBVC6pgIMTdNJrcizlVVw8ShCZ47vRpJP6pYS0wuTE
         f89p67AeJEa0lMmAvfAcU8mBItYMX+fIAUoLmcl4KZOx3aYIeMBoZySguGFS+GHxJ4
         dAc6id/pK9MyE9i0sF1kjIZkyGUW0Ao5XuNKm5QEeL3lAwKRcycK1SjBsRI1uajla0
         WxsebZ+PHoJIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6BD465C110A; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
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
Subject: [PATCH rcu 5/8] rcutorture: Cause TREE02 and TREE10 scenarios to do more callback flooding
Date:   Wed,  1 Dec 2021 16:46:31 -0800
Message-Id: <20211202004634.3130489-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables two callback-flood kthreads for the TREE02 scenario
and 28 for the TREE10 scenario.

Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
new file mode 100644
index 0000000000000..dd914fa8f690b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
@@ -0,0 +1 @@
+rcutorture.fwd_progress=2
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
new file mode 100644
index 0000000000000..dd914fa8f690b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
@@ -0,0 +1 @@
+rcutorture.fwd_progress=2
-- 
2.31.1.189.g2e36527f23

