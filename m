Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4D4AB4FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352066AbiBGGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiBGG34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:29:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD1C043181;
        Sun,  6 Feb 2022 22:29:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so1752740pjh.3;
        Sun, 06 Feb 2022 22:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=d+WkIuqvbZvnh92knm7pPSKCFdZnuYhm1crmhpRWENE=;
        b=VjkKtYRVlLV0B678djGlGhrqx+DTm+YkO1hSLKq9jhFo2pU/Pcrzb7ViPb+6C3ia1I
         qzFeUG6z1rjCmBdJQyQutuSy/e1KiPeSqmYe0vsnuE2B1rKibMG3h8TYXjtuvzhOdY94
         vAhXYU9TYurlh+dCTzNYmmSGoa09smI4zbshc3lhdWXBmVkfTs8paPEh3lT86WRt/uC4
         GJ+Gqin38QSMS/6V15o79zwuuIWFt0iMujhegYsqAHzRQqZTpzwT1nFqt7+IOr8abnOs
         V+vPEhrGylRZJtHrr/mUrqnhzkB4F60JYrpG1SKQom30vY6ZSNkc59JZPgLzIFzKyg6/
         REEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d+WkIuqvbZvnh92knm7pPSKCFdZnuYhm1crmhpRWENE=;
        b=Oy9ZD3MJxK3WqNhMxDCyZOwmoGFBSLrLMOo8diqj563XeL/ZVcmUltjNPAwR6oxk/H
         NM9X/pDYONEFj16asLj3bMtkMfYmiPKLCDGKhNYfLCkTN0sY+RAjqYFhE0grXbezl3Xd
         UA198CjVUspF7J/SVJmtYmZehiN0481Bf4wveaJ3ZvuEsIcvYfK2/kkRKBA+iRCj0wsH
         QwPiyHzSR5zfXCHdYamAIk4DS9SwSfz35tljQoNC/zDA1c55Goq7pPjJs/xjjeLmDNs6
         9ddKPRcFxWkuLUgXdLB3aXwKJ0+QXJTXIpY7e39jnZOg37Yj3JFp3wjX76EywZH/Fyqa
         vayw==
X-Gm-Message-State: AOAM530co/w2MtdODmCt1WaNV9S0dghFVDjg6loboAwnA4IB0I1+67mG
        gLC8mi/3ttA9tIjY3japqlJ8ozXQ++o=
X-Google-Smtp-Source: ABdhPJyuUTtUbmeEkhvuXOWYjb9HPcRwWawnznO7iuOezmhCZPM0DiqmAqvghCdOoKyVPlzF7EjXyg==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr14943943plt.115.1644215393972;
        Sun, 06 Feb 2022 22:29:53 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j8sm3994386pjc.11.2022.02.06.22.29.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Feb 2022 22:29:53 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, tony.huang@sunplus.com,
        wells.lu@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v8 0/2] Add iop driver for Sunplus SP7021
Date:   Mon,  7 Feb 2022 14:30:04 +0800
Message-Id: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
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

 Documentation/ABI/testing/sysfs-platform-soc@B     |  28 ++
 .../devicetree/bindings/misc/sunplus-iop.yaml      |  76 ++++
 MAINTAINERS                                        |   7 +
 drivers/misc/Kconfig                               |  20 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 463 +++++++++++++++++++++
 6 files changed, 595 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

