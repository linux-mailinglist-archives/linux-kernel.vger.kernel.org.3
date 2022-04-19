Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D05060D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiDSAS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbiDSASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB95140D5;
        Mon, 18 Apr 2022 17:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C0F4B81132;
        Tue, 19 Apr 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D9DC385AB;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=NA7ncOd3lAQr/67nsxE2rc6SFDgspmnx4HkPc1ydHVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJNfmDRQ+xdsIEX/RQRHZu82iQPxoCaeNB5yDpka85rJnFBFiHr3z5wkkW1saLPr5
         WrFJirHazIY6Ht0FD222nvhgbpZWQNOdKkB8O/AnKsSwdzx0lOUVKC1fewA0JVF5ds
         7WoRF3CESxgoMh8m0Jyw7ImU8xOWYC/M6+opzrOC+JGo27lIHyxsGtZMJLwexHzE82
         SJVyEVDhz30t0Y5bR44WC+NWCirntbtQ4QGFvEWxzQbvEmPQzPLiN4SoGkFoSxE9g3
         Uzada3wiyKzL6W2FF8UmhurHt5CBYUyS/eulx6VEd3ERx8yEEhUxagtX8CG19o1AW2
         4UBMayjORJRjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CAFCC5C0A23; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/12] torture: Skip vmlinux check for kvm-again.sh runs
Date:   Mon, 18 Apr 2022 17:15:18 -0700
Message-Id: <20220419001525.3950505-5-paulmck@kernel.org>
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

The kvm-again.sh script reruns an previously built set of kernels, so
the vmlinux files are associated with that previous run, not this on.
This results in kvm-find_errors.sh reporting spurious failed-build errors.
This commit therefore omits teh vmlinux check for kvm-again.sh runs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 5f682fc892dd..88983cba7956 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -36,7 +36,7 @@ do
 	then
 		egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
 		files="$files $i.diags $i"
-	elif ! test -f ${scenariobasedir}/vmlinux
+	elif ! test -f ${scenariobasedir}/vmlinux && ! test -f "${rundir}/re-run"
 	then
 		echo No ${scenariobasedir}/vmlinux file > $i.diags
 		files="$files $i.diags $i"
-- 
2.31.1.189.g2e36527f23

