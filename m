Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9941D57A26F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiGSOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiGSOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:52:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621D6F7E;
        Tue, 19 Jul 2022 07:52:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso2491965pja.4;
        Tue, 19 Jul 2022 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/pxAOS1tGZBz9dvVoCcgvj7kybrEn8WkCZ2RktbATAs=;
        b=kXHMohWY3LsEE6hf8AxFzZ2Q18BQAQ/XZiR4vDu2tYnr9Cg54YEED1+R8yjMlMLk30
         AHlkVv98eYzMw324BqLDclpQxlr90g2UGkDau03NJdfUp4O6HcNfb798HX0vS0U3Su7R
         qfU+sAb+BiMdPmCO/HmBsUiPoHDF5KexoYGDTgQR5JoygrtX/7/9ldZ/DTaiPI/5Wpiy
         W+AoHwbaynwplEXliFXvAu3jmZlGE8SJi/hiRv4lhPYApqP9MfoZWl+DXrLvIliD2otr
         +cQCCg5239HGOFTdmg4i9AfFu1+9B17BA1kMBDYSAWH5oKKi1m4k6LRNS0hXNxzG2/JR
         97tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/pxAOS1tGZBz9dvVoCcgvj7kybrEn8WkCZ2RktbATAs=;
        b=dRiCNz5kP09s+w+vbav77K8TubQaaeOi6hW58K7Va/4V2Xm46USHkw4FXbghmv44gH
         a6TyLXKVWDiQQzw7XBH3LPOHkCzR6NJJrg61d9ABhFm4Fdxo8zjqsRBwMHufpTECZsHf
         htClClkDTabC5Mjv+vzNwPCAoxnFTyFmppShDiouoQPikMTAq1Ntmi3Iham+uqTonuXj
         ij1z5565H6UE7HpLg++QVJgn06sYWRjpCaYS0I+/RpBs5AWCjL4YLGYbtuxOC8ima6xH
         PsvC+5ghCCxq581njF/kdl/yMDZwKBO8YstF1qnc79ikBKNart3vJVBM3UmCZNU1uVOm
         rJXQ==
X-Gm-Message-State: AJIora+1wSB+5vhm6OhBqwWtQ1ni7PGXcEzr+Ibyr26sqGOl6om2YYT3
        dzt7NXena76N8yZTb9zksbbBrkMlIZo=
X-Google-Smtp-Source: AGRyM1sJZZ5aUfr1exKIR9ffDmjOf/oXBLX2p2oGvjtVO3S0Zh1wIiSc/nGsFL/u27W3tXL+zhzy3w==
X-Received: by 2002:a17:902:ab86:b0:16d:a3d:f96f with SMTP id f6-20020a170902ab8600b0016d0a3df96fmr4276644plr.139.1658242372615;
        Tue, 19 Jul 2022 07:52:52 -0700 (PDT)
Received: from localhost.localdomain (1-171-6-142.dynamic-ip.hinet.net. [1.171.6.142])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b001615f64aaabsm11630842ple.244.2022.07.19.07.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:52:51 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 0/3] Add Richtek RTQ6056 support
Date:   Tue, 19 Jul 2022 22:52:42 +0800
Message-Id: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Since v8
- Instead of 'integraion_time' for voltage channel, use per channel sampling
  frequency to be more generic.
- Update sysfs-bus-iio.

Since v7
- Use 'DEFINE_RUNTIME_DEV_PM_OPS' to replace the explicit declaration of pm_ops.

Since v6
- Remove specific rtq6056 ABI document.
- Update integration time description in general ABI document.
- Remove the redundant blank line.
- To prevent the race condition for attribute wrtie and shunt resistor write,
  use 'iio_device_claim_direct_mode' API.
- Refine the order for 'action_reset' and 'pm_runtime'.
- Fix text typo in comment like as ohm to Ohm and timea to time.

Since v5
- Fix kernel version text for ABI.

Since v4
- Add '__aligned(8)' for timestamp member.
- Declare timestamp from 'int64_t' to more unified 's64'.

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

ChiYuan Huang (3):
  dt-bindings: iio: adc: Add rtq6056 adc support
  iio: adc: Add rtq6056 support
  Documentation: ABI: testing: rtq6056: Update ABI docs

 Documentation/ABI/testing/sysfs-bus-iio            |  11 +
 .../bindings/iio/adc/richtek,rtq6056.yaml          |  56 ++
 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rtq6056.c                          | 661 +++++++++++++++++++++
 5 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
 create mode 100644 drivers/iio/adc/rtq6056.c

-- 
2.7.4

