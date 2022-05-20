Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B578E52EB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349007AbiETMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348971AbiETMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:02:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB115353A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:43 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CEEA23F20E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653048160;
        bh=qJUgF2uIsMxkljS/4yaisro4oqOzykJLvWhhsyq41W8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bNeZ2WzXg4Ul+Rhg8QWMc1B3zFuFJB4pNL+DWAGIOqgakbXsqJzA30p5jEDZbgkLL
         w0IGllSMfXRTbHDmbIc47gjY2I1+VaqRsHKsIgPp8LGTCNjjS8KUESYuAhfoWwWy48
         8K0Y/wuKML7u9Og2vJ8eE18LHtTz6/hn1gLZqGK3WXFhErwZ6u/qAhKdSnbrkPd9cu
         dsTfIjACl3kEHzStFrt0E6EO67lodEDdn+1HaEITD3KIpqGzr96sF8cle51lH1tEIx
         SlEwMXwqk4uo85darae0tosOP1Twu8UH5FcQOj0Q87W373pHrZ3UrPcHaZrW8rUX8M
         rvvuHth9KhQ3Q==
Received: by mail-ej1-f70.google.com with SMTP id oz9-20020a1709077d8900b006f3d9488090so3925875ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJUgF2uIsMxkljS/4yaisro4oqOzykJLvWhhsyq41W8=;
        b=K/I64wg76Sx9Vi8X+yxljpISNvVQcTvWU5iEUP2eaXlllnUuRTi3N6aMDo4qH3JBMd
         IYgpZ62pBtaZ+Sj5SgZv9ulJB6Op+i48od7qqG+8y2atder9aw6EgFat5CvvygjkKxG0
         Llf0dF+ncWxw33a5YnI1teDnr/R0DV0v4jMXFdk/ixfIzK2i2S4+E2oKEAFdNr0vJ8pW
         NaeBDB0qeqoUSPDoUg+ThixwT8WLfFQlPCjVJuTgKlT3f+T4AZqZMRWAR6y7sVXrs5i6
         NE3iXX30/xx0VBBhmqICRco9/b4PIjG5SO/0utWu9/REl/Opo05Z0vENT/XX0PIxZWus
         iZnQ==
X-Gm-Message-State: AOAM530Tfm8shiX7V5zq/L04KVRUHDGLTULK35WYqWZLbzYYznVnMoaG
        bj676oxH+4O6LFfDn+E5fxFzIyZIxkXk82iZdUHwbCbSdt+Rj9DFM/8aDGO0ZpW/WKV+UnMwwq6
        sb8B7z3pi738EyXWEEc5jDnnbIBnx4NBFB9bR7wjhbQ==
X-Received: by 2002:a17:907:7243:b0:6f4:1ce5:4ac4 with SMTP id ds3-20020a170907724300b006f41ce54ac4mr8246063ejc.198.1653048157725;
        Fri, 20 May 2022 05:02:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx85Zt2rXo3aS3bxfgLeu4hY741HrqpGlVQ0XP/HkoRMsVc5ltw/pyBzC7DfFPWQ1vJSsLR0Q==
X-Received: by 2002:a17:907:7243:b0:6f4:1ce5:4ac4 with SMTP id ds3-20020a170907724300b006f41ce54ac4mr8246047ejc.198.1653048157519;
        Fri, 20 May 2022 05:02:37 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id fg22-20020a1709069c5600b006feb002a620sm560042ejc.1.2022.05.20.05.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:02:36 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/3] riscv: Kconfig: Fix indentation and add comments
Date:   Fri, 20 May 2022 14:02:30 +0200
Message-Id: <20220520120232.148310-2-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520120232.148310-1-juergh@canonical.com>
References: <20220520120232.148310-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add trailing comments to endmenu statements for better
readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/riscv/Kconfig | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..4507847d7c9c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -328,11 +328,11 @@ config RISCV_ISA_C
 	bool "Emit compressed instructions when building Linux"
 	default y
 	help
-	   Adds "C" to the ISA subsets that the toolchain is allowed to emit
-	   when building Linux, which results in compressed instructions in the
-	   Linux binary.
+	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in compressed instructions in the
+	  Linux binary.
 
-	   If you don't know what to do here, say Y.
+	  If you don't know what to do here, say Y.
 
 config FPU
 	bool "FPU support"
@@ -343,7 +343,7 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
-endmenu
+endmenu # "Platform type"
 
 menu "Kernel features"
 
@@ -394,7 +394,7 @@ config CRASH_DUMP
 
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
-endmenu
+endmenu # "Kernel features"
 
 menu "Boot options"
 
@@ -430,7 +430,6 @@ config CMDLINE_EXTEND
 	  cases where the provided arguments are insufficient and
 	  you don't want to or cannot modify them.
 
-
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
@@ -522,7 +521,7 @@ config XIP_PHYS_ADDR
 	  be linked for and stored to.  This address is dependent on your
 	  own flash usage.
 
-endmenu
+endmenu # "Boot options"
 
 config BUILTIN_DTB
 	bool
@@ -533,12 +532,12 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
-endmenu
+endmenu # "Power management options"
 
 menu "CPU Power Management"
 
 source "drivers/cpuidle/Kconfig"
 
-endmenu
+endmenu # "CPU Power Management"
 
 source "arch/riscv/kvm/Kconfig"
-- 
2.32.0

