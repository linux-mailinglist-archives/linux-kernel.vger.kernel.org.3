Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3464AA4B6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378428AbiBDX40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57182 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378360AbiBDX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D01C61CE3;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885FEC340EF;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=UPkQT5w2q6YZSFdKy0yUznbCd1ftvqm2IFzyJSlUNoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbrF2qDlhzbZE3R2DbBVvpMmvmLvpqLUc4DtU5Yo84xFQm0Q5ILWiO/jIUt2rshXl
         Zq5BQD/dggZx0BTjOdrAwjNbPWUDuOIQVHndwjW4X7OTTJGnJnaPedn7e7nZnVI3bK
         pM5piRAp1LXjTGu7vmJlifPyUsGFfCg/wSnZ+nbvoI4FmdEV7h+UPikl4NCeWm8IDE
         Q+NNaR4muOHUIAXQKMBFVLJdAzD+hHrUxXSnQ9sED1zQOUc1dIiRLIwijyxpUGJY50
         VlyP0hZd7vaYK9lkgFxrHxQVxqx4WcHM4m2YCgqTHNU8BvYzkON46vZOKkqSo2fK38
         NA11jzTR6hfaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 595C95C08B7; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/13] torture: Output per-failed-run summary lines from torture.sh
Date:   Fri,  4 Feb 2022 15:55:51 -0800
Message-Id: <20220204235601.3438-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, torture.sh lists the failed runs, but it is up to the user
to work out what failed.  This is especially annoying for KCSAN runs,
where RCU's tighter definitions result in failures being reported for
other parts of the kernel.  This commit therefore outputs "Summary:"
lines for each failed run, allowing the user to more quickly identify
which failed runs need focused attention.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index eae88aacca2aa..894f589dd5625 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -414,7 +414,7 @@ nfailures=0
 echo FAILURES: | tee -a $T/log
 if test -s "$T/failures"
 then
-	cat "$T/failures" | tee -a $T/log
+	awk < "$T/failures" -v sq="'" '{ print "echo " sq $0 sq; print "grep Summary: " $2 "/log | sed -e " sq "s/^[^S]*/  /" sq; }' | sh | tee -a $T/log
 	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
 	ret=2
 fi
-- 
2.31.1.189.g2e36527f23

