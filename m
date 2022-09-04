Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50F05AC534
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiIDQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIDQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:02:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08A12F396;
        Sun,  4 Sep 2022 09:02:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v5so6369928plo.9;
        Sun, 04 Sep 2022 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=eM8F7ERjbTNSfUMDIdi+wOzbv0OiZ6MXdcVdXb0RGlU=;
        b=JUyekAdqWL6BWjdTQxHZxBT4ve7+krMeTGWsxyjRF9xcYactu5WeJl1kDssU87WgiG
         pPOUzcz7QyGL5l9pCQ/JMiN6DYWEwp72sW9xsXey8I1bQEAl8kTDD1cWntYY/h6bSVc/
         GwOAv+I0o5xRPY1+KYFQhJ5fcLhCFyp/aMzITvVdEtMd66xHcjLkg4c7M53xBnQ5Qct5
         A7UNg+uWyynjDdEukzT44NH5jjdxglrtbyE06Ddj8REcZeH0HHAy70aS/FBWf5m/33oH
         XSsyZAkgaNvq2C9xsUV3YXNdaDIf6DhunDZVTdef2P1MYVVh9j2klYShPT97bbNj3nsS
         h0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eM8F7ERjbTNSfUMDIdi+wOzbv0OiZ6MXdcVdXb0RGlU=;
        b=f+1oJLsWULwNtq1vwA0vy3D+1F8y4mOyzzD+qMey2DmAtgDiqth/eslsNP9nXNMRF1
         I6GY6X67lE1c4bFX9sJOzdCwfI1cieOscTwox/QyRbFiRqOunyUVIqnkLnhdsCTIdpIw
         9rxuqeE7kYJu5HJE+QFQq97d4zwhaBXr93f18qqazbzeS906GzFt91R6GhmEPEYFakoy
         DjWIpUa7+Ihrm1gIJpx0SugtofeT7uEfdoyBTN9uBtumZmXu2EcPtj6+oyYlVw7GyttY
         7MM+TTWYijcJAQgyUhekJGj42qDs64yoCYreWiBpNHmC22HfN1S8DHcBFWFmfTq1adzr
         ITpw==
X-Gm-Message-State: ACgBeo1k4jxdY7jdnjqu2bcTkX03GPw2XOERLtdAzyu/sl4xPyJUrfA0
        b9th6y+5SMhrdNP5KDcSVgQ=
X-Google-Smtp-Source: AA6agR49M0ufTUH463CqIcH75mpCvMORKqPWbjYfmlQINO1kvnUsjgfuhj9JQJ+qWF9VHHNolZfQpA==
X-Received: by 2002:a17:90a:8d03:b0:1fd:7012:9096 with SMTP id c3-20020a17090a8d0300b001fd70129096mr15275129pjo.225.1662307334465;
        Sun, 04 Sep 2022 09:02:14 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 205-20020a6217d6000000b0053818255880sm5739390pfx.193.2022.09.04.09.02.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2022 09:02:13 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.huang@sunplus.com,
        wells.lu@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v9 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Mon,  5 Sep 2022 00:02:00 +0800
Message-Id: <cover.1662302950.git.tonyhuang.sunplus@gmail.com>
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

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |  62 ++
 MAINTAINERS                                        |   7 +
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sunplus-mmc.c                     | 964 +++++++++++++++++++++
 5 files changed, 1043 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

