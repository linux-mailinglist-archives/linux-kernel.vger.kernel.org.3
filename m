Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2924B17BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiBJVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:40:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344714AbiBJVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:40:32 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD58C26C2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:32 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so8045939ooi.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxLurPe5gtmMACmwYrmQ7RV4VZQpgtW/wJpQ92EZaMA=;
        b=ZGAexjLB1fsWd1qu3I8dybz0nQgpssACPs0RnY+Wbrn6/mWSSoTmwXtMt9tNeO8Fkc
         0I+n/5SG7WgyBJUEanBaXBjICX1pVeCelvfL/q4Xt/QFRo37bcM9/PxgLviQdD4zbMFl
         5h58IG8lVAZ1J6bPIwLAp9BJ1/w8D8iX9uPpIWgrmAisAvF8kDTVY/Xx6EKmp+kqXapJ
         fs2it4qhJDundsIeMW62C6Djp0MgjOappTSv95/++s+Vlh1846suJzz2o+PBfhgkUTN7
         iO9VjOWP46FjzScJjuh2v27wQaujMWU43ViE7bryqlB+xX/DBpouqO0D986eCoGCFBrP
         0MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxLurPe5gtmMACmwYrmQ7RV4VZQpgtW/wJpQ92EZaMA=;
        b=Ippm+8rGwXd/wyhwTkylfL6yli3qcMoGN1eEASaZXNw9zsoQkDDYmFj15RO/W0pIXs
         3WyMcf6pB6eVnqfr65jrITrubft9gHKl9WQN7Ck+3dTFdGbLxIHWZcwhB5YH9HuN68xP
         LY+EW/P5YPoOqIx+3KQHi5hSbb4PgsF3aFpbQH0Ci0khi074Ayai0GUs6ZKtx6TbIHsx
         bWndvlRkVAn0BVffouIm6u7aSMr1ugg0AIVxd0oOouRsBiKfle2rFU1EQvHj3XiSjdBZ
         HqdhRy9cd5vm7gzUOqMq+MdLbTX0+vTuqHLDxSZIyu/QHLD7rrVMkRppfjhujPe42HOG
         ZjdQ==
X-Gm-Message-State: AOAM532gXSDnyhvRKFNM/1sc2RB8MwPFJNze1BWFI0U+GWX+yBY6KW7s
        XpjmFuBtyhPD/0wYHxqO05GC8ZG8W1fRlikA
X-Google-Smtp-Source: ABdhPJwAVQp1nDJtdS+/A4GMweHMJUn2o2jysgwreocFk+ixOF7CGDbCRGXOrigMVd948zf4+Dd27g==
X-Received: by 2002:a05:6870:5a8c:: with SMTP id dt12mr1460469oab.327.1644529232021;
        Thu, 10 Feb 2022 13:40:32 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id u5sm8700000ooo.46.2022.02.10.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:40:31 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/6] RISC-V: Minimal parser for "riscv, isa" strings
Date:   Thu, 10 Feb 2022 13:40:14 -0800
Message-Id: <20220210214018.55739-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210214018.55739-1-atishp@rivosinc.com>
References: <20220210214018.55739-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tsukasa OI <research_trasio@irq.a4lg.com>

Current hart ISA ("riscv,isa") parser don't correctly parse:

1. Multi-letter extensions
2. Version numbers

All ISA extensions ratified recently has multi-letter extensions
(except 'H'). The current "riscv,isa" parser that is easily confused
by multi-letter extensions and "p" in version numbers can be a huge
problem for adding new extensions through the device tree.

Leaving it would create incompatible hacks and would make "riscv,isa"
value unreliable.

This commit implements minimal parser for "riscv,isa" strings.  With this,
we can safely ignore multi-letter extensions and version numbers.

Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
[Improved commit text and fixed a bug around 's' in base extension]
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 67 ++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index dd3d57eb4eea..e19ae4391a9b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/ctype.h>
 #include <linux/of.h>
 #include <asm/processor.h>
 #include <asm/hwcap.h>
@@ -66,7 +67,7 @@ void __init riscv_fill_hwcap(void)
 	struct device_node *node;
 	const char *isa;
 	char print_str[NUM_ALPHA_EXTS + 1];
-	size_t i, j, isa_len;
+	int i, j;
 	static unsigned long isa2hwcap[256] = {0};
 
 	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
@@ -92,23 +93,67 @@ void __init riscv_fill_hwcap(void)
 			continue;
 		}
 
-		i = 0;
-		isa_len = strlen(isa);
 #if IS_ENABLED(CONFIG_32BIT)
 		if (!strncmp(isa, "rv32", 4))
-			i += 4;
+			isa += 4;
 #elif IS_ENABLED(CONFIG_64BIT)
 		if (!strncmp(isa, "rv64", 4))
-			i += 4;
+			isa += 4;
 #endif
-		for (; i < isa_len; ++i) {
-			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
+		for (; *isa; ++isa) {
+			const char *ext = isa++;
+			bool ext_long, ext_err = false;
+
+			switch (*ext) {
+			case 's':
+			case 'x':
+			case 'z':
+				/**
+				 * 's' is a special case because:
+				 * It can be present in base extension for supervisor
+				 * Multi-letter extensions can start with 's' as well for
+				 * Supervisor extensions (i.e. sstc, sscofpmf, svinval)
+				 */
+				if (*ext == 's' && ext[-1] != '_')
+					break;
+				ext_long = true;
+				/* Multi-letter extension must be delimited */
+				for (; *isa && *isa != '_'; ++isa)
+					if (!islower(*isa) && !isdigit(*isa))
+						ext_err = true;
+				/* ... but must be ignored. */
+				break;
+			default:
+				ext_long = false;
+				if (!islower(*ext)) {
+					ext_err = true;
+					break;
+				}
+				/* Find next extension */
+				if (!isdigit(*isa))
+					break;
+				while (isdigit(*++isa))
+					;
+				if (*isa != 'p')
+					break;
+				if (!isdigit(*++isa)) {
+					--isa;
+					break;
+				}
+				while (isdigit(*++isa))
+					;
+				break;
+			}
+			if (*isa != '_')
+				--isa;
 			/*
-			 * TODO: X, Y and Z extension parsing for Host ISA
-			 * bitmap will be added in-future.
+			 * TODO: Full version-aware handling including
+			 * multi-letter extensions will be added in-future.
 			 */
-			if ('a' <= isa[i] && isa[i] < 'x')
-				this_isa |= (1UL << (isa[i] - 'a'));
+			if (ext_err || ext_long)
+				continue;
+			this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
+			this_isa |= (1UL << (*ext - 'a'));
 		}
 
 		/*
-- 
2.30.2

