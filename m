Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D24851CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiAELbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiAELbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:31:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A651AC061761;
        Wed,  5 Jan 2022 03:31:09 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t19so34933590pfg.9;
        Wed, 05 Jan 2022 03:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=66oKtQBJWcP3R2oSjIbdUHJLe2B+Ok04ztzTZ14ozJY=;
        b=iTjJFJ/pC1uamObrV/phXCXqspm8x8J+oUbdHjQxjmuwCGPa65S8XZf3mE/nZogJvH
         SMbeYB2FXkcGxwCXnXvVHadMEw5RP1PS3IuWMgxMtEtIQXq2sqZxJmeZWS2Swq3EWSfI
         N9eGvK365Gh4OYNPiIHizKiAIiSLhnfGmq9MvvKOxYbSy/KDbUE8E9lbiWZ6wPOeQAlJ
         flUOYvfn22ddSNWY541HnT2DNIjT3CGrTAJ2wXl+lDVgh/VNUIu84AnKeuPQLHdPYf1C
         U2MEsF42yo27vxdu0UkpocVsJR+D0e/Kz9siHJKd8Z7JndLx/oWZJSADqgPiVVG6f7+Y
         VyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=66oKtQBJWcP3R2oSjIbdUHJLe2B+Ok04ztzTZ14ozJY=;
        b=Mrh1tQsoRt8E369jmh/hwwnZZSwmKHaBHnLEFCXeZXCE2XE5JT3AYimr2F1IXw3yB3
         j/mMyLJQ6s/4M4UV3+NTt2T9MOoC3OX9hkV5WKSRK5UTIfVuXhIj4embSJGwIdxHmB3J
         D5aXrk7CPvcn4jeVMrKV+MhENLd4fLFSBMF2z6GxE50PnmdAilOZ0nVNq5KLG6gMbwOM
         hMXwEZ7O5p6bONUsWVb+2/bDfkUgXAvk8WvcZpuz/8OpNUgb0QR2c2AR8SpI29wFx03o
         9aN2GqospyIRju0dO53hj/UQ4WLaMLEUJcYAfbsKbNa21vDnpw0aWKrQbg3SCgBRQzjx
         67xg==
X-Gm-Message-State: AOAM532m0IOrf+NHX8UKQxep6i6RGNPuKeudUinc3zWwk38dEpUi3/ZZ
        MiWG0woSBUMuS91h2IvF82Q=
X-Google-Smtp-Source: ABdhPJyWlKRUUhbqI670/X0/OGjf06XnH1U9JnjKB4fTLiz98rI60u483wWbBAuk8N4PMMesSFV0ig==
X-Received: by 2002:aa7:973d:0:b0:4ba:70f9:14a0 with SMTP id k29-20020aa7973d000000b004ba70f914a0mr55010892pfg.37.1641382269213;
        Wed, 05 Jan 2022 03:31:09 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ko19sm1356860pjb.16.2022.01.05.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 03:31:09 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: st-hva: Fix PM disable depth imbalance in hva_hw_probe
Date:   Wed,  5 Jan 2022 11:31:03 +0000
Message-Id: <20220105113104.7783-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 57b2c06 ("[media] st-hva: multi-format video encoder V4L2 driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/platform/sti/hva/hva-hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/hva/hva-hw.c b/drivers/media/platform/sti/hva/hva-hw.c
index 15e8f83b1b56..bef880951921 100644
--- a/drivers/media/platform/sti/hva/hva-hw.c
+++ b/drivers/media/platform/sti/hva/hva-hw.c
@@ -406,7 +406,8 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 err_clk:
 	if (hva->clk)
 		clk_unprepare(hva->clk);
-
+disable_pm_runtime:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
-- 
2.17.1

