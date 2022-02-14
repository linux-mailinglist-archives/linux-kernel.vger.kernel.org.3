Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C84B3F32
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiBNCGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:06:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiBNCGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:06:41 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1E54BD6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:06:34 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id x3so7996718qvd.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6D+rW+M/590MNn6d2fJzbKUc0e2Gs+IX5YARDEY8vY=;
        b=XnUgXRrMXepVz7BhayGIuaIuiNR+gi4RU0BnTwEM2Q+1EE2H9I0y4aq0XfVXkoJynu
         vjlZtoyoCInbaMeI3YZkL9ml2a+6PxTpSsEEgnjXA5wNqZEHIBoNeY7WlNMGIanrM+Nn
         XSvNNx5I6xFPXppMW6Qub49m7rnV7XAnur0OMfSGspZkyGfKXsv2O931zJF2ymcBJoOQ
         kXXWoN/ITAlpg0+XQ9HizCsIxeUGTuNRHVE3AI++E3p1LgRGZJgcQTWDkgZv+yk9UibJ
         0Gk29a/2V5VbwTRI2LTRDqlMi69UNgVgJbfMwP13BjLq38VUwlIY+gCpzvqGLrr0IuFN
         Cf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6D+rW+M/590MNn6d2fJzbKUc0e2Gs+IX5YARDEY8vY=;
        b=q62FYAju4IyXvGbsbWS3XRBjkEQx3HJuoncjL8iHDTadqBtFuu2exMQLyDVRPgsIEx
         bIYzXCtd7QICwTTQA6mgCliU/9oh46Ncw5cboQn0Q3q8nzVlib/uRuVGsh7BeUBvElxZ
         G8p9RW7dR4PCe7DsA7Q2bAERaYSpizfVoKcwOqaIJewM/ZpX8C8Ib7Puu0SCW1g7bCvv
         3MIz/FwMFO/uyTcx1lI4dVKYUnWQ1FuCMiysy70vEZIqphEeEGMgHlxsPdKRaV4eU9UI
         VhqPGfSid2DTeQnIPtK5ivN99BATe7wRAjo4eRgs9fLyIsKljnqSRRc8aYtzHvARWRMF
         Vepg==
X-Gm-Message-State: AOAM531YGzC+r+4KuYY+j7fQZbwPFjODf/Smtz7n6Bc49vo/DFZ2brmV
        EW+YtBtZGooY11VcYokgoa+/qxjqT6g=
X-Google-Smtp-Source: ABdhPJyVbKTazCjbPnlL4BVLjqu5Hu2WSB3lyx94QL//89CseIbr6/MdX/GH5h5gxzc4Mpup1ICCmA==
X-Received: by 2002:a05:6214:20c6:: with SMTP id 6mr8215578qve.32.1644804393036;
        Sun, 13 Feb 2022 18:06:33 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d6sm16924750qtb.55.2022.02.13.18.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 18:06:32 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     kishon@ti.com
Cc:     vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] phy/cadence: Use of_device_get_match_data()
Date:   Mon, 14 Feb 2022 02:06:26 +0000
Message-Id: <20220214020626.1714696-1-chi.minghao@zte.com.cn>
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

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Use of_device_get_match_data() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 51c0b98f5fd7..e569f5f67578 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -263,14 +263,9 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct cdns_salvo_phy *salvo_phy;
-	const struct of_device_id *match;
 	struct cdns_salvo_data *data;
 
-	match = of_match_device(cdns_salvo_phy_of_match, dev);
-	if (!match)
-		return -EINVAL;
-
-	data = (struct cdns_salvo_data *)match->data;
+	data = (struct cdns_salvo_data *)of_device_get_match_data(dev);
 	salvo_phy = devm_kzalloc(dev, sizeof(*salvo_phy), GFP_KERNEL);
 	if (!salvo_phy)
 		return -ENOMEM;
-- 
2.25.1

