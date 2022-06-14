Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DB54AF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356165AbiFNLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356147AbiFNLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:07:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6DBEB7;
        Tue, 14 Jun 2022 04:07:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so16400893ejj.10;
        Tue, 14 Jun 2022 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyraSSKv1jqCeF4xZjEyVevZ1Z/RuxxufoUeosKgARw=;
        b=B02DeuPO+BZECqpvp/HqctH5+yuZhfdhDrn4GY1DbZ1slBnwpFZFJI7APngu8tHNIm
         IKOiauuMDwdK69gedR8dslBR/BKsp0swY2J45WBTHgyHy+PcBlb3+GetSipQBZldnru/
         N1PxRO3KhPGcDJGv2fTqrlKnyQ5N3JkltnBARkms4JjPrkHZx7aQ7BUAksbPTssIhFsQ
         o45dJqMUI2KjWNriW47ltltFr8lAYgpX8Ws6AiqXgoCMnUpddzc1ugJx6pDgJQsL6E44
         dUiNfkyWXv2m+TjNOazTDH4sWLAlG6+Pes4n7gy9YjEEdg22AojGOhG/A3OhtF+fK4J+
         Kf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyraSSKv1jqCeF4xZjEyVevZ1Z/RuxxufoUeosKgARw=;
        b=efzsyZ9j33r42vtStk5oFm28GsIniLT8EJzvEnkvXIVsdsbt/tekYxbUKN6SsZEiYZ
         kNfOYF/IC3sGLeR3awfpn9M1qIxzI+fI2kWE1N+j6Z01VEUb3zI+GpywxAugtZ1nkqUQ
         i74XLBBiSMHrP/TSGxhmPnbTY95ODTFiYj7QSg3netTF3NJ6jOOZNShrgbtKHtXyF6O3
         ANRxBTjc3pRG2shhjBLTqeeXPZmSU3QrwxucAEgRmRuamnGXN44KGlwByb9yIToDJ2vY
         ujZPdj8a9qurEZsShgGE6uFUYqiNUWL5gUW/lQiXvyX78z08/3I9RXgz8tgcf81vG7kG
         uDJQ==
X-Gm-Message-State: AOAM532sUo9uzFiOTCQBlppgEICwdUj8qzYu1PGw3atKypYerFg/W/sz
        4IkfVMvtlYTTGVhr7zGvhEM=
X-Google-Smtp-Source: AGRyM1ugMGU1GzBQZaCq6t82MbN9CwgPTCVr+506Anu6EgxBOpCVd7X6Nc3zIURwowiLXvicDNoUyQ==
X-Received: by 2002:a17:906:8416:b0:705:6a1b:e8ef with SMTP id n22-20020a170906841600b007056a1be8efmr3648558ejx.614.1655204846265;
        Tue, 14 Jun 2022 04:07:26 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id cb2-20020a0564020b6200b00433b5f22864sm6867456edb.20.2022.06.14.04.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:07:25 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 5/5] PM / devfreq: Mute warning on governor PROBE_DEFER
Date:   Tue, 14 Jun 2022 13:07:01 +0200
Message-Id: <20220614110701.31240-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614110701.31240-1-ansuelsmth@gmail.com>
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
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

Don't print warning when a governor PROBE_DEFER as it's not a real
GOV_START fail.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2e2b3b414d67..df6972bb0ce8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -931,8 +931,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
 	if (err) {
-		dev_err(dev, "%s: Unable to start governor for the device\n",
-			__func__);
+		dev_err_probe(dev, -EPROBE_DEFER, "%s: Unable to start governor for the device\n",
+			      __func__);
 		goto err_init;
 	}
 	create_sysfs_files(devfreq, devfreq->governor);
-- 
2.36.1

