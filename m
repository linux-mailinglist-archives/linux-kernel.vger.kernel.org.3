Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0E4B17B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbiBJVkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:40:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243868AbiBJVkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:40:37 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADBBBC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:37 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r27so7492983oiw.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nB7qzXaFNatnaTZQJRAInnjQf9KiqCTDZAFaYuusV0=;
        b=L+ZGFYNRoNLbHVhM3KhtWzMWcXEDYyJA7aw1jmcFUNm9LwjalIvnug5gAOBoaVsGAi
         XAfgYWak1dxQzZ5ghazPUUea8fGTUL4XYyIyS3b6NW+CmQgYLVmzlmTGPyvdu36ntJE9
         p/WWwPx2fjkcKd0nUagR9y6sxwOG6zjfJTQ/wWjLi9u+NSP/xV0hSdCGSkoc8CSEy4Zh
         Xfmpchix/fMksPHav7pOiVse8m4TiWBP74rJVn9fBN60F/vQOUJa2ip5dMXv/LouxZAc
         odHYF6dZ+iuK1KlWP32f8JPsVtkzl9VjkswCDQuIxLTMaPXm3Tnh3rK4m5SBJ5wSZl2Y
         E93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nB7qzXaFNatnaTZQJRAInnjQf9KiqCTDZAFaYuusV0=;
        b=rrXebOwSuWDkNV7rK42dAJL0+I10kOd6G4vsjZK0gvkNtsNSjWIhSfETAAU9yIpymp
         Mb2ULfnc2j6vBwOsZWW9LfvjpNCZQFKflBZsgVRdGDO/75m89eqa8uSytFlupXCwYF4M
         4t/KjLqnxAtbbT0yKPao7XkPBlhHd7uTkmzx+NXyqH1/6KnZLRzWSDn2d9QamiJgDuOe
         3UkSrHdHFdTd82PIz+fpGSNBwT3TnO3L8aScgzAHWrsEVFzs22XL0iBOeEeda+p/LbNQ
         DKS5/PPp8vhVcJIqI3GpqTHwF8jmtY1N5tVqkurw2QSIS2aHcFwL6Qd4lTs1E2gPXecz
         aHQw==
X-Gm-Message-State: AOAM533Ze46tEYBaRh4gVAzwivbmogv283d60CagKQnLk6TSOvlxQO4d
        2RneBnwVlp62Nrc9O0v3wOSoWhl4ppwaLY2w
X-Google-Smtp-Source: ABdhPJxnj59RepTjd/uznzgrpDdO30O9r7af3cgqYy9BVCSUocaHEleDWBfL7GJ76jB38zMSSwzmAQ==
X-Received: by 2002:a05:6808:11ca:: with SMTP id p10mr1942733oiv.74.1644529236740;
        Thu, 10 Feb 2022 13:40:36 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id u5sm8700000ooo.46.2022.02.10.13.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:40:36 -0800 (PST)
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
Subject: [PATCH v2 5/6] RISC-V: Do no continue isa string parsing without correct XLEN
Date:   Thu, 10 Feb 2022 13:40:17 -0800
Message-Id: <20220210214018.55739-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210214018.55739-1-atishp@rivosinc.com>
References: <20220210214018.55739-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isa string should begin with either rv64 or rv32. Otherwise, it is
an incorrect isa string. Currently, the string parsing continues even if
it doesnot begin with current XLEN.

Fix this by checking if it found "rv64" or "rv32" in the beginning.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 469b9739faf7..cca579bae8a0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -84,6 +84,7 @@ void __init riscv_fill_hwcap(void)
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
 		uint64_t this_isa = 0;
+		char *temp;
 
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
@@ -93,6 +94,7 @@ void __init riscv_fill_hwcap(void)
 			continue;
 		}
 
+		temp = (char *)isa;
 #if IS_ENABLED(CONFIG_32BIT)
 		if (!strncmp(isa, "rv32", 4))
 			isa += 4;
@@ -100,6 +102,9 @@ void __init riscv_fill_hwcap(void)
 		if (!strncmp(isa, "rv64", 4))
 			isa += 4;
 #endif
+		/* The riscv,isa DT property must start with rv64 or rv32 */
+		if (temp == isa)
+			continue;
 		for (; *isa; ++isa) {
 			const char *ext = isa++;
 			const char *ext_end = isa;
-- 
2.30.2

