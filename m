Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230BF4D8E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiCNUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245070AbiCNUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:40:15 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AAB39BB0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:05 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kl20so13474272qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FsTSrbVAURtuc7icXoc7CnjlReAr0UpIVXQMIlDTc4=;
        b=OaQVvtun4w2HGIP+NbUQehl+w1J2Tio2m55d4PUY1yEeMnN6smYhUOucavK9Lb9jcS
         PUpyUt82BEQRMi6ySCQkdOVHZb75cvBnPso9NGN9fQ3YoaGNcmbXqldzbaEzJHbpuY2z
         ka0zMpMCr4RMho5FRue3gRVZIu6yx/Ash8Q5Ds6KL/mKeeGzi1x7zs0IY9dgOHglRYDg
         2x6dSDnK/i6KZ1KjpFXhRPUA3LnQQQqp0pL68/WvLXe0sXvPosfdui0YLyTHTeXVogB0
         wSpo2eRqLgE7j2fiFS4Q11apKs+B4bl7QDTD9LmRAwBcrd2B4ab9YSWRlmv4/MxU70XE
         bjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FsTSrbVAURtuc7icXoc7CnjlReAr0UpIVXQMIlDTc4=;
        b=jpXXmXTjh8CGSIwIwgeHOMMii7aeTv3gZURHa9Toa6U4kYF3xeI0gY2VRKHxSWXXYV
         dGrXi4kqUhOH18Q7slDsV8K1TL44AM483IZJN4FjW80YuLW+vRxEk8K377xNNfPMQgWh
         2rsIBnYpyG0yMBbfY7kszWedEp0MinFE0/FKRLNb+Iu/Des+Ksw2y/T9GGDFtRRnYlBa
         0MspuMGLlMKdgHs7TATv24gRK1LmSSbHWsYxkpctzGc35X5NGeInXllg+Wda1Z0CEfvL
         838mzw0nKi2FHObiLcQsIm4Chi6C5e1VLfqah8zW1XOUBf9/mCvIBVVyiBs4OVM1hCqc
         Ss6A==
X-Gm-Message-State: AOAM530j+CVUZuOvsQAwL9QxKnXyROR0guMzt5aJF1JgAepzJ30xAVYf
        M9d2XMJd3wb+t/mzscanLXW+V6BJtgFSVg==
X-Google-Smtp-Source: ABdhPJzIp/quN1QwTOXk9P7tPFbqPaO4qUcmh7aJNwAZ1GnkCu+lixNP0VfbXyz5NNIm67Pv3SCLnw==
X-Received: by 2002:ad4:576c:0:b0:435:493d:98e9 with SMTP id r12-20020ad4576c000000b00435493d98e9mr19114325qvx.128.1647290344066;
        Mon, 14 Mar 2022 13:39:04 -0700 (PDT)
Received: from rivos-atish.ba.rivosinc.com (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm8597023qkb.74.2022.03.14.13.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:39:03 -0700 (PDT)
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
Subject: [PATCH v6 2/6] RISC-V: Minimal parser for "riscv, isa" strings
Date:   Mon, 14 Mar 2022 13:38:41 -0700
Message-Id: <20220314203845.832648-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314203845.832648-1-atishp@rivosinc.com>
References: <20220314203845.832648-1-atishp@rivosinc.com>
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

