Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACE055AB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiFYPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiFYPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:42:12 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F015FC6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 08:42:11 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7C6B53F8D8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656171729;
        bh=F3RxS92s6HC7mDr70wELutMLarrjjf9M1klJ5znbLyM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=TKLRMG0FhfZIJiRDMYIl+EuxvQ8yx5PVYdKfSLkRY59YDBvv/ugL7plefeZYCudYt
         itRawkly5Vm+qxJALV4EXDq2DLMESSJcRIhFyThNE/Y7rZYcT6gKzFgjWYyCkvlvbL
         UpSGIVBoHnTq1hOzIR3VPiZe40uOAYHSKkrB9Q0DRCsw/vzTW/S/7nyD5WIa3bh+0l
         UUTnAEfI4awL/CuSUqxilpFXAxFIF9B3Bp8p22rhSKs7jRz/Y+gi+A3FY5rlDQ062D
         er+SfO7W5CVkB7QEP/+BES52tcVpoGMXKFsBd28TJLhErUDrWdEY83OoHrMcScDUQT
         cDEAYO71LYH0w==
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402441200b0043564cdf765so4006464eda.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 08:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3RxS92s6HC7mDr70wELutMLarrjjf9M1klJ5znbLyM=;
        b=HQFZ++kSzs93tKi1F+PaPte9dVZWYc71sB8HwDEb7GO1+Ql2L/DvqK6QT2lHC/2cNX
         TPDk92D5QOnLCp2WzNquxrycPTM6JByrP3EYorJqURcMtQjADggaXLrKSu31jm2VPBrv
         cG1DgieMMacycA16b+lXQcVZXF2+ZqH/qPZayh56Q8+5wkbzRYuSc2/0/P2uK/nXpQ2S
         KcW/QXcYGihxfsm6WWiWTLnCQbrMxSGr/cGsiMppuUL37Za5/r8C68kBhD191bQTTD/g
         pUsl91Vq7dlGMP9gTDWX0p0wt2UmGk5DbzZnb3BDcjej2IiSw21lAoPcw4nK69IQaseW
         u2WQ==
X-Gm-Message-State: AJIora8zzi4Iz/NMNJynGKg+KPywxZJ4cLDK8if5MsOJtlKV7OpBMUxT
        mk/xOfetd14Poi0axnkSBmPchpqUogix834VsNzSNZ2cr49A/gn3lWE/GCEeep/XGTAZsdmpLPC
        OemxCnk6w2QBJuoFUolCP/hGSvkVYsez3Z05qhf2PJg==
X-Received: by 2002:a17:907:97d1:b0:722:e6fc:a04 with SMTP id js17-20020a17090797d100b00722e6fc0a04mr4306662ejc.217.1656171728940;
        Sat, 25 Jun 2022 08:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uYGJDDSMNvYv5uR9pGeZx1Jsr335Pjv0f9MZFs+TktvMHV6apBD3ph5wMlh5CGZNyhkmfAdA==
X-Received: by 2002:a17:907:97d1:b0:722:e6fc:a04 with SMTP id js17-20020a17090797d100b00722e6fc0a04mr4306647ejc.217.1656171728790;
        Sat, 25 Jun 2022 08:42:08 -0700 (PDT)
Received: from archlinux.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id d18-20020a05640208d200b00435bfcad6d1sm4239439edz.74.2022.06.25.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 08:42:08 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: compat: vdso: Fix vdso_install target
Date:   Sat, 25 Jun 2022 16:42:07 +0100
Message-Id: <20220625154207.80972-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
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
2.36.1

