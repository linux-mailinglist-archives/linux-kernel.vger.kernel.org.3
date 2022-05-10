Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816305212D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiEJK6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiEJK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:56:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86079186DE;
        Tue, 10 May 2022 03:50:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id iq10so15560899pjb.0;
        Tue, 10 May 2022 03:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keKvWn4skwJEPMKYt8IdlL6/BT3R30J+5SJ0HpwYsbQ=;
        b=TLnk/k5j02FJEO5ZPqpBonxx06Y7/UvAiW/xGg7q6jDc4KaST8vdQ4Q25FmZDW7WqS
         K21JUSYFOYIOaDVDu8Crv1GFf6zy50NK+HXnFNXGVzrtMNMmRzagXJyPgFPiTmZVNVnF
         ISDrXzbsIHZ2rUuFf223/A74htDcQlhsNa3n6kwhcIYwmAAgswojAC1Yt3VYNxO8LxUk
         DjJtOi7+StxGiXqQZ/YXFac2ZLfHy3capQgHv9yBLeg0/EESiyN7riHf17B425YTmYLv
         jvRi+TCDNVEMbPLbn5yzpD0flnwRAqRMNSAhx5yD9ODSrov1L6e4SAsW0c/JEA3zQ6hc
         nVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keKvWn4skwJEPMKYt8IdlL6/BT3R30J+5SJ0HpwYsbQ=;
        b=2n5DzpdLERo7heek0Og1DICFj4/KdLN17dLRSMB07ocmTtQ+g9siNuzogGLFTJZMgx
         6NvtWMFmpnjdTCpLVAYxW12jBycXax417po15XF/D5iLngzp1dQgyVPoCP0mkp6/qg/E
         dGbZbB26W4Ihnpfbt5eBPzgmE+r3JQ4z2LCJjWhaBt1/TeO3T8fGdYLP6Xd9h8sVLZh1
         R93YqPR2qJosyVgzvtBulnSA5s5TcVT2/EXq0ytxGQyiGhBQbEVhRVP1ie3ARIKRFDfE
         VmQkXxx5Y6CJpdiBpOmsBxIlfz+RoKThy2J47s9svYKXmVlYi9TSPPx/RKZwJdExMRfX
         zOSA==
X-Gm-Message-State: AOAM531D8XPKmX2dtoQQeFGYv04lNfRIRMU+StCfGve+uxd2ebCEfHOg
        SKOp2cTD/TIB5v7n3f6dX9MaIx/9eAQ=
X-Google-Smtp-Source: ABdhPJwcd9lTvldg1q7fXnHFTXYXLMY8RnJM+oKWHCngh5ehFgNLm1Af1QZ7z0E8AbSuNdsmwXc4sg==
X-Received: by 2002:a17:902:c602:b0:15f:2a36:ab03 with SMTP id r2-20020a170902c60200b0015f2a36ab03mr1396101plr.99.1652179842196;
        Tue, 10 May 2022 03:50:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090aab0200b001cd4c118b07sm1534895pjq.16.2022.05.10.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:50:41 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     corentin.chary@gmail.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] samsung-laptop: use kobj_to_dev()
Date:   Tue, 10 May 2022 10:50:38 +0000
Message-Id: <20220510105038.1351743-1-chi.minghao@zte.com.cn>
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

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/platform/x86/samsung-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 19f6b456234f..c187dcdf82f0 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1208,7 +1208,7 @@ static int __init samsung_backlight_init(struct samsung_laptop *samsung)
 static umode_t samsung_sysfs_is_visible(struct kobject *kobj,
 					struct attribute *attr, int idx)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct samsung_laptop *samsung = dev_get_drvdata(dev);
 	bool ok = true;
 
-- 
2.25.1


