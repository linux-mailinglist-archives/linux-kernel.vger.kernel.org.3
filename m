Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB4559112
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiFXEus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiFXEsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A4B69981
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:48:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l6so1078513plg.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=wG/cL1k0Db5CVASFDb2IJyBBfutIm8qgplfgRR5fvCw=;
        b=w8F/BHDTxvIXVC6FheFa0ViKJnTjyUoyIMvRk0YYdJtATT1LrUdw4skWF37W1cigG1
         8x26sID7xOkrcZRAchZerfjH7lOACfj2tmNIrBZ1/r2GPmzAKWlx6frKuZjlCffBR3dT
         cILziiDXGtRMOmeDIPoYZvVFfjJHND4L3eYFVKazXRkfaPzs5IxUG8YfnCnNLEcIIGiZ
         ucX6bRmC3mnNG88dA73+TR1MtLtUG2atpNDco24+MUvNN7l5Tt8gB3lTehD+HUIQi1N8
         eABa8iunfXAEsLk03BnTZMhn+68TeYVz2heeoCqjLyH8V0dLx6q5hl8IYX/wXoFj5UTt
         CYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=wG/cL1k0Db5CVASFDb2IJyBBfutIm8qgplfgRR5fvCw=;
        b=OdhvGP/tnbS4vJtKYiO2e6CX9W2GN7UFrF3m2FqZkKZrRsn4XAJuM1fCfeXYt/NABT
         cqzTPOydZ57M2IlOLA4lxUkWlD1aFENjl9NYfqR8kJYWQdUAhMMgjE2LpcTt8Xsv2FH+
         lNnoJVnDYDc1sI1CZEeP12H0gAYCP+nAIJUnsLgBDsPqAPjlqSm4PLres5Tvt/TXOppS
         AQQ9iqCY9rX+jRJCqESzH/FXYxS8LMVISn4mbqDe6EgP+ksXkld6R2T+cWnqLIznqGbi
         JMOl4SorXu0JbXFejL7YYb970JyL0xufFERTdsfVgATp6I82K4nnDgSrgHY15GKZheVp
         HfSQ==
X-Gm-Message-State: AJIora+JywpV30IavqPuYbt1wPsHWvbMayt2S5HUvJK2Cb1vky8831Cw
        UPmHroEy0Gbl4fxpZhX0Ix5nkQ==
X-Google-Smtp-Source: AGRyM1tDIqY+T0/4qiFzu9A4UssddVx4//CxdxfSa1dBpSxtstyE6Y1jCr4wGD+7ippEZV5Y3XJaZw==
X-Received: by 2002:a17:902:b681:b0:16a:f81:6b02 with SMTP id c1-20020a170902b68100b0016a0f816b02mr31620723pls.28.1656046109159;
        Thu, 23 Jun 2022 21:48:29 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id ik14-20020a170902ab0e00b0015e8d4eb2e3sm651922plb.301.2022.06.23.21.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:28 -0700 (PDT)
Subject: [PATCH v2 4/5] RISC-V: purgatory: Use XLEN-length loads to support rv32
Date:   Thu, 23 Jun 2022 21:48:10 -0700
Message-Id: <20220624044811.9682-5-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses an explicit "ld" to load up target address, which dosn't work
on rv32.  Convert it to a REG_L macro, like everywhere else.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/purgatory/entry.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/purgatory/entry.S b/arch/riscv/purgatory/entry.S
index 0194f4554130..71c50fef051c 100644
--- a/arch/riscv/purgatory/entry.S
+++ b/arch/riscv/purgatory/entry.S
@@ -8,6 +8,8 @@
  *
  */
 
+#include <asm/asm.h>
+
 .macro	size, sym:req
 	.size \sym, . - \sym
 .endm
@@ -26,7 +28,7 @@ purgatory_start:
 	/* Start new image. */
 	mv	a0, s0
 	mv	a1, s1
-	ld	a2, riscv_kernel_entry
+	REG_L	a2, riscv_kernel_entry
 	jr	a2
 
 size purgatory_start
@@ -41,7 +43,7 @@ size purgatory_start
 
 .globl riscv_kernel_entry
 riscv_kernel_entry:
-	.quad	0
+	REG_ASM	0
 size riscv_kernel_entry
 
 .end
-- 
2.34.1

