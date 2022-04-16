Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEB5033A8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiDPE3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiDPE2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793D4FDE31
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so13156703pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ncZocJ5Upo0Tlz4v6e6Y6+ABw2qemtuw7eXleVpkeo=;
        b=prrB44LhcGKKkVWfcFLerPI4WtP/au6LgaWr69RxUqf11mkFrpvZm4bK9lTXohOH9l
         1pACxD4KlqhcT5RoinA7VnR2s4c3Ls9RVJCYVpqb79MYkgu5pK+Yn+HmQy99zjJ1NxRy
         40mh/u6gN0HoTVXoLIPCH9xNrc6ozOmy4qRRRJDlX6IMcaP7mLZWRPICFEg+NoKHYSIy
         3CZzcK0XyWgrbgESGifGwFUx35ztV5KSV9zYZHOd+w9Ug47azjTzZuMArl4CSx6BLukQ
         7WTAKIlDRn90PdhhFf+HVI/FZRHivQG1T+mLf77HHFbwZDd3MuiMPv96N3UXwtflqg3B
         y7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ncZocJ5Upo0Tlz4v6e6Y6+ABw2qemtuw7eXleVpkeo=;
        b=gYzdkcLghjdgk3mlGzZTp39ppocN5eKFHLCiIWw02DPl44tZ69PferFifp8iEgbz+7
         jrgvPTaDhKpJUBvj4xxQ9fy+ltsunCiWUrrujNlVm0fRKC5xfenf/EeUNs54xV4Gk33w
         ftjp8pTjrQW/UR+7bEhlhXeQL+7ctdqwSZkJ73pGlK8v352cx4nPNKOxR33joKBNMPmO
         FoJV25Rw1w2NOEfFIykNeEj3+lcGpmM6mc2ui4TU7o2UjXtA+sftoVVy7tGkM3jXBz+Z
         AFhM2C2QYc+NpG9Q2EyU26I7iaKuJz1AJ/yvdZeE0Cwbu8L6ucZVpCdpHMj/1oKih5Dc
         MJsQ==
X-Gm-Message-State: AOAM5305o5z6XH/6+w1sLAtMwDq38PNbtB9MjnQV++aO/LzUo0QwPbyK
        ITz67UKYjyVpW8VkmFDfQP6FfhgZtt0=
X-Google-Smtp-Source: ABdhPJwfkJJ5f7A/rWC5feyPWZqOk2QyZtRy5EfFr9HUSoSTzi8+GzCZHt1Nhri9K8fIewRoJuSO0g==
X-Received: by 2002:a17:903:40c3:b0:158:a5a0:3c75 with SMTP id t3-20020a17090340c300b00158a5a03c75mr1862435pld.17.1650083183936;
        Fri, 15 Apr 2022 21:26:23 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm4258513pfo.211.2022.04.15.21.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:26:23 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5/6] xtensa: add xtensa_xsr macro
Date:   Fri, 15 Apr 2022 21:25:58 -0700
Message-Id: <20220416042559.2035015-6-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
References: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

