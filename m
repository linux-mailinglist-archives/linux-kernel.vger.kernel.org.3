Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B556648B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiGEH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGEH47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:56:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EFB13D1D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:56:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d16so9987589wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5dZdIc1hvkMEYVAj9UyiGCz6EmxkSEM83h7TJOheUI=;
        b=6s9g4MM/WSArj6qBhSnDTy4B3b+hiTstuCKJxNZ3trOEsw4AuPSUxSYYW0QW68WUgX
         tABhnW0yqeEF0xHVTnQ0vU29GH5vy/n9Zw+hMyWcaNKY2u91I52Pbm5n/EbWsNjB0IvC
         U8afSRPrqjmtbsptiGCvxjj1S2caLzb1x6dAs/SxUENCKKKs/7adHOpCwV+prvPDtzw6
         LMtGC+wKsqM7gmqOKjXLhGwCnSMomJ9HMKly3jWvL1GGjy+aKXKOVubHjDp7WoHjcS6/
         5v8cIk10SH4rZN8ofmPZlgBStlye/QcYrbNO+nJrVJY1opHre4KchD8qzh0k+b/SKcgZ
         H/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5dZdIc1hvkMEYVAj9UyiGCz6EmxkSEM83h7TJOheUI=;
        b=Z7uicT4/lxkArzQmc7RXNNcSvngpyd1isV6wlJ573CUlys4uAkYBYp1Iz8O/SVbN+x
         4TSx+7VNs2G5URFQAjC3pExQw5Vz0f8crImaHgoj9Zyy3lcFAa3J5CNbhPpeVHJ0ACst
         IS7orkjtS+1/W55Sn7Hw6Mkv8eKJ1YOMBN6vYkMhy4inLXxscQuFXIu6ZPTrZtSY7JY6
         eyV5/a4lDdyxJE/8acLGWe9zFbJVvUi4j4Ogz+tELOa4JeYmK1jB1sFHZ1rqYL+Ym4fi
         3sf6PbSMkNq+6LVp6/Rj2odYu0FaXn6bbrObGTm1UHS100twDyDiwZA+kFoSP5hDRZrK
         IPAw==
X-Gm-Message-State: AJIora/63jFgXAjV+9Az1M4wioZSmbVwzEPnaaaAwFWycEGatZsCkrfX
        NAqohrpsCcKdfaV7Luza1QizGA==
X-Google-Smtp-Source: AGRyM1vAi92HlCcP340VdsuW1eshwTJpEKAu0VF0zzIoSkayd5WUd0mGsFmCavTXKFLDUuf6AIFuWQ==
X-Received: by 2002:adf:e78d:0:b0:21d:67d8:6e30 with SMTP id n13-20020adfe78d000000b0021d67d86e30mr9948862wrm.109.1657007816194;
        Tue, 05 Jul 2022 00:56:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3c4f:78be:dc90:14f9])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d5911000000b0021bbdc3375fsm8323473wrd.68.2022.07.05.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:56:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v5 0/2] phy: amlogic: Add support for the G12A Analog MIPI D-PHY
Date:   Tue,  5 Jul 2022 09:56:48 +0200
Message-Id: <20220705075650.3165348-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; h=from:subject; bh=nDetBA3HotL8bYLSaVKluyx7j3QuDEtAntCaS1aC/Hc=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBiw+6eCamVpBN7p2hTYDYzwk+y1u4fjJBS4nv/fE/2 7XFZMMWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYsPungAKCRB33NvayMhJ0e9uD/ 0YC6+R9Lh2/AGg5uSX2jqwJ7tx9VOQ7b3rP4l7V6PZDgfpJ4qGWw37cfEMJitIcDf7Da1I7s6qahl1 3qGAlj0RBriaWa8rIYPYncv12u/dCo0ZH61YdWwgXv6vYL0GZvBu/GyT2JGewazWCJCNOp5Bnj+qra +5dWQ5FSvknEvWJxZX2alCZLvvt/NkBC5ReoSUPteqnCgILtYgV9OUGjU2wflhl291w0Ea8MOC4B49 wucrMGtl2GiWuDsJcX7kScHtBjBkzeogvi/2Ls3dWvFqKR8i8uVvlCbbXNKR8X32V8RJsrxhArDMLk LUZlIeugqGDVy6E3vrErD/fQ+d+krvDTQVfLuJX0buF5+7PasbA8rD3gyDzNBcFiW0fKYF+eaQ1Wdl lhBgt9TocIOaGVbWqthVTWqV+ELnpnspjycWBOPNfp86E5uunnemIT2BvoMUeLZzCZabz8a+KL29dv q6qcVE6GAAPnm7HJb+XGGPYvH4iw/YcyvReaY8WugJSuv1h9dLOOV5sSuQXJkl6XbpWAV0xKICklJ8 hChNqfjXFJfV+pHfVYZujvbEmHoaJZnkJ4hUEZYeRbE+Wpxep9jpgDVQVTZsigOj9jAbpHISSy54fp BG/jYCk08IX0TT99+ADKu3iElLs7M92cmcrG+lA/4ZgbD4WZtJirQ55XG3HQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.
    
This Analog D-PHY works with a separate Digital MIPI D-PHY.

This serie adds the Bindings and the PHY driver.

Changes from v4 at [4]:
- Add bindings review from Rib
- Order in Kconfig alphabetically
- Switch to dev_err_probe for error log
- Remove last comma after sentinel compatible entry
- Depends on MFD_SYSCON instead
- Do not keep reference of parent node pointer

Changes from v3 at [3]:
- Add sentinel comment as requested by Martin

Changes from v2 at [2]:
- Bindings example fix

Changes from v1 at [1]:
- Bindings fixes

[1] https://lore.kernel.org/r/20201123145157.300456-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20210210080736.771803-1-narmstrong@baylibre.com
[3] https://lore.kernel.org/r/20220107150512.614423-1-narmstrong@baylibre.com
[4] https://lore.kernel.org/r/20220616133811.1674777-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
  phy: amlogic: Add G12A Analog MIPI D-PHY driver

 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    |  35 ++++
 drivers/phy/amlogic/Kconfig                   |  12 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 171 ++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c

-- 
2.25.1

