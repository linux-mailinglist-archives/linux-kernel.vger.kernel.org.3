Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600F553A481
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351601AbiFAMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351732AbiFAMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:01:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B649EDC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:01:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cx11so1836679pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQaa8aVqn7LCqui/AQO7xtRUHuVEzK1EOsK/b5n0bwg=;
        b=Rk5+Fgt4g2fGSpTS1ffRyNPsXmfLLAMkv0mZQsApaSVR1HeVNIslWb2DxjvcsrIhs6
         SyTNBc2TR+Q5zXdjQLO8jSUqjrEGZoxU+pHFfRSzMmLGUSZk3INYBiV0So5V7mbROQ8Q
         IEN0dG2ksUsrljwtvp9qjzZhg0Ct2ISM/da+neB0N/R58Yu1OrRbvDxnJ1or6eo2q37M
         4S3JsBFBm61zG2GAYM0GziLa8ikOIdRfUP2mvIcTtvezCUi5zaBkdrnF0rgjt87tFSho
         db+zYwaGWkRh2jzaWLZr6lWFulYXKLSK6mtr73U2/ZvsNrhDg1ZQYdB+uO3RR3rztLEt
         0Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQaa8aVqn7LCqui/AQO7xtRUHuVEzK1EOsK/b5n0bwg=;
        b=Xpt3BTWfgwdjGi/1mpYeM/Em4LUJlyGPhUUj3TFw0JHYKtY4yUow/uo4nTvJEaeiYi
         DxO0JUhS6hhpsmyBO5dmDyiIIavbBdMDq6maetp/I/75Wnn1V1xIQxTRjqSp9BJx5aOU
         Aux8W6DjEgjt8COrv+cJDCzP0ox5veVpdd2UFF+5xAwWdqgJhMsICKNRDoGoWEqk3AmS
         CGZPnBQVIdvZKjelMWJVvDBzNzHu3LLUs+8wpLNWPASZJKPuIze/CJfQGTrhbgUyb42L
         pNfyU0AKu0iAZGEMK67GW2mfuR98oo0w5QJYUxpEcVtDqMvWT4un2NvpTk4ZDnrRYE6a
         79Tw==
X-Gm-Message-State: AOAM532iCVYdrZRay7q9wpj/kdVn8tw5KK0g9h1BYcboTxRGL+imR+0U
        FB9OuvoX2Rkqrk4aZQp/O7M=
X-Google-Smtp-Source: ABdhPJyD30OLkxR/cynKadX0v/sX1N9tODwKDdCOKgarNQnfqsE0vpzAJP2SytMd84Tg3bOydV5S3w==
X-Received: by 2002:a17:90b:3e8b:b0:1e0:582d:fc23 with SMTP id rj11-20020a17090b3e8b00b001e0582dfc23mr34063728pjb.228.1654084891207;
        Wed, 01 Jun 2022 05:01:31 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u11-20020a62ed0b000000b00518c68872b9sm1290228pfh.216.2022.06.01.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:01:30 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common
Date:   Wed,  1 Jun 2022 16:01:18 +0400
Message-Id: <20220601120118.60225-1-linmq006@gmail.com>
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

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling paths.

Fixes: 4740475 ("memory: mtk-smi: Add device link for smi-sub-common")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- add put_device() in return path -ENODEV.

I don't add put_device in normal path(return 0) because it will set
*com_dev=&smi_com_pdev->dev; and escape to the caller.

v1 link:
https://lore.kernel.org/all/20211230084115.5375-1-linmq006@gmail.com/
---
 drivers/memory/mtk-smi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 86a3d34f418e..4c5154e0bf00 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -404,13 +404,16 @@ static int mtk_smi_device_link_common(struct device *dev, struct device **com_de
 	of_node_put(smi_com_node);
 	if (smi_com_pdev) {
 		/* smi common is the supplier, Make sure it is ready before */
-		if (!platform_get_drvdata(smi_com_pdev))
+		if (!platform_get_drvdata(smi_com_pdev)) {
+			put_device(&smi_com_pdev->dev);
 			return -EPROBE_DEFER;
+		}
 		smi_com_dev = &smi_com_pdev->dev;
 		link = device_link_add(dev, smi_com_dev,
 				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
 		if (!link) {
 			dev_err(dev, "Unable to link smi-common dev\n");
+			put_device(&smi_com_pdev->dev);
 			return -ENODEV;
 		}
 		*com_dev = smi_com_dev;
-- 
2.25.1

