Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7A4B4429
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiBNIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:32:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiBNIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:32:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25225C69;
        Mon, 14 Feb 2022 00:32:34 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w1so9962829plb.6;
        Mon, 14 Feb 2022 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8gQFvMqCWneRAyNIMSowMj+TZ/71yfc5+xiRkK2xGUw=;
        b=qOANxSSKevLELIY7/9TQCADj8megS40pp+70mb6AjMi/vsaYPqxr0QzjBM3KMSSoa3
         X/Tb4YaxejcBuIx+/3e4LLK7yzZPIAjpdC2xdiiExxpvKJBaOjrZ7++wR+mUUclqng/C
         b9cZBP4xiNS1b2RyATKy0ESU+U0NeHFzOhfHSWFwrmonICWl1HXgYvDAQgyRanWSNIjh
         Tern6YYi8OGp6s/qhPjy3MZW3rM2oeCkDYfHUI11tmqfT8Fd7Y7EmjqvjYAwLggVgdsN
         anoaoOjN77Z6qJvqWJDfI+7dc0cQues94rPtRSdJhhv0yZzN+1l7sR4kV7bIZyzoGwHc
         nIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8gQFvMqCWneRAyNIMSowMj+TZ/71yfc5+xiRkK2xGUw=;
        b=jNQdCDCQ4G+vG5D1ufRuBiMznt0JNouewyDWEbFFsdp/dYRLUUqRNTrnQsZUpXVWxi
         fiZ82M1AbSWlKa9uPr1c9PhC6SF0PBGoxjIKMhctktfKePdLh7hJZN0dKmuqsJhDT4PL
         /i6HbnWCicYgkzEEYB2SaVR3QukHBKLnJzsUg0bGyBgPlSkprA0ET0kbMROGpjk8y7zt
         7RV0/D2qhU4wGWHevEPfNNJ/D9MAk70U3reqAVtMiESwKhJUNTK+ijYW5UR1r4/xKr7o
         JyZq7afBBUUN0txI2Ehu0hrtRdxtBlTCfIAAKAJ9UVuKOXISTos0TkX9v9dPbyJTnAyo
         xzaA==
X-Gm-Message-State: AOAM530cph7Uk4h+rbKjWOPNgrCdHtEdDyVKO4ER64UbjvwS1NDv8UMa
        DO8gr4zCEOXeYimcNRwh/0w=
X-Google-Smtp-Source: ABdhPJx7Vc5MeqxY7oO7Ta3x45e5KiY819c49HirT3AlLbENtvBRFRJcY/mbrmYg8OdN8uxQhCtbHA==
X-Received: by 2002:a17:90b:512:: with SMTP id r18mr13556916pjz.232.1644827553873;
        Mon, 14 Feb 2022 00:32:33 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 84sm6583420pfx.181.2022.02.14.00.32.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Feb 2022 00:32:33 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 0/2] Add driver for ehci in Sunplus SP7021
Date:   Mon, 14 Feb 2022 16:32:40 +0800
Message-Id: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
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

 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      |  69 +++
 MAINTAINERS                                        |   7 +
 drivers/usb/host/Kconfig                           |  11 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ehci-sunplus.c                    | 527 +++++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-sunplus.c

-- 
2.7.4

