Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A30465B62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbhLBAvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354799AbhLBAuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A2C061574;
        Wed,  1 Dec 2021 16:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FE3BB8219C;
        Thu,  2 Dec 2021 00:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AB4C5831C;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405997;
        bh=RaKtqnNJ6qnBg/bu+KqQ3tMZ/08WLSnoSUoDuXE3sEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVDa7dBBbQRyQtthYI1QZ8wkSgQzjvh16u5iLQXE7In40Alr8YnCdRaTs/isaX4N7
         LAD0eq+yGrNgpf/9B8gVPeQjRoV5KjamHHZX3lpQx3beZ/FTsaSU/WyX5M0G+prizP
         vms8qt3em0AJjoU7Z8dSy64z/XlraoGXVCYT1iyiuggnA65rtjPLYo3clsKELzp/jr
         ShKz3dzGCbOT00SEvisuk97UuKZVae/l3CAEg2G7LO6apFneRfQmBmWMl1lV7x5F9Z
         JCOeZSStI4yYgi+aaTYHmsgeYqqdBh1Hg5dQ7Yh/4F+jb4pqWnnPAAbyPJkBmb3iWa
         SC5bHLVfMeBVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 712C85C1184; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/8] torture: Properly redirect kvm-remote.sh "echo" commands
Date:   Wed,  1 Dec 2021 16:46:34 -0800
Message-Id: <20211202004634.3130489-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The echo commands following initialization of the "oldrun" variable need
to be "tee"d to $oldrun/remote-log.  This commit fixes several stragglers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 7ab79b0d5ad19..e09b1bc787084 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -184,16 +184,16 @@ checkremotefile () {
 		ret=$?
 		if test "$ret" -eq 255
 		then
-			echo " ---" ssh failure to $1 checking for file $2, retry after $sleeptime seconds. `date`
+			echo " ---" ssh failure to $1 checking for file $2, retry after $sleeptime seconds. `date` | tee -a "$oldrun/remote-log"
 		elif test "$ret" -eq 0
 		then
 			return 0
 		elif test "$ret" -eq 1
 		then
-			echo " ---" File \"$2\" not found: ssh $1 test -f \"$2\"
+			echo " ---" File \"$2\" not found: ssh $1 test -f \"$2\" | tee -a "$oldrun/remote-log"
 			return 1
 		else
-			echo " ---" Exit code $ret: ssh $1 test -f \"$2\", retry after $sleeptime seconds. `date`
+			echo " ---" Exit code $ret: ssh $1 test -f \"$2\", retry after $sleeptime seconds. `date` | tee -a "$oldrun/remote-log"
 			return $ret
 		fi
 		sleep $sleeptime
@@ -252,7 +252,7 @@ do
 		sleep 30
 	fi
 done
-echo All batches started. `date`
+echo All batches started. `date` | tee -a "$oldrun/remote-log"
 
 # Wait for all remaining scenarios to complete and collect results.
 for i in $systems
@@ -261,7 +261,7 @@ do
 	do
 		sleep 30
 	done
-	echo " ---" Collecting results from $i `date`
+	echo " ---" Collecting results from $i `date` | tee -a "$oldrun/remote-log"
 	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
 done
 
-- 
2.31.1.189.g2e36527f23

