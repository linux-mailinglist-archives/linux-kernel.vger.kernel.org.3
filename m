Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B98A4DE503
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiCSBvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiCSBvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:51:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2220D50F;
        Fri, 18 Mar 2022 18:49:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n2so8444457plf.4;
        Fri, 18 Mar 2022 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Q02eiM3XJSRXNKlCMmRjIwRa2jlfkAb9LyshPAOVqOQ=;
        b=NQk0sloTCeVMjv6qT4ZA1yJLqMWXvZgWPUVOuFiedFkXGt1CKRcCymZTadxu2NTHkd
         cwGYZjyhxtYBa4qwDpEtWVWkoXKWcufWKn5jtQaZqZqLqtEnxndOn9ykQgVv4WZt4GwZ
         BW4Sgdq0UpLzTZYDreAZ1VdIph2SqUPbNjIOpe8U97OXSHdgzGZLA4ts8Sx3+/Hr1b51
         ToDeOSEkKRovPMn+kTEGsrgyhKooNOIPdVXK4yI9r3SScxz5bDU9kM1tBERhZEz6pUd3
         P/zzMaKAklHdAcZNu5OtRpqmmrgMIEnTlw/je5RaAiOBg1h5nkqi8yQePXmUj4A9TWnz
         1GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q02eiM3XJSRXNKlCMmRjIwRa2jlfkAb9LyshPAOVqOQ=;
        b=bnKhhsq2gRJKRWSerOViWoQfdm9n6ni5XA5L+PvCkFsNQAvYFWF3EQepN444XpCFfj
         wFGlywT7BoWmI/nx/JdGDopz5HnePY2J7fAKMRESI7/oYCQ1zBIPNm8QXDQkV0vVfE9O
         L1g4rZHeGD9DKrDHYR0G45dwQ6kdAwRwpr9gsCzq1VcdiS1NZVo8lfaQ1R4/KKSmiNcf
         OR3oyiGe/ypRUKCcLqeacJnOLN1GsQmXc6Q4UmVSNjuNt1skwqlfqllx2H1cxkLjfbr9
         L4aBjZ4jWmE2f7pq0y6c/698OBg6Y/UbZB1wcuLIRhQSeiWO7Pm+ChVWQw/qxczC3u4t
         HgEg==
X-Gm-Message-State: AOAM530tOJFXqD7zkraGMxJBF/MKQxQGKws4pfR9km6etJaqu7/yY8+s
        sKVdV0fRfgQF2/m8+e2SpytaulpXHSs=
X-Google-Smtp-Source: ABdhPJw0jscNMSfB7pOIIQFN1e3+hXBhAY11gDdy3cDRTQGXy5G3Bkxu9SEz+zb3rEAG6R0DIrAMBg==
X-Received: by 2002:a17:902:b097:b0:154:2bda:bd38 with SMTP id p23-20020a170902b09700b001542bdabd38mr1126028plr.155.1647654594199;
        Fri, 18 Mar 2022 18:49:54 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm11738659pfh.143.2022.03.18.18.49.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 18:49:53 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v4 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Sat, 19 Mar 2022 09:50:10 +0800
Message-Id: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
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

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   79 +
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus_mmc.c                     | 2195 ++++++++++++++++++++
 5 files changed, 2291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus_mmc.c

-- 
2.7.4

