Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB55086D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377990AbiDTL1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiDTL1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:27:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E473ED3D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:24:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 12so1472745pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOcKsvlhkYOH6DURGCa3GxXMgwg70eEyugu305Hx/i4=;
        b=huQStEUgrnTLqHQcUVA47DLBVrjhRp8/5ooQIcVS/8VOTw2v7UkspwQK1F5mHJtRn+
         sKTazcqIsPoEyQWgGsL4xjnBB4ggKKLQlVrFCGSSASgstQ8GxPdRXPIPSSYqM6X+BJD/
         CjMNlZJQ6oILFY8f8vYnge/n0FMUaKLjG8YvtsFan0ZB/1LmuExXj14da32mDyl6ftWf
         PuR9vCc39qC6/gaDqF+WNahOZAUUI2XepCDQSa+U0oFcraBdJt/17pbNfNY82qUnJZ2x
         hXDiN2P2lw684VdyX08UCSdFaox9esIBTZPyPqRH2niJiQan2u9omItP/YrlYSrEbKoG
         s9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOcKsvlhkYOH6DURGCa3GxXMgwg70eEyugu305Hx/i4=;
        b=Uy81Iv7e+oUrKQUXFI+Eb393HcTtz26izQnfs0+WcPuiezZXqWKcDAe3GRbkZ/NCT7
         KWLLNuh+DG88YfKmltJarAuUGgi0rjbzblu9+ukZ3r68hV7Fhb1xbrBD9Yq+/3fW3B2f
         tOUUtTFZI69tPa/WTKoIee8ZgYdgzq+vEQ0gvzqnQkRTpeofYw95LS4CMWZik5euXgvM
         SDzZAgsWfafG2oIDwTaUy+X0B2v+5iqRR5FySnbzpM6CRDjZmddVxamavQk5sqmu/7GO
         ZozkZDSqc6P8LVFTkZv1uE9uMoKzJXjowqdTi1yfCnFlVibX+qEOYbpLwM/XdaPcoyGr
         8JnA==
X-Gm-Message-State: AOAM533T1u3CjzveVvrtJ4drGr7YDxnAl+ohXgjCrmk0JqrsSlmg6SSU
        EPiLrOVIC0lFfC1f9zF6oo3acg==
X-Google-Smtp-Source: ABdhPJzl3XTlnh4BpULoaWgL0FpnqMN+W7u1X3uwNeAxuOqev46qNnJVPCiu+w89eCRxGJ3fhrBbrw==
X-Received: by 2002:a17:902:f787:b0:152:157:eb7 with SMTP id q7-20020a170902f78700b0015201570eb7mr19337488pln.109.1650453858367;
        Wed, 20 Apr 2022 04:24:18 -0700 (PDT)
Received: from localhost.localdomain ([122.167.88.101])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm22273743pjn.34.2022.04.20.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:24:17 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
Date:   Wed, 20 Apr 2022 16:54:08 +0530
Message-Id: <20220420112408.155561-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the range and default value of NR_CPUS is too restrictive
for high-end RISC-V systems with large number of HARTs. The latest
QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
restrictive for QEMU as well. Other major architectures (such as
ARM64, x86_64, MIPS, etc) have a much higher range and default
value of NR_CPUS.

This patch increases NR_CPUS range to 2-512 and default value to
XLEN (i.e. 32 for RV32 and 64 for RV64).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
Changes since v2:
 - Rebased on Linux-5.18-rc3
 - Use a different range when SBI v0.1 is enabled
Changes since v1:
 - Updated NR_CPUS range to 2-512 which reflects maximum number of
   CPUs supported by QEMU virt machine.
---
 arch/riscv/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..1823f281069f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -275,10 +275,13 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	range 2 32
+	int "Maximum number of CPUs (2-512)"
 	depends on SMP
-	default "8"
+	range 2 512 if !SBI_V01
+	range 2 32 if SBI_V01 && 32BIT
+	range 2 64 if SBI_V01 && 64BIT
+	default "32" if 32BIT
+	default "64" if 64BIT
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
2.25.1

