Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17812481BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhL3LmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhL3LmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:42:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B328C061574;
        Thu, 30 Dec 2021 03:42:09 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u16so18064622plg.9;
        Thu, 30 Dec 2021 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/2GJveFYsVaUlKyHZdp6crFhqF80gEKGhbqZmnuCaPw=;
        b=ejmeQXi5v7W71useZlfjfwzFxkxvM1kP7DwvtcTupW3abw6ntYvZSeCDvTvBfDr6rD
         J7n569pNY4TVJauADBeMO0a58S/TwG1GBs3ffyk+e8m5ZgE5CixUEZpdIzqFlXPG+bAH
         nk32QjcaPju2vdFe/OIih0/wNBavRPTrwWeFQljYboic3cktf0/Dtu0lrzIY2mvOobaa
         I6hLRhU+bYCGPvtw1Q6uTKBwp1d4MgqfDj0c3Q58aoPE6aMq4zFx3EnVJAmSaKTSX7Q6
         oHi+xCN/AsMQfPSADLHdrX6QRhAWTl5Vrm22Qr3ZwSUeafN/ENvg74hWt7qs/YjPUSwp
         ZFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/2GJveFYsVaUlKyHZdp6crFhqF80gEKGhbqZmnuCaPw=;
        b=nKz8xnhDF3VLuc3JF54ozUrT41sLORTHSh1mBRujIUihX4rUM32qI08IWxric7sAfS
         Hub1uoCLwlshlrWa+p1v/tgHAR72QCKJosLHeQZMwsO0K801r7xYqgd6VssXxm55fSun
         mdLhCQao+ST7LwcTbOiHYMDKcaqerp/wqCA5lI956u1n7c1jHv+6a26JwajfJn7ukpeK
         8VSKRgt3qWP5sQTxq1Wmh8Q99bvHxeOcja+3W9Bh0VMczltrAdAidBPO+BpRsXwHVJ+W
         Jsx+vYfBBGeBcUSZahZbf7BWGXQorDDUGs9NTNKu3EIbXniWXu1deJcth3eq86fEpdZX
         tAZg==
X-Gm-Message-State: AOAM531aNNy599FDtVZZ/caUXmMrFjeMoy9dlEvlHD8OdqtuE0P9fkdt
        x/po9kk9VcAqSulSJC/JWB8Mxb2/AttiKmPXCtw=
X-Google-Smtp-Source: ABdhPJz6MwEuYN2+6s3o7RaQLmfYGH7X11lcFjXo8ZW4cYY7etouGrgDssFxE12vtlb+FIrJSDflOg==
X-Received: by 2002:a17:902:ea0f:b0:149:3fdd:1090 with SMTP id s15-20020a170902ea0f00b001493fdd1090mr30038430plg.43.1640864528698;
        Thu, 30 Dec 2021 03:42:08 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id c9sm22932631pfc.61.2021.12.30.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 03:42:08 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: qcom_spm: Fix missing put_device() call in spm_cpuidle_register
Date:   Thu, 30 Dec 2021 11:42:03 +0000
Message-Id: <20211230114203.13467-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling paths.

Fixes: 60f3692 ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 01e77913a414..6638c1de90c3 100644
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
2.17.1

