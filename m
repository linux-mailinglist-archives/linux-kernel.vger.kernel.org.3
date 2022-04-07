Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35C14F7ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbiDGJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243527AbiDGJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:02:06 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056091C16DC;
        Thu,  7 Apr 2022 02:00:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b33so1639597qkp.13;
        Thu, 07 Apr 2022 02:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aN5mT5XseTWatVt6bcoD7NMS4LCdVfX/RptWXKAKrc0=;
        b=mjoxyh9PZQCMkXRODxS+PxWgXjsdqxNe2k2AN5KmOdIO23yaKL9DVwQMPWJAU3RjAq
         uHxtahIMFBRZVDsQ9uST4zpdlMD7fToCXeeYyHx2Swg8w2ODthjwsQs7fxM9KCLLM7DG
         a7a8A/GWuUrjqNfXHWTZbI6PPOrQlXsfi4fKOE/XtY2DEVfG31t77tED+xEpKlolAECs
         VRpL5j1Dcctai9NhIG8H8PeEgP0alA0FCxq71csFsYp7CU+AlZyY0CDnqvDwk/0easu1
         AnU0SvkgLANK+kwW+NIavdi1xzfannMx9MMNDMDSMB29O7BJfggSdvoe4nWRCNoJ3pOH
         5rBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aN5mT5XseTWatVt6bcoD7NMS4LCdVfX/RptWXKAKrc0=;
        b=epRUl1grlvtnq0ZtijSnsSWcNZhUghK/Pu4iPiNskS2CF0FdV9cpu5FxTsD9LRQj3k
         AVRj40LIwxEq8TSPuh95hg1LxFaHK5FFIvyPOASvGKEMyva6bh3vGVW5hHv18+Ctls0I
         kLReysKeG7yHvNzvxEYBW3043VLyDWWgqTSgF44iHJbQj1ErevqaoJRjQ6VjzZbm+nXG
         mnati1kiOiW5zMmXq7CKyUsKxt8olOFHf01RFJNthGKE5nSjznc/NXhJhe5ZspbJyXzS
         uBBaGlVZ+jL+SC05hc8pRTqOpeUIUO6Dw4ZW+AqTqBqeYVfKb+TeXoFhMZPR3P8woIPd
         01YQ==
X-Gm-Message-State: AOAM531uYjvDFpRthw7oOPp/xA1kFUcvfqEC5uObVV39M5zyc33qs7mm
        UyT3loS8kjCPQBEG4onhLu0=
X-Google-Smtp-Source: ABdhPJxqgFtzM+fnzFFy+amc+0Yve7WLUJ2aiCFsq7jk9FKpT9bpqOFs2IvxrX2BataVLBGpo+jkUg==
X-Received: by 2002:a37:98c4:0:b0:69a:e14:16a2 with SMTP id a187-20020a3798c4000000b0069a0e1416a2mr255460qke.610.1649322005048;
        Thu, 07 Apr 2022 02:00:05 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a103700b00699d49c511dsm4689750qkk.104.2022.04.07.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:00:04 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     kishon@ti.com, vkoul@kernel.org
Cc:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        lv.ruyi@zte.com.cn, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] phy: samsung: fix missing of_node_put()
Date:   Thu,  7 Apr 2022 08:59:58 +0000
Message-Id: <20220407085958.2491783-1-lv.ruyi@zte.com.cn>
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

of_parse_phandle returns node pointer with refcount incremented,
use of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/phy/samsung/phy-exynos5250-sata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/samsung/phy-exynos5250-sata.c b/drivers/phy/samsung/phy-exynos5250-sata.c
index 9ec234243f7c..6c305a3fe187 100644
--- a/drivers/phy/samsung/phy-exynos5250-sata.c
+++ b/drivers/phy/samsung/phy-exynos5250-sata.c
@@ -187,6 +187,7 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	sata_phy->client = of_find_i2c_device_by_node(node);
+	of_node_put(node);
 	if (!sata_phy->client)
 		return -EPROBE_DEFER;
 
-- 
2.25.1

