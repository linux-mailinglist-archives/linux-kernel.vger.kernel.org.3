Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69191568AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiGFOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiGFOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:11:49 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF618E0C;
        Wed,  6 Jul 2022 07:11:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bf13so1067929pgb.11;
        Wed, 06 Jul 2022 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=KG16OAHavVBqkRuHTbh0NGqQDaSt65u8OkbDtr+MKsc=;
        b=RzX9k+b8GRhpE+9hiBRtVPva3BJQ5aTXpiV13GLB2bpDMg+y708Xc7a0tMnQeuukat
         47PBVS0j+LufZ/RyaPLbN34pp2qEc9yJOYqSbbzobWc2dvg5xzQ0iFImfkFZce3lNRhu
         /6/c5OXR9ebGVqjrJRgOBgho6MoC58e31gFedE9Hgv9wi5dk/Y4QdSdiVrArzbL1+ebJ
         j+3fSLOcK5fU3Lw80axnxvDZQtoDDPUfXNGqL541FCFuynl/nKrTXQkZaLj5aDkND68x
         jdCTXafqXjsnqo1AX7Af6PNmIdekV0LP7A51hdaFdMyFGTCROKryqbFaHOIaoPY7LAcZ
         6VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KG16OAHavVBqkRuHTbh0NGqQDaSt65u8OkbDtr+MKsc=;
        b=PmZwDH+LEUCsvVIPv6YjP6C6Nz6AsJZxhhTuME6/graKwZCXloJDvv0UN6+1zQos5I
         xwVH6iNrB424C4M55ioDQbj3DD49n++fS7wFvjPIAD0y4UIndPcIMoRCnpVw844+5D/V
         ajEcGyHmmKk7w+VMUv4aLVGON1XtEYl1+ZhwJ4HubHnShbZD4ayO1g6U96MYh0kgUWAB
         UCqOmYx/kVdvniaLigdjdlas7UjB8W1zEgVGcHSSrU1QQ+vuzgfGRkbfOklifjEZJQSs
         INap+7LHmjk76R7nJoyYr94QknPSPq6aBdpGePUG4GF35ZUwf1VGGFCnGtsjYl9Arv7H
         qLHg==
X-Gm-Message-State: AJIora/S6alXUbaQV6odFfwqExSczoMV4ff17AfrcxbJceOSmymX2RIZ
        g8PaJe2lZi1C/IidH71Gb5Q=
X-Google-Smtp-Source: AGRyM1tpK+6ZJPnE7uxluB75lS9txGRh7VyahB/IXqAsB6Pou+Erqkn+fGw7xpYr3j2NE6BUSe/hrw==
X-Received: by 2002:a63:ff66:0:b0:412:6f4c:1e11 with SMTP id s38-20020a63ff66000000b004126f4c1e11mr8289504pgk.396.1657116708393;
        Wed, 06 Jul 2022 07:11:48 -0700 (PDT)
Received: from localhost.localdomain (1-171-7-167.dynamic-ip.hinet.net. [1.171.7.167])
        by smtp.gmail.com with ESMTPSA id k2-20020aa79722000000b005283fa73dcesm8738427pfg.77.2022.07.06.07.11.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:11:47 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] Add Richtek RTQ6056 support
Date:   Wed,  6 Jul 2022 22:11:40 +0800
Message-Id: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
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

