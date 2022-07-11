Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34656D8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiGKIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiGKIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:50:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03113CE5;
        Mon, 11 Jul 2022 01:50:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l124so4212810pfl.8;
        Mon, 11 Jul 2022 01:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5g/2NksbO4TUZ12uNSjT5a+ira1ltuOc9HP/0hIVc7w=;
        b=KLLHc9drTZpul79nRihIyI5PAyxXRTmdJkXV8pzA8J0w53gdZiHv+aCEKAOoj5htXN
         WukzwCYDOFLeN9WMRfuWgHNfFY3WTACBv3kpUvoltkku6OyB0kfynjWHVWqCWgGxymlO
         eARtdYfOu6/d+ODhfp+g+RM5KlvTXdN6fQI5IhyYHO22XNZtH0s/N+G2KS2uTcRPl2/R
         92Wq/IBaQjOpleIN3NsSVRoGqaYsFbLCogPpYOWc3A7G7eQgfVjOSFDzxZwKO2hwgmsy
         n2AT2E+M/PFLrO0q9yRstAXHsI3rmIju8eUFoKv0mMzTEhMbUudGiOCOA7/qgfET06ZK
         XkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5g/2NksbO4TUZ12uNSjT5a+ira1ltuOc9HP/0hIVc7w=;
        b=z4pmQ+Exc/i1vwmLI0Iro4sGiSqyeXF0/7FQNV4OVvuR+TBd0Iy0Tkr+2305acc/XM
         5+sy3HPNBrNb+JtY+tgRoaLie2lHspcEMNEKlL3cp7aJ6Dn6pM38wYn4pNiHL25uaBjN
         +T1wQi1oMyUktIp0pTySK5GDQQH8uyGdeyuI6fldo9g1YUC85g2jxprvUckSzBagzQ+E
         gefhleNPT3St7PkJn1SdVCZ1H5IUQeGEzYo3BK4HJCSQcMvm3Na++iYvx4Hf9tJto1qc
         39JPzefIzzRp5WKRcVEpWcLdmXUKnae27+4bVvwUxvl9mwlseMoBRX8D6RgS3y4QazTS
         qzAA==
X-Gm-Message-State: AJIora9Y/3ynX9679eiQibiljo/eCLKYRHKiRXfj458UO8+sRQRZai60
        QDMv8Upd1k2CJ7lgQXqfd/8=
X-Google-Smtp-Source: AGRyM1skthwwca9xztYJduWQLAXrcwAXdYzCophm5dltSeq/9zR0kDVYVJguSnQHST3WWGzv/qygdw==
X-Received: by 2002:a63:ff66:0:b0:412:6f4c:1e11 with SMTP id s38-20020a63ff66000000b004126f4c1e11mr15162809pgk.396.1657529428611;
        Mon, 11 Jul 2022 01:50:28 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b21-20020aa79515000000b0052ac5e304ccsm2489388pfp.194.2022.07.11.01.50.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 01:50:28 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v3 0/2] Add USB2.0 phy driver for Sunplus SP7021
Date:   Mon, 11 Jul 2022 16:50:01 +0800
Message-Id: <1657529403-18084-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for USB2.0 phy driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Coretex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  phy: usb: Add USB2.0 phy driver for Sunplus SP7021
  dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver

 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      |  73 +++++
 MAINTAINERS                                        |   9 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/sunplus/Kconfig                        |  13 +
 drivers/phy/sunplus/Makefile                       |   2 +
 drivers/phy/sunplus/phy-sunplus-usb2.c             | 297 +++++++++++++++++++++
 7 files changed, 396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 create mode 100644 drivers/phy/sunplus/Kconfig
 create mode 100644 drivers/phy/sunplus/Makefile
 create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c

-- 
2.7.4

