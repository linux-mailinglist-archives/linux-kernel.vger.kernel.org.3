Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15C6552761
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbiFTXAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345964AbiFTW7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6434193C2;
        Mon, 20 Jun 2022 15:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710AC6148E;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AD3C3411B;
        Mon, 20 Jun 2022 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765899;
        bh=3kRnOesp5eHqSXcFmfKltAxDRwYQZS7t9KnwZqz15l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZ4fyvKQLKYSFqTRA/JFqzIyiYNlNFuCi/2iEnBE89OxhaPxKUr8/T20fLTpW8tXK
         edfvPeiaNXAtZ/+NkH3Gk+Z/zkEWGfYK9451AMiM094tpDz5ve0ca9hPZ52NptbNPK
         PJ+rO0UST/0X9Sxp2UtU5tCYerbJ+0G1EFkW5hgI926N0KB8jZAeECd7XbVUAAn2PB
         bhmutORkSUIkEeXo1N6bhg0BrO6UnEajArIj0oa4CyHGj92ZXdzeBNsIeiCLqnFkPM
         BbNwR8XPt8a1xLPtklUSwNmapigdqXtooVUx50s6GyFVldusflkt7S/som9GhMNPQM
         vIPRsovc1Bmdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 93A505C05B9; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/12] torture: Make kvm-remote.sh announce which system is being waited on
Date:   Mon, 20 Jun 2022 15:58:06 -0700
Message-Id: <20220620225817.3843106-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
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

If a remote system fails in certain ways, for example, if it is rebooted
without removing the contents of the /tmp directory, its remote.run file
never will be removed and the kvm-remote.sh script will loop waiting
forever.  The manual workaround for this (hopefully!) rare event is to
manually remove the file, which will cause the results up to the reboot
to be collected and evaluated.

Unfortunately, to work out which system is holding things up, the user
must refer to the name of the last system whose results were collected,
then look up the name of the next system in sequence, then manually
remove the remote.run file.  Even more unfortunately, this procedure can
be fooled in runs where each system handles more than one batch should
a given system take longer than expected, causing the systems to be
handled out of order.

This commit therefore causes kvm-remote.sh to print out the name of
the system it will wait on next, allowing the user to refer directly
to that name.  Making the kvm-remote.sh script automatically handle
unscheduled termination of the qemu processes is left as future work.
Quite possibly deep future work.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 0ff59bd8b640d..9f0a5d5ff2ddc 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -262,6 +262,7 @@ echo All batches started. `date` | tee -a "$oldrun/remote-log"
 # Wait for all remaining scenarios to complete and collect results.
 for i in $systems
 do
+	echo " ---" Waiting for $i `date` | tee -a "$oldrun/remote-log"
 	while checkremotefile "$i" "$resdir/$ds/remote.run"
 	do
 		sleep 30
-- 
2.31.1.189.g2e36527f23

