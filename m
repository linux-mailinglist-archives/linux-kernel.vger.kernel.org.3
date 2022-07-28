Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343BC583B01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiG1JKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG1JKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:10:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F285721A;
        Thu, 28 Jul 2022 02:10:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 17so1458727pfy.0;
        Thu, 28 Jul 2022 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bj82CbtTyxhZzt1ha5XVKWWziIA+fLtpPoDKxfcP//Q=;
        b=h+xeEmpH+LEZnyHMYQiBQo+AvFZ+QOdg90MdHHh0UF8HDLv+M7IzKSdccpb4fkfzkF
         UQdJOYjFfNtMY+eWzC2scG0YtqA0Y+UPIBvERzr9CqWc2m6Ihwpk5KLc4Q1vHuJ4jJ2Y
         34nBl8evT77kZtXGzQZmfEXQW+Pa6zrc96fI5yOVmB43HJnO5oEy27Z1nnjMHFZKX7Eq
         r/u7ag7WQ4RywY5EiPs3IvuYkkQJnsF0S5G5rqDpER5eeLMjzq/rxpz+AzBHC6ggDIs1
         fU98AScNM83BUmv9rdjJgPrBbJVslMFdvsJt/Hhy8d+sujmETnfRkizSAyXQsL+v4kJB
         dgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bj82CbtTyxhZzt1ha5XVKWWziIA+fLtpPoDKxfcP//Q=;
        b=I0lqiBiu6WGuiJu10CkLl9mU769JsyQCPfm//gl/9bWWXbimoCoK7IAVmGjmiKajNO
         uGx6ba+Kkj3yczO1CsXtKymv0IJ9x0suL2SjiNCq7hRX1HhT9zxKmsACOJpHvYRP6dKI
         WmEvDaiR61oJGTlKroR6XHnFY64YJFpq+45RFXNaiP5BGtqkubcS5gOJ3lnfvPU945aO
         WfjQkDjtJw1aPnoPQEdA+41h5RmxpaiHjEIGWNTnC0EJbAkc2vfEqKsIJJb1HPTolnIh
         ywO/YYoY4g0JCOA2kfmXMiVvKcFQ7PNNvCGJVzTCo01t+rLZe7yWukXFLbC/QywYUpnq
         odDg==
X-Gm-Message-State: AJIora9Rh6X4pkOnC8drW80+vNAiPJHwfc7NAxkTRWei78m/Thgg7Qn1
        AqkQPWIUX2NaNcZNLJi5GmA=
X-Google-Smtp-Source: AGRyM1tul11mVRIboPlPtgx/4h/0hs5mb8pLTJn+GHvAoKHdccC3K7v/632PLRjF2+qpgD1k3ehFrw==
X-Received: by 2002:a65:49c8:0:b0:415:e89d:ea1a with SMTP id t8-20020a6549c8000000b00415e89dea1amr22348715pgs.266.1658999449418;
        Thu, 28 Jul 2022 02:10:49 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a3ea300b001f317767790sm1659190pjc.23.2022.07.28.02.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:10:49 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] rtc: rtc-spear: set range max
Date:   Thu, 28 Jul 2022 17:10:43 +0800
Message-Id: <20220728091043.1896158-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

In the commit f395e1d3b28d7c2c67b73bd467c4fb79523e1c65 
("rtc: spear: set range"), the value of 
RTC_TIMESTAMP_END_9999 was incorrectly set to range_min.
390	config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
391	config->rtc->range_max = RTC_TIMESTAMP_END_9999;

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 drivers/rtc/rtc-spear.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index d4777b01ab22..736fe535cd45 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -388,7 +388,7 @@ static int spear_rtc_probe(struct platform_device *pdev)
 
 	config->rtc->ops = &spear_rtc_ops;
 	config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
-	config->rtc->range_min = RTC_TIMESTAMP_END_9999;
+	config->rtc->range_max = RTC_TIMESTAMP_END_9999;
 
 	status = devm_rtc_register_device(config->rtc);
 	if (status)
-- 
2.27.0

