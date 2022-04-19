Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739F9506106
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiDSArT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B625C63
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A616B6142D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79473C3411F;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=7svjDJnENxdUmRTc+dBi9nfkTxydPXZ0C6KVAl+Km68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0nNaMhH5+/73D+1cMWXN2wKz5m0iUSDYZCOtdZAFh1JHe0fsvOZW13JGSWpQoMP5
         Cuq3fUkXwYtWd+dD0FvXtZtC8VEwZi16GAFNLLXDAEbxUntl5ss6WXykWnp6xR/VTT
         ouHMkvsvnHkhXIqnWrumxjD9gRvZqZOnnI4Ov615/ruUjmDJrfzFDwsCrezxPxMjIC
         eJHEdK4Xmxu2I2T4gYkZ+cEtT8Dya7DC9uJUlcS4w9SdrVexNfv5IEvxv5UnQgJf48
         UUIQQEakoRCMVD/EDWTQ6xgYp10udJgko0anKbIMbLWRQrAVBfjUjGahr7o1Gj8BqR
         xiJBnbIVSLMXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B2FC5C3234; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 46/61] tools/nolibc/string: add strcmp() and strncmp()
Date:   Mon, 18 Apr 2022 17:42:10 -0700
Message-Id: <20220419004225.3952530-46-paulmck@kernel.org>
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

We need these functions all the time, including when checking environment
variables and parsing command-line arguments. These implementations were
optimized to show optimal code size on a wide range of compilers (22 bytes
return included for strcmp(), 33 for strncmp()).

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 4554b6fcb400..0d5e870c7c0b 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -102,6 +102,17 @@ char *strchr(const char *s, int c)
 	return NULL;
 }
 
+static __attribute__((unused))
+int strcmp(const char *a, const char *b)
+{
+	unsigned int c;
+	int diff;
+
+	while (!(diff = (unsigned char)*a++ - (c = (unsigned char)*b++)) && c)
+		;
+	return diff;
+}
+
 static __attribute__((unused))
 char *strcpy(char *dst, const char *src)
 {
@@ -184,6 +195,18 @@ char *strncat(char *dst, const char *src, size_t size)
 	return orig;
 }
 
+static __attribute__((unused))
+int strncmp(const char *a, const char *b, size_t size)
+{
+	unsigned int c;
+	int diff = 0;
+
+	while (size-- &&
+	       !(diff = (unsigned char)*a++ - (c = (unsigned char)*b++)) && c)
+		;
+
+	return diff;
+}
 
 static __attribute__((unused))
 char *strncpy(char *dst, const char *src, size_t size)
-- 
2.31.1.189.g2e36527f23

