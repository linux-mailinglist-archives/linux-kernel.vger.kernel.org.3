Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148F506125
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiDSArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525D2A724
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C81661419
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7461EC36AE5;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=9N5Oy4zBAcINKzn6vYAORDvO50WX1cEVYblAMVZFE9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibuFo3TPCxEoITt/U7wvwza/+VR6Eup5U3XfE3bxHkRrVBLFivxRPYvO3Yh3Ach/w
         2AZ+BrxrDu8lu0YUXh8y1S0FpGi5dfEfy/xx7RkH72FTOKYK2McWnQbPnkZHzlsxW9
         EW/R7jmMjNuq5Mw4i/cxQEHPZ58K1Nw9ta+VGOWGqWLahP2fTTzuvxD3axFbw/sHkw
         AaIxDbPIaAPR8GvNJpl0r3T8djoibi9qCS1slrH63GY1/jk0Ick1NBku9CQMxmH4WU
         WnPSXNjXIDVQ+FS9dJLLzXzsKvmRNK9mZFx39upN3hj9mAcH/FP3iYWtfBQVf5xJ3s
         lJtlmA8pW2muA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5924E5C3233; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 45/61] tools/nolibc/stdio: add support for '%p' to vfprintf()
Date:   Mon, 18 Apr 2022 17:42:09 -0700
Message-Id: <20220419004225.3952530-45-paulmck@kernel.org>
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

%p remains quite useful in test code, and the code path can easily be
merged with the existing "%x" thus only adds ~50 bytes, thus let's
add it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdio.h | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 559ebe052a75..15dedf8d0902 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -163,7 +163,7 @@ char *fgets(char *s, int size, FILE *stream)
 
 
 /* minimal vfprintf(). It supports the following formats:
- *  - %[l*]{d,u,c,x}
+ *  - %[l*]{d,u,c,x,p}
  *  - %s
  *  - unknown modifiers are ignored.
  */
@@ -184,8 +184,12 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 		if (escape) {
 			/* we're in an escape sequence, ofs == 1 */
 			escape = 0;
-			if (c == 'c' || c == 'd' || c == 'u' || c == 'x') {
-				if (lpref) {
+			if (c == 'c' || c == 'd' || c == 'u' || c == 'x' || c == 'p') {
+				char *out = tmpbuf;
+
+				if (c == 'p')
+					v = va_arg(args, unsigned long);
+				else if (lpref) {
 					if (lpref > 1)
 						v = va_arg(args, unsigned long long);
 					else
@@ -202,18 +206,22 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 				}
 
 				switch (c) {
+				case 'c':
+					out[0] = v;
+					out[1] = 0;
+					break;
 				case 'd':
-					i64toa_r(v, tmpbuf);
+					i64toa_r(v, out);
 					break;
 				case 'u':
-					u64toa_r(v, tmpbuf);
-					break;
-				case 'x':
-					u64toh_r(v, tmpbuf);
+					u64toa_r(v, out);
 					break;
-				default: /* 'c' */
-					tmpbuf[0] = v;
-					tmpbuf[1] = 0;
+				case 'p':
+					*(out++) = '0';
+					*(out++) = 'x';
+					/* fall through */
+				default: /* 'x' and 'p' above */
+					u64toh_r(v, out);
 					break;
 				}
 				outstr = tmpbuf;
-- 
2.31.1.189.g2e36527f23

