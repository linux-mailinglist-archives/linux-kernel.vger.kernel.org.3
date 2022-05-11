Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99145231FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiEKLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiEKLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:42:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D92229D1;
        Wed, 11 May 2022 04:42:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x23so1737859pff.9;
        Wed, 11 May 2022 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vR78/0cozBARbfgmLg/xD9wO6VleNhWzZE+8yJ1LpXQ=;
        b=VACSZeD+XR+ARtHH3HoDnaZS+Y9u1fGwlFPSmy63JxD/kP+30Jq0Bw98Lmoei0v+Bk
         dLtImgiBpBxS6NLLDcpRIaxfaEh2GQSLkpXGtKFHcusiemYSBHZs70CdReAUi4jZTYb8
         9RsUGKNJXVDh2GQXNK5pD3IW1dBPpyxJQ9jZkz4aiM9oXTT70rw0BVbYiUqnz5rSMtoJ
         VU7LRv2E8BiFHSAn/azo2T5/mtArfc7CUOavPLJeakQWlxtZyKY/p7zsttHQ2/LXBChX
         IZ/govXWVwDH0619SZw/Csb2RPynK/4UldL6zHvUyhYBnToqsPV0xnQqnbyIZeI9By0p
         lu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vR78/0cozBARbfgmLg/xD9wO6VleNhWzZE+8yJ1LpXQ=;
        b=Go6pnwfc/wvgFLRLOpJoxbbkijyyeszARUF1e3d79jxTA8Xd96mc8LI/BVyn8EF2Tf
         zlYI4bAKOQRPjtDZYW3mUe3ws/YNLgQcWmegn0gvs9fan3JQGTGlzXdxCPtZuUmgvmQD
         8gQGQvgAfxomExNs5ytX9KHQTBGrsk2EeFfKxKPiC1J9f39ilj6hBGs3PlqEsjozp6zi
         Z/4wPwucXoYW+yvugh2Y6tfHiz+7eY79ofEZcohReSvEFWrukFc2GpxBBcaue0ze3hoO
         wxQZyKTTfFMc1X+j+uyRtgaIynjg57BvYAuoSVFlU5Ihx4RpLtnO6uIdUUBG+JmUjuJK
         /BEQ==
X-Gm-Message-State: AOAM53339K2q7oxW1zA3ZaYKGO7GIqJCCZ3tH20Ljob/1nRWB3Bn2khA
        VcexWpk/YLykLkuph1xGqCY=
X-Google-Smtp-Source: ABdhPJwmoiL/c+C4ECSorOVKxMM33LVv+pl673jYWon4sDaR3WqZS1VElgoX59Aah3WRPCBSqoWfrg==
X-Received: by 2002:aa7:938c:0:b0:50d:418a:cdfb with SMTP id t12-20020aa7938c000000b0050d418acdfbmr24996286pfe.72.1652269342295;
        Wed, 11 May 2022 04:42:22 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id g1-20020aa79dc1000000b0050dc76281e1sm1474115pfq.187.2022.05.11.04.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:42:22 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Damien Riegel <damien.riegel@savoirfairelinux.com>,
        Rob Herring <robh@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] watchdog: ts4800_wdt: Fix refcount leak in ts4800_wdt_probe
Date:   Wed, 11 May 2022 15:42:03 +0400
Message-Id: <20220511114203.47420-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add  missing of_node_put() in some error paths.

Fixes: bf9006399939 ("watchdog: ts4800: add driver for TS-4800 watchdog")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/watchdog/ts4800_wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index c137ad2bd5c3..0ea554c7cda5 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -125,13 +125,16 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 	ret = of_property_read_u32_index(np, "syscon", 1, &reg);
 	if (ret < 0) {
 		dev_err(dev, "no offset in syscon\n");
+		of_node_put(syscon_np);
 		return ret;
 	}
 
 	/* allocate memory for watchdog struct */
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
-	if (!wdt)
+	if (!wdt) {
+		of_node_put(syscon_np);
 		return -ENOMEM;
+	}
 
 	/* set regmap and offset to know where to write */
 	wdt->feed_offset = reg;
-- 
2.25.1

