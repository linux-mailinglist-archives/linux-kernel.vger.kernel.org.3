Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34611571325
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiGLHbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiGLHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:31:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873439A5C4;
        Tue, 12 Jul 2022 00:31:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so10579070pjo.3;
        Tue, 12 Jul 2022 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gO6Io2EtpSwnOBhKD/43gkcXBj6LMBmsymURYe81IBw=;
        b=lghqFGKSPmMDONFGSd1EaPy5LS0XZ2rRcmNKUJeuAzvJxRBDSTFRZdxW3VRABGgqrN
         u2bBed9HImWHHyMk5ePYl1r+RdC6sohh+AfW9EXS/oYHUOUMSHLm/xCrZnalOBcI1H65
         COV0G61rqrKPMI/AV3pOi+4hw4MmHg2Mj6hrjEbnq4Gm824uDj/39Cqro9ATBGEKo2JH
         oiKB3k+zaeUw0eCLS0S1FYkxVBxFccSoopxOeX0hPnGiwpOyFbcAqtumA64PnEB2P498
         IIOGDVxdPXqc/xGbAPJSlkmV9bQ3WHe/KRPB4CfJ3kCPNIzQ08Mn0bjdNh4BU3y6zE9X
         A8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gO6Io2EtpSwnOBhKD/43gkcXBj6LMBmsymURYe81IBw=;
        b=P1LTsQOIq+DrjUGWeFnTzvE7H25I48KHNXqTJrP+fkjQY3b+EB0335tIJluAG/ajLT
         DtdAdwH963CPLqytEiZNdzV78oyckkFd8pdltfb+fW5cZ8EK10HvOlripXtY06tpcu/X
         Wl4bGR/EuFVbmH+3cKQdBtLRfGWG4Tb2OCUEAiXCj88aytKxpyfeZJFvTaCflnDgXoY1
         3+smlBO/cdpzvlLMMoTztTFd6yoYb0x2NkTZCanPBroaYLBeUtS/D1CF2+Ca0+y0Zdrg
         nqVhy9swrp080wG1xRgA298+wo9picA2id3zFiP1+fLZI/H4oIyS/qTt1xSucz1Dk3uw
         LcDA==
X-Gm-Message-State: AJIora9CLeQHW1w1BnY1nNmezYoF2ud2/beATpf7Xr7obArsfatI0ZO5
        HAIgZ9/rogurR/zkcvWEr0CCYQGa8BfJoA==
X-Google-Smtp-Source: AGRyM1t9cDIFvEjl6p0PB9XlVT7csJT4GP2Qoo1t/7jyO2dAN8FrCqhm/9j0Wty6arBC1Ooqq1zVhA==
X-Received: by 2002:a17:902:ebc1:b0:168:fd13:8adc with SMTP id p1-20020a170902ebc100b00168fd138adcmr22939534plg.161.1657611092789;
        Tue, 12 Jul 2022 00:31:32 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t18-20020a170902d29200b0016c09a0ef87sm5994557plc.255.2022.07.12.00.31.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:31:31 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v10 0/2] Add thermal control driver for Sunplus SoC
Date:   Tue, 12 Jul 2022 15:30:43 +0800
Message-Id: <cover.1654660009.git.lhjeff911@gmail.com>
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
 drivers/thermal/sunplus_thermal.c                  | 139 +++++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

