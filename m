Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479785526EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbiFTWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiFTWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12331B7A2;
        Mon, 20 Jun 2022 15:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9658612EE;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C923C341C7;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=n7HI6sinDisynSHP103tNG9aSbp5KKiDzOeA9d+Lwk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+EiZMQ2CeLc0OCOiNDByl4SFY431IAMQJzhF/GJ2gNmNv/wfnStYi7UnI+G7tOU6
         1tFl6lUMNtgwg68VXBg30JR7ivyYSmyPvoTaF1YLS8p5amUaomjhUNbMNZgYxxl2IL
         W11PuCcOE3+rE8ULVCXAtX3RQslQr9Zl+CFt/Frfuc6aA2TQ3e4uzS15y4f7MfoU9R
         zH3ROWCcidwKZDNkEX+3HTpQT71CDWTa9FME4T1/QLlJ8lwjKiljfyMWMnFWvP0DRz
         tckubD8SOGb3UQSFmOnN1AbOEruX9LLhXJ9gV8Q+onlz93n+2TSxAF7FvUC74OSlAu
         VzL6Ay5T9J7uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 05AF35C0ADC; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/12] rcu: Forbid RCU_STRICT_GRACE_PERIOD in TINY_RCU kernels
Date:   Mon, 20 Jun 2022 15:20:25 -0700
Message-Id: <20220620222032.3839547-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
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

The RCU_STRICT_GRACE_PERIOD Kconfig option does nothing in kernels
built with CONFIG_TINY_RCU=y, so this commit adjusts the dependencies
to disallow this combination.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 9b64e55d4f615..4da05beb13d79 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -121,7 +121,7 @@ config RCU_EQS_DEBUG
 
 config RCU_STRICT_GRACE_PERIOD
 	bool "Provide debug RCU implementation with short grace periods"
-	depends on DEBUG_KERNEL && RCU_EXPERT && NR_CPUS <= 4
+	depends on DEBUG_KERNEL && RCU_EXPERT && NR_CPUS <= 4 && !TINY_RCU
 	default n
 	select PREEMPT_COUNT if PREEMPT=n
 	help
-- 
2.31.1.189.g2e36527f23

