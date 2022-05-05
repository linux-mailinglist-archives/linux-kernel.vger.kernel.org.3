Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F2751B5C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbiEECXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiEECXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:23:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D94889F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:19:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h1so2531324pfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Moay9sBk8rVdbaL64S3jDlKhD4QT9fJRTKr12K5jA4Q=;
        b=m2o/3KXUn3ZQ20LMuY5L26YynIH0bHNe0Fuf3ch/mnqdG+uF0EhIGNRoA94CF7hkkU
         DICEutWk4PRZI4AgQ8JvG5IkzCYvyR4tmrErX7caGBsnZUMCBejo6+xhAxENgPsaMHhK
         ueKhrdkcSY04Yv5M7PPd3D42BeiiPApWaVfUxe9vSaHQ3Dlg7JWpS2NEtItND9bzw1dP
         YGGxf0Y0M5Jnt/pw4tYfLUN47x1o/BiRsOEFtnthcKW/oQQvaxmZFnWlTr6XuhLZJFdZ
         1vufCkBVn6X7bcLuzA9meKQLomIuFG+ictp7pKua3eHxp+fyx3yYdGwkTfrlAX9SmSWO
         TW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Moay9sBk8rVdbaL64S3jDlKhD4QT9fJRTKr12K5jA4Q=;
        b=tq1vT3i4LXFv0svFWQMIl4O+Co14tAbOCIA+jdvMv65ys5fbvZRq2MgdHayNaJnLw8
         kPXp6RXaHoMGoup/X8XpTYL+9+4fZ0sgtk+Y1+r6wNxf9q+T0bHhbO5OhoTnvwfQO8e8
         JvxqRJJqJnDS4QZEBbQvRAjt920yFEldMNcG7yHj5qKplHavlhWYOzMLIr2V/CYf1O/j
         +ULAebfkg+jOdcPCF6ddbOge/iec3TODTu5gYiXjbbWQosS17MbquuRvy8zo9X8C7ZKF
         pFgmf0DHX8Cgb8dPBjuOiIrvhxixgwuCV77l77LSFASg++W9LGIW1qAvG7jNQEf3dkwg
         zqAQ==
X-Gm-Message-State: AOAM533BZrDXnzTMX3eJhHURZbl8XWC7cS5g4VzWwQm1CHAYA7x5e/Ir
        QFM9iRGo3q5EBl1MbjVmkJvTmFuameY=
X-Google-Smtp-Source: ABdhPJze9fMC3XNJanQ45X3LhX0fh8loKWHwpc0KslufZ+Vjs8bB8YGm37Bc3hMJTtbcubwSHdG/sQ==
X-Received: by 2002:a05:6a00:1353:b0:50e:982:6a4f with SMTP id k19-20020a056a00135300b0050e09826a4fmr11808215pfu.50.1651717198174;
        Wed, 04 May 2022 19:19:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e185-20020a621ec2000000b0050dc76281bdsm76984pfe.151.2022.05.04.19.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:19:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alexandre.belloni@bootlin.com
Cc:     npitre@baylibre.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] i3c/master: simplify the return expression of i3c_hci_remove()
Date:   Thu,  5 May 2022 02:19:54 +0000
Message-Id: <20220505021954.54524-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 8c01123dc4ed..6aef5ce43cc1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -768,13 +768,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 static int i3c_hci_remove(struct platform_device *pdev)
 {
 	struct i3c_hci *hci = platform_get_drvdata(pdev);
-	int ret;
 
-	ret = i3c_master_unregister(&hci->master);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i3c_master_unregister(&hci->master);
 }
 
 static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
-- 
2.25.1


