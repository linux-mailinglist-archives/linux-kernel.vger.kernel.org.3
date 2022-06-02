Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8752D53B6A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiFBKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiFBKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:09:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A12ACB75;
        Thu,  2 Jun 2022 03:09:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y189so4332651pfy.10;
        Thu, 02 Jun 2022 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZ6/Z6SVP3bMPtYdo2xOBExwLeSKhpcPwADfzY2mUgY=;
        b=P5FCR1zQhkv9INLkzy3lndZ5Ngr++COfVc9slwwvBm25ElcacyrCRCkwPl/yYBgkse
         QLWQXjONaVbcru2/xA2KFlWSQ1GuaQM/8BDxojoouFNQ5KW2G4ZzIyaPA7UQC8Ut6Zkw
         vntH39nx/+ERaEmzk4cZou89XShrLblzjUbeVzI7cGMSTaTgbRA38eG/09DJBU4mo3Od
         G3dYUjP7qSLAbZOYy7NOuS/JO2LIsy9e/GPyu2XrG2TplhukfADg5Lfr1LX9b9TwQuhA
         OxQBnEC+BUCd8s0xFDBXL2IlPNwhFibkZloypUgR5qrphyWZl7ZY3k4uI3fFYRyVzufq
         Jm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZ6/Z6SVP3bMPtYdo2xOBExwLeSKhpcPwADfzY2mUgY=;
        b=sz+0HKuG6iqv+nLpPGvx7Ube8kEfGKNWeB5i4tx91+ANfBy9jZHmIu3rgdCJKQkr71
         nCHFVZ5mTr/heO5xkXp/E69c7qHhl9Dm2egKlSLxu9El4aICEIcNv+Maq+dk6R3gXvgt
         7E80andV+FQ4fW7Qkn7xMSe89pXUqQtXZNTHz2G21T2NzpgxETKCCS+qg8O/aRi0r7Ng
         zwqKk5DhSI/E29NsXg8V23cofwraxggw+g5iYCZYWjjBHL4lfURhM4vWgYe1K2foi6Wn
         U1OIyIcUn7rkTRr4tfXJXpfKnCWHK1I+038ixyZ1+ui+08bnkia1FIrftwn+qILmMBtc
         s5Mw==
X-Gm-Message-State: AOAM532rqA+ETwLslosuFNbUboiaUq/KBMWk7oIeoJo1HkuVHB17cwg1
        YwdBpdt/sKWXn9HH6F870Oc=
X-Google-Smtp-Source: ABdhPJzX/B0PymPJ6LOZrim7NUPUOa8ufP/MgHJ+xiejOiQd2HS1yPsjx5eEhnehi4N3IZ3OyEPu1w==
X-Received: by 2002:a65:6e42:0:b0:3f2:78fd:da9b with SMTP id be2-20020a656e42000000b003f278fdda9bmr3561664pgb.297.1654164595554;
        Thu, 02 Jun 2022 03:09:55 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l5-20020a170902d34500b0015ef27092aasm3084364plk.190.2022.06.02.03.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:09:55 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [RESEND PATCH] cpuidle: qcom_spm: Fix missing put_device() call in spm_cpuidle_register
Date:   Thu,  2 Jun 2022 14:09:36 +0400
Message-Id: <20220602100936.41174-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling paths.

Fixes: 60f3692 ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Link: https://lore.kernel.org/all/20211230114203.13467-1-linmq006@gmail.com
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index beedf22cbe78..c734f914b616 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -107,12 +107,16 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	data = devm_kzalloc(cpuidle_dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		put_device(&pdev->dev);
 		return -ENOMEM;
+	}
 
 	data->spm = dev_get_drvdata(&pdev->dev);
-	if (!data->spm)
+	if (!data->spm) {
+		put_device(&pdev->dev);
 		return -EINVAL;
+	}
 
 	data->cpuidle_driver = qcom_spm_idle_driver;
 	data->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
-- 
2.25.1

