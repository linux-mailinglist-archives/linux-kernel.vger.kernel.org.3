Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3677A508475
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354675AbiDTJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377089AbiDTJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:07:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1F25F9;
        Wed, 20 Apr 2022 02:05:03 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id bz24so529649qtb.2;
        Wed, 20 Apr 2022 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWU0CFZHZcK0qVtLfhFSoJd+WGMELdBWCS1aTnDQr3U=;
        b=Iv2nZ/RlP644ADdG0Hr0RG7R/5gfSIQHdry7ICG8dKhB1iHWDcQCWdF7CfrLtk4hGv
         gQRXUT6pvM1qpHMrUoWSoaUV1nendQ7v3rdf8Uo4ZSqn/yEYDQSFYpJlfYvjvgwHdcse
         JK4il4+3AiMnBm+F1NoGl433RbNvIJTR8uHZqZVSPPiWiusSgQyakK2Ri0ArABjsRPP/
         bX0WQMZxc9kZiZ47tVtutgaqh0iRmbdFXjMzyVYZ/UMZBiwUgzv0829jphGWtb1vLK+o
         QUiQtVS2bBRa+ZDO7SijfGJhpI9dkaw/9B+k7LMSq7L9ImXT2X0n1a4o9ZY0ezJOQg3W
         2iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWU0CFZHZcK0qVtLfhFSoJd+WGMELdBWCS1aTnDQr3U=;
        b=hj43+746/1PmvjiPhQQ4wUA5QVqDiwrpHr+xsceyekMCVIfR46vKevX/MKAhdWruB3
         PnEHXPe6Kod+UIdm139F4stdnZQmg/a2WFy+Xo01m7MEOSSoMHsFYEbomDyMy9+vxcWW
         KgbRAnE09OSnKaQxoPCueyKolNwB9Zamg5/XAt7i9CeCXDWH4+9AmPhmbuqMANq3oXpv
         EcxD0y/xQ8l0G4zvcMwR0vpiDfzQH1j8UXtNYRSTUWk4ZU7hFzdMpV67EYbOaHdLQKWR
         OjtktK3ppW9m1SDZkLERjdc0d1oJ8PXw+fRLuBycSJjflVmqdTgB0oLUMQSAeqLKLiQ1
         pYAQ==
X-Gm-Message-State: AOAM530HQcccfY/XB+AqMvaSJsktTCHuDs2HzhlJx2RPVVuZQHFRUTDi
        owjK29tB4k6B63uul+QzXBw=
X-Google-Smtp-Source: ABdhPJynC+cZt0N24fBHq9t1/ImAPBCuJFzgMh6bLZNrRU9DO1Wd9RchF3AZrg8Hkwza637Uw3GtwQ==
X-Received: by 2002:a05:622a:1ba5:b0:2f1:f540:e04b with SMTP id bp37-20020a05622a1ba500b002f1f540e04bmr11914803qtb.62.1650445502343;
        Wed, 20 Apr 2022 02:05:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f28-20020a05620a20dc00b0069d98e6bff9sm1249602qka.32.2022.04.20.02.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:05:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alain.volmat@foss.st.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: stm32: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 20 Apr 2022 09:04:52 +0000
Message-Id: <20220420090452.2588930-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/spi/spi-stm32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index a6adc20f6862..6fe617b445a5 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2000,9 +2000,8 @@ static int __maybe_unused stm32_spi_resume(struct device *dev)
 		return ret;
 	}
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
 		dev_err(dev, "Unable to power device:%d\n", ret);
 		return ret;
 	}
-- 
2.25.1


