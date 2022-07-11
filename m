Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3C570066
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiGKL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGKLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC7D2DC3;
        Mon, 11 Jul 2022 03:59:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3244138wma.2;
        Mon, 11 Jul 2022 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WXgRMiTgqX2tD7jS3P4TsuHzbPBo1GBlNVC43Q1FzA=;
        b=c0SJ96FyIgA3bG8QIM/DKh5ta5UOPEn7He0+XWqiR9VJ4EX2VKOamCHGmCW/XPxVo5
         zzqbo67VmKUH4VDUa5nk9xGGsjuQyI+oqyXzZxcvoAnW8/PXHP/lACcwL5+NNkbQWkMt
         w4yKGpNDlfkBFl5Njz0YWJcrpF9jTljlhXzN15ESTlFIykzV6zFk1gKMb9DVSGnECqV4
         O9ojp/MfBi1//pYxPu443K27AuI0+m1zzFiT0v2seFrFv5L8oHgiI5QKEpFojfO9uWDp
         PK//dyPDcwvJGpY7snd/P3RdE6qquwKQNaWLGDCnw/7s8zUH8zIvA+ZJSwatsttd2fhO
         fefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WXgRMiTgqX2tD7jS3P4TsuHzbPBo1GBlNVC43Q1FzA=;
        b=AdT3W9V+ctkb7cT8NM+/ent1PrNCTMqZe2DVrQma3Re45CbvJQUvhE4T69c0A3wMSn
         n2ZZ3cO47Vtsu8P2IXh1chHCh9bd7kqxjj2wNktrwP+iaB1uiiB/gRUdc/GOw1oF4Opt
         T1e2d0M2VTTPTvbYxwCx3AEFqQpv57ZdKg5EGOf44vzkW+JncpWhkhlw86iV3Ku/Ny0a
         XUiOkWkyF31yGFbON3VEfNQUxsxYT+yt+UyrPkgPJPxNkoD+FkZru4qjiM+RFlxnpbSp
         w8CA/+fZpWWdYfw7Ds4+n3gngzzAO3RivIKsiytNxHHjMXA0dC9XNe8cV0nCkN35zn00
         wR6g==
X-Gm-Message-State: AJIora9Qwev8jiOm9msDqsEwXCROdszy4BVGEBIwwmPiofRq5tZprRFN
        EVUt+OLvWBTQxaIQ9NRnqDs=
X-Google-Smtp-Source: AGRyM1vVjxI4kVIK5pzYUOyy8Fsue0YMtmtqN9DKtWECAV/LTUwlPoLPdujT1Irz1r38cdT8KKsXwA==
X-Received: by 2002:a05:600c:1d83:b0:3a2:e9c6:69c5 with SMTP id p3-20020a05600c1d8300b003a2e9c669c5mr1712528wms.171.1657537175532;
        Mon, 11 Jul 2022 03:59:35 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm6504617wmc.16.2022.07.11.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:59:35 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 3/4] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock support
Date:   Mon, 11 Jul 2022 12:59:30 +0200
Message-Id: <20220711105931.43164-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711105931.43164-1-robimarko@gmail.com>
References: <20220711105931.43164-1-robimarko@gmail.com>
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

IPQ8074 has the APSS clock controller utilizing the same register space as
the APCS, so provide access to the APSS utilizing a child device like
IPQ6018.

IPQ6018 and IPQ8074 use the same controller and driver, so just utilize
IPQ6018 match data for IPQ8074.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v7:
* Dont max_register modifications
* Drop custom IPQ8074 match data and use IPQ6018 one as they share the
controller and driver

Changes in v5:
* Use lower case hex for max_register
* Update the APSS clock name to match the new one without commas
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 80a54d81412e..f1f0e87a79e6 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -142,7 +142,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 /* .data is the offset of the ipc register within the global block */
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
-	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
-- 
2.36.1

