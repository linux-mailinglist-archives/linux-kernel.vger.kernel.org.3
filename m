Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55057480B78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhL1QnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:43:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39602
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhL1QnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:43:11 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F1C283F07F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709790;
        bh=QEjdNCFh1I2/FVAvbi9/CNnV0tj1pywVMVJDrsQ6S/M=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Bqdzdtgmr+ruO7oiH7URP49KprUdi2fuR8m/jU+EQ93X3vTMNfKotZWkgqe5ojDAh
         s1dGg9fVZ0aJq5HogKVsQUChqFTFNeoz9pogqia3scG3AXpQivdTQbINmRw/2mVXK2
         y7tQ5fonV1Y4uecumzrogs0lrvz8Gl6ddTT22EKNSoQin7nKa3BbVLecrjd7c6RAMv
         X7oFHDKRmBrgSBvFYCIV4I4mlNSgzGoRARyJnH1tzdFlbPOWwmBndYc6eu+yfuia01
         nQU6HIXYI8jnnnJxeJxem0RzHeRRg6f5spvaKkbQEXLKPyVzZPAEyHTB0ZpmVO0dqK
         Oe1vkYIbVv7nQ==
Received: by mail-lj1-f199.google.com with SMTP id n6-20020a2e82c6000000b00221698ffa68so6246551ljh.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEjdNCFh1I2/FVAvbi9/CNnV0tj1pywVMVJDrsQ6S/M=;
        b=f3HGFXpJNzd32CxJaskzFesO3jtOOAtRnpiEmYSibF8J1KZa/t8f8ac8dW6kwUD0gQ
         ULxGNes5VX0uIiNGevx08J3huAETImxXEkZTkXY0c6D11OAkjttMj34oAg1aIsUGDO2c
         pH5Srb99iY/wPyM3ANqYfD+o9uo64JDeL1aBt5MyqS4/I1eoClrSOaMAuU/IFwN1z+ao
         TpcjGGyGIQmx7bcmtK2ncsObm+ggsEzOZW3Svr9G0AH11bjC/AuDaUP1n8lFNWKeXcZh
         auywAPyolNaJjcyWRnTn3WpEmFAO/Dzi6vWXvtEJXzP1M5O8PpAHUNI4exLoIwE45QUQ
         bBsg==
X-Gm-Message-State: AOAM533Dh0AfU7MK7A4njAz1P4yWbFMTrVLoiSRnjYpjfkP5TGUJ5oLj
        y8P5jxAHUGOZq0wjbPGHd1K4Oy6/NCW6UHEEnkAAb9QfFjdOsxuvENVS1SOf0HTv1O/iXFPWxoE
        1OHO0t0Ib1oXVMMxVhKVWhgi1YhHH/nLL/zV8hGRGyA==
X-Received: by 2002:a05:6512:2103:: with SMTP id q3mr12696199lfr.538.1640709790381;
        Tue, 28 Dec 2021 08:43:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuF3oWT8cZMD7Nqx/2DjV9aAVXl8AQ/O4g5c+EzTbwKY07FXphsdOMJMAV+vz7PorU0kowRQ==
X-Received: by 2002:a05:6512:2103:: with SMTP id q3mr12696184lfr.538.1640709790220;
        Tue, 28 Dec 2021 08:43:10 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u5sm968701lja.36.2021.12.28.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:43:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/3] regulator/mfd: dt-bindings: maxim,max77802: convert to dtschema
Date:   Tue, 28 Dec 2021 17:43:02 +0100
Message-Id: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dependencies:
1. DTS patch: nothing depends on it, sending here so Rob's automatic
   checker won't complain about DTS.
   I will take it via Samsung SoC tree.

2. Final MFD patch depends on regulator, so the two last patches could
   go via Rob's, Mark's or Lee's trees. :)

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  ARM: dts: exynos: drop unsupported MAX77802 regulators on Odroid XU
  regulator: dt-bindings: maxim,max77802: Convert to dtschema
  dt-bindings: mfd: maxim,max77802: Convert to dtschema

 .../devicetree/bindings/mfd/max77802.txt      |  25 ---
 .../bindings/mfd/maxim,max77802.yaml          | 194 ++++++++++++++++++
 .../bindings/regulator/max77802.txt           | 111 ----------
 .../bindings/regulator/maxim,max77802.yaml    | 118 +++++++++++
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts     |  12 --
 6 files changed, 313 insertions(+), 149 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml

-- 
2.32.0

