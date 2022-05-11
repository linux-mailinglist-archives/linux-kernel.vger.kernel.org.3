Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E7522E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbiEKIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiEKIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698203134D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 204so1380720pfx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=xQ+/39AkE91LiVQ4Kr8wAA4c9UriWAJqTaLbb/7ZPVs=;
        b=SfpCeNotyMV4WtU4qnoNenmfbtHMUNvrX4pnIiOvIGTqAQAaXZ/jGZzwDQBZ8ygJc2
         TLnaW+J8N+713J2VFcZHm01b+3Up8pZC1pM0BTk4kO6gyONiOpX3Pkuau+2cZY9llWmj
         d0DdSlvrKLHfRH5NCzmwQQaEzTeVucMJSJ7gm4nmwJ7+dc3FlENOFcWkpnhYGibD9V/i
         FG0BsVfs7fKzU2MdbfHlc13e0MZOCKIayq82xy74sZCwBaOxH5Tlci+oX9ZzNsTjyYvI
         pr3Kuowifkn/6Yx6HumbY49exSgGILh/7/RAmVmIASfQeMMATBf7qsL0JD2wNxkrHUl7
         t/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xQ+/39AkE91LiVQ4Kr8wAA4c9UriWAJqTaLbb/7ZPVs=;
        b=Zye3FOmG5S8D40aDwPG5gCsgHbyD6zccd21rgmwhiuLrXe58wpWoV/XO3eqGcR0gAA
         pk7+fqIlarfFQlqWRfWtGfBWjIZpzS+4AOEF/uanPOq+N7a3MFwbNPSqXjQuSp3TLHbe
         3EHSO4+l91pnCw6jS28OQ312DECpj72VWD08QzhpUdbUWCDTirW+HdnpyCJ9vx6QOUAb
         DztsI7HJA0UKN1ebKxzb2SFvBlairHORySpMoWOk0rYVCNTZjiWYLJpSENxkKrDbCe/J
         g2mZi9a5CjwBfwLnSq+r8Q9r1xg7eCvvraALoseWWX7ldgL1G4aZ2WPunMbNPDHn2v7o
         heeA==
X-Gm-Message-State: AOAM530xXD1mxb3QbIhciVpzKPqcCTrL0F2elUXOouXIsVzZWX9Wo/eO
        5iLWeA+whAAsl/GzmzH2fnr8Jw==
X-Google-Smtp-Source: ABdhPJx14OOqONpi9lA4QVGlDX8spXGW/IUI+yFob384ZCn8UeBWK1FuA2bgig7NAFiQb5KBMGjw3g==
X-Received: by 2002:aa7:962e:0:b0:50d:5ed8:aa23 with SMTP id r14-20020aa7962e000000b0050d5ed8aa23mr24006586pfg.43.1652257890964;
        Wed, 11 May 2022 01:31:30 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:30 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 01/16] riscv: Rename __switch_to_aux -> fpu
Date:   Wed, 11 May 2022 08:31:11 +0000
Message-Id: <7bf1e003db9845e2a13eff15c33e3a490d34810a.1652257230.git.greentime.hu@sifive.com>
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

The name of __switch_to_aux is not clear and rename it with the
determine function: __switch_to_fpu. Next we could add other regs'
switch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/switch_to.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0a3f4f95c555..ec83770b3d98 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -45,7 +45,7 @@ static inline void fstate_restore(struct task_struct *task,
 	}
 }
 
-static inline void __switch_to_aux(struct task_struct *prev,
+static inline void __switch_to_fpu(struct task_struct *prev,
 				   struct task_struct *next)
 {
 	struct pt_regs *regs;
@@ -65,7 +65,7 @@ static __always_inline bool has_fpu(void)
 static __always_inline bool has_fpu(void) { return false; }
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
-#define __switch_to_aux(__prev, __next) do { } while (0)
+#define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
@@ -76,7 +76,7 @@ do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
 	if (has_fpu())					\
-		__switch_to_aux(__prev, __next);	\
+		__switch_to_fpu(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
-- 
2.17.1

