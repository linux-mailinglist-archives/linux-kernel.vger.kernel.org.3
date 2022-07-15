Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896C85762CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiGON3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiGON3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:29:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E091237FF;
        Fri, 15 Jul 2022 06:29:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l124so4654350pfl.8;
        Fri, 15 Jul 2022 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmEbAYKWlOqPX2RjEuea2Sgy80PtCQ6vAnGW/GIiSPU=;
        b=nW1VzwudviEYvqFXOa/22wLsBmSaClxipxEjXsDbuunL/jtsRLkzRJ0XgaCdDTlQCG
         vd1Iy14VPseOW1lSpRlmdwD4ZJC683VIQfD58Pa74De44nwY3neCWRcGgBoOvS3jVEiU
         zX0fNm7uMrBSi57//klwfRHxHdgsTA6mhPHyoq91szD6UGrdQRmSpIIwvGp8ytAD7xaE
         TzOrZA2j40YTfZnFE+GW5bOc38g8h0JJxk9rqmgJdWRMJN8jeMVRNEZ0E+fKIcDfirX0
         hgsW4Vh5+jhaf/cv9/8fNyDk49bAp697pV2KT79h+jaXe/iPRpI7xBoG3fGUz8udmfE1
         +uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmEbAYKWlOqPX2RjEuea2Sgy80PtCQ6vAnGW/GIiSPU=;
        b=wkBJ+fKtTIFuY1GppvdLQzsHFZkrPKPabBxMw49zEKoDOdfMG9vbhkwWvXr+GvP04z
         aVEs3BdKRCfqEPPlQ5vldvzH2GXjoo11mhnUTIINp1fAQrKE/SC9vOE9bY1BlYs53zBV
         p+/u6AmD8Zd0h9VNLBoO6IU59gu2qTOMm0JhYdPfVYP1TrfWrj9+mgsGDfB399SbU1b2
         vQseaY+qsnPLJEael2lvAcWMbxt9id6VvpgRXgxiJUfpVju/FPubdb7GpzF5yQ6EczQU
         GdTOMWyKXSFYfe9JOvrBMtbTd16PQaH1RUMdSBKcxq2rQ+EqONB7Q+8Zd7cSOICiLMxJ
         hwpA==
X-Gm-Message-State: AJIora9FeJPt96wWJpRJFLsi9CHBHXjZ83TmNEr4qnFxFUSwckaElgL/
        sbX3Hx2z0ZlaL+hjd66MIw==
X-Google-Smtp-Source: AGRyM1vAiEUCIHGxamaoKHk4eRp56pEf+4nacB8IWdx8UvYeFXHCvGjCB2QPDzWpnqo9Xbxw/UeaKw==
X-Received: by 2002:a63:e955:0:b0:419:66f8:e331 with SMTP id q21-20020a63e955000000b0041966f8e331mr11835579pgj.585.1657891763075;
        Fri, 15 Jul 2022 06:29:23 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b0015e8d4eb2ddsm3493893plm.295.2022.07.15.06.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:29:22 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] iio: light: isl29028: Fix the warning in isl29028_remove()
Date:   Fri, 15 Jul 2022 21:29:09 +0800
Message-Id: <20220715132909.480548-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses managed resource API to register the iio device, so it
is unnecessarg to unregister the device manually.

The following log reveals it:

[   32.374955] isl29028 0-0010: remove
[   32.376861] general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
[   32.377676] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   32.379432] RIP: 0010:kernfs_find_and_get_ns+0x28/0xe0
[   32.385461] Call Trace:
[   32.385807]  sysfs_unmerge_group+0x59/0x110
[   32.386110]  dpm_sysfs_remove+0x58/0xc0
[   32.386391]  device_del+0x296/0xe50
[   32.386959]  cdev_device_del+0x1d/0xd0
[   32.387231]  devm_iio_device_unreg+0x27/0xb0
[   32.387542]  devres_release_group+0x319/0x3d0
[   32.388162]  i2c_device_remove+0x93/0x1f0

Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/iio/light/isl29028.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 9de3262aa688..505235903bd8 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -641,8 +641,6 @@ static int isl29028_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.25.1

