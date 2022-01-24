Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8333C497A33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiAXIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:23:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42788
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236208AbiAXIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:23:54 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F10493F1A3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012632;
        bh=7zKcWROJaURhL/8HO42elhk/RcTUKxPURWmHqK9IZzA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=hAJExfno7hXb3pnG9f2+5GMT1ttGD6C5YC06Cb4AZoXQ2b9NkyjMr5GkLRw49bATa
         PRWSVWZFuN++/lz3zbiLrMs+VCT9igGFMa7+bixk+96eDW8f7UH6m0ecFr2em9wZ16
         IA0CsMBX6kbwLUw3M3yTGXicZWpXXNMQTpSmQqVQs5/1Jx7tKBMyQsgjB6PBflpckV
         xW1X/syqBt0vC0afgF1j96sDqjrvfd0CTfxvcIgVkg2O+d0aTaKi7GoDRFZT8gmG00
         8uxdF6f5Y5yIyGc+9LleOE4+Ll5tqs4WbiLvoHf/AkmO3/6S8+iZiD59ujW4uM6ieH
         ePzvIUbIMzMTQ==
Received: by mail-wm1-f72.google.com with SMTP id o193-20020a1ca5ca000000b0034d78423625so13302961wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zKcWROJaURhL/8HO42elhk/RcTUKxPURWmHqK9IZzA=;
        b=CCL/OX+6BxThyW1GtLsm8Avp8g76VSTVGQ5dy1Skb4nVP57oob7VkQImDXH5TdOGVk
         jhAeVIb4+7jckMbgGYEpB3kIAmdcwNoCH4Y57K9bdEKN99PYRxqPSv2ZV6qxQF3DAl+r
         ShhX8+q/l1LSlceqFvUmT/DTsAUJPplzHvCy4ZpVvJJwPJ/IGyg2S80FbBVCaKn3BOI5
         64lMJcVPbPtH4b+x/6gAvkiUOAB68xzRs7XT66BFmzUVj8XVHqG6RXCEZGzcPMV0Tjhh
         Wy+RLjgr0Aw9PWfy5V4C96+wBvnlYH6r/IHUfWpTZAKbSALTNhEvk/UBkdGsGLBv2YN6
         aA/A==
X-Gm-Message-State: AOAM530VGn8RpY9ILIY0K5GCi2NYf9dzHUgn0nG5HrvfR/xLmMteTCHv
        v7SCWVMm1CR2A0VNI30SYLqOv0PvTZTf2H9NMQpNfvu+O9JzgR9OT6OgydZxYnoiRffGIsIVhD+
        WK32JVmWelX8gDmeSruYqCUgQUe0XPQNdRcdUD2z8+g==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr781508wma.52.1643012632393;
        Mon, 24 Jan 2022 00:23:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ4msI9DBdqPFRBMYAxKWHo7GfTdXh5lgJOdfR2H1wJlIwpu6wqbPgDj6zli+U2IlDQPbSPA==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr781490wma.52.1643012632243;
        Mon, 24 Jan 2022 00:23:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v6 0/4] spi: dt-bindings: samsung: convert to dtschema
Date:   Mon, 24 Jan 2022 09:23:43 +0100
Message-Id: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v5
================
1. Add new patch 3 (fix indentation in example).
2. Patch 2: reference spi-peripheral-props in else.
3. Add tags.

Changes since v4
================
1. Do not require samsung,spi-feedback-delay and fold patch 3 into patch 2.
2. Rework message in patch 4.
3. Add tags.

Changes since v3
================
1. Patch 2: correct path in exynos-usi.yaml.
2. Add patch 5.
3. Add tags.

Changes since v2
================
1. Patch 2: drop child device schema, as Rob suggested.

Changes since v1
================
1. Patch 2: describe devices matching compatible, correct issues pointed out by
   Rob, add reviewed-by tag.
2. New patches 3 and 4.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  spi: dt-bindings: samsung: convert to dtschema
  mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
  mfd: dt-bindings: google,cros-ec: fix indentation in example
  spi: s3c64xx: allow controller-data to be optional

 .../bindings/mfd/google,cros-ec.yaml          |  31 +--
 .../bindings/soc/samsung/exynos-usi.yaml      |   2 +-
 .../spi/samsung,spi-peripheral-props.yaml     |  33 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
 MAINTAINERS                                   |   2 +-
 drivers/spi/spi-s3c64xx.c                     |  14 +-
 8 files changed, 246 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
2.32.0

