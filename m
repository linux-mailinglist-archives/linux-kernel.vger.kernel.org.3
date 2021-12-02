Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E884465B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbhLBAsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39232 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344461AbhLBArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF7D2B821A0;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBCDC5833A;
        Thu,  2 Dec 2021 00:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405819;
        bh=RwTiSH2043ckm/NhwtIpkSHOCAoEdVxq1VCFeZwpy9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMoy1de7+T25BKnyoO7RpsnE2u65/38GkEh5SnXdEeeaGcp9uEIJUFPLRhPzl/3bR
         5FDwa9TcWlufOSUOO3krcj1q8VYnuwJU2rp2WGnfeckzYKG6TPxiAJZzGp2CqzcbMy
         VRKCt/UgfpVOiOUJM+KuJgyBzddUEVFIJbrrRJ2HbRg5Ro9pZRYf1GooCulSfpta1E
         LraesdALAJNgd98umi9RwEBDlmACfxj67GaaCZ3VPpYplACuB9LVtMV2rpjBic0nhu
         r8ryE5RH4Vf48nD6I7uzxJT3N3jB2AiCo+hP4+BHxUKlA/iLTfoJ+3/B5vYNca0e6w
         PIIDQQqMMSlYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 65F385C1357; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
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
Subject: [PATCH rcu 17/17] rcutorture: Combine n_max_cbs from all kthreads in a callback flood
Date:   Wed,  1 Dec 2021 16:43:36 -0800
Message-Id: <20211202004337.3130175-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of multiple callback-flood kthreads, the maximum number
of callbacks from any one of those kthreads is reported in the rcutorture
run summary.  This commit changes this to report the sum of each kthread's
maximum number of callbacks in a given callback-flooding episode.

Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c                                  | 9 +++++++++
 .../testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh  | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1e8360d159200..33ea446101b30 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2170,6 +2170,7 @@ struct rcu_fwd {
 static DEFINE_MUTEX(rcu_fwd_mutex);
 static struct rcu_fwd *rcu_fwds;
 static unsigned long rcu_fwd_seq;
+static atomic_long_t rcu_fwd_max_cbs;
 static bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
@@ -2428,6 +2429,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 			 n_launders + n_max_cbs - n_launders_cb_snap,
 			 n_launders, n_launders_sa,
 			 n_max_gps, n_max_cbs, cver, gps);
+		atomic_long_add(n_max_cbs, &rcu_fwd_max_cbs);
 		rcu_torture_fwd_cb_hist(rfp);
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
@@ -2489,6 +2491,8 @@ static struct notifier_block rcutorture_oom_nb = {
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
+	bool firsttime = true;
+	long max_cbs;
 	int oldnice = task_nice(current);
 	unsigned long oldseq = READ_ONCE(rcu_fwd_seq);
 	struct rcu_fwd *rfp = args;
@@ -2503,6 +2507,11 @@ static int rcu_torture_fwd_prog(void *args)
 		if (!rfp->rcu_fwd_id) {
 			schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 			WRITE_ONCE(rcu_fwd_emergency_stop, false);
+			if (!firsttime) {
+				max_cbs = atomic_long_xchg(&rcu_fwd_max_cbs, 0);
+				pr_alert("%s n_max_cbs: %ld\n", __func__, max_cbs);
+			}
+			firsttime = false;
 			WRITE_ONCE(rcu_fwd_seq, rcu_fwd_seq + 1);
 		} else {
 			while (READ_ONCE(rcu_fwd_seq) == oldseq)
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index fbdf162b6acdf..1c4c2c727dad1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -25,7 +25,7 @@ stopstate="`grep 'End-test grace-period state: g' $i/console.log 2> /dev/null |
 	    tail -1 | sed -e 's/^\[[ 0-9.]*] //' |
 	    awk '{ print \"[\" $1 \" \" $5 \" \" $6 \" \" $7 \"]\"; }' |
 	    tr -d '\012\015'`"
-fwdprog="`grep 'rcu_torture_fwd_prog_cr Duration' $i/console.log 2> /dev/null | sed -e 's/^\[[^]]*] //' | sort -k15nr | head -1 | awk '{ print $14 " " $15 }'`"
+fwdprog="`grep 'rcu_torture_fwd_prog n_max_cbs: ' $i/console.log 2> /dev/null | sed -e 's/^\[[^]]*] //' | sort -k3nr | head -1 | awk '{ print $2 " " $3 }'`"
 if test -z "$ngps"
 then
 	echo "$configfile ------- " $stopstate
-- 
2.31.1.189.g2e36527f23

