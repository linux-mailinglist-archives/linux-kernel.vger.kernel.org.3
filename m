Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C759B4C83C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiCAGPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiCAGPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:15:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96049938;
        Mon, 28 Feb 2022 22:14:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so1313901pjw.5;
        Mon, 28 Feb 2022 22:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PH1beb/z1ahch6wzT25gnsAtYDGOM8+pvUYjPY/TxPU=;
        b=Ji/Kr0+XMyq6YybkY8r0kkCbklCqbzx1HBoKKROO/QrZrd7ON1mXhg6qDBAQsQdJVG
         q6lHVxQbolqcqib660su51YX7c+aWaoeAoTVAZ/5O4TtX77BthmawBqf5aii29Vqz4aP
         p0zGYw/mom4KUjW+mf/EURQtLSTX90Lv5WYHhScL8Bg7LfM2KTfexOA8AGDa78WB9A9U
         RYixcx3Li+fFJyvHKSuKhTyixNi2uLVfgPP97qblBlm+VaT0+DTnEK25ySp10MFPN5Ji
         66sv0Nkyxwu+c2z3BaGBNSh6ijats42Zw244fUhe60kRag0SyBBFN1Xr83hcGJWVXuQg
         H+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PH1beb/z1ahch6wzT25gnsAtYDGOM8+pvUYjPY/TxPU=;
        b=FNAL6gSklrait14PPSbBzhrYnuJoTyRPf6hqrpImIQpTt9jPGTafucfjzsziAhXwrO
         qlLI+ZLfaVLWBRudBm/3tx5vzqC/IM/dYT4S23NXoAnMqW37bybIOmQu80nG2CvjZlDm
         Me3AhY5b5GDVCtqwMllc74bQeNNd1RV2Z03aNx0+QvhE2RnpJ8KZm8TtajLmk8u3uvRK
         R4ZCjOrJppQVm20CXkvA/V93ftqerodYGqFRwotUmKIinxAP/eNT+jl0PunSSlyRcXpa
         64/cc64AYS7OCPYKxOkYPw7VFa/BeeDrOKASCrQ6WmJNz4mqMDBQXtagORrGQP/tCGCq
         5IKQ==
X-Gm-Message-State: AOAM532ApJxUxW/8r40Ly8wlwEVg6vNKbQLuDuZCIsJ2kL+Xfp5E3XpW
        4JF7R6OauKiV0KMO9f570sh5h51Vc5jlwSYykv8=
X-Google-Smtp-Source: ABdhPJwe2XwQj1/qqfwMVxlcczTF/DleUEyrIFi+5vVHSL0lyezr9cUT5DUPoXDMwseKl3j1rudLKw==
X-Received: by 2002:a17:903:2285:b0:151:4b38:298e with SMTP id b5-20020a170903228500b001514b38298emr14222632plh.36.1646115273033;
        Mon, 28 Feb 2022 22:14:33 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a17090b090a00b001bc8405bd55sm1024741pjb.30.2022.02.28.22.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:14:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] slimbus: qcom:  Fix IRQ check in qcom_slim_probe
Date:   Tue,  1 Mar 2022 06:14:21 +0000
Message-Id: <20220301061421.14366-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <239c3b32-6754-02ba-6bfd-7f05fa2adfed@linux.intel.com>
References: <239c3b32-6754-02ba-6bfd-7f05fa2adfed@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns non-zero IRQ number on success,
negative error number on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- use more precise expression in commit message.
---
 drivers/slimbus/qcom-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index f04b961b96cd..ec58091fc948 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -510,9 +510,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	}
 
 	ctrl->irq = platform_get_irq(pdev, 0);
-	if (!ctrl->irq) {
+	if (ctrl->irq < 0) {
 		dev_err(&pdev->dev, "no slimbus IRQ\n");
-		return -ENODEV;
+		return ctrl->irq;
 	}
 
 	sctrl = &ctrl->ctrl;
-- 
2.17.1

