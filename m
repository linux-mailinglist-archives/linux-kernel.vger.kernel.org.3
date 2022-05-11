Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DF5231E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiEKLfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiEKLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:35:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7863380
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:35:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 31so1541652pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MZ56pDFwVnKOXfifpZSPr/1GPpet0KvHNF4wyHnxkM=;
        b=kqXr5s4dDIf9h5PnDYgt2/AU2H37ORdYS7RRO+BDROwYpLNWtj0EwKL7BDMfiaG81o
         6DAsreuSeFa96GQqEyYYi2STqkMUfcaqz200VYX39t4vOyJWK8JrZ78gvz6eh6Os9aB4
         UhnvG9wzD+6UoyG7qOCim2SKGqbtSzcDPmoc/T9k71tT2IMAMtgjYsZTkku5jzCFBoK2
         XjmZ8GIs5oz2VKCH9+5SetlGLh86g5SLntGL9RENCMBK0hjaxHtq/TPuQIdzzfU60LCG
         AtT88GzsslyN5ekx0a0P2MIsfRQrk6ZSvrkd8gqNKHTe0f+G5jOlDunorJXjlz51p5BN
         qCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MZ56pDFwVnKOXfifpZSPr/1GPpet0KvHNF4wyHnxkM=;
        b=zl+HXU798+rzq0RReh26ckZ9QFzxAl5eenviURsYHcnxFU6MMME+BviAyvCjfx2ho2
         QGb9o9Rrfb4nanWnwhYi3oC1XBr5yC5wpttkwNWlfTJxY8vn95c+Je4ewCoPgpp6ojzk
         KZXZaGtWsMpkGw9gApsmxINA4ZbX0RSx0rKFtpwrwlQVYayDT0i5fW0lJt4l9UbZvHZK
         rHPQloV/txd8l9gnfrNvWbhzvBT/odhoBFf7rVMBi7cErqCwrxo9UxDQlfHucBJ9uv3D
         H7aFAAkgR9G6hXtuIFb7qVjaJVsdD81/jPVgJd2gSWuy92r6/kEMxRRrJQhrU97iM0Bt
         6QwQ==
X-Gm-Message-State: AOAM531byZcDl/vLx9z2WH3akhCX+5VkeUcptUkHrCRTLPZmKE1fFQtE
        KFgeo3/uMuWlffVmEWfzDv4=
X-Google-Smtp-Source: ABdhPJxW6/PVUjOeQiDdk0es/i/xNSOdHBeITEkkMZvP6SketwG4tsot6BkXexicQMVtkZjPNXSzUQ==
X-Received: by 2002:a65:6d09:0:b0:3aa:1ecf:8848 with SMTP id bf9-20020a656d09000000b003aa1ecf8848mr20722322pgb.55.1652268914012;
        Wed, 11 May 2022 04:35:14 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s2-20020a17090302c200b0015e8d4eb23esm1584594plk.136.2022.05.11.04.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:35:13 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <b38343@freescale.com>, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] regulator: pfuze100: Fix refcount leak in pfuze_parse_regulators_dt
Date:   Wed, 11 May 2022 15:35:05 +0400
Message-Id: <20220511113506.45185-1-linmq006@gmail.com>
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

of_node_get() returns a node with refcount incremented.
Calling of_node_put() to drop the reference when not needed anymore.

Fixes: 3784b6d64dc5 ("regulator: pfuze100: add pfuze100 regulator driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/regulator/pfuze100-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index d60d7d1b7fa2..aa55cfca9e40 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -521,6 +521,7 @@ static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
 	parent = of_get_child_by_name(np, "regulators");
 	if (!parent) {
 		dev_err(dev, "regulators node not found\n");
+		of_node_put(np);
 		return -EINVAL;
 	}
 
@@ -550,6 +551,7 @@ static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
 	}
 
 	of_node_put(parent);
+	of_node_put(np);
 	if (ret < 0) {
 		dev_err(dev, "Error parsing regulator init data: %d\n",
 			ret);
-- 
2.25.1

