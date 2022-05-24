Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38D55324CE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiEXIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiEXIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:03:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B393455
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:03:16 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 46E713F157
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653379395;
        bh=llXcMB27bzBY3jTzV9fPnL3rBPYYoIJI1kMb7QxoWZs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=B9bqwFjDie1BebsjK6oFuRMw41YRvY9bNBRhtLoylGL7/urkydGPgAg1DhTSW0jv2
         Lt1FcPSL1s0f9WswQhi4gK5EGvuUkrIbRK9MXPHkByBY9SJthMiNOHxPjcupfsYgYq
         3/klFUnXCrwMdCpK335/oA+CohsApPZKQ+ZdS1SfcKNj6ZIVHXmmoodOp9DOep+9If
         FpzDY1K3OCl6XUsl+hjyc+TeVRFrdCJkAoyKBm81vlp2V57CEseLMA5i/q+uQtO2yA
         nN1lq9lXRBPOrwLp1kj0Pn+dk7sh/Ca6uxaNtFxtYbwkLcXcknLGVtDaeGEEhiXEZy
         s457SGHeJqVug==
Received: by mail-wm1-f72.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso939074wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llXcMB27bzBY3jTzV9fPnL3rBPYYoIJI1kMb7QxoWZs=;
        b=gAAUf7+ZEzpx3MKFSdxfHTLe5OwfovIuBDYNClZot88rrRcvcw0pHBjXyKrmbc05iP
         ZZcUpwcme/PzhBLPPxCfUZO0BXUBXrQK0jP4u1qDoBpeiI1arrnxdf1Bg4aEyhKlqXYQ
         bTYD2GI1Ai+u37vi+lXxdB17Smsda2hMcIEmYFKbPVPIKKji0smuGz1mrGRC/7yS0kDF
         1JRLSsobJvLjPGaob2rk8yT0HW3WlMBqMYcZVHbxI9Fqmdm8XCI0bQnMi6cb6ro7f8Dy
         9nnXsP+tk335h1RMQ71vVrce/Dqo2LohOuIXa75JsZpNyzh1+jRRt8oGHldX6JB8zNHS
         uDFQ==
X-Gm-Message-State: AOAM531bbg6dMAeX3TmnC7+ZiqSrVXGaEmcxqkMlbiP44GI38ml8rWB9
        D5sv9/EtFBdFXX/p9HXH+v4D2E79vUxKmiJS1tGpxYp5nxz2gvrncXll+G6PQyzCvyP9tCu3bC+
        UtTeAQqV9++DSs8QVR0f/Fb0WWVl1j1+M13qPYpc3Hg==
X-Received: by 2002:a05:6000:1621:b0:20f:f723:ec49 with SMTP id v1-20020a056000162100b0020ff723ec49mr717742wrb.284.1653379395026;
        Tue, 24 May 2022 01:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWNw9OXR8ld6R1bAnCAZMWCeilUppYldTLCS0p1zIsVBDty0O40XQ4SsBaWhBThWVJe6AacQ==
X-Received: by 2002:a05:6000:1621:b0:20f:f723:ec49 with SMTP id v1-20020a056000162100b0020ff723ec49mr717726wrb.284.1653379394819;
        Tue, 24 May 2022 01:03:14 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id f9-20020adfc989000000b0020c5253d8e0sm11983117wrh.44.2022.05.24.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:03:14 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] MIPS: Kconfig: Fix indentation and add endif comment
Date:   Tue, 24 May 2022 10:03:11 +0200
Message-Id: <20220524080311.22133-1-juergh@canonical.com>
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

While add it, add a missing trailing endif comment.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/mips/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index de3b32a507d2..6e92ca97e479 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1321,11 +1321,11 @@ config CPU_LOONGSON64
 	select SWIOTLB
 	select HAVE_KVM
 	help
-		The Loongson GSx64(GS264/GS464/GS464E/GS464V) series of processor
-		cores implements the MIPS64R2 instruction set with many extensions,
-		including most 64-bit Loongson-2 (2H, 2K) and Loongson-3 (3A1000,
-		3B1000, 3B1500, 3A2000, 3A3000 and 3A4000) processors. However, old
-		Loongson-2E/2F is not covered here and will be removed in future.
+	  The Loongson GSx64(GS264/GS464/GS464E/GS464V) series of processor
+	  cores implements the MIPS64R2 instruction set with many extensions,
+	  including most 64-bit Loongson-2 (2H, 2K) and Loongson-3 (3A1000,
+	  3B1000, 3B1500, 3A2000, 3A3000 and 3A4000) processors. However, old
+	  Loongson-2E/2F is not covered here and will be removed in future.
 
 config LOONGSON3_ENHANCEMENT
 	bool "New Loongson-3 CPU Enhancements"
@@ -3255,7 +3255,7 @@ menu "CPU Power Management"
 
 if CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
 source "drivers/cpufreq/Kconfig"
-endif
+endif # CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
 
 source "drivers/cpuidle/Kconfig"
 
-- 
2.32.0

