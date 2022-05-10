Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C210521430
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiEJLxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiEJLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:53:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2D25D110;
        Tue, 10 May 2022 04:49:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m12so2769359plb.4;
        Tue, 10 May 2022 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82IWfN3DJGbMvK2+4fI3Xh7XLeQQn1ow6dAglNayAwg=;
        b=Pf+rwq1rUZIBQn0eFIdRJcsu1xPsB1/4WueqbikzakgqBAivKEZJejMSWB5khdKck4
         L4Y24o0Pg/+QwXMMXPgws+H4J/qJUm9Yg4F97pb4NibGStRCUgCI6ARijpZ70R/lUWhD
         Eux7y5xFOloevXcSJ0Ne99pjaVxX/Nv3ETwdWXmEk4URpDON4P5uze4i1pPm6wa2O4mR
         XdVpSNkL+HA/Jqv+w2b/nl4VXUo3/gFtWr/DEYAMq8o4mFJSriSM0MDnBLOajj/cSX+Y
         38JZpXSdt7Nd5opgGljqBvyUmlseDZbrSiyVcbN9Ry9BOg+Mh7ljI+K4DNrHVrxhTBP8
         J4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82IWfN3DJGbMvK2+4fI3Xh7XLeQQn1ow6dAglNayAwg=;
        b=QHW0CqF6k9v5EPVE+EC3hcC/eon8bZFccqGZHTbtvv5JHFCkI/m9kOHnpWyP31x41u
         sNAruyhdmbIEJ1CfrajbeFFL4l+ctkYcUEf3LHIljhDefw+LPLog55qTU8t0v0iXqze3
         QbJWKzKoDyoXKgFAB1U1ZqzJihn6TXkDdYHS6JPLYmIB2dAh448qS9Px3zR25IhwYDFn
         dYHTnnRAbuZ10QFNuOiqCkbwy/DqOxSesvj6F+zzjaC8M86nnsxJ4WIgIJIDeyuCDUxj
         UbeMRT98MBXnJmBAmnY4PaEuTF6s7UCDXTYQvW3WALwNtFhVv8eGFPctToq+Uaf+aILY
         pKjw==
X-Gm-Message-State: AOAM530lgn8N4NUe7rupcgg3Jy4egqirrZZe2lwRjBvQaVbtbGjN1nhw
        v5m1tlBxmJDJFtLcyybk3g==
X-Google-Smtp-Source: ABdhPJzZ/q+Y5wsV2WhUkaAfZuYQU04VlorbapxLQbgGpJxgSaWNny5cBeJfTb8zzS0PcimXckkNJw==
X-Received: by 2002:a17:90b:3a8b:b0:1dc:4eb4:1f2a with SMTP id om11-20020a17090b3a8b00b001dc4eb41f2amr31406683pjb.50.1652183357655;
        Tue, 10 May 2022 04:49:17 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b0015e8d4eb1besm1931516plx.8.2022.05.10.04.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:49:17 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     ribalda@kernel.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] media: imx214: Fix the error handling in imx214_probe()
Date:   Tue, 10 May 2022 19:48:52 +0800
Message-Id: <20220510114852.1719018-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The driver should disable regulators when fails to probe.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/i2c/imx214.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 83c1737abeec..61eeaefd4298 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1076,6 +1076,7 @@ static int imx214_probe(struct i2c_client *client)
 	mutex_destroy(&imx214->mutex);
 	v4l2_ctrl_handler_free(&imx214->ctrls);
 	pm_runtime_disable(imx214->dev);
+	regulator_bulk_disable(IMX214_NUM_SUPPLIES, imx214->supplies);
 
 	return ret;
 }
-- 
2.25.1

