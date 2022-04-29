Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2718515126
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379322AbiD2QyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379313AbiD2QyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:54:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CC9D5548
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q23so11550895wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNYpWGO+GrpCk66Nh5RWJKF3WobSkmY4PbioKCEWPFY=;
        b=TJ1U/wRoz5C/CERNp5RQJqGMOkIBsbtoy4QIiJZD2TedW6yrrMFq5+yg0MzV2ILoio
         HQj2dVF5V4fP2t/zzQ87bHb2qgi5uSu0zJnKVcQGK1tL7neXv3WTRUNrBo9IOp1pLFM+
         Bv7TvBXEScmzPJ+y+WcIsefaUU7u8HjjvSlASAbmlC5EnBw/AmMB+06rMDXmSI/9RDgN
         gTjYrnx4Ek/xcub5GQh6Dx3YKLZpOKOCuftfqTmSuOWUIfTEEkMNgKSLCtZ6xboAQIWP
         h8JgV+Na8iaYc1azsxTv9V/5xIRR8TSqQG2VqqxHX7e9gUahJLBFWIXnb77/kSzD+q0d
         mKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNYpWGO+GrpCk66Nh5RWJKF3WobSkmY4PbioKCEWPFY=;
        b=d78b6jK4aZHsN2HnDNCbGedgkMw7SP6Az9Q9TCKQRN7qje9A0XVeLvKft8Ve4FRvKp
         uNkpDt60a9sJ4nDeWe5VS0mqLTDPdysuzXmiA5YGhA6gw9LDU/TuH6U75vYLJuFyh1V5
         G9JDcDNsOewin5WU/OLH6p4mBLC90C42BXmaWMesc+5MOJGsdhV+6ZJsDHfFn7EyarnV
         PEo4VIJWXV3Jmppl3vAfJ77VZz4uZ8Y8PA99Iw/bZ7kDB5CYZ8sSB8O+Rpqap60T9J5y
         bNUw8ayBLkJX+U+jB52xxC8kaeVhACN0B4TK3fl7zNXNdEksqkyjG1vkN9qWbcpdeMCJ
         iitw==
X-Gm-Message-State: AOAM533EbcMzIeiFEfeN9Y9sWDAHyeOths7+uw+Ly4pBlsxAz+ky8iLD
        62SHD1Oeou1zk7YWEuitfCrXew==
X-Google-Smtp-Source: ABdhPJyA2Xzxv8Rqt/58gTOx6WD7hg0+F2bIQJ7mcE9Oz09xpNKZO/6zcFKPvEQrky04uStjetkCIg==
X-Received: by 2002:a05:6000:1685:b0:20a:ea43:9f93 with SMTP id y5-20020a056000168500b0020aea439f93mr45210wrd.160.1651251057818;
        Fri, 29 Apr 2022 09:50:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm2848941wrf.41.2022.04.29.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:50:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] slimbus: qcom: Remove unnecessary print function dev_err()
Date:   Fri, 29 Apr 2022 17:50:51 +0100
Message-Id: <20220429165051.6187-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429165051.6187-1-srinivas.kandagatla@linaro.org>
References: <20220429165051.6187-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

Eliminate the follow coccicheck warning:
./drivers/slimbus/qcom-ctrl.c:514:2-9: line 514 is redundant because
platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ec58091fc948..c0c4f895d76e 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -510,10 +510,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	}
 
 	ctrl->irq = platform_get_irq(pdev, 0);
-	if (ctrl->irq < 0) {
-		dev_err(&pdev->dev, "no slimbus IRQ\n");
+	if (ctrl->irq < 0)
 		return ctrl->irq;
-	}
 
 	sctrl = &ctrl->ctrl;
 	sctrl->dev = &pdev->dev;
-- 
2.21.0

