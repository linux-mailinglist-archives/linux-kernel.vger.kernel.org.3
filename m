Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6121E4D0BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbiCGXKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245702AbiCGXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:10:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72EB31526;
        Mon,  7 Mar 2022 15:09:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso342372wms.1;
        Mon, 07 Mar 2022 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Irknw6RQZUFdI9aXxc+3L26hKyaP/zkHhWNuLVXeO0o=;
        b=dfbKY+mnDGP4mJ8Za885HhOBk9DHTkBTNOFC/iNhyD8vE9thA6b2Mw/2+K5Pw5Bn4i
         qyaFa02sE9zEqane//Kv7zLPm3r5D50IUnPtc9BaBPKTT8nn1a5wlJaAuljWmZHGBBlR
         4wIPjzPRcKY3USfEdPZbtbkeFjmHmY13aSLPP8xOOl72d2XaWk4D+YU7co/9214pyqBg
         VYZ/XwyKJlGuPrYpyaGFXuJQ0rKd/SXI9ILBjHZUQfKCsqLCGBms/OHKOPH+jWuHSMgb
         WmwQWkIhwO2/NzY5fRpucmVGOdZV+2cndyJVfVJAZqNOn52a0lT6sDvzEhNOT7C59s6G
         /VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Irknw6RQZUFdI9aXxc+3L26hKyaP/zkHhWNuLVXeO0o=;
        b=6YL7xuD4N5UlTak/V5dJi2J+8ciAZNuOxrmdmoEts/EIkYXgmdBJX3/ml7BxhFPPKv
         5n1SGtBUuXJfxmlmwAMQy+X+EIJ0jLbiNN7EGsnmHRe6g6YW+0y4GN6A8xS204Da5Qx1
         kMBPbXSrE5p9VIkdF2nLaoPbimdXYRN5kYlsRPAQOpK0J/kmQ+QIkjUrq5y/6OgtF3bn
         SDpjHV8+gQJ9gSIpFAfCBxLJF6+e8NHabSfIe7sJBun4irUFsuKO6ZB3wXhtCiyCZX0b
         +6U9YhpmC9/6pbr+2ONvgorP4LNtsU+grnPSUMv1PSZUDcEtXzAX9uetCi410tWbNxV1
         wC9g==
X-Gm-Message-State: AOAM5333GAFcKVYfKBDQ69jbfagJMuX3YGlVHarcH1hmjRBYgihOtKsX
        olvIBTWaSZ6Ele8EbUKD13s=
X-Google-Smtp-Source: ABdhPJyUVoSvxkCc+Dedh2m8q/S7kd59ABqP8cYxYRUUL2GD9oC3GwI2gz1/0P2Mqn1+Cwj2/nC1+Q==
X-Received: by 2002:a1c:35c9:0:b0:37b:edec:4d88 with SMTP id c192-20020a1c35c9000000b0037bedec4d88mr1015533wma.159.1646694581283;
        Mon, 07 Mar 2022 15:09:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00389ab74c033sm566569wmq.4.2022.03.07.15.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:09:40 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: nand: mxic-ecc: make two read-only arrays static const
Date:   Mon,  7 Mar 2022 23:09:40 +0000
Message-Id: <20220307230940.169235-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only arrays possible_strength and
spare_size on the stack but instead make them static
const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/nand/ecc-mxic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
index c122139255e5..8afdca731b87 100644
--- a/drivers/mtd/nand/ecc-mxic.c
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -224,8 +224,8 @@ static int mxic_ecc_init_ctx(struct nand_device *nand, struct device *dev)
 	struct nand_ecc_props *user = &nand->ecc.user_conf;
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 	int step_size = 0, strength = 0, desired_correction = 0, steps, idx;
-	int possible_strength[] = {4, 8, 40, 48};
-	int spare_size[] = {32, 32, 96, 96};
+	static const int possible_strength[] = {4, 8, 40, 48};
+	static const int spare_size[] = {32, 32, 96, 96};
 	struct mxic_ecc_ctx *ctx;
 	u32 spare_reg;
 	int ret;
-- 
2.35.1

