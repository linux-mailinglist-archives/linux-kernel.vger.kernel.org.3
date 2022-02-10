Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF74B05DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiBJFvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:51:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiBJFv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:51:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC62E1174
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:51:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y18so908968plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 21:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qlm9yJ5575SFpR6IPywQKZmVoP3waSVFMhfeayBNTbA=;
        b=fnfZc0AIG8SBxpjQDcaVBiRVbSpK8UXvadVoxtlMHcKr0gAVz662qCEZ2aLfHkaCrp
         oiNJ+9QqhvaLMKcfaPl1GvDq/YUj/KRrfqu1TELLhPgEcxVBKkh5/LP578h0s79b1qwj
         Y7SVefGUnaxDq3ntC/uarGxulVKTMh9zt2PhbZ5bJd2Bnb1UTvzXAAVcFv37EO3hG2OS
         z27IWz2UqxPidErtJ6MEhNTczwPVKRGCWbxEC3/KRbK/xRRz5GP8MTSv/3LDlLwfNba8
         osTFlbhy2375IUn5yHEpNyCH1aSPSULs4Q4hVFjmfd5Opdfvh1Tc1WsDh0arV08b9I13
         RBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qlm9yJ5575SFpR6IPywQKZmVoP3waSVFMhfeayBNTbA=;
        b=ssZ99h5P4nDhgMXXe8DSxLiYDCtdIrVUKD0IyTY38XmKQ+rShSX+Ctlx3AhHaK6I5X
         PJHJoAN1+H1XJFzl/MD3aurr0UgDX1hFit379cl5003TcyNc5TcKiArt3tCdDZhLmyCY
         PwccNdEtLxGZvUIB2zbIVlrifBMZOVkuXMfyC32NZngjhE2dKzLALIbdU9G2xVTabnLi
         zEiw54tyOng4PPPkeyom2YQltEZbXgcCfovT38e82J0PXIhsluYl7GB06u52EkWaM8JN
         5EpwIE4uR9z8xfASANTOS35IXI+fA5xHodnlIxsOIV53tyFHhGmDu25fA5vocKlM0Aue
         0Ihg==
X-Gm-Message-State: AOAM533GoU6ADw7OTokzpSsxMdn1q4VAwqaLHaUwwF+3h6S2mKBkcm/L
        7Ss51ztTYlzNSaNrOH+nKYRutw==
X-Google-Smtp-Source: ABdhPJyfhOIllPegTmHNIO0ywUxfTTaD2VxDT95TmWoHMJ394XuWoV97b8eft+oMdipg7wKw+LoPoQ==
X-Received: by 2002:a17:903:2406:: with SMTP id e6mr6077678plo.98.1644472278347;
        Wed, 09 Feb 2022 21:51:18 -0800 (PST)
Received: from localhost.localdomain ([122.179.114.46])
        by smtp.gmail.com with ESMTPSA id s32sm15192270pfw.80.2022.02.09.21.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:51:17 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v11 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Thu, 10 Feb 2022 11:19:47 +0530
Message-Id: <20220210054947.170134-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210054947.170134-1-apatel@ventanamicro.com>
References: <20220210054947.170134-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

We enable RISC-V SBI CPU Idle driver for QEMU virt machine to test
SBI HSM Supend on QEMU.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig.socs           | 3 +++
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6ec44a22278a..f4097a815201 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -36,6 +36,9 @@ config SOC_VIRT
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select RISCV_SBI_CPUIDLE if CPU_IDLE
 	help
 	  This enables support for QEMU Virt Machine.
 
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index a5e0482a4969..b8c882b70b02 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index d1b87db54d68..6f9a7c89bff9 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
-- 
2.25.1

