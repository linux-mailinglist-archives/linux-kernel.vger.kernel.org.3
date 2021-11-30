Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75150463F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbhK3VB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbhK3U7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:24 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42364C061756
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:05 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 193so28348983qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUNKiXAWAUN4iwGd1SifU15/tpnbBkbe7AHAWWIr98E=;
        b=LZOCJPtLFSoau9EcU86RQxw58oHnh/zez1MbaQoz8cunHM+Voke9Ei6SME8kQiJnUO
         vMkc/D3ldOhwmMUhbHGR6kG0Dx9XnQu/n/aFHV0IxaKB4ndW0tH+q1bpn8n+nMsC5OIu
         YWVDhZkYUiceRNOFlyZ9wgX9gYY65nNo2Eq5o3XQn/IGR6UFmdgpe+GeeRiahOkB+CO1
         UcXs+rGeHG9qQUHlQ7XqZdv3vL+z/qksafwSCvmuQX8UQNvL2Lyfo1U457vLDqs/kTFl
         CuiFSYoQZ36StDp4athI/U4h30TsA8k/CIrPN9ymDPaHT30Hm7F9Av0QZX+KbMnRk2EX
         fENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUNKiXAWAUN4iwGd1SifU15/tpnbBkbe7AHAWWIr98E=;
        b=7DnoB3FWKxbWQsI4s53Ssf2462lBrOkFkNebprADY0XVEvVSBSWXmnNDfrer4u6q/S
         2UhDcXpmAjZP8wiSIuC8nXP1uigl13MHS5eAVoKY40RvvNvnO10pX9FyyJs7ygQW0Pqh
         njpFk1hC2UJIka9DNxW7He2NqiBmxpUGpZ89hxrsDS6zOs3WmtBzmmBn7WuqqdGQo3B4
         6+uOeJtQDtY5CNP9uxU5xP1m2WNSvaYIkzTSpnslKySWFEPZnVKoil+kXE6clEXNCI+o
         4qYQyrLmD4Kud6mwQRcotsh/D9U9RxO7j7tS+2mR2UGUZTI+r5rxzZ8oWIkZLjAXlqvS
         zPJA==
X-Gm-Message-State: AOAM533PIm5ibvAQLXH7gKg34PlatTkxKRc+XmdgHHdpFp0MEgII70pL
        pmgZKjUYsJ+yzRj/Q+QAEMObJ/rOhQ==
X-Google-Smtp-Source: ABdhPJzU1A91bXk3g7QJDMs9l7KNFgJ4BWSP+yTujnwwo7H0C2uHEtleIKd3wV9OzMh+ktHNCt/DTQ==
X-Received: by 2002:ae9:eb56:: with SMTP id b83mr1992350qkg.322.1638305764340;
        Tue, 30 Nov 2021 12:56:04 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id t11sm10549356qkp.56.2021.11.30.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:56:04 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 4/6] x86-64: Remove inverse relocations
Date:   Tue, 30 Nov 2021 15:55:47 -0500
Message-Id: <20211130205549.116673-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130205549.116673-1-brgerst@gmail.com>
References: <20211130205549.116673-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the percpu section is not at a fixed address, inverse
relocations (which were needed to offset the effects of relocation on
RIP-relative percpu references) are no longer used.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/boot/compressed/misc.c | 14 +-------------
 arch/x86/tools/relocs.c         |  9 ---------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index a4339cb2d247..5d0ffab408cd 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -215,7 +215,7 @@ static void handle_relocations(void *output, unsigned long output_len,
 
 	/*
 	 * Process relocations: 32 bit relocations first then 64 bit after.
-	 * Three sets of binary relocations are added to the end of the kernel
+	 * Two sets of binary relocations are added to the end of the kernel
 	 * before compression. Each relocation table entry is the kernel
 	 * address of the location which needs to be updated stored as a
 	 * 32-bit value which is sign extended to 64 bits.
@@ -225,8 +225,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 * kernel bits...
 	 * 0 - zero terminator for 64 bit relocations
 	 * 64 bit relocation repeated
-	 * 0 - zero terminator for inverse 32 bit relocations
-	 * 32 bit inverse relocation repeated
 	 * 0 - zero terminator for 32 bit relocations
 	 * 32 bit relocation repeated
 	 *
@@ -243,16 +241,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 		*(uint32_t *)ptr += delta;
 	}
 #ifdef CONFIG_X86_64
-	while (*--reloc) {
-		long extended = *reloc;
-		extended += map;
-
-		ptr = (unsigned long)extended;
-		if (ptr < min_addr || ptr > max_addr)
-			error("inverse 32-bit relocation outside of kernel!\n");
-
-		*(int32_t *)ptr -= delta;
-	}
 	for (reloc--; *reloc; reloc--) {
 		long extended = *reloc;
 		extended += map;
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b27980291ff8..e452b54ddaa1 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -28,7 +28,6 @@ struct relocs {
 static struct relocs relocs16;
 static struct relocs relocs32;
 #if ELF_BITS == 64
-static struct relocs relocs32neg;
 static struct relocs relocs64;
 #define FMT PRIu64
 #else
@@ -959,7 +958,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 	/* Order the relocations for more efficient processing */
 	sort_relocs(&relocs32);
 #if ELF_BITS == 64
-	sort_relocs(&relocs32neg);
 	sort_relocs(&relocs64);
 #else
 	sort_relocs(&relocs16);
@@ -991,13 +989,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 		/* Now print each relocation */
 		for (i = 0; i < relocs64.count; i++)
 			write_reloc(relocs64.offset[i], stdout);
-
-		/* Print a stop */
-		write_reloc(0, stdout);
-
-		/* Now print each inverse 32-bit relocation */
-		for (i = 0; i < relocs32neg.count; i++)
-			write_reloc(relocs32neg.offset[i], stdout);
 #endif
 
 		/* Print a stop */
-- 
2.31.1

