Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F8B5578B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiFWL3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiFWL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:29:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EBC4BB94
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:29:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sb34so11343386ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5PmuIo7mYW3CN+sFVEg61+n+8PCcK1fiGszLtqNBkE=;
        b=P3gPXxuZ6ksVlpTZiR36XjCGEeVdjZXDDLl4AQ/oh28NtYEm4DU9LantR/Dlct0XCl
         Z0w6zQCjHnnQ3mQ5xztonY9oSX9xHdgUmXlbzw6DyxVEQ9G3A7qPbfDy4i+zLek/np0V
         By4/BOrqGqbieW260s2Iq1bfkMoWkbzL8pWc+qxWFKZXDO2/Ug6Zqqd5f4Kf3G398Sn+
         ioQBmIUqacMOHM2JHrkc7s/vWXHFt+rOS/bW76vohiiXyhlWmY0zdemkVC/gO5xOJt0r
         kms8boIoKhlyOzgR+wY6NKkDzBXCohJPGA+ln3OpfZ3mtHgp1p485glfr4ZVtKWTU/ej
         VQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5PmuIo7mYW3CN+sFVEg61+n+8PCcK1fiGszLtqNBkE=;
        b=qxSXtVvO/9XP/HYvAybAGlt4kv7S1DtkEzw/kxyzmcVt0/YbcbLn9UNjNdXKJl+a7Q
         kidaR6ogglWvBfs6/nSIJ40BxSjOxtbcDrrNW1LyTKJMJJ8D973qRWMWFfmhpDBSlpI3
         q6eR9xH0Yfin1uD8DJI4J0FgD9KL/P0MDeUxOnssYyXAei2Ygkq+Gsm2ParPCQ8QQBJ1
         RF8tSp82nn5AZR0VWDdqcI0JinTcdAI+rY/m7QukaU8zzeRctU6Ip/gUlGZSq/Xg4NHQ
         Tnqh+V0VkjVQLtsD1nA9bRLYa8ux6ckMbAsm6zZAg40J3F+QN53U5MKnt8ZguaYngX3j
         whiw==
X-Gm-Message-State: AJIora8l82WwMh6gQyUhaaO0RjEjdAJeVNV73+Vm7Jt+XnI2bJ7ylbM9
        JxPVeSWcgp3Iwy3E+ZVR2Y0A7w==
X-Google-Smtp-Source: AGRyM1vlJNeyno6YRTMSYN5fCFkHIVRrt2/G/UFpHdTwakW1nLE5XtZkaNm9rgjUJE5W33x19uhZCw==
X-Received: by 2002:a17:907:da1:b0:722:bc0b:4f4c with SMTP id go33-20020a1709070da100b00722bc0b4f4cmr7761188ejc.761.1655983748760;
        Thu, 23 Jun 2022 04:29:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090614cb00b00712057b037fsm10268110ejc.167.2022.06.23.04.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:29:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] riscv: traps_misaligned: do not duplicate stringify
Date:   Thu, 23 Jun 2022 13:29:05 +0200
Message-Id: <20220623112905.253157-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Use existing stringify macro from the kernel headers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/riscv/kernel/traps_misaligned.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 46c4dafe3ba0..378f5b151443 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/stringify.h>
 
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -150,9 +151,6 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
-#define STR(x) XSTR(x)
-#define XSTR(x) #x
-
 #define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)			\
 static inline type load_##type(const type *addr)			\
 {									\
@@ -207,9 +205,9 @@ static inline ulong get_insn(ulong mepc)
 	asm ("and %[tmp], %[addr], 2\n"
 		"bnez %[tmp], 1f\n"
 #if defined(CONFIG_64BIT)
-		STR(LWU) " %[insn], (%[addr])\n"
+		__stringify(LWU) " %[insn], (%[addr])\n"
 #else
-		STR(LW) " %[insn], (%[addr])\n"
+		__stringify(LW) " %[insn], (%[addr])\n"
 #endif
 		"and %[tmp], %[insn], %[rvc_mask]\n"
 		"beq %[tmp], %[rvc_mask], 2f\n"
-- 
2.34.1

