Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6232447CEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbhLVJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhLVJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:12:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7AC061574;
        Wed, 22 Dec 2021 01:12:22 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k64so1796601pfd.11;
        Wed, 22 Dec 2021 01:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CBfSdeah4di0RYShSh2rMeibOxUYRgUc2dFokC3MDPs=;
        b=F1ey74bq97uDtJL95JJR0TplMYCBicm6fktnA7NTjHxIFuZBLELmIUvgJKsljEsFcs
         jRBnSc5Vajm0UX5/gqdLN8AFmnYBM5JGTQltgxn3QzqoTn5S2OWrdYR+FJdmVx1EKRMd
         DM8c6wy046SpQ++LMh1pAoM6UZZoKa3hzrvXJUkHccO+OgUPmm8Do1sNnPpf9PYv1ZUm
         siUWLqxGsXZXmdebIvIZK14bNCjovKRrhDjY3SmC5ffAjwTtz7Ucdw7n/pNqHKq+tqkj
         3FJUk73CzVdW5tk0dbvk16e8i/FluCaE8H1S2UW5DBkNfFdpC3fMftHJhAJaga3oB1M3
         dekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CBfSdeah4di0RYShSh2rMeibOxUYRgUc2dFokC3MDPs=;
        b=p95AFf1UhqeegrzowP5Q0b1EA7btBBhKT5Bln3a0kT2CvUrF7b/xQGzyAa6cvppdwY
         dHKvZwIMwqSPztkyleNemsuFL5Gt16P0WexEUCmEw9eEE62hova0uGOSySkJaBruGhvf
         RpTpjpyxKEebq2/lgCUIU6A6Qs2oybIPMmK1GZKotapdl26BuPWUNgdEWcGgyfwHDk46
         XlPntEWBaiubr8GCLvEKq8kJVginasIq1iBQbi8ABARIe2tPfLJAM0C4NKQaAFuWGTbd
         UqT9ENb/J3m7q7+rulwfOsoyJyu+jyNlbeCJGi+3yRXiDGN6r3p8FgWxE6bMLyM8SQ7/
         uzmQ==
X-Gm-Message-State: AOAM532lvRu/IFC0cpNeKI0SY3c+/PHBlspdsbyCLfzlRJHJvOIl7EIv
        pSulQ9sM27fzAVC1jCBfPMg=
X-Google-Smtp-Source: ABdhPJx0v6korpyB8h6BDWyEOwqsxyPCZL9duyZc0agqAuGZCniOG6GcAsi3Yl8ykX7bLor6SFXhpA==
X-Received: by 2002:a63:d312:: with SMTP id b18mr2071718pgg.198.1640164341930;
        Wed, 22 Dec 2021 01:12:21 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id y65sm1470011pgd.79.2021.12.22.01.12.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:12:21 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, vincent.shih@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 0/2] Add driver for OCOTP in Sunplus SP7021 SoC
Date:   Wed, 22 Dec 2021 17:12:24 +0800
Message-Id: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for OCOTP driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  nvmem: Add driver for OCOTP in Sunplus SP7021
  dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver

 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |  86 ++++++++
 MAINTAINERS                                        |   6 +
 drivers/nvmem/Kconfig                              |  12 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/sunplus-ocotp.c                      | 228 +++++++++++++++++++++
 5 files changed, 334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 create mode 100644 drivers/nvmem/sunplus-ocotp.c

-- 
2.7.4

