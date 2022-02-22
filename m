Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E84BF8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiBVNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiBVNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:01:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C1558F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:01:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lw4so42691450ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9YLfdLDX50M/ZkhtC5IB+zCV0i6JtJQXN7NqFd+CRpY=;
        b=i8pfb9alhkTcpLZj0VvRWw/SByHorpH2HXvfuMZjGoh0KKG0Vhepn7lR2NSf2v6bBs
         dxZrjMmM3LzSvKkkfIHKKT9MhOub4+fHYWtfcajasoGut28hS4ddFrX0DEEyBxqTSpZS
         8AmOb4HCThgAlUmdvwC4ywVwJ+3jp3ZNtqKiPHv/edcW6y6LLdZtM8dXt4i+SvOPAjUn
         vIL7Y8oHT9HjQuUFXx+3kjtF0WqlMDdZfmf75WeHUySDsjTAfnA2EXYLRyqlYyG+rYz6
         H0XBCTwxUaN9U7y5y7Tp0iK6XOSBX3xwdVwoYLmE257N9gLUfXF50Yxdyy20ooX8V4Zg
         t1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9YLfdLDX50M/ZkhtC5IB+zCV0i6JtJQXN7NqFd+CRpY=;
        b=JfLOiFzHxRQoNKDsOChfLEiRnlYG8Qy6MogiEnt9FqGM/0gLSPey6NMOf1wSo6RqKP
         LBpSFucTuvVzhRw8KKZSe8S9YNqTS9lEJOK3aKMvgJDkfMFcskIW8CkdoZDYJcJGTlsB
         fCgbZ5jUaB0i438xM1XeIRp9CkUe8uOEgl2w0AM1p9045ooep3WhlalYlGcFYWca1vbU
         163JQgGvRaFqfMNn6YaAAMCZqT8tKu724P8wZmw20+Gn2xyRJ8Tc6CKmTYlOhlAQ/rXf
         0oA6iewnEV3hvLh+RilP8qJePwH23i6HGfUeQvsEqAdZ4vO7VKjTgAncnqOH8djG2jBI
         jxjg==
X-Gm-Message-State: AOAM533JIfTniB5pcn5B1vC6x1wIvtc/UJg0dXaqH9n1AY2TO1EQkOpd
        HZaRmrxX+dGD+iHyp93d8g==
X-Google-Smtp-Source: ABdhPJzneJDSRlyptDo027tAxgL8Jf7Ldl0E5HRf6E2QMhw4MnNh/vfaCAgpzooFtZe+EkJWk0ydow==
X-Received: by 2002:a17:907:9691:b0:6d1:711d:9050 with SMTP id hd17-20020a170907969100b006d1711d9050mr8154251ejc.755.1645534890128;
        Tue, 22 Feb 2022 05:01:30 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.189])
        by smtp.gmail.com with ESMTPSA id s15sm6291542ejj.84.2022.02.22.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:01:29 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:01:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86, alternative: record .altinstructions section entity size
Message-ID: <YhTep9uK8kLdTOsY@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
now it is 12 again. Record this information as section sh_entsize value
so that tools which parse .altinstructions have easier time.

Dividing section size by 12 or 13 and looking at the remainder doesn't
work because the number of alternative entries itself can be multiple of
entry size.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---

 arch/x86/include/asm/alternative.h |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

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
+_Static_assert(sizeof(struct alt_instr) == sizeof_struct_alt_instr);
 
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
