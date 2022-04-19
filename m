Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF828506102
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiDSAqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC42AE23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E8E3613EF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44993C2BBE4;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=z34sJQnULSom1UTnZ7CPD/vLH4bsFBBYQ7NZgK/v9PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoHbzr0VwV/D/giI4D2fHpfCgvSgkMRCOsgI5NRDUNqAph3/a6cj5qE8ThNlHT+Bx
         4anLeJaMBn5RS2a9NCK9gsLQ6uH2crx9aR1RIOyXS61qNkt/F8zL1sLueAxyGMG5wn
         jr3JuEpl8EGOMhEkk0sAn2lqmqPqT2hTVKMJuH75gCWd9Dy6l4eDf8H6AmsDyhC7NG
         CgFC55/hPnJ+lxcSJloG1M+jdG5WxGppedIGjRMKoq7SKleBrOifZBh4YwvnG4GnMu
         98JSMkXaizbUAKfDH0bjmnwzG4+w7LbVqoqQ6WdE7boCA6p0Zpwu4r7gM5wP9FOloa
         9bVKB6WxR+AJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F9915C3103; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 31/61] tools/nolibc/string: add tiny versions of strncat() and strlcat()
Date:   Mon, 18 Apr 2022 17:41:55 -0700
Message-Id: <20220419004225.3952530-31-paulmck@kernel.org>
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

While these functions are often dangerous, forcing the user to work
around their absence is often much worse. Let's provide small versions
of each of them. The respective sizes in bytes on a few architectures
are:

  strncat(): x86:0x33 mips:0x68 arm:0x3c
  strlcat(): x86:0x25 mips:0x4c arm:0x2c

The two are quite different, and strncat() is even different from
strncpy() in that it limits the amount of data it copies and will always
terminate the output by one zero, while strlcat() will always limit the
total output to the specified size and will put a zero if possible.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 7c274efcdfae..c550c9ba8f4c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -121,6 +121,28 @@ size_t nolibc_strlen(const char *str)
 		nolibc_strlen((str));           \
 })
 
+static __attribute__((unused))
+size_t strlcat(char *dst, const char *src, size_t size)
+{
+	size_t len;
+	char c;
+
+	for (len = 0; dst[len];	len++)
+		;
+
+	for (;;) {
+		c = *src;
+		if (len < size)
+			dst[len] = c;
+		if (!c)
+			break;
+		len++;
+		src++;
+	}
+
+	return len;
+}
+
 static __attribute__((unused))
 size_t strlcpy(char *dst, const char *src, size_t size)
 {
@@ -138,6 +160,25 @@ size_t strlcpy(char *dst, const char *src, size_t size)
 	return len;
 }
 
+static __attribute__((unused))
+char *strncat(char *dst, const char *src, size_t size)
+{
+	char *orig = dst;
+
+	while (*dst)
+		dst++;
+
+	while (size && (*dst = *src)) {
+		src++;
+		dst++;
+		size--;
+	}
+
+	*dst = 0;
+	return orig;
+}
+
+
 static __attribute__((unused))
 char *strncpy(char *dst, const char *src, size_t size)
 {
-- 
2.31.1.189.g2e36527f23

