Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE745163AE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbiEAKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbiEAKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:37:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3CDEB0
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:34:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l18so23034390ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+FMZjVIJ5w3qpzg5VfAXXy3DLGF32A6QmZgvHOgpUo=;
        b=Axce0TYlrCwEH/OXf3Q+fPzTCVR1pkC55fzHRUNkfOa/5UKkS6l+gXGdDO7x/EKwu5
         HIGmjEi/sz3/EcvRghaysm6hrH9v0MdU5YXPnxqw87y3ZVxkNoj8dmoOkv9JlYR7K7+/
         2xkuFuiStcHciDx9pmq1f9MVxZkhWNkSbaGte1cnm4eVvZKJXrn2FhogieCNxF4oV6ty
         e2C976bZfLYPyZuvrf5hyyjArlSI+xn7U+KpwyfYvZla4m5yncoKMKEewMrRRQReZdt7
         voSOODD9ETfKVlD9cSqsIJvplBSQeNlCIGB0vcJ75pD4okj47Qh8USDiU+G1UL1lyqvN
         kchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+FMZjVIJ5w3qpzg5VfAXXy3DLGF32A6QmZgvHOgpUo=;
        b=obxMa3iqaWmR7AjtHxyEHrjL/F2aDpjgCjiZqPx1y31ME5ot1uDifxCcAclFYEYaPZ
         cZ0F8H97QU/raPYHRiwH3z/VxFFxLmQdfa5+79qUoYHWm71MQ1U2XySeMuInV+MpYdiq
         NZ6iq1O0T6p1V/owQrD0tJhuSk1/Z3xV28DMPg0pjqDKh0Jt55/S8oXjfItDe6Re4maA
         e7xpUV/uSybqVy/iMpQU0LxrPbSbyNloAcsJ+P7+NWGhRDYMMzVOv4XpU8L1B4z8avfP
         OqC2ibDcC54sx1Nudp0IDOEoYtIN6AdQk/6ZaZICc2OyciJSsxRWrtyuHbC/LvuTAnKs
         th9w==
X-Gm-Message-State: AOAM532EEb3H3N3LdmfmpkmGDnPKk8V0q24eD0SjkpLhrMD6H07voU9L
        n0y0FMS76auLEXIeAng2iDZb4A==
X-Google-Smtp-Source: ABdhPJzUVs967ak8EbM5gnxWF8sDu1+zkwx/N8L+VXoBr1ZAa/Larvjb/c+OX2osNcUE6xtkNO598A==
X-Received: by 2002:a17:907:8a14:b0:6f4:4365:dc07 with SMTP id sc20-20020a1709078a1400b006f44365dc07mr1243250ejc.693.1651401272951;
        Sun, 01 May 2022 03:34:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv49-20020a1709072bf100b006f3ef214e35sm2443733ejc.155.2022.05.01.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:34:32 -0700 (PDT)
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
Subject: [PATCH 2/2] mailbox: imx: fix duplicated initializer
Date:   Sun,  1 May 2022 12:34:28 +0200
Message-Id: <20220501103428.111286-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
References: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
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

rxdb field is being initialized twice:

  drivers/mailbox/imx-mailbox.c:889:19: error: initialized field overwritten [-Werror=override-init]
    889 |         .rxdb   = imx_mu_generic_rxdb,

Fixes: 315d2e562418 ("mailbox: imx: introduce rxdb callback")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/imx-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index e88f544a1548..df8a785be324 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -886,7 +886,6 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.rx	= imx_mu_generic_rx,
 	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
-	.rxdb	= imx_mu_generic_rxdb,
 	.type	= IMX_MU_V2,
 	.xTR	= 0x200,
 	.xRR	= 0x280,
-- 
2.32.0

