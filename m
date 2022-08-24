Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757B359F48E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiHXHwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHXHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:52:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CAD7FF91;
        Wed, 24 Aug 2022 00:52:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so15736549pfb.7;
        Wed, 24 Aug 2022 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DJjiIOEQIs2TIKhR//KHHq8rrYIG6LWPSmpI7MagC8A=;
        b=RJeW7TjH0W0m2aMCi8A+OeEI8DUHjL8V4R9Voj3QkrMGNiBRhHPIwiaso1FB3paIMn
         9TyXbKLguCUAcGGsP/tsXaoGtJ6rDgBVDsalLBd7RMG/BaD38/W4amWj7UOEyYHjPS5t
         AJcTck6EtlyRm4M//t77OTAKtbZGahm+bt/S38OxQYTY+n5qyCZz5vT7pOzX0Gr/2i/9
         g7F7EXU366k0fWE3qQWQKb0s5wKUu2d1nZL/KUW5pRiFTDTgvjFFZJDqWEwlgFo6QGNk
         BW63WbTP2AREfjZ3le5iW1lzraB/Jrp32VRWvId2r5gvrwDIRJATJfziSdYFmnMKj8r8
         4z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DJjiIOEQIs2TIKhR//KHHq8rrYIG6LWPSmpI7MagC8A=;
        b=4oB9OKLs1ODLhxPIxu3bJ21eQbSmkYiLtoODBRzxrr2Z5VrNcOjg1QjxxnWlr5QSif
         cTNlR2LeEt4DBH8BwX3O9g/mGab1qnMWo1ge7nrVy3KmoXHYVUT8wzlVpOda4UBIqG7m
         PWK9qe4oIyR8n+qDhPgPE+EieR9FcxSnZAVHso7etJtHdPPVGiZVpTlH5UdZtBXe1Kmd
         MXg7h3idpalJwSG8NzMco+k2s6PvtVXQncHDTXiTy8Cg/SX3AApSSC4syUjdjzO8SwTh
         P6JTtepvCV9Jtj5cMVTDg3RGdM1Q5gBMAaqgaSILIgCnbtt0/c2hnqFzUC1TrwIJMzSj
         A4AQ==
X-Gm-Message-State: ACgBeo2PsaqCyaC166viDqu5NgeKE233XirysxSlfZKf3sDl4cD2tjfX
        AWpxLxdVTbez7ZnAWd3+324dgIeaGJg=
X-Google-Smtp-Source: AA6agR5vHD0sbTiQkRo4KBVBdNU52zes8p9ItPkp4mCk7foV+vyKsHdm5GD6xrPsQGV8l6kmtj0QsQ==
X-Received: by 2002:a63:8aca:0:b0:42b:b13:b252 with SMTP id y193-20020a638aca000000b0042b0b13b252mr3199618pgd.246.1661327537236;
        Wed, 24 Aug 2022 00:52:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e62-20020a621e41000000b0052da33fe7d2sm12424499pfe.95.2022.08.24.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:52:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     axboe@kernel.dk
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] block/rnbd-clt: Remove the unneeded result variable
Date:   Wed, 24 Aug 2022 07:52:13 +0000
Message-Id: <20220824075213.221397-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value from rtrs_clt_rdma_cq_direct() directly instead of
storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/block/rnbd/rnbd-clt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 9d01e7ab33e4..78334da74d8b 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1159,10 +1159,8 @@ static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct rnbd_queue *q = hctx->driver_data;
 	struct rnbd_clt_dev *dev = q->dev;
-	int cnt;
 
-	cnt = rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num);
-	return cnt;
+	return rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num);
 }
 
 static void rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
-- 
2.25.1
