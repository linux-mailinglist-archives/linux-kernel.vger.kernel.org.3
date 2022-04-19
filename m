Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8B50611A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiDSAqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF0F29C8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C3061381
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035C6C385C6;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=iw7VZyIxYEox+Zw4JuU45s1lfP7xk4LgcftYhKIrPlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPItQFmbzPlA5jZo000s6d9Oiz4Wh7CUfuOkVaGnUD8VZNiNVGC+qnlgc4T2Tu0Xn
         RYACcanQJCwNQOTg6wdqvMwZMzLVLm4ji/MQ4PZLMmkRi5q4r8Ls5BRUSkh8RwG3yp
         o5SE+ha3ShtkPA4aZjyR/C3DlVtK/GhgapxQu+TGNIZ5Nomu+ZwoWF37T6FCZny6F6
         OIuBs73WGEnTqLwaF/InhtehpTrFCatk2yebFoyFstutizE2pWM7eVm9b+iVwlADuv
         7vhwYA7f/BkoZOr/mCZkl+stVTyeRkzbDRVsHs7XA8yYBcWAidkgUVWyRmTUg83ops
         IyExhjAGz+7Jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 23FD15C2DF5; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 16/61] tools/nolibc/stdlib: add i64toa() and u64toa()
Date:   Mon, 18 Apr 2022 17:41:40 -0700
Message-Id: <20220419004225.3952530-16-paulmck@kernel.org>
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

These are 64-bit variants of the itoa() and utoa() functions. They also
support reentrant ones, and use the same itoa_buffer. The functions are
a bit larger than the previous ones in 32-bit mode (86 and 98 bytes on
x86_64 and armv7 respectively), which is why we continue to provide them
as separate functions.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index dbb45631c7ca..d972871bf2ba 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -144,6 +144,78 @@ char *utoa(unsigned long in)
 	return itoa_buffer;
 }
 
+/* Converts the unsigned 64-bit integer <in> to its string representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (21 bytes for 18446744073709551615). The buffer is filled from
+ * the first byte, and the number of characters emitted (not counting the
+ * trailing zero) is returned. The function is constructed in a way to optimize
+ * the code size and avoid any divide that could add a dependency on large
+ * external functions.
+ */
+static __attribute__((unused))
+int u64toa_r(uint64_t in, char *buffer)
+{
+	unsigned long long lim;
+	int digits = 0;
+	int pos = 19; /* start with the highest possible digit */
+	int dig;
+
+	do {
+		for (dig = 0, lim = 1; dig < pos; dig++)
+			lim *= 10;
+
+		if (digits || in >= lim || !pos) {
+			for (dig = 0; in >= lim; dig++)
+				in -= lim;
+			buffer[digits++] = '0' + dig;
+		}
+	} while (pos--);
+
+	buffer[digits] = 0;
+	return digits;
+}
+
+/* Converts the signed 64-bit integer <in> to its string representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (21 bytes for -9223372036854775808). The buffer is filled from
+ * the first byte, and the number of characters emitted (not counting the
+ * trailing zero) is returned.
+ */
+static __attribute__((unused))
+int i64toa_r(int64_t in, char *buffer)
+{
+	char *ptr = buffer;
+	int len = 0;
+
+	if (in < 0) {
+		in = -in;
+		*(ptr++) = '-';
+		len++;
+	}
+	len += u64toa_r(in, ptr);
+	return len;
+}
+
+/* converts int64_t <in> to a string using the static itoa_buffer and returns
+ * the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *i64toa(int64_t in)
+{
+	i64toa_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
+/* converts uint64_t <in> to a string using the static itoa_buffer and returns
+ * the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *u64toa(uint64_t in)
+{
+	u64toa_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
 static __attribute__((unused))
 int msleep(unsigned int msecs)
 {
-- 
2.31.1.189.g2e36527f23

