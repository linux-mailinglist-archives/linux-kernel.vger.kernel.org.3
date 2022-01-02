Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35942482BC1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiABP5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 10:57:08 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34690
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232469AbiABP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 10:57:07 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EEEC43F175
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641139018;
        bh=A+kc5tjlYhkcgVbZnwxwk25Cyab3ia817LPKbVAH5v4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tRlA7sS1jrY1ej+eoYhkUJtf5aBNr/swK9zQpPzEcztgqT8mefpg4a2f7FYHuUVXO
         XrV8Xo6/JAMs0kYjZG/Pg0YOBFQqgz7aHrfD3102nJPBnc60pHUkPKVZGT1oqxfYuC
         vCl12IEDKVGF0qaqotVIQEpCdbqWLMhiJahjK7YBdgd18PeX7g/j1xgNt/G4rtsRK9
         laUm17bsRH3t6Xt21QBWlB/OcaDw0f7wj89QtK7fJF4y0pKNG/Jb2VZFmj4sNiD7gZ
         gOxSaK+pvduWL+ac+ElVZDD1P6g9ZO2/llcOd+XO+uiAmpWWh8G8mUOJZlXqZyG02r
         CWXytVk2Rh3zQ==
Received: by mail-lf1-f72.google.com with SMTP id m8-20020a0565120a8800b00425edb1a456so5901397lfu.16
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 07:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+kc5tjlYhkcgVbZnwxwk25Cyab3ia817LPKbVAH5v4=;
        b=n1I4Dy9XwMQnwzgXibXqRj/Df4wu8CNg2RS3HeaZStA/Dncmd163BrseSOG1Wbtk7u
         96HK8u94vT+CSOT47ZG++87SfBfFa7PfpImvEKiuTw+FvJpYPoTLj29prmfKVMHFpJf/
         6fcBg8tfjpQarLu+VIjDZln7zHf9oJJff+al8pJ9oliHrYQN+wBkbz0KD6LftXoIefFi
         oagcpTXBw6/4M97eGrBXAjvehrQBCZeDg87Pes+fsKHomD5EB2Hp4VyC7oT00XENnkZk
         PJXi8UvVE2F2nGb2ij66VSEHtW33HwEyG0Dd6SHX0tFBrHRY3DzfC1pA0+YSTclfgwhA
         vELw==
X-Gm-Message-State: AOAM531MukR81VIIHnNihPEi+jocfKOFAdb33NK17S3Hu1HkqqWvBqkE
        06c+iJTngax1zpJGAhAphf2eTYsiFnPhaRsFggN4mafl3SSt9WsluyhkB9JzvW9uBC0ngqhTt7s
        6LFsOZJs+NBIMl99eAOVa1GM4inHM98jWu/PVJT7Osg==
X-Received: by 2002:a05:6512:3b13:: with SMTP id f19mr37208592lfv.305.1641139018228;
        Sun, 02 Jan 2022 07:56:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmhRKwE5nQPF2pu8WTE2iWhPIheUcCjEwBbgtMiwC7AbFDHUGWTHzDvCXqDbhcAt4qNHiAHA==
X-Received: by 2002:a05:6512:3b13:: with SMTP id f19mr37208576lfv.305.1641139017947;
        Sun, 02 Jan 2022 07:56:57 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f5sm1383176lfc.132.2022.01.02.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 07:56:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] dt-bindings: gpio: samsung: drop unused bindings
Date:   Sun,  2 Jan 2022 16:56:53 +0100
Message-Id: <20220102155653.42165-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 6c56c6cd8031 ("gpio: samsung: Drop support for Exynos SoCs")
removed support for the Samsung Exynos SoC in lrgacy GPIO driver, since
it was moved to new pinctrl driver.  Remove old, unused bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/gpio/gpio-samsung.txt | 41 -------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
deleted file mode 100644
index 5375625e8cd2..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Samsung Exynos4 GPIO Controller
-
-Required properties:
-- compatible: Compatible property value should be "samsung,exynos4-gpio>".
-
-- reg: Physical base address of the controller and length of memory mapped
-  region.
-
-- #gpio-cells: Should be 4. The syntax of the gpio specifier used by client nodes
-  should be the following with values derived from the SoC user manual.
-     <[phandle of the gpio controller node]
-      [pin number within the gpio controller]
-      [mux function]
-      [flags and pull up/down]
-      [drive strength]>
-
-  Values for gpio specifier:
-  - Pin number: is a value between 0 to 7.
-  - Flags and Pull Up/Down: 0 - Pull Up/Down Disabled.
-                            1 - Pull Down Enabled.
-                            3 - Pull Up Enabled.
-          Bit 16 (0x00010000) - Input is active low.
-  - Drive Strength: 0 - 1x,
-                    1 - 3x,
-                    2 - 2x,
-                    3 - 4x
-
-- gpio-controller: Specifies that the node is a gpio controller.
-- #address-cells: should be 1.
-- #size-cells: should be 1.
-
-Example:
-
-	gpa0: gpio-controller@11400000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "samsung,exynos4-gpio";
-		reg = <0x11400000 0x20>;
-		#gpio-cells = <4>;
-		gpio-controller;
-	};
-- 
2.32.0

