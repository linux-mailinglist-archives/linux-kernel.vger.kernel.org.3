Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3502505D52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbiDRRPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbiDRRPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A29205E6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso14619423pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EczBgSrH2S/KZGWpRphduxUxnAnNXtm2R6frAPGuEZk=;
        b=EUAqnJDbpIA/Y7va/xIASz/J56PcYmJzvt7wqzCFE6UI48jubb8e8HZNWni8jozFrZ
         FbZjuEtRgfLi18erfhHPJZ+kR8jJ1n2rkX/cM6+r/rBV2DVNaWab0awGfMZ1JEE04BKT
         17zEaIWmmA8/AQkB8XuzJ9QQEPCt+F0x4/h//nLVAWyBXql/1NwaU31FLS5y5NCa3eec
         JEe+Zqwq/tvaJiYuwf1XPNWfN5sN5A4DW34AL5fmWofFIdKxkQ8gEYEzpUHGqv0J3B67
         BcVNolgE3XBYItsTpt/MlzFsaRa9trTVlBlANZj5ZW2BgE6ZB5erqO+Siua8PiAgfV32
         ue2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EczBgSrH2S/KZGWpRphduxUxnAnNXtm2R6frAPGuEZk=;
        b=0496U7wZl7Fr5sXus87XHhbRaUA0BC2RvKxe6mBcdp2KxsHFx4s3LJo3eauHIuy/gI
         rfp4+k7Ea/6vX4RgNgb16BXcucxi7e85IpRf/eZG8s01hziXIJiA9UAr1d1w9WuutN6V
         fD/cCdwF4Q+AfXoXniZcKDLoGeqiUfOIx0kcx9mQix8eivuByWWdzu9KOhG53bB8Mn1p
         g2V1PJMOHx/JODWMW7H+83XUkPZBMehZ6JTTEPLFsgtb1otB4bAxLwiv6XzAlesn8cHJ
         6MvXHlzhs7b7PE0z6XbjG9JHm4nhlsY4UNMaPFH94XuL4AqUU04YzkOJljknSwfCKgnt
         GXZg==
X-Gm-Message-State: AOAM5316uPsuNSYP3yeY5zIEtw/OwXGCasfa7IHBbjzKU01pPz6Rv7/i
        8wTWa16W6KNNXCAxIedLU37XCS8zZhw=
X-Google-Smtp-Source: ABdhPJzho3bEGmPO1L6ubBM5Kahyw7ugp862MrHda+qnPqa++tNNLj6M/co9uD3OUfPW4AhySLlKNw==
X-Received: by 2002:a17:90b:4c45:b0:1d2:abcd:be49 with SMTP id np5-20020a17090b4c4500b001d2abcdbe49mr4298011pjb.193.1650301945715;
        Mon, 18 Apr 2022 10:12:25 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3f09:380c:8f11:5a8a])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0039d1c7e80bcsm13637138pgi.75.2022.04.18.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:24 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/5] xtensa: drop dead code from entry.S
Date:   Mon, 18 Apr 2022 10:12:01 -0700
Message-Id: <20220418171205.2413168-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
References: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
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

KERNEL_STACK_OVERFLOW_CHECK is incomplete and have never been enabled.
Remove it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 6b6eff658795..3c0b1aac7aba 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -28,15 +28,6 @@
 #include <asm/tlbflush.h>
 #include <variant/tie-asm.h>
 
-/* Unimplemented features. */
-
-#undef KERNEL_STACK_OVERFLOW_CHECK
-
-/* Not well tested.
- *
- * - fast_coprocessor
- */
-
 /*
  * Macro to find first bit set in WINDOWBASE from the left + 1
  *
@@ -350,15 +341,6 @@ KABI_W	_bbsi.l	a2, 3, 1f
 	l32i	a0, a1, PT_AREG0	# restore saved a0
 	wsr	a0, depc
 
-#ifdef KERNEL_STACK_OVERFLOW_CHECK
-
-	/*  Stack overflow check, for debugging  */
-	extui	a2, a1, TASK_SIZE_BITS,XX
-	movi	a3, SIZE??
-	_bge	a2, a3, out_of_stack_panic
-
-#endif
-
 /*
  * This is the common exception handler.
  * We get here from the user exception handler or simply by falling through
-- 
2.30.2

