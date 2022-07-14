Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63F575728
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiGNVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:47:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D1E6F7C8;
        Thu, 14 Jul 2022 14:47:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z1so1583113plb.1;
        Thu, 14 Jul 2022 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JBraEEF7Pi/rPUlvSul3up/f1rkIrFL2lXpXxABUjo=;
        b=lscc9nAaqk/gLbSr2XL8YrPRs/zyT8T4SiE+UzcwyfJZDejV2V03/Ceml36zOXDw2j
         GSw5Bz+NY1ohcFs2Y+SbhIHhCmrrBRefc9Ctq2tTml3QpKdab/V6fYGRGmiVrgBUngI1
         99Q4DNc0rMuLLiHGkogfp/rrBqI7OQKuhgDfVe9wNw9mtmWkUZ0MuZBbsOMzAVRzGvLD
         9xrGld/ogqVffulMZ1eEaY/hE23kNAH0MTXlQDS3QZykMAvUoMSZwpUr0kXvMYTo6mw+
         feoN81IqGiQNmpkPgcbCkP6v7rV2i5qe9SRfa03yGMJNePPiSyC36JkgtWtmZHn9FToR
         7dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JBraEEF7Pi/rPUlvSul3up/f1rkIrFL2lXpXxABUjo=;
        b=6QwXP10Cr/vxxjLJSZ/JduPHFicz+Gs1pjFXtD0jKhHC6YW+vjazKoiGDCyOkl0YtC
         1/Hl+aLEdkqCOEt5hPwpXjeUFVoaZ9UkiaShQfLRWUQk+J3wFZkk688aPqMzAUjllg/u
         vfdWnISFLvOf5rlQ++3rAbeB/yx9z2YiewUyJ0E3vQmj+fdWPM3UwyBWHpgI5+G0zl5k
         Rz9NV42wyjoGfa8A+IvUZYkdAfdlr7b99x04mEdiEisMlLTcN3hVdSQkMYqcDp4/ABBY
         vgU3sO8I2Atm8tKlVflU/tAOgE2xVhq7HSzBikqjJx7yAvWZd+b2SfDewhMUzIPRk5/F
         vREA==
X-Gm-Message-State: AJIora8Sqxb2/rc66bp0RsaYxKzplpdwEWRVDzMdarjEddkfoJy5oRNi
        GVsOkqKEu6tM1brXZFI8tNYzK5aks4UKjQ==
X-Google-Smtp-Source: AGRyM1v5QC4ANKVLVpkPuuJcTPGQopcKs4QNjHemdLKq1UTYUTez/Vz/d5mLTfj3qgv8jyrxm1KP0A==
X-Received: by 2002:a17:90b:3c07:b0:1f0:eab4:79e4 with SMTP id pb7-20020a17090b3c0700b001f0eab479e4mr3015352pjb.186.1657835237487;
        Thu, 14 Jul 2022 14:47:17 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id v21-20020a17090ac91500b001f113765d48sm145572pjt.2.2022.07.14.14.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:47:17 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [RFC PATCH 0/2] Updates for asm-generic/pci.h
Date:   Fri, 15 Jul 2022 06:46:55 +0900
Message-Id: <20220714214657.2402250-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the OpenRISC PCI support patch Arnd suggested that
we avoid copying arm64 and riscv asm/pci.h and moving that to be
the new asm-generic/pci.h.

This patch does that by first moving the old pci.h definition
of pci_get_legacy_ide_irq out to the architectures that use it.
Next, we create the new pci.h definition.

Stafford Horne (2):
  asm-generic: Remove pci.h copying code out to architectures
  asm-generic: Add new pci.h and use it

 arch/alpha/include/asm/pci.h   |  1 -
 arch/arm64/include/asm/pci.h   | 18 ++-----------
 arch/csky/include/asm/pci.h    | 24 +++--------------
 arch/ia64/include/asm/pci.h    |  1 -
 arch/m68k/include/asm/pci.h    |  7 +++--
 arch/powerpc/include/asm/pci.h |  1 -
 arch/riscv/include/asm/pci.h   | 25 +++--------------
 arch/s390/include/asm/pci.h    |  6 ++++-
 arch/sparc/include/asm/pci.h   |  5 +++-
 arch/um/include/asm/pci.h      | 24 ++---------------
 arch/x86/include/asm/pci.h     |  6 +++--
 arch/xtensa/include/asm/pci.h  |  6 +++--
 include/asm-generic/pci.h      | 49 +++++++++++++++++++++++++---------
 13 files changed, 69 insertions(+), 104 deletions(-)

-- 
2.36.1

