Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2514FD1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 09:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351731AbiDLHEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351540AbiDLGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:53:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C854186E0;
        Mon, 11 Apr 2022 23:42:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j17so15193278pfi.9;
        Mon, 11 Apr 2022 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oIBDhcdWSaE7vQbKGazUcowf2lwLjEe8FI7+3jjOTMs=;
        b=FYGUdST2//KLw3IMPTIMx0PfdT9wSS77bKBOMhv6Nxwnr5QxDAulcTw8z1kSzzx86/
         DWF3bZT7bCoIU6/+RPkJxK/GrDSUJI5MPwr8q5Jvw2eZu+7sqw8TdpPLkkssTitPPARr
         zxnvphd8O1XhS1NNmEnDY3XBY2QK24svSHcMx9JuIZfLl6M9YEMtJTEhiMQK80ljGF7a
         ccVTF5cTDjwI2hhQlXgYDJzXn66V5GH0COb2Zgfy19Iwickp4YDfgmVWWFzgLem9Q5QQ
         WDwe83SkXys0Ms8zceDEqVBRrsH8QdKnW/HkAvyfCz4iBUyVA9+eSM1cNUGK47ab8sm2
         ypvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oIBDhcdWSaE7vQbKGazUcowf2lwLjEe8FI7+3jjOTMs=;
        b=yllyzhaOKPgy9N9N8UdHajaoawnUCHbjTief+HRF1zMB2NwIb4/EpTcNnj6upV0Tcf
         vI7I6nMS8QitzrzCNFsPdb8yBcmHOL4dNwltGeSz9SfhNUq4Xm6hyr88MAJatM0T3oM5
         gBJMty0J4VpVjwvS3+jqbjhWprIkE8JIHE+nG6gM/5yLG4PDR2zzIzggnj942cFjiFcf
         C5avBBI1RWUEPtVFty9aJkJTlCA/kXXWcn0UekxOjkNaPVSCHN0COPId2ewipU7xzg8g
         pjCi1d8Z4SO9PSmdhpebAIxT6nnH2GRXe/IgPpo/dZe4jjv5FLZYZ1DHLKww6ZxFoD5A
         s0Xg==
X-Gm-Message-State: AOAM531DqfiOVjcaVS5weCJe8uSsJkp1mw8zIEZ0anvt8bbiH8EX1ryB
        H/w4TcAU9v8hfzsJms9vf+Y=
X-Google-Smtp-Source: ABdhPJwkDNzf1gmAwCceiQIT3v9UrRANN9Vn1yUYO2C5fplpnnA2P1eiazgHb1CoPJAd0DSD6XQfBg==
X-Received: by 2002:a63:495b:0:b0:399:8cd:81de with SMTP id y27-20020a63495b000000b0039908cd81demr28660222pgk.508.1649745741684;
        Mon, 11 Apr 2022 23:42:21 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j9-20020aa78009000000b004fde2dd78b0sm31712830pfi.109.2022.04.11.23.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 23:42:21 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] iio: proximity: vl53l0x:  Fix return value check of wait_for_completion_timeout
Date:   Tue, 12 Apr 2022 06:42:09 +0000
Message-Id: <20220412064210.10734-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <PH0PR03MB6786F62DE142E3E2C66C937F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <PH0PR03MB6786F62DE142E3E2C66C937F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not int.
It returns 0 if timed out, and positive if completed.
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case.

Fixes: 3cef2e31b54b ("iio: proximity: vl53l0x: Add IRQ support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- add driver name in patch subject.
---
 drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 661a79ea200d..a284b20529fb 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -104,6 +104,7 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 	u16 tries = 20;
 	u8 buffer[12];
 	int ret;
+	unsigned long time_left;
 
 	ret = i2c_smbus_write_byte_data(client, VL_REG_SYSRANGE_START, 1);
 	if (ret < 0)
@@ -112,10 +113,8 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 	if (data->client->irq) {
 		reinit_completion(&data->completion);
 
-		ret = wait_for_completion_timeout(&data->completion, HZ/10);
-		if (ret < 0)
-			return ret;
-		else if (ret == 0)
+		time_left = wait_for_completion_timeout(&data->completion, HZ/10);
+		if (time_left == 0)
 			return -ETIMEDOUT;
 
 		vl53l0x_clear_irq(data);
-- 
2.17.1

