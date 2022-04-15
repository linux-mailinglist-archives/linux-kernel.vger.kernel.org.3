Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9C50268B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351330AbiDOIOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiDOIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:14:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1A366AC;
        Fri, 15 Apr 2022 01:12:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 22so379506pfu.1;
        Fri, 15 Apr 2022 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=V1TQqJ8Dwm+rkTp7MnC8Cpp/Mlay65J8IEUqFYwowU0=;
        b=IoHFyoV/QMaWz5slv3dX8BWXMPwkrW8AOmkucgTgu9oEOFR9T1jbQ7lCV5zzzgcjD1
         5Lvi0ZPc+3KsmwhyGygW48c5TaeNeHcCvItjnVIoV54QUU+yglZJqpXAL5J8WHquclUE
         83t7e+ew1kTsla1lP6uSg3df/NT5SvzYCn+pZ33zqAX4E6zsPZxGs1UTUYFCSNZLj0HX
         iXS9Z0QuXkNw/yqBNP/IqgENg8Qe0WUBtm7ESVwHv8FXUtv5p6OcYCy7tU0e/lOpqLFi
         PriaBMITZiDucgPqwbeaxQw5B49/+OPiUjk6DLqOnTZTbTrBDzeD3IgL/qiu5lxt01Tl
         Hefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V1TQqJ8Dwm+rkTp7MnC8Cpp/Mlay65J8IEUqFYwowU0=;
        b=UXXtNKMuQ2BGEPA6pKH5rjtNRR2w08L6crHBdhKftChHleW72cYQygqopJ4bFH/Xut
         GrcWLGLVydEYJpNUfFd7XJa5ynxEzjmrSRbwlbrciiVg052K4zXc7h7O5hipNCE5EqdD
         h+LwUH5i5HYoUdaibPGFm+xclC84gcnkmFiWocALzjYh28G11qco05z/jqqNbtmHaMex
         0+cPjCL/vxk48sz5tw6VmAfQv18ZzZu4PFfR4u3fyNZQmPE6O0hJohSRKUaILiln8ASf
         ABV5+8EqOrctUdGiwXJT140EINtN5Dxo/PGUgR9BqWM8gUpy02lxWghjtGXNOlvKEQho
         WWHA==
X-Gm-Message-State: AOAM530jXYJmIL+oJvCTi5IMvEiLtgVywJv8cN5HO6G+ixS6df4FmUPz
        6/bKSj50zY1EoJt5k3p7HvalG3DsxjTmOQ==
X-Google-Smtp-Source: ABdhPJw4LGqz6LhFvkjeGdZOe+Ng0d6Qv/gkkbgVfLnFZ3lW4zTCWZ7c2+/mD8uJo4XEBoLqooqkDA==
X-Received: by 2002:a63:4523:0:b0:399:1124:1574 with SMTP id s35-20020a634523000000b0039911241574mr5351198pga.609.1650010337684;
        Fri, 15 Apr 2022 01:12:17 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 5-20020a631045000000b0039d942d18f0sm3790376pgq.48.2022.04.15.01.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 01:12:17 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com, nathan@kernel.org,
        trix@redhat.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH] spi: remove spin_lock_irq and variable in the irq procress
Date:   Fri, 15 Apr 2022 16:12:04 +0800
Message-Id: <f9991d6064d892d22ac7c2dfabe16309e9d03888.1650010304.git.lhjeff911@gmail.com>
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

remove spin_lock_irq spin_unlock_irq and variable in the irq funciton

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index f989f7b..f1fa887 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -85,8 +85,6 @@ struct sp7021_spi_ctlr {
 	int s_irq;
 	struct clk *spi_clk;
 	struct reset_control *rstc;
-	// irq spin lock
-	spinlock_t lock;
 	// data xfer lock
 	struct mutex buf_lock;
 	struct completion isr_done;
@@ -199,8 +197,6 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 	if (tx_len == 0 && total_len == 0)
 		return IRQ_NONE;
 
-	spin_lock_irq(&pspim->lock);
-
 	rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
 	if (fd_status & SP7021_RX_FULL_FLAG)
 		rx_cnt = pspim->data_unit;
@@ -239,7 +235,6 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 
 	if (isrdone)
 		complete(&pspim->isr_done);
-	spin_unlock_irq(&pspim->lock);
 	return IRQ_HANDLED;
 }
 
@@ -446,7 +441,6 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	pspim->mode = mode;
 	pspim->ctlr = ctlr;
 	pspim->dev = dev;
-	spin_lock_init(&pspim->lock);
 	mutex_init(&pspim->buf_lock);
 	init_completion(&pspim->isr_done);
 	init_completion(&pspim->slave_isr);
-- 
2.7.4

