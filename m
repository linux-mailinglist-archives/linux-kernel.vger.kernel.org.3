Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A6A4B7BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiBPA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:29:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbiBPA3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:29:32 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18255F70E1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:22 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id n6so685463qvk.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iS9w0OaNOwq2lVntX7Egw8nvc58/BIqmU/Sn5pstZMs=;
        b=ScmFXUnXQsBDQOeRRDk2JBohAqloSaHvUZJJVuDjOjk6MgJrr3XFo1W8C/+DWEOpLp
         CFoD3CAA31Kh5JHz4MeR1/WPbopm9O71On05gdvf3KfQDy903btjnNyyFU0gz0tOB6Z7
         xFAFLQyz++xdvte4qay9VSxxaGBH7vl23QevY/KA6IP7MpaF5wB2+AKBVZNamTdUlfaN
         CIXDvPYRFQEAQU/t6zoMKOHwXQ9qgE2F8qmzjS9ffST7S5fB+ORib58xIj4LD7VVwqZV
         dk3soLeJWZbsvYAySuo3vUIXxVkk1ku0rTyE6Dy0DE6rWVNDB7awyY9j91+vQH4fLf7R
         gj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iS9w0OaNOwq2lVntX7Egw8nvc58/BIqmU/Sn5pstZMs=;
        b=BBOyEl1GXbqDKVHN2LfFOf1o2o4WgJL+JAvtpCpIBErnUWwsPYuYJBGqI/lmOGeX9/
         O/O9Wxzl7TRWsTxlkZqWMUSfp1hwIELNZ7Zeg1fO1BtG7HR5S7Zerj+PHlZ1ZgcnYUhL
         ndgoJFqJaFlozjhziElLCcIhoInB3vrDMR24ImUUVbkYz4NDF2jcOSLsXvtKDcZxwKpZ
         8Mtkm3KJ89qhS2zKq5wR94UNSl0bPX1CC3FDnm+OFR9sWKVrQES5Kw5dHgh+Il6ZFPpN
         lE3A633frVOd/mkQ8N+589vFl3xta50xvAWuVoQKXsUwFj30dZyfIetI9fFX3pJBU8RM
         7nkg==
X-Gm-Message-State: AOAM533lW8tTODOsXgiKK4v4khiG0rmi2AKPCrFRlgC0RpLETB+/AJmP
        rzMKpkMvwRosS2mRt736TZQN7kPhS9eqHOUK
X-Google-Smtp-Source: ABdhPJz0gbZP4BqfwiEDTMFUWQv3BXrxUsgsH+d0Rk7lM7XCFsOt8L1wSSB2ejz32cYkvipIBoymcA==
X-Received: by 2002:a05:6214:1c87:b0:42d:20cb:e484 with SMTP id ib7-20020a0562141c8700b0042d20cbe484mr288883qvb.10.1644971361084;
        Tue, 15 Feb 2022 16:29:21 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id g21sm20882584qtb.70.2022.02.15.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:29:20 -0800 (PST)
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
Subject: [PATCH v4 1/6] RISC-V: Correctly print supported extensions
Date:   Tue, 15 Feb 2022 16:29:06 -0800
Message-Id: <20220216002911.1219593-2-atishp@rivosinc.com>
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

