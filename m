Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA985AB745
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiIBRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiIBRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:10:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C48257E21
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:10:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b16so3101799wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XInrryNIY9nWPw8b/rG+4EuR2jYt8oyYwco8MBZZHcc=;
        b=GIKoSOuhwiUesp8AGGvxHNe3EaUB/b+26PjY8I+VMDZantQYIYZ/M021LDJNQxFcco
         2PRg7/nBpVjT+vB6uBOwL3TGcRydnFxwckkEzyBwNhZvA6gebP8xCUfs8JYwtDxYGQPq
         otHNljJ0+EiseZUtlFCgeS7JKwlnVT8jNY4nEbLrHhp6XKX/eNLkZRFxHsld/j+Wdfb4
         opwk7xS0pZWITa2aSHYOqDMrx07eWI21ntk06W4siWM/DlnHBWhhpb4vG+dazXNi/TMB
         L2JE8KT8fcSE5nSuvtbPA9wW1ve8DroftBDtr8vTSdPMzHEzENTmXbV3pGxVqTFS6Hvx
         LSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XInrryNIY9nWPw8b/rG+4EuR2jYt8oyYwco8MBZZHcc=;
        b=iSRU6//ksNm0T+vXhUvI+ZiQvYiWtDnUvvGwMH9/7yeNyUT4BBsRX4gAgWfXSXnAx8
         uHBkXWDuqz0VETOBt34FFFIGa+rXSm2KLCdTTyyWxm+H5lxropuyDIKyc0kIl1e6vuI8
         1/RVop9oijDYwZySBwwCPXmK6ht1usQw4I6CgL+xnabiLQOEnVD961Srg20SF5cfrDxg
         naF8LbLZh8xd+ao2j6vXs45IrftkEO/o0aEY/xdE38csQbT17bvpcQjoREtpsAcO4C8d
         kZhMxA+02PBAw+uOx8scWLEJ/p/fwDsoMleAnSqN7SkypFUnJJG26NzBV1lymfKzGj4H
         GgVA==
X-Gm-Message-State: ACgBeo3eFXnLKTwT2mLgLxBWzk3p6R1dbeuF8HdBOpdIpw862rPML3Ww
        I73zQ23MrGX2Ea+0u4HOldjXOjCnhJqjnA==
X-Google-Smtp-Source: AA6agR4uxHa2OJgeNRbbA9gbB7n+j+zIQ9GOlB1nKzHS74Bmd1PDSM3ClcIzsfGQrtRZNYj5Iv7u+g==
X-Received: by 2002:adf:db06:0:b0:220:7a57:6665 with SMTP id s6-20020adfdb06000000b002207a576665mr18463946wri.55.1662138652877;
        Fri, 02 Sep 2022 10:10:52 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d66ca000000b0020fff0ea0a3sm1950651wrw.116.2022.09.02.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:10:52 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zong.li@sifive.com
Cc:     Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v2] soc: sifive: ccache: reduce printing on init
Date:   Fri,  2 Sep 2022 18:10:50 +0100
Message-Id: <20220902171050.257409-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
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

The driver prints out 6 lines on startup, which can easily be redcued
to two lines without losing any information.

Note, to make the types work better, uint64_t has been replaced with
ULL to make the unsigned long long match the format in the print
statement.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v2: use BIT_ULL() for the values.
---
 drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 46ce33db7d30..40d2ac7895a2 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -76,20 +76,17 @@ static void setup_sifive_debug(void)
 
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
+	pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
-- 
2.35.1

