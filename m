Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4350A68B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390531AbiDURIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiDURId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:08:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85AA3ED01
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:05:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j8so5433469pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=VAtOPkJ1SY/tzMbGCTKTKv8dG7z23I5mteO8idQRNqw=;
        b=F03wFIkvH5mHwPm9Vdu97iKnCWlemvMdFvOppF2ZHGD8qtffYcRETG3VtVhIj4qvYx
         XWmKJ/KsFbZPc1kUl1FxRWXZr5+5Vn5eHGrysqnfIv3aZFgOr4xeSn3fDvZQG9uLzcMQ
         M/9UffPcFn07CYsjM+L2p5OHf9tHrF5TTki3qW1CH4jL0aF8veH/OpcovTFTbw2NpU3+
         0w3kbZmQ1MT0WHZoHPveAXxJmj6KLpBbvQvXnpN51UYFdvkEMfI1ozg8XM9sEgA33H1f
         KB577+f/yUEmDZQCuJmDNEJ/9zZ3H9cfwN3Q/rDUZlUDARsAPSs1PEcRG2meHbtvi8Pg
         RvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=VAtOPkJ1SY/tzMbGCTKTKv8dG7z23I5mteO8idQRNqw=;
        b=rAkEvp5n25+vX5V4u3xEnn9kxiL2z1i3xx6z/syoGrxYUL2V10wDrGasOoG/GuMIrv
         Bir2lDb9KgIm7pdk0YvMMVzq+PvoS6Y9eImkdpYng78yMWE2J26/LSdQReBitWi5mCRN
         tiiefgJaOBUz890BPIJqoeKYlFN4wlYSFNF4Znhc/ddAyrAeShcDxHO4buH6Wzl3BSUl
         IdisOEQWjIPHXJFD5JBTXWI6IjfBmJIWpkgchIaOjr8SM/f0wL2hUYNmIdCIliQjJ7/g
         HZYBO0ovHgOdMHGPAyc6jTt/heAg85tuQzKZMWbIxf1emhGBVgai/kIPkiwHDVM4YW5T
         gM6A==
X-Gm-Message-State: AOAM531e0FIVMYQgm58TeN789UYBa17AlGL/ckG1O/Z3FbrRzVmbXZP3
        Qk7uXROOJksVdnJDGFA8RxONAw==
X-Google-Smtp-Source: ABdhPJyjqlvEcnOu/+Sk4eVZPHB9SHCOwWZKtrj2V0KbAODClpJDnwpOm1MZqxewG78k6bjgkizydQ==
X-Received: by 2002:a17:90b:384e:b0:1d2:798d:6f42 with SMTP id nl14-20020a17090b384e00b001d2798d6f42mr635645pjb.5.1650560740380;
        Thu, 21 Apr 2022 10:05:40 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id j6-20020a63b606000000b003808b0ea96fsm23186858pgf.66.2022.04.21.10.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:05:39 -0700 (PDT)
Subject: [PATCH v1] RISC-V: Only default to spinwait on SBI-0.1 and M-mode
Date:   Thu, 21 Apr 2022 10:03:55 -0700
Message-Id: <20220421170354.10555-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The spinwait boot method has been superseeded by the SBI HSM extension
for some time now, but it still enabled by default.  This causes some
issues on large hart count systems, which will hang if a physical hart
exists that is larger than NR_CPUS.

Users on modern SBI implemenation don't need spinwait, and while it's
probably possible to deal with some of the spinwait issues let's just
restrict the default to systems that are likely to actually use it.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
This seems to be the source of many of my new hangs when trying to test
the NR_CPUS=512 support.  It's not really related, just fallout from
testing different setups.
---
 arch/riscv/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..dd5e975abe37 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -359,7 +359,7 @@ config RISCV_SBI_V01
 config RISCV_BOOT_SPINWAIT
 	bool "Spinwait booting method"
 	depends on SMP
-	default y
+	default y if RISCV_SBI_V01 || RISCV_M_MODE
 	help
 	  This enables support for booting Linux via spinwait method. In the
 	  spinwait method, all cores randomly jump to Linux. One of the cores
@@ -370,6 +370,12 @@ config RISCV_BOOT_SPINWAIT
 	  rely on ordered booting via SBI HSM extension which gets chosen
 	  dynamically at runtime if the firmware supports it.
 
+	  Since spinwait is incompatible with sparse hart IDs, it requires
+	  NR_CPUS be large enough to contain the physical hart ID of the first
+	  hart to enter Linux.
+
+	  If unsure what to do here, say N.
+
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
-- 
2.34.1

