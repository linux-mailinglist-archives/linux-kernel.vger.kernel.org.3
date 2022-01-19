Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73C49417D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357255AbiASUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:10:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46190
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243247AbiASUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:10:13 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5688C4004C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642623011;
        bh=B0MRNjKyPBOkLqskhHhUYFAwrhXXjHwf0AFyIDpdjDg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dGL7DvwWVnqj8a3LnyFOHTHRNaqJOg4+4sxY9r7eZ9Iu5uTuPlaFyvLDndlnx/LS9
         wpJQWwOjpXePea1Mr5ywjN7zkkbCMOZh1J+9BSRfv5PImlPmQTYMnOlN2WGdppjh3f
         jJa5UaCkGUkMqh4T/2CyklJto3pUpSzMyMIF3i1ad/q7f4/r1ZUx2DohQCe7++44We
         6d0q8SMcl/3EvcSIifJl5cKYtKL3ADHh8UvwFyPVGzqK4fzZipzTatFS32WEJ6EjPM
         0EImQMYP5hHwGP3q0++CY3wXWB8DxyeQ1mwDQTGyqTHqoJ6saianQIw6v9/HEI/ejE
         AUZBESm4KiEug==
Received: by mail-ed1-f71.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso3736663edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0MRNjKyPBOkLqskhHhUYFAwrhXXjHwf0AFyIDpdjDg=;
        b=b/H2r2zUu+x8UX0jboYwxmg0LFw1n+TpccRkl1VC186siAXLEVisazswdAt+mgSfGn
         RsRDh92bcdWusqCZ6e1QxNp21MCRe6B5vrOfCSzhsnU+HfKNuy1EuljLcYgd258NqrRO
         oSgfXPXvQ++UqKTJPHr3cYZqrU6Nh5uGfEjCQGn3c51HotU9FumCEEi8SYZZk/4/dYTX
         vEyRqECWcW97vovtc+JVb8OEm4ZfS0YA4opJn8WddqsrA+s+/s3phEyrOo+QFEDkNc9E
         82FKxFgrpLXOsSTzKbeoBW2Av2gM1TAn81lLd6U8P7rmc81J292ELBPG45+QGmkf++J/
         L/zA==
X-Gm-Message-State: AOAM530Xqw8xkazqiXuUAXoeV5zoYwm5CbOS6num8oX0iSRt2EL7HqzS
        AxqeEL+dKv0iDhBBHlF5D7wYxTzPLFxb3oP/fChmKoWYCL5qHcv3X51IxWevHrG+MrasRcxZ+mN
        XxMaiKBM7sumeAuNJZTfBf6SBhL12y+Kj5TfHLAlQXw==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr31876164edc.340.1642623009980;
        Wed, 19 Jan 2022 12:10:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyXY0vDwKSfhnExno/DI3+JyjNBt4Lf3DhxMlvfzqLgNypDn6KioMudJOfGjSmKq3JQmKr2Q==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr31876128edc.340.1642623009706;
        Wed, 19 Jan 2022 12:10:09 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a26sm215005ejr.213.2022.01.19.12.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:10:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 0/5] spi: dt-bindings: samsung: convert to dtschema
Date:   Wed, 19 Jan 2022 21:10:00 +0100
Message-Id: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Krzysztof Kozlowski (5):
  ARM: dts: exynos: split dmas into array of phandles in Exynos5250
  spi: dt-bindings: samsung: convert to dtschema
  spi: dt-bindings: samsung: allow controller-data to be optional
  mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
  spi: s3c64xx: allow controller-data to be optional

 .../bindings/mfd/google,cros-ec.yaml          |  29 +--
 .../bindings/soc/samsung/exynos-usi.yaml      |   2 +-
 .../spi/samsung,spi-peripheral-props.yaml     |  36 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi             |   9 +-
 drivers/spi/spi-s3c64xx.c                     |  14 +-
 9 files changed, 251 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
2.32.0

