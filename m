Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA214A312C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352970AbiA2Rx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:53:56 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36204
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352753AbiA2Rxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:42 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D5913F1D9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478821;
        bh=veL6ZTddJGkmWO+v+Lus/eVk85DvsY9iBADvcny/2xo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DLouUQhikh5cRDDWpdHkHLVQxRxldX2Ay9iQTA6zCfq7Hxqb8w5mnrVmeK+mtn+gq
         iaVNa+bj/1BxtKLBurE57hM73R2Y3DhhtSfNAeHNS13GHHAslic69Eguapwa+IiRGZ
         dJSkyOu1TT81C5JiHhvfRzowrRlmSoGzeso0uCH3E1JtPhELegZQ3AEJX1LEvayr6a
         uYBw49TLoPo0lI64NC06549WQMNtieD15ohYf+G6L+kceaQAofNlE16C2A/4lLZup5
         3qNoJFd2MTdBjx2N1u8w5eQ3IiN1WgX++m+ekDzYQZV1l0QYdFNJNm32BWp8Wt86dL
         J1/X9+3hB+PQw==
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so4698045eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veL6ZTddJGkmWO+v+Lus/eVk85DvsY9iBADvcny/2xo=;
        b=SmzBflBX0YZD+IUC5NZT2esl3tjA428M69/8WFEFSdahPSgj9Va+LERqsBpH9Jef/H
         EaE33vpx8iKK8TSB4RWxl44NyT/ugO/SqPTfRZwt6o+H3nEsuubWH94Xg+JzN90cCoj2
         YiFwh4svU0LLEIZUwLScK3DpFsiJXegu7uqGLtP1mZ5zB5YGcwzdGd9KGaXgDkDGWbhI
         AhsJmiYrqer06rfVLe6clX9Ufr9TOnyqzheTDWhEFlx881JHL01Sa2BrIz6u91KRiMLa
         g6HSnJXWjAiWa7YgB0nFNTV5pyS5Le402N7WpidEIuQcjYnHCTVZeRZ/Ap/S5901RrRx
         bVBQ==
X-Gm-Message-State: AOAM531VmYhiJCylJ2vepI1IyIytZbF9VTBsYnyzbVSwh5FPMURhxMAy
        1OjrU/UeaulKJoNElVfzQgFvuSjWWNhbguOa48LEUPi+Iv46YYobI3YZqHU7nWrOJHDt98gM1oI
        qG+QSY3QDETjopPGHKZMXqEIp9lyL/go/tsNPyhsupw==
X-Received: by 2002:a17:907:7e9b:: with SMTP id qb27mr11137893ejc.524.1643478820797;
        Sat, 29 Jan 2022 09:53:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5CBLthMjPGZikxjz/GeJrdUwukf8hFoejvpxjbfEPDuwkf4B6TSZ0xs7lVYUf2VA3qmtYCA==
X-Received: by 2002:a17:907:7e9b:: with SMTP id qb27mr11137881ejc.524.1643478820636;
        Sat, 29 Jan 2022 09:53:40 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: serial: samsung_uart: Document Exynos5433 compatible
Date:   Sat, 29 Jan 2022 18:53:32 +0100
Message-Id: <20220129175332.298666-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Exynos5433 UART compatible, supported since commit
31ec77aca72e ("serial: samsung: Add the support for Exynos5433 SoC").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 2940afb874b3..6aceba4a5f79 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -26,6 +26,7 @@ properties:
           - samsung,s3c6400-uart
           - samsung,s5pv210-uart
           - samsung,exynos4210-uart
+          - samsung,exynos5433-uart
           - samsung,exynos850-uart
 
   reg:
@@ -111,6 +112,7 @@ allOf:
             enum:
               - apple,s5l-uart
               - samsung,exynos4210-uart
+              - samsung,exynos5433-uart
     then:
       properties:
         clocks:
-- 
2.32.0

