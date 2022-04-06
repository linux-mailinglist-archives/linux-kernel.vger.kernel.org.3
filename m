Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A214F6EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiDFXkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbiDFXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:39:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78710200342
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:37:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so3400838plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MgwUzux9l9MfjkfiPyLThjf7TEJ7a+1kv720LXWdL0c=;
        b=h3rzaO/ehbfZ3kl2FGqKxW6CKni734T3jpG3x+dhqbWIx0ekxvMJytn06tsYtavlKS
         p7odvwy7v3WOQFdQ+vTa6dwdAxbRBySInSfsw4+BBw6Xok7WEWgHy7uuYd4mkVKhJI3A
         QYge0VgdY5Ua0NStPSbitgP35D1VdCR1LWosIfyACxiSrcYRr/4TBTjBGpFXZNF7PHAN
         ZgDm6vBGthjIXGD7vnJZhMg1USt7k6pniK5j4hENo9d8uyBLlAVJiXOlkyUrAH4dVzGw
         qST0RXzc1ZnJqNsu9iRuwPVHItUL0EN323XjyJzmygDPKZZuVOZjk7ULU1eLwL71oShJ
         iOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MgwUzux9l9MfjkfiPyLThjf7TEJ7a+1kv720LXWdL0c=;
        b=QvBKqAfTy8cJ/QcnBZrHPZz3zvfXbITvfHk7BUc0gvZErZk0hINOlbpPu1KIqQaxDG
         ky8cxOWH5tK7WBPDULtm0l2fupp4lZMw6zOhbutpid/QPn1vFWnTGj8KBF6IWLeRDHhX
         Vk6kcKgq5DyBux5NS73WHHJZNc1gQgJO2t+hhjqqGgki50pc11ziNTggnbSf5hvvcnGG
         VUk+6fWjh5vZz/aWhz+LCCvHgqjIGFwn1MwbJ4hKQ2d63KR8/a9IUZd6RDagDQNymsJ1
         rBy0QHkSFAhrba1Xw3JSsNainwnb2N6Kuhjlxko1jxik2hB5PE6ez5xdo9X3Gv9fSi4d
         gqbQ==
X-Gm-Message-State: AOAM530V4eovP9iVKXDm2vKpuQJb4fo4nK5ipulK730jkUfgakSIXNXY
        70CqZ6jIMRDMLBADbI8UVCiGcQ==
X-Google-Smtp-Source: ABdhPJzBI/AgQUtI42LRmJQIG6o/7UZtBtE27V6Ss9Y15BjgUkXheWJ0cSmnrjtHxtCg+5UlMXWc5Q==
X-Received: by 2002:a17:90b:1642:b0:1c6:c6d0:fbfa with SMTP id il2-20020a17090b164200b001c6c6d0fbfamr12403634pjb.218.1649288237042;
        Wed, 06 Apr 2022 16:37:17 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:16 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm64: Add config for Pensando SoC platforms
Date:   Wed,  6 Apr 2022 16:36:44 -0700
Message-Id: <20220406233648.21644-8-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_PENSANDO configuration option for Pensando SoC
based platforms.

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Fix a typo on interface max speed

 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123cde02c..e3b5557e1049 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -203,6 +203,18 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
+config ARCH_PENSANDO
+	bool "Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based Pensando SoC
+	  family to include the Elba SoC.
+
+	  Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

