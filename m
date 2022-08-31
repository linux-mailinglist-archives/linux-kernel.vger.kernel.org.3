Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779295A8446
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiHaRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiHaRZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:25:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692E1C137
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so8390116wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lCJ0X4MxUytr04uLAZfmQJHTkCXKEdN4OMX7NFuLbu4=;
        b=Q3S1nbqunZ84BvgZwdQEX9PqqmrAQNvv4jEpzOY6BxlVLuE1IoEXXKjtROg5F47oGL
         Qmgb6STeBCzOkRHYA4Ne5LCR3shk0edN6ixDwGEOmpVeXYkQhvljK6DgLIDriZudG/l4
         R9kRylrw4IRf/Ik/VfxbiZA7Vy6m9O2+VhVX84kEIIicDRd+XVGOY1skq4e9sJgwxeE1
         qVa5vU7B03fD0XKY5xDRIbfjgSA4ghgQfLYadm9VzUvb01KPQA0/WWKsFPyCYIfs7y8t
         t1ZrwnVoScEV5jD9tVG+ndJ/vE1kWpH5HtV+yjsHgiQyd2lQ2hKESKqN4qEb5xIPtW0n
         qC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lCJ0X4MxUytr04uLAZfmQJHTkCXKEdN4OMX7NFuLbu4=;
        b=3x8pndULRfxXfGAAD3+pYqhXPrlfxrLEPiCe3s1DFLN0c+6BGIfsJIiUq7nrt2wLBq
         O/NU1aAzKhvHUUEWmliaVEQiV9jYhO8IdjtjhwnmKQxZAoDkRfcPhz0X1FOU6V03fppT
         MbEMg16jqZ2rMiJwThZsMzKejBrEtQkvopVPNgICmKbIvtMrl6l25a5NFTkb6tN8wiGN
         ZMc7CDqwStRRg2w8gwbZGoDxkgBjS1vPRCqRL4tvegYm55c0kLAeoyzFI/JaPWcLaFS9
         by4QIXF7ndQZiJm0D4ztXxDJa5C2eYlWG8fq/m7QYOMbhX3h+BjICSg7CXL0tHyYMgw5
         lhqw==
X-Gm-Message-State: ACgBeo1iWVnh8JhNxSWaz3i8AHrg6zAQtHf+mK8TwOrbeOraH9KH0smo
        Pwxi/27DyUkPsZdmugkH0PWbIg==
X-Google-Smtp-Source: AA6agR7AG0MhMcCgUXxNj/1M4XOFv1/Vik4cv/p81wTY7rbGynK6w5HUZOKiGVN2hPE63IiOUAeS0g==
X-Received: by 2002:a7b:ce09:0:b0:3a6:6561:d9d5 with SMTP id m9-20020a7bce09000000b003a66561d9d5mr2664876wmc.62.1661966702341;
        Wed, 31 Aug 2022 10:25:02 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0021ee65426a2sm13746758wrb.65.2022.08.31.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:25:01 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH v2 0/4] riscv: Introduce support for defining instructions
Date:   Wed, 31 Aug 2022 19:24:56 +0200
Message-Id: <20220831172500.752195-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with toolchains that haven't yet been taught about
new instructions we need to encode them ourselves. This series
creates a new file where support for instruction definitions can
evolve. For starters the file is initiated with a macro for R-type
encodings. The series then applies the R-type encoding macro to all
instances of hard coded instruction definitions in KVM.

Not only should using instruction encoding macros improve readability
and maintainability of code, but we should also gain potential for
more optimized code after compilation as the compiler will have control
over the input and output registers used, which may provide more
opportunities for inlining.

I grepped for other places we may want to use these macros and the
only place I found was ALT_CMO_OP(), but I didn't dare touch it :-)
I do suggest we apply this to the Svinal support [1] as we won't
want to frustrate the compiler's inlining efforts with hard coded
register selection.

[1] https://lore.kernel.org/linux-riscv/20220812042921.14508-1-mchitale@ventanamicro.com/

v2:
 - Cleaned up some whitespace issues pointed out by Anup, myself
   and checkpatch and dropped some {}
 - Pushed the quoting of register tokens into the macros
 - Picked up Anup's r-b's

Andrew Jones (4):
  riscv: Add X register names to gpr-nums
  riscv: Introduce support for defining instructions
  riscv: KVM: Apply insn-def to hfence encodings
  riscv: KVM: Apply insn-def to hlv encodings

 arch/riscv/Kconfig                |   3 +
 arch/riscv/include/asm/gpr-num.h  |   8 ++
 arch/riscv/include/asm/insn-def.h | 113 ++++++++++++++++++++++++++
 arch/riscv/kvm/tlb.c              | 129 ++++--------------------------
 arch/riscv/kvm/vcpu_exit.c        |  29 ++-----
 5 files changed, 146 insertions(+), 136 deletions(-)
 create mode 100644 arch/riscv/include/asm/insn-def.h

-- 
2.37.2

