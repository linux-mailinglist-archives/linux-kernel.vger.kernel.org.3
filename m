Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB3513C50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbiD1UH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiD1UH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22F29BF946
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651176281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eHZWLEclhf29kIZyh1gGmmJ7MYLM4Nno1XkZrn7Hc/Y=;
        b=Ugo5Oo4yp5io+ve2nKNKZRbIYvIOnHsyaqjD+2B7yDo9RNg9Z42s1AIiu1liJpNzaqid5Y
        NbsUJK/UMjjGa/H+27VmQSO7EcYLfFhdN9kS6sz1i6DB5FHCoO7pun8WNT1+dj35DLI1Ml
        3WV3lqNz3WQ3zXkOe8SN9FeqrJuQ2WE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-R0XpHcEDOi6turp-tuLw9A-1; Thu, 28 Apr 2022 16:04:39 -0400
X-MC-Unique: R0XpHcEDOi6turp-tuLw9A-1
Received: by mail-qt1-f198.google.com with SMTP id o2-20020ac86982000000b002f1d71c97b8so4148019qtq.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHZWLEclhf29kIZyh1gGmmJ7MYLM4Nno1XkZrn7Hc/Y=;
        b=saTp2SFXuSOq2BIzcZQrUG3/jIDcpPXsQ6kBUIagZyW5nyofA3a5iUCvTHoL1WAEkj
         XKwNW7KzmIGuhvwP05BmwWoUKmYeZP05uEtCSDPqlChd07HniISO6q4U6udCrs4KwuKo
         NS4p0jYEZ1zul/6qQIshNa69jvNShqnblUIvaRgvpxGkGtTvsImbN+oV83P2oVZr9E4r
         7XauN83Z5KHJW5TBzvq41xsbpVawvpY4pBSRzcJk1N7QAyIzbIOrr81HoFvpUU31JPKL
         RyCVOKhKsNlTmVlUI9RcwMV8YlD4rcFDY4E0SfjBTSbE+3dzBnXiX6T+9Uv0kwu9MzY0
         xD6Q==
X-Gm-Message-State: AOAM533ZgKd+VjvhjwoRgZhQANmRyKsRje4wdf7jXqpb1B+JTh10vYpH
        +36MLDoJs/WEGbVLT8OATzfmGcwoUHDLQ3cBEqSrwmxgRFtfO3YQnLwq9w1y3Pfbohvp5JzkqMx
        b/PW670rX5If4kZwmUpG3sV3/
X-Received: by 2002:a05:620a:4494:b0:69f:8836:8d0a with SMTP id x20-20020a05620a449400b0069f88368d0amr7924767qkp.742.1651176278945;
        Thu, 28 Apr 2022 13:04:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+i66/kajM5A84yUVBqlRcfbDwfqWVqYG9IR4hBKDqDRm8si8FWNnw7GUOmDAsW+79SVwxGw==
X-Received: by 2002:a05:620a:4494:b0:69f:8836:8d0a with SMTP id x20-20020a05620a449400b0069f88368d0amr7924755qkp.742.1651176278701;
        Thu, 28 Apr 2022 13:04:38 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a044e00b002f3656df6f6sm523505qtx.78.2022.04.28.13.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 13:04:38 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/mm: Simplify RESERVE_BRK()
Date:   Thu, 28 Apr 2022 13:04:25 -0700
Message-Id: <0e001c79794c46d619714d122c262147ed83f658.1651176151.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/setup.h | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a1b107f2a12a..7590ac2570b9 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -108,27 +108,19 @@ extern unsigned long _brk_end;
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
-- 
2.34.1

