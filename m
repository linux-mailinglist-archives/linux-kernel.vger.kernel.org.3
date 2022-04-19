Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5DD506112
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiDSApo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF64D2A724
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE5961382
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07D0C385B9;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=LIAUuKjPhnDlL3iLTwusab7z19Sgly7N5/hwAttZiuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWXqWGu4sbJfzZ7h3iXTISgudkU+6XIa2HyA/Ykche3PMDqLcH7vgsEHuHD+TwEVc
         tJDJvknmjebuK/P/Dcw5lcaLkWT7RoiWVdaP73GWuQlm+kJf4H3m33GB89QC/jVPKk
         oDZiq998L737uat3yukj9+cSkQVdqSiPqZWKqoO8vSSNjY9Vi1WIFhK5bITWvOCxhz
         jOrBj1mdUPxrnl8erGFCB3fI8JU03sKo7EJR3apAy7OD2coFI5yjscF30TTuGZ2Zcg
         2EPA2PN069RTYL2+tTeq3QG/nlBBrmAoSbxRZxyBir7SB6nMK8PCAUaECqil7gJNW7
         X29rSQIX6XK8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 18E765C1308; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 10/61] tools/nolibc/ctype: add the missing is* functions
Date:   Mon, 18 Apr 2022 17:41:34 -0700
Message-Id: <20220419004225.3952530-10-paulmck@kernel.org>
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

There was only isdigit, this commit adds the other ones.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/ctype.h | 79 +++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/ctype.h b/tools/include/nolibc/ctype.h
index 6735bd906f25..e3000b2992d7 100644
--- a/tools/include/nolibc/ctype.h
+++ b/tools/include/nolibc/ctype.h
@@ -13,10 +13,87 @@
  * As much as possible, please keep functions alphabetically sorted.
  */
 
+static __attribute__((unused))
+int isascii(int c)
+{
+	/* 0x00..0x7f */
+	return (unsigned int)c <= 0x7f;
+}
+
+static __attribute__((unused))
+int isblank(int c)
+{
+	return c == '\t' || c == ' ';
+}
+
+static __attribute__((unused))
+int iscntrl(int c)
+{
+	/* 0x00..0x1f, 0x7f */
+	return (unsigned int)c < 0x20 || c == 0x7f;
+}
+
 static __attribute__((unused))
 int isdigit(int c)
 {
-	return (unsigned int)(c - '0') <= 9;
+	return (unsigned int)(c - '0') < 10;
+}
+
+static __attribute__((unused))
+int isgraph(int c)
+{
+	/* 0x21..0x7e */
+	return (unsigned int)(c - 0x21) < 0x5e;
+}
+
+static __attribute__((unused))
+int islower(int c)
+{
+	return (unsigned int)(c - 'a') < 26;
+}
+
+static __attribute__((unused))
+int isprint(int c)
+{
+	/* 0x20..0x7e */
+	return (unsigned int)(c - 0x20) < 0x5f;
+}
+
+static __attribute__((unused))
+int isspace(int c)
+{
+	/* \t is 0x9, \n is 0xA, \v is 0xB, \f is 0xC, \r is 0xD */
+	return ((unsigned int)c == ' ') || (unsigned int)(c - 0x09) < 5;
+}
+
+static __attribute__((unused))
+int isupper(int c)
+{
+	return (unsigned int)(c - 'A') < 26;
+}
+
+static __attribute__((unused))
+int isxdigit(int c)
+{
+	return isdigit(c) || (unsigned int)(c - 'A') < 6 || (unsigned int)(c - 'a') < 6;
+}
+
+static __attribute__((unused))
+int isalpha(int c)
+{
+	return islower(c) || isupper(c);
+}
+
+static __attribute__((unused))
+int isalnum(int c)
+{
+	return isalpha(c) || isdigit(c);
+}
+
+static __attribute__((unused))
+int ispunct(int c)
+{
+	return isgraph(c) && !isalnum(c);
 }
 
 #endif /* _NOLIBC_CTYPE_H */
-- 
2.31.1.189.g2e36527f23

