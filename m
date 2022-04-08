Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98D04F9067
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiDHILq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiDHILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:11:41 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3031DFF;
        Fri,  8 Apr 2022 01:09:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p8so6936237qvv.5;
        Fri, 08 Apr 2022 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvrPdbilEiNQ6xA/V3yxjuFCkZh5Xedbmn0/+sfMiOA=;
        b=b8/zWJkkt+8LFdvr03PPHOxb+Z6y6VXc6MmQTX/FjDS1Cm2Bcj194BwvwDL941Q5FX
         fcims+D8y7aaodn7XoNS4JQ3bJ96a63/8P+iSwgU4xNMCqZY7WqqY/plPl2s+FLPeEJy
         lo9ynUaBl+Toh8y5XrDjLwlEYKP5pe/zHiDLhVoFWYW/2wPsWzEqngC0Tl2OUopjqMgX
         4kgeYjdD650syf2yLeFrpKeHPVWA2b9TwOb9T5aiCDK79N0XnviF/SmXgW+Tyu40gWEi
         HsoMPF78023Xg826hz0Cj2QEjgrTOgx7hxIByOgulLmcy1vCnfrmkLeSP6/vOlYACvAY
         frLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvrPdbilEiNQ6xA/V3yxjuFCkZh5Xedbmn0/+sfMiOA=;
        b=tmBuMJxAN0z1tmtNtOixMeEl9ZKg62dsUrJfFmHO0yeb0eSX4hxMLbpYDoFKnxDEns
         N/k8ONBVTzwYEqsY2+mQ0VNrmKSPutTPK8hvtc6azu3jCXx/FpvesPAVDUpoZaDgmL3/
         M0tkrpHu79RHmKAltFrCU6D9WZBRlK2oP4xhQuyos8lEAsrdsXpDX4ZtHrFExWmMuEAC
         dErUCd8IKR64NJ1lRxl3iU4kIhm0zVuZzclWdEE7zxjBko/joWbaCvN68sOJzlfA/knS
         s4YHwhs8P3M/b2MWCXpc9cN1tBUqkL8fRRIbW5xFiusG3wor4VYxKcm0CXSyFGw1G38P
         MrxQ==
X-Gm-Message-State: AOAM5300O96ZGXCSoezI8MggWt4a4uumrR2nB2+g1iJiy8wHTJY2wqH3
        y7SMuOb81CnWyF/CPJ3i0mEEn9gZhVY=
X-Google-Smtp-Source: ABdhPJyvbQrNsswukOsqSflO07qr+g2xhSpqnKYHPs4QUTSGdNb8QFb9n0tAUILqhHI0FriQs/pplA==
X-Received: by 2002:ad4:478a:0:b0:443:e160:28e2 with SMTP id z10-20020ad4478a000000b00443e16028e2mr15175141qvy.76.1649405377090;
        Fri, 08 Apr 2022 01:09:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002e1ed105652sm16799392qty.2.2022.04.08.01.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 01:09:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-ti-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Fri,  8 Apr 2022 08:09:31 +0000
Message-Id: <20220408080931.2494356-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-ti-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index e06aafe169e0..e6e8b062766f 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -172,9 +172,8 @@ static int ti_qspi_setup(struct spi_device *spi)
 	dev_dbg(qspi->dev, "hz: %d, clock divider %d\n",
 			qspi->spi_max_frequency, clk_div);
 
-	ret = pm_runtime_get_sync(qspi->dev);
+	ret = pm_runtime_resume_and_get(qspi->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(qspi->dev);
 		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
 		return ret;
 	}
-- 
2.25.1

