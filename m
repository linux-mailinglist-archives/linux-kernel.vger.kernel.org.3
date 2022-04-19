Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FCB5060C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiDSAPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiDSAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D37635C;
        Mon, 18 Apr 2022 17:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E14AFB81136;
        Tue, 19 Apr 2022 00:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D918C385A1;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=N/2wcv4fSS59b1Qr2OkYx77ELrRFwx2AKbsAhPyTtJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESbh2uzKIEpFPSlMhKsElSAlfSZAW1bC23Lvt6RiAN/qgGoWMYj8QVEytkZDhDo7y
         PQnqdryc30nGXahz6jY/MVqCAP5LVpxugxAljmTWYWmNgDWjVQO9MMaAm+cl3BjJCw
         VOBVwJux6f+0XvqVkiN1gmR2jYGWvB1TqdAHQvfv30SaQgadGsQpKRy/sh6jpWqtdk
         +QphEYmYN3OUXOkGrX+Ddfx/UMSoNuXvYySoyCFRyVO4gzkNZowWr1+EtVrO8lEuW2
         0wXwx934+E5QAinTDm3V15dfb2G+XxPVLYnZq9zKga8+KfcncfiMoSz/l0S/4OKMW+
         ymlMeDhzlRQaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3DC085C04BD; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH rcu 01/12] rcu: Make TASKS_RUDE_RCU select IRQ_WORK
Date:   Mon, 18 Apr 2022 17:12:22 -0700
Message-Id: <20220419001233.3950188-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
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

The TASKS_RUDE_RCU does not select IRQ_WORK, which can result in build
failures for kernels that do not otherwise select IRQ_WORK.  This commit
therefore causes the TASKS_RUDE_RCU Kconfig option to select IRQ_WORK.

Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bf8e341e75b4..f559870fbf8b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -86,6 +86,7 @@ config TASKS_RCU
 
 config TASKS_RUDE_RCU
 	def_bool 0
+	select IRQ_WORK
 	help
 	  This option enables a task-based RCU implementation that uses
 	  only context switch (including preemption) and user-mode
-- 
2.31.1.189.g2e36527f23

