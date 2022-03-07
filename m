Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA54CF0E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiCGFZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiCGFZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:25:44 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E837713F1F;
        Sun,  6 Mar 2022 21:24:50 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o26so12637436pgb.8;
        Sun, 06 Mar 2022 21:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sBs0g7c3eiiRDzIn9OKXg+84akXNbU5YGA45uOIsBGI=;
        b=SRY61KTFSOEutOMsOj0yyqdSkKS73lXb98tEFQ+u0In4fmQvBF5XApot+Xe61C0J8Q
         NO42Jd6zJsunH959LMMHnjr1Vs7zIfZPDKIVBGNFbzlnzrnibnrLRuoXCuDVBZiTLAZJ
         d2iE6zxPZRzjSc4Tn6zHNCo/dHYSW5NGfxIFVxZNAYlZUykYmrwq5j10/yX2hMyd5cIC
         KaL0QUdLxf9HtgnC42ErNWj+FYeQhxUznHZ15pnWZnkw7+ngnPbAXIbXe7QSM3EZXMzs
         FQo/BAptgzL+tTFVaFHnuaupDrKmx574KCXeVWind79qf60Vq9jZwmTz1QFEQIUgQo6F
         drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sBs0g7c3eiiRDzIn9OKXg+84akXNbU5YGA45uOIsBGI=;
        b=NyCWSJg9zphDO4ZwKuz9uzZhb3O38LDrZSwsHHFsa/m7xezn8QM80w0kATs3SAEyuI
         sd8F/9b5qSajcfTyiejCdfBk/A1X0ZmleEpXZ+xhnl1heL1fxcN05XVrgFOvsbmTtm3T
         7v8XD8lRZnP7AU0juVyknQFjN9Hw+ixbQdIE/puYqHYPNlDhSYJsbI4Kr1xvC0IcoOEK
         JWp6hXlrRrKXzUV+1d6oy9SHlIEDaGA8R1AcbTz7JDTj7V0OqpH4++Rro7rHz+CnEAp/
         z8mAwJHreXagx+ee5wl6fDDCRM3wrk8OtH+hAOAFYdf6l74GnXI/6TrPRN4fc9c2oW6n
         Sb7w==
X-Gm-Message-State: AOAM532cRf60NCnqnzegwrYvoCSFvpwF0NiqZqBl51MZ2snKAuSopFss
        b7aYHZPEbFHu0OTh7R0jvVzz4i8yM18=
X-Google-Smtp-Source: ABdhPJzzyVmlGJTfQnhHokej1K13burAVM1KEVsIusj8kJyzQ8+NI4ZAgrNyAm7qq2ziSwc0nanfSg==
X-Received: by 2002:a63:90c4:0:b0:37c:7f95:2fb9 with SMTP id a187-20020a6390c4000000b0037c7f952fb9mr8375675pge.267.1646630690419;
        Sun, 06 Mar 2022 21:24:50 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a170200b001bf2d530d64sm9767170pjd.2.2022.03.06.21.24.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2022 21:24:49 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        Dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v10 0/2] Add iop driver for Sunplus SP7021
Date:   Mon,  7 Mar 2022 13:25:07 +0800
Message-Id: <cover.1646629400.git.tonyhuang.sunplus@gmail.com>
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

Add iop driver for Sunplus SP7021 SOC

This is a patch series for iop driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: misc: Add iop yaml file for Sunplus SP7021
  misc: Add iop driver for Sunplus SP7021

 .../devicetree/bindings/misc/sunplus-iop.yaml      |  76 ++++
 MAINTAINERS                                        |   6 +
 drivers/misc/Kconfig                               |  36 ++
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 438 +++++++++++++++++++++
 5 files changed, 557 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

