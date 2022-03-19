Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7004DEA89
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbiCSUMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiCSUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:12:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E19AE7E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:11:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z3so9627850plg.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xuLvsF48G4bEmQ+Xadib75DXEx62ohD0fiQNUuk6D0=;
        b=na2k4f/etI3FYItI0t7xAYPi1yoo5d90dhKBG8WYuHARX1xZzWYihnRV2yXDU561ii
         rN1FaKtjvOEm128jtS+aENG/RWlSbQYCUHGiFTNt73VtkPRMhh83hBKULotVJy8N2zU/
         s6oSXcK3qkTKUnY7q3iOL/dAg3olIAxm9MAHeQRX6WVKH9h9xd5dwuwj9/nLYTQ91D7c
         SHG4UniZoWjbMotVt7S2VduljI8Wh+cOGV5R7M5tqAnC05JewQpPh89+l1wMGJyRmNN/
         0kxi5Xs9Kgyu2mnZNmz1KtXG/ecmnUQJOUBgANui9SGbJUuw+uvvCRdl94ruQXucYd6J
         wQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xuLvsF48G4bEmQ+Xadib75DXEx62ohD0fiQNUuk6D0=;
        b=5/jv7jrGI2SMY9m/u3HjvAWoQy6eqlAKBTTSbPcnZcMdXeiu435Z+TsL5dCav+Clqx
         riXRVLQPxZvMfi21fhQHCG1HK3Xk4XsLzf4LDn18TNMJylhu//B34INBrg5EqWgS2chm
         H1xnv5PBpWDfYY4Bl0bA7OJqCLVoEFVJ912TEFgmqS8MP3H0YXY0+4mRrMXRAFPGRDcf
         NeuCAU6Z9l1VecqqhohGGZxrp3+qCxdrZidS0Z65gjxNKEsK7YKw0qk+NZ6GI+d0aCgV
         P8PyrG2vz3mSQUHVuowfqS0ggoNadN6a5qqetWSXUFggu2deBZoG4ROFS0vjAMXVRimg
         970Q==
X-Gm-Message-State: AOAM532CTzsjqnXtQRu4iYfHQZ59BctaK1CDhVkZ6GidqkizCJDMtTCS
        nuzGGPaCMcYaTzUImwfhD0Sph7Xg4jAcQA==
X-Google-Smtp-Source: ABdhPJzaHCA0/uGrVM5mBe7t1pju56DWQxdnI/iIb/706jijsZUN59Du+wHAXvMf3l6YpvyMobmzPQ==
X-Received: by 2002:a17:902:6903:b0:151:6781:9397 with SMTP id j3-20020a170902690300b0015167819397mr5711398plk.137.1647720659838;
        Sat, 19 Mar 2022 13:10:59 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:951a:ad0c:e44c:ff47])
        by smtp.gmail.com with ESMTPSA id u18-20020a056a00099200b004f737cdd046sm14447556pfg.145.2022.03.19.13.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:10:58 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: merge stack alignment definitions
Date:   Sat, 19 Mar 2022 13:10:47 -0700
Message-Id: <20220319201047.3006578-1-jcmvbkbc@gmail.com>
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

xtensa currently has two different definitions for stack alignment.
Replace it with single definition usable in both C and assembly.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/asmmacro.h  | 2 --
 arch/xtensa/include/asm/core.h      | 7 +++++++
 arch/xtensa/include/asm/processor.h | 6 +-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/include/asm/asmmacro.h b/arch/xtensa/include/asm/asmmacro.h
index 3190157950fa..e3474ca411ff 100644
--- a/arch/xtensa/include/asm/asmmacro.h
+++ b/arch/xtensa/include/asm/asmmacro.h
@@ -225,8 +225,6 @@
 #endif
 	.endm
 
-#define XTENSA_STACK_ALIGNMENT		16
-
 #if defined(__XTENSA_WINDOWED_ABI__)
 
 /* Assembly instructions for windowed kernel ABI. */
diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index 9138077e567d..f856d2bcb9f3 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -37,4 +37,11 @@
 #endif
 #endif
 
+/* Xtensa ABI requires stack alignment to be at least 16 */
+#if XCHAL_DATA_WIDTH > 16
+#define XTENSA_STACK_ALIGNMENT	XCHAL_DATA_WIDTH
+#else
+#define XTENSA_STACK_ALIGNMENT	16
+#endif
+
 #endif
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 37d3e9887fe7..ba62bbcea160 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -18,11 +18,7 @@
 #include <asm/types.h>
 #include <asm/regs.h>
 
-/* Xtensa ABI requires stack alignment to be at least 16 */
-
-#define STACK_ALIGN (XCHAL_DATA_WIDTH > 16 ? XCHAL_DATA_WIDTH : 16)
-
-#define ARCH_SLAB_MINALIGN STACK_ALIGN
+#define ARCH_SLAB_MINALIGN XTENSA_STACK_ALIGNMENT
 
 /*
  * User space process size: 1 GB.
-- 
2.30.2

