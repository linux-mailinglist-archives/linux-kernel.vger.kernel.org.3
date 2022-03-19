Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21494DE7C8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 13:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbiCSMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiCSMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 08:13:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D67460D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 05:12:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z16so11768827pfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3X2tV+keGbsYSbHq09ZXywcQX5PSv7w44lhkAPv5lw=;
        b=BjHsw0mvLUvarLSC8WSX/z2bDCV9Ys0dIKCBECBHrwoAVRHgDqcB4hewr0fxb5bc4Z
         k7AbAL00hQGqtFXBm9ksabyMIl0CPtsIbnMbIcyte5tX7UaHxOtIFokBg5apXwHwgiM6
         YJoCjviQg4zD4Bsc3CkauV9irEFh+UQ5PhUrqYdYWD3PHIKN7JvKypD7/6N3aqw4F1yC
         VSsFZAHkxWoWxx/fca2/k6sc0RAm1DL3LFmTm+7crrE8GicKOq6/oAsO3Lcp/k+KHEzW
         yCi93exj3LdJWp50theehgjfx3XuksAcwpjoXXRclHe3khT/D0toBbXjtbln26pUSZgI
         mj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3X2tV+keGbsYSbHq09ZXywcQX5PSv7w44lhkAPv5lw=;
        b=TIOhZVyNjRhmRXPAknDH+Q8gLO7boLhSNnqKE66jPjd+uvJT+cnflQ+scY1106wMns
         e35g1k1LVMVEIJJwd2tX/OUqEFy7Cstz8QGkta1bsN4ubrQ6+BO62ICRDdFTBh77eFHO
         z3K6kDMnjI+aiN7OBnNiv3knFccDNplBzZWdMsLAT3qWBre9UjnpdLqzWJszzvsHK3Vi
         bBPflz+cnoQKEDZwmsbxYh8AWVLtN+9Eo+YWZTL1GCUHKCdni+IV4ykpdovjaPhibCbc
         S/K6FaL85fcIq8AVtshh5j/EZQHrSbon85TQYfr1c9v2ZOuFXzp5Cs5im3YS7HCOg90J
         o2kA==
X-Gm-Message-State: AOAM531ORUIDwMKJlTdQ8jB9xR0+kpdEdCIdoIfU7NhivY6nbxV3mnHp
        hJJJN5mDUMCsZp7WsfxJz5OvzNhJElpvaw==
X-Google-Smtp-Source: ABdhPJypAFKeWc4pTz3U+RtY8y8FZ46cOZnnU3lPnAP+NuKamOo8h3FNBLpurSzehAOlyuDfISU3cQ==
X-Received: by 2002:a05:6a00:815:b0:4f6:ee04:30af with SMTP id m21-20020a056a00081500b004f6ee0430afmr14593413pfk.15.1647691935126;
        Sat, 19 Mar 2022 05:12:15 -0700 (PDT)
Received: from localhost.localdomain ([122.167.7.108])
        by smtp.gmail.com with ESMTPSA id pg5-20020a17090b1e0500b001bf48f8904fsm16192254pjb.49.2022.03.19.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 05:12:14 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2] RISC-V: Increase range and default value of NR_CPUS
Date:   Sat, 19 Mar 2022 17:42:06 +0530
Message-Id: <20220319121206.95919-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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
Changes since v1:
 - Updated NR_CPUS range to 2-512 which reflects maximum number of
   CPUs supported by QEMU virt machine.
---
 arch/riscv/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..423ac17f598c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -274,10 +274,11 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	range 2 32
+	int "Maximum number of CPUs (2-512)"
+	range 2 512
 	depends on SMP
-	default "8"
+	default "32" if 32BIT
+	default "64" if 64BIT
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
2.25.1

