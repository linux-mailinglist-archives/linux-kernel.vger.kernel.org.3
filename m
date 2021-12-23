Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0443A47DE72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhLWFGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhLWFGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:06:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9158CC061401;
        Wed, 22 Dec 2021 21:06:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so4613897pjp.0;
        Wed, 22 Dec 2021 21:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XFoLoAfHvUopZGfcI85P/HbrBRpFH7LK7Y429vPP4Ks=;
        b=gudjkiSFEMIjShAdAtPshkLMKvpKkGIp/D/FfV2XNe24yU1U4J5C8ky++TXjNMKwju
         IStLeqpQygcpdgXBh9CBRVZqhjv1B0/X112Dv+zrHQKrWgf87QDljyMYz3+bKrTjkGn6
         OH2MbCoBL4lZvXkm0UrCIXe+2CWD5BSPbe9tP7bmJxKSgKaV61WvyhcI8acq/3AVhmfi
         3AIso3vl1JabAM5vJqHhk8BkOs+KS9pE1+sDcVrfM80+XM6fb3wjTmw7lRSL+PV/8LRZ
         J02ecdWpEHwgm0La6eNXN5LvggrkW0i0zPsSYh4fd4ozX9dCNR79VLmIfdbEtRW4Iyn2
         PANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XFoLoAfHvUopZGfcI85P/HbrBRpFH7LK7Y429vPP4Ks=;
        b=mN3IHTCAbpV6MxjUdmTrfTuJ85Nw8OXUHU3MnDKzEIeKzfyIOxditr1YX0jqPV71oy
         Nlr/9lswUPy3XQ6Jj4U2zqOSAg8PQ2BMx7fjz6EJ1a3vJu5heBcqSk595oT/rx4BQSWR
         QawvcrAMcKWlEEqz6VMj0VgMj6X8eBl9j4i0jLaRlxLN1oQvoA5HJf7nxhyjbdBcfJ5g
         JE4uQW36UPF4d39G2h+PC7VqxPVqzxONIY4TrVyhxxmxgsQJEiVgsidx0n7cs5jaAcVv
         56eodNsk9+5pMB32ReyshjWmiyrEsxCTFNcRX4VXMQ/u3zMfHVrdYFdJnRZEHNSlynS/
         5gsw==
X-Gm-Message-State: AOAM531iFiyCCmsMGlUY3Es5g8P1spvE56YkzyOyCZkKH1+4T0i5UBSG
        i0u2+5n2tZQSm7oKGGLUhK8=
X-Google-Smtp-Source: ABdhPJwzIzHkbEZ0uhJygATvC4lYyt2Y6df98Jg9YbOzYK6eZit1E9XRTN82W+KZXqBJY6KHuWIS2w==
X-Received: by 2002:a17:902:e541:b0:149:2af:fa6a with SMTP id n1-20020a170902e54100b0014902affa6amr926124plf.27.1640235978886;
        Wed, 22 Dec 2021 21:06:18 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oo13sm4170936pjb.25.2021.12.22.21.06.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 21:06:18 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v2 0/2] Add THERMAL control driver for Sunplus SP7021 SoC
Date:   Thu, 23 Dec 2021 13:06:24 +0800
Message-Id: <cover.1640235724.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for SPI driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  THERMAL: Add THERMAL driver for Sunplus SP7021
  devicetree: bindings THERMAL Add bindings doc for Sunplus SP7021

 .../bindings/thermal/sunplus_thermal.yaml          |  49 +++++++
 MAINTAINERS                                        |   7 +
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 161 +++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

