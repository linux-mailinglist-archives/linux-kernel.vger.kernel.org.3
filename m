Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6122C535878
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiE0EaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbiE0E3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:29:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DBCEC32A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v15so2963949pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIrQErFI0nRjNQUwExp/Jh1TFsN8kfOtxaRGqU2b0Oo=;
        b=pKCqDbTIAzv7XZRd/1zw5xnWSmXS92/XeAuIrPG8RV18k253OQHW3beXdj/Z8X8DpF
         8AUBLn8agQRTVprD6pj44OQXvmKpf7X1Xombc26hQyZyMIO2Ckewei5KbRrlAIWsyfNm
         6/qvRTgRbDTc0KXsSKeP0hKxIzwqLoey2H1mU8H4qSIKDSLr+xWPNBsrtYxbOO5VhJqh
         zRaJGTh5c3xN8Sr/aJOtrqj6z1aQf8DjyKQ7u/WpEYnPwyYBxxwV0X4ArwfrxW7eag40
         hhLVhFQwIMTNWbmV7EeuTdBm7BcP9DItwSC7gkPsO7/ZwBcLx5bGDyJHtapzlyZmwt3F
         9XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIrQErFI0nRjNQUwExp/Jh1TFsN8kfOtxaRGqU2b0Oo=;
        b=fkmbkaz1+UorzEtklUkdfYOzhis619ddgn/GcfKlhVi5AOvemeg+eUH1qDbE6CgO3M
         O7vfzn5WAaFrNVst6636rDwCPz0IX802zvie6EKAIWwC16zXzcdbWBdYMMEick9l2gQI
         Cr5Tto0WBRES2iLfVt4nwqjdfV0DFrXmZbRlcuvS26pTeKOx4oErodepxjP578A387eB
         6o+7pN+MyL6MdH2YW1RlFH4bxzG74SAiAuGqPMX7jpmPKNO/GMeAL9HVguey2H4La5zS
         Z09R1vnXsQb9V1aWWdze0uydeblqZVU+s9L6rtYeAku1TaROYTEo1OvSHllSmzvWjy2w
         9wsQ==
X-Gm-Message-State: AOAM533m7DwVgXH1GbbU+HGr0HE6bIPb4ld6pMvU8Gueg0nCFzwFLc1l
        Bv0S7kvKx6L3uIdc8m3msuSmJsnIA0UBYQ==
X-Google-Smtp-Source: ABdhPJxrx52oLQouegWB2cqbQczI8Sk5a9+PlV1NL/HCXxcozVKB/AzjA84fz49VaakZvG2hls6TCA==
X-Received: by 2002:a05:6a00:1683:b0:4f7:e497:6a55 with SMTP id k3-20020a056a00168300b004f7e4976a55mr41855313pfc.21.1653625792677;
        Thu, 26 May 2022 21:29:52 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y63-20020a638a42000000b003fadfd7be5asm2352307pgd.18.2022.05.26.21.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 21:29:52 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/4] RISC-V: Enable sstc extension parsing from DT
Date:   Thu, 26 May 2022 21:29:35 -0700
Message-Id: <20220527042937.1124009-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527042937.1124009-1-atishp@rivosinc.com>
References: <20220527042937.1124009-1-atishp@rivosinc.com>
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

The ISA extension framework now allows parsing any multi-letter
ISA extension.

Enable that for sstc extension.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpu.c        | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 0734e42f74f2..25915eb60d61 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
  */
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_SSTC,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ccb617791e56..ca0e4c0db17e 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..a214537c22f1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -192,6 +192,7 @@ void __init riscv_fill_hwcap(void)
 				set_bit(*ext - 'a', this_isa);
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.25.1

