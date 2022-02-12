Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FB4B351C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiBLNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:05:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiBLNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:05:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149826AF9;
        Sat, 12 Feb 2022 05:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 179DCB8068E;
        Sat, 12 Feb 2022 13:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C06FC340E7;
        Sat, 12 Feb 2022 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644671105;
        bh=I9zqqNz6a40jJe8Y6XJkwn3RA7u4Nik/c6hmRpvHBK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLXQ8rH60xZuvy6UTsfGsN5jE11beT/h7rKCUfCRPcc+KbcgkvKfwogoIIB92MrtR
         6edDfmM2CU3mqai9oepD2z9WxBlAfVl9+J22japM0izJA3TQjRloe64d5pGLUPdPhh
         IGjZWIW8vZc3N0kOUX0E9ZmSIzDs40uWHCATfoq3r+tNeYVcaKHnXONjtsnFDyNxSk
         E9j+hkd+jIu7btG/MO32BZ6SjLP9eUwNIq+25RF/Om0Kf7TQ6Ak19S5mx55pcebwUZ
         bC99FC6CfHwXn+rlMDX2RJB8HqbAHcaG0GNkPc64M/dAko6d5nvvLVCAWWWryx2xoC
         Ru/4xL6wtJ3HA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 01/20] kallsyms: support "big" kernel symbols
Date:   Sat, 12 Feb 2022 14:03:27 +0100
Message-Id: <20220212130410.6901-2-ojeda@kernel.org>
In-Reply-To: <20220212130410.6901-1-ojeda@kernel.org>
References: <20220212130410.6901-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rust symbols can become quite long due to namespacing introduced
by modules, types, traits, generics, etc.

Increasing to 255 is not enough in some cases, and therefore
we need to introduce longer lengths to the symbol table.

In order to avoid increasing all lengths to 2 bytes (since most
of them are small, including many Rust ones), we use ULEB128 to
keep smaller symbols in 1 byte, with the rest in 2 bytes.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 kernel/kallsyms.c  | 26 ++++++++++++++++++++++----
 scripts/kallsyms.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 951c93216fc4..57213e1d2349 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -69,12 +69,20 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 	data = &kallsyms_names[off];
 	len = *data;
 	data++;
+	off++;
+
+	/* If MSB is 1, it is a "big" symbol, so needs an additional byte. */
+	if ((len & 0x80) != 0) {
+		len = (len & 0x7F) | (*data << 7);
+		data++;
+		off++;
+	}
 
 	/*
 	 * Update the offset to return the offset for the next symbol on
 	 * the compressed stream.
 	 */
-	off += len + 1;
+	off += len;
 
 	/*
 	 * For every byte on the compressed symbol data, copy the table
@@ -127,7 +135,7 @@ static char kallsyms_get_symbol_type(unsigned int off)
 static unsigned int get_symbol_offset(unsigned long pos)
 {
 	const u8 *name;
-	int i;
+	int i, len;
 
 	/*
 	 * Use the closest marker we have. We have markers every 256 positions,
@@ -141,8 +149,18 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	 * so we just need to add the len to the current pointer for every
 	 * symbol we wish to skip.
 	 */
-	for (i = 0; i < (pos & 0xFF); i++)
-		name = name + (*name) + 1;
+	for (i = 0; i < (pos & 0xFF); i++) {
+		len = *name;
+
+		/*
+		 * If MSB is 1, it is a "big" symbol, so we need to look into
+		 * the next byte (and skip it, too).
+		 */
+		if ((len & 0x80) != 0)
+			len = ((len & 0x7F) | (name[1] << 7)) + 1;
+
+		name = name + len + 1;
+	}
 
 	return name - kallsyms_names;
 }
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 54ad86d13784..79b11bb7f07d 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -470,12 +470,35 @@ static void write_src(void)
 		if ((i & 0xFF) == 0)
 			markers[i >> 8] = off;
 
-		printf("\t.byte 0x%02x", table[i]->len);
+		/* There cannot be any symbol of length zero. */
+		if (table[i]->len == 0) {
+			fprintf(stderr, "kallsyms failure: "
+				"unexpected zero symbol length\n");
+			exit(EXIT_FAILURE);
+		}
+
+		/* Only lengths that fit in up-to-two-byte ULEB128 are supported. */
+		if (table[i]->len > 0x3FFF) {
+			fprintf(stderr, "kallsyms failure: "
+				"unexpected huge symbol length\n");
+			exit(EXIT_FAILURE);
+		}
+
+		/* Encode length with ULEB128. */
+		if (table[i]->len <= 0x7F) {
+			/* Most symbols use a single byte for the length. */
+			printf("\t.byte 0x%02x", table[i]->len);
+			off += table[i]->len + 1;
+		} else {
+			/* "Big" symbols use two bytes. */
+			printf("\t.byte 0x%02x, 0x%02x",
+				(table[i]->len & 0x7F) | 0x80,
+				(table[i]->len >> 7) & 0x7F);
+			off += table[i]->len + 2;
+		}
 		for (k = 0; k < table[i]->len; k++)
 			printf(", 0x%02x", table[i]->sym[k]);
 		printf("\n");
-
-		off += table[i]->len + 1;
 	}
 	printf("\n");
 
-- 
2.35.1

