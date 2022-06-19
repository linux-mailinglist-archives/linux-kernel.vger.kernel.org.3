Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B307550D80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiFSWmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFSWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:42:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328636300
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:42:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d13so8195671plh.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJnRSYwFFbA1z5RItbH0NQEdcdfXyAPGLJWjJYDa8ik=;
        b=ExFC/Vv3EqyC5xTKbTwwGdx65Svmf7QXfGR8MpwLkNbDcyp4nJg2XO9fTY40V3XsBB
         c53H8oRmQ8b+n3Y+7w/gEYCme1GhkOmu49dwJYiQzm6T0Rwycm1YBJBuoAw6Ea7JKJJo
         /kvDfC+myCHbicGu6/CvkBVQgDQ5qQxGCm9sqnC/2zyuQzOxcrT13ZnPi9Y0Mv2JOr08
         kIWAehKWkhBaHT+lJUJ3mVnJj7T7U/jxdaWrtThIatdC4i1Mc0MRosh3qm3eKT1LP+Lw
         6jzXGNJZkWnBLPzeTQzMsa9PFz4QljhxHfu6HJNS9JuKeDc6+wB7KACML9tvPmopEHES
         R2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJnRSYwFFbA1z5RItbH0NQEdcdfXyAPGLJWjJYDa8ik=;
        b=r+VM1Aqab1yzyE9G7saVpPvL+aYKzj7snBoXJ4JX7HkVwaRpzz2zBAOgxkJOr4BF1U
         VR1XsUKiU3K3ZOfc26xpz5BrjTJaG6OUvf78h0p3iH/5yPJEnVK7ro6s+qFgYs3s4yzP
         jhSp7Se9ql2UOJ1QZD156dSLBYe85puaLo6N3ALJTntXa5I+UfckpxVtcDF3pYB6IRc2
         aICYSA/jEAsBFlVwcX+EhiRqjAfiiDgvogpkR+tIhgRJEpxdnmWUzzWFvB/Y9K4f5YpX
         vCUmvOQJqqFA00FHW6VcT5vktaznu6nz0S/IhNHQcBQmuEI1nWyW7YRw2+fjSeLlmAET
         2rYw==
X-Gm-Message-State: AJIora/Ro04PkbOkYZ58y7XMBeoGpCZNZe4DfezTM6YBmPbzuqpg2Fgy
        iZFt8cA2xKLz66RC4dA8HiU=
X-Google-Smtp-Source: AGRyM1sjAyolFpLvFjS735XkMcvXFjUi8l6Q8JfxO9BfG5pdOgiESpFFgGeFx3WafWj3yZbIpkH+DA==
X-Received: by 2002:a17:90b:388f:b0:1e8:5df5:b2a3 with SMTP id mu15-20020a17090b388f00b001e85df5b2a3mr23686090pjb.70.1655678521676;
        Sun, 19 Jun 2022 15:42:01 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:c443:f10c:f501:dd9f])
        by smtp.gmail.com with ESMTPSA id m22-20020a638c16000000b003fa95b940bdsm7733583pgd.88.2022.06.19.15.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 15:42:01 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: rename context_tracking_user_{enter,exit}
Date:   Sun, 19 Jun 2022 15:42:01 -0700
Message-Id: <20220619224201.1063325-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This fixes the following build error in the linux-next:

  arch/xtensa/kernel/entry.o:(.text+0x4): undefined reference to `context_tracking_user_exit'
  arch/xtensa/kernel/entry.o: In function `common_exception':
  (.text+0x1ac): undefined reference to `context_tracking_user_exit'
  arch/xtensa/kernel/entry.o:(.text+0x14): undefined reference to `context_tracking_user_enter'
  arch/xtensa/kernel/entry.o: In function `common_exception_return':
  (.text+0x20d): undefined reference to `context_tracking_user_enter'

Fixes: 29765ae224e4 ("context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index e3eae648ba2e..d72bcafae90c 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -458,7 +458,7 @@ KABI_W	or	a3, a3, a2
 #ifdef CONFIG_CONTEXT_TRACKING
 	l32i		abi_tmp0, a1, PT_PS
 	bbci.l		abi_tmp0, PS_UM_BIT, 1f
-	abi_call	context_tracking_user_exit
+	abi_call	user_exit_callable
 1:
 #endif
 
@@ -545,7 +545,7 @@ common_exception_return:
 
 .Lexit_tif_loop_user:
 #ifdef CONFIG_CONTEXT_TRACKING
-	abi_call	context_tracking_user_enter
+	abi_call	user_enter_callable
 #endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	_bbci.l		abi_saved0, TIF_DB_DISABLED, 1f
-- 
2.30.2

