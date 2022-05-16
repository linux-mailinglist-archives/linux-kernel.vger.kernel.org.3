Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD85292A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349266AbiEPVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349380AbiEPVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:15:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B92D17E05
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n190-20020a25d6c7000000b0064b9bf694e1so8022292ybg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uR8fBj5xEbHbPpF6kOnzURYdm0/ut31Y0IfMxJWffDM=;
        b=k3uVMrQMx5KY7DTaJyGFyhujDhf5HLPHQg/0aCxqS5oo2mQY5FHDkhTUSQjPxxqybO
         kA/eQp81aO1qWo63Rh73bC+/TXjut98EQmmed89OALR85ZitiQnON9b7oc58EMGYgku1
         90LqX5fl79FFgb5Zhz4DGBafUSczGI1yeesAfc5hnZJj3Jn3PKcI4vSa5lt5WLwgLO8C
         GyKwHTNF/HqZI4jumboVr5RUJjvtEF0wpVvrrDUqNQvOkfqS4zBnC6NfHjcpkYo/1OuH
         MhQXZSbmFUwBuKjuNzO+TDMalriyAofGKhozeDmkqKAjOGUdp85Vc8Xs8Qgwu1nLrcji
         nUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uR8fBj5xEbHbPpF6kOnzURYdm0/ut31Y0IfMxJWffDM=;
        b=xbjzdgT0e3Z0FiooGv4Xr3el6GqWcIhnwMe9XqoqKrZLSIGkCS3aqeDbMZv2Lmp03p
         OxqHpEzewo4g51m0dgDkTx+DaGWn/3TvMlgxBw9CSXWJFzjzFqskxSrjHHs6Qyoli/Uo
         gGpSdUL1RoRO+ZbJRnpk8DA4rcrnl/HHrKjW2Ark0mE5yhfF9F8nVzga8j9WSAqRggZo
         UddkZh0CdDSUokAItJZWSQvACXRlTle9CbKj/g+Avvm4SuvuC4WYZ9rOKWzeqdr0UkJy
         qNp4MFMd1AX4wUu1vgPniHfoYIPJFm/I5Htm+2P2myQnTV3EtohKfk4X+No9M+SitGrg
         iK9g==
X-Gm-Message-State: AOAM533ZenlD0QC1L959iLrv5I5yCsQ6HhJoIZUikuUDZ8+8ZNcK67Rk
        yL72U5QE6loXWC953BwJqc/hUQvA6Tq2sSBN6Lc=
X-Google-Smtp-Source: ABdhPJyDi6K2oWYXlyWCJ5XKcQVc/+zo2gwZ5YIL/COpbALJXAIL4i9mZKX4jcpzEcnqt2DJGWV03Fw4pOgixa+NJU8=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2ef0:b8de:b9c8:da45])
 (user=ndesaulniers job=sendgmr) by 2002:a25:fe12:0:b0:64b:473f:cb79 with SMTP
 id k18-20020a25fe12000000b0064b473fcb79mr20805404ybe.82.1652735405447; Mon,
 16 May 2022 14:10:05 -0700 (PDT)
Date:   Mon, 16 May 2022 14:09:51 -0700
In-Reply-To: <20220516210954.1660716-1-ndesaulniers@google.com>
Message-Id: <20220516210954.1660716-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220516210954.1660716-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652735394; l=3985;
 s=20211004; h=from:subject; bh=gVoVkYKp2fU88mTtUugTh71wg9G6f/KfwhDgJ87QUd8=;
 b=arxbscZTEvpEke55vwBYjBhK3a5JbxBkFo8AE5K5jAu1hTI0EVf0NjdTojY3MekesE1ui17QOmUi
 IxK7fHIzB0nn38yIJRfegglWQwYT22lzKrGDP3dLQfSyZokvCrVV
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 1/4] ARM: remove lazy evaluation in Makefile
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@arndb.de>, Ard@google.com,
        Biesheuvel@google.com
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch-y and tune-y used lazy evaluation since they used to contain
cc-option checks. They don't any longer, so just eagerly evaluate these
command line flags.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Makefile | 60 +++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de5a5..99a7ed7e9f09 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -60,44 +60,38 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
-arch-$(CONFIG_CPU_32v7M)	=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
-arch-$(CONFIG_CPU_32v7)		=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
-arch-$(CONFIG_CPU_32v6)		=-D__LINUX_ARM_ARCH__=6 -march=armv6
-# Only override the compiler option if ARMv6. The ARMv6K extensions are
+arch-$(CONFIG_CPU_32v7M)	:=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
+arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
+arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 -march=armv6
+# Only override the compiler opt:ion if ARMv6. The ARMv6K extensions are
 # always available in ARMv7
 ifeq ($(CONFIG_CPU_32v6),y)
-arch-$(CONFIG_CPU_32v6K)	=-D__LINUX_ARM_ARCH__=6 -march=armv6k
+arch-$(CONFIG_CPU_32v6K)	:=-D__LINUX_ARM_ARCH__=6 -march=armv6k
 endif
-arch-$(CONFIG_CPU_32v5)		=-D__LINUX_ARM_ARCH__=5 -march=armv5te
-arch-$(CONFIG_CPU_32v4T)	=-D__LINUX_ARM_ARCH__=4 -march=armv4t
-arch-$(CONFIG_CPU_32v4)		=-D__LINUX_ARM_ARCH__=4 -march=armv4
-arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3m
-
-# Evaluate arch cc-option calls now
-arch-y := $(arch-y)
+arch-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5 -march=armv5te
+arch-$(CONFIG_CPU_32v4T)	:=-D__LINUX_ARM_ARCH__=4 -march=armv4t
+arch-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4 -march=armv4
+arch-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3 -march=armv3m
 
 # This selects how we optimise for the processor.
-tune-$(CONFIG_CPU_ARM7TDMI)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM740T)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM9TDMI)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM940T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM946E)	=-mtune=arm9e
-tune-$(CONFIG_CPU_ARM920T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM922T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM925T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM926T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_FA526)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_SA110)	=-mtune=strongarm110
-tune-$(CONFIG_CPU_SA1100)	=-mtune=strongarm1100
-tune-$(CONFIG_CPU_XSCALE)	=-mtune=xscale
-tune-$(CONFIG_CPU_XSC3)		=-mtune=xscale
-tune-$(CONFIG_CPU_FEROCEON)	=-mtune=xscale
-tune-$(CONFIG_CPU_V6)		=-mtune=arm1136j-s
-tune-$(CONFIG_CPU_V6K)		=-mtune=arm1136j-s
-
-# Evaluate tune cc-option calls now
-tune-y := $(tune-y)
+tune-$(CONFIG_CPU_ARM7TDMI)	:=-mtune=arm7tdmi
+tune-$(CONFIG_CPU_ARM720T)	:=-mtune=arm7tdmi
+tune-$(CONFIG_CPU_ARM740T)	:=-mtune=arm7tdmi
+tune-$(CONFIG_CPU_ARM9TDMI)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM940T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM946E)	:=-mtune=arm9e
+tune-$(CONFIG_CPU_ARM920T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM922T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM925T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM926T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_FA526)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_SA110)	:=-mtune=strongarm110
+tune-$(CONFIG_CPU_SA1100)	:=-mtune=strongarm1100
+tune-$(CONFIG_CPU_XSCALE)	:=-mtune=xscale
+tune-$(CONFIG_CPU_XSC3)		:=-mtune=xscale
+tune-$(CONFIG_CPU_FEROCEON)	:=-mtune=xscale
+tune-$(CONFIG_CPU_V6)		:=-mtune=arm1136j-s
+tune-$(CONFIG_CPU_V6K)		:=-mtune=arm1136j-s
 
 ifeq ($(CONFIG_AEABI),y)
 CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
-- 
2.36.0.550.gb090851708-goog

