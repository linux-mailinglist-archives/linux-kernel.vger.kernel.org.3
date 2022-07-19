Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1205857A08B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiGSOIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiGSOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:07:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBEA10B1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:24:04 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8FF053F11D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658237042;
        bh=NEnwNeO0CJTpgQRAzMNc/OyktHScHaIM2e/dnIHqR2A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=R2sv/c2wZouVXGKLUvLPiPELXF4UmmEOTlP9j8MzvVx12azBFaAzUHKs7t906LlPN
         8g6bMCRyjm5dBiCHoBYKM5hEB83JasedzCReVI5RhHB80gFBR/jXcNsai128/eO3kn
         vVYFGM82PT13rNEvtM7fbRQdqbxc4N+HVJcMIk4rRaPueoSANbir/KFbdH7jJjdjKv
         0cpBdEnJVrcKyCP6ybsFjhrVBl2MWSRy6A4gdvIBOh+xOw01YIF7QbSxDIYIZFLqP+
         VAfKrI00rMDOutgQMoJrzrposrR7EE8k4Ph3LO43fJXb3QJEo4ThPiXP8QeolK0lXm
         r7Q1kVDd9928A==
Received: by mail-ed1-f69.google.com with SMTP id i9-20020a05640242c900b0043aeffc5cf1so9973749edc.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NEnwNeO0CJTpgQRAzMNc/OyktHScHaIM2e/dnIHqR2A=;
        b=jhCJJYk7dFZNQHKfeWLC5GSRVElBdpuJHTQ9eRK4QTXDS4yXznL33ik6fZMNoXbJ/5
         foTzPso7qjp67kM/1Smgysxo1gwd6EvaD9L01YTXYBPTBWrsrd6DNmjFTrtlUvcv4+K1
         ZZJbA00TTPcM2/vGTkZqeFELTfrRUAbC+Hk3CScJ5o39n1IanngtQnN6FKBBsJvJkW8F
         6yXZr7kE+t9ECm1pLbQTBNe56yCVZbw0W9Ly06iz/TXf1x+ygg2bk/eVATDQKA5Lus1Y
         /EHC+lYDclmgkEfjHi3GnEL3G0Aa/YVp7TrpLGppZqn95ZLYA1BZa6l8RyVMTZatO/Yh
         wfyg==
X-Gm-Message-State: AJIora+dahOqDa1feuERkdIM4zQfT+jLbxJSwTN6lajZ8fhluUGV5fAJ
        vGgg39xxCLFbM3os3aZN09/1p0ymD7czwzQKCnocAKVVN0GXw82mxWr5ez01ZsRNWDWjp1yzxRZ
        brAwTT58CZy9wUaiWcNsZ2LWyt9ybuy8ZYJIrXpEIqA==
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id n4-20020aa7c784000000b0043acaa875b9mr42981346eds.311.1658237042255;
        Tue, 19 Jul 2022 06:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vfyjfKXkaD87iqKYQR9PlNCxMZIIgmYzl1HjLWcMUG68oqnf4JIHYfUz56Vl8NCmixfGa/uA==
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id n4-20020aa7c784000000b0043acaa875b9mr42981330eds.311.1658237042117;
        Tue, 19 Jul 2022 06:24:02 -0700 (PDT)
Received: from archlinux.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709067c1200b006febce7081bsm6682894ejo.163.2022.07.19.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:24:01 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: compat: vdso: Fix vdso_install target
Date:   Tue, 19 Jul 2022 15:24:00 +0200
Message-Id: <20220719132400.75407-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_COMPAT=y the vdso_install target fails:

$ make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- vdso_install
  INSTALL vdso.so
make[1]: *** No rule to make target 'vdso_install'.  Stop.
make: *** [arch/riscv/Makefile:112: vdso_install] Error 2

The problem is that arch/riscv/kernel/compat_vdso/Makefile doesn't
have a vdso_install target, but instead calls it compat_vdso_install.

Fixes: 0715372a06ce ("riscv: compat: vdso: Add COMPAT_VDSO base code implementation")
Reported-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
v2: Add Fixes and Reported-by tags

 arch/riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 34cf8a598617..5cfbef613e34 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -110,7 +110,7 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
-		$(build)=arch/riscv/kernel/compat_vdso $@)
+		$(build)=arch/riscv/kernel/compat_vdso compat_$@)
 
 ifeq ($(KBUILD_EXTMOD),)
 ifeq ($(CONFIG_MMU),y)
-- 
2.37.1

