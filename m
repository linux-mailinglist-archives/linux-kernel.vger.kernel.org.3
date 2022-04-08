Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9514F9066
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiDHILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiDHILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:11:05 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0867331369
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:09:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a5so6948874qvx.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nZ8Cf3LRZ0eXC+/jDpJdGvASXhI58JudQeh/uFiupk=;
        b=H1IEa2iWhEQ1d1Yjqu37Cs/OifXy4ZmAuFmoO6+VooAyXg1ksBXzGezyqoNwfDQV6t
         PnvA4NdgCNYKChIP20C18F3IWSwY+8P+CFq3R0siTVXKY0WPp1ArzWky5FomG97bmHUy
         VTgIUM1XOwPNdQskNNEeJ0r7JGQ3FD5tZR8z9caRTHNxPtA8K41qIXjM9GoNURXe42hK
         z8VXV+0c7p0EzXc3/G6GzT6LucdwhFJ/LKFLDSQ9MAm2amFNCT2ZfSgSoKncRwBtegKQ
         vVD7gyG38/vk7+mtAA1/se21LH4Xv993+W5sM8cHpy92zry8WXG2xTYIieCmlEy065+V
         fvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nZ8Cf3LRZ0eXC+/jDpJdGvASXhI58JudQeh/uFiupk=;
        b=Y0Gs30Uzr9Z6b+BxPvMmWYJV1iHYO9iFUMkG6o2HMIWkMtvf7QOXRuC5SD+y4diQIn
         VhRJbQ//62OPp/tePJzmm+FKQG1zy5vY6gA5wMgbghSuvgsWVfO39ovRQ0fQ71n2zxU4
         xVatuq2woud+eqvMtu/MbNvgO+2hPtHTRUth3q+Wos2RH6srC7l2X961H6Oi6DfFVCFa
         JH8zhNkupwHbYloduI3bsTD7GZV8B2YVx4s0jXiREXS3NR9PvoUJKJmnBbHTO6l2p7w0
         g+58JNWjKjDifsohvjUC1jK83MyY4hVUXZkTthJxpdn8yOuuieF1JuwZrBeKLnu/ts1N
         CbZA==
X-Gm-Message-State: AOAM531sEdl6CAuCREG5MV9VvKW1F+I4h1rRqx51mLx8WmWdJB1L8vIn
        g0Ohndzw7jCrTuycP54p+zg=
X-Google-Smtp-Source: ABdhPJwTB9rECcgi6dQKDidSmCGKrWtx4dlHQ1tFg6sZ6udhOdVQhhI/Wzqi0UV8UV2iOT+OzrRLNw==
X-Received: by 2002:a0c:f649:0:b0:443:da6c:4297 with SMTP id s9-20020a0cf649000000b00443da6c4297mr14824550qvm.71.1649405341255;
        Fri, 08 Apr 2022 01:09:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c65-20020a37b344000000b00699aa260f5dsm12102323qkf.1.2022.04.08.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 01:09:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     nm@ti.com
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc: ti: pruss: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Fri,  8 Apr 2022 08:08:53 +0000
Message-Id: <20220408080853.2494292-1-chi.minghao@zte.com.cn>
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
 drivers/soc/ti/pruss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index b36779309e49..0e4ba0f89533 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -279,10 +279,9 @@ static int pruss_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pruss);
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "couldn't enable module\n");
-		pm_runtime_put_noidle(dev);
 		goto rpm_disable;
 	}
 
-- 
2.25.1

