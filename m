Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0964C4FEC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiDMBki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiDMBkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:40:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E554BB97;
        Tue, 12 Apr 2022 18:38:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so558790pja.0;
        Tue, 12 Apr 2022 18:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FHnPLloxi4vtZdgy1A8R9HJFeUvpP1KwxVP1zs+LIe0=;
        b=VaqQDvsG2iIQr3Hc//BnO/Da4eSRCfbKxcQZWVRpfOJBruCCPEdLOSMXm9DrJzmP75
         Bcqi0FLgLHuN+c1XsEutTXLxEbJKFaqjJzVhcWXFmQRl2RieG2mBKlvKvpGLPSPVUULV
         bJ9GjtPRrm9K3LIeNE5mgjYxXSJQ6pmY4aYpBB3mLExkkm6lwOITJPk60eJ/YKqyU6yO
         6qxLVOMJ0Lmascmjy1m3l+xrA/rM1KZUcBHf8ufnLfr+qTueQUHVjktWr7hh1BZfluxu
         nyBDwJi6EQE29uy79lt5ZOzyUjFqP6maoCyARG48UADdEr/+nJqrwqld1ZIqjhDK2U0R
         oDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FHnPLloxi4vtZdgy1A8R9HJFeUvpP1KwxVP1zs+LIe0=;
        b=wggiWhhAj6wI2/Q12CDOgeLklLLc+eyFhpKO1+dVUUBqpkKTBEx107ysvCoAaurJ4F
         WFBT2hQG2yX/JvDDIJio/JtsSu3PzeH/DRoEYjyBbuhcl6NJEZqVVLi4DngucsUCSDzD
         NP+wqkI4id5jxj+YfcOBix0fHHN2HnYm+FcDhx4ywoKz9obWF8cL0Qpaxb7Bu6//Uktc
         yZ1FNRirf1PoasFiCEIKjnOSGgAWI9PnjNoWhy9B+KDoILJlRfdb0WuCv2rEsitFnKmd
         FoEPZ5nP/zCVcJX3Ivr9L9QpsIIxztanHySlq9Qh1YQop4aQGc+DYi4TegqffThdvvc4
         A9OA==
X-Gm-Message-State: AOAM530dGyOnmy0xpz+8QAn8Cn928FcishgkRlI2g/S3Bm8R3u8MREL2
        dE9bmucSJJRR/uGtjJUx5nM=
X-Google-Smtp-Source: ABdhPJyGMxyv1B4c7Z4hnf6gYAia8+nV6TnCa5TI7MJ6bwInkfOM0Q9nfxJcxTarO1ziq4pZYfW39A==
X-Received: by 2002:a17:902:7409:b0:158:3a78:3e43 with SMTP id g9-20020a170902740900b001583a783e43mr18615185pll.145.1649813893914;
        Tue, 12 Apr 2022 18:38:13 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id v4-20020a17090a00c400b001cb4f242c92sm793492pjd.26.2022.04.12.18.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 18:38:13 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com, nathan@kernel.org,
        trix@redhat.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH] spi: remove spin_lock_irq in the irq procress
Date:   Wed, 13 Apr 2022 09:38:00 +0800
Message-Id: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
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

- remove spin_lock_irq and spin_unlock_irq in the irq funciton

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index f989f7b..120623c 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -199,8 +199,6 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 	if (tx_len == 0 && total_len == 0)
 		return IRQ_NONE;
 
-	spin_lock_irq(&pspim->lock);
-
 	rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
 	if (fd_status & SP7021_RX_FULL_FLAG)
 		rx_cnt = pspim->data_unit;
@@ -239,7 +237,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 
 	if (isrdone)
 		complete(&pspim->isr_done);
-	spin_unlock_irq(&pspim->lock);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4

