Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D113B509D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388173AbiDUKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388132AbiDUKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B111A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h12so728838plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ncZocJ5Upo0Tlz4v6e6Y6+ABw2qemtuw7eXleVpkeo=;
        b=GxeC1J4vIS2+nci1FssatJn2cr0PL2yiEEkCFTAXrc6vp/Hdak0blA8sEU7aaUiQZO
         iY0df4KkxlBC2WdN751BCw+N2+eyltOv4WK0jnbD39oL2OpbAEu6KxN69JZahH7VmJdN
         k/bg8N2AmEbhcHMv//taWra5dbJC5yHokEa13D0vHBuFbH2KVWyzazzaWPWf75R6hm+q
         UfWHYxZWC5aNG6WFkhWSgUIlHxeIvBU0OJo3SR5LBeQtjlR/MYTcWnHOajkiCqH4naiR
         oBC4iVbVs44xhsxoY3b86g3jJUXgsgl6o/ybA0aIIvelm5smPoDF/g2guC5M1h5k3GU7
         IN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ncZocJ5Upo0Tlz4v6e6Y6+ABw2qemtuw7eXleVpkeo=;
        b=G18XFqvCTUKG7wsujZPCUhHKQvXuKXvTPoH8+04sppPCzd1ATTC/hysRpY9AzJvqZn
         JZD8sFoJ1pBLHkb639NjgQ+QKv4orAMAbyUWlYt2RngLncdm94n8da+le0tV4YKqTYGa
         nOcGsrTEip0S3bSiq+1LFeH3cYIYuAKGiYiSCplA38i39G65t8eG+eibGiOGfAbZNDkZ
         RXif8ZLUBb2hfjHg6WjjbWLsMP2Xt1hZoTfvZHgK9OFe3S47C6hmYnKwjKKDrRUl684S
         2Dnvd5/nRZMerVBUcVAWkCuNSMEzFM+enbomeA18Ps/QhVxFAT8Nu0zMb6cVb9+pbBtM
         8m8Q==
X-Gm-Message-State: AOAM531Zd4ucLLsb++0weaT7Q++JiCQiWzCXWWvYtIULABHgpralzn2R
        TenfTl2D2q4NBWyKTZjLEVoqX9jluikOMfl9
X-Google-Smtp-Source: ABdhPJw5iQLhLc0cXQJtig5GDsbvs6FR4G2vZL4RO7TETYS+6jdWbG3N3AmwhGxg2lJGYpUToXV/Bw==
X-Received: by 2002:a17:902:ab96:b0:159:1ff:4ea0 with SMTP id f22-20020a170902ab9600b0015901ff4ea0mr18414042plr.60.1650535864712;
        Thu, 21 Apr 2022 03:11:04 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:11:04 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 07/10] xtensa: add xtensa_xsr macro
Date:   Thu, 21 Apr 2022 03:10:30 -0700
Message-Id: <20220421101033.216394-8-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421101033.216394-1-jcmvbkbc@gmail.com>
References: <20220421101033.216394-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa_xsr does the XSR instruction for the specified special register.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/processor.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 4489a27d527a..76bc63127c66 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -246,6 +246,13 @@ extern unsigned long __get_wchan(struct task_struct *p);
 	 v; \
 	 })
 
+#define xtensa_xsr(x, sr) \
+	({ \
+	 unsigned int __v__ = (unsigned int)(x); \
+	 __asm__ __volatile__ ("xsr %0, " __stringify(sr) : "+a"(__v__)); \
+	 __v__; \
+	 })
+
 #if XCHAL_HAVE_EXTERN_REGS
 
 static inline void set_er(unsigned long value, unsigned long addr)
-- 
2.30.2

