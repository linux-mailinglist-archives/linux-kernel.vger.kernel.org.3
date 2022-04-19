Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D250612F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiDSAsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525AB2DA9D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2DF8613CA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4F9C341C5;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=epS+0Vm2DucSaF80BJUTQiv8VtGW/lZvv9umv8iDYPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxclmqW3Oxn4Y1hZmxPQCAEQste0+e+RoQq/WTGAQElKKck1/4Bis/vTV4eRLxV8P
         xE4Znw9Zi8c+JppwKYvxuotYjJmUpEgKSTNyBEbUyjskiUHfgQqiBLNr8PLTtXt/lO
         J1gd4y3uCJzsDtzd8lDIm1e6jXTZgkwhUVFX78appaT5m3wADrvsetruVYX9tQ2uQl
         AbE6uVe9m+KOyCi+DEjFS2YZVEMr/MjyNr2kZY2WhLqp75go0uHxe3I125cc96HrO6
         qRAwO7gS02LQ/Y5igCKTzY58pRJyFz3viMC4zAGxO4K+IRLKyl02ZN68fjWQKHIp+k
         6qovEiV3+fAtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5CEAC5C3236; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 47/61] tools/nolibc/sys: add syscall definition for getppid()
Date:   Mon, 18 Apr 2022 17:42:11 -0700
Message-Id: <20220419004225.3952530-47-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
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

From: Willy Tarreau <w@1wt.eu>

This is essentially for completeness as it's not the most often used
in regtests.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 28437863c63f..4d4308d5d111 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -464,6 +464,23 @@ pid_t getpid(void)
 }
 
 
+/*
+ * pid_t getppid(void);
+ */
+
+static __attribute__((unused))
+pid_t sys_getppid(void)
+{
+	return my_syscall0(__NR_getppid);
+}
+
+static __attribute__((unused))
+pid_t getppid(void)
+{
+	return sys_getppid();
+}
+
+
 /*
  * pid_t gettid(void);
  */
-- 
2.31.1.189.g2e36527f23

