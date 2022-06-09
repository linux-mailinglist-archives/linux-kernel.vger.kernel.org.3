Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534054503B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344169AbiFIPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbiFIPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:09:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E91E73CE;
        Thu,  9 Jun 2022 08:09:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s12so40882517ejx.3;
        Thu, 09 Jun 2022 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHOM+mYbI6Bxg2SBi/HBdfsrINjBzJ9I6MBqUHf1FjY=;
        b=a2VNDPi0QrYfC9azutv4aMCuFa4B+DHC7sXr6PEJGqVcn21a0JdUCoqDLtHSJdCuni
         sJHi4TCYMSV+UZeo2/AnfmlVEjCDghh5h1xzrjYsbB+OIRqQKhEKkG0Zl61xaOX8rGLe
         xui5KMp56FLkNDxwtkxx0mYV35AzETwbiuHtV0CCCLWR7WwT2J4d5vf+vD8nTUqlGXEz
         pcxf9YM+oGCHmCDpQ20u/1HhG6R35+ZqnZdrLmVIhbQk7aVhEZ0vtg0Qq9Ke1o0lU/Qo
         XIBpESu9HdBu271S4Ja/CTnuRmiKq4LezQDl8qp5tliEeoLbYTUrpnAePqCyluGLfwfK
         k9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHOM+mYbI6Bxg2SBi/HBdfsrINjBzJ9I6MBqUHf1FjY=;
        b=CZve1iGGzGxTwvlJR/JXwGEu5fS2zuD/YtV3Dc6V6rlzn9e5uz+rRXmtt17pE17vIL
         FN7pP5jb10PyxlBJsmMX4VXUzvN75kMTNRrYwEQ06PUYaL6YOWqzYYUUCkOaaOeKF6jc
         PPe/354Uvsg1Luf5nWjvu7mg5EUe9AD1JLdzaDsn0OV/JaIyTUtXRBy9KAHtfo8TKUC/
         3m6C0wgWcJwnHggWGQ1Bth+EN/KSsvLYjzQ64E1b0K5mHXUqci6NXGE7g1BnsKPP7Vct
         PAaPtsIXqv8h7wtjJ02zBxcleqBSEIz8v9cMHNZY0pEKnuvaH57NQTgX+dUw3rmcx8fh
         U+/w==
X-Gm-Message-State: AOAM53017si/XeJnmmbHeKxoJyb+GmOqNIhCSnFQ8f0539LGaDYcScM+
        WbnlI7vRCMFtAnmKB8JP8No=
X-Google-Smtp-Source: ABdhPJwWBhLrnEnZGNDPrUTJVdumNLHrNgMQtMwzp9/W9oT6/3xaUDfnp2FyH0FrEjXOglHnzxZS2g==
X-Received: by 2002:a17:907:1689:b0:6fe:fcf4:128e with SMTP id hc9-20020a170907168900b006fefcf4128emr37376626ejc.446.1654787375202;
        Thu, 09 Jun 2022 08:09:35 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm14395135edq.15.2022.06.09.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:09:34 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider which controls
Date:   Thu,  9 Jun 2022 17:08:46 +0200
Message-Id: <20220609150851.23084-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

its power enable by using a regulator.

The currently implemented PM domain providers are all specific to
a particular system on chip.

This series adds a PM domain provider driver which enables/disables
a regulator to control its power state. Additionally, marked with RFC,
it adds two commits which actually make use of the new driver to
instantiate a power domain provider and have a number of power
domain consumers use the power domain.

The perceived use case is to control a common power domain used by
several devices for which not all device drivers nessesarily have
a means to control a regulator.

It also handles the suspend / resume use case for such devices,
the generic power domain framework will disable the domain once the
last device has been suspend and will enable it again before resuming
the first device.

The generic power domain code handles a power domain consumer
generically outside of the driver's code. (assuming the 'power-domains'
property references exactly one power domain).
This allows to use the "regulator-pm-pd" driver with an arbitrary
device just by adding the 'power-domains' property to the devices
device tree node. However the device's dt-bindings schema likely does
not allow the property 'power-domains'.
One way to solve this would be to allow 'power-domains' globally
similarly how 'status' and other common properties are allowed as
implicit properties.



Max Krummenacher (5):
  dt-bindings: power: Add bindings for a power domain controlled by a
    regulator
  pm: add regulator power domain controller
  MAINTAINERS: add REGULATOR POWER DOMAIN
  arm64: defconfig: Enable generic power domain controller controlling a
    regulator
  ARM64: verdin-imx8mm: use regulator power domain to model sleep-moci

 .../power/regulator-power-domain.yaml         |  58 +++++++++
 MAINTAINERS                                   |   9 ++
 .../dts/freescale/imx8mm-verdin-dahlia.dtsi   |   1 +
 .../boot/dts/freescale/imx8mm-verdin-dev.dtsi |   2 +
 .../boot/dts/freescale/imx8mm-verdin.dtsi     |  35 ++++--
 arch/arm64/configs/defconfig                  |   1 +
 drivers/power/Kconfig                         |   1 +
 drivers/power/Makefile                        |   5 +-
 drivers/power/domain/Kconfig                  |   7 ++
 drivers/power/domain/Makefile                 |   2 +
 drivers/power/domain/regulator-pdc.c          | 112 ++++++++++++++++++
 11 files changed, 221 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/regulator-power-domain.yaml
 create mode 100644 drivers/power/domain/Kconfig
 create mode 100644 drivers/power/domain/Makefile
 create mode 100644 drivers/power/domain/regulator-pdc.c

-- 
2.20.1

