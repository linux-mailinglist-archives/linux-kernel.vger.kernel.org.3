Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7645AE18A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiIFHrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiIFHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:46:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D24475492;
        Tue,  6 Sep 2022 00:46:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x1so6142807plv.5;
        Tue, 06 Sep 2022 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SCIfIiiq/yyzgkPopZpz5RfhutkNUE2O01+O5PYJujM=;
        b=C0k5vt9j9FkkewR8ci4JPOODHwrNNGa4r6DSBf28d9sHkCrIfhiOvmM/yVAu3yv7YO
         jPiuPTFIk8lD3nTokg4njPbUFRZrPFc1r9UJZb0akD/lT+xfF96UbZ5Kj0wBUCw5Hy7o
         ZN/KLYRueo/p2NuOpICD7/kuf+OVSri78c0QxJFivRMvxpFg9MzaQgtM63mvKmasEBfW
         IrNk49J0dkpexeMxLgAPIqfAHdJjnAEJxAFQR0HaNkzSQaYn4aVU3fOGeP6ETjvRiz3l
         K70uDuALDAzeZv8516FHa16MObBRvKzdnFlGz10mu4S+bCgdfrd/uDrBq5sANyYdSFkV
         II+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SCIfIiiq/yyzgkPopZpz5RfhutkNUE2O01+O5PYJujM=;
        b=M1bOmRGpJgLQAc9XZVXAffzMJRM262tYX2jPtsO8H8RSTzubgFguc3jMJAAqOyge52
         yi5GmHQkZlHbqHsLsibS/et5yWAeO6w+mpM08zkBgZmj0Y2hNk3KxSz0/VxCugFbFQfC
         8PD64nkQGq5DI8CXZv2MFc2QhJi+VqB6VT8uJyvAfB3Vuifv7qPjZSFoKzfFkOw709jA
         njUpzF2KX+0Av/i+ZcJ3wZSBlB7On0ZljW5sGZBeMjD0R6AVb2gGJ6Es9StfzkE76FnF
         PXDCw6IFi89CRSG1y5jZKJXIbOlFwMwxEcoj4g3aEGJGnVK2Q2m2/xrYisp07rMJ/OBF
         5thw==
X-Gm-Message-State: ACgBeo08KhWn/iAmoexf5xDz/VlL8wqkAza0EGdaCbVgxnV1v5Ar+2dK
        BnnGsdwYCZ9ZCFsOlQF62ns=
X-Google-Smtp-Source: AA6agR75MPe4BTJ7xQ0L6D61Z4NNGMSJJtZlBcoUzwa1mbQDGNXmSb63h2KGTJtZ/zjJ7FwWon+EuQ==
X-Received: by 2002:a17:90b:4c8d:b0:1f5:29ef:4a36 with SMTP id my13-20020a17090b4c8d00b001f529ef4a36mr24029428pjb.127.1662450404429;
        Tue, 06 Sep 2022 00:46:44 -0700 (PDT)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902759200b0016c50179b1esm8919604pll.152.2022.09.06.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 00:46:44 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] meson: vdec: fix possible refcount leak in vdec_probe()
Date:   Tue,  6 Sep 2022 15:46:30 +0800
Message-Id: <20220906074630.35779-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
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

v4l2_device_unregister need to be called to put the refount got by
v4l2_device_register when vdec_probe fails or vdec_remove is called.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 8549d95be0f2..52f224d8def1 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -1102,6 +1102,7 @@ static int vdec_probe(struct platform_device *pdev)
 
 err_vdev_release:
 	video_device_release(vdev);
+	v4l2_device_unregister(&core->v4l2_dev);
 	return ret;
 }
 
@@ -1110,6 +1111,7 @@ static int vdec_remove(struct platform_device *pdev)
 	struct amvdec_core *core = platform_get_drvdata(pdev);
 
 	video_unregister_device(core->vdev_dec);
+	v4l2_device_unregister(&core->v4l2_dev);
 
 	return 0;
 }
-- 
2.34.1

