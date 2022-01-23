Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC10496F97
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 02:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiAWB61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 20:58:27 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:32077 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiAWB60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 20:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1642903106; x=1674439106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=acgAkle8xoBTvtH1UMjY/cNHDObGSDA6DvWE/JyvkgM=;
  b=QTSmhUc48jdi2i0i+LIZVFdgjihn45HH+U5Eyn/PCe8Z7Y5AiZXtX3+h
   W+B0Qr4pwnwffiPp8hSqvKI52454seVgbIyll8QQW7oqIRgyZFzR9g4lz
   fPIWIe3jXA4UP+LutYZ9nROKiMa/x7XtP4fTN5R4HeqFbLTW72axKJF01
   0=;
X-IronPort-AV: E=Sophos;i="5.88,309,1635206400"; 
   d="scan'208";a="986676307"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-9ec26c6c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 23 Jan 2022 01:58:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-9ec26c6c.us-west-2.amazon.com (Postfix) with ESMTPS id 4552F419CB;
        Sun, 23 Jan 2022 01:58:25 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 23 Jan 2022 01:58:24 +0000
Received: from 88665a182662.ant.amazon.com (10.43.161.142) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 23 Jan 2022 01:58:15 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/boot: Avoid redundant address overlap tests in memcpy().
Date:   Sun, 23 Jan 2022 10:58:07 +0900
Message-ID: <20220123015807.45005-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.142]
X-ClientProxiedBy: EX13D49UWC002.ant.amazon.com (10.43.162.215) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'dest' and 'src' overlap, the boot time memcpy() calls memmove(),
which tests the same condition again.  GCC does not optimise it for now.
Let's split the copy part of memmove() as ____memmove() and call it from
memcpy().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 arch/x86/boot/compressed/string.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1eaa3..4c0edb5d6 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -50,26 +50,31 @@ void *memset(void *s, int c, size_t n)
 	return s;
 }
 
-void *memmove(void *dest, const void *src, size_t n)
+void *____memmove(void *dest, const void *src, size_t n)
 {
 	unsigned char *d = dest;
 	const unsigned char *s = src;
 
-	if (d <= s || d - s >= n)
-		return ____memcpy(dest, src, n);
-
 	while (n-- > 0)
 		d[n] = s[n];
 
 	return dest;
 }
 
-/* Detect and warn about potential overlaps, but handle them with memmove. */
+void *memmove(void *dest, const void *src, size_t n)
+{
+	if (dest <= src || dest - src >= n)
+		return ____memcpy(dest, src, n);
+
+	return ____memmove(dest, src, n);
+}
+
+/* Detect and warn about potential overlaps, but handle them with ____memmove(). */
 void *memcpy(void *dest, const void *src, size_t n)
 {
 	if (dest > src && dest - src < n) {
 		warn("Avoiding potentially unsafe overlapping memcpy()!");
-		return memmove(dest, src, n);
+		return ____memmove(dest, src, n);
 	}
 	return ____memcpy(dest, src, n);
 }
-- 
2.30.2

