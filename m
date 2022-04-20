Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D6507F57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359168AbiDTDH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359212AbiDTDH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:07:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7A3A5EC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:04:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d19so370068qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqneS1sFpDsOyrIE2+1UdTS/4fNFnUPRBLnd3RmNOTc=;
        b=Ts5wpZlehNTldV56YalrJSp5dhybuu6s+42AgTPpMsMwjFt1Lis7Rt+xmK9FiGrio2
         HqLSB4P+IzJOw+6Bkz6PTrg+YcegYXzJGd4zlkOm30JZB+yWwqKV7qq9mHJMgm9uucUv
         /ylGtHPl592ncy1Ko3mPGdSmR3RmOr7Ar//h7ITZwPp/wsPT6/qocvoCupoZwIFDzDSf
         fYcOGN48iPY8aBPztkQacG0OHWYO35uCtj4BqSNdu25D3pTWUH0OjeCD8FbVBoa8L1Aj
         sDsFDbYDyfEySElrOHYUPcqUKXIq5uonPN1JW7eM9e1SOfRmSiKxCj5zvxMMKj7c6X/3
         FsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqneS1sFpDsOyrIE2+1UdTS/4fNFnUPRBLnd3RmNOTc=;
        b=NDdVS79qcnhWnHyrOVxQPM0EwcRutddCXeggYMXPyksbPzSbAGxt0LWai440fQisZB
         noQva30hUH9NV+SGvqHGO9SHqBW1wwtlz17D1XnYR1wnYVfEc9spIgtxg0ThThYNs2CS
         m/WWFnfct5nkTZtcmTg9Dz08rCvVjSDgZRtLmGeamIi0IC2lgEBPPxGcXSPuA3Xi1hM9
         oquqsWvGu3eLykedRrR2J1rBfkiO2fFOprDuHs9pJvHmiAjKKf1bs76bcEb8k4dRw1cQ
         CsGMHIFi1SiVdbbV1ZESzU7j1mf334cKZ6JT+f8ENUfbb1PR6x8ZBNzlnEA1tepiqarx
         lDyw==
X-Gm-Message-State: AOAM531AxW1PadgNjPGoIg7efkKzRDcerOpVoWAHcWXwwtEiBnEw90gt
        vU7F+iD3KXNb+d4DZfpE2ow=
X-Google-Smtp-Source: ABdhPJx/s+b4syYfQni7rUQWx2AyU+UcLFCRd7P0jGC6d1QDovYVBI1ayiBLkCungiG7Xd4kM0xQww==
X-Received: by 2002:a05:620a:16b3:b0:69e:bf77:778b with SMTP id s19-20020a05620a16b300b0069ebf77778bmr4284035qkj.642.1650423849002;
        Tue, 19 Apr 2022 20:04:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v23-20020ae9e317000000b0069ea555b54dsm901109qkf.128.2022.04.19.20.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:04:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shengjiu.wang@gmail.com
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: fsl_asrc: using pm_runtime_resume_and_get to simplify the code
Date:   Wed, 20 Apr 2022 03:04:02 +0000
Message-Id: <20220420030402.2575755-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/fsl/fsl_asrc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index d7d1536a4f37..31a7f9aac6e3 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1211,11 +1211,9 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
 		goto err_pm_get_sync;
-	}
 
 	ret = fsl_asrc_init(asrc);
 	if (ret) {
-- 
2.25.1


