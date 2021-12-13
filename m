Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD065472162
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhLMHKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhLMHKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:10:07 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32CC06173F;
        Sun, 12 Dec 2021 23:10:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u80so14102686pfc.9;
        Sun, 12 Dec 2021 23:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DbYjXsVsDnXf9MOGkA15Ub6YmWn6ZhOqh6fUQBEWTkQ=;
        b=dgM5jZrmjTluHCJALfo6f+Q76t7Hnuy6KZIe7jIfPmOeOKzh0NDYXXBl2Zd/UXobqZ
         kSZWkrrhVOQAHM6hRxceuvj4BnYy6xGbiXTqZ7kmRLumGx5fO+8fdMx9i+25X5s66Ngf
         RJ0jOLYsLQD0oJziodsCalG0sHfEqfHnXrbieg6GRMpe+oWwR3v36smznQ+v+ltuJMdp
         zf6sgO5xLCT69y/bOv6tPbPp++YvS7qCfBwcb+k56a6+MTKhLhU8U7Sve6T/qgJBnjU7
         Z7a0tdwSxejSAV144xTTQzS1gdjGg5hqJYrUzvuFVXgCPLKPY3+geZB834raPZLwT83x
         o/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DbYjXsVsDnXf9MOGkA15Ub6YmWn6ZhOqh6fUQBEWTkQ=;
        b=lFCY1z582tr2oaOkTm8LqnJss/bRO+5QcWK2iHUcQFPJVoZ0AbUwnfGPaYy5JRLTnU
         Vr684IGaFmxJLTvKBdwk9xwO/hCArNX6mKIUgiGE7N1IbPkq/FKMY94izyhTnfzhW5+9
         eI8GyAKTuiy5+rouBRjWh9skwu11T004M5NXhKzlQ9fkMfXwgyzhA4Qzf9NXHuYBLRRs
         tNeZ20nkPHT2+aj4Ij8+CqX0v5NLd4yr/HrubbjYpxvNZJ1yv1dDjMSURBLIj6hCyh7r
         XLpPcf8GnyRbueQEp8V8UP2nS8SgjVKwvcmpg3qcMcMg1LB/cl6qDpUsV1p0nB4lOT+G
         L4JA==
X-Gm-Message-State: AOAM532zYSn/hQ9eZ977f37Yib1qclBIsCUHghATejs2XCHn7nbRj+UM
        2nESwuwicnpA7EyoCY8aX5E=
X-Google-Smtp-Source: ABdhPJzpwBBJFZunMdShxanDdF5UXtKTmueKU4k5E3tKqH/2iBGT0C+ZdprB0EwtWC/2MbgmYGZURQ==
X-Received: by 2002:a63:a50c:: with SMTP id n12mr18393607pgf.558.1639379406513;
        Sun, 12 Dec 2021 23:10:06 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x16sm10601848pfo.165.2021.12.12.23.10.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 23:10:06 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v5 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Mon, 13 Dec 2021 15:10:05 +0800
Message-Id: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for UART driver for Suplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Hammer Hsieh (2):
  dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
  serial:sunplus-uart:Add Sunplus SoC UART Driver

 .../bindings/serial/sunplus,sp7021-uart.yaml       |  56 ++
 MAINTAINERS                                        |   6 +
 drivers/tty/serial/Kconfig                         |  25 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/sunplus-uart.c                  | 782 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 6 files changed, 873 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c

-- 
2.7.4

