Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1F4B17C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbiBJVkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:40:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiBJVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:40:36 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CEC2734
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:36 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so8036097ooi.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HqpIlANdkOQKOXjwBjs8cYmBoShBh+rol5NQg2UHcQ=;
        b=sEIOgtn1hTncoRYD7rw8soECdhc+qTSuHFirYdgpmhgl11ZRxUmCTJqQVLp3uySO+W
         cWU9hHTcbrqdsckB4wBTllc/wKv00ME8JP7Kd53Mo4WiUozmQaHHnQ9cj3vRPUTSn/fF
         IlIOXfazff84lCs44cUF7H1kpTHRjy38zyayW8YKBIJYqZx9DwY2WvZTAi4uumZfvpcH
         z97M8iueKtbeA9mK57qbseZ9uMRuK3PMSfFtn/ytwtDFyxTVldrjOEscwCdZGImYqZGH
         s8YuADiDbhjizT4sb6v8MYxBmaDok5yNbwKiPCssHErMqICrXYMohrA7/oWN7P3RDraK
         g0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HqpIlANdkOQKOXjwBjs8cYmBoShBh+rol5NQg2UHcQ=;
        b=Jh6CE30cgis8GuVJ4fkRROOOZra+e8RJtU+yqEWL5PEjyso+ugVkW4DXFXeGHfaw7d
         tsHwqTfVrsL1BtO7u+gfhMXSnt1656iTOZWSint/oftOSDFU7wvvFMt/yLai5o50d0+c
         TnVGB/v91dVQUsKfe2pldPI1GC42UWc8TmmBnL3bN5P/OawjcIV+pUT5Day4+HK3Fgbb
         GCcC9jNrw4PVsmP5ksm4PhTeV9PsXMMGf11R71HET3B1vbjLcBEP2KPJ7kpm0VzxXxfp
         zMIXcGmh4evckNa+pAdUn5Mv5Q+HDkguMfmF2WTf5c5d7bFhFIpOtep4aYanLox/NmbW
         TqVA==
X-Gm-Message-State: AOAM532jNYfUNEbyiE18vxf4v76qK5VTVQgPUEq4oEQd3iyrHb4FmFas
        8RJBgdprbYoUP1L06eW0wZ7DoVls4XDgwiRx
X-Google-Smtp-Source: ABdhPJwswvuwH8xTFr0UU7nRSK+wVt/HmmuoJ/He9mWLY9YbklssjC7cpvnAPAdYQwCb8VUFbiowSg==
X-Received: by 2002:a05:6870:e495:: with SMTP id v21mr1423427oag.39.1644529235166;
        Thu, 10 Feb 2022 13:40:35 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id u5sm8700000ooo.46.2022.02.10.13.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:40:34 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
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
Subject: [PATCH v2 4/6] RISC-V: Implement multi-letter ISA extension probing framework
Date:   Thu, 10 Feb 2022 13:40:16 -0800
Message-Id: <20220210214018.55739-5-atishp@rivosinc.com>
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

Multi-letter extensions can be probed using exising
riscv_isa_extension_available API now. It doesn't support versioning
right now as there is no use case for it.
Individual extension specific implementation will be added during
each extension support.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
 arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5ce50468aff1..170bd80da520 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
 #define RISCV_ISA_EXT_s		('s' - 'a')
 #define RISCV_ISA_EXT_u		('u' - 'a')
 
+/*
+ * Increse this to higher value as kernel support more ISA extensions.
+ */
 #define RISCV_ISA_EXT_MAX	64
+#define RISCV_ISA_EXT_NAME_LEN_MAX 32
+
+/* The base ID for multi-letter ISA extensions */
+#define RISCV_ISA_EXT_BASE 26
+
+/*
+ * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
+ * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
+ * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
+ * extensions while all the multi-letter extensions should define the next
+ * available logical extension id.
+ */
+enum riscv_isa_ext_id {
+	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
+};
 
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e9e3b0693d16..469b9739faf7 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
 
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
-		unsigned long this_isa = 0;
+		uint64_t this_isa = 0;
 
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
@@ -169,12 +169,22 @@ void __init riscv_fill_hwcap(void)
 			if (*isa != '_')
 				--isa;
 
+#define SET_ISA_EXT_MAP(name, bit)						\
+			do {							\
+				if ((ext_end - ext == sizeof(name) - 1) &&	\
+				     !memcmp(ext, name, sizeof(name) - 1)) {    \
+					this_isa |= (1UL << bit);		\
+					pr_info("Found ISA extension %s", name);\
+				}						\
+			} while (false)						\
+
 			if (unlikely(ext_err))
 				continue;
 			if (!ext_long) {
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				this_isa |= (1UL << (*ext - 'a'));
 			}
+#undef SET_ISA_EXT_MAP
 		}
 
 		/*
@@ -187,10 +197,21 @@ void __init riscv_fill_hwcap(void)
 		else
 			elf_hwcap = this_hwcap;
 
-		if (riscv_isa[0])
+		if (riscv_isa[0]) {
+#if IS_ENABLED(CONFIG_32BIT)
+			riscv_isa[0] &= this_isa & 0xFFFFFFFF;
+			riscv_isa[1] &= this_isa >> 32;
+#else
 			riscv_isa[0] &= this_isa;
-		else
+#endif
+		} else {
+#if IS_ENABLED(CONFIG_32BIT)
+			riscv_isa[0] = this_isa & 0xFFFFFFFF;
+			riscv_isa[1] = this_isa >> 32;
+#else
 			riscv_isa[0] = this_isa;
+#endif
+		}
 	}
 
 	/* We don't support systems with F but without D, so mask those out
-- 
2.30.2

