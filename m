Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD965A5E03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiH3I0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiH3I00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:26:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE41072FE7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:26:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso5690882wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XM3hePWi4RDkuttssXrZ5VE24lNRdsy0rflErqQPY28=;
        b=bzJhyUUM5uZv8zprUMiOXaBrBVZ/UgJq0b0zOl6DqnXHgQojf+yPBZ5c8Z9vFqh5q0
         2nQC93flygBxrmVG+ODrSWT/eSkSNRTcX2Y6vLp6UMgN3/WzkLhiHTMdoy6o6HA73hUW
         7zxAcvoE2q3BvvO1sPktBzvhptHkN6EO0boN3qDwA5hFxGEbpZPabuYASBL9G8gR0zxJ
         YUfIkQ9wY2Dy2pgy+A+lXXGd5UaZkvFVPTtexArM1iN/Tpw8y+A3cUa1v1LaizfnEZDR
         Lq0pD5DIkVkFPgjzUP/wcrekf2b9g/c6OrRoDafImhR/ymh1Zr1j9JhaxlCfkVmB8cve
         YtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XM3hePWi4RDkuttssXrZ5VE24lNRdsy0rflErqQPY28=;
        b=mpBLZOqjN3QE8naj0HtaxtUFr2YCI3jpJXOiM9jWMJ3Jq5RGHkT3cA/OZ6U1rJLkcb
         2UcyXimISTn951KfztWjYzmYTPsOpYd4fogX6Nz1tPf6Npob6FplP3CEHwkeBmcCJVr+
         7q30Y2ZQVa0B/zORzNKfMAHp5MpCxLFUrOUAd+W0+klyDn0vS/b4faCkyGJ05KmqCPnd
         rt151G17kSlp/f1hdhJ56Dgn9nfdMf/njE9vpI4X4yraK9mHigDiluPtu8UZe8MpM0va
         UuXoKeP7Y1pO87jRfn4JP2E00VuPb1v9NCYRSjzAKmEtX7VPy/xbLBlJWfNui817sEyN
         zjPQ==
X-Gm-Message-State: ACgBeo2QKex087AumqZy8kYoIMFQPPgkoTK7YDjsDDZLXyPbXkPveTVr
        ZKAzfL2tRXn4u89+KiABv7dkWw==
X-Google-Smtp-Source: AA6agR4t9yPdMnXaYpamc2su/lpj35tI/2NDGR0soqyjuxgixE2p5bvOVagi7BoSRqbqQcAVKeZZmA==
X-Received: by 2002:a05:600c:1e05:b0:3a5:b441:e9c with SMTP id ay5-20020a05600c1e0500b003a5b4410e9cmr8915891wmb.24.1661847983138;
        Tue, 30 Aug 2022 01:26:23 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b003a5ea1cc63csm11051643wmb.39.2022.08.30.01.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:26:22 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     zong.li@sifive.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] soc: sifive: ccache: reduce printing on init
Date:   Tue, 30 Aug 2022 09:26:20 +0100
Message-Id: <20220830082620.1680602-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829062202.3287-1-zong.li@sifive.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
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
 drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 46ce33db7d30..65a10a6ee211 100644
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
+		1ULL << ((cfg >> 16) & 0xff),
+		1ULL << ((cfg >> 24) & 0xff));
+
+	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
+	pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
-- 
2.35.1

