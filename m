Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754DC507F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359189AbiDTDJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359167AbiDTDIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:08:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411C2AFE;
        Tue, 19 Apr 2022 20:05:51 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e128so361183qkd.7;
        Tue, 19 Apr 2022 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jXVd4JyYt+RLNj/hac0Knj+pNB+a1zaGjepppWkJ+bY=;
        b=ZFxLZ3jbqwA5VN/V3U/Sorl04NGsIMy+K76HC0ts1VMujTqraPtXgbpy5j38Vr9y25
         P03eTzrb5j+T55kQJmLGL0oTfrJhhIKMehj4M43TrxjbvCUE5i2lnBnXedwhUB0Hrg8T
         Km317NMpdTpDEDCNWEwmM0UIdwDiGLeChlukAexTd1u+qP0rZqP16/WcVoKDON3/vYwq
         i7vFxRBZmRhliRki+IgBDiztCxmLGNoxw7Zgao2S8BI1opGRiguZJh9M5gUsCVwo9kNR
         f9HEzFx1zQc5GciqiPzoiVb8snwF2//GFjEDjuvFlX95ZL3WxdzAKWNBqKf/cpmMIev2
         lQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jXVd4JyYt+RLNj/hac0Knj+pNB+a1zaGjepppWkJ+bY=;
        b=8Eljv12YMj5RIK5MCsL1cuuuqrB/L6iIRM5Y0KR9Uf7ju+5cdfSmLRQVie6OlEb8At
         SKJIr2eGfJHL0QaLQwl+2MiLFWKcHomakDggYnfLvX0O9zqRu9BVKxQpze71BVoigkby
         9x2EeKMlmMkMiCoWI3OL1bUyCRRmJWHu+PThMRrAtapczbxv+XY9H2FSFzhaTfEFDUQB
         G1rIOtoBOjtR8j1s87U9jXL/zfOJDOzpMF5dKxoeoBEfi16BX4wN6R+dtT4E+RKYi8Nc
         +vuPfPrtr2gCTW3G98j5D4u5FbFTBKIOBVtQ9GEHy7pxdpQU/had2vNUSvVr/M15tWV6
         NfVA==
X-Gm-Message-State: AOAM530iiGOZNPxlxqcCj15y0rMiDhHrMRKR5cVKfMCVuDg5PAlapLRi
        YLVb2w90ZRRkE0AXTMErGAM=
X-Google-Smtp-Source: ABdhPJzL0eDkXCbFY6rkISzDtHZ8674iDU2OWn1mphdzKQERD2iJuHbptDQuf4Brr0rJp8/htPELXg==
X-Received: by 2002:a37:b502:0:b0:69a:ca1:298 with SMTP id e2-20020a37b502000000b0069a0ca10298mr11469168qkf.133.1650423950492;
        Tue, 19 Apr 2022 20:05:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm1157252qta.75.2022.04.19.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:05:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] remoteproc: qcom: using pm_runtime_resume_and_get to simplify the code
Date:   Wed, 20 Apr 2022 03:05:11 +0000
Message-Id: <20220420030511.2575880-1-chi.minghao@zte.com.cn>
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
 drivers/remoteproc/qcom_wcnss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 9a223d394087..2c471c763b5b 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -228,11 +228,9 @@ static int wcnss_start(struct rproc *rproc)
 
 	for (i = 0; i < wcnss->num_pds; i++) {
 		dev_pm_genpd_set_performance_state(wcnss->pds[i], INT_MAX);
-		ret = pm_runtime_get_sync(wcnss->pds[i]);
-		if (ret < 0) {
-			pm_runtime_put_noidle(wcnss->pds[i]);
+		ret = pm_runtime_resume_and_get(wcnss->pds[i]);
+		if (ret < 0)
 			goto disable_pds;
-		}
 	}
 
 	ret = regulator_bulk_enable(wcnss->num_vregs, wcnss->vregs);
-- 
2.25.1


