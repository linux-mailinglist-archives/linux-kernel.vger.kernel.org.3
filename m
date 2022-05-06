Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D651D775
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391281AbiEFMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbiEFMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:24:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080821900C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HSYqsfm/L8cEFT67qwt/B0OdeJkOEA6FwbUFh1hXWX8=; b=q0pSpo+oIqDrF1geN8hflRwUg8
        8aJkHHj+rRjaL8DYYghR8s/9JWizHXsogySF2zF0WWFbJDvnUcJHAZD0xq8qqICtD0gQ+Ps5r7wDa
        iOQMUfSzURZBb8M7CyIiC/DhPc1M2y7ORUf6eWBZAlrzU2z1j30jwzeWOeXhdU2gC/5jXUk2eFY3z
        URGo4vdyPxZHk1mBdUk1O9K+dl+83jmkMSWRUS1q14AwL2oYPj85iO3/p+dlTXW4NsjpM/pakZHU9
        NVogShqw0z/ae5rshzXg0fvdUBgaeJUdVCk4GM4oSqIVyil+LtpIJSjJwM2LWtUw9uWv4kBzOUlHE
        3SJ6C+uA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmwwU-00BfTa-Qk; Fri, 06 May 2022 12:20:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12362300776;
        Fri,  6 May 2022 14:20:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E22A720285CC0; Fri,  6 May 2022 14:20:15 +0200 (CEST)
Message-ID: <20220506121631.133110232@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 06 May 2022 14:14:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 1/6] x86/mm: Simplify RESERVE_BRK()
References: <20220506121431.563656641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

RESERVE_BRK() reserves data in the .brk_reservation section.  The data
is initialized to zero, like BSS, so the macro specifies 'nobits' to
prevent the data from taking up space in the vmlinux binary.  The only
way to get the compiler to do that (without putting the variable in .bss
proper) is to use inline asm.

The macro also has a hack which encloses the inline asm in a discarded
function, which allows the size to be passed (global inline asm doesn't
allow inputs).

Remove the need for the discarded function hack by just stringifying the
size rather than supplying it as an input to the inline asm.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/setup.h |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -109,27 +109,19 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within
- * the file, and somewhat descriptive.  The size is in bytes.  Must be
- * used at file scope.
+ * Reserve space in the brk section.  The name must be unique within the file,
+ * and somewhat descriptive.  The size is in bytes.
  *
- * (This uses a temp function to wrap the asm so we can pass it the
- * size parameter; otherwise we wouldn't be able to.  We can't use a
- * "section" attribute on a normal variable because it always ends up
- * being @progbits, which ends up allocating space in the vmlinux
- * executable.)
+ * The allocation is done using inline asm (rather than using a section
+ * attribute on a normal variable) in order to allow the use of @nobits, so
+ * that it doesn't take up any space in the vmlinux file.
  */
-#define RESERVE_BRK(name,sz)						\
-	static void __section(".discard.text") __noendbr __used notrace	\
-	__brk_reservation_fn_##name##__(void) {				\
-		asm volatile (						\
-			".pushsection .brk_reservation,\"aw\",@nobits;" \
-			".brk." #name ":"				\
-			" 1:.skip %c0;"					\
-			" .size .brk." #name ", . - 1b;"		\
-			" .popsection"					\
-			: : "i" (sz));					\
-	}
+#define RESERVE_BRK(name, size)						\
+	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
+	    ".brk." #name ":\n\t"					\
+	    ".skip " __stringify(size) "\n\t"				\
+	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
+	    ".popsection\n\t")
 
 extern void probe_roms(void);
 #ifdef __i386__


