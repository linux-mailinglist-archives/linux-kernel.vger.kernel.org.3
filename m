Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20438587234
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiHAUPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiHAUPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:15:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D055E45F59
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:14:23 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w29so8936642qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEVJVI7ZHSfxXmecZ7P8AtoCE66RlHY49+eIUnnu+00=;
        b=ibXN/3C4tzWEWtqX2Fgim0+ZN2LlTdvveKO5yKYY/752MdiTb2MyZDFF511ZPAOFXf
         OR+b68+f5yxY9kOwhd1Gnt6PhkkwyTOn/lbZj3u37XssrpIpd6nPLqGl3VcVDXdDZCip
         vKozvHxKQvZB4dRZ4NoyLZwFcxNcblqSLRJKYTWXO5E8OJm5bVN2jFG5RAmB7lN89jEP
         UzU0bX1oFq5BOOw1bT7euje8PGZ1ZQLgBPHa/QfE5/5qXld6ClmHr7xFXH9xytKuZGRn
         TCYnMwxMJyF7HfviMtL7YbjtGgp6mnMF8PlUW8yhpIJ53X74Z3pmARkehV3DfYxUPGsH
         F2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEVJVI7ZHSfxXmecZ7P8AtoCE66RlHY49+eIUnnu+00=;
        b=sReIniB7xekHvFtb4EGeGjrWz/ylrF9u59iG89tsPnhRpGJ88DaXtUP2tuEmMNO0wu
         Nx6CGe5OjQ3wknBwr1xWrNc2doY8/lYP9fcGa0C8+wCWiWWJZUBW4LCzBd5tgaFMqqSr
         sHjsCFEjyhkzW+evDmEYHkoHM/uqy48URP8Qm+MSDIh9dMa9nB8ekZEYTykSv4FKOIel
         JObNfFdbkI9sU0a/RaddQFuctWy2bKoETPQc4IAIzgQXBWDn6gjdFkjH3DGxfOgxjjoX
         8eyDLKR1gkKlVwH8rvybgS4xYlxtTBRZg2ycnwokeWJYArGpMs+R0+bjpp9NW5gsbtYe
         HGEQ==
X-Gm-Message-State: AJIora8DLS4c1/WFP+Vuux4d1qa4dxUHIFhvSJ4d3n+djxKzhdoZWiF5
        LBdBPZiMIJPqdm2UCQfTopgdMw==
X-Google-Smtp-Source: AGRyM1uWTfS2YCHrnGWCx6rTienxTjs9YGc2SzlErgnBKQjE3z7DqcxkZiuoquBx4Ax1K1ro3GQ43g==
X-Received: by 2002:a05:622a:2d6:b0:31f:3670:3d2b with SMTP id a22-20020a05622a02d600b0031f36703d2bmr15673451qtx.412.1659384862954;
        Mon, 01 Aug 2022 13:14:22 -0700 (PDT)
Received: from hefring.. ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id r20-20020a05620a299400b006b59ddb4bc5sm9288317qkp.84.2022.08.01.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 13:14:22 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
X-Google-Original-From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Cc:     Ben Wolsieffer <Ben.Wolsieffer@hefring.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: v7m: handle faults and enable debugging
Date:   Mon,  1 Aug 2022 16:13:37 -0400
Message-Id: <20220801201347.1255392-1-Ben.Wolsieffer@hefring.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables real exception handlers on no-MMU systems,
increasing robustness in the face of buggy user- or kernel-space
software. Previously, any fault would trigger the invalid exception
handler, which would hang the system. With this series, faults only
kill the offending process and allow the rest of the system to
continue operating.

The second patch in this series adds support for undefined instruction
hooks, enabling software breakpoints through ptrace. Using this
functionality currently requires a patch to gdb.

This series has been tested on an STM32F746 (Cortex-M7).

I would appreciate feedback in particular on the following questions:
* Is the fault table formatting acceptable? Or should the lines be
  wrapped/shortened?
* Does my chosen mapping between faults and signals make sense?


Ben Wolsieffer (2):
  ARM: v7m: handle faults
  ARM: v7m: support undefined instruction hooks

 arch/arm/include/asm/traps.h |   2 +
 arch/arm/include/asm/v7m.h   |  29 +++++++
 arch/arm/kernel/Makefile     |   2 +-
 arch/arm/kernel/entry-v7m.S  |  68 ++++++++++++++-
 arch/arm/kernel/traps-v7m.c  | 162 +++++++++++++++++++++++++++++++++++
 5 files changed, 258 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/kernel/traps-v7m.c

-- 
2.37.0

