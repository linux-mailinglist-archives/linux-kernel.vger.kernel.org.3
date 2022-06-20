Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE1552759
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245220AbiFTXAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbiFTW7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB3193D3;
        Mon, 20 Jun 2022 15:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07564614A1;
        Mon, 20 Jun 2022 22:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39148C341CE;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765900;
        bh=mZiTOBDcqD704lMtn9ef+smf6JxOTN0xNvMG6GVm+gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdyRVY6Gx7syR9u3gBHnFgnVLZX4lTnhJvR/8/DhawivveNWjnPPHLjM/3UcsCJFl
         n8+uaVwbsqPe4xS93AeCIM73DJ4E/Mj06QKGSOpl+SLAXKQCUNJ65Q51W+gQEeV1UG
         M8zAIUpYqEhuPkJo4OV1eMckhR5rXK+4J1C/wwqqFnsr+AE0EEVNs6IJP+9ZLO+sLI
         gMthiBSYBMrq04o/HL94POibots/38XEWhdIjVh6CcJxh3jSsOplYWrmZmSn1NOIqP
         4ScpI2saB+Iwd5pIUMlVuBe4rpyQ25piljzxS7nmZKtFMyG9McVVmYBUm4hBiUMxB5
         jubzQEPWH0qzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A36725C0CCE; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/12] torture: Create kvm-check-branches.sh output in proper location
Date:   Mon, 20 Jun 2022 15:58:13 -0700
Message-Id: <20220620225817.3843106-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kvm-check-branches.sh causes each kvm.sh invocation create a
separate date-stamped directory, then after that invocation completes,
moves it into the *-group/NNNN directory.  This works, but makes it more
difficult to monitor an ongoing run.  This commit therefore uses the
kvm.sh --datestamp argument to make kvm.sh put the output in the right
place to start with, and also dispenses with the additional level of
datestamping.  (Those wanting datestamps can find them in the log files.)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-check-branches.sh    | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
index f17000a2ccf1f..ed0ec7f0927e7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -35,7 +35,7 @@ then
 	exit 1
 fi
 
-# Remember where we started so that we can get back and the end.
+# Remember where we started so that we can get back at the end.
 curcommit="`git status | head -1 | awk '{ print $NF }'`"
 
 nfail=0
@@ -73,15 +73,10 @@ do
 		# Test the specified commit.
 		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
 		echo git checkout return code: $? "(Commit $ntry: $i)"
-		kvm.sh --allcpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
+		kvm.sh --allcpus --duration 3 --trust-make --datestamp "$ds/$idir" > $resdir/$ds/$idir/kvm.sh.out 2>&1
 		ret=$?
 		echo kvm.sh return code $ret for commit $i from branch $gitbr
-
-		# Move the build products to their resting place.
-		runresdir="`grep -m 1 '^Results directory:' < $resdir/$ds/$idir/kvm.sh.out | sed -e 's/^Results directory://'`"
-		mv $runresdir $resdir/$ds/$idir
-		rrd="`echo $runresdir | sed -e 's,^.*/,,'`"
-		echo Run results: $resdir/$ds/$idir/$rrd
+		echo Run results: $resdir/$ds/$idir
 		if test "$ret" -ne 0
 		then
 			# Failure, so leave all evidence intact.
-- 
2.31.1.189.g2e36527f23

