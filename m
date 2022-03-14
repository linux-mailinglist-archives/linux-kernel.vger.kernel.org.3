Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2A4D7A62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiCNFdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiCNFcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:32:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2223D48B;
        Sun, 13 Mar 2022 22:31:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bx5so13441775pjb.3;
        Sun, 13 Mar 2022 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=akKkIRXIYhBfccu9aWc61gGlpCUxaFUU/s3JqogAArE=;
        b=PjSfC0ps/xLgBk0pinQyRDBs38fuyDGJcMDPsEO6Ybob+NY8wuMkS4zsycPkrrma30
         T8JyOHKq9MiMwsThaB8sYZIqgGSor7JD+fkoH+4JS8qV/50Yd52Vt/HHGtKVCrt/G4v3
         Q0wFymH1HsMVn23uGiQP0hRVCJWx4jGaSYa5EfLgGTCliMWvadj5cIE9Sv9J0XDNa3oA
         QQqsja+PGf22wuxuddxlRDlxUlsq09KcUPG9YCxH9FXZb2RZIlVc+BcYCns92p2WJc8D
         0EA/WbheX4DeEj8Awzp6NmyiX8FKoXrH4u7OgWwrK8OY0b+yThAQCypG6xiVZaRI0+DV
         kubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=akKkIRXIYhBfccu9aWc61gGlpCUxaFUU/s3JqogAArE=;
        b=xC7Zl1HrGCOXK/JNXxn8Y3rQcmx7ifBiY+QYcOuv3Hjcqx4iRsJf4+LaPN1zarw1Wx
         Ab39yuFfD7TO3Uut0c+7JiLhOe4kzWHxonAtyMVkaFCbFEF+Qj3kNPF9BcRkQurnr/C2
         xZRax8GPjD1dKJuPeaJA2TVWScdIhpOjeA+71wmG/wrP87/WB+yR1X5mEgt6dmeJhT45
         LdUf0nzI8J037RQwUzirpGfMYVsgj3twjqIV2HPXsqv2BSkOK/6mTuN/Cm7rt3NU6/Sa
         e+UpbnyKD87Ef4qnrWfXEMmanRR2dnJZQQlb+Ge+I+d/hUJWsYS6BpcrXs9lQ7scLtv8
         d4eg==
X-Gm-Message-State: AOAM532AfQmsu3yRXryOLXao+1/UHoyt4NqT/3C8AfB0SXkMrfNZ45Sn
        02oJnZUhzjMyw6RMwrXk8XM=
X-Google-Smtp-Source: ABdhPJxNDhQJUyQ1uPSN7wewJAogWSlX7OTyxUczXIhWuBXsXOtIBgGvDEiETvJMddgM5nvdSxvx1g==
X-Received: by 2002:a17:90a:6c01:b0:1bf:1e67:b532 with SMTP id x1-20020a17090a6c0100b001bf1e67b532mr34555036pjj.138.1647235905130;
        Sun, 13 Mar 2022 22:31:45 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id c7-20020aa78e07000000b004f6e4d8ccc8sm18116376pfr.163.2022.03.13.22.31.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 22:31:44 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 0/2] Add USB HOST OHCI driver for Sunplus SP7021 SoC
Date:   Mon, 14 Mar 2022 13:32:02 +0800
Message-Id: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
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

This is a patch series for USB HOST OHCI driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  usb: host: ohci-sunplus: Add driver for USB HOST OHCI in Sunplus
    SP7021 SoC
  dt-bindings: usb: Add bindings doc for Sunplus USB HOST OHCI driver

 .../bindings/usb/sunplus,sp7021-usb-ohci.yaml      |  69 +++++++
 MAINTAINERS                                        |   7 +
 drivers/usb/host/Kconfig                           |  10 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ohci-sunplus.c                    | 202 +++++++++++++++++++++
 5 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.yaml
 create mode 100644 drivers/usb/host/ohci-sunplus.c

-- 
2.7.4

