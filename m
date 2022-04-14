Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCB5004C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbiDNDsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiDNDsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:48:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF834D9CC;
        Wed, 13 Apr 2022 20:45:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso8115661pjb.5;
        Wed, 13 Apr 2022 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Iw5eztU8m7i+81sCTLbbKDJmKiwP0eiopjfIyARfjWk=;
        b=XV1pzfWFdEX9mQQYipJu2mwUUetQQHMopFgJ6BTBJXAVpSDR6T3ishzCHs+cpX+GTf
         EkJDJb0/0C/p4dNaiVK0VH1LGOgLgROVPHRZ1cJiH3jjwBtB6feHWiZHioX1HDWM/zKI
         bnOFTRECaPQ7zmde1BGI6o3bcFi2f7jNALVpnZ8fJL0/63r3khf+YvucmNqIyIUV6dqV
         0la/thepKXqcnUxzyDVeP++w/LDpXkixfom4VPk46TzY0fUMscW2enFCIiGPDHU771/U
         MFv4YhYCAQplZIvsRHZ0QfXb/xJEDHhIpj3f23AgZcs4WS1MIruKNpTTRJ/HZvxX7Sha
         Xmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Iw5eztU8m7i+81sCTLbbKDJmKiwP0eiopjfIyARfjWk=;
        b=tAisJGzgZpDtsG04jgcJ/oaO69ulNb4W1eEgQH7qbpO5kYMXjSjWYhHGkcrHslV6s8
         EPRrIRAMrac1FNP8JOTFXBfqMeLJIw7RCk/EdmYBBbhn0M8PIBFteutvhMw81s4nge93
         Noi9emcupBvDEUXm8lbmBxCwNj6y8tcy4938l5RUfw99n7vxvLsDm4gYoBMvWA+4EHoK
         LRUZlleAFmtsVoxt0asOCF/6Cp35lvKaY+xvKmU5E1hj8OBdkHQYpg0yw2Wt5ZerGKbc
         z6C6/lRFpclyfDo+ErLRLYIfFQ4RXQwGuyY9Ol9W+Z6+wH6Z11mHVUOo89rb0TzApYzO
         o0oQ==
X-Gm-Message-State: AOAM530pvJiq2r18yw9IU3zkNdV7dhqLywBYaRO+PzlKWnlqcok0VAGS
        fnoyzLZjnuATqr5rbdWrymg=
X-Google-Smtp-Source: ABdhPJwn3r7/HfokZxUsqrC8CqSjXVccSUNQsdR1KcFVAydmaHdrIvmjV5XwWtemMJDM3VbCcmbVCQ==
X-Received: by 2002:a17:902:e94e:b0:154:3a4:c5e8 with SMTP id b14-20020a170902e94e00b0015403a4c5e8mr45974658pll.19.1649907937193;
        Wed, 13 Apr 2022 20:45:37 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id l6-20020a17090aaa8600b001cd5b85d664sm3193854pjq.1.2022.04.13.20.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2022 20:45:36 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        kuba@kernel.org, davem@davemloft.net, vladimir.oltean@nxp.com,
        colin.foster@in-advantage.com
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com, lh.Kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v7 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Thu, 14 Apr 2022 11:45:22 +0800
Message-Id: <cover.1649903900.git.tonyhuang.sunplus@gmail.com>
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

This is a patch series for mmc driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
  mmc: Add mmc driver for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   62 +
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus-mmc.c                     | 1183 ++++++++++++++++++++
 5 files changed, 1262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

