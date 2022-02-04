Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB04AA4B7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378599AbiBDX4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46802 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378428AbiBDX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0146B83973;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A5CC340F0;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=fq+PXC+3LobGGhIbiFdbfmExaf2eeUyxk01b1jjprwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tt/SCs2lRWi72t7fvXGQB9NCtrAjZJesx0pqw/EtpTk8wl13uuvWpvnFUfrCZKKkF
         vKtIEdQHLHQD1mZ/khiMgZ5KFuHcLig1d5VXa7EhwUfls5x3NM5HCNLIra2+pItpqa
         W5K5Hb74HHFIgQTRrn65XaVly47kpnCRWwY9SvKavaD5QKDf0to20egqA8OJKwyTvH
         LO7oTjh3cXWRhj2hufrPYcCYjBbnZL6EuJEmjJPJUT+oslkd7YY2C8k66SIMqwY0Q9
         ahGtcIEAhJGmfy/IeYVOcLb5bMBx/+hdU4gCFVF3fDGy0WDSrd3BUV4XdA1WQ1YURT
         VdQ1R5eK9ga3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5CFBA5C0992; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/13] torture: Indicate which torture.sh runs' bugs are all KCSAN reports
Date:   Fri,  4 Feb 2022 15:55:53 -0800
Message-Id: <20220204235601.3438-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit further improves torture.sh run summaries by indicating
which runs' "Bugs:" counts are all KCSAN reports, and further printing
an additional end-of-run summary line when all errors reported in all
runs were KCSAN reports.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 894f589dd5625..bddce72ea5ce4 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -414,8 +414,14 @@ nfailures=0
 echo FAILURES: | tee -a $T/log
 if test -s "$T/failures"
 then
-	awk < "$T/failures" -v sq="'" '{ print "echo " sq $0 sq; print "grep Summary: " $2 "/log | sed -e " sq "s/^[^S]*/  /" sq; }' | sh | tee -a $T/log
+	awk < "$T/failures" -v sq="'" '{ print "echo " sq $0 sq; print "grep Summary: " $2 "/log | sed -e " sq "s/^[^S]*/  /" sq; }' | sh | tee -a $T/log | tee "$T/failuresum"
 	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
+	grep "^  Summary: " "$T/failuresum" |
+		grep -v '^  Summary: Bugs: [0-9]* (all bugs kcsan)$' > "$T/nonkcsan"
+	if test -s "$T/nonkcsan"
+	then
+		nonkcsanbug="yes"
+	fi
 	ret=2
 fi
 if test "$do_kcsan" = "yes"
@@ -424,6 +430,10 @@ then
 fi
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
+if test -z "$nonkcsanbug" && test -s "$T/failuresum"
+then
+	echo "  All bugs were KCSAN failures."
+fi
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
 if test -n "$tdir" && test $compress_kasan_vmlinux -gt 0
 then
-- 
2.31.1.189.g2e36527f23

