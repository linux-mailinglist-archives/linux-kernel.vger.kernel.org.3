Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E54AA4B9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378607AbiBDX43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378471AbiBDX4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EFCDB788C3;
        Fri,  4 Feb 2022 15:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3895761CE4;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB4BC340F1;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=4V1LkW9IAvyKIMEbPh/BLiAi71eumZHE3CFmxyRHbdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VoB1aOhAL9XZVabaKKxyfODr40vetmCFRvNPHv/5TO9NABOwxK56EjsmopxPxv1BY
         FuSXLHITljiFL7yH8lVxLqdeBMLtsIuVCCV/8iKsoBylcs0lt3fgz8glVqAL/w+Ci5
         a6i5WMhZjbxPP3yhgturViNkyi2lKJYSdvhdq/QULsku1J9JNQc63lNMf5/ceZjL7z
         8SuWaEO+lYp2yu4rk+fUfGMj6kZ3mS4PN8n5x30wlvCaaiV7AtEEFDoEti5vl+bNIk
         IPAWlkjeuNjJsgs44pO0Q75XRqeFznAY0pUKQ1xiHMOpCwndGidRL/S5s63FnDfkNw
         X9WxTiq9QhwKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B2BD5C08DD; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/13] torture: Make kvm.sh summaries note runs having only KCSAN reports
Date:   Fri,  4 Feb 2022 15:55:52 -0800
Message-Id: <20220204235601.3438-4-paulmck@kernel.org>
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

Runs having only KCSAN reports will normally print a summary line
containing only a "Bugs:" entry.  However, these bugs might or might
not be KCSAN reports.  This commit therefore flags runs in which all the
"Bugs:" entries are KCSAN reports.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/console-badness.sh        |  2 +-
 .../testing/selftests/rcutorture/bin/parse-console.sh  | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index e6a132df61721..69f8a5958cefc 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -10,7 +10,7 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
-egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+egrep 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 9f624bd53c277..822eb037a0573 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -138,6 +138,16 @@ then
 	then
 		summary="$summary  Bugs: $n_bugs"
 	fi
+	n_kcsan=`egrep -c 'BUG: KCSAN: ' $file`
+	if test "$n_kcsan" -ne 0
+	then
+		if test "$n_bugs" = "$n_kcsan"
+		then
+			summary="$summary (all bugs kcsan)"
+		else
+			summary="$summary  KCSAN: $n_kcsan"
+		fi
+	fi
 	n_calltrace=`grep -c 'Call Trace:' $file`
 	if test "$n_calltrace" -ne 0
 	then
-- 
2.31.1.189.g2e36527f23

