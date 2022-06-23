Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0888D5587E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiFWS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiFWSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:55:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB951037CC;
        Thu, 23 Jun 2022 11:00:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so29037073wra.5;
        Thu, 23 Jun 2022 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRJQoHw1UG1x5dNKh7G6ADZfil6pTNVqaifRMO6ggF0=;
        b=MLfROjT9/wqnuFpNELvplnXAfdW9jH48Eqh1salfv/Iekdf/56jqn/sNuyZRUiEz10
         LOcxnnmDfEqCQ5Un9E78BJU/fWmqt5NBklAScqUPcry29uRuvK/keaXyz2Ow/qdOk2iV
         A9oYQFcNBZWZNTxTamiLRbqZ79v6n4ZM+3JkdRjUm95FXoEKfU1rvz5O3+emNoF1KwPk
         bvUWyACqMfwaBX/P1MvNDnUpBY2MDdGZ4E31GS4iQDWIZlRo1xPsjWcEUSoNIB+IVqv0
         7fVsBU9TCuMwQA49LZMGOWZqLYkTEMabyIML70inShUXE3twRqxjpWjWXHZ5YOVsmYtZ
         LevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRJQoHw1UG1x5dNKh7G6ADZfil6pTNVqaifRMO6ggF0=;
        b=llWtAVIj7hQv67rCdnFS5oCvyP1c0pU1R9mZ2DtzheE3FfJeiAXVrbn8iA49Mvcv/3
         O//AcrEusc3bZoqkJeH8npxRAB2JfHG2QIlIG7IRsXCnzDeOQGNFoH9YtbFFUVBG7nxj
         w1U7+SQo/l5AD5gXRF32h9rUaQI9CWAt1jsdDXnvpBrCFSQAigLS3QDrr3hRozjhF8W6
         hXZPh5cIEtR7spyS5stn1OmNQZQTd8FJ92PbzWqn31NxU1YJGdx0ikUQsy+ROHGYckn0
         8x29TQ+aG3WjExGcEpbO3dtEcNn7X2qBqxIA3ckZAheSGxWfmkeueZtKWAyTPPlgVEvC
         pjmw==
X-Gm-Message-State: AJIora8//T6m6iiyk8FfXjPkfobyvRdXi47l/BSQaB8JobuMdaaVwdok
        k8s+xWUb7I6roKxfKKDr8qI=
X-Google-Smtp-Source: AGRyM1toobZl5B1XzSCHMlvHvQl5Nai3QbUhmgtQcRWFRH+ixEaJocohOwMe9KH9e6aUg3VghL2QrQ==
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id c18-20020adffb12000000b0020c79b2a200mr9789991wrr.617.1656007255590;
        Thu, 23 Jun 2022 11:00:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b0039c4945c753sm4678551wmq.39.2022.06.23.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:00:55 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: imx-bus: use NULL to pass a null pointer rather than zero
Date:   Thu, 23 Jun 2022 19:00:54 +0100
Message-Id: <20220623180054.79687-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The 3rd argument to the function of_get_property is a pointer and it is
being passed using 0. Use NULL instead.

Cleans up sparse warning:
warning: Using plain integer as NULL pointer

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/devfreq/imx-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index f3f6e25053ed..f87067fc574d 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -59,7 +59,7 @@ static int imx_bus_init_icc(struct device *dev)
 	struct imx_bus *priv = dev_get_drvdata(dev);
 	const char *icc_driver_name;
 
-	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
+	if (!of_get_property(dev->of_node, "#interconnect-cells", NULL))
 		return 0;
 	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
 		dev_warn(dev, "imx interconnect drivers disabled\n");
-- 
2.35.3

