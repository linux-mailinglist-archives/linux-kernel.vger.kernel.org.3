Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4194522E79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiEKIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiEKIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A13525C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d22so1183588plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=vOP9ZS/vxkzOlI/l+cYdq2hR42ZqOFcbpjPtOsjjFaA=;
        b=f/GBF7F+MFK3EAYxoYQRrccahir05NtthLiHYzXGNTNWj3phkyDZ2fKkhIvoEhMKex
         GFha3bwBcWHrhhkSK7v/OBVw7NoZItkcqrRCD7K8PUQDf897gbKw8a7aaNpYm/HzIUt5
         ug3QcVV4xJ7gZw71SUTKUsLxKtD0rHn9SG7HJxEEtqm2ZpVQLdsDqma4TVsMEiIVrEo8
         E19T2gxzZrFQcfhx+qYSHH4PgZ8VhbFqiISaXwOJe2jUnp+qcTS+zwMcOjFMYGOPEU11
         mQEaVkOo5xqgqVDA9l5sPh1NpI7Cwv84vnYKUr0jICaWf9sQ3/Jj2f6ToVVjM7cwMKmH
         pIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vOP9ZS/vxkzOlI/l+cYdq2hR42ZqOFcbpjPtOsjjFaA=;
        b=QvWtBG5bJ5/+0yz2pLx2qBZeskBzzl3mDv5droLCzW47NeHhi4bj+APgjIB+NSScPF
         O2KsU+iMKwmez6/W1Pa4UZ7bViJ9iaWa6EtvyQWaz7tLSS2rfg+dqZ1SwbFnBp1+gVVB
         V1V17zCCh4fNZEfQa4hHL8gnYF4W3nRvOOuEasSTgFb4FPEQymYFxYtowKvBvYH6vlvg
         +moOWHa8LiRSPBzzV3KUNelRbFRTc0sJ+OiakNqDvMyUW3eZNRd8mSbgjMevZsigPTm4
         393TiEmXXfNG2ljEVG99Kc7qLs/LcLhz29FnrDU4OJJxc27oFmp7OeUNqglRePr3M53U
         YYsA==
X-Gm-Message-State: AOAM532ccUhacpJIjeTi0AI3CTH/FWa9X8BE4WnwcXVxg0g8xJ84XCpp
        5mxY97d86xOi6jt6rFnZOw7+TQ==
X-Google-Smtp-Source: ABdhPJzd9MohPSdgpI7PT06NrpVeiGGVvF1d4vkuVIARh6Sr2k+nuPxNbBaG8oTBR6ik6brdH9/xHw==
X-Received: by 2002:a17:902:b48f:b0:15e:da68:8f12 with SMTP id y15-20020a170902b48f00b0015eda688f12mr24076205plr.27.1652257895794;
        Wed, 11 May 2022 01:31:35 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:35 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 04/16] riscv: Add vector feature to compile
Date:   Wed, 11 May 2022 08:31:14 +0000
Message-Id: <f286c78682842079f4718af15f6a5c38ba289e51.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds a new config option which could enable assembler's
vector feature.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Kconfig  | 10 ++++++++++
 arch/riscv/Makefile |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..f54f37cc746b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -343,6 +343,16 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config VECTOR
+	bool "VECTOR support"
+	depends on GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
+	default n
+	help
+	  Say N here if you want to disable all vector related procedure
+	  in the kernel.
+
+	  If you don't know what to do here, say Y.
+
 endmenu
 
 menu "Kernel features"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7d81102cffd4..1f19bdac6767 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -50,6 +50,7 @@ riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
+riscv-march-$(CONFIG_VECTOR)		:= $(riscv-march-y)v
 
 # Newer binutils versions default to ISA spec version 20191213 which moves some
 # instructions from the I extension to the Zicsr and Zifencei extensions.
-- 
2.17.1

