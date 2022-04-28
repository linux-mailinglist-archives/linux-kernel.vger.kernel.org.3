Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF21512BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbiD1GtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbiD1GtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:49:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D729858A;
        Wed, 27 Apr 2022 23:45:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n185so2962312qke.5;
        Wed, 27 Apr 2022 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozQAvh/QxaKIiwy4471nIibPkTSEzJozNZp0wEk64nc=;
        b=LNZxey5sG/qnatBJx58qWzgHNkysC7SndnATolVVS08YKZvpglIOIuRnvE6oqscvpV
         8K62hhNOkYOpuz9EBNiz3/iP3G+FkCTP+Miys6fk2eJy5h1YgUUMmN57RYTcKC/CR6LS
         7opm1S5PD9PbdQ4utoal2UUS/txisW3dKsZxzHoLhho9jZM2H3dJdMw2tvvC4g67HrIK
         E1ZmsEipY/jeZnwRNnlvNTgd0jsjbeoe+wunLITJb0hFG44lVzbrdFV8+XTLPkSOLgtW
         Rzt++o5bAf2U5sgmcPhYgFWwOkfYpaCcmhw9ZLYxDWihOEPi6r5Z9Ve6fTksPUmP40V7
         9aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozQAvh/QxaKIiwy4471nIibPkTSEzJozNZp0wEk64nc=;
        b=Nxiww1HTrTkMKNDlAyIcgRDo6VoeZiiwyeSaqAoTFX/i5RJl5HSVcXQdPMaw7NT2Wo
         dM5ilQXQqnxRw0/mCDCBJfJTTW+7v19bhvEGNyGvENof0ezAj4p/9HPSvkkArF1QebtJ
         4+XT2BrqQNfRawee5NbjowFqTFn7OEcAtayRfprysA9XQoumZLmaoqmq0zOoHChQFCtg
         ubGsL2M4Mx7zOa1D/w7FjoJV0Mph9Ewf+7zGhIYUaf4prOSrY2kTn5R05k8FBw1JRngk
         oNrHqv+3V0iD/Elioak6vtnGKZ4XINCH8fSex5AJO72dDmq1IuXw2uRBGEfFa++nf/IU
         VRkg==
X-Gm-Message-State: AOAM533fUkJE9vkyA4FJygxMuy6YDvBt3hVA+847S4vJe4vK4e9YIrhz
        Ocvf6c5/ENHRqTTDfCA4QpY=
X-Google-Smtp-Source: ABdhPJze+I/OAY2J8r4P2DbZki/nDfefrL+rDDVv+p/+5yO1DB8UCQ4mTP/YCUhjUX+5emcvEtV44g==
X-Received: by 2002:a37:9c8b:0:b0:69f:8793:f2ef with SMTP id f133-20020a379c8b000000b0069f8793f2efmr6035949qke.300.1651128351916;
        Wed, 27 Apr 2022 23:45:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b0069f6ab15281sm5653195qkn.52.2022.04.27.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 23:45:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] remoteproc: qcom: using pm_runtime_resume_and_get to simplify the code
Date:   Thu, 28 Apr 2022 06:45:45 +0000
Message-Id: <20220428064545.3850057-1-ran.jianping@zte.com.cn>
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

From: ran jianping <ran.jianping@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 2f3b9f54251e..366e1d4a839a 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -175,9 +175,8 @@ static int qcom_rproc_pds_enable(struct qcom_adsp *adsp, struct device **pds,
 
 	for (i = 0; i < pd_count; i++) {
 		dev_pm_genpd_set_performance_state(pds[i], INT_MAX);
-		ret = pm_runtime_get_sync(pds[i]);
+		ret = pm_runtime_resume_and_get(pds[i])
 		if (ret < 0) {
-			pm_runtime_put_noidle(pds[i]);
 			dev_pm_genpd_set_performance_state(pds[i], 0);
 			goto unroll_pd_votes;
 		}
-- 
2.25.1

