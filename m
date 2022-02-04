Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B0F4AA4BA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352855AbiBDX4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378501AbiBDX4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8600DB788D1;
        Fri,  4 Feb 2022 15:56:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5BA61CE2;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50FFC340F9;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=GgBZ5rqIurEZcMB46ROQ79+OYhe5rUcm87n6PCyjT3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT31gzk5KwfzA8Vb5gKM0Ebw51ai7nLBWJWK54YJIgj26Hp31VAO8Tyt3bCJHgRAJ
         0/A59zUAjU6zt6b524dvmesQM8LtYXFu8D89ilT2PxfFuWgTQiVhDpfvgjQrCDT9i0
         9BmUvjQ/p82ys5teco9D2DT/J5NZWEEuNHIEcN2lovjSwnANl4TeM9N6PlNebv+yfi
         PX1nkgrpYh9P1BT9VuAF0Cp+sHUfTvFA2mCxFHEOQjBFoIeSYcRBXFFSTNPa3/p8r0
         pwSydpFbe8B/akNV1iJsN22shX2y81JrmXSOMZfhMt4vU/uFWiV72GvUuSTGF10tr+
         z1IwCvUuSybGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 624265C0A6A; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/13] torture: Print only one summary line per run
Date:   Fri,  4 Feb 2022 15:55:56 -0800
Message-Id: <20220204235601.3438-8-paulmck@kernel.org>
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

The torture.sh scripts currently duplicates the summary lines, getting
one during the run phase and one during the summary phase of each run.
This commit therefore removes the run phase from consideration so as to
get only one summary line per run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a5f1c5fbefe4c..d1cb60085d8f2 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -414,7 +414,7 @@ nfailures=0
 echo FAILURES: | tee -a $T/log
 if test -s "$T/failures"
 then
-	awk < "$T/failures" -v sq="'" '{ print "echo " sq $0 sq; print "grep Summary: " $2 "/log | sed -e " sq "s/^[^S]*/  /" sq; }' | sh | tee -a $T/log | tee "$T/failuresum"
+	awk < "$T/failures" -v sq="'" '{ print "echo " sq $0 sq; print "sed -e " sq "1,/^ --- .* Test summary:$/d" sq " " $2 "/log | grep Summary: | sed -e " sq "s/^[^S]*/  /" sq; }' | sh | tee -a $T/log | tee "$T/failuresum"
 	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
 	grep "^  Summary: " "$T/failuresum" |
 		grep -v '^  Summary: Bugs: [0-9]* (all bugs kcsan)$' > "$T/nonkcsan"
-- 
2.31.1.189.g2e36527f23

