Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5D4D63FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbiCKOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350341AbiCKOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:44:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6D13C39D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j17so13355137wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDiWp0YZhxRCTSM6iyT6AyMHl1Ys6xIr0uetO8EavSM=;
        b=BAoXfju0z2oxw/nRANCXQFXTU0BUto8RnqRYE+fPGznHy+rs8VmnLXUNDEu79qqrYA
         kBSH9xoEyU+gnXzzrX2o92DA3AmHfV6alKCWzix7Eh+7w49XEwcb+j1l3ABeZzqQRZwy
         GpNfjlOvw8k+GGYjK/zjUbhTCmFIzCVFnc4GIRJxWy1OtD2zLUyv9BmxoEUsp3ltQ1iY
         ko+MqNTMgQpuKJWLlDo1mfz/2YibMYyaLL8x6Dz1gVZO+Bs/hZ26JtISumoQOX3aCrwI
         y7MqxdD0GUhkSJsKfoGEB4Wqqpc3MX2OW6XmcENGiAtY5+HxiV87D8WU6GxMR7j9W2Jw
         lQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDiWp0YZhxRCTSM6iyT6AyMHl1Ys6xIr0uetO8EavSM=;
        b=Sa5we5DRUQN0jk10iMj3e4+2ynRFYQd4pmP89WmjBAIP4k5NugovJAla9IsRXvb9TQ
         2K7Y7P2Z5hYrLfleq6lceAiTlhhFEArsf1OE0FW/NADJbg5C0tRiERRbXZhgJ226qVDa
         jwC6GCYce3Esv7NCCnq1S19HbBYH9a9ANRr2C0tyvowP6DddM7NobC25dELstwrp12h3
         RWKbGrW75pU/c9Ef+e+xpjY14K1XRRL1BUS8dzrIqZD25tFg6AfSvG/5/Jaua28eAugo
         Jyxg6xwtE22W1emSXAzggiqGv55RByUXinZhxtEcVWbX5noTq6igd9Iegx4WREvTdBe0
         BbtA==
X-Gm-Message-State: AOAM532u7L5LtnP7sd3sdFpaqq7oKzL8bI2Yd76JCCkNPa5Y/FM0MWh2
        t8nWRgjCMAOrU8Ync5Eftg==
X-Google-Smtp-Source: ABdhPJwKOvBHeoA+WmReXPzZ2Gn9TgkH04wGwJtTJY5USmPvijtMbIDoiP9FU7LkqYePiXroEddu5g==
X-Received: by 2002:a5d:5104:0:b0:203:855d:c41c with SMTP id s4-20020a5d5104000000b00203855dc41cmr6862911wrt.128.1647009808405;
        Fri, 11 Mar 2022 06:43:28 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.95])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm6877637wra.97.2022.03.11.06.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:43:28 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 4/5] x86/alternative: make .altinstr_replacement section non-executable
Date:   Fri, 11 Mar 2022 17:43:11 +0300
Message-Id: <20220311144312.88466-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311144312.88466-1-adobriyan@gmail.com>
References: <20220311144312.88466-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instructions in .altinstr_replacement section aren't meant to be
executed by CPU directly, only after being copied to the real
instruction stream in .text/.init_text.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---
 arch/x86/include/asm/alternative.h | 10 +++++-----
 tools/objtool/check.c              |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index cf7722a106b3..d754a18edc99 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -165,7 +165,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
 	ALTINSTR_ENTRY(feature, 1)					\
 	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
+	".pushsection .altinstr_replacement, \"a\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, 1)				\
 	".popsection\n"
 
@@ -175,7 +175,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feature1, 1)					\
 	ALTINSTR_ENTRY(feature2, 2)					\
 	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
+	".pushsection .altinstr_replacement, \"a\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
 	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
 	".popsection\n"
@@ -192,7 +192,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feat2, 2)						\
 	ALTINSTR_ENTRY(feat3, 3)						\
 	".popsection\n"								\
-	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	".pushsection .altinstr_replacement, \"a\"\n"				\
 	ALTINSTR_REPLACEMENT(newinsn1, 1)					\
 	ALTINSTR_REPLACEMENT(newinsn2, 2)					\
 	ALTINSTR_REPLACEMENT(newinsn3, 3)					\
@@ -338,7 +338,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f
 	.popsection
 
-	.pushsection .altinstr_replacement,"ax"
+	.pushsection .altinstr_replacement,"a"
 143:
 	\newinstr
 144:
@@ -376,7 +376,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
 	.popsection
 
-	.pushsection .altinstr_replacement,"ax"
+	.pushsection .altinstr_replacement,"a"
 143:
 	\newinstr1
 144:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c33ec67c4a9..18c32035f41c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -359,7 +359,7 @@ static int decode_instructions(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 
-		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR) && strcmp(sec->name, ".altinstr_replacement"))
 			continue;
 
 		if (strcmp(sec->name, ".altinstr_replacement") &&
-- 
2.34.1

