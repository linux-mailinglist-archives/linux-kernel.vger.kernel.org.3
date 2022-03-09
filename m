Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD4E4D26EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiCID57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiCID54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:57:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FC15DDD0;
        Tue,  8 Mar 2022 19:56:57 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 11so929242qtt.9;
        Tue, 08 Mar 2022 19:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNLHA9N4r4aIWE8DeGEVOgoiZevArb3vnmHjnclBokU=;
        b=KT6+0BEk9a7VYOIkB7lwjto6+7w1Ifuaqfgb9nPAXaGt/P3auBOyymDZrMqjte+Ia1
         oaXMB8zKkh4LgVEdwBRpgEtg9jJx59ELVoUqugrtQShBZZoDdBjZrKImT2SCPbdwAki7
         Dm2dUYIK+hS+lgb/1zEkCeBKO03NEis9yWhsRbPy3PW++qweD+WZzn5HrA7EDJvSYxiO
         /Y2XR11WLMCvWR/TY1WnYXPZwinfONDjCI2eG/JvTmhkn0Axr/mQEMybMn0HdIm2PaKn
         CQ5Dd2b71OjUXx1zufajp4qdhMdX2dMmp4/K70BYkyo5xrBe2KUVxWtggUJEbF4SMgNj
         VMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNLHA9N4r4aIWE8DeGEVOgoiZevArb3vnmHjnclBokU=;
        b=quGKK02VAsJ5naAf6pGo00X+JGPDkzoUbNNjy4TtK3YMVgdEeExhUrweZQlWAU8cg6
         zJGzWRwE3ESsCwKSMY6MGK9fQm2Yirn0BiHEVa3QqW8oNICD9QAWes1vAfQUOBU7Ll4W
         W9NqZL/CrhfuodjsWJV0MA1Np1IsvkKiL1Pg3DYy7Ml9XtObCOyVrJv6Y4PeJG+Hzdd6
         jTPnJmEvVQHSQv99vq2rMU3fYaMLII6ImSgyas82XGsAU7kywNNa1D4rJ2/BTQVQ326p
         BTKkcD+BD5iRHxBS80il3cB7hFk4j00hYPKeoRtckjLPrkkjPbtRgObS/loRNXJVyzFw
         lpzA==
X-Gm-Message-State: AOAM533il9TdLRcXeJDtEvm0lEQi/IdDNxM+TK0XwiwL+0eSXWzs9j0V
        g1ASyHxbHexs5839oWD4zO0=
X-Google-Smtp-Source: ABdhPJyjJJZSB7IzDh1GARggA2zm3ogRVKUPFzP2Vqy8jXpT/DDzJldlXg+umh2CcpTXczLFrZDVBA==
X-Received: by 2002:ac8:5e07:0:b0:2dc:ed40:d01a with SMTP id h7-20020ac85e07000000b002dced40d01amr16426379qtx.286.1646798216247;
        Tue, 08 Mar 2022 19:56:56 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006494fb49246sm425299qkb.86.2022.03.08.19.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 19:56:55 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     prabhakar.csengg@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] media:davinci:vpbe_display: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 03:56:48 +0000
Message-Id: <20220309035648.2080945-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
for requesting IRQ's resources any more, as they can be not ready yet in
case of DT-booting.

platform_get_irq() instead is a recommended way for getting IRQ even if
it was not retrieved earlier.

It also makes code simpler because we're getting "int" value right away
and no conversion from resource to int is required.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/media/platform/davinci/vpbe_display.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
index bf3c3e76b921..e0aabcb333ac 100644
--- a/drivers/media/platform/davinci/vpbe_display.c
+++ b/drivers/media/platform/davinci/vpbe_display.c
@@ -1363,7 +1363,6 @@ static int vpbe_display_probe(struct platform_device *pdev)
 {
 	struct vpbe_display *disp_dev;
 	struct v4l2_device *v4l2_dev;
-	struct resource *res = NULL;
 	struct vb2_queue *q;
 	int k;
 	int i;
@@ -1405,14 +1404,13 @@ static int vpbe_display_probe(struct platform_device *pdev)
 		}
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		v4l2_err(v4l2_dev, "Unable to get VENC interrupt resource\n");
 		err = -ENODEV;
 		goto probe_out;
 	}
 
-	irq = res->start;
 	err = devm_request_irq(&pdev->dev, irq, venc_isr, 0,
 			       VPBE_DISPLAY_DRIVER, disp_dev);
 	if (err) {
-- 
2.25.1

