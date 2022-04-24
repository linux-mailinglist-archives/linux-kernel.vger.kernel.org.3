Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6750D52D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiDXU5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 16:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiDXU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92E3154FA1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650833664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DHCWz0NT7/oap0KtY1nMcbeGh8Z12KZ0bXl9rYv24JM=;
        b=KrrxVrO8PP+RV4+NSbSUQBObC+4rmxqWT3yXwTCyr8tbJi+7+ZcryYvNwsdV4VZLGvG244
        ShzVcD+Oo+9mNdlkNLvfiRUuM2W7CwVXoLlMRR0KvevsN4NRfPqGgz0XePGYUX+ewYPo5W
        2jciOY4H5AsyCmT1mb4AixreOecm8qg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-QKTgqLN-OMGNQNcJFbt0Wg-1; Sun, 24 Apr 2022 16:54:20 -0400
X-MC-Unique: QKTgqLN-OMGNQNcJFbt0Wg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6892101AA45;
        Sun, 24 Apr 2022 20:54:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6311A4087D9C;
        Sun, 24 Apr 2022 20:54:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23OKsJ9h019671;
        Sun, 24 Apr 2022 16:54:19 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23OKsIPc019666;
        Sun, 24 Apr 2022 16:54:18 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 24 Apr 2022 16:54:18 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>
cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] hex2bin: make the function hex_to_bin constant-time
Message-ID: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hex2bin is used to load cryptographic keys into device mapper
targets dm-crypt and dm-integrity. It should take constant time
independent on the processed data, so that concurrently running
unprivileged code can't infer any information about the keys via
microarchitectural convert channels.

This patch changes the function hex_to_bin so that it contains no branches
and no memory accesses.

Note that this shouldn't cause performance degradation because the size of
the new function is the same as the size of the old function (on x86-64) -
and the new function causes no branch misprediction penalties.

I compile-tested this function with gcc on aarch64 alpha arm hppa hppa64
i386 ia64 m68k mips32 mips64 powerpc powerpc64 riscv sh4 s390x sparc32
sparc64 x86_64 and with clang on aarch64 arm hexagon i386 mips32 mips64
powerpc powerpc64 s390x sparc32 sparc64 x86_64 to verify that there are no
branches in the generated code.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 lib/hexdump.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

Index: linux-2.6/lib/hexdump.c
===================================================================
--- linux-2.6.orig/lib/hexdump.c	2022-04-24 18:51:20.000000000 +0200
+++ linux-2.6/lib/hexdump.c	2022-04-24 18:51:20.000000000 +0200
@@ -22,15 +22,30 @@ EXPORT_SYMBOL(hex_asc_upper);
  *
  * hex_to_bin() converts one hex digit to its actual value or -1 in case of bad
  * input.
+ *
+ * This function is used to load cryptographic keys, so it is coded in such a
+ * way that there are no conditions or memory accesses that depend on data.
+ *
+ * Explanation of the logic:
+ * (ch - '9' - 1) is negative if ch <= '9'
+ * ('0' - 1 - ch) is negative if ch >= '0'
+ * we "and" these two values, so the result is negative if ch is in the range
+ *	'0' ... '9'
+ * we are only interested in the sign, so we do a shift ">> 8" --- we have -1 if
+ *	ch is in the range '0' ... '9', 0 otherwise
+ * we "and" this value with (ch - '0' + 1) --- we have a value 1 ... 10 if ch is
+ *	in the range '0' ... '9', 0 otherwise
+ * we add this value to -1 --- we have a value 0 ... 9 if ch is in the range '0'
+ *	... '9', -1 otherwise
+ * the next line is similar to the previous one, but we need to decode both
+ *	uppercase and lowercase letters, so we use (ch & 0xdf), which converts
+ *	lowercase to uppercase
  */
 int hex_to_bin(char ch)
 {
-	if ((ch >= '0') && (ch <= '9'))
-		return ch - '0';
-	ch = tolower(ch);
-	if ((ch >= 'a') && (ch <= 'f'))
-		return ch - 'a' + 10;
-	return -1;
+	return -1 +
+		((ch - '0' + 1) & (((ch - '9' - 1) & ('0' - 1 - ch)) >> 8)) +
+		(((ch & 0xdf) - 'A' + 11) & ((((ch & 0xdf) - 'F' - 1) & ('A' - 1 - (ch & 0xdf))) >> 8));
 }
 EXPORT_SYMBOL(hex_to_bin);
 

