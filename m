Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B575163AF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbiEAKiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiEAKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:37:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A30ADEAA
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:34:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i19so23011807eja.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cp7/o6x5IzdrJbmJy3xqPuHx+JaFO1sYCDgkJSh0CjQ=;
        b=lRUnRnElduCIHzH2HCmBQKpbPMKJplrJTWLK3nlYHZEzMU1pMnrAqF9Lzz9+dKPIje
         xkcB7rLy23kfMNWttlsYJGyPyQgR3FcMq6EyQqbFe+6WIjgCv28J21pA/NhfmcH9rpv9
         fIMXYWW/f5omnPuLmdxanIRO0RBrA0rhFctJW16EWdCVC4geXUDy2l3eBJLJx4n7dqw8
         X034WxW7aIUREWHWoeyYzIflzjYY5jNV2EWo61pW4IWW+gxQqPc4ruf50+NcmiWhB2By
         0CuyOxshcyC4XY7nyqRjVDr1XaNzzuFnFD7Ntqk7pb+sLJ5zyZsU0Tp+pVsJRUmHKn76
         9JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cp7/o6x5IzdrJbmJy3xqPuHx+JaFO1sYCDgkJSh0CjQ=;
        b=pVqYSi4sCFJbkVP0Gx7W28eOZFa37DslbaPbHaauR4pB9vf6HHnifJxAPSO7XtCqH1
         UFSnILQOTU5ZILsShqTDhWdqKX1ltEHGoRbNaOxVuBeqd2wSDOzT8HDMpUTZDf8q94YH
         ojdd99Ug7b2qTA0MS3/FdUygqae9nAbzqP9gWLizhIQDTgYRot05IQcqg9uBaBS8xTPL
         l6lhYfAYylawWb9Hp9zJ16hvgqhOlP+DJFNyHjhGP3ODRYMdPszKDfy0R1sWli5ZXgKr
         Mx1fmDLrvwRVr5mlFWiRCYBg2QMiaEFy6aZpOWKFXvXeEgiI0V2aRkCOXUSGGI7tQGiP
         E2fw==
X-Gm-Message-State: AOAM5335kaT0xDU1vyC+4xSjxwTZL9ISPXpElD/jCWc4FzlQUeh+ycfY
        IScC6zC3mbvw5aV0CtSoixCG+Q==
X-Google-Smtp-Source: ABdhPJwv+vVoRb9P/PghU+aWHDJQi4gjxoCN9SWVZ4Ok6tA0pak1jR6F73PxC22SovUKL1Q3a1g77w==
X-Received: by 2002:a17:907:9710:b0:6f3:6e7e:d5bd with SMTP id jg16-20020a170907971000b006f36e7ed5bdmr6946306ejc.252.1651401271825;
        Sun, 01 May 2022 03:34:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv49-20020a1709072bf100b006f3ef214e35sm2443733ejc.155.2022.05.01.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:34:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] mailbox: correct kerneldoc
Date:   Sun,  1 May 2022 12:34:27 +0200
Message-Id: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc warnings like:

  drivers/mailbox/arm_mhu_db.c:47:
    warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  drivers/mailbox/qcom-ipcc.c:58:
    warning: Function parameter or member 'num_chans' not described in 'qcom_ipcc'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/arm_mhu_db.c | 2 +-
 drivers/mailbox/arm_mhuv2.c  | 3 ++-
 drivers/mailbox/qcom-ipcc.c  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/arm_mhu_db.c b/drivers/mailbox/arm_mhu_db.c
index 8674153cc893..aa0a4d83880f 100644
--- a/drivers/mailbox/arm_mhu_db.c
+++ b/drivers/mailbox/arm_mhu_db.c
@@ -44,7 +44,7 @@ struct arm_mhu {
 };
 
 /**
- * ARM MHU Mailbox allocated channel information
+ * struct mhu_db_channel - ARM MHU Mailbox allocated channel information
  *
  * @mhu: Pointer to parent mailbox device
  * @pchan: Physical channel within which this doorbell resides in
diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index d997f8ebfa98..a47aef8df52f 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -160,7 +160,8 @@ enum mhuv2_frame {
  * struct mhuv2 - MHUv2 mailbox controller data
  *
  * @mbox:	Mailbox controller belonging to the MHU frame.
- * @send/recv:	Base address of the register mapping region.
+ * @send:	Base address of the register mapping region.
+ * @recv:	Base address of the register mapping region.
  * @frame:	Frame type: RECEIVER_FRAME or SENDER_FRAME.
  * @irq:	Interrupt.
  * @windows:	Channel windows implemented by the platform.
diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index c5d963222014..881706da59c0 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -41,9 +41,10 @@ struct qcom_ipcc_chan_info {
  * @dev:		Device associated with this instance
  * @base:		Base address of the IPCC frame associated to APSS
  * @irq_domain:		The irq_domain associated with this instance
- * @chan:		The mailbox channels array
+ * @chans:		The mailbox channels array
  * @mchan:		The per-mailbox channel info array
  * @mbox:		The mailbox controller
+ * @num_chans:		Number of @chans elements
  * @irq:		Summary irq
  */
 struct qcom_ipcc {
-- 
2.32.0

