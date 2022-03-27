Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9994E87AF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiC0Mk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiC0Mk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:40:56 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E841F626;
        Sun, 27 Mar 2022 05:39:17 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h18so3602465ila.12;
        Sun, 27 Mar 2022 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mK+dixa0LoEPtfSZUPyenmhOFOLQVwPd2apmwWfFfKk=;
        b=Cxc7UtWsWbPr0EBSFHG/IsAtFw218VBBnQUsXTeD8TC1O3/IQwAgLSAnhIKh8kiKD+
         8O87BfuhWAWrv9wbYS905+MbxHmX0MjQJ8S9nHQux66MYNNQFE6LzVDEPjVAlhpHREgx
         LPzhHdMZwLreadrR/Ou64OmJuu2UgmzWiO2jTRJpgl8PNdvir4kQPmkAtFlkwEA9y1zy
         Hd1re5B5QP/Fis5oTFZpc4qfX6e5+S0rhed8AX2g0UK+iVa4kIrdsuVrq3Cby+prjNYj
         L+bKvysgtw9LuL15b5k2mwYu3mRsxjC6aFk+ikTfIO9zZ3pTNA/AgoPEnablN36BWs1Y
         2RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mK+dixa0LoEPtfSZUPyenmhOFOLQVwPd2apmwWfFfKk=;
        b=SuhoUV69nc0UebXElOnvT2/7UZOtFtEbWa61kvzNeZaX0EJhn5uLjqAH1tRELHb7GD
         afu/kGp6TZdgHSdGF0/UfElmV54EAQiPkYJR7jra+587irdyhJ/q9wZxNt2lvEh34dRF
         kaQWEAOjax55u6KSabz5gvpn9y+xq1pIfRIPCWXSrEsvqJXheEbu+wpG6Y8ZEF07okaa
         3sDv5HQtRmjCLnKBd08MCxe0hMRvXhy51mvnHYUSPjKkbVZfpIB3+q15Db/5qNNmzhpc
         lVwzoYRTqchOQaYaxrvek1rFS3kUCJgKmlKB4SyU6S3RpgY+ytKqzGiyTmqAeM+C/7qm
         5Lrg==
X-Gm-Message-State: AOAM5336Krafg2DJX7oEVaN3DAiduEPqNZO0JlZQfUl5Dgt4ZOrRaoHD
        FQ4AUCmf3GnjYe+sLZ8JG1x8PyvXSI4=
X-Google-Smtp-Source: ABdhPJxucE0TY7Eko2gCyimMqt3jAoPXXrivt7GCnIyK8+KMY9Hs0ZZ1RQapuajVqIx3CVVscwBhmA==
X-Received: by 2002:a05:6e02:12c6:b0:2c8:5969:104a with SMTP id i6-20020a056e0212c600b002c85969104amr3180676ilm.73.1648384756584;
        Sun, 27 Mar 2022 05:39:16 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7073:b368:2f66:5e36])
        by smtp.gmail.com with ESMTPSA id t7-20020a5e9907000000b00649d6bd1ec5sm6134534ioj.31.2022.03.27.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:39:15 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     haibo.chen@nxp.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
Date:   Sun, 27 Mar 2022 07:38:30 -0500
Message-Id: <20220327123835.28329-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The SDHC controller in the imx8mn and imx8mp have the same controller
as the imx8mm which is slightly different than that of the imx7d.
Using the fallback of the imx8mm enables the controllers to support
HS400-ES which is not available on the imx7d. After discussion with NXP,
it turns out that the imx8qm should fall back to the imx8qxp, because
those have some additional flags not present in the imx8mm.

Suggested-by: haibo.chen@nxp.com
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Added suggested-by note and imx8qxp updates.
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml   | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 7dbbcae9485c..1427e9b5a6ec 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -34,23 +34,25 @@ properties:
           - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
+          - fsl,imx8mm-usdhc
+          - fsl,imx8qxp-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
       - items:
           - enum:
-              - fsl,imx8mm-usdhc
-              - fsl,imx8mn-usdhc
-              - fsl,imx8mp-usdhc
               - fsl,imx8mq-usdhc
-              - fsl,imx8qm-usdhc
-              - fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
       - items:
           - enum:
-              - fsl,imx93-usdhc
+              - fsl,imx8mn-usdhc
+              - fsl,imx8mp-usdhc
               - fsl,imx8ulp-usdhc
+              - fsl,imx93-usdhc
           - const: fsl,imx8mm-usdhc
-
+      - items:
+          - enum:
+              - fsl,imx8qm-usdhc
+          - const: fsl,imx8qxp-usdhc
   reg:
     maxItems: 1
 
-- 
2.34.1

