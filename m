Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4F4B7BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbiBPA3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:29:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbiBPA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:29:36 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63FF70EA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:24 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id de39so343890qkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPhfrRu9lOMUwT/7SSpNUGyvJjdNpXCP/wW++bFxhRc=;
        b=YPlmDeBF2w6ovQYBYeEzPbox6WtothHnO7nsxF53hmX5zJ0jsbDAZKFrpdr0D1vh0z
         BbtZFa59zGUcnQ6/cbDnd6PQANTTzmOeB+gsU48SuAocmqBcD4N+sy7LAskYEaXBbwON
         faFomcz6BuIUnNy12LVRLPmhUmXV2EuhqKhLv5YuTTEKFMqRf/Emz0Vl33gr1+NI30yy
         WOWkisZcDD98K0wjYQAUeBQPkSOJ2RrMxr4zqfkXb6dusQu7XfRJqSUgx4b6fbppCbtY
         VEq5tpGWHkbhOf7QjDe3WcQ0aDkKljAApomEwZzmb4UtaF2z/YR0SswW3HCXgIO6LJm8
         WaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPhfrRu9lOMUwT/7SSpNUGyvJjdNpXCP/wW++bFxhRc=;
        b=b8GBZ6QfJNJhgCcYQBkWAxCAlbqgU0jUqLqYPFDpkJWUYulEyzOBpxuyjUO0GrzuJh
         y69+cg1snd6xXp+9kom9M6tECv8D+sgY144h/FxDo9COp9Mc3T9NwXoOmSjbp6yfffUk
         vDQY67E83r6RunUoTlDaCteslX337Gt33pMAjM0SIoV+Q64YozyEiGJpj5fVpcDX6UPn
         D/pT3I8InLe/t8Ompq5uBHkeevYg2f1eK7JEeleQSW+v2xG+vfFx7cI0TSzu61dVG+HN
         Q7FMr74gHCEa2zCIigbijLgjO4qBv35ggoor95zsBYBt3Ktu7tcuIbPHq6lyfYOK4tAW
         xJdw==
X-Gm-Message-State: AOAM533OIjW/9M8Nt3EJVR8gBbAtGIyzn8CXnWIqiZIO9nPEaNxw4mxy
        h7kPmPzAb2UlsC7HbULp6jJRbXHqVTmKUwOo
X-Google-Smtp-Source: ABdhPJwjUXfhUdSHWN5jaqEIsJNOX3lvX7622QszkSBMLvEK3VhO3Psn4rluzieRO/ioHE2DD9qi0Q==
X-Received: by 2002:a37:2797:0:b0:605:bbdb:310d with SMTP id n145-20020a372797000000b00605bbdb310dmr208086qkn.638.1644971363199;
        Tue, 15 Feb 2022 16:29:23 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id g21sm20882584qtb.70.2022.02.15.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:29:22 -0800 (PST)
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
Subject: [PATCH v4 2/6] RISC-V: Minimal parser for "riscv, isa" strings
Date:   Tue, 15 Feb 2022 16:29:07 -0800
Message-Id: <20220216002911.1219593-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216002911.1219593-1-atishp@rivosinc.com>
References: <20220216002911.1219593-1-atishp@rivosinc.com>
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
 arch/riscv/kernel/cpufeature.c | 67 ++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index dd3d57eb4eea..65664422b04d 100644
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
+			const char *ext_end = isa;
+			bool ext_long = false, ext_err = false;
+
+			switch (*ext) {
+			case 's':
+			case 'x':
+			case 'z':
+				/**
+				 * Workaround for invalid single-letter 's' (QEMU).
+				 * It works until multi-letter extension starting
+				 * with "Su" appears.
+				 */
+				if (*ext == 's' && ext[-1] != '_' && ext[1] == 'u')
+					break;
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

