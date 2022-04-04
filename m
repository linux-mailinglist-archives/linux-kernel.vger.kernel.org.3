Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0B4F0DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377077AbiDDEEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377060AbiDDEE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:04:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC723A72B;
        Sun,  3 Apr 2022 21:02:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso1863474pjb.0;
        Sun, 03 Apr 2022 21:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XeVwTDzrXqVMm+FV+pdpyBqyneG4xSl1PcMNGR1pJ1k=;
        b=n64jXqJuSD54zDdl9SzEdlpegLkU9Z+KblQccul6AKk3Oog51rbQLqMGP7QbR9bCQ8
         QgGASSOqzcDVo/RiF8bySSUeOAlA9faUZ4CDUy7zAdLfcz6lLhK6vdSqbtRvdfzdgHVa
         ZPjDbOQijGIlDvUWy22jiwSO6wq3lbwSrpZ70g8QBXtCPOKuqVPNKajiYbAPcV6S+/bZ
         hBjZ6Vi8HAlmMrA1F5x9rp4zIdgj+msvEHcD7QG3T9IdA/z6GJluFetiicE19ed0OB1f
         KxqY8xtUY4J3XviyPLweRS3k6N39z6OK2EjoNX0UOJ7sFRNlttm3xAkWRAUpmkNQdIhk
         ly9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeVwTDzrXqVMm+FV+pdpyBqyneG4xSl1PcMNGR1pJ1k=;
        b=wYc20XDVN/c8MRWvTzfl9nByghhKvPNcTncuyEDCocnpIqK81/yK7NaDmhKMwRAKe/
         H7uNu35gqr2NTIMwYeUUwY1yT/1hw4s0Tkt/wl0yaFvo+KgVpvQfYnzkAqmKa/zjjHGt
         Cvlt9isBilqKxlCaR7GuCG1WZ/+z/eRSjSodaMPodbuiqmaYKZN9MFiapP+5oVK8MFVu
         zzn8JXA6pMQ09BObzhQBQ7XcN1B9fz/XwaTu54Oqb2WEaL7dBRoIOM/mXzgXnn0FOpBP
         7WSewJwx+l8oNTEobd87HAe+oRlMe36Cjzy06W18q/wypTZ4C0JXg+Vw5i84xLWYMW17
         444A==
X-Gm-Message-State: AOAM5306t3Mzqbjxc3qmEDsrAlKrM0dgZDWqYlXcB046a0uEzw4hHRML
        /I8e0UfcRHn649Q2G3b1wB4xopa3wVNJB5hjedmrGA==
X-Google-Smtp-Source: ABdhPJwCr37hf6Rzgni7u/IRXGRnIMjMDRLrRUdoxnhWo812bMhhZ1X8EnHtZAnnazIyb7rxdDXPQA==
X-Received: by 2002:a17:90b:87:b0:1ca:a84b:37e with SMTP id bb7-20020a17090b008700b001caa84b037emr1140510pjb.168.1649044950447;
        Sun, 03 Apr 2022 21:02:30 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id j70-20020a638b49000000b003985b5ddaa1sm8756191pge.49.2022.04.03.21.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 21:02:30 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH v2 3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
Date:   Mon,  4 Apr 2022 12:01:51 +0800
Message-Id: <20220404040153.1509966-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404040153.1509966-1-gch981213@gmail.com>
References: <20220404040153.1509966-1-gch981213@gmail.com>
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

The recently added ECC engine support introduced a generic property
named nand-ecc-engine for ecc engine phandle. This patch adds support
for this new property.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v1:
  new patch

 drivers/mtd/nand/ecc-mtk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
index 74ddaa46ba7c..9f9b201fe706 100644
--- a/drivers/mtd/nand/ecc-mtk.c
+++ b/drivers/mtd/nand/ecc-mtk.c
@@ -279,7 +279,10 @@ struct mtk_ecc *of_mtk_ecc_get(struct device_node *of_node)
 	struct mtk_ecc *ecc = NULL;
 	struct device_node *np;
 
-	np = of_parse_phandle(of_node, "ecc-engine", 0);
+	np = of_parse_phandle(of_node, "nand-ecc-engine", 0);
+	/* for backward compatibility */
+	if (!np)
+		np = of_parse_phandle(of_node, "ecc-engine", 0);
 	if (np) {
 		ecc = mtk_ecc_get(np);
 		of_node_put(np);
-- 
2.35.1

