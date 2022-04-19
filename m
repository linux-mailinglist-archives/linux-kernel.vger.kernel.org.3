Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739F506104
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiDSArH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794425E9C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C7B613E9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0394CC385C9;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=K5A+vpOw+gMJPPnE3pH6ctc1bGh1NtnOQPafpXQpXk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+cH/ltFT1MXYJrswJKMGHEfKR/Zd3T0nP2W6wHj/8v6StGnDMIsBTrercWNNWtyr
         ki77XVClE7g9O6+HbGWe7ZDibFsrgawqARdy6lJB8R+PaGYKGuw/qLb721ELod7Qkf
         7KimhQISKbgqiiZhoAPnyJh766r0mKrIrHioKOpD2Mm5gzUUskq0P9/njInO8eCNRD
         401EV/2FGjP3gfIx4ApT3+L0YcHcM2gkpxPf9TDPz2I6Ls+EdRy24vatHYya/DKLh5
         tX0RXDpc2VzCPy7leeramKdlkevHwkDnmFYpIxWJqEj7JQasm1HkcTu3XlMvT+KprA
         IyayHj2M+hvww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 25F295C30D2; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 17/61] tools/nolibc/stdlib: add utoh() and u64toh()
Date:   Mon, 18 Apr 2022 17:41:41 -0700
Message-Id: <20220419004225.3952530-17-paulmck@kernel.org>
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

This adds a pair of functions to emit hex values.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 80 +++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index d972871bf2ba..82a4cf606d3c 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -52,6 +52,46 @@ int atoi(const char *s)
 	return atol(s);
 }
 
+/* Converts the unsigned long integer <in> to its hex representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
+ * buffer is filled from the first byte, and the number of characters emitted
+ * (not counting the trailing zero) is returned. The function is constructed
+ * in a way to optimize the code size and avoid any divide that could add a
+ * dependency on large external functions.
+ */
+static __attribute__((unused))
+int utoh_r(unsigned long in, char *buffer)
+{
+	signed char pos = (~0UL > 0xfffffffful) ? 60 : 28;
+	int digits = 0;
+	int dig;
+
+	do {
+		dig = in >> pos;
+		in -= (uint64_t)dig << pos;
+		pos -= 4;
+		if (dig || digits || pos < 0) {
+			if (dig > 9)
+				dig += 'a' - '0' - 10;
+			buffer[digits++] = '0' + dig;
+		}
+	} while (pos >= 0);
+
+	buffer[digits] = 0;
+	return digits;
+}
+
+/* converts unsigned long <in> to an hex string using the static itoa_buffer
+ * and returns the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *utoh(unsigned long in)
+{
+	utoh_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
 /* Converts the unsigned long integer <in> to its string representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (21 bytes for 18446744073709551615 in 64-bit, 11 for
@@ -144,6 +184,46 @@ char *utoa(unsigned long in)
 	return itoa_buffer;
 }
 
+/* Converts the unsigned 64-bit integer <in> to its hex representation into
+ * buffer <buffer>, which must be long enough to store the number and the
+ * trailing zero (17 bytes for "ffffffffffffffff"). The buffer is filled from
+ * the first byte, and the number of characters emitted (not counting the
+ * trailing zero) is returned. The function is constructed in a way to optimize
+ * the code size and avoid any divide that could add a dependency on large
+ * external functions.
+ */
+static __attribute__((unused))
+int u64toh_r(uint64_t in, char *buffer)
+{
+	signed char pos = 60;
+	int digits = 0;
+	int dig;
+
+	do {
+		dig = in >> pos;
+		in -= (uint64_t)dig << pos;
+		pos -= 4;
+		if (dig || digits || pos < 0) {
+			if (dig > 9)
+				dig += 'a' - '0' - 10;
+			buffer[digits++] = '0' + dig;
+		}
+	} while (pos >= 0);
+
+	buffer[digits] = 0;
+	return digits;
+}
+
+/* converts uint64_t <in> to an hex string using the static itoa_buffer and
+ * returns the pointer to that string.
+ */
+static inline __attribute__((unused))
+char *u64toh(uint64_t in)
+{
+	u64toh_r(in, itoa_buffer);
+	return itoa_buffer;
+}
+
 /* Converts the unsigned 64-bit integer <in> to its string representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (21 bytes for 18446744073709551615). The buffer is filled from
-- 
2.31.1.189.g2e36527f23

