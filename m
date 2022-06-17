Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67554F457
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380587AbiFQJdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380925AbiFQJdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:33:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A6D15829;
        Fri, 17 Jun 2022 02:33:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y196so3710044pfb.6;
        Fri, 17 Jun 2022 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DQqtBZQvmWcHeVNDbchb0TJuxs6lxK8z0XJvGtf7guI=;
        b=XGbCdemz1/31qY+TIdC+qeuVXwy9MkE4SeE9Q3MUi3B5rOsYds/K4LcjJjomqJ295j
         Ij10mwRe537NcDi3M29i9qVtn/eaz4v1bmTAf8Hg4HigKD5KrsiKdGLtGUumnLOlki+7
         alrxZ/9QHSb38IrqS/BebMWrjItBzNIw25boG3lsx0WDVy1JRVP2NQom1fWtcrXzLoW5
         7gRPGuT6ZsRNId9Fg6y0mz7I2ZLTx0sDqUBHf3axoBXkBWnucAR0J+Nx6ZHasXk4ANPo
         WrjC6++/xxnBEC52kl7KZ1fJstRxMP3zkOgM/GI+tyXze5vPX78d4Ox6hvGUoq8T/gXO
         nWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DQqtBZQvmWcHeVNDbchb0TJuxs6lxK8z0XJvGtf7guI=;
        b=CaAalMcOaLse1u3oiF1wdKQx0vo7md75LeFrqHST7V+I5XOF+7BN/swQLUoEjal6xB
         qvZ20jhXoW+k1jAlA6PUBc0fQ7c6/Hs6IXLFw+ewbMhvJPrpWXYpdWA7NXvKdqlk+kde
         SGgn7uj1xlc2RPhXbxY5/eLs//aD+CuX3eCpBcIdAci/CZkNc/M6D+Y1BrsGupFHBBEJ
         e9TjAZcYaUMHhy/4oLpotlCQZL+mR57n4V7GmXQyGAjRq2Iyh1FBcxSsoeerxjrBNbPn
         8e5EbUoRnJuDiFFNVfUSvcnwbWM5oIxKkHQMLWUMQgcT7uzGleTwa9Gbc4shX7Aaoyf3
         0KOQ==
X-Gm-Message-State: AJIora8ymFUOdBd+ebEqR0TfoZW1Y7niVgtb09I+u+UXBsf+mE1NTNaI
        s020bNlIMhf6wQubVpl/w6Q=
X-Google-Smtp-Source: AGRyM1txPmv7kBAqyuErGcZWmFl01saucMsNwFPHvJMCN0YByXKQJL++Z7XlKZQVAZV6yqkdg/Kt8A==
X-Received: by 2002:a05:6a00:2410:b0:522:9837:581f with SMTP id z16-20020a056a00241000b005229837581fmr9072334pfh.11.1655458381800;
        Fri, 17 Jun 2022 02:33:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:e813:14e7:c8c7:4065:3f67])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b0015e8d4eb242sm3103576plg.140.2022.06.17.02.32.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 02:33:01 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add Richtek RTQ6056 support
Date:   Fri, 17 Jun 2022 17:32:53 +0800
Message-Id: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
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

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series is to enable Richtek RTQ6056 support.

The RTQ6056 is a high accuracy current-sense monitor with I2C interface, and
the device provides full information for system by reading out the load current
and power.

ChiYuan Huang (2):
  dt-bindings: iio: adc: Add rtq6056 adc support
  iio: adc: Add rtq6056 support

 .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |  58 +++
 .../bindings/iio/adc/richtek,rtq6056-adc.yaml      |  57 +++
 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rtq6056-adc.c                      | 548 +++++++++++++++++++++
 5 files changed, 679 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
 create mode 100644 drivers/iio/adc/rtq6056-adc.c

-- 
2.7.4

