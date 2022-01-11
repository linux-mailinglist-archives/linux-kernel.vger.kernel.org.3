Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4DA48AB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348906AbiAKKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:13:54 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41872
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348736AbiAKKNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:13:47 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D6C440047
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641896026;
        bh=BJcC+0E6Y2y3qsaMlSAjaaYN+3MxC8IRY4wxOhHEIbc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Jk6obyhns8VIX74aukat8xkwB0vl3cFxu5HHhQkHEv4HrgG9sEdpt07MW4rV0fCfT
         B8upXaCXqGsBnDfk3iNOgdW1LnxbEQhQWAC5HQH342ANG3rwNP/pM9TJnnANsN3aFu
         JiPsUb3J/unQ+7vn5ehpYMgc0nlh3nRbDdzQYDYxzw+r/akuX/LLsa5N2DwAd61GaX
         rpYW4Ofx8+QfZopE+LWyEl5k458J2QycmlMUKGKnUWsd95p/Mvcm/D7Sop1oACNW1a
         LbCoLf5SzlOyh1GuImYvxp97M6DS0x0VInrjEzAFcA3TtOfT3Sv1baAUcE6CLa+i4c
         5pQ03gKaLXsuA==
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso12849211edd.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJcC+0E6Y2y3qsaMlSAjaaYN+3MxC8IRY4wxOhHEIbc=;
        b=ls2NPlXuKBRJ8N9FAndiqyxqj/0krVzs6ntxb19+QAQsf/C09Sy2dEpcOAv+Lpe0In
         YjUCOH9AwMcF1sCMlsHgMSpvSnwuevEsOoqAFjkae8A55KgF6KkAw6kNNWLfPYBV8PW7
         pEo0U7zPDr94bQh3vXDeNiSdVJqM836fWh/OwCofFoina3eyF9GkqDD27GRZmJAoOEZ4
         rkCa1iGwjmolIjXFj3TjwcADNtpXKddtXfWtay2nPqlDDXGkt0VEoYUfwHLDhohKbvf3
         heM6pHr3Ztj5FUGbh7E9zKtzleHAa6WiHaYaA6FiHuqERtKEB+4KizQKOUbLbE6vZ+LD
         pNUQ==
X-Gm-Message-State: AOAM531RmZERJH1/SJrhv1Cj85+JICKp5nOnWz2oxwYR1M+15YPbDhcI
        vE/5UDdk43Stmksg0VPFjlsw0pGkU0JvUxCNJ6ftzY7zltU+BdWIZhjTx/yNIDKLK4KbwLstJVK
        1AaI+imT4q+irub/OJI8ULsSmGrJZn1tMo7IMAknZMw==
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr3244364ejc.188.1641896025435;
        Tue, 11 Jan 2022 02:13:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRZEoQ5u1bGZQZJNook5L4lY9BkzKhKOYtLcERafkQAKIt2Tq7bk74PNAyjv+BJ4TXFGswLg==
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr3244340ejc.188.1641896025195;
        Tue, 11 Jan 2022 02:13:45 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 26sm3431268ejk.138.2022.01.11.02.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:13:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/4] spi: dt-bindings: samsung: allow controller-data to be optional
Date:   Tue, 11 Jan 2022 11:13:37 +0100
Message-Id: <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC SPI bindings requires to provide controller-data node
for each of SPI peripheral device nodes.  Make this controller-data node
optional, so DTS could be simpler.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml  | 1 +
 Documentation/devicetree/bindings/spi/samsung,spi.yaml         | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
index aa5a1f48494b..cadc8a5f061f 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
@@ -28,6 +28,7 @@ properties:
            - 3: 270 degree phase shift sampling.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 2, 3]
+        default: 0
 
     required:
       - samsung,spi-feedback-delay
diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index da4533feb946..322558818a43 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -75,9 +75,6 @@ patternProperties:
     allOf:
       - $ref: spi-peripheral-props.yaml
 
-    required:
-      - controller-data
-
     unevaluatedProperties: false
 
 required:
-- 
2.32.0

