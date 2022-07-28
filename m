Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ABD583BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiG1KBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiG1KBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:01:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E021824;
        Thu, 28 Jul 2022 03:01:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 6so1132293pgb.13;
        Thu, 28 Jul 2022 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=t9y7xjj5WswnQX5E7Cfm2CbUgSKkz6Tn2hu/+krjfiY=;
        b=FkKyak4Np9Q9Q4Q363wcf/BhiPXHnyqiCIpO9R1PpVQVHjzjdPzTOtsfQ34rC2fWn+
         /q3X8vUeDUJkSgG3sduo1hfZPuHqpM3i58XRu48HFfLGhcXVWzNk3fkiY8XiiHenhmgc
         bnwp1VoQ+OzZEwcugLZGD+hgpLtFUutmXy/KDC18uhSaiPKz8zSVWTyORwUMGOuNfJTX
         UufMNDo/Un6hiDvaLTnekoE5hIGUo00GZ9+mo7myrmuspepbnL3lzhDIm6lYa87b4t+1
         Mul5BcIv6vNc5P3Yo1wiX+MsQjgjhGJauIzLfEQhXR/6AAj0SgB1us9A7APonnAl+ZF1
         DBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=t9y7xjj5WswnQX5E7Cfm2CbUgSKkz6Tn2hu/+krjfiY=;
        b=HhZnfEsFBXtIpPmAq4U3rBGEWHtKeJa7lrGDFrCjqWaiAuwDfl0UKxPrkCQIpk8a3W
         fC4ecOgrWHixcwB5QGt68MJgmvRkkq3FIcjBAYn7KPPp0Rt2KiHQ7FtlK4UEVOD/VngP
         DzBAiU55QTVRml3IirZicOjnQW0Ui0qZjQaWUMJjAwUG7lLsRQ5xU2ojQ5D1eal68ntY
         sMQJvolrK897+PRDm++Kvd6rSVRgQZJx/5Ft2N4+HEGmu8ZMRNxGwY3zebzb06F23r9Y
         s4gHV6Hf/zJ5XQWiTgaL2r+8YdkVMYSNy6Dk3S8eKvQS4SrDioxDSKgZR6V6ewWGJoAQ
         pX3w==
X-Gm-Message-State: AJIora8XC09V0/NNmCUpWnagaQUAlvNqJB9BymgeFFuIliu0QA68Ac5C
        neUEcfAyuSrMceSOvGMPeLkzwlWYiFrUKA==
X-Google-Smtp-Source: AGRyM1vlE8uAzv7vhFLcwh6wpgHVnrtFe01MErtHeOpApYtLksTF7tKwsxD90yFnnXmsO69iup2JmQ==
X-Received: by 2002:a05:6a00:4211:b0:52a:c86e:aba3 with SMTP id cd17-20020a056a00421100b0052ac86eaba3mr26744474pfb.41.1659002467141;
        Thu, 28 Jul 2022 03:01:07 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b0016c3b0042d0sm864522plh.14.2022.07.28.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:01:06 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH v2] rtc: rtc-spear: set range max
Date:   Thu, 28 Jul 2022 18:01:01 +0800
Message-Id: <20220728100101.1906801-1-zengjx95@gmail.com>
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

Fixes: f395e1d3b28d ("rtc: spear: set range")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---

Change in v2:
- Add fixes tag

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

