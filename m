Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4997A4F5C3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiDFLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiDFLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:34:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CC57420C;
        Wed,  6 Apr 2022 01:25:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f3so1846350pfe.2;
        Wed, 06 Apr 2022 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IG1tkBL/llWliJGxLdIJUi+tn1T0VL64oyH/UZUw89c=;
        b=QPJaob3DWnJOF0A5Bd6wMkgO1PBv7eszJS0ISBhTZWYdryyhjUFV1fRQfPdTa5hQCM
         W43X8dLDty/J7+imnxV4BC4Sbdpu/c8g9csxKqh3vhETdgAqakN6rBjzb9FT5kj1JxtS
         JiDmiEUKDLdbSsvaHEA+UGa9fcaZ64PN2AqRpkctCRix/B9e8RfgLloBY3J/7HxtQeMU
         MaE6pQWqqB3++Fc0xT5aYkq25EQMcw0H84GeATO0dn2F8V0Ps0AvooJQ+8p12XNeb8uL
         KL2teXJ27f6DZhrLWPY7wn5HbGuM7srf0u8wtC2BWCnwwVHVyqBdzqBwH0rAT5a8L06e
         Ukjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IG1tkBL/llWliJGxLdIJUi+tn1T0VL64oyH/UZUw89c=;
        b=5itJWm/Yqj3YWoDiTSliCiwF0V3U11/FSdCDt1LBczUFgnMoptGIf1BdA07839yw7X
         EAHfzWmj8MHj62297P42U01CAEaUvCwhx0sAlUPN/en8C+9b8gNnJV0iNphwAfxVcnYi
         ZvmXCcBHxysTIajGSjYVWgr1FgHmUpDPSZGIyJgSpf60HzBm+kSEuyTkWhSE+FpC71qT
         zKkOXXIZtzBKkLzh56B4a+8TjlJnZ+rhmP2IcNM8FVw4nnxE1GiYqbvE1NMQHbLlOvkm
         14VlmG5plukdRolnPVSu0cOMihnlqxidl88ZDP+mEtMo5Fk8GE+il4KgHfk7z1jhTdEr
         TXfw==
X-Gm-Message-State: AOAM532ZVUrKdqxCvkwLzIKRTSnt53AfCQdjXrrcviDLtfaHVYQ2wXpQ
        4a6yHfSN9ZrS3rYbzOhA5HA9SIs+xNg=
X-Google-Smtp-Source: ABdhPJxS+OZSD/1fNuIFWUZ+3YRvhsEiRlApfi0syLrgD0V6D3u3WlZsVQfyKKCvA5kQQRa7jnFHJw==
X-Received: by 2002:a05:6a00:1786:b0:4fb:266f:b184 with SMTP id s6-20020a056a00178600b004fb266fb184mr7677981pfg.10.1649233544284;
        Wed, 06 Apr 2022 01:25:44 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 68-20020a621647000000b004fa763ef1easm18052948pfw.125.2022.04.06.01.25.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:25:43 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@penguronix.de,
        krzysztof.kozlowski@linaro.org
Cc:     wells.lu@sunplus.com, lh.Kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v6 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Wed,  6 Apr 2022 16:25:30 +0800
Message-Id: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
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
 drivers/mmc/host/sunplus-mmc.c                     | 1200 ++++++++++++++++++++
 5 files changed, 1279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

