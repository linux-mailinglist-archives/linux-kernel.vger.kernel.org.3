Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33C4E89EB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiC0UFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiC0UFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:05:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD491262C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:04:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a1so17548805wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COTgShTCyiLMlrNxlE0qokNd1oeay237G4xLk0WvIG4=;
        b=0G3YzXqRJnkfwb35aCQOr+CPJPvnqIj5UuFMosD2KmCv35abDqrRq5soYe3rD9ooVH
         aSLVvnpPxW1zwA1dxspdKJ80AvG0BzgF51O4oZcpJOyYQzvltAWR3m51oOdo+bqQm32B
         97AYMt1b1foMgbqtpKVff9vO2di/+9nPVdF6T9EFePqjkrb1l2rELSifw7HCwW/qQ6xr
         earJwPfkbQlHHzaF3PatkXd5G9DRd2FGRdzir39is015ZfErsjEah9s73S5htrdZWA25
         MfmqIKa4r1JkilvfYx2r9OvQLUnVpr+L1wjFXZ86KgOVcGmeTSDCtJ3iBX//m/0tRgwP
         hQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COTgShTCyiLMlrNxlE0qokNd1oeay237G4xLk0WvIG4=;
        b=k/MoS5x3U14UsWpGfcxaK0viUG5CBo5adazWFeljgKErKgtoHILaGZ5JbI7NRR2V/6
         w4cs8XlKqqS+sCFP5ckVNN0Wf9XVigkMkcDv3NKuWZRMeoTFhFZLWz73JmwIHwhSXSzD
         ichsT8BAcEeKJkYKFXcmA/8BSDupcRU9bdO/C2l9tApdpL9olCqaMonHIQNBRI5FfuiA
         XT7AUhjwWAJg8Q5FsjMXjQk9IZX5TYRamtGMDI5SZqEX4uLDuUt+pdM5HXdlrr22/ik2
         r72VXs1N8mymgSVxqLqEsr21asGOiGL6yNowwh/YMFGrbrVA3IXhBubYBwhtVb9V+8ou
         Ve8A==
X-Gm-Message-State: AOAM532joeqlyr5yWhHPO1+pcDrcAxYWFBK/uDpqeWZF7gfx1zt8cFgf
        JnonUUyvBOkx/VsqZqbwH1Ochg==
X-Google-Smtp-Source: ABdhPJzQr5nbLF6xvrTrP3vgxvxOVv1+Ha36WIlWzt0zZzQsS2CCsnvGHNNoYCTzoP1mVxhh1NQPPQ==
X-Received: by 2002:adf:ba8f:0:b0:1e9:4afb:179b with SMTP id p15-20020adfba8f000000b001e94afb179bmr18925947wrg.57.1648411439935;
        Sun, 27 Mar 2022 13:03:59 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0038d06cc21b2sm1354555wmg.35.2022.03.27.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 13:03:59 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: defconfig: enable MT6359 regulator driver
Date:   Sun, 27 Mar 2022 22:03:11 +0200
Message-Id: <20220327200312.3090515-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327200312.3090515-1-fparent@baylibre.com>
References: <20220327200312.3090515-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC regulators are essentials to be able to
boot MediaTek MT8195 based boards to userspace.
Like the other MediaTek PMIC regulator driver,
let's enable as well the one for the MT6359 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: no changes

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 50aa3d75ab4f..1e521f17cb39 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -644,6 +644,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6358=y
+CONFIG_REGULATOR_MT6359=y
 CONFIG_REGULATOR_MT6397=y
 CONFIG_REGULATOR_PCA9450=y
 CONFIG_REGULATOR_PF8X00=y
-- 
2.35.1

