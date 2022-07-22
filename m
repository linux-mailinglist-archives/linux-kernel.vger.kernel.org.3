Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB057E22C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiGVNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:19:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F7A0257
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:19:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA37D374B5;
        Fri, 22 Jul 2022 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658495977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KrGoc2Vun/9e4eTJmeJ025qkk25JgKacUbd13yUyq14=;
        b=P5HfKlNEvivcXN3MgIY3+wDKgVBpZxZ1UYgL3Fd0kuV3OfK4ds2A8gIGG/C0CxTd9m8BOg
        GfcMwA+InZDc+KUr09sVHpFeWAxG6MM6ZDL7qH7pINwTD4LpZlTxIqlcf08LwUXiUA9+qr
        apV8a7lzOl3ebanHYcBVBm3e/IzM74g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80B0B13AB3;
        Fri, 22 Jul 2022 13:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gl2dHOmj2mJ3UAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Jul 2022 13:19:37 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, agruenba@redhat.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] iov_iter: Microoptimize fault_in_iov_iter_(writable|readable)
Date:   Fri, 22 Jul 2022 16:19:32 +0300
Message-Id: <20220722131932.3453128-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inverting the condition inside the 2 functions results in reduced nesting
as well as saving 20 bytes of generated codeu as well as eliminating a mandatory
branch when a proper userspace iov iter is passed:

add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-20 (-20)
Function                                     old     new   delta
fault_in_iov_iter_writeable                  131     121     -10
fault_in_iov_iter_readable                   131     121     -10

That's because in the original version the compiler duplicates the
function epilogue right after the initial branch, resulting in the
following code:

0x000000000000081c <+12>:    je     0x828 <fault_in_iov_iter_readable+24>
0x000000000000081e <+14>:    pop    %rbx
0x000000000000081f <+15>:    mov    %r12,%rax
0x0000000000000822 <+18>:    pop    %rbp
0x0000000000000823 <+19>:    pop    %r12
0x0000000000000825 <+21>:    pop    %r13
0x0000000000000827 <+23>:    retq
0x0000000000000828 <+24>:    cmp    %rsi,0x10(%rdi) ;loop begins

There is always a branch penalty before actual executioni begins,
whilst with this patch the generated code is:

0x00000000000004ac <+12>:    jne    0x507 <fault_in_iov_iter_readable+103>
0x00000000000004ae <+14>:    cmp    %rsi,0x10(%rdi)

The branch is taken only when the passed in iter is not an iovec

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 lib/iov_iter.c | 76 +++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0b64695ab632..897148d9cd12 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -443,26 +443,26 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
  */
 size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
 {
-	if (iter_is_iovec(i)) {
-		size_t count = min(size, iov_iter_count(i));
-		const struct iovec *p;
-		size_t skip;
-
-		size -= count;
-		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
-			size_t len = min(count, p->iov_len - skip);
-			size_t ret;
-
-			if (unlikely(!len))
-				continue;
-			ret = fault_in_readable(p->iov_base + skip, len);
-			count -= len - ret;
-			if (ret)
-				break;
-		}
-		return count + size;
+	size_t count = min(size, iov_iter_count(i));
+	const struct iovec *p;
+	size_t skip;
+
+	if (!iter_is_iovec(i))
+		return 0;
+
+	size -= count;
+	for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
+		size_t len = min(count, p->iov_len - skip);
+		size_t ret;
+
+		if (unlikely(!len))
+			continue;
+		ret = fault_in_readable(p->iov_base + skip, len);
+		count -= len - ret; // reduce count by the number faulted in
+		if (ret)
+			break;
 	}
-	return 0;
+	return count + size;
 }
 EXPORT_SYMBOL(fault_in_iov_iter_readable);

@@ -482,26 +482,26 @@ EXPORT_SYMBOL(fault_in_iov_iter_readable);
  */
 size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
 {
-	if (iter_is_iovec(i)) {
-		size_t count = min(size, iov_iter_count(i));
-		const struct iovec *p;
-		size_t skip;
-
-		size -= count;
-		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
-			size_t len = min(count, p->iov_len - skip);
-			size_t ret;
-
-			if (unlikely(!len))
-				continue;
-			ret = fault_in_safe_writeable(p->iov_base + skip, len);
-			count -= len - ret;
-			if (ret)
-				break;
-		}
-		return count + size;
+	size_t count = min(size, iov_iter_count(i));
+	const struct iovec *p;
+	size_t skip;
+
+	if (!iter_is_iovec(i))
+		return 0;
+
+	size -= count;
+	for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
+		size_t len = min(count, p->iov_len - skip);
+		size_t ret;
+
+		if (unlikely(!len))
+			continue;
+		ret = fault_in_safe_writeable(p->iov_base + skip, len);
+		count -= len - ret;
+		if (ret)
+			break;
 	}
-	return 0;
+	return count + size;
 }
 EXPORT_SYMBOL(fault_in_iov_iter_writeable);

--
2.25.1

