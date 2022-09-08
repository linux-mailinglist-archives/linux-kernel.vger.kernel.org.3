Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB005B210C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiIHOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiIHOpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:45:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CC10572
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:44:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2555218pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=J1tHlju2+cXYieX/pEOr8qlvVRzsaNnqR5zd8sgRAW4=;
        b=gmV61+9vUSmtpDQFopsJ2ku3wTMWgbaDlPMVRXv9AHl4iBvo7ocd62TOfwkJbaLlD3
         sdT+g6nLvNMzHUhHmtJMNBASiEfsmw5xvFYEEpF5JM8o+Z95TepA0A+CNZRGuWl2+0Ib
         FSOAE6spy6vcklkB7VHY1c58jGl7J+cTfUZGw3XEpdmxWADy8O7kPJ70CNnTLI4noPYb
         3kDm38AsD9c3hqaGc0CFGnWsvAUdNYGezZtE2RgipI8yB0lzYIr45BNTI/FRQzPqNSq2
         TPB8PMf0lwv6udO9FeRhJ7E/YjNbr2+Col9SKCnYpk4TdSc9Kyt66l7al4XJYsNNmdU9
         rxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=J1tHlju2+cXYieX/pEOr8qlvVRzsaNnqR5zd8sgRAW4=;
        b=gXIV5yz9kAaKkJKMLxKp5gTWuAhjfQpb994T87ZudypUJenav+NbgMP94lMkjK6/cf
         3QvWNnPBQvLnSDPoiHrl4pjYs0JLMvTTvKuFNgrcTE9ZkOsBK1AbMwhRNA5lKXCsC+VC
         st/y9dpKo18orTDkv4ZEselwgCwfmlUqaMrosemvN0Y3x2JkrPdaFv+NdSrPaSt6jqq3
         TZt+MPQtFzIWKQgXnsEN4FX36MtwC2AbGt4nNm2tKd4FXIuQZJiEP41T2BD3r++P3IRe
         /gP3Q1F0B7fdgfRoDUBtdgNR9Fyv3KgOWxAg35HZd7e/OZ0LUFeg5xaI6UgrCD/Bo7J4
         5nbA==
X-Gm-Message-State: ACgBeo2krRv1SJgVJM+AeawU8c6VkDLi1bfE5jU0xeOrTgu0mjonj8Uj
        LKWIXNBanSnrAy3NS6P7TeVgjC1jSfThpQ==
X-Google-Smtp-Source: AA6agR40T8VGOwQPVPXwn0xDEJUAihdvvc+xd5Ba8Hk/nOFgbOdiZAU3choIZea4zpjK/11k8ZrXAg==
X-Received: by 2002:a17:902:d2c7:b0:176:c8a4:2f2 with SMTP id n7-20020a170902d2c700b00176c8a402f2mr9425217plc.119.1662648289321;
        Thu, 08 Sep 2022 07:44:49 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d40400b001750361f430sm4484728ple.155.2022.09.08.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:44:48 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 6/6] soc: sifive: ccache: define the macro for the register shifts
Date:   Thu,  8 Sep 2022 14:44:24 +0000
Message-Id: <20220908144424.4232-7-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908144424.4232-1-zong.li@sifive.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the macro for the register shifts, it could make the code be
more readable

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/soc/sifive/sifive_ccache.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index b3929c4d6d5b..0ddcc657c694 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/device.h>
+#include <linux/bitfield.h>
 #include <asm/cacheinfo.h>
 #include <soc/sifive/sifive_ccache.h>
 
@@ -33,6 +34,11 @@
 #define SIFIVE_CCACHE_DATECCFAIL_COUNT 0x168
 
 #define SIFIVE_CCACHE_CONFIG 0x00
+#define SIFIVE_CCACHE_CONFIG_BANK_MASK GENMASK_ULL(7, 0)
+#define SIFIVE_CCACHE_CONFIG_WAYS_MASK GENMASK_ULL(15, 8)
+#define SIFIVE_CCACHE_CONFIG_SETS_MASK GENMASK_ULL(23, 16)
+#define SIFIVE_CCACHE_CONFIG_BLKS_MASK GENMASK_ULL(31, 24)
+
 #define SIFIVE_CCACHE_WAYENABLE 0x08
 #define SIFIVE_CCACHE_ECCINJECTERR 0x40
 
@@ -87,11 +93,11 @@ static void ccache_config_read(void)
 	u32 cfg;
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
-
-	pr_info("%u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
-		(cfg & 0xff), (cfg >> 8) & 0xff,
-		BIT_ULL((cfg >> 16) & 0xff),
-		BIT_ULL((cfg >> 24) & 0xff));
+	pr_info("%llu banks, %llu ways, sets/bank=%llu, bytes/block=%llu\n",
+		FIELD_GET(SIFIVE_CCACHE_CONFIG_BANK_MASK, cfg),
+		FIELD_GET(SIFIVE_CCACHE_CONFIG_WAYS_MASK, cfg),
+		BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_SETS_MASK, cfg)),
+		BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_BLKS_MASK, cfg)));
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
 	pr_info("Index of the largest way enabled: %u\n", cfg);
-- 
2.17.1

