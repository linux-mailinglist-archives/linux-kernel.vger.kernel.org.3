Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13759465B60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355050AbhLBAvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:51:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41760 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344262AbhLBAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04972B8200D;
        Thu,  2 Dec 2021 00:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33B1C53FAD;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405996;
        bh=qlV5snXuPSmJO69YHgwKyHjdEnkb1SnckQkEox6XHig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHJO9RWzYHl7KmqdNShn8FoEPbWukWxn52MYHcqujY4ChJVVbeYbv1a0jYqbXVfze
         stEYc436+huArKW7Vhtuo7/ex0qMVU6fmtIKUszVFTIHKwJQDT6ncheNYUFNggdCP4
         qrHJYwy6WgMeiGEkxWREX1+1yTRzNMvH6WRiyXiSip2Ywg0j08StAD91FQ5ZdnRB9h
         dIFNs3iZYOSlaTTKrw5J/7NpcI+qm2690G1bPfsQsQrl93EP/ydt9cSZ4LADIzI0pD
         8QavI2ZSWTQb6heLP0cUwpNnL9nbdjRm0VNdqCKSXXyfvZKo3g5Cg0Mvx6ISHFVFmK
         YKHBePLNdMQfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 680275C1010; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/8] torture: Make kvm-find-errors.sh report link-time undefined symbols
Date:   Wed,  1 Dec 2021 16:46:29 -0800
Message-Id: <20211202004634.3130489-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes kvm-find-errors.sh check for and report undefined
symbols that are detected at link time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 4 ++--
 tools/testing/selftests/rcutorture/bin/parse-build.sh     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index daf64b5070387..2e9e9e2eedb69 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -30,9 +30,9 @@ editor=${EDITOR-vi}
 files=
 for i in ${rundir}/*/Make.out
 do
-	if egrep -q "error:|warning:" < $i
+	if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
 	then
-		egrep "error:|warning:" < $i > $i.diags
+		egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
 		files="$files $i.diags $i"
 	fi
 done
diff --git a/tools/testing/selftests/rcutorture/bin/parse-build.sh b/tools/testing/selftests/rcutorture/bin/parse-build.sh
index 9313e5065ae92..2dbfca3589b17 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-build.sh
@@ -39,7 +39,8 @@ fi
 grep warning: < $F > $T/warnings
 grep "include/linux/*rcu*\.h:" $T/warnings > $T/hwarnings
 grep "kernel/rcu/[^/]*:" $T/warnings > $T/cwarnings
-cat $T/hwarnings $T/cwarnings > $T/rcuwarnings
+grep "^ld: .*undefined reference to" $T/warnings | head -1 > $T/ldwarnings
+cat $T/hwarnings $T/cwarnings $T/ldwarnings > $T/rcuwarnings
 if test -s $T/rcuwarnings
 then
 	print_warning $title build errors:
-- 
2.31.1.189.g2e36527f23

