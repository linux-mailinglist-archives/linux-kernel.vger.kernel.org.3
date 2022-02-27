Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACAB4C5A4E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiB0JvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiB0JvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:51:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7556404;
        Sun, 27 Feb 2022 01:50:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l9so7894214pls.6;
        Sun, 27 Feb 2022 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=0DCsJEgYCR8I8HZ/v5w4ZJgzjo6a8wTktOr0T/UncpY=;
        b=lGGvmjBy2LqPrcywkKkje1CAH0aMeOVUbimwU+mltvcZxS1454kSy7WozIGPbWz45j
         IL9Y5IjzYdkrI8DFVRcWpJM+XH1+yKfo/C2VkQtj4FMeprdXWlTV/zxhBVEf1SzSPo03
         1ly9rw8hcM4Ao/bUgHb8rxZBViB1uVAPOW/ulb7161GpboNoAIGhKE2tAhQQW4OnJtnr
         JfEtgN+4xY+4abM7+kYjHp0/YguBuFevFpJN5d2K72HieTQcpJgBALPRQ30/f68s2P3V
         I9FivMaczC+tIf2TIhUdsoZG5n0w2WBCqydzHW1bjsfKU2XYqhXKBWzo9lTRCJqtBwJ4
         cP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0DCsJEgYCR8I8HZ/v5w4ZJgzjo6a8wTktOr0T/UncpY=;
        b=Y0TR18y46qbhkvobZcusijSMrIZkJqVjoLturoLbyJzAro1R6QekCLmDlSFqsbE+Bi
         3zrC4e7kmW6amVWu9ZqZ98u8qyydJbYsqBBNpk6GIbJpAblAQT2xiFWBdSNuC3I3lF9P
         6XAwZcQdN/e4wqhhrqRPhMFqjniZsSG7sRQ3PbKO9X6TM8m0MUjeYpoTb5otv78rlk5Q
         qo9d1ybZIWdGK/QHvMa4mytiU3d+YCIjJspyBP+YjXXNygULFkcDNeEEUOHLappr9XOM
         IoSZcRakmbqjrHXChtikXJAz7oLNA4JIcwUVmCwBTVgYlQFq5f8x+N87gbF1y1wDtThw
         TsoA==
X-Gm-Message-State: AOAM531McQeGR7+wUgf4YHBRJVqtYkPmGTMDBSTuHgyjU5NNoKKYDinb
        7lZ/gKJwwDVcPWHw3PkszbU=
X-Google-Smtp-Source: ABdhPJziWeUJbfSpBuaz+yLKcwXzLcoMNGdL/RDfMWUB+MFDYBLZ6nXXiJUFMtBzqaVkD2YtYOYJiQ==
X-Received: by 2002:a17:902:ab09:b0:14f:c4aa:16e2 with SMTP id ik9-20020a170902ab0900b0014fc4aa16e2mr15524879plb.85.1645955426048;
        Sun, 27 Feb 2022 01:50:26 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id o185-20020a6341c2000000b0036fb987b25fsm7473334pga.38.2022.02.27.01.50.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Feb 2022 01:50:25 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 0/2] Add driver for ehci in Sunplus SP7021
Date:   Sun, 27 Feb 2022 17:50:39 +0800
Message-Id: <1645955441-6496-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      |  97 ++++
 MAINTAINERS                                        |   7 +
 drivers/usb/host/Kconfig                           |  11 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ehci-sunplus.c                    | 495 +++++++++++++++++++++
 5 files changed, 611 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-sunplus.c

-- 
2.7.4

