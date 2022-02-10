Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9829A4B0372
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiBJCgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:36:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiBJCgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:36:45 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A282237D2;
        Wed,  9 Feb 2022 18:36:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so4161952pjh.3;
        Wed, 09 Feb 2022 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OTYmrbGIx6yiOF0Z0bFCD7WxKDh7jr/0cIzV9rC1yXI=;
        b=ngYRXwXFCD94gM2rlOPHYb53Xo02WgOf9T5fUzPW4ur8qQWwCRXQCUuza+m3EZdwTV
         4t+Nl46o0H40VbIUQkjiKnvQhNhPIP62SA6gfjGownuxZOktrYllW9yqpbL7ptiudXiS
         u1VEuCMbZ+uJwLQucORQ4/+rpAT9EMokKrcPvAkAn/O9M61kea4kg1ENtRRDkATieH4b
         NaA/KF0SpPVyqyeCjQjkTaop+OxRCfxhsPqjoRzrR4PlpCBDN3WzkiNZqIYKqEv+6VEu
         QpjNs4iFURWGnd7VkaCHSvP9thxAp9wKo+1Fj34ZxjsWt6IPBLKFUPaVqBlnFrB7TbIX
         0Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OTYmrbGIx6yiOF0Z0bFCD7WxKDh7jr/0cIzV9rC1yXI=;
        b=quas8HOWwlK5K7TfG7qjunQTTKR5kTSoburEErA02Ohqvxm5z+LCEUZGK+py6wqWJJ
         /dzO5Nh7BRzhbS1nQcS0u2T1c85IagYSe+I5UoeDIAPiitgzQE7tPDfNBGV0TDl+0Svv
         RGFnrNW8FLtsVAgzyl6wJ6G31Npz96pq8dML1dJ7va6QwPscmCizcBhsPXtXTgvxl3Yy
         3F/JSawwD6VsofK8tsyX3x1XJprB3Rusk5+KLK/YT+5QfYkiIDYvFxIVdrbX0CWsd1mN
         QBcLbA/hnKDbnYnmzCT867556u86zk5RCHpJSgL+54OPSHPvpruhC+8ERv7Js085dQfu
         2lLw==
X-Gm-Message-State: AOAM532/68C19JUFh02ft5c9PU0cuoqgZyomdCWQVgpibbC/XxqaOsPW
        xL50BBB/POacjugu+Vd6aLqWYq/fHs1+vA==
X-Google-Smtp-Source: ABdhPJwlL3HPV93WjdBrDI+iGqX24qf6pToV1X6K1yVEpflfbuaQG3FCEHUzQ/++0dcVM14GDeoCWA==
X-Received: by 2002:a17:902:c404:: with SMTP id k4mr5336273plk.71.1644460606616;
        Wed, 09 Feb 2022 18:36:46 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id f16sm20173665pfd.118.2022.02.09.18.36.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 18:36:46 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com, trix@redhat.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH] spi: Fix warning for Clang build
Date:   Thu, 10 Feb 2022 10:36:56 +0800
Message-Id: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang build fails with
spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
  uninitialized whenever switch default is taken
        default:

Restore initializing ret. and add return error at default

Fixes: 47e8fe57a66f ("spi: Modify irq request position and modify parameters")
Reported-by: Tom Rix <trix@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index ba5ed9f..460993a 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -375,7 +375,7 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 {
 	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
 	struct device *dev = pspim->dev;
-	int mode, ret;
+	int mode, ret = 0;
 
 	mode = SP7021_SPI_IDLE;
 	if (xfer->tx_buf && xfer->rx_buf) {
@@ -403,7 +403,7 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 		ret = sp7021_spi_slave_rx(spi, xfer);
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 	if (xfer->tx_buf)
 		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
-- 
2.7.4

