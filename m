Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD94C9E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiCBHQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiCBHQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:16:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89D47AE8;
        Tue,  1 Mar 2022 23:15:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso645878pjb.0;
        Tue, 01 Mar 2022 23:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsSqX4r0z/r+w8Wj2n7nu/2FEq4vM6QzbWoDE19qgSw=;
        b=oGyqkbwUZWLjGm2rQ5CdtFXSrWgQOGHhProB0qxT5CJMBzsqkimjnk2vHlZSADpYdG
         pl/h8fUiz5xnsW98hmlkzX3VCdI5w7nyvnRaj41BojYaFrXa1ChaWhVwbLin6wxrcq7i
         rM52rSoy3RT9RQMDvlLhv5WGtAJJD2qfhPVUQ6kq+6khIWE9waG7w3orcBINWTwxl2i9
         lF82azIMPtFkfif/4jkLsDe5q/m77dGK9Z2y2F6VT4YkJpEN+fv2vIq8WsblL08Wq+l7
         tCB+3pVjXeJ0CYOqoMvmDQiK0JKM4Ax8ovuwsO9UfE6+iwQVAuHiMOUjjuwmRMRmeeJ2
         byvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsSqX4r0z/r+w8Wj2n7nu/2FEq4vM6QzbWoDE19qgSw=;
        b=raeKpc4C+J/EqQEE9Aqr0LrblkH7tuACexoHx0IXj/d3Pb/CD51p+CWCSYWPbnHJ2I
         fKzlyKPRikWZh17mLcTjzkBOYUi2Ib/StOkw5OOu0dj0QIPHBejE1QTy/lWowVuvBQ3k
         pvLqk4+qYC+hnqnhDjnPuAtRIp6KWUrQVMMd2KWJV0D8YXh5k8SqGpgmgjA36QH2RHbZ
         GWMQ9h383E4kbkLchlcJbXHCSlOcWj00n5KD1f0Nh7vFzdkpXxR5nPZ/dJwMpq/SI7aj
         1pJIs6ukl8B+Ze2TNHqqVDNoJgoeVtlkJGSRoc1W8kjKwpvbHof3Z6NZMeH/teXSEnrq
         VG0Q==
X-Gm-Message-State: AOAM530OtSXkudw1oHY0yP+jssEpYVJf8ZFZ3/duYk8HXLKqXOrDamlm
        acxMZ9wy66rGEvf4ppaXaks=
X-Google-Smtp-Source: ABdhPJw7Bb9ODt+6n4ApKF4fp/A4k/wWtL9d4ZNZ7r0g/Plq7SmO9JXZxOhY6qnnQgcvF1wXT4h0sg==
X-Received: by 2002:a17:902:9895:b0:151:6a35:dab2 with SMTP id s21-20020a170902989500b001516a35dab2mr14071435plp.118.1646205340137;
        Tue, 01 Mar 2022 23:15:40 -0800 (PST)
Received: from localhost.localdomain (118-166-40-238.dynamic-ip.hinet.net. [118.166.40.238])
        by smtp.gmail.com with ESMTPSA id lk9-20020a17090b33c900b001bc7c2dfcdbsm4219098pjb.37.2022.03.01.23.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 23:15:39 -0800 (PST)
From:   Xingbang Liu <liu.airalert@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xingbang Liu <liu.airalert@gmail.com>
Subject: [PATCH] spi: qup: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Wed,  2 Mar 2022 15:15:21 +0800
Message-Id: <20220302071521.6638-1-liu.airalert@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Signed-off-by: Xingbang Liu <liu.airalert@gmail.com>
---
 drivers/spi/spi-qup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index d39dec6d1c91..00d6084306b4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -593,7 +593,6 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
 	u32 opflags, qup_err, spi_err;
-	unsigned long flags;
 	int error = 0;
 
 	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
@@ -625,10 +624,10 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	spin_lock_irqsave(&controller->lock, flags);
+	spin_lock(&controller->lock);
 	if (!controller->error)
 		controller->error = error;
-	spin_unlock_irqrestore(&controller->lock, flags);
+	spin_unlock(&controller->lock);
 
 	if (spi_qup_is_dma_xfer(controller->mode)) {
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
-- 
2.25.1

