Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52074D8E51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbiCNUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbiCNUkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:40:13 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48739825
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s16so13860891qks.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iS9w0OaNOwq2lVntX7Egw8nvc58/BIqmU/Sn5pstZMs=;
        b=J1u1mo5RTmgXNbrfgwFkTpTBTCeG52RUdgQLYIOwlkQUNknzurIy6+GGvvcZXSWiLj
         258uDYkHGO11XTf8680JctynowTt+FLeqeGfy/ic1OP1weDl7Y0vYg+Ztpxl8I9lJoh4
         +6VB2xfNOq2j1lXC+uvSbeNWsEII1X668sYtnPAIIOPfDTItK+mxrg0krcuPqpiI0r2j
         zq81+lWc1U+Jj70SklpzoXnlFdQ9Nj+w/dTSSobJgYtpzmw6pzFB3maNdWQqej5UxR1U
         y9CNXLH6DHZnZelBEg8/HTIjMZSuJpMfwEv7niu2i8l2J+yZNLWqrR2uNUvFFmXToFfT
         a4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iS9w0OaNOwq2lVntX7Egw8nvc58/BIqmU/Sn5pstZMs=;
        b=1+a5p9YXJ+z8KBgXg6Q2PvVW38qeXnOtj0TtxiSwTcl63GkWiX/izwNVxchu68+GDW
         DNRgtXhyPxhZfRa8EXXbtgASzyBeTCcsDWwCa/Ox1iGkZ+gswBS8xgKoyGo5hw9mEERq
         ylD2i9U7ah1Ug+2qc2d+wI35HFuyJ8CgdkzJm1tvAlAlMvsxYeu8EJF+WKCqQHtLmdwp
         Mapysfye94C7rwTTU2K54wf9ESesOBM1kMJTwkDw2m0xF8bFZy4mbJh/BSCoV7TxYdgw
         b4RXEkD51/TMXpBUzI3+yYy+M52cLjtm4il2RVvB9fKZdLL8bGhSz6Q+3j4KkxSUr8KZ
         /aog==
X-Gm-Message-State: AOAM530mMcIQ0DaJY04vXzNMHO2i3aL+/KxDPwdPv6tkVZllmycj02DR
        lbOFBCFacsPKoasPTSATJqytoB63FWVG/g==
X-Google-Smtp-Source: ABdhPJxrS2xKMXQ+tv4b7WMBRUbarbEhVo8VEZIHtn5sm7hXQlKPDFFUdcpLOluZu44tq7mq8ulN/w==
X-Received: by 2002:a05:620a:2584:b0:67b:3209:96ec with SMTP id x4-20020a05620a258400b0067b320996ecmr15883646qko.755.1647290341311;
        Mon, 14 Mar 2022 13:39:01 -0700 (PDT)
Received: from rivos-atish.ba.rivosinc.com (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm8597023qkb.74.2022.03.14.13.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:39:00 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Anup Patel <anup@brainfault.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 1/6] RISC-V: Correctly print supported extensions
Date:   Mon, 14 Mar 2022 13:38:40 -0700
Message-Id: <20220314203845.832648-2-atishp@rivosinc.com>
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

This commit replaces BITS_PER_LONG with number of alphabet letters.

Current ISA pretty-printing code expects extension 'a' (bit 0) through
'z' (bit 25).  Although bit 26 and higher is not currently used (thus never
cause an issue in practice), it will be an annoying problem if we start to
use those in the future.

This commit disables printing high bits for now.

Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d959d207a40d..dd3d57eb4eea 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -13,6 +13,8 @@
 #include <asm/smp.h>
 #include <asm/switch_to.h>
 
+#define NUM_ALPHA_EXTS ('z' - 'a' + 1)
+
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -63,7 +65,7 @@ void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
 	const char *isa;
-	char print_str[BITS_PER_LONG + 1];
+	char print_str[NUM_ALPHA_EXTS + 1];
 	size_t i, j, isa_len;
 	static unsigned long isa2hwcap[256] = {0};
 
@@ -133,13 +135,13 @@ void __init riscv_fill_hwcap(void)
 	}
 
 	memset(print_str, 0, sizeof(print_str));
-	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
+	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (riscv_isa[0] & BIT_MASK(i))
 			print_str[j++] = (char)('a' + i);
 	pr_info("riscv: ISA extensions %s\n", print_str);
 
 	memset(print_str, 0, sizeof(print_str));
-	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
+	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (elf_hwcap & BIT_MASK(i))
 			print_str[j++] = (char)('a' + i);
 	pr_info("riscv: ELF capabilities %s\n", print_str);
-- 
2.30.2

