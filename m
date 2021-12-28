Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60B480B63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhL1Qji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:39:38 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49166
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235407AbhL1Qjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:39:37 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F1C23F1AF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709575;
        bh=HGuU3G/CmacYFKUeANclkwpOH3maXtk12cKoz5IJaT0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=oxxN6eSWF7AXk4UAgg/175iDP8hmfpEDN1ZnkOItg3GnAAV8mg/Y7D7sOPyrjzRcC
         6m2XhJuKSYgwRwLLWIf+JbP4BVs/31EIC9Cn1ut+1WkTN6RrtLdfnnASUGcl1omKmN
         HDGk97b8wIj0V5RoFUY0kipcX61vKZjCnvNU5EAdxH8ErPQxZAX1dB2BZuHK74W18i
         w3+YVLp9WgODqPwAdS3pemiG25UpeceDqBDmJl2uJ4JkhJhXVwUXaDCuw5yQFB1+FJ
         4daaf9eTSGy0o9bZd/+fNE+sa+2quqmfuBpMXqbhFphcInc06uPdnUOeKGQr5v2Lwf
         dfeOkC/jDeElQ==
Received: by mail-lj1-f200.google.com with SMTP id l6-20020a2e8686000000b0022d9a4d18d5so5214048lji.19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGuU3G/CmacYFKUeANclkwpOH3maXtk12cKoz5IJaT0=;
        b=nZqrSkxWdRILZ7ZuN+Wv5dzkZ5nnvnBi3HE6xJQiRcFmRxKKz7Yfxobc5M+Afrq+1D
         JNbewCxcrnMSiQyfF6oBX0v2Q0Aw2dGPkl5ko/SAuL6pmJ48SC8QqERF4t4CsUPPKR/t
         /+C2+/zWd+hJytCRwL2JmxPP3mlV2ufmpRJnf25TRqCbnnObfIQ3SG3Hit0HMdgbcRu0
         oCjLiZA0dXnH/gyLlk5R1YN1SsXPUOaZD8TcE1sT//MRAyWeqJzzta6WgflX5Mz93LuY
         0Xqli074HmKG43jVUDXMd8Cx35YqxVP/ovWj7j0e+Z3ryUcu+otuveV/Timcr/UsISlH
         R+hQ==
X-Gm-Message-State: AOAM530LdSS0Id0Xf56sgiy8qjfUxqam0vaXboCxz6Oxu4EDtLVnZcKB
        2fKU5DBiubOWt8MPltFWHKrpDjhtcK7vxFFxTpOYocFN/db1UHYUZOGV8XROJ3He5lr5i6bHGNB
        QN3tbnuxxLj5MDsFylPluukuundfIVnP2nbdShTGBeQ==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr12168951ljk.22.1640709574631;
        Tue, 28 Dec 2021 08:39:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2R4OjcmDuYU5dFgZyIsJA+br3TJLYbRM0hsPoVHlotH5EqETNcXzL7aQK6WUoOnCtKUrTgQ==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr12168917ljk.22.1640709574002;
        Tue, 28 Dec 2021 08:39:34 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d3sm1972876lfs.204.2021.12.28.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:39:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/4] leds/power/regulator/mfd: dt-bindings: maxim,max77693: convert to dtschema
Date:   Tue, 28 Dec 2021 17:39:26 +0100
Message-Id: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The final patch - MFD maxim,max77693 bindings conversion - depends on
all previous. Therefore this could go via Rob's or Lee's trees.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: leds: maxim,max77693: convert to dtschema
  dt-bindings: power: supply: maxim,max77693: convert to dtschema
  regulator: dt-bindings: maxim,max77693: convert to dtschema
  dt-bindings: mfd: maxim,max77693: convert to dtschema

 .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++
 .../devicetree/bindings/mfd/max77693.txt      | 194 ------------------
 .../bindings/mfd/maxim,max77693.yaml          | 139 +++++++++++++
 .../bindings/power/supply/maxim,max77693.yaml |  70 +++++++
 .../bindings/regulator/maxim,max77693.yaml    |  49 +++++
 MAINTAINERS                                   |   3 +-
 6 files changed, 365 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77693.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml

-- 
2.32.0

