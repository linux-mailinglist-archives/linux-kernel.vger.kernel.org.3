Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF054E7849
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356968AbiCYPqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377707AbiCYPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3CE6AA62
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:06 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j83so8536698oih.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkQ3UAnjoomD8VPxDQGaMS5VaJH8YbqKgUsD/Zma4MY=;
        b=oHx4JAwEXn6GgCr+ZlOFRzGIUkK0CECP6r/qt42JKzUphuz+H/VDiuqheZ04dJwsT6
         307WVSAq0IA86aW/+QsuCOA9/PLxOViIUIQjxy4Q+cCT/GreOe0OKft4athJv9c7CbRR
         DL11Z4jdKXHyL7vqWA42Tas8kFpsxN6KqL/a3ax+7bfyUVgjeyP6ACcPnw5L89o2Uh63
         p5Z6xrr+nM/d1tEevU+Z735CzBmujtKa+aAWH3QzUsOnsoWZJ+Gu7Dw4Ml2NfQJU5An0
         rBYjT5sGhy/N6FXFAVVNAO+EtfE0+KX0BhPQRbeux2o9xfWzR+X2ltQB9GBR0LnW2VEt
         nC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkQ3UAnjoomD8VPxDQGaMS5VaJH8YbqKgUsD/Zma4MY=;
        b=iMjadUxEHWXSDX0H3qtCU8qXumoxslK80fNhPN18olpT09l9qtqU+ecIpOZssiuimQ
         ntclcMOnLFD4vUfkeKGt7hLanD5kuXaphVWk/0aOaKa2+q0qwpj1E9DK+/Ms/8tFpUZ3
         GM6kCkH/m3hCkU3OqdEjtSfF/sgapagVgVwGsMr6trBPhGK0M0N9wD2OTWy+2g77G1e+
         zhnUl7U5C0qOfX6gX1GTotBKvj6IRSbboV0IRD5zL0p2TVZ3M/zDWNdngcc5PlCdjskm
         oRvYKnHP99zzASKdYM3aYoL0O0m1D0+XKt5/0aysRDe+kMwECuJhkaTP0XvzzSsEgrEi
         9fFQ==
X-Gm-Message-State: AOAM5321qroDs1e6YDyeazI/6TD4xqJRadlY0Bf8qruabaupVBe1cf5t
        yHn+tb6D7+jvlJO34CHc5KDA6Ewd+Q==
X-Google-Smtp-Source: ABdhPJzj0um+If716xMiZgaCy/MNm0hDqSyOGI5g04+AFHHXshTc7Caduux5+8RXnKQ6uJXK7F9kGw==
X-Received: by 2002:aca:6742:0:b0:2ef:7242:35de with SMTP id b2-20020aca6742000000b002ef724235demr5516422oiy.166.1648222805669;
        Fri, 25 Mar 2022 08:40:05 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id el17-20020a056870f69100b000de9672ac3csm1709566oab.52.2022.03.25.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:40:05 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/4] x86-32: Simplify ELF_CORE_COPY_REGS
Date:   Fri, 25 Mar 2022 11:39:50 -0400
Message-Id: <20220325153953.162643-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325153953.162643-1-brgerst@gmail.com>
References: <20220325153953.162643-1-brgerst@gmail.com>
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

GS is now always a user segment, so there is no difference between
user and kernel registers.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/elf.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 29fea180a665..cb0ff1055ab1 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -116,7 +116,7 @@ extern unsigned int vdso32_enabled;
  * now struct_user_regs, they are different)
  */
 
-#define ELF_CORE_COPY_REGS_COMMON(pr_reg, regs)	\
+#define ELF_CORE_COPY_REGS(pr_reg, regs)	\
 do {						\
 	pr_reg[0] = regs->bx;			\
 	pr_reg[1] = regs->cx;			\
@@ -128,6 +128,7 @@ do {						\
 	pr_reg[7] = regs->ds;			\
 	pr_reg[8] = regs->es;			\
 	pr_reg[9] = regs->fs;			\
+	savesegment(gs, pr_reg[10]);		\
 	pr_reg[11] = regs->orig_ax;		\
 	pr_reg[12] = regs->ip;			\
 	pr_reg[13] = regs->cs;			\
@@ -136,18 +137,6 @@ do {						\
 	pr_reg[16] = regs->ss;			\
 } while (0);
 
-#define ELF_CORE_COPY_REGS(pr_reg, regs)	\
-do {						\
-	ELF_CORE_COPY_REGS_COMMON(pr_reg, regs);\
-	pr_reg[10] = get_user_gs(regs);		\
-} while (0);
-
-#define ELF_CORE_COPY_KERNEL_REGS(pr_reg, regs)	\
-do {						\
-	ELF_CORE_COPY_REGS_COMMON(pr_reg, regs);\
-	savesegment(gs, pr_reg[10]);		\
-} while (0);
-
 #define ELF_PLATFORM	(utsname()->machine)
 #define set_personality_64bit()	do { } while (0)
 
-- 
2.35.1

