Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660150B343
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445656AbiDVIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445657AbiDVIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:53:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70583BE1B;
        Fri, 22 Apr 2022 01:50:08 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y129so5363043qkb.2;
        Fri, 22 Apr 2022 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6nkPYSNqK+Cw/qD6vjcOwkiY8eCBmiuAPmGQItUKZ0E=;
        b=IdhdwlZB5sTnfN3m5koHQdBJdez4rySc7Gh3bi7zDveBPNwaHnj1HrpLWB8Xu3RN2c
         q5ELUClQ1eGaDzTesqeK69p+q2L1oemo2Ov5wmUcNXYCEDlOcvXOdt2Hw0DmSI1h7WhL
         ESqtoX9vIbUmbEFHKbmzUxZYfarIU5Ya8UWTc4Gmgpzj5ghpgmhqmihapgQ0X6TCaORO
         QHKURbaD7/9p71VIYelAw7VlCWzlHvI+A7tdnmYgx6RRDBxHzP3xs9JOLuUDCKcAZxCw
         CoHJKZx00cjCZzU+LmYcrHKeW3U+kbOOPWmCjhfSKTo/tzC+r/tPjhS7JsTAioo32o2I
         fypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6nkPYSNqK+Cw/qD6vjcOwkiY8eCBmiuAPmGQItUKZ0E=;
        b=RHCh98n5O0Uj/cLDwMwlhTNkctcTyagNQ9ShRmmiddWUaUwmrs+dawV+e0QKEW8e1u
         5ZNlv8LkuWR0dEup/bE5UaTxK0RPs285FmPzAoSk4fgJxQAQngRdGk0Ts7rAgrTHvnH5
         PE8s940WULQ2/bbZtoyoWw6OD6IL7XqnsQ6moG8kkkRd3Fw9lKQZveGVrGU2bZEBMrJY
         AWvilRnqDFKCBbQpAgOIvaxsVKXxkQaogogRAXZXrcVGt3qiiqlZIFK5iVnzvxS7db7W
         NSXVNpf1ztxlQEJLpDkAQgVcZDuKY7ZcvgLxi/JAcWVJ8cBm1sJz5ubsP26toYvaWnAF
         hM2A==
X-Gm-Message-State: AOAM530zZz4jjH5npk7D1gZYJOQbMcMFtneqcbFvboQcYFm+KieHfcMR
        gnJz4BUvZbsf3l5LgwxwyS0=
X-Google-Smtp-Source: ABdhPJyXCx0PAFPmSxMP4XcsxbcfGEtc4GJyQK+4XSFjo//0/7XCsgrqJoEyPTW8ArA3Zu5AvNz3Bw==
X-Received: by 2002:a05:620a:2681:b0:67e:933e:54b6 with SMTP id c1-20020a05620a268100b0067e933e54b6mr1980148qkp.428.1650617407550;
        Fri, 22 Apr 2022 01:50:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w82-20020a376255000000b0069ee3f0ae63sm653237qkb.45.2022.04.22.01.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 01:50:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, quic_khsieh@quicinc.com,
        bjorn.andersson@linaro.org, linux@roeck-us.net,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/msm/dp: fix error check return value of irq_of_parse_and_map()
Date:   Fri, 22 Apr 2022 08:49:51 +0000
Message-Id: <20220422084951.2776123-1-lv.ruyi@zte.com.cn>
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
return an negative value.

Fixes: 	8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a42732b67349..3926d2ac107d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1239,7 +1239,7 @@ int dp_display_request_irq(struct msm_dp *dp_display)
 	dp = container_of(dp_display, struct dp_display_private, dp_display);
 
 	dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
-	if (dp->irq < 0) {
+	if (!dp->irq) {
 		rc = dp->irq;
 		DRM_ERROR("failed to get irq: %d\n", rc);
 		return rc;
-- 
2.25.1

