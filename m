Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51B51F5F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiEIHbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiEIH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:28:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857EE6584;
        Mon,  9 May 2022 00:24:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w17-20020a17090a529100b001db302efed6so12035990pjh.4;
        Mon, 09 May 2022 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSyObxIXmaw5ibvcX0FawVvjRmdC4oHfcmD/+YAXJH8=;
        b=Cpa3JylI61TL4omhJYr4HUdHy4dDjr8Gu9DzBby4WY6Qwp1YGihoaKtdZonC4jJ+xQ
         NyCevRCfU+9kzHgJQUj9ZzF3eMK/PUhJqexYYsUVaDs95IjfH3vdz5P3ZISXQbudzrkQ
         4h/zefHj59q8Ca89DIW0MSvWljTznxdn/qLjYprJ9ggdhMn2S2wvIMGps45awZYUxLND
         vzmt6TswM7QA0pHWtWI07TycCAQyfZ19TUl3OoA6d9bNnsy1CGfgxKoLFupuiBJv3yj+
         6eNKd9Nk9nQ3+r8EKZmF9IQjQuv4B//RBirT8B8Cl3ZH6P3GQfV2rScGc66WAlHewviG
         /rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSyObxIXmaw5ibvcX0FawVvjRmdC4oHfcmD/+YAXJH8=;
        b=Gh2S8nxNlbZ0dCiIivkeBYzp0y6jya75dJtjmUe+189fIR1O0bOeMzvaDEldkpW/Xh
         j7jBE1OaWkVIizkeuw0gHZ7eUenV7GuYCYaTAWsLpXZfyItL4OFWMN21mxxHUNtnTH3w
         C0z/OI88SNTOfmkwXm06axzrFtFpQqpnWL3fXs63Z5vPsjl8I/Qj8eSbSRGgYkXUvyD2
         BG24v27I+WG/TlsWD7myo9OmbBtX+KFa3lKIO2JmMkVPvcsCkcNEH14RupuW4aaFPleX
         dDfHRHnaCSDtp+FcW+Ih0NNLStykuRPRNiciYU14WhqBScyW7RT9ihI4aIOmC+hnsmqz
         kiTg==
X-Gm-Message-State: AOAM5309vmeou63ohpWJCMYqt9FKrTeFQ3gN/BM+hQh0KKPtVb6rNKXj
        BC8bWvTdyqm2Os/mefqh3og=
X-Google-Smtp-Source: ABdhPJyrhPWwqX3SrKDowpboDc+L15KMZOBt6laplo58tJSNrThENeqHmKIoYExOwv9DHN6Z809jJA==
X-Received: by 2002:a17:90a:7acb:b0:1d9:85a5:e1e3 with SMTP id b11-20020a17090a7acb00b001d985a5e1e3mr24612187pjl.172.1652081049760;
        Mon, 09 May 2022 00:24:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a1-20020aa78e81000000b0050dc7628137sm8181659pfr.17.2022.05.09.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 00:24:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     jic23@kernel.org, lars@metafoo.de
Cc:     anand.ashok.dumbre@xilinx.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] iio: adc: fix return error variable
Date:   Mon,  9 May 2022 07:24:05 +0000
Message-Id: <20220509072405.1118019-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Return irq instead of ret which always equals to zero here.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/iio/adc/xilinx-ams.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index a55396c1f8b2..a7687706012d 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1409,7 +1409,7 @@ static int ams_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return ret;
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, &ams_irq, 0, "ams-irq",
 			       indio_dev);
-- 
2.25.1

