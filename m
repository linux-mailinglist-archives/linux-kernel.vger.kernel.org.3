Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A221348035B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhL0SdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:33:08 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45334
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231721AbhL0SdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:33:03 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DF95C3F1B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640629979;
        bh=RFPGHmjdhJ/hloNRhgmml05wd4YHMhrSG+GgHjMTnJk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hbsNls55h7iHCHQKlGI0ce8CWrlK61baRNtu8ytzbBrlTT38GsL/9IAZC0nO/12KC
         5LVkT09qvGnq3i/4HZTnImGVNkVp6qJlNcGddU7a+4Ry+5Yn53pkaDRhsQZtrX4JxV
         y5NnorBgtAF7BgiHG19Vld7MzpyRyFZyJFj5fTk9ZA4PTY0hwqMMtd7ohyHFNHjA36
         J58/BbCd7IEWgOWDQh8a7faMtCktbKWIah7m5/LKLjMmB5BAOlzUsqlSsZiCfEZqLb
         WCV2yUlAkCcLmUpqa+KvqgaUs32BqBD3RrETwphVskQgIvMAecIhEiXXRvIATazx+m
         bLDXje5qSboZA==
Received: by mail-lj1-f199.google.com with SMTP id e7-20020a05651c090700b0022d70efe931so5285880ljq.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFPGHmjdhJ/hloNRhgmml05wd4YHMhrSG+GgHjMTnJk=;
        b=m2F25btDetRotrpCQxE/iGMLNLKhUt+qfZRRbeCaenZ3baA1cEnKVnQ9mYbwUdUXfu
         CJz5LOvKiH9Gw8et8FJV5mf5VllrAF/cJ/rtRY6GoPuHXaiQSX5hbrFgbAptS4vcj+WK
         6HstClk03Lt2PEhqTcX2m44SN96ap1IQ0PshEnsFn2E8B82Mh+fQTYR7yKK9WmHvl+YT
         vBDGVq+8QbeNw4HHtr2a5KPuOI+1MTlmkiIN2X4NL3vodb94xaBY6WDGz6I0skE9Fo/x
         vaadf7cWMZmEnxfUybYMEuFtHLqGSztB0weqGZRm+Qwx4cycfJ3kunCONrK+8SnsJ5EO
         wIBg==
X-Gm-Message-State: AOAM532EYPK9Oeoz9danomIkHjE+b52NaJ0VejltqXsPaoxW6QaYrwiH
        HHdMHicvdVmK1gyJlEKdbNy0Zrg5f9qOut7SAKvI7D5bC7afMqs6diS+64+ijAbDLBNHq0Nvhju
        3Q1KYP+OYkytIcncSN5Fnvr/CcQqeqzX3RQ8SmdktTQ==
X-Received: by 2002:a05:6512:168b:: with SMTP id bu11mr15627644lfb.401.1640629979254;
        Mon, 27 Dec 2021 10:32:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/Gt49kywYk1krG8CoXR3xfc8T8Tm6VqX8pnxg2OeXzFbjocvCOPPW2+Ds+ALgMTQuQ1xw9g==
X-Received: by 2002:a05:6512:168b:: with SMTP id bu11mr15627620lfb.401.1640629978994;
        Mon, 27 Dec 2021 10:32:58 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o12sm1299622ljc.5.2021.12.27.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:32:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: [PATCH 3/8] dt-bindings: rng: atmel,at91-trng: document sama7g5 TRNG
Date:   Mon, 27 Dec 2021 19:32:46 +0100
Message-Id: <20211227183251.132525-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatbile for Microchip sama7g5 TRNG.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/rng/atmel,at91-trng.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index 0324e863dab8..c1527637eb74 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -13,9 +13,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - atmel,at91sam9g45-trng
-      - microchip,sam9x60-trng
+    oneOf:
+      - enum:
+          - atmel,at91sam9g45-trng
+          - microchip,sam9x60-trng
+      - items:
+          - enum:
+              - microchip,sama7g5-trng
+          - const: atmel,at91sam9g45-trng
 
   clocks:
     maxItems: 1
-- 
2.32.0

