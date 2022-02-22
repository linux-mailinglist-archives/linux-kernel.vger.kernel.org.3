Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D94C0348
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiBVUs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiBVUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:48:52 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56DA2F2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:27 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso19383651oon.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FsTSrbVAURtuc7icXoc7CnjlReAr0UpIVXQMIlDTc4=;
        b=6a+eX7j3LCyMn7OaC5yvtENFql8mK7SDDMa4RtV1aQ93fAn5DduP6Fgc7zUxkNDPTK
         2f5BEhyv8QBUUnYojgoP9I+MJqoziATEH1PvK8x/8t7oxNPO0/tcxhlAJGfxpsv2ELxp
         nfu2dWei93dbF37AOXHaYScoVk4bCNOoDm8lnsSjeyt2iYjkkidiwnvv/dGi5PNu1x2R
         68xEWUesACbG6mjSkozJilU0wLtHje/Ch7BosK/ew81mgyEbv8fsSfyEZnHa/tvVCuWn
         NihWa3DT/You12J90LfMjxx/hnQY9P/qyn3SO5SeuXy/X83tM5KGyBCAF4sPu+G1sY0j
         nLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FsTSrbVAURtuc7icXoc7CnjlReAr0UpIVXQMIlDTc4=;
        b=cU3tz6v7NdygR1s6iJUzmyoStRiCEyFp79/pb6wflfIfTQExwxie74bMs8YupzXAEe
         JDfXWAuTWmXqnbfeC5c2iYsZWS/9lYS1Ri0J0JmIRpF9EjkxOtZ/wwV4K1ct6sXCAxBS
         5x7/W7zutUsjju5QNDhG06LHeUGLzzmpJLNFljVu/TxySCYgXiXA2euAEODmZSTJKPhO
         wCeXnOy7tQnSTj+fQlgPdjbOQ58H6RLpUQMIh0+oONRliJuNHh6jYpBJPZN74gljG1Gg
         JF/GuMKhpKjqomy3pEzUHaedu0H2TwCigMy4wBxPTI5sW30OhFHlK7b9/Vedona0n+oJ
         l7pA==
X-Gm-Message-State: AOAM530XY+sqjCDiJKEpT/C0ocs2XFZLY3/gKUyYCN9q4xeMMKZt9TLV
        8wnTvNJqceGTgmJHLpvgVXBAhdd+zA+H0g==
X-Google-Smtp-Source: ABdhPJwVNKQnkJZdZ0jgSou92auChtzBu1r7KPJtir+JSZM/M01cC0DkREbbPZe7LjE4CO/652m/yQ==
X-Received: by 2002:a05:6870:d88e:b0:d1:359a:29f with SMTP id dv14-20020a056870d88e00b000d1359a029fmr2644172oab.232.1645562906164;
        Tue, 22 Feb 2022 12:48:26 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id o14sm16508197oaq.37.2022.02.22.12.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:48:25 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
Subject: [PATCH v5 2/6] RISC-V: Minimal parser for "riscv, isa" strings
Date:   Tue, 22 Feb 2022 12:48:07 -0800
Message-Id: <20220222204811.2281949-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222204811.2281949-1-atishp@rivosinc.com>
References: <20220222204811.2281949-1-atishp@rivosinc.com>
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

[Improved commit text and fixed a bug around 's' in base extension]
Signed-off-by: Atish Patra <atishp@rivosinc.com>
[Fixed workaround for QEMU]
Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/cpufeature.c | 72 ++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index dd3d57eb4eea..72c5f6ef56b5 100644
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
@@ -92,23 +93,72 @@ void __init riscv_fill_hwcap(void)
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
+			const char *ext_end = isa;
+			bool ext_long = false, ext_err = false;
+
+			switch (*ext) {
+			case 's':
+				/**
+				 * Workaround for invalid single-letter 's' & 'u'(QEMU).
+				 * No need to set the bit in riscv_isa as 's' & 'u' are
+				 * not valid ISA extensions. It works until multi-letter
+				 * extension starting with "Su" appears.
+				 */
+				if (ext[-1] != '_' && ext[1] == 'u') {
+					++isa;
+					ext_err = true;
+					break;
+				}
+				fallthrough;
+			case 'x':
+			case 'z':
+				ext_long = true;
+				/* Multi-letter extension must be delimited */
+				for (; *isa && *isa != '_'; ++isa)
+					if (!islower(*isa) && !isdigit(*isa))
+						ext_err = true;
+				break;
+			default:
+				if (unlikely(!islower(*ext))) {
+					ext_err = true;
+					break;
+				}
+				/* Find next extension */
+				if (!isdigit(*isa))
+					break;
+				/* Skip the minor version */
+				while (isdigit(*++isa))
+					;
+				if (*isa != 'p')
+					break;
+				if (!isdigit(*++isa)) {
+					--isa;
+					break;
+				}
+				/* Skip the major version */
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

