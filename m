Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2E4C92BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiCASPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiCASPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:15:09 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82013B55C;
        Tue,  1 Mar 2022 10:14:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c9so14155008pll.0;
        Tue, 01 Mar 2022 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvTC2gtVVCd0mSMj/05A70ERgumEKKzDpQ3v91EDxU=;
        b=E99TwnvlKE/+7dUSA3mRBfKLigkbHMEyKGiIFON9RFsGy7JE8QN0Mi4OzPWMQfecyn
         wgPUZaTmRNtfp7gWGB9VJfKM6ID1M3qvNqDTe6bIDy/Sh1D3Blmn2arUKVYDzNoAoXTk
         Ul/ReWtWMX0C2poeSFVFE0eciaMDps12A7addFitTmNyaCThq1t+Qtt/wkM8GT4nGGFF
         lm4QVyI2CdQyOydBQ+3HAPruYoiTVxYvuIn2S35NItAg1d43gAg2InX+7V8Br5sqUi6q
         IPaxpNslz7VlkATBmnHsNk9cDsUNP+Stt1y2ZeKPmxRmjPkfeJ+EvSOvsBsbRCZB3r6F
         d+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvTC2gtVVCd0mSMj/05A70ERgumEKKzDpQ3v91EDxU=;
        b=G6i2X8uFLrLYgJXXAFEYDmg7LIIplFtG+6Bb9n+2QZ9Vk00dBX9J3tzsz/G3l/cHuQ
         RmCAqFcFhSpD8QNoFvg8Hz+m0rnNZuWSpLqHcUROGjjfO8Oajsy8PFmZ6uERoaupfZDm
         YJK8Iceo7ovTst1xUi+JB282Its4Qwclu2G/icxqtG/ivL2cb4CBmQT981qqViMzvuXd
         VyeVbz8DNCJaB+ugHbDMTjES9K7x+QRAV3ne26Rhb37ANtwrQoBA6OBYppdlrk4nKWJk
         pQb6UnUILMXn9d/MIuoaX1SUz69sMaaWoRQY61EMFIz4I+UP+XO4nOj+OZuVV4gH+NUN
         mD2g==
X-Gm-Message-State: AOAM530UqiZLX61JlP83fI0EDQocLrjwWES3gQkeMrtDdNA7LxVdvdvZ
        /7aTLQ8DjMicE5GADDjPZtS/ikGJaB0=
X-Google-Smtp-Source: ABdhPJzc0UxlELQq13kNnMa9jGVAQVr/GQ7RbeXIWJxryqFAGNMBWJU1MXCH2G6jIUykSJzO1WAL+A==
X-Received: by 2002:a17:902:b189:b0:14d:6f87:7c25 with SMTP id s9-20020a170902b18900b0014d6f877c25mr27403123plr.31.1646158456915;
        Tue, 01 Mar 2022 10:14:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm18773821pfv.49.2022.03.01.10.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:14:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH RESEND] thermal: brcmstb_thermal: Interrupt is optional
Date:   Tue,  1 Mar 2022 10:14:12 -0800
Message-Id: <20220301181412.2008044-1-f.fainelli@gmail.com>
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

Utilize platform_get_irq_optional() to silence these messages:

brcmstb_thermal a581500.thermal: IRQ index 0 not found

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 8df5edef1ded..0cedb8b4f00a 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -351,7 +351,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	priv->thermal = thermal;
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						brcmstb_tmon_irq_thread,
-- 
2.25.1

