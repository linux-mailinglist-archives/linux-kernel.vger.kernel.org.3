Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8C4D63FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348846AbiCKOoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350338AbiCKOoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:44:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D541143474
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:29 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h15so13262793wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5gE0XdXqC9gHtzyBCIQLq6aY5RtsqXs8k1BMQmBKKU=;
        b=c+uBxTtavAjlE8clrAPrLRJ/9DhvuU1SwA+nwyp8/ZAxGgSW8hGu5F/XaTsELWX6vl
         UkXNK5l2q/NcNdEb/CaRrI4WUlbcCoV+MSxUphhTewr+Wxj1PLWESlbkZXXSE12lwbbx
         fBGhEbKYNAdCJRPO2Hhney/0BfkHQ9JgBHDL3A54g+piOfTbX+ryZ/z7J1ROY+1AbCfa
         QIF0vkgDOZdYMF6dkw/2oAm0Uvr+2cn6W5cgabTAML7Dd/JdCG/GQ053tNmZsLPKg4Dt
         068XV0tQDa03UqR+3d2ktany+NwRrjB5jnhKXeIVOm/KJzAGhQmURjWWLfy1pB6lIKbQ
         UCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5gE0XdXqC9gHtzyBCIQLq6aY5RtsqXs8k1BMQmBKKU=;
        b=i3+EFJmdK3AQR6BnBFR4YyXuneCjzpRMfiJKLjP932CR17Pgp3Vsk8urEprM0uBX/y
         23QLfpoZGSjmrxsBS/DXee4cf+33FtlCw/xKu34CU3Jvegk5uP6G4YHnDCsJvAQHbyxx
         iwws9W9GXpm4Za1quiVxJZZBrtP6kiA9unAVeLCguOkZELEtkjOlnJ4pSRJkacR3IxKR
         TTNYv4+OMHuRSi6zXOIK8W+JNjMJf1qbn5VuimC04CY8TMFnIXWJKyr/dHg8PKjEuAcg
         K2yIXVO167bu5R7MZbXmdVaee/Dis/Fj8LslYwwk1c6mdUVj5XUulxY8IJgYdxk3sM9f
         elMw==
X-Gm-Message-State: AOAM533e/2k/KsgXVsu7lOWwcPjtRRIkEe4ASZMA2O9oZjtpZ8/xHnjP
        rTIGEHbGzSqIzO97PJjdJQ==
X-Google-Smtp-Source: ABdhPJyQf/F8/15x4l4UbG7zE/rKsIvASGHEc0YD+SjcLxdkxuqtjDruRAyV31Jjh3Wn8GeEe1cmug==
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr7749533wru.212.1647009807615;
        Fri, 11 Mar 2022 06:43:27 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.95])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm6877637wra.97.2022.03.11.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:43:27 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 3/5] x86/alternative: record .altinstructions section entity size
Date:   Fri, 11 Mar 2022 17:43:10 +0300
Message-Id: <20220311144312.88466-3-adobriyan@gmail.com>
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

.altinstructions entry was 12 bytes in size, then it was 13 bytes,
now it is 12 again. It was 24 bytes on some distros as well.
Record this information as section sh_entsize value so that tools
which parse .altinstructions have easier time.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---
 arch/x86/include/asm/alternative.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 58eee6402832..cf7722a106b3 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -9,6 +9,8 @@
 #define ALTINSTR_FLAG_INV	(1 << 15)
 #define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
 
+#define sizeof_struct_alt_instr 12
+
 #ifndef __ASSEMBLY__
 
 #include <linux/stddef.h>
@@ -66,6 +68,7 @@ struct alt_instr {
 	u8  instrlen;		/* length of original instruction */
 	u8  replacementlen;	/* length of new instruction */
 } __packed;
+_Static_assert(sizeof(struct alt_instr) == sizeof_struct_alt_instr, "");
 
 /*
  * Debug flag that can be tested to see whether alternative
@@ -159,7 +162,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, feature)			\
 	OLDINSTR(oldinstr, 1)						\
-	".pushsection .altinstructions,\"a\"\n"				\
+	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
 	ALTINSTR_ENTRY(feature, 1)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
@@ -168,7 +171,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
 	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
+	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
 	ALTINSTR_ENTRY(feature1, 1)					\
 	ALTINSTR_ENTRY(feature2, 2)					\
 	".popsection\n"							\
@@ -184,7 +187,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
 	OLDINSTR_3(oldinsn, 1, 2, 3)						\
-	".pushsection .altinstructions,\"a\"\n"					\
+	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
 	ALTINSTR_ENTRY(feat1, 1)						\
 	ALTINSTR_ENTRY(feat2, 2)						\
 	ALTINSTR_ENTRY(feat3, 3)						\
@@ -331,7 +334,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
 142:
 
-	.pushsection .altinstructions,"a"
+	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr
 	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f
 	.popsection
 
@@ -368,7 +371,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
 142:
 
-	.pushsection .altinstructions,"a"
+	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr
 	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
 	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
 	.popsection
-- 
2.34.1

