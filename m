Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5B50DC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiDYJN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbiDYJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:13:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D548C9B69;
        Mon, 25 Apr 2022 02:09:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu34so9854893qtb.8;
        Mon, 25 Apr 2022 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxgLQ1soDdNo6GOHgPvluqBZIfBwx/V3C+hOxuZtNW8=;
        b=BtwHxyPpct0J/94b6H6JFnfA626J0AL2B34MiNkgVl/GmKQdL0t7FSK6PAhiLi7Km6
         h876ttC1XBP68qbB3vc4+a93XEN5R9ZwU/dKsbGptAD3v+11FS+3wniG62kH+RdmoDLV
         zt79dPL4a8c0YUu3WvbCSchqL2EyqvClNf4zAlgruLcHdamP2Ll6euQm5p7yAKi7Sw1v
         ZmGYY9bmlAHDsDAXexFR8zv64kfP9DKxxg5/uOZ9egdrB98PmSnG8LKTl2pX7fYdU+wR
         a4tqIPxNnHfzca27KN5WaSkZCNc9OkxMXrTysh5MHJupPxFOXcAGmz2Dq4xmkElk+UDO
         2Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxgLQ1soDdNo6GOHgPvluqBZIfBwx/V3C+hOxuZtNW8=;
        b=pVA0M82VWdSIBRcNek1JU8JYUA+Fnp9Wt5v9db4WikuviSI10BK436uV9qNxr4yCuB
         L8YrZz76h4nrog6im5aKr1/psINAzjyF+aSX6BvaRtySy1nxNtaa63RSMY7WsI0wuGkR
         zcghAzHRhT4FZI7Vf7OeAI5IPsL+OT0dk5B9OKD6mJD7vstVyUnE6Z1BIeViq25Cbj1W
         /09bhMQdku9FCFJZlaXXnYKoNq9zT0duevQnpwyJ/PAi7JrOxBoEPbxu4bsdD+IQ+hqL
         Gzxg2F0X4bbSKI8XfelhAwz3oJktaYg0wD9zEJWxNGESI/3sj3jPQ0A5V1ADrr8tS5f4
         5hBw==
X-Gm-Message-State: AOAM533tcAmOhoQiZdjw4qYgIe6V26T9l/7gECbODmrK7GtnrRH2LIlb
        f5rVNZSXxrhktqQPXNRGwFzpP850GuI=
X-Google-Smtp-Source: ABdhPJwBdVMVBLRA8VCjJ4w1pDSTXYa39d9cefp0lgq6pG4EAjTTfJBWbxdQxFOYYMlZhszBt2D22w==
X-Received: by 2002:a05:622a:100a:b0:2f3:391c:3ce6 with SMTP id d10-20020a05622a100a00b002f3391c3ce6mr11187185qte.351.1650877797522;
        Mon, 25 Apr 2022 02:09:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y189-20020a37afc6000000b0069ede17247csm4799225qke.86.2022.04.25.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:09:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     robdclark@gmail.com, sean@poorly.run
Cc:     quic_abhinavk@quicinc.com, airlied@linux.ie, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, swboyd@chromium.org,
        bjorn.andersson@linaro.org,
        angelogioacchino.delregno@somainline.org, tiny.windzz@gmail.com,
        architt@codeaurora.org, jsanka@codeaurora.org,
        skolluku@codeaurora.org, ryadav@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/msm/dpu: fix error check return value of irq_of_parse_and_map()
Date:   Mon, 25 Apr 2022 09:09:47 +0000
Message-Id: <20220425090947.3498897-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The irq_of_parse_and_map() function returns 0 on failure, and does not
return a negative value anyhow, so never enter this conditional branch.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index e29796c4f27b..36eeeae7fe45 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1187,9 +1187,9 @@ struct msm_kms *dpu_kms_init(struct drm_device *dev)
 	dpu_kms = to_dpu_kms(priv->kms);
 
 	irq = irq_of_parse_and_map(dpu_kms->pdev->dev.of_node, 0);
-	if (irq < 0) {
-		DPU_ERROR("failed to get irq: %d\n", irq);
-		return ERR_PTR(irq);
+	if (!irq) {
+		DPU_ERROR("failed to get irq\n");
+		return ERR_PTR(-EINVAL);
 	}
 	dpu_kms->base.irq = irq;
 
-- 
2.25.1

