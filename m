Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B5517BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiECCQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiECCQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:16:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB031928F;
        Mon,  2 May 2022 19:13:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g8so11267666pfh.5;
        Mon, 02 May 2022 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=MOwqrDynsILdhLPhrKZZELMK7J6DyMaA/5YQtV+LAIE=;
        b=RWDB81inAWrEzJg1Dm3EJSQOpikcE6oNRtOVl4+DGR/q9O8EojanZK6cobBrWELPqS
         KJ0SaPe4XHEwxY9PMFW8ndSpEE+AFlmEPu5cIoNF1/YSL6N+dG/51KSGQl8ufCj2h/5D
         oBcSI4X4k+jtoaICarHl40pKfU8LGfe1C/0BHdpNtw2AuBhfPN97jSW+WCvBnxn65Thd
         5zjKdArHDQimbK5ZIwX27+vlemSTlMD2T3scd5gybfGMTAOG9VUmK6x3YUP4ci7JlioQ
         cRklWavOgTBUhUDclZSwhw+wtnZZLiLHMw31+9WEAI6OdvKg26n2Z+bvUASqYj/nr5U+
         Z3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MOwqrDynsILdhLPhrKZZELMK7J6DyMaA/5YQtV+LAIE=;
        b=F37cTGCmN2tr1SRQfadaQ5O+NQ5h/mOuVYVCrLwslxZvNYX4B6UPgwzECzFg5EhFhl
         JKZ5DltI2z/SZYgka/Q1JvmT6iKVLdlfsZmti3VuCRlP89TVmuMFoyvXMq3voAMJQlYv
         U4XxLYD++QrBfhLDf8jT/oumYf1D6XpKHtTaJJ3jAObafXIUeCPCNoZJsdUdUKPtCnb9
         HCRa/WRzavwcEbFVnx4gsb3elAHwZyMH3wy/m4fkMAuCoe4HPdzG4L3iILnW6r8KbueD
         LVoUmK6GDBUCL0MIvKRPjRRDzAFPrp46ZHkYjmPQBzqcxhwx36xvkSfEh5cuLPzzRRaU
         ozIA==
X-Gm-Message-State: AOAM5325llo2WaqKyZpsqukSvsPBc8KzUyrS3lBzzFQELeTENrcTwAoH
        T4rnZ7yz8tY62yPX7R/Z0HStZHpwbiKnJA==
X-Google-Smtp-Source: ABdhPJzhxFUMTawNZzOtvZIBRqDqmrZxPThkwiMNkA4U+OTvP+9PXxROIH39Jl3YtUVqxqkovsujQQ==
X-Received: by 2002:a63:8ac1:0:b0:3ab:199:cbdf with SMTP id y184-20020a638ac1000000b003ab0199cbdfmr11822425pgd.466.1651544000062;
        Mon, 02 May 2022 19:13:20 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j22-20020a17090a7e9600b001d903861194sm365805pjl.30.2022.05.02.19.13.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 19:13:19 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v8 0/2] Add thermal control driver for Sunplus SoC
Date:   Tue,  3 May 2022 10:13:06 +0800
Message-Id: <cover.1651543731.git.lhjeff911@gmail.com>
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

This is a patch series for thermal driver for Sunplus SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus
  dt-bindings:thermal: Add Sunplus schema

 .../bindings/thermal/sunplus,thermal.yaml          |  43 +++++++
 MAINTAINERS                                        |   7 ++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 135 +++++++++++++++++++++
 5 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

