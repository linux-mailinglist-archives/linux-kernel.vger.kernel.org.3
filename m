Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24DF4DBE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbiCQFjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCQFjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:39:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808C26A978
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:08:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q19so1811659pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjOHj/8BATPBP0IusStgCkjkvXpEOFe7FfCA17j19dU=;
        b=o1u3cr7gjNAmLIFszokjYtRlBW9YgENKNSlekv8UL8chTfVfPdo6wVkoY6bwpm60l6
         l3jwfncEOHo063kGAFw3R6s40XnNCmp8ZGTK9gz8JM69rP4B5e7w2FewsQG+0kY8xkBE
         VY11XP+IZ7GEHIlyOyh7s8/Rbkdl9MqIsfNeSmI6fiksjsG4xzEalnCm8D4AwuPqOO6S
         uXEKkzZkHrHl3dLpgT9W2dx3xNS3+P6sjXgIYRYKxv6lZ5nlA4sVTQMiGVM2+dLHvn+x
         s9Akgp3UHRCkylI1xF2HXF6cpEaW//VHHRTxW+JxEouHH72oSD9c91epcZkwmiepKuMF
         1+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjOHj/8BATPBP0IusStgCkjkvXpEOFe7FfCA17j19dU=;
        b=Ha7kOiO0PpPGNJ3imrtxUsmM9QFqOuMqcJRbjLDHzbL9rzNGp1/h6NBz6uCprnHVOO
         7bfdFz7tZD9YIvmYmh2IZBMf96zeW3Ywq1/RWpA9TeQ3xH9pcpBX91O+wGKC1+jb/dmG
         WnOCRg0Ys1NW7//rnj2asXVFjp7gc6mIphHvqkvgldWW31GiFDKJ0WY7r8NSXwQ0L7gg
         qd7RiXT7acq0SeJd0BA3ZhFKcX6On8P30u6dq1SBi1pA3G21R5SWWgk9OF8ukk43HcJM
         r29lWY6iWG1abRU+BTj47mdDnTQfxw8WkwKzXDYyUNFq6cUO7MWjTCPSwzz11vwH1qdn
         qWXA==
X-Gm-Message-State: AOAM532/90WWDxsy/9R5KgptkPJSIHZ44oHcdmJq5tdePuZlzAdPRNaa
        hez3trMV5mgKSAqTW1/bETOOk19DJJZA/g==
X-Google-Smtp-Source: ABdhPJzI9v1AsK1frl/OfapPyfUjcQq9CI1+CjtXBFdgE2i0TOisHVwLb4aM0S1NFFwVdeouAbr7lQ==
X-Received: by 2002:a63:1743:0:b0:381:42cf:187 with SMTP id 3-20020a631743000000b0038142cf0187mr2035408pgx.397.1647489361831;
        Wed, 16 Mar 2022 20:56:01 -0700 (PDT)
Received: from localhost.localdomain ([122.171.160.59])
        by smtp.gmail.com with ESMTPSA id g9-20020a056a0023c900b004f736d081d9sm5184749pfc.64.2022.03.16.20.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 20:56:01 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: Increase range and default value of NR_CPUS
Date:   Thu, 17 Mar 2022 09:25:42 +0530
Message-Id: <20220317035542.272547-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Currently, the range and default value of NR_CPUS is too restrictive
for high-end RISC-V systems with large number of HARTs. The latest
QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
restrictive for QEMU as well. Other major architectures (such as
ARM64, x86_64, MIPS, etc) have a much higher range and default
value of NR_CPUS.

This patch increases NR_CPUS range to 2-256 and default value to
XLEN (i.e. 32 for RV32 and 64 for RV64).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..54f125eb10f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -274,10 +274,11 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	range 2 32
+	int "Maximum number of CPUs (2-256)"
+	range 2 256
 	depends on SMP
-	default "8"
+	default "32" if 32BIT
+	default "64" if 64BIT
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
2.25.1

