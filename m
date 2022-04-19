Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674A506101
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbiDSAsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1EB29CBE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD65761423
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39274C385D9;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=oepFIishKrkOeUnkt79DFJwu+yfbGonUhjPMazu3u90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIqczG8CmyWZ23hWcM7zcJbSONbHWzlGBR46Tgjm2vZyhJAB6ONd7z5GEnGFOAA9H
         MTSOOOIFHDturjTsd4rTnjbd0gW0UcUhwgZ46Ryp/1bn6vQRzQx8FkO4SMkWfzkQVE
         ZEhcZY4m2DWfKQGoygYTlh9TSKSzd1qt31ylvLo7u9rVf36sff1/1VUQSRIb3IBoK1
         MEJkVMmK7Mzh1rLbrWY2WQzCDURijIm4rPI/xN5/f+K02Igjg4WYvBhApiHELyUiES
         q8MW/ParDjvj7dVdFcCQAvwsQ3R2PCwwwCa23ggILD649uG0Hy5oB2gJTlllEV7f+X
         ipYkPXT1gUMyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3DE2C5C3102; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 30/61] tools/nolibc/string: add strncpy() and strlcpy()
Date:   Mon, 18 Apr 2022 17:41:54 -0700
Message-Id: <20220419004225.3952530-30-paulmck@kernel.org>
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

These are minimal variants. strncpy() always fills the destination for
<size> chars, while strlcpy() copies no more than <size> including the
zero and returns the source's length. The respective sizes on various
archs are:

  strncpy(): x86:0x1f mips:0x30 arm:0x20
  strlcpy(): x86:0x17 mips:0x34 arm:0x1a

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index b831a02de83f..7c274efcdfae 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -121,6 +121,34 @@ size_t nolibc_strlen(const char *str)
 		nolibc_strlen((str));           \
 })
 
+static __attribute__((unused))
+size_t strlcpy(char *dst, const char *src, size_t size)
+{
+	size_t len;
+	char c;
+
+	for (len = 0;;) {
+		c = src[len];
+		if (len < size)
+			dst[len] = c;
+		if (!c)
+			break;
+		len++;
+	}
+	return len;
+}
+
+static __attribute__((unused))
+char *strncpy(char *dst, const char *src, size_t size)
+{
+	size_t len;
+
+	for (len = 0; len < size; len++)
+		if ((dst[len] = *src))
+			src++;
+	return dst;
+}
+
 static __attribute__((unused))
 char *strrchr(const char *s, int c)
 {
-- 
2.31.1.189.g2e36527f23

