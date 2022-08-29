Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C55A4140
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiH2DGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiH2DGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:06:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D967371BC;
        Sun, 28 Aug 2022 20:06:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13264634pjh.5;
        Sun, 28 Aug 2022 20:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=SHFI7KtF/4EdUvL9JCtWG9NI+uEC+BREujAzYelFCr0=;
        b=PcC3zq7uFX7iBXv8JDYqbGP9G7BYYGGKvR3aS8or3BZuXCM6uAvqDlFu5sxDyf59v7
         6ykmyabD3LE1Y8ApnHH1O6AZqYzRudlqHq6liyJNXdVr+8e0lmA74UnJIfGjou9rtKHf
         26Ykizx7H5b1qUJ7GLRV3l6N5i0NAIQK9KyGgJOVul+6/jzbrp/4oh5uUzKYj/SVuAys
         oHyhIZ/5KkTTXcnk4a/HsYsMe+ra7PqvVl1YpYoRcl9TfnCYrfqSpeisG6Tk3MMUCsmz
         W3hCLXRIOe51pgt9TMUWCt1KzLML5ZRw7yLmKMGTe3RTKJv8eXQ83ubvXStkBVx0f+sE
         TMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SHFI7KtF/4EdUvL9JCtWG9NI+uEC+BREujAzYelFCr0=;
        b=7buxa2cOwEZA/kSMwZ1YEyBNrKP0CZny0B9I4uaNZnYP48Xxp98m+bGJizrCfrBLXT
         sLOaVTLTJnPmgL6xS7bTXV2N/s2qj7PcFkwMPyPz/kHv9wfCfKSshtsYI8xIoak9h1GO
         o6iyFPkFFt1o4MGZg5y5P9Iv3Fpiioq7y6i3dRCOwZknR98J5jfedVRA65+VZBauxBdb
         XhgYK0FnJiGJKPGOuj6N50VA2PZWwb7GyQsaBHOju8VLmZxwRZKlTVfkXhHCOidPW7ED
         nvNS202n2TK+v0H+6P6vIlYpU282/E5aLdM9SwnlzoDr0mDV5wB/Wqbk1hrl6cw10JL7
         EoWA==
X-Gm-Message-State: ACgBeo0uZZ/V8Af58/lYUY8Q2I/Xa0Mw/wzD+UClWtxpztgbw8WVAD/6
        uRfW0HB+Ry/vdpsY38enol4=
X-Google-Smtp-Source: AA6agR4QGBvLx0PLjokfyPSOco5N8lTdDu2/rn3TtoLnnWir5vXAQObhaj2lVExpw51CRNFHWerI5g==
X-Received: by 2002:a17:90b:4a09:b0:1fd:d4be:fed4 with SMTP id kk9-20020a17090b4a0900b001fdd4befed4mr2281055pjb.6.1661742411528;
        Sun, 28 Aug 2022 20:06:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:7020:1d84:ae39:a965:2e45])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b001714c36a6e7sm6105839plh.284.2022.08.28.20.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2022 20:06:50 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add Richtek RT9471 3A battery charger support
Date:   Mon, 29 Aug 2022 11:06:28 +0800
Message-Id: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

Since v4:
- Remove the line for the owner field in driver.
- Add the documentation for sysfs entries.

Since v3:
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2:
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.
- Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
- Specify the member name directly for the use of linear range.

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9471 battery charger
  power: supply: rt9471: Add Richtek RT9471 charger driver
  Documentation: power: rt9471: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power        |  44 +
 .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 952 +++++++++++++++++++++
 drivers/power/supply/rt9471.h                      |  76 ++
 6 files changed, 1162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c
 create mode 100644 drivers/power/supply/rt9471.h

-- 
2.7.4

