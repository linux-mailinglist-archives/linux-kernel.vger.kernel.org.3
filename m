Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37164AA4A6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378459AbiBDXxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378408AbiBDXxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3506BC06C94B;
        Fri,  4 Feb 2022 15:53:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5716B81210;
        Fri,  4 Feb 2022 23:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F34C340ED;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018809;
        bh=VaAGDBn6uKvflCX1P8zwNnB516OO2C64Im2j7PiEN0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+4yQqHfLjxmEfTpGG2f9Qe5YDGC/USJBSM1y1O2HxfrTF3eCj+hIzoGT1cgCcQ0G
         KbwezbnPbEWA33WkavozgBA/eMsJzr+7TeFDIIqSuewVMwGCRpgM+nqKvlIDH1a7IG
         MhsbuqnBOSmdAXrJSBT6RLBKFfDUYnVeZCefx9cLHdxdRU2UtsgAU7EL6Fh4zw2OQX
         FbrNHtaOAfThPKV/UnoFoQUdWBMo7Mlvyy7umZnQoholFJeO8AopqcMNfxcD6l6rxB
         /fkxBqN9hjoqA1BQAIqUs/n28y4A8i54PXc7WA+pF3E6XwXD06KBamTDvYGycQCu2i
         ROmOpH6Am4cgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 76BA75C0829; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/8] torture: Distinguish kthread stopping and being asked to stop
Date:   Fri,  4 Feb 2022 15:53:21 -0800
Message-Id: <20220204235327.2948-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
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

Right now, if a given kthread (call it "kthread") realizes that it needs
to stop, "Stopping kthread" is written to the console.  When the cleanup
code decides that it is time to stop that kthread, "Stopping kthread
tasks" is written to the console.  These two events might happen in
either order, especially in the case of time-based torture-test shutdown.

But it is hard to distinguish these, especially for those unfamiliar with
the torture tests.  This commit therefore changes the first case from
"Stopping kthread" to "kthread is stopping" to make things more clear.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index ef27a6c824514..f55d803f995d4 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -911,7 +911,7 @@ void torture_kthread_stopping(char *title)
 {
 	char buf[128];
 
-	snprintf(buf, sizeof(buf), "Stopping %s", title);
+	snprintf(buf, sizeof(buf), "%s is stopping", title);
 	VERBOSE_TOROUT_STRING(buf);
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb(title);
-- 
2.31.1.189.g2e36527f23

