Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ADD4EB6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiC2X1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiC2X13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D72818596F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648596344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j9WAFWoFaJCbtXRV2bAUg/ZVuSKeu2t11Zs3/Bjgv9o=;
        b=Rbp2lkNXab7ry0MtLn0Ycc/Wygh/1l75l5pUfJ1vkMGRXYH3Pqe9z2tZMJ7pMnXvVdwLc7
        r0w/IyXp2gzDr/JghWNjaFKAgNry15a3egrlsAtixZNyq+l+4bNKmNOYeeZYZ4WdZajcU2
        4ywJ5HaWeORTlxktG7L5ilHPFcpn1Cs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-2tIhvgnFOXqarJ00hJy12g-1; Tue, 29 Mar 2022 19:25:43 -0400
X-MC-Unique: 2tIhvgnFOXqarJ00hJy12g-1
Received: by mail-qk1-f198.google.com with SMTP id 207-20020a3703d8000000b0067b14f0844dso11490583qkd.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9WAFWoFaJCbtXRV2bAUg/ZVuSKeu2t11Zs3/Bjgv9o=;
        b=FBANm61Xa/uwZzPxxIdyUR+jj51hM2WRMAUOKEKvDkDgmyhFvaBEP+eRAT2ny1ZK/J
         aKNkQaqPcLO2ycUfpkgs0OB3HsEjNvtz5QrApcBTtKvEGktJAcjBTwPa5FurzorluQLl
         TkXRMoiX8n1MscgIyZfRajFLYyf2NI3nKmJ0/abOBn1mQDhKZbGUerZnH4Qfuf6UrXl/
         DxAGZUiciJvce/uxGBads+q2YeeVfiffhxCRhiHGEt+n8f2uVQuUiTGmSSqINx8O9uz+
         oto3ytlqC6dJD63DwdscUqe2GaWx6qog8DVs/nZ4S5bxax8oXCO1li5iqs1+Kf4fg7Mo
         Jn/A==
X-Gm-Message-State: AOAM532bmiQvSDzUg29JlN2WTG5mtwlwlySmmm4dvGsWasnrCskxwSDy
        C6tT4aHp2OC4RrS6tHdPcIh4M6JbME/hnsBV7jj0GVDSeZWuHOU0nRBd9+iCOT7YKG8m1w1gy0t
        K3aIyjlCCwdUtKxKb1swO8lrp
X-Received: by 2002:a05:620a:68a:b0:67b:3135:a9aa with SMTP id f10-20020a05620a068a00b0067b3135a9aamr22146762qkh.508.1648596342752;
        Tue, 29 Mar 2022 16:25:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOKNeFEhOkGB2fAKKllqYm87EkU8WRMQ94OOyRzsSNA2a9eo8RNLBPMCuy0SqxE+nglW//YQ==
X-Received: by 2002:a05:620a:68a:b0:67b:3135:a9aa with SMTP id f10-20020a05620a068a00b0067b3135a9aamr22146750qkh.508.1648596342537;
        Tue, 29 Mar 2022 16:25:42 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f18-20020a05622a105200b002e1eb06ece3sm15856149qte.31.2022.03.29.16.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:25:42 -0700 (PDT)
From:   trix@redhat.com
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, hverkuil-cisco@xs4all.nl, vrzh@vrzh.net,
        laurent.pinchart@ideasonboard.com, tomi.valkeinen@ideasonboard.com
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [RESEND PATCH] media: staging: atomisp: rework reading the id and revision values
Date:   Tue, 29 Mar 2022 16:25:26 -0700
Message-Id: <20220329232526.3238181-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative issue
atomisp-ov2722.c:920:3: warning: 3rd function call
  argument is an uninitialized value
  dev_err(&client->dev, "sensor_id_high = 0x%x\n", high);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

high and low are only set when ov2722_read_reg() is successful.
Reporting the high value when there is an error is not
meaningful.  The later read for low is not checked.  high
and low are or-ed together and checked against a non zero
value.

Remove the unneeded error reporting for high.  Initialize
high and low to 0 and use the id check to determine if
the reads were successful

The later read for revision is not checked.  If it
fails the old high value will be used and the revision
will be misreported.

Since the revision is only reported and not checked or
stored it is not necessary to return if the read with
successful.  This makes the ret variable unnecessary
so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../media/atomisp/i2c/atomisp-ov2722.c        | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
index da98094d7094..d5d099ac1b70 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
@@ -906,22 +906,17 @@ static int ov2722_get_fmt(struct v4l2_subdev *sd,
 static int ov2722_detect(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	u16 high, low;
-	int ret;
+	u16 high = 0, low = 0;
 	u16 id;
 	u8 revision;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	ret = ov2722_read_reg(client, OV2722_8BIT,
-			      OV2722_SC_CMMN_CHIP_ID_H, &high);
-	if (ret) {
-		dev_err(&client->dev, "sensor_id_high = 0x%x\n", high);
-		return -ENODEV;
-	}
-	ret = ov2722_read_reg(client, OV2722_8BIT,
-			      OV2722_SC_CMMN_CHIP_ID_L, &low);
+	ov2722_read_reg(client, OV2722_8BIT,
+			OV2722_SC_CMMN_CHIP_ID_H, &high);
+	ov2722_read_reg(client, OV2722_8BIT,
+			OV2722_SC_CMMN_CHIP_ID_L, &low);
 	id = (high << 8) | low;
 
 	if ((id != OV2722_ID) && (id != OV2720_ID)) {
@@ -929,8 +924,9 @@ static int ov2722_detect(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	ret = ov2722_read_reg(client, OV2722_8BIT,
-			      OV2722_SC_CMMN_SUB_ID, &high);
+	high = 0;
+	ov2722_read_reg(client, OV2722_8BIT,
+			OV2722_SC_CMMN_SUB_ID, &high);
 	revision = (u8)high & 0x0f;
 
 	dev_dbg(&client->dev, "sensor_revision = 0x%x\n", revision);
-- 
2.26.3

