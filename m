Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2FA50611B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbiDSAp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiDSApL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C702E21E2A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA00A6137D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BE0C385A8;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=3/nVAO39urk0Clwy2IyJ8hb7zVq7DI5qPlt8WqtHNCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ik9QM7xn9TWRT4gw+vwPByQlIiJE/u3BZbMWyatiBvDcyg31Hmkrd4w61kJ4ihipP
         MH0qIuE+cnm+5xArFPirYg69eugxkDuZfFE577iTo08ZgNQ9/HQu2mWyHSbXjPGSCG
         SAM1dNhpRKqDdiSY7rjyY/NxrP4nH/4zgpaOy1oARDoKS/hrV5Ih7NDLqf5jj1gcHa
         Kv5Z2DPiOr7nCFVkpeillotQGOBXwwiLmeu22RulpYaWlm6AD8LzoXTTQVPScrxjwG
         Ynof+AjBiPqcnO/18q74ZK0G5gj7oVf0SZPKOttx1I/4juXSpH6gzhm851nh6izUqr
         MnBqGb3WhYXVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 067475C04C6; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 02/61] tools/nolibc: guard the main file against multiple inclusion
Date:   Mon, 18 Apr 2022 17:41:26 -0700
Message-Id: <20220419004225.3952530-2-paulmck@kernel.org>
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

Including nolibc.h multiple times results in build errors due to multiple
definitions. Let's add a guard against multiple inclusions.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index ad23712f9cb5..4660637d9b17 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -80,6 +80,8 @@
  *      https://w3challs.com/syscalls/
  *
  */
+#ifndef _NOLIBC_H
+#define _NOLIBC_H
 
 #include <asm/unistd.h>
 #include <asm/ioctls.h>
@@ -2582,3 +2584,5 @@ dev_t makedev(unsigned int major, unsigned int minor)
 {
 	return ((major & 0xfff) << 8) | (minor & 0xff);
 }
+
+#endif /* _NOLIBC_H */
-- 
2.31.1.189.g2e36527f23

