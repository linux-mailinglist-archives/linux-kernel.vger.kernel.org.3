Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7238C4E890F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiC0RBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiC0RBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:01:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A035865
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:59:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p189so7077420wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9yOef5SF2ptXbZCon6US9rM+lNuvu/cG2d6ltNWSnc=;
        b=577AsB00T7qdRNLEEMs8//vnIYxsdavNMPva+BkPV2I+/A/yzujMl9Gp5VbrFV+QvR
         RbCwZUU93h6R1QcsevXhSaKmFNvZXTAo7N8C6FORPu1KvwS2ntqcyQnzCHikUmF4flHv
         m13HVh3SiZYoUEbTdpB3dA5QM6h3f1nDkd1sq1dprATygmXLhSqSsGygsQS0DPHozJ0X
         SkV6T6TvByKSxzwemnh/wMIesK8eWXclrWl8vPa9wYoDm2qOplMs8PDKakRmSgCzwxky
         rDrfM7ZxlytwdJk0H2UKLmp99kQ6AetcYBkCoLAmGRat6CPvbPaPMyEYHo6FUmtb3xZK
         qYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9yOef5SF2ptXbZCon6US9rM+lNuvu/cG2d6ltNWSnc=;
        b=Qj1aoW4Tmp/pxAyf8XIvCpcmhTeRXlONlnorW1mJKAiblUGqWQf68aWt2ECDTFoUSO
         5ifmpa0jpug8gS+AhPIuNv8UmqTXFuiSYmBk1fMcomn7B6YwCcHmgFCIVQf31l+dtbbI
         x+U36as4/GnZ/G/Xq+h+RGzsEm+xcSOaQu1nB43RF+NL/tQxEXU/DK2Q89a/hayxstOo
         +TiNISFaaEiBdKp7/qerCI6JtuD5UdTSXbTuOz4Cp0oXHm0+IfkVDUNS/fhRKgVz0Ou0
         gYMyRsgb3E9knGMTwssPoNR6GhdJUwXtTe6IEGgfNviFMM5kjHYRj3GJFaza/Toa/K3h
         OYpw==
X-Gm-Message-State: AOAM532jrrriiOL6sMSuLKM95vLF9TtN/OChyyBBuFsBsB+baxJgpK0k
        R9zAhxlwzAMnEFGJq9MHgV7nSQ==
X-Google-Smtp-Source: ABdhPJy7xMQGyH/VkEQ2uAxTzSUTciloFVj6v1JtIaiyTf0GIpXD8gOEL3HxjHl5QzGgt90Tu5CZ5w==
X-Received: by 2002:a05:600c:2e45:b0:38c:8854:252f with SMTP id q5-20020a05600c2e4500b0038c8854252fmr29983615wmf.78.1648400379964;
        Sun, 27 Mar 2022 09:59:39 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm9979423wmz.43.2022.03.27.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:59:39 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: defconfig: enable MT6359 regulator driver
Date:   Sun, 27 Mar 2022 18:58:36 +0200
Message-Id: <20220327165837.3048639-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327165837.3048639-1-fparent@baylibre.com>
References: <20220327165837.3048639-1-fparent@baylibre.com>
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

