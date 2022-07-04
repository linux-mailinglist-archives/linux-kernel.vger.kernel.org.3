Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4D564F64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiGDIJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiGDIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:09:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DE638A6;
        Mon,  4 Jul 2022 01:09:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so8801616pji.4;
        Mon, 04 Jul 2022 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=KOcTHJ4ga+QAl3gF4ti051436C9mn58/FXpIHms/jTE=;
        b=PZCmtibzFYQZVP6CXzU52p2HaKwNygHrUjI1x09JDxUpeFgDr3UM1SeEEkNlrmvzwa
         dCD4YOuAX4IaDh8X/pJ8OLcXWyZHOScGDXviurfDnyVnWp1yTDxmW6JmKg6rZJ1iatot
         q6IF3RY5PjAn04HuYGAWrozfDUZc+A5K9Q+V0M4R8O/3KRola53EruJIHBJMhB/CRAiH
         xufjscQ8IGUKNXetddvR0d9ISISITFLtLkeTiBfmQ9bSCWWl1LTKf5i9cpCPBviWsRI9
         XXPFmioqh/BS+DHTqs4Wvh0SdT5pvxN390r4nqW5pJVnqBPDiNlXFN4FyjPx6DBMDAWi
         F1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KOcTHJ4ga+QAl3gF4ti051436C9mn58/FXpIHms/jTE=;
        b=Hm9UqaKbvzDSNHRZsGZW3YbyaVBRxjxmwt88ME9jTrLjQOaiDQZf6979y+3qxcC8Zm
         04fGIUwq65wa9cELWyWhOA8bfaKG/ahFMzokq2xNcBtHhXjxJZpbK3n/U2B9V+5QyuKM
         2FzNGwst+R9yDB1CNl4T1zts3GMv7NwyhdLheSnt7xG0QaztYhFt40eKRADEwRs01ND2
         GeGWrQwa9T+/p5Q+yLh9B7Uuy0xG28RtlADE0p98jY1AqU5FAaSkvFdrJtDtZupcpbQc
         Y70Ktnf4mb9spbjitRKUg79vpIjnRbLR/5zDihujIDg/6mWR44L7z1FK6ONxpqdqequG
         BRBg==
X-Gm-Message-State: AJIora+zvvIvCM/KER76fd33OPAOANgTqXpuULYde38WBfBa5Gx16obE
        lxVk1UlwfUCL9KJzaehnq7U=
X-Google-Smtp-Source: AGRyM1vTq8Gq0cMHvxWTYTIq2dTe97LVnVwGB/9dRhlWiypAZ2GkAMDx2Rqyqyjaf/HKhlCMXyqpMQ==
X-Received: by 2002:a17:90a:cf90:b0:1ef:87d5:4798 with SMTP id i16-20020a17090acf9000b001ef87d54798mr4795711pju.140.1656922186354;
        Mon, 04 Jul 2022 01:09:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:5fa0:f4ca:b72:ee4c:412c])
        by smtp.gmail.com with ESMTPSA id bg14-20020a056a001f8e00b0051853e6617fsm17596248pfb.89.2022.07.04.01.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2022 01:09:45 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Add Richtek RTQ6056 support
Date:   Mon,  4 Jul 2022 16:09:37 +0800
Message-Id: <1656922179-21829-1-git-send-email-u0084500@gmail.com>
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

Since v3
- change the node name to be generic 'adc' in binding example.
- Refine pm_runtime API calling order in 'read_channel' API.
- Fix vshunt wrong scale for divider.
- Refine the comment text.
- Use 'devm_add_action_or_reset' to decrease the code usage in probe
  function.
- Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
- minor fix for the comma.
- Use pm_ptr to replace the direct assigned pm_ops.

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
 drivers/iio/adc/rtq6056.c                          | 651 +++++++++++++++++++++
 5 files changed, 729 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
 create mode 100644 drivers/iio/adc/rtq6056.c

-- 
2.7.4

