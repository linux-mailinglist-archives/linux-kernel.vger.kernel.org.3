Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305735773B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiGQDfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGQDfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:35:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24CB15FE7;
        Sat, 16 Jul 2022 20:35:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y141so7935950pfb.7;
        Sat, 16 Jul 2022 20:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TP3NuknBFwR+HMAb9EGFICsetJYvdp1cQE+vF2pIYIY=;
        b=Y3FoT4HNok10kBgoxv8WDEwn7zhDTYRu388hTCVBTmj3jFmwNCRlF4dFGh7oEuyIwg
         uyNyNXTrdUMFb3CX3qqX9H8uJQru77P34dUuQ1Rho9F49MWYkMmzHApFpWXNyJKWTuvx
         zZztno86ZjOJejUTStftEwZCSIuea95+j1XZjUQ3IpsXo6oPd7y/IdOjGpnmxfOm9lq7
         lx0UCoTTCxI1SDY+i2kudzu/sdz2xI2+IQqP4HjKSbPOm+MTfusHyARBWdPMhmWgJJXd
         PP9qEI/xJn3afWmN0tvIbMlAseNKnvLFFzV8Pj/W+Eo9xcXbO5KCPWqrqdO2m+Jfx7Si
         Ps/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TP3NuknBFwR+HMAb9EGFICsetJYvdp1cQE+vF2pIYIY=;
        b=hjG8l9oWNQ8Lwf4S7xuXWJ9saDcnZVyHiEFRwRzy9F7LSxMbY/V1GQLn3OoWKIuR07
         HWrqUBh36jUOvHEv72Go9FLD6qtRMm2upqmfX9D82ury+fqftq3Iw3U0kFh2X0561mZ5
         IrC6W6sbqiinqU5QGqK3oZsD26O/ReKi36jASRBBCw5wRKBLaKTwkDGwiu6fjXCbkodF
         9fJLaEx7P1mC1mmWUolH5WyOONm8hQcmRBEkqFmlXCDVQQU6s2qkkpVcf+Q5yu0Qa8qL
         meJG+6Bezs1rLStjecaFmc1lo8gme2wc/5X/KAOJNhMwhuY4OZZ9APraztmP6Zvnc6ai
         mGhg==
X-Gm-Message-State: AJIora/TcaiOk1Povr52DC7cw2FHXyzKMyftXfRlKh1NmPcWoQh3xqiT
        gbUFAPg1cs3PvzW7PTN0VfDexSTtS/I=
X-Google-Smtp-Source: AGRyM1t/uI3R/Ju5pJaOnhwS3KjJr/qvycAbzjW9qeofLhqpJX8p8oQBP/Bc/1a/jJEWz6DQ3nWzDA==
X-Received: by 2002:a05:6a00:2484:b0:52b:2be0:2191 with SMTP id c4-20020a056a00248400b0052b2be02191mr14476822pfv.51.1658028901844;
        Sat, 16 Jul 2022 20:35:01 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b00163d76696e1sm6275909plk.102.2022.07.16.20.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:35:01 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [PATCH v2 0/2] Updates for asm-generic/pci.h
Date:   Sun, 17 Jul 2022 12:34:51 +0900
Message-Id: <20220717033453.2896843-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the OpenRISC PCI support patch Arnd suggested that
we avoid copying arm64 and riscv asm/pci.h and moving that to be
the new asm-generic/pci.h.

This patch does that by first moving the old pci.h definition
of pci_get_legacy_ide_irq out to the architectures that use it,
this turns out to only be x86.

Next, we create the new pci.h definition.

Since v1:

 - Remove definition of pci_get_legacy_ide_irq on architectures
   not using CONFIG_PNP, which eliminated most.
 - Add ifdef around PCIBIOS_MIN_MEM for consistency.

Stafford Horne (2):
  asm-generic: Remove pci.h copying remaining code to x86
  asm-generic: Add new pci.h and use it

 arch/alpha/include/asm/pci.h   |  1 -
 arch/arm64/include/asm/pci.h   | 12 +++------
 arch/csky/include/asm/pci.h    | 24 +++--------------
 arch/ia64/include/asm/pci.h    |  1 -
 arch/m68k/include/asm/pci.h    |  7 +++--
 arch/powerpc/include/asm/pci.h |  1 -
 arch/riscv/include/asm/pci.h   | 25 +++---------------
 arch/s390/include/asm/pci.h    |  1 -
 arch/sparc/include/asm/pci.h   |  9 -------
 arch/um/include/asm/pci.h      | 24 ++---------------
 arch/x86/include/asm/pci.h     |  6 +++--
 arch/xtensa/include/asm/pci.h  |  3 ---
 include/asm-generic/pci.h      | 47 ++++++++++++++++++++++++----------
 13 files changed, 54 insertions(+), 107 deletions(-)

-- 
2.36.1

