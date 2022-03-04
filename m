Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3344CDE35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiCDUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiCDUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:15:36 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8123065B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:11:24 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id c7so7306138qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOaq/RArOsIMDEytI6Sz1pnZYzBz3vUl5NUCRG67IW0=;
        b=qwkfyanXvztQ6XLHz71CS2ApVZCgU95lIC27jZPWXeHR2QT7ofzrhKQjLu8US8da3j
         +V4zJVXa1833fD7feTy7V19ftKSt58usT4zuDhsZY99fM3u4/VP08oB5BNHmy7mMUmBC
         Hd5+qCg79rcE+EW8alFQs34f1JBTdkEJhwX/KMoPc70/mwmRao4pvlOfyi9vWBIaga0J
         dqH7iXWKMJN0CAlQSWv3SEcZOgAGMT3IFmRtBnUsrvzvsDq6CJ+qHjejICE7X/qhd1mG
         QNyxZ3elzq1UufWglGovzC3hRw4Fbab9k9NwdCY6ZDP+EEK/o7lM7vwVVkxtC+PS1SFc
         LWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOaq/RArOsIMDEytI6Sz1pnZYzBz3vUl5NUCRG67IW0=;
        b=ySKdTDfVGo/Vtoeilo4a55TX0AAfX4ZXuba7yu7GNLhqJdyGzKu3681Zm9ZEnelwWg
         AC4UCWDp1q4I/Xtnxid9WkqYO75Hi/va9GQDcqI6Rl7XysKuaDYwFKeKqZ2wI4ITn9g3
         5ujeAAV2cYDWnk+65Fdri4Ps9L4mUA2pxjmgFp+OlmFYWy4CWDlwhTGBgWuXT98HnOsU
         IlTWg/tgLFI7l8HyPkQmJeAJRrBfsDGDaG6NcryZziswfAZaS6kxaiXTlkzwSDZqRBZj
         eII72ZgZb+f1KBSIogID2Gh0qtWRj5nWdikX6eojtJxKMGPFsTD/aqYhAozU7wRR3rW6
         6D+w==
X-Gm-Message-State: AOAM533+zt/bIHpNINIPh4ocyxSJdzuiIbGNChT4sVMiPW5LLRVJ/krf
        njxLTia20pZ20GpxIYXa5x8wV9/jkN6HrQ==
X-Google-Smtp-Source: ABdhPJyz4bobvXoyET5/f3LrTYV3os+fQ89XumUD4klEmrv0+DoLEKr8Botl+4EiH0M454t8eFvVIw==
X-Received: by 2002:ae9:dfc7:0:b0:648:e065:84be with SMTP id t190-20020ae9dfc7000000b00648e06584bemr209067qkf.129.1646424641718;
        Fri, 04 Mar 2022 12:10:41 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002de8f564305sm4605481qtp.1.2022.03.04.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:10:41 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH v2 2/7] RISC-V: Enable sstc extension parsing from DT
Date:   Fri,  4 Mar 2022 12:10:15 -0800
Message-Id: <20220304201020.810380-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304201020.810380-1-atishp@rivosinc.com>
References: <20220304201020.810380-1-atishp@rivosinc.com>
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

The ISA extension framework now allows parsing any multi-letter
ISA extension.

Enable that for sstc extension.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpu.c        | 1 +
 arch/riscv/kernel/cpufeature.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 691fc9c8099b..7335e9138fb7 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -51,6 +51,7 @@ extern unsigned long elf_hwcap;
  * available logical extension id.
  */
 enum riscv_isa_ext_id {
+	RISCV_ISA_EXT_SSTC = RISCV_ISA_EXT_BASE,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 031ad15a059f..7568c7084a52 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -71,6 +71,7 @@ int riscv_of_parent_hartid(struct device_node *node)
 	}
 
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f3a4b0619aa0..1d8a06575cea 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -192,8 +192,10 @@ void __init riscv_fill_hwcap(void)
 			if (!ext_long) {
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				set_bit(*ext - 'a', this_isa);
-			}
+			} else {
+				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 #undef SET_ISA_EXT_MAP
+			}
 		}
 
 		/*
-- 
2.30.2

