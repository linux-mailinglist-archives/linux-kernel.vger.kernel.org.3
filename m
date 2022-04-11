Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6F4FB66D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbiDKIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbiDKIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:55:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F53EBA8;
        Mon, 11 Apr 2022 01:52:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so12900874pjb.2;
        Mon, 11 Apr 2022 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Q/paJW9ie5DNXM/d6p+1m3onX+nRzXcgKkbIti8bjJE=;
        b=KpDoUUVC50cOsIuyNJpgW+RFycUibIju6u/aEuTTHZ1ih8p56PAxFHD069Q0peRT8b
         JVGYHmne4rEMsecWIxD4tq9E5kBIe3rPN09VeBiEJEzYAMtC/Ic/LL0J0QbrB0aYhfI3
         89bVV8MgpS2Zej8E0movu8gY3YxoRZ+3EI+aIwADCxS0Q9RA4dlD6w4OHlfW3SFcCtH/
         c2F1pxqJDbfsK8E6x6czEjqFMlwZRjl55pQpFvYIdlnuHYOH9eHexGnbjKcm4oCOeiij
         cSoo7orH84EFgAY8Tldl4OC49PoCkr5Qg31IhAZ5ywHtA+pzJLKcLOSJiWMOekpAaT+f
         9/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q/paJW9ie5DNXM/d6p+1m3onX+nRzXcgKkbIti8bjJE=;
        b=UxfDEle8K5R651EmL5BUc5VDrvVPsghr0V49+LXYbULpdcC9vRLPcZosWZcQf7zAF6
         7UNcJMGSEBPNc3Tbc6ckxcDU/kDcIWRaMobCSKboVLt4oGAoTAWnfuROXR5MmZ6nw8gz
         I4OecH39fq754JGyNYtQc1u4p8Z4M6htkq9J4uHhUBSCb8bo+eTJ9iyj+0jWN2tN8Ekh
         5c5WspGlnDbLt37QY/duBNrv5TEWGUbkuP0tDBahKaUhka5WE+RWYtjcY3HFdPVOIPTW
         z+f8HYYchHOQ8IWoJbak8ixvLGzRPbyKlSSodqnew4d3PzDwA91TiSqFaBpyibiIwnsS
         I6lA==
X-Gm-Message-State: AOAM5327RwVLcFcvbnLsNfwrPLFxRCHag7lG/xq2cEzY9ivvpOJ6p6Q7
        4Og5C+3mO4ZGdMo//N/dLOI=
X-Google-Smtp-Source: ABdhPJzkbQcsfDV7LTEJJnM7W8CweM0vo8LWRIcDEFHzuxiT8wwTp34XuevjvN3nh6DXvFzYiQnoYA==
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id s3-20020a170902b18300b0014fc26620d5mr31472235plr.136.1649667170595;
        Mon, 11 Apr 2022 01:52:50 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b16-20020a17090a011000b001cb4815d135sm10054057pjb.9.2022.04.11.01.52.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2022 01:52:50 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v7 0/2] Add thermal control driver for Sunplus SP7021 SoC
Date:   Mon, 11 Apr 2022 16:52:38 +0800
Message-Id: <cover.1649662002.git.lhjeff911@gmail.com>
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

