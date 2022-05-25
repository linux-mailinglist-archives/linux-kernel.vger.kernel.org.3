Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813BD533E13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbiEYNmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiEYNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:42:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738560D86
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:42:19 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AF133F208
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653486137;
        bh=+VxdaNpJpgbuyYbGPWQ3j6iLwWVMldqSArRiIGoG5Ck=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=MNrR5li2xhugiDoapM5rYXU6WGz2N/CdpT/TSQhRaZjvW/diQsDLN2Zh2IfZVK4Az
         13qyqVhOxnvlSIRhh1kI5lPcZL6jn6MWlVK7r01zILX+EutXr/8QVABARzV1wF6GF3
         2nRULvx8ZGLKZZ/h0KMoM0LSOLgBWudLhDxvgGWSOqJ7olQsMKGyJtswu2F1dBGO7R
         INm4ifOO8iCv9NL9/9jsY7+x6LUZl5XMx6nQwayzBe92Ktq43dmHDK91ejKXtWBj1t
         hXQDeMJb/A1k9a6IAn8MYukhACo4Dpn2LhE5MSu1MDtTVpI/cGKMzK/uyaJ54aJc7l
         /Llyzmrvyb6Fg==
Received: by mail-wm1-f71.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so2870543wms.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+VxdaNpJpgbuyYbGPWQ3j6iLwWVMldqSArRiIGoG5Ck=;
        b=rLVlKfhsbvSextZQm3GfUIuDh3ex4fkREAPbnWd/XFc1X9mscnUWnyVRGzHVfwSU7j
         +118xROEiS+L6U8zioj3b37t65VPB5UP9Kf53ptWGpWOicvWEqD7rWfECBUvwabvPYtN
         uRf76dsTkl2Zm9L0JaMnGfTWkmdGVRy9Erld212FuoOkCuh3ZafsRkyt0f+I42G2B+0C
         BYkkXyUvatBuX5FjJVLL6xoJqfHdmxckYQ14Thai5vmojww/T/xkoz0rG65YijH1vqWG
         6yllJ9VKtQFtCMAA+2jPNc6aeAABZGEM6ZTTLIzLJmSM9rC6yLWbB5l6Og0xrl5xV2Qr
         CTqA==
X-Gm-Message-State: AOAM532EVTuf596yn7f0RsRvy/U/2NR+0Li9/O2U3ul6c/x01wb8WQrF
        K1Er4kNE9BtfauOXvr8gNfhE8P0i08gscL7M9tKMGbK1Fo5xi9CPXiXjgutcqG3Afh4Xp50H8Dr
        H25kUiCMDMOMYCxU4XxYgWta4mKPc+HlfHdTuKuWmog==
X-Received: by 2002:a5d:5885:0:b0:20f:f390:c47e with SMTP id n5-20020a5d5885000000b0020ff390c47emr6442932wrf.133.1653486134742;
        Wed, 25 May 2022 06:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyChDi8V4mTkhBMNVYiG8rb/JvRySCfyubTMbdjD4OIepvluuW4yJL5Nxe4jz+VCB0K8Q0+zA==
X-Received: by 2002:a5d:5885:0:b0:20f:f390:c47e with SMTP id n5-20020a5d5885000000b0020ff390c47emr6442915wrf.133.1653486134522;
        Wed, 25 May 2022 06:42:14 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d64e5000000b0020d0c9c95d3sm2151947wri.77.2022.05.25.06.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:42:13 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] x86/um: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 15:42:11 +0200
Message-Id: <20220525134211.54417-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/x86/um/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 1bcd42c53039..186f13268401 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -32,12 +32,12 @@ config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables" if !64BIT
 	default 64BIT
 	help
-	Three-level pagetables will let UML have more than 4G of physical
-	memory.  All the memory that can't be mapped directly will be treated
-	as high memory.
+	  Three-level pagetables will let UML have more than 4G of physical
+	  memory.  All the memory that can't be mapped directly will be treated
+	  as high memory.
 
-	However, this it experimental on 32-bit architectures, so if unsure say
-	N (on x86-64 it's automatically enabled, instead, as it's safe there).
+	  However, this it experimental on 32-bit architectures, so if unsure say
+	  N (on x86-64 it's automatically enabled, instead, as it's safe there).
 
 config ARCH_HAS_SC_SIGNALS
 	def_bool !64BIT
-- 
2.32.0

