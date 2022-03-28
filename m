Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24E04E9960
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiC1O0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243782AbiC1O0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:26:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0521EEDA;
        Mon, 28 Mar 2022 07:24:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t5so12784309pfg.4;
        Mon, 28 Mar 2022 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8cccm2I+4KQDgNNYHUDY+ywBQCQ8yCeJGNdK8lQVpuc=;
        b=IYjEsW9/LupErXbLGzSBAZGPm9cCPnTKQASA/r1SBiEmUA2dpVFLdeb2ZVCXU44JL6
         hHLbYKI8oltUMlu8JBtd5XdaOkpZLw8t0R0Qk3BOYb/57dhke2Zt8wOysMbre1rTno73
         j685lnflFzMCJBuK5UOPaBwHUIH0X+jovn3Ui3ow2QunV10XwCrekr1QUQZ1TiSZQgDu
         wJLk0ue9OLiv+vTTgkK7Zrzk+UAPK6IZKFZiK4Ct1eCvYmFyZU0lHdTzq8qfitd3o1c6
         dCdnDHDxsWAlntgHnilGr5DWLF+np4WSww4TTMbnLwfn9G3yOB/M1RhzDW61qCU51JHH
         7j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8cccm2I+4KQDgNNYHUDY+ywBQCQ8yCeJGNdK8lQVpuc=;
        b=qBow+QEsFFsLeLO6VKOgAb0FfAItHZHsf0kr2kT/yotuxPP8qJCiv6F6/eBGD6571y
         p8y6PgjoaVUglkrLH/jgpZ4snB29D4xphrja+Sty1la55VcN4tq5yIsLi4PPQjV1Zkm2
         JEPg4vP1hljX1iuF8G3Pvrmgo9imD/n41stArNtOaKRIocIe62I1xSnMx3c0NcD06Idp
         RL3tq+f6VVtF8QjAeEqTjvEmDKuXy1DiAqe4yZOQq1oOrWZDvy7ddFxUiNKYBNkjrb2m
         0dw0JBvWLlEhPC54/Ac+HffddyoMZt2PfLwRKeKD39BIh4uJ/qm7maEPNgp+ldf5X2sn
         Yqmw==
X-Gm-Message-State: AOAM531BCAz2uvHeDaZIKx7pXD+cMPorGDUssP/wgHAKrrMc+moOuPgH
        Ydy/HHje1vMvCSqwopRIwuy9CGgxPnQ=
X-Google-Smtp-Source: ABdhPJwA5iDbCHTLuYfWrqG6KuF3HtRxj7SDoNnVwtk1l8KQzi1iaq7qdTa9xXCJo2ckFBal+JZfYQ==
X-Received: by 2002:a05:6a00:2485:b0:4f6:b5c5:ee8e with SMTP id c5-20020a056a00248500b004f6b5c5ee8emr23446306pfv.21.1648477489258;
        Mon, 28 Mar 2022 07:24:49 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm21664206pjb.16.2022.03.28.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:24:48 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op()
Date:   Mon, 28 Mar 2022 10:24:42 -0400
Message-Id: <20220328142442.7553-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes case where MSPI controller is used to access spi-nor
flash and BSPI block is not present.

Fixes: 5f195ee7d830 ("spi: bcm-qspi: Implement the spi_mem interface")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 86c76211b3d3..cad2d55dcd3d 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1205,7 +1205,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	addr = op->addr.val;
 	len = op->data.nbytes;
 
-	if (bcm_qspi_bspi_ver_three(qspi) == true) {
+	if (has_bspi(qspi) && bcm_qspi_bspi_ver_three(qspi) == true) {
 		/*
 		 * The address coming into this function is a raw flash offset.
 		 * But for BSPI <= V3, we need to convert it to a remapped BSPI
@@ -1224,7 +1224,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	    len < 4)
 		mspi_read = true;
 
-	if (mspi_read)
+	if (!has_bspi(qspi) || mspi_read)
 		return bcm_qspi_mspi_exec_mem_op(spi, op);
 
 	ret = bcm_qspi_bspi_set_mode(qspi, op, 0);
-- 
2.17.1

