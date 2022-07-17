Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2002577294
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 02:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiGQAmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 20:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQAmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 20:42:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E314037;
        Sat, 16 Jul 2022 17:42:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y141so7764905pfb.7;
        Sat, 16 Jul 2022 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hb6uI1Kl3qHRzDha2s0SlVlOvbXC6dOtlm91aV7ABgY=;
        b=it36RuOLsBUb3x81iM5ebii17uRe/rIOh4gOAMgUMfdDFOooc24jHBqg1D19EvgGYp
         rGuxzkmkldERIjq7tslreLZSlJGgnRGZajpZEv1Hfg26MJ+uZ5QPKyQvf6eb2T4q6xJN
         izlzO1STSkNLExhKVt90oBuuCH7uXjzNgfZnUDHbupggLqK9SVsY1b2rvsdIv6LJzkIo
         Xp51AGH+7jIUDqQGCBBU3P8qL0HSVqCsKkoUMYVvSw59nJlDLarrgPbUf+2gKwc58HK1
         YHAUXt9ggD0BGrcv6FICyFDfXwoRphl6HrUqk+Mzjn+MuWsCa4PUmpxIbrN1eBasItj6
         Dgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hb6uI1Kl3qHRzDha2s0SlVlOvbXC6dOtlm91aV7ABgY=;
        b=LMwvSoyi6hj5B1Fyt1yixtylkOYfvv8+pjxHcYI/S6tMleqz5UNLbDTbG3I06CFONG
         3rSSf/Rl0WCzwiGegU/k8wjGPoAzs1b3/zUcAWTNeR0rwzT+AZq/WFZ0TUgm1jCsFStO
         Qn91QnZSJ/119Zo0lQVgJiXJr00S1PGgvX9cawBpZW+I1Kmkum/hF5Ir5G4d+mXmGzUW
         REC7QHF8Ean0byhFcrwNaKIta9qUx4Sv+XdFiIdKox10UrnyXMHHECe/GiSRzMhCCfqM
         qrcBlGmCbpVMQq3nRd15t3yFZrZ65o5X6M8qIL5zbVQN/DGuMclsZ0Gm1BPEwlmKVbD0
         r5qQ==
X-Gm-Message-State: AJIora+V4tRnJmDx/IDa1p5xlacZ9K3ToMpjLejg91AkbLX5aH6TPax5
        lVqDRWGSHDsLyNTCvrxs8Q==
X-Google-Smtp-Source: AGRyM1vBg68W+rk82aX7JJRSUKXZFSFngt3GxMHzOuhh1/5sCdlBkrhs4z5+JMQbHyQxntTnDPtucg==
X-Received: by 2002:a05:6a00:301f:b0:52a:ccdd:17f9 with SMTP id ay31-20020a056a00301f00b0052accdd17f9mr21383840pfb.82.1658018572098;
        Sat, 16 Jul 2022 17:42:52 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id y8-20020aa793c8000000b0052ab602a7d0sm6363409pff.100.2022.07.16.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 17:42:51 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] iio: light: isl29028: Fix the warning in isl29028_remove()
Date:   Sun, 17 Jul 2022 08:42:41 +0800
Message-Id: <20220717004241.2281028-1-zheyuma97@gmail.com>
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

The driver use the non-managed form of the register function in
isl29028_remove(). To keep the release order as mirroring the ordering
in probe, the driver should use non-managed form in probe, too.

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
Changes in v2:
    - Use the non-managed form to register the device
---
 drivers/iio/light/isl29028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 9de3262aa688..a62787f5d5e7 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -625,7 +625,7 @@ static int isl29028_probe(struct i2c_client *client,
 					 ISL29028_POWER_OFF_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"%s(): iio registration failed with error %d\n",
-- 
2.25.1

