Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7949E06D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiA0LPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiA0LPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:15:45 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E7C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:15:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c23so4107382wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqCQ3Cv7kubS972WRmyqz9Ovn66XN6I/kVUjqRm07dI=;
        b=FTCageDzja7MDHvfCdCrAWTT1F+s07YyGIVA7XEv4aLKB2thbXHqzqoYf2B1gCt55v
         FPdI0kwpmhullu7lusRBsFROrm+KGgOqAtkHTjjbNhm6h5D9+3Ne1tFsyO728iltINTl
         dBQs0alpeVpfV3Ha9RCcABOFdXRj9F9nclZzHbGfx/nZgyAVj22++a7xGi+3VV6O+50e
         YlO6CPOAiBrbTNpl7iW6UryfHdGsLmrXnjHP5ob91ye0kIvslaoJHzzvOTBaqn/RosYg
         tF9a1eLC1+aX8lSTzRPeyy00PR6DzazDjd+e9EaH2EA5Y4Nck7tI0AegXRpMNS2yhmF1
         WXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqCQ3Cv7kubS972WRmyqz9Ovn66XN6I/kVUjqRm07dI=;
        b=vvJUKTCcuhmtEW/k0JqcrnvVcmWfyqfHTjgwfhTI9L7fRA8nZ1Y4tUGuRfqhhDpHMb
         ikJOrMJ0YIJMJgcWlWstFS7/tLn9LKgaB9303DTz8knbM/0UqqwKcFyFRPew7MScc30V
         +GGaXpg7KIrHy8xNbZXX8+iv/2pLx1LZ9a8WG8SieARdnMob+lizRNLWG4kkH4AdWjn6
         xqo+MyZgxBMlh8p2rkaNdBsbRT9RVGcprStae33WJZ95k56/oVlgQj5jEH0Rbi0x8sRx
         HjePE2vFLje2OMhXuPp2RgP4g6wzIsv1YCpOW5LuBxqWqu+Tx3NMjQKNWEMgCd1tZ03a
         j+FQ==
X-Gm-Message-State: AOAM530ZTETuKSGEck9C3sgCnQQnmJo6Ol0DlI8tqWAHPpTa9ETSx6+D
        1fP+ZzfgsCT+ipSSCNcx1frmgA==
X-Google-Smtp-Source: ABdhPJwjpkby8GQSoY8fsnnpW0eosHE4KMSv6I6bmTxLodSfB9LUCloN8JxTHyEdgsOEm+5ExtPVTQ==
X-Received: by 2002:adf:d1ef:: with SMTP id g15mr2661269wrd.418.1643282143753;
        Thu, 27 Jan 2022 03:15:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb19:8b2c:5e00:7d3d:d638:46ec:78dd])
        by smtp.gmail.com with ESMTPSA id r7sm5956311wma.39.2022.01.27.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:15:43 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v20 0/3] Add matrix keypad driver support for Mediatek SoCs
Date:   Thu, 27 Jan 2022 12:15:23 +0100
Message-Id: <20220127111526.3716689-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This is a follow-up on an abandoned series, see [1]

Since Dmitry seemed generally happy with the driver, I applied his rename
recommendations.

Thus, I have made the following:

* All Reviewed-By: tags were kept
* Applied Marco's Reviewed-By: on the bindings (since he approved v10)
* Fengping is still the maintainer since he is the original author of this driver

Please tell me if you would rather have me do things differently.

[1] https://lore.kernel.org/all/20200909072159.14888-1-fengping.yu@mediatek.com/

v19 -> v20:
bindings: use dual license
bindings: fixed 2 indentation issues found by yamllint
bindings: drop clock-names description
bindings: use standard keyboard node name for example
bindings: use default: keyword for default values
use debounce-delay-ms property instead of mediatek,debounce-us

fengping.yu (3):
  dt-bindings: input: Add bindings for Mediatek matrix keypad
  Input: mt6779-keypad - Add MediaTek keypad driver
  arm64: defconfig: Add CONFIG_KEYBOARD_MT6779=m

 .../input/mediatek,mt6779-keypad.yaml         |  77 +++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/input/keyboard/Kconfig                |  12 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/mt6779-keypad.c        | 218 ++++++++++++++++++
 5 files changed, 309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
 create mode 100644 drivers/input/keyboard/mt6779-keypad.c


base-commit: 87a0b2fafc09766d8c55461a18345a1cfb10a7fe
-- 
2.32.0

