Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7E584002
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiG1NcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiG1NcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:32:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528FC14095;
        Thu, 28 Jul 2022 06:32:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f7so2120890pjp.0;
        Thu, 28 Jul 2022 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmQYtc1hSA2dj1fab7+3HzZDSuHervzNbSwsZTrDXjc=;
        b=QXUxjVv/gljXab51PFwJL1C/wua/AScPk2bmSfmz6gdfQHtCzkhJTi+xGfkdYw+exf
         TGQfnxDkwloVWUF3030IK9oe/TJVHbU6xS8yrMGCo0g3207kXuwarKDjBROixk+4nG6S
         V7mKEhgXUJ3Qugvr9Z/igXxLXBCTjYZPK5jPWoZXKsMLPyQRgYpq1dbNnKA1NZH6315C
         gQwhk1ZzN9HeJMBtVBivGQHolmf/FVomggU2LYS1k7r3MhdZnnotRTCuHHD48lCxFSwQ
         T80wHrZEP/g0Qm064hTopGqRwyQsBzsDeyGIL0fY2HgftkPfdJhVExkTs/BK3sZkZqB5
         p0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmQYtc1hSA2dj1fab7+3HzZDSuHervzNbSwsZTrDXjc=;
        b=d0G+57BPYI29oXuKqfeh9mFe29sqlofEqtoID+H95wJoZ+OrB351yyN9nHGZWmCZBr
         0lEq7R1/CZo3qa6x9djbijnpqZxhzSY61vVgpjGLuo58RgxkVTkmGGAIf8vjyplCUUwX
         9iiUI/6rBJUjCnTgi2EebxkzPLaFWURAYK3rfytSiTVLsAbPhb2Yab0DBSEPTuG4nm3A
         ObIYAE2LnwT9xI3qxnfufuZ2FhjNltqg/HaT+TisWulerzva4sY6boplsQF6Wj7xvEMT
         oxy9r0tWnz4NHR4EqpOhU22N/7dM7Rj/VB5I0JyBSWzmD4f2jMbVjaLNy2cV7FAzSOmm
         0SUQ==
X-Gm-Message-State: AJIora9SCo2TqddipHdbiwOTrl/qAK/Bu0l+KNxZc+lR7L/ZSTYb2lb+
        i9zo4DsPbmOKEI/F+k+XznkztrBq7zPrRQ==
X-Google-Smtp-Source: AGRyM1vie/uVlJ1G36FoIXDt6/36i5WBdxQFflygh4kQtsKlRuTN5pA2cmd600APZ8MDePZw9OBoPA==
X-Received: by 2002:a17:90b:4c50:b0:1f2:c763:52fc with SMTP id np16-20020a17090b4c5000b001f2c76352fcmr10184248pjb.233.1659015128869;
        Thu, 28 Jul 2022 06:32:08 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id u188-20020a6379c5000000b00419b128cf98sm928474pgc.54.2022.07.28.06.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:32:08 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v5 1/2] iio: humidity: hdc100x: switch to probe_new callback
Date:   Thu, 28 Jul 2022 12:54:34 +0000
Message-Id: <20220728125435.3336618-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
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

Switch to probe_new callback due to probe is deprecated soon.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9e0fce917ce4c..0d514818635cb 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -351,8 +351,7 @@ static const struct iio_info hdc100x_info = {
 	.attrs = &hdc100x_attribute_group,
 };
 
-static int hdc100x_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int hdc100x_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct hdc100x_data *data;
@@ -422,7 +421,7 @@ static struct i2c_driver hdc100x_driver = {
 		.name	= "hdc100x",
 		.of_match_table = hdc100x_dt_ids,
 	},
-	.probe = hdc100x_probe,
+	.probe_new = hdc100x_probe,
 	.id_table = hdc100x_id,
 };
 module_i2c_driver(hdc100x_driver);
-- 
2.31.1

