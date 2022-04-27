Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95D511099
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357900AbiD0FoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiD0FoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:44:20 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD515780A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:41:09 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id o11so433803qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JV8pQOc5Qejtv06EEBVTrbMWAXGbQqdo3c7+2WXb4jI=;
        b=ajS0hizqv2IixrVtj2sPD0g6xYvY+s+Du+IhrRQheYAxNmg/PLcQGrOeAnqsNtov3P
         a38kUQvNo/62c1UXRj5wDSO7wlncvN80QgIUjZCEqZv1VxnATVF3LZeqMmESEhdbU2Zk
         +IlN6IkdOpWq6GmdwtYHIHHEvpu63Zj64V4yTHqcywyr0WytZsIc4Gvdf/ECtZjy7ZKG
         Mi5HM+U8BM24YdJQZj5HNoZR7pVpVIB2miXzeNPzvww2ti+/ZNRXylIM8eYbz77OkiUJ
         KnD+aOtymYDN/xlWHvIzYaO4cXvof72UbzOHTHiG3OMsVbjpwg2H437fvoj00xFdjBgg
         ydjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JV8pQOc5Qejtv06EEBVTrbMWAXGbQqdo3c7+2WXb4jI=;
        b=HGp3auKr+RC2Pe5+hQwzB+S7khzKdUBLdenbjdjVAVpqKnSl63efiakvaqmm0IY5Fw
         7+a3C3mPcQ9I6C+ekq6ueFHeR8QE5gVwCGY25GdKKm6WWnzUhbIg5PlSTOWGAyyOQ765
         HjVlseg8rxA1CZa/y3dPrOIlAcGBCNEM2qHGmR6WyenBbAL8xEpox/kb1neY/x/nqXYh
         SjFY7syjMVN0jf9rz02dXb0bX3CmFUSzrJ2knfS2BbWtjOCDtcpsr1UG0rVP46gAnhLC
         A/cSzAwZ+yUVSxTAHeS7S8Zi4zbjybO0R+ETxbG/V9ltebhUP5X36G0QdaZEVyR4gGNg
         5llA==
X-Gm-Message-State: AOAM5306D3G5bGAwS8Pg5JaR4No8B5UJS1dFHskjdhFVEn12fud0pG0g
        5yeFhN+6V3/4nqtb1aBVROY=
X-Google-Smtp-Source: ABdhPJxtgcSLhoDzmG3LpqmnRgM7rghHDpeZRyNOs4Bdhx0GbtzDNI0Kz57QEPNzRxIlMMbBz+r6Rw==
X-Received: by 2002:ac8:5994:0:b0:2e0:5d77:4b5c with SMTP id e20-20020ac85994000000b002e05d774b5cmr17717732qte.289.1651038068888;
        Tue, 26 Apr 2022 22:41:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l25-20020ac84cd9000000b002f382b88d48sm757101qtv.15.2022.04.26.22.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 22:41:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     jassisinghbrar@gmail.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mailbox:imx: using pm_runtime_resume_and_get
Date:   Wed, 27 Apr 2022 05:41:00 +0000
Message-Id: <20220427054100.3841587-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/mailbox/imx-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index e88f544a1548..73340c82438f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -830,11 +830,9 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		goto disable_runtime_pm;
-	}
 
 	ret = pm_runtime_put_sync(dev);
 	if (ret < 0)
-- 
2.25.1

