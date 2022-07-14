Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39597574632
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbiGNHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiGNHwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:52:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360D2663
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:52:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so7744980pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcNGA3XzcRpkB54UbiRwCq/ocLcwLdrUgSteNlNaCe8=;
        b=lEcA0UWrC6raUJrZWmqB71/bzsVSJJ55UkgurxyF9UqHs/KGuEtZg+3oaT7Fw5hutV
         Csyc10J5PMgS2pDn4jBxhbBKc9X53dTJm4ZSMnH1pe7Mz1gfpM6kxHvBiLiEvSqL73CV
         QHqcXKl1QBl3bWUqFNjKgvoQZCL+CrqyBZgHEVpk1j4u6ktz43bKs1r/iH7GC9gpERha
         LHrKgn5C6y7yJ+ILkjgVnrc0fNlpLvAV/BIn2CqFhQ0xXHkMykBkP6DLR3KxDf2E8sIb
         hvURkKRvZ8sBf/Fwv99sTg318oTsa1VV1bhvhuTotHxEa7gHD2zg4rTn74aTRUlH+WVq
         DDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcNGA3XzcRpkB54UbiRwCq/ocLcwLdrUgSteNlNaCe8=;
        b=6v39D68qJ9lpJd7/57PHHxHpD6F6iRHSO/8nYODEvpwVSAOPkbJn5INzzHxKChZ2Ak
         ktzY3YSPk4h7bMw5VSXztcPK3shfd3Nfqbxc0bY88MLo/x3m8yhDaxdXM9MVRZ4DchW8
         AOgx86MphnVWByBPCCEW4mio585psPjVPXUx6gE2FV6UANkAeMhVVOVF+5hxOp1CuLeT
         5qumJlpvm881/1ZbH896apfhWtO1eiXJJD9VFGjHTvPRI95lZE3qcaqjxENyagk4fQQy
         q1TGqokKbmEmUVTEpWuw08KNl5qZAiJ+SK5I0ElwB7b7Q7782xsY5L5T+RiAv+pWl5dH
         7Spg==
X-Gm-Message-State: AJIora/bjX7EOlSbHI6WSw2cnePtJOLAwGdVHy5IYDU5dw4rZ2fvZSup
        WX0QVJIroux4aiVWd/UpZHfkxFIYHScLPQ==
X-Google-Smtp-Source: AGRyM1tJXeOsuMb0ttruI104XChvIpW5XYaKsbIPeZa4Cp0YSiMT7XmAN+lLwi1Yli1IZgFcX3Hmfw==
X-Received: by 2002:a17:902:d581:b0:16c:66bf:baef with SMTP id k1-20020a170902d58100b0016c66bfbaefmr7175474plh.29.1657785168288;
        Thu, 14 Jul 2022 00:52:48 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:d0f1:2297:37d1:f468])
        by smtp.gmail.com with ESMTPSA id z128-20020a626586000000b0051c6613b5basm904488pfb.134.2022.07.14.00.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:52:47 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: enable KCOV support
Date:   Thu, 14 Jul 2022 00:52:54 -0700
Message-Id: <20220714075254.154725-1-jcmvbkbc@gmail.com>
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

Select ARCH_HAS_KCOV and set KCOV_INSTRUMENT = n inside
arch/xtensa/boot/lib.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 Documentation/features/debug/kcov/arch-support.txt | 2 +-
 arch/xtensa/Kconfig                                | 1 +
 arch/xtensa/boot/lib/Makefile                      | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/kcov/arch-support.txt b/Documentation/features/debug/kcov/arch-support.txt
index afb90bebded2..0a91f5ce34a9 100644
--- a/Documentation/features/debug/kcov/arch-support.txt
+++ b/Documentation/features/debug/kcov/arch-support.txt
@@ -27,5 +27,5 @@
     |       sparc: | TODO |
     |          um: |  ok  |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 0b0f0172cced..c4ef8e9c7249 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -6,6 +6,7 @@ config XTENSA
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
+	select ARCH_HAS_KCOV
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
diff --git a/arch/xtensa/boot/lib/Makefile b/arch/xtensa/boot/lib/Makefile
index 162d10af36f3..6f9a56a8ca85 100644
--- a/arch/xtensa/boot/lib/Makefile
+++ b/arch/xtensa/boot/lib/Makefile
@@ -17,6 +17,7 @@ endif
 
 KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_inflate.o += -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_zmem.o += -fstack-protector -fstack-protector-strong
-- 
2.30.2

