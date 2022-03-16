Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2704DA8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353423AbiCPDCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiCPDCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:02:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A145DE6A;
        Tue, 15 Mar 2022 20:00:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so1995373pfh.8;
        Tue, 15 Mar 2022 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=0vjHVqi+Ddx08szS2b3lBLBbrzzpz4a7Qqfw8HmDOco=;
        b=OcAbNMsTnhKB9W4pF1MQN30ldoyPE9dByvJys1PocCaEtk7TeWn7tuYNXjQckEesw9
         sl4zfv92j8FL9AXiRD2HzacRbqsnIV2GhpKXbYUDYGhoSAaSoMuILy5zwXY1etOHKLVG
         otYnrnHb5/4vOsawBDolDQ9rutxTQInSqiHs2ysbgVADQHq3YOse1DBP6WpZVsfvG/wm
         Gwf855nG+HopE4fVFkBlEvh9FYffYsez028VKFC7f7ury/hw1v5cJ33VSPY7Gzw2pAhh
         Ff7PegefjSMqJleWsC/q2tmYADUDMXgtcKBh83XiSN4SbqIMZVwpmr3Uch9pb4wBowao
         nd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0vjHVqi+Ddx08szS2b3lBLBbrzzpz4a7Qqfw8HmDOco=;
        b=cKLYDiG6fo+vFOpqVNQeFWaJtY31oYqGAVXwHfKExW2yDG1fuKi8Ku4lNc7N4oy3Z+
         MMqf7wQ7vPmpcLMS3ClCoNONXJYK9PnXTaUg00hrFIUNC/mOwTtMcvYRranm8sfbvI+d
         KHag7UJhjeXzn/kSN2w6eSVTIqXsPFSpFDMq/xoWVJI5JWW60dVqJRv1MSgAvJ0vO/Uk
         SoapSo5UWxdtln3r5QyS32Yz/PWp2KbcXBpKAKL1X48jgSTeyx1eeYoMyVqVq7KIP+P+
         Xg2tMmw1QiyzYUlyddSAbfKkJQOHkOst1uYUYqfLXSQ8umfBT4gn5VxDN7yJz1KYMLUy
         19/Q==
X-Gm-Message-State: AOAM533FluY992UcmNK8PjyIpeHvdqevHwSSMnhoo1QohJg08d08sgI7
        ABXDFZIbbcQ5WoHXyI0zLDN4MpyIgB1izw==
X-Google-Smtp-Source: ABdhPJzYkZsem088i2ABAGIv0OIIk+C4eBmI4C45VDIRX5Jj/sfbudnv2G0YqyPLTges4Y3r7Bhcwg==
X-Received: by 2002:a63:6942:0:b0:380:153e:63f9 with SMTP id e63-20020a636942000000b00380153e63f9mr27217418pgc.212.1647399646931;
        Tue, 15 Mar 2022 20:00:46 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm582329pjv.57.2022.03.15.20.00.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 20:00:46 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v5 0/2] Add thermal control driver for Sunplus SP7021 SoC
Date:   Wed, 16 Mar 2022 11:01:04 +0800
Message-Id: <cover.1647399369.git.lhjeff911@gmail.com>
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

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus SP7021
  dt-bindings:thermal: Add Sunplus SP7021 schema

 .../bindings/thermal/sunplus_thermal.yaml          |  47 +++++++
 MAINTAINERS                                        |   7 ++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 140 +++++++++++++++++++++
 5 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

