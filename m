Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF3A4A3054
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 16:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiA2Pmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 10:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiA2Pmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 10:42:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58607C061714;
        Sat, 29 Jan 2022 07:42:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h21so16679689wrb.8;
        Sat, 29 Jan 2022 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDfBcCV+jqICJ+umnEPyh0zc5fKOvTpA/0JLXbxrvaw=;
        b=YRADI/76mabaLf4IRcW+iUVwM4d5XalrfrM65rAgmDHXMgw/pREmSDXS1OlC0Bn00W
         BYD58D2rRkOkUXyYsmqT6UsbbLZOE49yI72y1wbyFYP0oh3pTbKX+whITxjx54FwHT54
         rcY0tfctVsXgFc046Jyzq7yoGgtWwTbIU696dGNvIju/PnrS7YBdaqlqkoPYwHqtF81b
         R1iPZVhdmnGJQ7jdzQtZ5/9vx/0mE9TN8rOW1bl1XyoPbB8TDqjnTKzxLbU4X7u477iX
         vPMAuxN69n3L4m0hkvoTRM62uivp3iH4vnoWcwG0fD8h4qMX1f3LOxV2lbFv7d4OCDJz
         deTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDfBcCV+jqICJ+umnEPyh0zc5fKOvTpA/0JLXbxrvaw=;
        b=65v84vvfhMZiFbGdFNVGk7U2glQBZ3sr05tujhyZqlkngnFBeOB17nUI6auldbKEpb
         TnxIayVz1vAGYHMZr4OB+TDt/St0UjP1RS88vTfvFMyYdvkU67ZbnQ4UHU3ffq6jIDDS
         ldD/+lWXkcm4ddsGwKjlUgaFO4dEMdXz7gsKrDT8zMXB5Zm7FtRYTnpF1GO+gJwZjMQx
         t/mxfbq9yoWG3LT8jWq+6ys9ruR4ley9Lh3857AKVTG9Rv4u7+iEb/04CXVpAmGzZpw/
         /RPsecADZmLInMME5Vj2SJpNzsoI66DD9C2WZofoddvCvdim//5Ob1V2XhHaQUin5BLV
         bkNA==
X-Gm-Message-State: AOAM532ZnZWEQ2N30E+kbtUstv1WNRhqxDIpN+9Sr5ykHPxlmkx7X/6q
        zowV0Pw3LcBFxGpxcBxeJ1M=
X-Google-Smtp-Source: ABdhPJzuryF9xXT+zqclTdu3vlK9c6QeyBNyyqPs6N9Gl6EC9RT7kbjuBw1I6Pf7pwGVHC/qP48VuA==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr11159990wrr.618.1643470963900;
        Sat, 29 Jan 2022 07:42:43 -0800 (PST)
Received: from pluto.desnull.home (84-236-21-114.pool.digikabel.hu. [84.236.21.114])
        by smtp.gmail.com with ESMTPSA id b11sm4478557wmq.46.2022.01.29.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 07:42:43 -0800 (PST)
From:   =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
Subject: [PATCH] Add ethernet0 alias in Nanopi NEO's device tree
Date:   Sat, 29 Jan 2022 16:42:14 +0100
Message-Id: <20220129154214.45629-1-baltazar.radics@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for U-Boot to generate a MAC address for it
automatically.
(Without this, the MAC address will be random on each boot.)

Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 9f33f6fae5..df71fab3cf 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -45,6 +45,10 @@
 / {
 	model = "FriendlyARM NanoPi NEO";
 	compatible = "friendlyarm,nanopi-neo", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+	};
 };
 
 &ehci0 {
-- 
2.35.1

