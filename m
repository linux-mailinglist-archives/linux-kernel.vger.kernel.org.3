Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE39465B59
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354915AbhLBAu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354669AbhLBAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF5C061574;
        Wed,  1 Dec 2021 16:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 811B6CE207F;
        Thu,  2 Dec 2021 00:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E12C53FCD;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405996;
        bh=UlM6yG11W12UDElkrypUK7QGiJEmA9jLZKz6ydk8pYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OABWZq7pws7suuCJzuEcyCkgAC7nPsqnjH3JfxHfZqnA1hxMmXCVbHzbB4ju8UGUL
         itV82vaKafXeS1OmTftmOWIarZSyXlDw3k9iVXrcSKeIlDLmJhWO874netiY3NWm00
         /PkX2KWalc2ildSEn5urc0iv29jtIZPI2+HHl5mo02Zlf6ChNSXOtCboyjVDgL5Oas
         uOK2vIWv+IvzA9c4wJQsFgJwwDwMuBzsSMhGdK6IgZlleWuE13d9PrUtWDoUvmpmw3
         kaouyp+4NNOzEF6xfL++FNFS3Sswi54by03/nhYSsiahjBzsEDYaX3xj2icODXtktL
         P+1uQ43Jjh5IQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 65FC45C100F; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/8] torture: Catch kvm.sh help text up with actual options
Date:   Wed,  1 Dec 2021 16:46:28 -0800
Message-Id: <20211202004634.3130489-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit brings the kvm.sh script's help text up to date with recently
(and some not-so-recently) added parameters.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6cf9ec6a3d1c0..6de0c183db5b9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -74,7 +74,9 @@ usage () {
 	echo "       --help"
 	echo "       --interactive"
 	echo "       --jitter N [ maxsleep (us) [ maxspin (us) ] ]"
+	echo "       --kasan"
 	echo "       --kconfig Kconfig-options"
+	echo "       --kcsan"
 	echo "       --kmake-arg kernel-make-arguments"
 	echo "       --mac nn:nn:nn:nn:nn:nn"
 	echo "       --memory megabytes|nnnG"
@@ -83,6 +85,7 @@ usage () {
 	echo "       --qemu-cmd qemu-system-..."
 	echo "       --remote"
 	echo "       --results absolute-pathname"
+	echo "       --shutdown-grace seconds"
 	echo "       --torture lock|rcu|rcuscale|refscale|scf"
 	echo "       --trust-make"
 	exit 1
@@ -175,14 +178,14 @@ do
 		jitter="$2"
 		shift
 		;;
+	--kasan)
+		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
+		;;
 	--kconfig|--kconfigs)
 		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
 		TORTURE_KCONFIG_ARG="`echo "$TORTURE_KCONFIG_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
-	--kasan)
-		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
-		;;
 	--kcsan)
 		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
-- 
2.31.1.189.g2e36527f23

