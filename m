Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF94F9258
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiDHJ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiDHJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:58:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B710ED
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:56:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j6so4356011qkp.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjH23Wya03LzbkbLO4xeU6GQ68cZ1wSb3Yi2WGQa36g=;
        b=kwZlD3/T+8qksiVvwDWjaBxxgIIVSYni2McJG2R8ABsKzH3XAndqvyO/puYitsTS6I
         hyMn439AjiX6+X7t0ybOotbpCUKestpjSQW+MwJ1tn4yHdhW/iHjc2WxVFtkKxfdhMAU
         DVfwk9KVG8qsFEUGmjkHd9pYPrhRDmsbMdOdVjHZwd+FqnmsWSchDQHJ9fRn+co8JGCF
         S64FHnf3u98DW7FeyG76CogW0Ge+PYcZgXfkzQ8n0D2kH6+QPg0CQu1Oa9OBJ8da223Q
         HpyDqiuyfos5Pwyf7YCGWgz9zahQ3CkyB9/mlOTc8gflv7vqJsXV1oQEHdGxbzldjx8D
         Cxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjH23Wya03LzbkbLO4xeU6GQ68cZ1wSb3Yi2WGQa36g=;
        b=GECyiDpcF1GjOqog/SpxCnA1mizXvUoIdpV9f0ScCdyefYBoULgZhvZZy2Aqa/IsYQ
         dFBktVq7Os8TpBFcBrZE2NP7Au0hEGrdrkLPIWKlE8aeDgb3NKS0YL//T+Hk2vZIYFAO
         xcOIShaZX1sTt8EBO34tNt2ZkpBbJKcOm+C6H0q9O5xyA4IajxbIJ1HM0h6Qsw/XJ0B6
         z6uPCyLq6I1IBXgP4Eat7FFZC4ZWBAdvmuB3rG3V+aQ9kEuqYvQy3iuD6mzIgbpL+3qv
         3B8tEABDd+rMs9qrKLjs/aaL/Hy147xQRpcniSBKjHvnlg9mLro8Iw7e4nRTvRDOMeG1
         NARw==
X-Gm-Message-State: AOAM5308+1G4pPr5SvUNcGs8T4l3feiYLR33M4+wtoLZK2uLHvZ/sAie
        0iMDq2S7Pmd+SBCM5Ni1lKCa2EwkgQ4=
X-Google-Smtp-Source: ABdhPJzBDfUMRgrkFGRaQjb3JnVcxyXu1WVg91CC9KZq/9K2aRGRx1RKgyBqq018Jv1LGYCHzqJ3Qw==
X-Received: by 2002:a05:620a:288c:b0:699:bbc6:9e54 with SMTP id j12-20020a05620a288c00b00699bbc69e54mr12416634qkp.226.1649411783812;
        Fri, 08 Apr 2022 02:56:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c10-20020ac87dca000000b002e1db1b7b10sm18053944qte.25.2022.04.08.02.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:56:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     kishon@ti.com, vkoul@kernel.org
Cc:     lv.ruyi@zte.com.cn, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] phy: ti: Fix missing of_node_put in ti_pipe3_get_sysctrl()
Date:   Fri,  8 Apr 2022 09:56:17 +0000
Message-Id: <20220408095617.2495234-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

of_parse_phandle() returns node pointer with refcount incremented, use
of_node_put() on it to decrease refcount when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/phy/ti/phy-ti-pipe3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 2cbc91e535d4..f502c36f3be5 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -696,6 +696,7 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		}
 
 		control_pdev = of_find_device_by_node(control_node);
+		of_node_put(control_node);
 		if (!control_pdev) {
 			dev_err(dev, "Failed to get control device\n");
 			return -EINVAL;
-- 
2.25.1

