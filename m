Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5352E5B210B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiIHOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiIHOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:44:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C8127FD8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:44:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t3so13032586ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=/LYqlihFtMiIWz1JCFoOXwhnLs+6cX2BR50CFJfoD+E=;
        b=Ol0XOB9U8HsPE9InPTNP76q2kVkHaeDTLX7ySkjLA7fblhmynlxJK/umD98dF93OWO
         gSfZtwB/7mOTHX1+zi5xYWXRJUUsp5aFAzLxu/1FoO3SodUZwdj16cAeDOncHZ01Hr4i
         vhGEXA1dBrQ0e7/WrTzsYbveg2em4IQ6NJke9OVQ+9WELP+vmmM6stxg+QyG8hEmbN9B
         BSt7P2H2W/f2F0DJBVEsk2WbmH/bOmkdLOsrI0QlZX2ciio6Spo8SSYyEfyqgBQrjRlX
         +g1BxAexU5XmTEFTFWYpf2ApYtrUX+94jT2npHbQYDAvZn6joROjgtPfAD1tGri9djNi
         Ya5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/LYqlihFtMiIWz1JCFoOXwhnLs+6cX2BR50CFJfoD+E=;
        b=ZTmon1w/i2NWhfMMXcANXt7KVqjrvcnGyVOG+iJibQzHqgnKTJpMNlul07DhhKdwoc
         0sapIkd3zG/W4y7f7c6yXLrB4Fop420MzOuktA5fGDlwfueu7SYf7xT6UI1bHwBNfq9Q
         Gzd4xeo29pLS6yupPvGa0g2dwHzAZYoWkNt78o85knbLgpEVelmzknTdSE0rKniANAJv
         zCF/4L+gCvU6ibDvAseNu3dTVehwwEzIKKmhsd0xY4B/1zFgdK6nVW6EH+V43bz/MbJ+
         kFxT6ertNOpLIHF2rUNzkatu503SlZHrN2A2eIRfcB+NZUYEdlasTh53VuOt2XimV9xa
         DEmw==
X-Gm-Message-State: ACgBeo3tO+MZZMGXcWJBU3amFZZPI6qggHg6XHZKvXujR56N9FQ9M3Ck
        NoTdHHPp0wnKAMp5u/dQWjIbjQ==
X-Google-Smtp-Source: AA6agR5MoBM6Nh6NRv9LGoE95XEgih+Iu0/v2HU4oT6nYhN+8muWh796COOMMkr0kmLxVfQjEs5RRw==
X-Received: by 2002:a17:902:ce82:b0:16f:9697:1d94 with SMTP id f2-20020a170902ce8200b0016f96971d94mr9325306plg.12.1662648283072;
        Thu, 08 Sep 2022 07:44:43 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d40400b001750361f430sm4484728ple.155.2022.09.08.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:44:42 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 4/6] soc: sifive: ccache: reduce printing on init
Date:   Thu,  8 Sep 2022 14:44:22 +0000
Message-Id: <20220908144424.4232-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908144424.4232-1-zong.li@sifive.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@sifive.com>

The driver prints out 6 lines on startup, which can easily be redcued
to two lines without losing any information.

Note, to make the types work better, uint64_t has been replaced with
ULL to make the unsigned long long match the format in the print
statement.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 690c19489317..58d14f11a63a 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -81,20 +81,17 @@ static void setup_sifive_debug(void)
 
 static void ccache_config_read(void)
 {
-	u32 regval, val;
-
-	regval = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
-	val = regval & 0xFF;
-	pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
-	val = (regval & 0xFF00) >> 8;
-	pr_info("CCACHE: No. of ways per bank: %d\n", val);
-	val = (regval & 0xFF0000) >> 16;
-	pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
-	val = (regval & 0xFF000000) >> 24;
-	pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
-
-	regval = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
-	pr_info("CCACHE: Index of the largest way enabled: %d\n", regval);
+	u32 cfg;
+
+	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
+
+	pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
+		(cfg & 0xff), (cfg >> 8) & 0xff,
+		BIT_ULL((cfg >> 16) & 0xff),
+		BIT_ULL((cfg >> 24) & 0xff));
+
+	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
+	pr_info("CCACHE: Index of the largest way enabled: %u\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
-- 
2.17.1

