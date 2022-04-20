Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671E9508FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381595AbiDTSvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbiDTSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:50:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB33243484
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so2603238plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=dGeAOCT6r5MCsaaONz+vK0DLEKteGUlMarNKYZRrUPE=;
        b=3DPUa2Vpp9GY71EMMBzT6vukuP1h7Mh1qSwctxVlOMqU2UrCl9zuFahzP1szIXX6JP
         +oGAyKYhhah/seZxnMyfudLk7ktQMOGReYKJAwqGSiWJomCJ6tV1k3jMPmrpTlPOtdQW
         kJRC/sx8oC23TRYHOJxOV0QJoQrwmZ0nlCC7vOzpxq3sjENQOgDOxC9U8MlJRYCijp3X
         XkACjOJY/fWnJpMHcU5hiv/g6rX4WMuwoudIiCd7VVJOnrLNQvI3lOfJlQ7+mItlv0ou
         VvWCbxS3lmCJH69vxwECf49ur9p2gkktQCU/g3ezMq4gFJAtIgzB5/OFWA4IP12tcw8N
         Apsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=dGeAOCT6r5MCsaaONz+vK0DLEKteGUlMarNKYZRrUPE=;
        b=2ijMcWsVNsqnwoJtF5O/fRwv5qPpTr5+RwyImrywrpQjj5svYdfU9bXNlqWV2HSOGG
         DBx3GvKE0weQPKOiNOzSkCYJNAE+7fTKvOj5xmcEClL2sn+FXm4qOCkpFsZkNeE+WtR8
         A7s4vpvt8HOUbmvS5XpaWvR02JMiVXKOCW/GYh7xRGF/nAmalE6PLIRw/CjlmOUBwZzb
         YSSD9nOy9gkcAd9fHroGR/KNKm+i8tlVAVHinbBvgtxdwm4AkYTI1XSmbSqT75avmc5r
         gfeyRzgntyDiTc0pQBllkSjODIFOfojH07iDMxdVf+lBpEoyt1SVAGLsHvRt/zZcUKqR
         aU/w==
X-Gm-Message-State: AOAM531Bs02+Ir7fO7KcwNICtrB92iuclfShF/7WEgt/VROte3mpkoyo
        qavtOWhapE+Bfr9aDDwm6aPlag==
X-Google-Smtp-Source: ABdhPJy51U92hAStdVI18w60yzTLPW9PlcbYe4Ark6awPA/Y9+hbDDPc6f0OMhgjrOvin5aqSs7Y0A==
X-Received: by 2002:a17:90b:4f82:b0:1d1:b8fd:7e36 with SMTP id qe2-20020a17090b4f8200b001d1b8fd7e36mr6060236pjb.194.1650480492240;
        Wed, 20 Apr 2022 11:48:12 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id bc11-20020a656d8b000000b0039cc4dbb295sm19485492pgb.60.2022.04.20.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:48:11 -0700 (PDT)
Subject: [PATCH v2 1/4] RISC-V: Avoid empty create_*_mapping definitions
Date:   Wed, 20 Apr 2022 11:40:53 -0700
Message-Id: <20220420184056.7886-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420184056.7886-1-palmer@rivosinc.com>
References: <20220420184056.7886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, vincent.chen@sifive.com, guoren@kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, rdunlap@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

At least one use of these, that in create_fdt_early_page_table(),
triggers warnings and should cause a real error (create_pmd_mpping()
ends up skipped on XIP_KERNEL).

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 677b9eb8810e ("riscv: mm: Prepare pt_ops helper functions for sv57")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9535bea8688c..7bc9a21e29fb 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -567,9 +567,9 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
 #define fixmap_pgd_next		((uintptr_t)fixmap_pte)
 #define early_dtb_pgd_next	((uintptr_t)early_dtb_pmd)
-#define create_p4d_mapping(__pmdp, __va, __pa, __sz, __prot)
-#define create_pud_mapping(__pmdp, __va, __pa, __sz, __prot)
-#define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot)
+#define create_p4d_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
+#define create_pud_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
+#define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 void __init create_pgd_mapping(pgd_t *pgdp,
-- 
2.34.1

