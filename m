Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAED576E23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGPNQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiGPNQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DCD12127E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657977361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gnHdMkzLi00tNGCUGHal6nCmNk9iiTh/Qem2M8JBxB0=;
        b=EEAdtlOZbGjluEvH2Eb8YISGCVz3+vXVNmpfDtbEfLztOeJT1ccdh7jTl21ohteHSAbj1b
        npsLLCHF3evgSgZzydyRy+srBIfU1k9sk6hb3wvvuQmeK+7awpc6TPPCtzbxfxoVwnAJNT
        LsXrnaBrrPf/Xs6qxjKgeZxjfMUPT2E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-Q1blIeSZMZq6wadmOgf63g-1; Sat, 16 Jul 2022 09:16:00 -0400
X-MC-Unique: Q1blIeSZMZq6wadmOgf63g-1
Received: by mail-qk1-f200.google.com with SMTP id bj26-20020a05620a191a00b006b5c4e2dc77so5331136qkb.16
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnHdMkzLi00tNGCUGHal6nCmNk9iiTh/Qem2M8JBxB0=;
        b=4uvvyL6PR5GzpKYsWq9UA13Bv4GzPaP6dk81GgVJiF/knLSe21qD2DZ1pcDm32HIzw
         GoiYjrXd0MGeeSaVyJAc431sGez89lNMf6DRA9VfB2AsUrUUTGIlZE94YJ9WQ7j3nQC7
         RpvUYRxHaXlq6DTEXvg1GKqT13wh7b7yxUqBzSWg84pHfpt1ESCOaBPy1x2H1ixJjFyu
         nnQw+stsmGxpCvzq9+8SUbvuFubroMZI0errbgXSVS1ZbserTRVq8XbRTlx+wLCsOrZi
         Gb1ICqI32eIeTnHwlRiV6jc0rKKIVWtvJKZ0qTrBigcN2UmbnLFD9O9CjROOHTNRROa9
         whjw==
X-Gm-Message-State: AJIora/qGZPll4nF+diSJRqBNiwfW25K1LWxi5cTzLJ8B1Hy40r84NAL
        7tSd4Wgx8y9KTIBt71bK+DbvdHnz19CLT5+VCgxy0RMDWE8yTrOhdlDIUGLcP54helaDQaHpfJp
        5WoGXI9k8DfAmGs8NSnwugo0D
X-Received: by 2002:ac8:594e:0:b0:31d:410f:8b56 with SMTP id 14-20020ac8594e000000b0031d410f8b56mr15567516qtz.574.1657977359657;
        Sat, 16 Jul 2022 06:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0hlikaPC0mBP+PR0j6EJBA0q7qPSPcc2vLVEczOdQynomZ3XMyGd4vyQYhwE9REYZkwJhWA==
X-Received: by 2002:ac8:594e:0:b0:31d:410f:8b56 with SMTP id 14-20020ac8594e000000b0031d410f8b56mr15567502qtz.574.1657977359393;
        Sat, 16 Jul 2022 06:15:59 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006b5905999easm6122095qkl.121.2022.07.16.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 06:15:59 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     axboe@kernel.dk, nathan@kernel.org, ndesaulniers@google.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ublk_drv: initialize ret variable
Date:   Sat, 16 Jul 2022 09:15:55 -0400
Message-Id: <20220716131555.2014270-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build fails with
drivers/block/ublk_drv.c:1304:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]

When the call to ublk_get_device_from_id() fails, ret is used without being
initized.  So initialize.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 52fd0af8a4f2..4d1199c98026 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1298,7 +1298,7 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	struct ublk_device *ub;
 	unsigned long queue;
 	unsigned int retlen;
-	int ret;
+	int ret = -ENODEV;
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
-- 
2.27.0

