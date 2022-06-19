Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E705A550D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiFSXSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 19:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiFSXSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 19:18:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986D6418
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:18:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m14so8268688plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJnRSYwFFbA1z5RItbH0NQEdcdfXyAPGLJWjJYDa8ik=;
        b=PRPcKBAVLRg6b5DqsLtdYa5C6MnAQGCLVwiIdenw7M+JxCHY0i/TSi4SSzQ4NsIjhC
         7vnNZNTdqgvNpXB0vi/Zzk+8ehX+f172iFvgFXi/mVEERpdx1ymFv9O7vhhrycPXkyRr
         DmYAbc5hm7ZTgAAC5HzaKBG9iApK3//2MS9temQCL4BmM0UfOP/otMpb0wLWvZzPHxLy
         Fq3SA6KGVfvugX5L2sCpmuoaez7xuc8nL5KidRdeVtQRV6wmaaWezDiv5BO4K0K15KyN
         QjVG2KIwYRccfmgmbtltozukiB2m6skKxf5H+6VfQaakbTqCjDemb9Gg16IS3clIaFrE
         LEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJnRSYwFFbA1z5RItbH0NQEdcdfXyAPGLJWjJYDa8ik=;
        b=ubgMzA5oN6JxqlH7qyZjv5+okLMTfdoGu2hRjFR3NFyJ++hO0L7I29xaZEQ9b9V3cF
         fHVLi7CZpWE9PWRsvcJg5wz8G4w9ELQH5ZWwMWAsbffOym+QNxNHgK7aVx0RFPxaSuso
         Pc+9YhotOzGX3AZ/DjWW/ulAKKmV4mcpUq2iC1gfn68pz5dbhPklzQha5bJE9tkA1clf
         TJZ9/5L79G1byNbT/HT7TL/JF6Id/Yi5Dq9wDKkorjWeDcmhwDHxrLP/cs8Ccugqh6gy
         aPTInVjnTiXHN2cAc+c6Yf/aU0H8uoI9fdDCr654OyugzEekjrnMfksXfIwWBwL6Gj+s
         a5pA==
X-Gm-Message-State: AJIora9UW9ZI3Hi+KB52Q1eHkR7QQTtTPaPcE4h/YTHH+AYr5pnJ0Sy8
        kEO2gac0s59Uxa7wJlKjLa8=
X-Google-Smtp-Source: AGRyM1s0BtZp4+k5tlBq3BmazcM0zNeairHrbKwFmoo8IUMgcvX/DMNXayKzmVcOEv/6KdxEuw4gGg==
X-Received: by 2002:a17:90b:350d:b0:1e6:7780:6c92 with SMTP id ls13-20020a17090b350d00b001e677806c92mr34649739pjb.46.1655680727806;
        Sun, 19 Jun 2022 16:18:47 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:c443:f10c:f501:dd9f])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090aa58900b001e2f6c7b6f6sm6807016pjq.10.2022.06.19.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 16:18:47 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] xtensa: rename context_tracking_user_{enter,exit}
Date:   Sun, 19 Jun 2022 16:18:36 -0700
Message-Id: <20220619231837.1150499-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619231837.1150499-1-jcmvbkbc@gmail.com>
References: <20220619231837.1150499-1-jcmvbkbc@gmail.com>
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

