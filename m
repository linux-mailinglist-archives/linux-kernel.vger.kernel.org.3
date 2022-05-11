Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C6522E74
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbiEKIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbiEKIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA631509
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d22so1183472plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=JRX/iLnU0PEl4aE1jsRvHTuo999D/a+QvZpCGEgPlUA=;
        b=HAJWgvIRoqs0LfgalWP6ojZO1g0sEnjUIfCygsOcXzR06mAxirp7FsF1rIPz8xH0TJ
         6QsOm/LPEddHAO1rPR6C1P0qVYnfEaOEq9u6XnbvJdfGD5ewDaY8kEgX1D3+A5pxOeUm
         InWSlP3RoygZr7h5hwVCVIiSevSmzaY9psUk9V+iuUhrhPZHWEsZXWEtDPb4R4jOk+yf
         8sGmPstZ4OThvmH0GMvS0A9RIcU3oIU6fDlFPdvfOkw1gXc1q0Kol19+GikYAl1Ufzy4
         TKI7aV/WyUFKaPykbHiXZeRjqn+Bwi0EdFA9/+5fsahSFUh1lwf3opCPCxV8ijiIU/Up
         NEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JRX/iLnU0PEl4aE1jsRvHTuo999D/a+QvZpCGEgPlUA=;
        b=X7cy5UUbBJEl+MT1SIxD/NJ4ixANboHscmJ+8jsKg8ad/BVwdmzoUB0QmYKhg7qWc3
         RCEVrc0ZuPMEIFTZXdt5dguHBPKBXasxiuhACQKnk9pt5LGpnHFIiwVtMBHt7V/2f3OC
         7QFwU/OmibGaYN6jQ63BUQBudgQkKOyFwVQUK1KFts12bpCD+c03ZLBYomRRJAVYYgo/
         ZstvT+Gx4MwFTvXy2S4lsfkkDEozn7bSdcYbfI8JQFU8PGhfXQWJndz2ddyH+UBFsz5X
         lCT/sze2Cirfirom0LxAk6TdyU3g3SOfyMaKUJLYYaeYyUmuvlMKhVNTTBCbpewJr/Pv
         HtxA==
X-Gm-Message-State: AOAM532z8JBs1dyXILjPlgtThAu/BRiK6GbjO084VJNTpr9oz3esZmED
        X376vc+DwOyecv4THibH8QBOCQ==
X-Google-Smtp-Source: ABdhPJwsXQV+fb5RuleuyZPN6gdlX4DQrCU1gxu8pD+8g8dT4KUeC1ecnrXP925EDhqQm1GhsYAz1w==
X-Received: by 2002:a17:90b:4f87:b0:1dd:100b:7342 with SMTP id qe7-20020a17090b4f8700b001dd100b7342mr4146651pjb.64.1652257892511;
        Wed, 11 May 2022 01:31:32 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:32 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 02/16] riscv: Extending cpufeature.c to detect V-extension
Date:   Wed, 11 May 2022 08:31:12 +0000
Message-Id: <7fcce42051191f2c90f536d0bdbc57da1ee1d9c2.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Current cpufeature.c doesn't support detecting V-extension, because
"rv64" also contain a 'v' letter and we need to skip it.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
index 46dc3f5ee99f..c52bb7bbbabe 100644
--- a/arch/riscv/include/uapi/asm/hwcap.h
+++ b/arch/riscv/include/uapi/asm/hwcap.h
@@ -21,5 +21,6 @@
 #define COMPAT_HWCAP_ISA_F	(1 << ('F' - 'A'))
 #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
 #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
+#define COMPAT_HWCAP_ISA_V	(1 << ('V' - 'A'))
 
 #endif /* _UAPI_ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..92a8fd6bd3ed 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -76,6 +76,7 @@ void __init riscv_fill_hwcap(void)
 	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
 	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
 	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
+	isa2hwcap['v'] = isa2hwcap['V'] = COMPAT_HWCAP_ISA_V;
 
 	elf_hwcap = 0;
 
-- 
2.17.1

