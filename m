Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1761574633
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbiGNHxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiGNHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:52:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE526E3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:52:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so7694201pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egUZShWWFfJvJGgDYNvzi2mq2YkyEJX8dqyYulCWxMA=;
        b=kCZjuXiNve52btMzwkOrHXi0qbubRIPWlPYTzqCtMfVej81TQRPENJiIWfCYVwv4wo
         y8u+ft84ab1joSTR75Z27N18UisYHNho5KsoNJA7iBWvoP1HZKhw4mOV4d0rAcy56i71
         DDFNQm9SlIAKpJqhxYojkO38HcEk5S02kuprbfOqFD59tg+ri2E9Eyy8XGeJrmGKKj65
         DlY+I1aVaWlXl1wDvlmk5hy381KMdbDAA5E03AgcM68lChv11ednAmWWOV50vVWMHdML
         hQx9Jp/PQp7547/5KQIa6Xzd1/DoJELKRV+8aFE5uVyF7GHP7Bq65nCZxuKHpn+qXpAf
         NACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egUZShWWFfJvJGgDYNvzi2mq2YkyEJX8dqyYulCWxMA=;
        b=eDllIjPX1nEIj+nzyBuHM81Gd4uZ991bJLLW9OzIOjXD/1KBFosDkm1lLK7NwppZQE
         XTGJW/MpEFA+zjoMZTbynh1ZiRpa/nMRFNf0Plz8m2RboVjhRZLjeAGFtHbVUDwUD6Ly
         Gg11xQlR0Ih88Jet0rpG98VnjfMwW+/fs1qzSMHQjo2yzXQfVae41EM2FEKjkBdWD2sC
         Rm9aK6iq/P8UJsjFiipa0KLvyESAp3EP/1w6ekB0RVXiNrjFMLHOw2cD/Ibxih1wf0IS
         LQnk+0biA6Zz3nF346VxNOXWQrS+V554OW1DnMljLqXsz9wNpCO4YXvw4IOSg1nmYuEU
         X5iQ==
X-Gm-Message-State: AJIora+NSqyaNT0CPizUGUoY1nhHLzpxyDgmbDoaRXQT5en/DnWTBnA1
        4fklDqtoYCOoF3ew5uY+U/s=
X-Google-Smtp-Source: AGRyM1u5QSr5pqLCDw267ozgral5tGr/brIhzB4k02FD6FD+QVfOA1zaa10tysPIrvksOA/jS9CjBg==
X-Received: by 2002:a17:90b:3e89:b0:1f0:4233:b20e with SMTP id rj9-20020a17090b3e8900b001f04233b20emr8547349pjb.0.1657785177509;
        Thu, 14 Jul 2022 00:52:57 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:d0f1:2297:37d1:f468])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00008b00b005289fad1bbesm923541pfj.94.2022.07.14.00.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:52:56 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: enable ARCH_HAS_GCOV_PROFILE_ALL
Date:   Thu, 14 Jul 2022 00:53:05 -0700
Message-Id: <20220714075305.154776-1-jcmvbkbc@gmail.com>
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

Select ARCH_HAS_GCOV_PROFILE_ALL and set GCOV_PROFILE = n inside
arch/xtensa/boot/lib.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 Documentation/features/debug/gcov-profile-all/arch-support.txt | 2 +-
 arch/xtensa/Kconfig                                            | 1 +
 arch/xtensa/boot/lib/Makefile                                  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 502c1d409648..0b3ba2415fac 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -27,5 +27,5 @@
     |       sparc: | TODO |
     |          um: |  ok  |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c4ef8e9c7249..5fa1fd1aecff 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -6,6 +6,7 @@ config XTENSA
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
+	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
diff --git a/arch/xtensa/boot/lib/Makefile b/arch/xtensa/boot/lib/Makefile
index 6f9a56a8ca85..0378a22a08e3 100644
--- a/arch/xtensa/boot/lib/Makefile
+++ b/arch/xtensa/boot/lib/Makefile
@@ -18,6 +18,7 @@ endif
 KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
+GCOV_PROFILE := n
 
 CFLAGS_REMOVE_inflate.o += -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_zmem.o += -fstack-protector -fstack-protector-strong
-- 
2.30.2

