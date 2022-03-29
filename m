Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320F84EA714
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiC2F01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiC2F0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:26:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921D1C3495;
        Mon, 28 Mar 2022 22:24:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so14906180pfm.5;
        Mon, 28 Mar 2022 22:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fKUQSvF1rxeZpzkW/pPa8pB/P3EaTdlnzpE0ZnyysTs=;
        b=NnVJzFvnWMycqFm0hrTuDP616OwjHd9UN0XrRDXmQsY7Vf4SVlrMDcmwJ+1NgbMxf3
         lAxkTIO+VbIZTFc/+pabwzLVDWIKzHr0Bcj7DJuLA7u/jv/clmmGjn4wkSSSGvlSCvpC
         bujUr46YODeShC/SLB5+iB+pDgP9tbsBa+59QqpViXFyv6wjuhQtZe8cwNug8zmVV7Hw
         fOS2GD7MdrYJF89K7p5fJ+ixkbaXDOkr7WDe1Bcw5TNYCxIF7k6IZEaWw2LiNMmpwd8f
         KZeAtD3g4cO6XnEoJiC8LeVG1JZcZ5KeGjMRemIKBga9cGauz2XE1KwxiClz1gY6QsTr
         U02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fKUQSvF1rxeZpzkW/pPa8pB/P3EaTdlnzpE0ZnyysTs=;
        b=D5JMdvPCckiHtqI7fPuJ5BG4Zk86IUgpSNe1xSKjYRB27JVISh15aI11K6X9jBiCGL
         3e4d62kbCgYvKZ62CtPBEBPzoIkAWZuKDjTmpYRGhIhKZpKigaBtIxCklEcnUHo+7GiC
         qJCIU30FvzdgOwA6ZuXs9ic07NtJJtm+dbQDset0XQLWlKTgu6UilFREMuobLO9ZQWPT
         X1LLubTh8eNAAi+kyWp1fMBsxLoz53Lzb2Ho6eqv6IG4z9S9DNfO2pOB2Hs8nE7bKM7T
         PdrhhuwElPYl7ipcO+il7SMNJJ0eYN+meD2HS1oSmgCq3iyshWg5EhkuW1VyZ8A8WM86
         HzAQ==
X-Gm-Message-State: AOAM533E7Qy6M9TURYukkyFfyhVENSVifWcT+Rpl266Yf/bN3gsU6/32
        XmHPIg2U7lYEcao+2zp+qAY=
X-Google-Smtp-Source: ABdhPJz6jupWIsoQefHVYGMb6coOXIlT2Nlo8YakLmyOgT8kIGl/nIB7JNaEyGJF1DVvCzzbsn2jEA==
X-Received: by 2002:a05:6a00:acf:b0:4e1:9222:1ef3 with SMTP id c15-20020a056a000acf00b004e192221ef3mr26278762pfl.18.1648531482691;
        Mon, 28 Mar 2022 22:24:42 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id cn9-20020a056a00340900b004fad845e9besm16690335pfb.57.2022.03.28.22.24.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Mar 2022 22:24:42 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzysztof.kozlowski@canonical.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v6 0/2] Add thermal control driver for Sunplus SP7021 SoC
Date:   Tue, 29 Mar 2022 13:24:30 +0800
Message-Id: <cover.1648531197.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for thermal driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus SP7021
  dt-bindings:thermal: Add Sunplus SP7021 schema

 .../bindings/thermal/sunplus-thermal.yaml          |  43 +++++++
 MAINTAINERS                                        |   7 ++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 139 +++++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

