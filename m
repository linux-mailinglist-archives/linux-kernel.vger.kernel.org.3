Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46434507F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359254AbiDTDI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359219AbiDTDH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:07:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55E393FA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:04:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i14so438637qvk.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lB8BBizelOBxUY2qv4ST0PrKLXMyNa9DnyNjkNLjmec=;
        b=mcy+8bJ87Z1l9XR9HkNwLxGZ2d01t/zLaFzmkL9u+V4+NTMaTgs/UOqd+4QMo7ic5L
         EYJdaw5EuIMuj/mlno8UafIv6PpPUdLJy8Tv9mFhboZDBbZf82gaYQyNoDLHj6nVLZRz
         uqL87jpEvsJpeJ0UIBkLowFYgEjBTYVt+h/CaOsshOxFb7j/f6ea/hdw+FzQHjnpkVu+
         J1+3TqNXrZbJm1JtY/N2FmcsiGCopI+Tu0+1poJPQDlymb8SQa2F690vpaR7i161LFD2
         PnAvlWnyhvUbEUXNLN3ehGRuHfr6pAuUM9ceJhXHQvPOJJ8cUCgcV8yYgXnFvTrn2h19
         0YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lB8BBizelOBxUY2qv4ST0PrKLXMyNa9DnyNjkNLjmec=;
        b=DyTq2in3mzXkSsmBOd3f3cKY6l/Xz+/tZkiZT0cVqOpr31Crl/aD1DMNCrxnvHdTO1
         UJkrjI9mq2dZ3upnVOTqkmxAJkwZeJwcwOecIBpxFSq934y43QNyfBe62Jc6nDo8kBKQ
         /FADW9lqVby4a3CB8/oLqNem/EMoWcP8DdLsewJUjibMRQVIesoSXK8oLdSklRAIWVex
         bRfsxY0oFkXjYCCHcaLIQefSMcpdY6mmhWBeizURWZszjrZGjpQWI9z2kxx69HVQoN8p
         XBRMD3hX5M41eN73Y6AJKC9qbYZZZiA/ym0F0A+0+8Gn4G69xIoNlh1R2wmhXlptFC+r
         FXfw==
X-Gm-Message-State: AOAM530GdpwybvCC59QkM56cax0FklVDA54/Xu1CyJ9WpIM8cHs5M7hu
        U7tXC4z7htKoekJCDZwfLZM=
X-Google-Smtp-Source: ABdhPJyJwovdSHHmviYSU+xbTbk8rPDBT8hoeRFAFiOmmlTco6MShhHIWqg6Rr+19MxApe+oSfiDIQ==
X-Received: by 2002:ad4:5c45:0:b0:446:5af6:7706 with SMTP id a5-20020ad45c45000000b004465af67706mr9583174qva.112.1650423885729;
        Tue, 19 Apr 2022 20:04:45 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e13-20020a05620a12cd00b0069e908ab48dsm898490qkl.106.2022.04.19.20.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:04:45 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: img-spdif-out: using pm_runtime_resume_and_get to simplify the code
Date:   Wed, 20 Apr 2022 03:04:39 +0000
Message-Id: <20220420030439.2575817-1-chi.minghao@zte.com.cn>
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
 sound/soc/img/img-spdif-out.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index c3189d9ff72f..f7062eba2611 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -362,11 +362,9 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 		if (ret)
 			goto err_pm_disable;
 	}
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
 		goto err_suspend;
-	}
 
 	img_spdif_out_writel(spdif, IMG_SPDIF_OUT_CTL_FS_MASK,
 			     IMG_SPDIF_OUT_CTL);
-- 
2.25.1


