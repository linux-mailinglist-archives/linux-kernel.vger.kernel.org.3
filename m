Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E98157F853
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiGYCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYCoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:44:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139CBC1F;
        Sun, 24 Jul 2022 19:44:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e132so9138482pgc.5;
        Sun, 24 Jul 2022 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=a4smhlXQRPY08uZFYWaREPplMOTenvaPYfLKafzeLgY=;
        b=g8KdayopTfm0rTuvVjbGJF0Fqri1hOHJ/P7xPCvZngTKUJJRFvxIFwtm4xvy66lOY/
         rN9J+SMwCFGJsTl3BVGUMeV73vqf31Re/WlsTKu379ZcSCC9Y1h4jOW3ncRNByVqmkez
         MdxlJCeeaJdco+5DGtXkME913JgG2SsLalxAjvJmNy8Tbd43s/YDGpjZIA3nveVzPKzz
         rmsdtGb7EEnaIs8ao+apTqcERdbSXcb0TiWX10+r0lsApqogIaYgoDOEoI6Vf8TMJlk3
         4jYCWywSmwZFHEXeChB2wtKaBxuStT7APFTcQu7zVWr/tjFFHsOmMi625vu1VcmnVRnm
         /JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a4smhlXQRPY08uZFYWaREPplMOTenvaPYfLKafzeLgY=;
        b=AwwVzd3FoXjuAqZfj3RTyRmjVr8PQaMyuMA2/RE4o1ndEgfgIeGimKMMjiwAvcu5iu
         AArYPguBMs4QHX/ejSDmLu6KumROgiaFeASw5jEqm157n8qW8YEI4bOzRHua8B05ZcM3
         kVCOHeESbwiogpVhcbGdbG2+LzzaIWWtUlDnhJMgZXbbDxSl3m/QXneswAgeoXreaszw
         /MTmKJldtUwqQKPTWPbKGqSumVOnVSHPPuERvA6TRADgFqiKuwO9lxfa8+luX2Uls+fW
         m8ARnh8aZzEmhFn1JlPKG1KwW+WhKJVHR/UU/E4Wl0bpBExDwa6doxFga1oC25hSEPhA
         I1wA==
X-Gm-Message-State: AJIora/AJt3m4qu24b0K8+8uG3nDBRjYGrQGpTaA9eWwb9yaCmmk6L2e
        jUCbEDYIMI6biqsL70dTcrg=
X-Google-Smtp-Source: AGRyM1skOhwsZ2B83o1MkEB/dH4BEcN0rbxltYzHhPOlyRIyTD6z+FBB9Pa0FkSEUY0x65BA++W/rA==
X-Received: by 2002:a62:1508:0:b0:528:be70:2f69 with SMTP id 8-20020a621508000000b00528be702f69mr10846563pfv.42.1658717070380;
        Sun, 24 Jul 2022 19:44:30 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id u13-20020a170903124d00b0016d1b197914sm7983304plh.90.2022.07.24.19.44.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2022 19:44:30 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v5 0/2] Add USB2.0 phy driver for Sunplus SP7021
Date:   Mon, 25 Jul 2022 10:44:10 +0800
Message-Id: <1658717052-26142-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
  dt-bindings: phy: Add bindings doc for Sunplus USB2

 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      |  73 +++++
 MAINTAINERS                                        |   9 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/sunplus/Kconfig                        |  12 +
 drivers/phy/sunplus/Makefile                       |   2 +
 drivers/phy/sunplus/phy-sunplus-usb2.c             | 297 +++++++++++++++++++++
 7 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 create mode 100644 drivers/phy/sunplus/Kconfig
 create mode 100644 drivers/phy/sunplus/Makefile
 create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c

-- 
2.7.4

