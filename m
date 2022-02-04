Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981504AA4BE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378637AbiBDX45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378514AbiBDX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BFADB788C0;
        Fri,  4 Feb 2022 15:56:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80522B83978;
        Fri,  4 Feb 2022 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D136AC340FC;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=7df+VBYTF6sNJWXaffHoxsD1+Ms6yjHX8EopTce+Ujg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LE49Lbqj/GCAhp57/SIeYP1wNk6vdc9dkC35lm8lgY4zwDNLJqI++/4+J3H02UbgJ
         AxfEUdg3ARdw0F+b0qqvoq+hYSTFQ9LvMM0VJe5nuawCLspIzZIOoen4MAZC8n/PRT
         Z4AxPy0jJDuQhYihJIh0T2eRgpwDUQ1OIL8jWwSUsfLAj/PS9fvO/7S9rxz19d4jPG
         7EeV4OL5WA9uhmy9MIgFZAHVI19LpHV8nnD+OGQCAo8YKbnobjrj1uDxldf407LDOV
         6qwgYGF+CgRFEIA967dT6slLtm8Od4K+Hllrx5TyYp0seBGcxljfmAO01v0z8/EYrZ
         TAil3wukia4Jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 65BAA5C0BCB; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH rcu 10/13] torture: Change KVM environment variable to RCUTORTURE
Date:   Fri,  4 Feb 2022 15:55:58 -0800
Message-Id: <20220204235601.3438-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The torture-test scripting's long-standing use of KVM as the environment
variable tracking the pathname of the rcutorture directory now conflicts
with allmodconfig builds due to the virt/kvm/Makefile.kvm file's use
of this as a makefile variable.  This commit therefore changes the
torture-test scripting from KVM to RCUTORTURE, avoiding the name conflict.

Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  4 ++--
 .../selftests/rcutorture/bin/kvm-check-branches.sh |  4 ++--
 .../selftests/rcutorture/bin/kvm-end-run-stats.sh  |  4 ++--
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |  8 ++++----
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 14 +++++++-------
 tools/testing/selftests/rcutorture/bin/torture.sh  |  4 ++--
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 5a0023d183dac..0941f1ddab658 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -47,8 +47,8 @@ else
 	exit 1
 fi
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 dryrun=
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
index 370406bbfeedc..f17000a2ccf1f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -49,8 +49,8 @@ fi
 mkdir $resdir/$ds
 echo Results directory: $resdir/$ds
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 echo Using all `identify_qemu_vcpus` CPUs.
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
index e4a00779b8c69..ee886b40a5d2c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
@@ -22,8 +22,8 @@ T=${TMPDIR-/tmp}/kvm-end-run-stats.sh.$$
 trap 'rm -rf $T' 0
 mkdir $T
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 default_starttime="`get_starttime`"
 starttime="${2-default_starttime}"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 29b068a55b466..8c4c1e4792d02 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -19,8 +19,8 @@ then
 	exit 1
 fi
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 starttime="`get_starttime`"
@@ -108,8 +108,8 @@ else
 		cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
 		exit 2
 	fi
-	cp -a "$rundir" "$KVM/res/"
-	oldrun="$KVM/res/$ds"
+	cp -a "$rundir" "$RCUTORTURE/res/"
+	oldrun="$RCUTORTURE/res/$ds"
 fi
 echo | tee -a "$oldrun/remote-log"
 echo " ----" kvm-again.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 348ad177a5acc..55b2c15332827 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -25,15 +25,15 @@ LANG=en_US.UTF-8; export LANG
 
 dur=$((30*60))
 dryrun=""
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_BUILDONLY=
-TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
+TORTURE_INITRD="$RCUTORTURE/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
 TORTURE_BOOT_GDB_ARG=""
@@ -262,7 +262,7 @@ else
 	exit 1
 fi
 
-CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
+CONFIGFRAG=${RCUTORTURE}/configs/${TORTURE_SUITE}; export CONFIGFRAG
 
 defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
 if test -z "$configs"
@@ -272,7 +272,7 @@ fi
 
 if test -z "$resdir"
 then
-	resdir=$KVM/res
+	resdir=$RCUTORTURE/res
 fi
 
 # Create a file of test-name/#cpus pairs, sorted by decreasing #cpus.
@@ -386,7 +386,7 @@ END {
 # Generate a script to execute the tests in appropriate batches.
 cat << ___EOF___ > $T/script
 CONFIGFRAG="$CONFIGFRAG"; export CONFIGFRAG
-KVM="$KVM"; export KVM
+RCUTORTURE="$RCUTORTURE"; export RCUTORTURE
 PATH="$PATH"; export PATH
 TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
 TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
@@ -569,7 +569,7 @@ ___EOF___
 awk < $T/cfgcpu.pack \
 	-v TORTURE_BUILDONLY="$TORTURE_BUILDONLY" \
 	-v CONFIGDIR="$CONFIGFRAG/" \
-	-v KVM="$KVM" \
+	-v RCUTORTURE="$RCUTORTURE" \
 	-v ncpus=$cpus \
 	-v jitter="$jitter" \
 	-v rd=$resdir/$ds/ \
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index d1cb60085d8f2..e00e60efb2310 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -13,8 +13,8 @@
 scriptname=$0
 args="$*"
 
-KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-PATH=${KVM}/bin:$PATH; export PATH
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
-- 
2.31.1.189.g2e36527f23

