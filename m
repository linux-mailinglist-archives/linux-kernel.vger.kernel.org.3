Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A04A760E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbiBBQhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiBBQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:37:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072AC061714;
        Wed,  2 Feb 2022 08:37:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id me13so67466785ejb.12;
        Wed, 02 Feb 2022 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cd2L7uJjqX5X65ANfXGFgzVTnafQ2XhujK8sHBCfjuk=;
        b=SRa8Io2MbRzk3l5SK9isqBAaRwOJc8Lms8I0mHmPtJzBhhrio5x2R1NTl50VfftL5i
         wtZavavJmWgy37uwUClyHPoC+KmvVKr2ow002HwiK5UvTdwmIBdqOymwIaTMuwORSJHx
         WgcRS/Wp8yOVxfbLNvV1Ikf1dtZyMeLYSxpeWqPFKTF85VY9yZUA2iiDkVuFMtfflpV/
         ZNqs0F+e10o96wz9lfIMMFAgIJxZrF4CiVHQLZIIs5c1hdxE8cFZMVY5mmXOLy4LQM3N
         KQQN6NqlX2OUKlvJme5z6msZ9HBTQujNrjQd3DVjRhmrKINPZRUla2sRzS+fNov8GP+v
         vOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cd2L7uJjqX5X65ANfXGFgzVTnafQ2XhujK8sHBCfjuk=;
        b=iRGW75rPQDCEwTcAdC88NZvXRmW+eGJ+crVlRyxywQ54zqv0MIPVXZBLoW+C3J847h
         ASK7ShSooIGqhep8NdBMPT91TYo0aViQ//GAGpjcvfg8chPFwnNSqGmjH7nIh1LKuIJX
         ozWSQY1idNXv21UY+a85XCqYIblL0+KRK05i3wzhWYEopJ7cohqqwVjrCdj+iuzkdz6f
         IWNFCu5zPIQdau0Ivpf1XVK/TEDY7/7Wy2YvAOfreTyC6w8FR87oCAvDL0OwKQfZ+gnM
         j5xa4kYk/PyRWx5MKu9LgRgvOIsXcq7Gfti2UzUNpx3us54LfSN1VVV8NrbIAMukzmEN
         EdSA==
X-Gm-Message-State: AOAM531wo3pLSBNl9xe935IBUqqEG98DU5b59jCLj7Gg4Y+zOXNcDqC6
        s2ru7ONjUSya+biIVbruJcY=
X-Google-Smtp-Source: ABdhPJy1r4v5P6yPdGmqIX4qx7EFiacE68y8GIyjMzqFVYw5OA2PnEyoN79TNPqHpQWIFetOU5hgPA==
X-Received: by 2002:a17:906:7712:: with SMTP id q18mr21712684ejm.434.1643819824755;
        Wed, 02 Feb 2022 08:37:04 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id w22sm8282605ejc.137.2022.02.02.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:37:04 -0800 (PST)
From:   =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: [PATCH 3/3] ARM: defconfig: add smb347 charger driver for p4note
Date:   Wed,  2 Feb 2022 17:34:17 +0100
Message-Id: <aba0d1ffe6a34ed09022cb8ea6e780b01b7d70c0.1643757744.git.martin.juecker@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5d15937b6a7c4ae82a8f0d164fa28a4d4ad46325.1643757744.git.martin.juecker@gmail.com>
References: <5d15937b6a7c4ae82a8f0d164fa28a4d4ad46325.1643757744.git.martin.juecker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Summit SMB347 charger has been added to the p4note device tree,
enable the driver in exynos and multi_v7 defconfigs.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 arch/arm/configs/exynos_defconfig   | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c58877cfdc9d..9d3191de96b6 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -159,6 +159,7 @@ CONFIG_CHARGER_MAX14577=y
 CONFIG_CHARGER_MAX77693=y
 CONFIG_CHARGER_MAX8997=y
 CONFIG_CHARGER_MAX8998=y
+CONFIG_CHARGER_SMB347=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_NTC_THERMISTOR=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1c2c3e9f0e05..bfbcb57e2083 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -510,6 +510,7 @@ CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_MAX8997=m
 CONFIG_CHARGER_MAX8998=m
+CONFIG_CHARGER_SMB347=m
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ASPEED=m
-- 
2.25.1

