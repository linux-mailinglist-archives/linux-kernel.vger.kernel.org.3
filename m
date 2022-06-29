Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5D55F351
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiF2CUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF2CUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:20:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12632205F4;
        Tue, 28 Jun 2022 19:20:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id jh14so12751563plb.1;
        Tue, 28 Jun 2022 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rlgeYTKJxDBdTrgiYt+xBlY3VqeL9LFxhA7ObySVmls=;
        b=Asfrq9DkHEDXEOE6TLp9NaixoEmjkbBjN4QAx1t6Jdz3CAHsjxDxSsf/t1Zsa5FrLv
         eAV53wLS92Woy/9kPUoKw6SQqLTHED9oDevHdXwa9oMp4e9GWW0+nmsl0RbwD9CJXOFQ
         GCgFaZgfpAFwIz4ff4T+BSFPWrdWJlSGLsGCefl80M3lE323Og+zDqV58X0dvy1Vremt
         rYc1LPNQcFkeAVqStAbUK+BbVm8pUQ0NtQYuBDioKE3vMVBSdi0iCHPnNoZZbFhjiUg0
         13cHDeE6Fr0g76Quc0Gi25gyzsEX4DGgu6Zgs2zVujBmeqXmkGTlsbP2jY7fqAVZL6sm
         oEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rlgeYTKJxDBdTrgiYt+xBlY3VqeL9LFxhA7ObySVmls=;
        b=SvLPA2I7apaakYIZrIqoGJ/p+caiDMNkCDVCAnwavcigtNv+7J+GX2So2oczQ5JfoA
         Y/ny4cvq8hiIo9OGRmNF/eLOVXBtSp/CpWLw3Q/zsWB/2uqY5ZuTtRfYRf0WmhxFxZTw
         3Gmmeh74N+7DrC8A2rgrIi9U2OFZ6rj4GWQRChiDu78DAD5P19TeSndrDjlY1OT0IYYv
         x/UvslFwzZeQsyB18pY73kc+yF3NN61FEec7ztbKeqVVp/ka33OhrtQzhgbtC2fRybri
         IqqyEs1c39lz7fGzKw8aYM1Zr0gbV+Om6aE4qW/3BWIst3/wH2t9ht8izzK4Wo4rBRUX
         UrlQ==
X-Gm-Message-State: AJIora/SjXZFNPell5sTLKkK6CiwO8DyrBnZPA66WjlnYopVcJaeoT6P
        mIy1Pii5exX6mc2MlOzsHlXzXzVUFGg=
X-Google-Smtp-Source: AGRyM1v/ayIzyNIeUDcObnQHPxXau0MRrWv2PtOl7K6jdnh20ferQPLXLDrB7Du5ep/zyZoPLrTBaA==
X-Received: by 2002:a17:90b:3e86:b0:1ec:fc46:9e1b with SMTP id rj6-20020a17090b3e8600b001ecfc469e1bmr3004092pjb.155.1656469219432;
        Tue, 28 Jun 2022 19:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:3e21:914b:bb3e:3e56:4806])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005251e2b53acsm10089015pfw.116.2022.06.28.19.20.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 19:20:18 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add Richtek RTQ6056 support
Date:   Wed, 29 Jun 2022 10:20:10 +0800
Message-Id: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
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

Since v2
- Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.
- Rename file from 'rtq6056-adc' to 'rtq6056'.
- Refine the ABI, if generic already defined it, remove it and check the channel
  report unit.
- Add copyright text.
- include the correct header.
- change the property parsing name.
- To use iio_chan_spec address field.
- Refine each channel separate and shared_by_all.
- Use pm_runtime and pm_runtime_autosuspend.
- Remove the shutdown callback. From the HW suggestion, it's not recommended to
  use battery as the power supply.
- Check all scale unit (voltage->mV, current->mA, power->milliWatt).
- Use the read_avail to provide the interface for attribute value list.
- Add comma for the last element in the const integer array.
- Refine each ADC label text.
- In read_label callback, replace snprintf to sysfs_emit.


ChiYuan Huang (2):
  dt-bindings: iio: adc: Add rtq6056 adc support
  iio: adc: Add rtq6056 support

 .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |   6 +
 .../bindings/iio/adc/richtek,rtq6056.yaml          |  56 ++
 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rtq6056.c                          | 670 +++++++++++++++++++++
 5 files changed, 748 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
 create mode 100644 drivers/iio/adc/rtq6056.c

-- 
2.7.4

