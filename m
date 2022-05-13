Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3B5260F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379882AbiEMLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350675AbiEMLZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:25:00 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2742A7C06
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:25:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jt15so6433195qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UE4ANBc0dyv3rKuUnMaCAbsStOruYiarl2aWFMtkOuk=;
        b=AaBzSlnW49zH06z7yi1ois+BrtxmqIe9mgTOZtnWiu4Ilto2+Fu4b3Mhi4Ax/r1x7n
         e2Qnif5FFcpu1uKeN3QYn6eseYKurLktuseBR/sw/wjuY55Wwk/fpcB7mB1a6CFX8bXO
         jK05ni5VBCc8THDLHDC5e88bs7d2hpsRMTV4NGEfgOEYeNllWaLqofN8VFK+jpjrdqQx
         XmU1O7+//ooeobHm1VbcsRzg6rzl/AQ1+CDBciu1jVwq8FN+OL+96tBaahkRjAsrjwcD
         lqQETAUNi8+2iO0jw62jyTo7AU2DrsroaF1fRit9xSC3a1NmM54BYL2EJhcIW23Vx+N5
         S5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UE4ANBc0dyv3rKuUnMaCAbsStOruYiarl2aWFMtkOuk=;
        b=8M+S2KNV5trJcnEnKsGyOEPNSD1hs50Yq3xbWnFMefUKZ97u6VfZIfeQ9f/j2CRGVg
         n/TM9ae4CEygeP39+PP8kweTvCi+M+rj8xr9/kIf8/oUwGSN7Cwgj6Cq1w+TrzzQ46EG
         riRLexn2U5o6P76SemG67EEEg3NoyelgDUZxC0RYgvMFlzFwgsIAeCygiRagutXtPlxo
         k9nxo04MSZd9E13cmI+LeO0nATkRCrA2uB4caupc9DvZX8oxFiaLexPhx0VTexAfyPp4
         GI8+YOv3G7NnuDgBV1BmD87Z1LD9MhMMtkE/mNbyQD9unSEOiGoE4/d5LF5Kpc/Tt9If
         ScvA==
X-Gm-Message-State: AOAM533QaOiV5tUvTATVKjjUcSh4J/eImq/xzBVLLgbft2MPYrEq2hUN
        3hDaiFMybMYv58oYgYXervk=
X-Google-Smtp-Source: ABdhPJycz2hJ2vcUk/lsOKvMWhUkTqJ7XQ7rWnfvUzPsgPjtueIyOCCFObBknLOW8fxijfVvHMidtQ==
X-Received: by 2002:a05:6214:509d:b0:45a:d14a:eb53 with SMTP id kk29-20020a056214509d00b0045ad14aeb53mr3762501qvb.40.1652441099174;
        Fri, 13 May 2022 04:24:59 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a147c00b0069fcc501851sm1208618qkl.78.2022.05.13.04.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2022 04:24:58 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, schspa@gmail.com
Subject: [PATCH v2] driver: base: fix UAF when driver_attach failed
Date:   Fri, 13 May 2022 19:24:44 +0800
Message-Id: <20220513112444.45112-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
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

When driver_attach(drv); failed, the driver_private will be freed.
But it has been added to the bus, which caused a UAF.

To fix it, we need to delete it from the bus when failed.

Fixes: 190888ac01d0 ("driver core: fix possible missing of device probe")
Signed-off-by: Schspa Shi <schspa@gmail.com>

---

Changelog:
v1 -> v2:
        - Remove the blank line needed after fixes
---
 drivers/base/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 97936ec49bde..7ca47e5b3c1f 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -617,7 +617,7 @@ int bus_add_driver(struct device_driver *drv)
 	if (drv->bus->p->drivers_autoprobe) {
 		error = driver_attach(drv);
 		if (error)
-			goto out_unregister;
+			goto out_del_list;
 	}
 	module_add_driver(drv->owner, drv);
 
@@ -644,6 +644,8 @@ int bus_add_driver(struct device_driver *drv)
 
 	return 0;
 
+out_del_list:
+	klist_del(&priv->knode_bus);
 out_unregister:
 	kobject_put(&priv->kobj);
 	/* drv->p is freed in driver_release()  */
-- 
2.29.0

