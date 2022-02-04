Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362564AA4B8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378658AbiBDX4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378484AbiBDX4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7BDB788C2;
        Fri,  4 Feb 2022 15:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AC961CB0;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA708C340F7;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=xZePTPvdeMNKn6sTItV8Y+MIp/pcS8E3CgnOqzP3cbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqqQsunXUKAcpm/Zld16EZ4UYx91XDOKE9ODXhLRtd65n/a6jazUpskuYjL5FivVy
         2ljvobmMpun5Oy5OT4Ll7nhy2Y65d47ufLqXzW3SErAIF/lo/SgVeibiSF/HFi/GwG
         tzqoYoDpRmUn0Shlz0hFqlhUAaKdW8LZSTfa8yBcYwgeVyb0oOn2AsmwEtd/03qIRJ
         qNCzzpWHdMbVtg4ykVrgbq0ABgqCUCQ1WvQPawvwo8Bs6XoY/y7BKoMUTZESS/F56h
         vYv6YOinnuqvLIJscdW5QitT51k7CJiHEM23ZHQUVSy233k+xBW50yUQ2U4F6WGbnu
         2If/wvbFXvWYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5ED2E5C0A0A; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/13] torture: Compress KCSAN as well as KASAN vmlinux files
Date:   Fri,  4 Feb 2022 15:55:54 -0800
Message-Id: <20220204235601.3438-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_20,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compressing KASAN vmlinux files reduces torture.sh res file size from
about 100G to about 50G, which is good, but the KCSAN vmlinux files
are also large.  Compressing them reduces their size from about 700M to
about 100M (but of course your mileage may vary).  This commit therefore
compresses both KASAN and KCSAN vmlinux files.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh        | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index bddce72ea5ce4..a5f1c5fbefe4c 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -37,7 +37,7 @@ configs_scftorture=
 kcsan_kmake_args=
 
 # Default compression, duration, and apportionment.
-compress_kasan_vmlinux="`identify_qemu_vcpus`"
+compress_concurrency="`identify_qemu_vcpus`"
 duration_base=10
 duration_rcutorture_frac=7
 duration_locktorture_frac=1
@@ -67,7 +67,7 @@ function doyesno () {
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
-	echo "       --compress-kasan-vmlinux concurrency"
+	echo "       --compress-concurrency concurrency"
 	echo "       --configs-rcutorture \"config-file list w/ repeat factor (3*TINY01)\""
 	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
@@ -91,9 +91,9 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
-	--compress-kasan-vmlinux)
-		checkarg --compress-kasan-vmlinux "(concurrency level)" $# "$2" '^[0-9][0-9]*$' '^error'
-		compress_kasan_vmlinux=$2
+	--compress-concurrency)
+		checkarg --compress-concurrency "(concurrency level)" $# "$2" '^[0-9][0-9]*$' '^error'
+		compress_concurrency=$2
 		shift
 		;;
 	--config-rcutorture|--configs-rcutorture)
@@ -435,11 +435,11 @@ then
 	echo "  All bugs were KCSAN failures."
 fi
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
-if test -n "$tdir" && test $compress_kasan_vmlinux -gt 0
+if test -n "$tdir" && test $compress_concurrency -gt 0
 then
 	# KASAN vmlinux files can approach 1GB in size, so compress them.
-	echo Looking for KASAN files to compress: `date` > "$tdir/log-xz" 2>&1
-	find "$tdir" -type d -name '*-kasan' -print > $T/xz-todo
+	echo Looking for K[AC]SAN files to compress: `date` > "$tdir/log-xz" 2>&1
+	find "$tdir" -type d -name '*-k[ac]san' -print > $T/xz-todo
 	ncompresses=0
 	batchno=1
 	if test -s $T/xz-todo
@@ -457,7 +457,7 @@ then
 			do
 				xz "$j" >> "$tdir/log-xz" 2>&1 &
 				ncompresses=$((ncompresses+1))
-				if test $ncompresses -ge $compress_kasan_vmlinux
+				if test $ncompresses -ge $compress_concurrency
 				then
 					echo Waiting for batch $batchno of $ncompresses compressions `date` | tee -a "$tdir/log-xz" | tee -a $T/log
 					wait
-- 
2.31.1.189.g2e36527f23

