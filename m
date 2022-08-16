Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9659604B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiHPQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiHPQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:31:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D27FF8C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:31:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w19so19922442ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zQV/5VT7wDalmkEhlghHzSuKJXiFKNeXoOeTjzFLGpk=;
        b=CAbU+smotGSq8NH4wYkOstoaMnYiFDhJwY6nrngetrdZ/mJm6/jTaIqqLaGPW30O10
         ZPMiWKhTp58dBD5Ntrss1tFjKNz1xRr7g4dy+jzKSqTJRl+51VJOqZBH8d4xKgUoIpN+
         AiJJ/PX/V4eJsxt2SYRVVb3V+v70ARkV2TjPDAPUqu4ckg5GXKtVRH2X/JKOEc4DnukI
         Ei+99QevtnywDfNadIB1PROfUmaw4YB6gXB8/gFcqzbJbl/GTx7g80v7RjN4FAeXb9tx
         digxmK7PCQNHpztxtFJDj5ro22pMCBNqdy7F4imn3cBFP4p3HZxrPqEo/MEgEC0m7QtA
         2VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zQV/5VT7wDalmkEhlghHzSuKJXiFKNeXoOeTjzFLGpk=;
        b=G7xLY5xbRwA+kMS7wbLb1SJFPHZw9o9BPspLl5KwbLS9yZ/O/PQdUk5/f2XkJVsmkJ
         k5lDd/h04qM7sdD6qLCqNnbzeVhjGSc6H1myqvZDEX8leStWTg85grrZn79/jmQ18EJu
         ewZK+/oenbW41kdU8A5oyNyB1BXqSrLfG6tqVysaFVr5saMiXY5HYRRYFlG6h6kbiSqz
         DoKLDfEEkSWJArzyz9QtSxtqlb4IMPpdu8c72VN35Zoh37Ad5KwqO2OK/tZTU5uYpEYy
         EnNunaiufUXr0BXkWRGcKVRzvbJYa0S+aC/jHqwyFbpQ8ZNF3pjeqSZNVpSz/E1/hVIu
         mf0A==
X-Gm-Message-State: ACgBeo0NSs5gzSsBrmd3kTbfOzEXCwYP3wHznNTmuGyyED306eGElSBY
        JYZIrXL1Yi1KaHQbvStrQaJK2w==
X-Google-Smtp-Source: AA6agR4GtDno2qO3fgrQ9XAPgCZKZowFbrnnmPr+RSngGYDTP4QSH9ExK0n5/ZwnuuaI+FgJxxrvhA==
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id hp33-20020a1709073e2100b0073092bb7fcdmr14039523ejc.170.1660667459930;
        Tue, 16 Aug 2022 09:30:59 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id r30-20020a50d69e000000b0043bbc9503ddsm8730819edi.76.2022.08.16.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:30:59 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daolu@rivosinc.com,
        jszhang@kernel.org, palmer@dabbelt.com, Conor.Dooley@microchip.com,
        re@w6rz.net, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] riscv: Ensure isa-ext static keys are writable
Date:   Tue, 16 Aug 2022 18:30:58 +0200
Message-Id: <20220816163058.3004536-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-type: text/plain
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

riscv_isa_ext_keys[] is an array of static keys used in the unified
ISA extension framework. The keys added to this array may be used
anywhere, including in modules. Ensure the keys remain writable by
placing them in the data section.

The need to change riscv_isa_ext_keys[]'s section was found when the
kvm module started failing to load. Commit 8eb060e10185 ("arch/riscv:
add Zihintpause support") adds a static branch check for a newly
added isa-ext key to cpu_relax(), which kvm uses.

Fixes: c360cbec3511 ("riscv: introduce unified static key mechanism for ISA extensions")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 553d755483ed..3b5583db9d80 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -28,7 +28,7 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
-__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
+DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
 EXPORT_SYMBOL(riscv_isa_ext_keys);
 
 /**
-- 
2.37.1

