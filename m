Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2770350612D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiDSAqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9D02A730
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4656D61387
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA3AC385D7;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=yyxQcEQkGbsIpnbxVQaX+H2riId0XmKKxGJBUjEqkRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mekSrUYrjKBfSYGCKiGEsfwMkO0o/KZw4tMxqAdtDYITorxJu+hNkWVreyPx+w0Q/
         VxZlreJCGirS1gUfSwGp/qbR50jiEpOE3cbObAFHjwf77F4WmMsF/9mzOyyKJsw70M
         u9TOT8aNib+tqS5yh1pYx3gvIrtcv6Qr99Mz7vdfEYc8H7DdSDYRy4IhRiWJYpW72d
         Ku2m6TmqmRZZ1ZalQCwsn3TOKY+6dVzFwjNFVVza2ykAJ2hwl2TJ0HllIB1ctYVjN4
         N0kk7tex+qX7wT4zEGZb0tkXt+kJsjqWB3+tly8PHT5SO4TslG8XdVOmA2E6eLSKRE
         nqSMlKYcXpknQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38B645C30FE; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 27/61] tools/nolibc/sys: make getpgrp(), getpid(), gettid() not set errno
Date:   Mon, 18 Apr 2022 17:41:51 -0700
Message-Id: <20220419004225.3952530-27-paulmck@kernel.org>
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

These syscalls never fail so there is no need to extract and set errno
for them.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 539af457a91b..ef017cc0a580 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -458,13 +458,7 @@ pid_t sys_getpgrp(void)
 static __attribute__((unused))
 pid_t getpgrp(void)
 {
-	pid_t ret = sys_getpgrp();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return sys_getpgrp();
 }
 
 
@@ -481,13 +475,7 @@ pid_t sys_getpid(void)
 static __attribute__((unused))
 pid_t getpid(void)
 {
-	pid_t ret = sys_getpid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return sys_getpid();
 }
 
 
@@ -504,13 +492,7 @@ pid_t sys_gettid(void)
 static __attribute__((unused))
 pid_t gettid(void)
 {
-	pid_t ret = sys_gettid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return sys_gettid();
 }
 
 
-- 
2.31.1.189.g2e36527f23

