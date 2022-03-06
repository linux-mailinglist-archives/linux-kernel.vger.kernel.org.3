Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43A4CE972
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 07:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiCFGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 01:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCFGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 01:11:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BCC47568;
        Sat,  5 Mar 2022 22:10:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p17so11172655plo.9;
        Sat, 05 Mar 2022 22:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bTdhh/5VMjchowHJrtU9IWxfTRNg2byjdSu19Bb5sQI=;
        b=Q8ZJxtPz1iuCKhkBpauBxAg34PB8IiG3TlPdQb5sVTGC0Z03U/GY74mYQQyDV4yMVM
         lK3YjL0CXuL0MKxL1rVGEZWWjZlGpWnHOI5INEm6MDepsRlHqyMQWMXU0X1lkZuXCcOs
         JpSTBSYzT45Z7g3d5YQD0Byj5tMf1zr/a1WsP8AZ2cA2I2Aj0mQEX69SPUP/M5u/GLPU
         slKP5A4vyHZt1GsiSQPKvc6IPyXQdWz05YJpxWcd+bUwuzeq+MGmhf4hYeKK6mPAzm/8
         WVHPTvO+VbyuMoe6nnXyx+GLWt1P5/QC0eTQ9F5RMUgibgtHjnUWsoKHGaInEYrJYgtB
         RHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bTdhh/5VMjchowHJrtU9IWxfTRNg2byjdSu19Bb5sQI=;
        b=KvO0F1GBT4xBeyUGOsT/vxeJkT4TDimM843o+zTE6uBkQYrkBrP3hOlJ/tTipNKOyI
         FfSWkch4hbJinA1T3lQ55gRWaUd3pN7gGT+sCQuZ3v2rl5g8RZGqtQboxkdOJNx3B7nc
         J8kfNA3rfxRgSumcidlmYVY2oN117kyNntROOAwK2uQEtBAMTC4GaJ9/Vkl3F5528LC6
         Ood8dCcnD6HJfYXLToGj1LhWQ0kK8S1w2facByNcf5qdOpUOQRBTZxribAs3q+YahEdh
         +Lm9hIdQ7A8svLmRNETmpdarFntzwiK2H/ZGrvneN0kWhdu7aizI//i4lesePL1/o+Ya
         nMeQ==
X-Gm-Message-State: AOAM532JEc5Y/lZRLbSJX881RaWAPFNj1kCGLnNnCIvVDO1LpG5+260t
        AYcewJXjQR8KBeOWedhWQLw=
X-Google-Smtp-Source: ABdhPJw2z78XNkuUT+CrMuqMagiZ55nNkVTmvHIhnndayAsPH+/VyihABGYebe0LlQcr4NMEk8U/RQ==
X-Received: by 2002:a17:903:1c8:b0:150:12cd:a02d with SMTP id e8-20020a17090301c800b0015012cda02dmr6412993plh.174.1646547018666;
        Sat, 05 Mar 2022 22:10:18 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q13-20020aa7982d000000b004cb98a2ca35sm11994907pfl.211.2022.03.05.22.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Mar 2022 22:10:18 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v3 0/2] Add driver for ehci in Sunplus SP7021
Date:   Sun,  6 Mar 2022 14:10:34 +0800
Message-Id: <1646547036-14885-1-git-send-email-vincent.sunplus@gmail.com>
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

This is a patch series for ehci driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Coretex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  usb: host: ehci-sunplus: Add driver for ehci in Sunplus SP7021
  dt-bindings: usb: Add bindings doc for Sunplus EHCI driver

 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      |  63 ++++++
 MAINTAINERS                                        |   7 +
 drivers/usb/host/Kconfig                           |  12 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ehci-sunplus.c                    | 241 +++++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-sunplus.c

-- 
2.7.4

