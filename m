Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B74509D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388115AbiDUKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388130AbiDUKNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF003BB9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g3so3621634pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krfRbYYatyCGds2MwYdKefUqds1k1xeRA08PwuSXA4Y=;
        b=g87LhKva3LFgGX9NzZNpu/79BTanc1X8wjAfdpx8ze2wxI6KheWccpSr/JjNXhgQ3m
         haQZJaZSSMXSNfLMhnij0+sYUqYkXOnVqJa2BJAoASVy9J+rLKdeFlA3qkobCVyMjCi0
         /8m8m79kJaG71xW5rCO7Ze+WHgUB8Pt9WFPG2FQ5i4cymN29l/pMS8Vz7KFiYhn63Gk8
         BU4+mQ2wVz5e3dkopJTRhf/QYE0m05gPc1A5krHnIbbZK/Z9AGbLvxqweM70NYfayDqS
         8t6bN7WpBYuqVbjfucMgVNsnd7OpiZ0yM3DfqomwHZjTlyMVlqIncQm2xQKU2O5Z3T6n
         9gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krfRbYYatyCGds2MwYdKefUqds1k1xeRA08PwuSXA4Y=;
        b=sCy8kMr5o5RQFKS318tlw8I8dGRnypjMxOz8eh1KNKCWbVHJ53seMk4wPXA18hswxX
         n8i9e0pgcZiCaVA4jKMWN2E+UsT7CbVAg8Tm4jSTrUvkZ7R6Fon7LVAXpQsLfxjHIqXv
         WsJHhHB3bEbmcsLCJ8HGHDvtE3bbXQ3rF0NkjfzxHbBBLFhL9kv9x5pKsdMQnERCSTM9
         pT39f5qhSqp1m5mwfys5aYRxkTk1IztEO3jLGK45YleFnATyrFCdZ611axKRwdY4taYk
         HT+w0p1G3yeRuNsZPUWdvhv4AQEhXWn7MmKBor4BBsAztbnx8z5Vk83Ej7xSGThddGbQ
         nFhw==
X-Gm-Message-State: AOAM532bWsM0OSAYnqykPTRnSKgmBhm6T+IWz786D4FxBdbA+5Wj82Di
        uCigizODoFHnWQESxqDHSV8=
X-Google-Smtp-Source: ABdhPJxyBQQGFDZ7GssPAhYSdL7AH2vid3Vy++/p2C4coonfRUHCAfORR16KjakCfPZv4j4jDb5ayg==
X-Received: by 2002:a63:ad45:0:b0:382:2459:5bc6 with SMTP id y5-20020a63ad45000000b0038224595bc6mr23929315pgo.474.1650535863302;
        Thu, 21 Apr 2022 03:11:03 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:11:02 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 06/10] xtensa: handle coprocessor exceptions in kernel mode
Date:   Thu, 21 Apr 2022 03:10:29 -0700
Message-Id: <20220421101033.216394-7-jcmvbkbc@gmail.com>
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

In order to let drivers use xtensa coprocessors on behalf of the calling
process the kernel must handle coprocessor exceptions from the kernel
mode the same way as from the user mode.

This is not sufficient to allow using coprocessors transparently in IRQ
or softirq context. Should such users exist they must be aware of the
context and do the right thing, e.g. preserve the coprocessor state and
resore it after use.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 95903f25e523..62c497605128 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -69,7 +69,7 @@ static void do_debug(struct pt_regs *regs);
 #define USER		0x02
 
 #define COPROCESSOR(x)							\
-{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, USER, fast_coprocessor }
+{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, USER|KRNL, fast_coprocessor }
 
 typedef struct {
 	int cause;
-- 
2.30.2

