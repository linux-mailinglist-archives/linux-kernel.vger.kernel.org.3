Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388D25060DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiDSASx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbiDSASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B740F140BD;
        Mon, 18 Apr 2022 17:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63F7AB81128;
        Tue, 19 Apr 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FAFC385AD;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=qQJdeszLavvK5OgUBHVTt0BjmEDQYA/8LDdOWwnnjWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ax09gEw6IglFcoNcoHWv8Fkf4wUiUYo8xmtTlYnMwAURW7xm/KBqZDDIYimcK4AyY
         ZtCJx+NO28TXixwROBLhzndqFG4t1snXlg2o0Uvx7AtnECmm+V7JeAvLwD8vpm2L4G
         Fon4OS7o1g9vvIWaWoxZKmOfJbZZbq7qgz/a7UFA+mQnvdaUWmQddR9ceQvbauJ+/M
         C2ShZyd25x2WJEPRR5GVuoBM/Cw1iRjenagwrpRHUmw8pUszsjVk3bfKuQIns9ETP6
         9yH0Qp1l10jrvKqvOMb8j9VisjyPfqn8RNSkJv0tl4EHlZ0hDPQk3NHHmgb+CBlVX3
         qORPbF2yS+o5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C57995C04C6; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/12] torture: Use "-o Batchmode=yes" to disable ssh password requests
Date:   Mon, 18 Apr 2022 17:15:15 -0700
Message-Id: <20220419001525.3950505-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
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

The torture.sh script normally runs unattended, so there is not much
point in the "ssh" command asking for a password.  This commit therefore
adds the "-o Batchmode=yes" argument to each "ssh" command to cause it
to fail rather than ask for a password.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 03d7dede5f9b..0ff59bd8b640 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -138,7 +138,7 @@ chmod +x $T/bin/kvm-remote-*.sh
 # Check first to avoid the need for cleanup for system-name typos
 for i in $systems
 do
-	ncpus="`ssh $i getconf _NPROCESSORS_ONLN 2> /dev/null`"
+	ncpus="`ssh -o BatchMode=yes $i getconf _NPROCESSORS_ONLN 2> /dev/null`"
 	ret=$?
 	if test "$ret" -ne 0
 	then
@@ -153,14 +153,14 @@ echo Build-products tarball: `du -h $T/binres.tgz` | tee -a "$oldrun/remote-log"
 for i in $systems
 do
 	echo Downloading tarball to $i `date` | tee -a "$oldrun/remote-log"
-	cat $T/binres.tgz | ssh $i "cd /tmp; tar -xzf -"
+	cat $T/binres.tgz | ssh -o BatchMode=yes $i "cd /tmp; tar -xzf -"
 	ret=$?
 	tries=0
 	while test "$ret" -ne 0
 	do
 		echo Unable to download $T/binres.tgz to system $i, waiting and then retrying.  $tries prior retries. | tee -a "$oldrun/remote-log"
 		sleep 60
-		cat $T/binres.tgz | ssh $i "cd /tmp; tar -xzf -"
+		cat $T/binres.tgz | ssh -o BatchMode=yes $i "cd /tmp; tar -xzf -"
 		ret=$?
 		if test "$ret" -ne 0
 		then
@@ -185,7 +185,7 @@ checkremotefile () {
 
 	while :
 	do
-		ssh $1 "test -f \"$2\""
+		ssh -o BatchMode=yes $1 "test -f \"$2\""
 		ret=$?
 		if test "$ret" -eq 255
 		then
@@ -228,7 +228,7 @@ startbatches () {
 		then
 			continue # System still running last test, skip.
 		fi
-		ssh "$i" "cd \"$resdir/$ds\"; touch remote.run; PATH=\"$T/bin:$PATH\" nohup kvm-remote-$curbatch.sh > kvm-remote-$curbatch.sh.out 2>&1 &" 1>&2
+		ssh -o BatchMode=yes "$i" "cd \"$resdir/$ds\"; touch remote.run; PATH=\"$T/bin:$PATH\" nohup kvm-remote-$curbatch.sh > kvm-remote-$curbatch.sh.out 2>&1 &" 1>&2
 		ret=$?
 		if test "$ret" -ne 0
 		then
@@ -267,7 +267,7 @@ do
 		sleep 30
 	done
 	echo " ---" Collecting results from $i `date` | tee -a "$oldrun/remote-log"
-	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
+	( cd "$oldrun"; ssh -o BatchMode=yes $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
 done
 
 ( kvm-end-run-stats.sh "$oldrun" "$starttime"; echo $? > $T/exitcode ) | tee -a "$oldrun/remote-log"
-- 
2.31.1.189.g2e36527f23

