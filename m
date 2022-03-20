Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB78B4E1AC1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 09:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbiCTIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 04:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbiCTIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 04:20:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01754BFCB;
        Sun, 20 Mar 2022 01:18:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kx5-20020a17090b228500b001c6ed9db871so1668653pjb.1;
        Sun, 20 Mar 2022 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZTlK/Bl88+jvg7euRJCR0++f1eoFemf2mpVTfihNXE=;
        b=DChlEfN5MJw+CFm9abAQAMev+aFzzLVXr0n7WQ6JvzpSpERkj0wUQQZ4/2EFjkwGIm
         1Mi3PxNF5hv2FFRNahxFS6s0pPSylgkx3j4T7QvAkJYpw8L83G0ULenWyZIfkye1h+Ln
         FpOCTBztz2ndUPS0jhmnMZsTKtz2k9ICoIJobYlTNaUiZveUBbEXmPr6dQeahxyosrHk
         Wc3nY1ApIR/PdIakksdVIXywTh1DYDlQeqh0fOLr/GEFFbw79SYmgSmFRYdqm/x14UmV
         mVc7Q0fvBeu3R4hEVcGn0XjlXlZWDDjTma2PMsORzi7AgI2g9Z/7Nhoa8ch5erPzTuF6
         kgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZTlK/Bl88+jvg7euRJCR0++f1eoFemf2mpVTfihNXE=;
        b=KedX0wEys4FYhdPXZRdFFTmUUjzGjipl2oGPstZUUeog7Tk2js7r+JmNXD0LJ8q/lC
         uLmKh+YL62CFyFRYYLwzdUj8GBi+3m8izDwyEg2/ajUz2sqk6KK9s6jJ4GZNSc0c7XtU
         R1CelaaiNduQCSxEl9+fRkI9Uzk0tf/sArbGIFUQyZaK2J47EBT1bGzvLlnAqrArNUqr
         /CG4TMqWdzcSA6EtHq1BsOMzSFtwziT06R/4di4HWp2osSg22CgrXjItKm+8zhL5Y9cr
         45pCBYCfyoJhBd7m0CuxIXDqpcClZjEYfOSaJ68pD6aU6gIp/dR76Tq/tyd0dkm5Lqdu
         l/LQ==
X-Gm-Message-State: AOAM531mbWE7jnFvsm1NJSgZLwxzRzf5BaH61iDj3/ig1WAqKKAZ2sUT
        N/Cr6QS2Ir2YFm2kVdeG2lU=
X-Google-Smtp-Source: ABdhPJzQKDV1VuFHoGFiCY4nHH5I5fPsIlsorg2wnWzdj5GeKFEWEIBt9zXWxosu8/Jsbtez4UGN8w==
X-Received: by 2002:a17:902:7fc1:b0:150:1ae7:94c5 with SMTP id t1-20020a1709027fc100b001501ae794c5mr7264326plb.45.1647764335140;
        Sun, 20 Mar 2022 01:18:55 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id q2-20020a638c42000000b003817671cb29sm11228639pgn.41.2022.03.20.01.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 01:18:54 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     lkp@intel.com
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: kvm: copyright comment fix for vcpu_sbi.c
Date:   Sun, 20 Mar 2022 15:18:10 +0700
Message-Id: <20220320081810.405589-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <202203130225.OBpOOQrW-lkp@intel.com>
References: <202203130225.OBpOOQrW-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reports warning copyright comment warning for
arch/riscv/kvm/vcpu_sbi.c. Since the comment isn't for kernel-doc
consumption, fix the warning.

Fixes: dea8ee31a03927 ("RISC-V: KVM: Add SBI v0.1 support")
Link: https://lore.kernel.org/linux-doc/202203130225.OBpOOQrW-lkp@intel.com/
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index ebdcdbade9c652..2888cde02fddd0 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * Copyright (c) 2019 Western Digital Corporation or its affiliates.
  *
  * Authors:

base-commit: dea8ee31a039277576c215fffa13957970246366
-- 
An old man doll... just what I always wanted! - Clara

