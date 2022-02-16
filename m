Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ECD4B8000
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbiBPFWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:22:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiBPFWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:22:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AA6928C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:21:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c3so1145317pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fkaw2AgXeRapA2vSGzULQ3ZFgz87sJihuak0e8PCYl4=;
        b=JVdxVIQGvlv4EAIbwhLIia88Drof+Ql0VIpTJ5KF80jdvIuqT9g/y3Z6uVveFvkP18
         hQyjG+Y7edH91sHJZWwqvINOjxz84mpFEcxXY+ehad/rP0MclJVE+Il3nQ4KQPvKvJMo
         Wnwxmr2mxeSp7uBReaQYgY4pjEP6BjFpkZBqCzbLbvDCTKNB3RXmeeCmGTxiE9I7yfpY
         WO3OyX7PN4SANtT1Bi7IIQ5rsR3P46pUsifCcLKgVXriuZIas7isxbd+G/f1gH/P7euX
         at0vrBTRo+DH6DvbwEo0zAieiSpI5KURwlBmzLSy2X9aGUoXuYyXI6hVmUuey1WNhl7p
         dCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fkaw2AgXeRapA2vSGzULQ3ZFgz87sJihuak0e8PCYl4=;
        b=xNfnOqadsgPy3WUkJgoRKosia5LW2p3dZHlJK1k1kVHV+twXN/EH6LKdIMtoTVxTSF
         F9IU8u0UuHO0cH36hO67UYFHZNGvistSsTPjt1eKsxEtXrUVUXMviURbG7C4lTUOHiIn
         qOGKPvwgQmKnw5iFBAhJnMR4qi2bKONrvR1b4h6dYHUtOVX+pxXNfAoR3z1xIgwgIe4J
         BjdGJAn+s1zh3G2wPB7n5zSwYCHiuW5bjaE9qa5pCKfhHzPeP0gzbvgUv16sE4KHxP2E
         YUhDcUnuQncDR1mDr1U3ODhgSMTkTu5yehKsG2qiYzz3vn/4OHuPIBWDf5kT+hqM2lLK
         w6gA==
X-Gm-Message-State: AOAM530A7JPT465eFsmWqeQzNeespOpo6C4El3dYUW+K45YWIsYe40ND
        3Iiq/+y9SflNVt+OFhmJz9nwfA==
X-Google-Smtp-Source: ABdhPJyqifKB2A/wkCgP3p0BooigA7Y58CXS/BbBGPS8ZodKSN9SErbkIUz+aRc5ZwwoucVhJKFPHw==
X-Received: by 2002:a17:902:c443:b0:14d:a756:b1f2 with SMTP id m3-20020a170902c44300b0014da756b1f2mr1032189plm.94.1644988916233;
        Tue, 15 Feb 2022 21:21:56 -0800 (PST)
Received: from localhost.localdomain ([117.248.109.221])
        by smtp.gmail.com with ESMTPSA id ot12sm10775259pjb.22.2022.02.15.21.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 21:21:55 -0800 (PST)
From:   Mayuresh Chitale <mchitale@ventanamicro.com>
To:     palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com
Cc:     anup@brainfault.org, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [RFC PATCH 1/2] riscv: enum for svinval extension
Date:   Wed, 16 Feb 2022 10:51:09 +0530
Message-Id: <20220216052110.1053665-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216052110.1053665-1-mchitale@ventanamicro.com>
References: <20220216052110.1053665-1-mchitale@ventanamicro.com>
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

Similar to the other ISA extensions, this patch enables
callers to check for the presence for the svinval extension.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpu.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 691fc9c8099b..bbff7cb279ea 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -51,6 +51,7 @@ extern unsigned long elf_hwcap;
  * available logical extension id.
  */
 enum riscv_isa_ext_id {
+	RISCV_ISA_EXT_SVINVAL = RISCV_ISA_EXT_BASE,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ced7e5be8641..ff0613f8cc39 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -71,6 +71,7 @@ int riscv_of_parent_hartid(struct device_node *node)
 	}
 
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
-- 
2.25.1

