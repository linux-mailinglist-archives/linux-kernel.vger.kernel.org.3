Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED84CF33C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiCGIKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiCGIKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:10:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167602D1C9;
        Mon,  7 Mar 2022 00:09:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q11so13058311pln.11;
        Mon, 07 Mar 2022 00:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fih/vSdGHR0JowIfC8euC+Svpd2DDeZcu7agJIp6P7A=;
        b=ndhMl3gNFu8scDqQV2O31UQhX7Z+oXkb/9xN0mCO+wAgpgzTMV7lo9ta56tGAA0TUW
         eb6Y20srUk/lj5tr6yq0HOmpbJ1GYk0Cp2O89z8Q4n/OyAe0vphsCQSzuUL/pO+N+GkA
         0B8n18OKofzmIweyAVUHkQHyRRDqxpK+Z5Ug21nxQ//V4a/Kzu9xZcDSi0yMeyEGLmbO
         Bpo+S08DjyveU+F35BW75YjGaFGnfJbW63CMY0oI47iZCPIPjnZjSeSE5QJFVWhTYSdx
         1DFXtHENlMNRTY3+w+dMFEeFQVG4BSP8rnkZTv8BoWh+AfU7zQhVBjregDK8WyRkKvEG
         irJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fih/vSdGHR0JowIfC8euC+Svpd2DDeZcu7agJIp6P7A=;
        b=QcvdK9BCo3vGuNl0HH88S8cEAQudiZzMjkxb+YDes7yf3rf20aETM2DrJfhivtLvQe
         gDGWRyiPPeNh6HTLDf/Gqip8yPFSdVm9BPGEmisaITfGzUGxpSNE/cWGELdA30Bflyar
         KjnJtWSlhEZN+F9n+M0Ds/83bLEymh2qaWAdNzLLiG7cXQebQPcE3CBpb7A5fmNVe3rG
         eVBV2M/TOrhpfNVQa97r/ZUWQ21+z4gmG3on2zyQVj0NAyKbaIdFIkgo4TUgQhDzIDB/
         xQCAoAf6pQ8aHgw9S2wkFdz4HTncHlPLRW27G16pdJ4x8mnAGMTURB+ngY0FEvkJZTpj
         oZVA==
X-Gm-Message-State: AOAM531Zv96/yxXLX6J2zeTLiNukmjDwu5nsSIti/u4B2jOrG5sjCaCW
        5YTendp+ZbwuDHatSneU1DU=
X-Google-Smtp-Source: ABdhPJys0jf5Q9QRQsiqr9PkmPvl/JSNQteR6wmuhJDKT2xzhonaCP8tqLciYuheYcZ6FpX3JD3wAw==
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id i12-20020a1709026acc00b001498f60a526mr11157106plt.25.1646640554645;
        Mon, 07 Mar 2022 00:09:14 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q15-20020a63504f000000b0037425262293sm10906324pgl.43.2022.03.07.00.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:09:14 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v3] media: st-delta: Fix PM disable depth imbalance in delta_probe
Date:   Mon,  7 Mar 2022 08:08:59 +0000
Message-Id: <20220307080859.14475-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2a3b4095-7b63-4da5-d0fa-43ba86715504@xs4all.nl>
References: <2a3b4095-7b63-4da5-d0fa-43ba86715504@xs4all.nl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will decrease power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: f386509 ("[media] st-delta: STiH4xx multi-format video decoder v4l2 driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- remove unused label.
changes in v3:
- add err_pm_disable label and update related 'goto err'.
- update commit message
---
 drivers/media/platform/sti/delta/delta-v4l2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
index c887a31ebb54..420ad4d8df5d 100644
--- a/drivers/media/platform/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/sti/delta/delta-v4l2.c
@@ -1859,7 +1859,7 @@ static int delta_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(delta->dev, "%s failed to initialize firmware ipc channel\n",
 			DELTA_PREFIX);
-		goto err;
+		goto err_pm_disable;
 	}
 
 	/* register all available decoders */
@@ -1873,7 +1873,7 @@ static int delta_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(delta->dev, "%s failed to register V4L2 device\n",
 			DELTA_PREFIX);
-		goto err;
+		goto err_pm_disable;
 	}
 
 	delta->work_queue = create_workqueue(DELTA_NAME);
@@ -1898,6 +1898,8 @@ static int delta_probe(struct platform_device *pdev)
 	destroy_workqueue(delta->work_queue);
 err_v4l2:
 	v4l2_device_unregister(&delta->v4l2_dev);
+err_pm_disable:
+	pm_runtime_disable(dev);
 err:
 	return ret;
 }
-- 
2.17.1

