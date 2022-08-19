Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21827599D56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349238AbiHSOC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbiHSOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:02:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C59100F02
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w3so5796517edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ioRh9mRUb9BV3NN71JPPL0cy/65mLsur08UYOwEqqrU=;
        b=GZVjM0oT/jbRvlebZxN7MGMydyf11mil4YudVibKpm9RHu0qvusJx5AujpF2+GpHzy
         684FerrGI7EWa5eZmKfoiVJhZFCn09+ql//Qx7quIJmmF2fbzdv5tryVPnhO9LWI/H7U
         XOcEYnm0cajmwWKbwPfY9ELGQrEiXmHMbzK6dYmFim8L4cxOc5AyxxbYtDfwEjULQp98
         7Pn+76HSUVCJ2vFBKh9iY1msgUbQCf/CkyER2JocpK+HFyFMpMlW5v17aUQ7eWedMMrT
         PMZ46YEDDZazB+3fuWIjKufU0+HwILs2zo29o+jawzitCeEpmHdYTAjdFXh+XARmEcjs
         yH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ioRh9mRUb9BV3NN71JPPL0cy/65mLsur08UYOwEqqrU=;
        b=hC89BX58rHGA1MF0XnUA4vNmobHO9KRSzx/1TUb0gARkUtrum4wvV5ocTMw+nw70Lq
         2UNNyDr9F2tIavmGjBcb2u6snIf1l/Nmg4rneiyXej78oo2kxwFTUFkXYuIGUcbUBuOZ
         xGCMElqaW/q69q9mbVQwf7SF5ggzDOIpnEd9C4F466kqZefTs86SnUb4crme6AAEkPp9
         TwMYB2J2Soh4Wnj6CzuU4nMqiToi0iYh3rJPtLLOST8mjYQBpg7K3L0DYlwUwr+a6luI
         r6c9aagC2qFe7lXwzcZBjSwJHBA1CC5vhMiR6cen2RJGjmzCjCuVZGtUEwfRCZFd7R3h
         Za4g==
X-Gm-Message-State: ACgBeo2Im8opUizL+fJoCOr/ejtIZxx8+n09TQP9+ZGFZgVLpXmbkkTg
        p8grIiMjIzE+WutmZyMHD4t5TA==
X-Google-Smtp-Source: AA6agR7kfJlxF66pPKRv3SHolinYo6IHh4QECg6tWyE9EbC+k2VEVxhZYNRzPX5CfjVarStKjh10Ng==
X-Received: by 2002:a05:6402:4441:b0:43d:5bcf:afa0 with SMTP id o1-20020a056402444100b0043d5bcfafa0mr6211701edb.91.1660917771989;
        Fri, 19 Aug 2022 07:02:51 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id o16-20020a1709061b1000b00734b2169222sm2363778ejg.186.2022.08.19.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:02:51 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH 0/4] riscv: Introduce support for defining instructions
Date:   Fri, 19 Aug 2022 16:02:46 +0200
Message-Id: <20220819140250.3892995-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.1
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

Andrew Jones (4):
  riscv: Add X register names to gpr-nums
  riscv: Introduce support for defining instructions
  riscv: KVM: Apply insn-def to hfence encodings
  riscv: KVM: Apply insn-def to hlv encodings

 arch/riscv/Kconfig                |   3 +
 arch/riscv/include/asm/gpr-num.h  |   8 ++
 arch/riscv/include/asm/insn-def.h | 104 ++++++++++++++++++++++++++
 arch/riscv/kvm/tlb.c              | 117 ++++--------------------------
 arch/riscv/kvm/vcpu_exit.c        |  29 ++------
 5 files changed, 133 insertions(+), 128 deletions(-)
 create mode 100644 arch/riscv/include/asm/insn-def.h

-- 
2.37.1

