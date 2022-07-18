Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC72577A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiGRFqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGRFqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:46:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519F13EA4;
        Sun, 17 Jul 2022 22:46:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k19so8100643pll.5;
        Sun, 17 Jul 2022 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4U/T4TQ1PX4uMET9peobxa9Y8PX05uQk0MMRd5+txYw=;
        b=NwlEr4aqAri6iJBvt5BR7RSYcKRL93rGStkMcZN9hEa9krZx/0iIuY0T9TtqYBFltg
         pUGyEQb/WbYRlZH3raTsDm5/+orIkCTeTFIta5H9BbcbaHbrzir6/TQduLVE9WmLDttP
         VN5f93idslGTWxwnC0///+7PeCNjiJr0i6E3hlzQ9T/qK62xz9YKm8qV4dbeuAk38H2m
         vLSMaqCsoiVoVq4JIazt/MEKLQcJvknZaOOSgoKn97LZ60eJJu3GPfQwo1VQ50G3E1cj
         qPeQyZQr/tcKj0Z77JyAJGcYUKQQq5rFYcz3MlkKtAAku4D3ya9RL190kY45B+q5Ye9c
         QVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4U/T4TQ1PX4uMET9peobxa9Y8PX05uQk0MMRd5+txYw=;
        b=KL9Zm3rBiPbH1fqVHJWGrHUylltI8M6UDqwLGyOOY6WCJyf0I5lKpt6nbPil6n6vHj
         9mJ1OIkVZuEK8FlWYOHQbke+uMUpqxDG0b2I2bw/fULYlZk5ByYpsrYthwmSEFLheOd1
         leKwYAyDY/XyiRM8kkPzVHPg8RKX3wkdgc235fJmF+BT5Jlp/pspsnPk67HFpxii/bsn
         paXi8bEB0GY7IcnlJEDmV6GSNbbIr7fIwpMbhuFv0q4mXyH+jrY9ZJgtkYx1tm7IGmmX
         yfv5FllLnvEptAzn99jLPRwtwcyXETtig8IsNNp4x0PDuJ2pS6/xB0bTQgDchssv/zl+
         +sZw==
X-Gm-Message-State: AJIora/nQeBp83uF4ktu36XjbwUNzPlhZQGqfujUq9VVATH+hdD3gY0k
        pk1YGIyvYDg6+W3hcVbHo43K86A1JcQ=
X-Google-Smtp-Source: AGRyM1skqEkRM2g0rnalHzjqnob/eNv5haky08K+XJgQw6J7ymMTHY4KQx9Mw05Zg2nky0CQpzFqDg==
X-Received: by 2002:a17:903:447:b0:16c:9a:7a0c with SMTP id iw7-20020a170903044700b0016c009a7a0cmr26063101plb.137.1658123170594;
        Sun, 17 Jul 2022 22:46:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:e7ad:4982:5f13:5219:614d])
        by smtp.gmail.com with ESMTPSA id c66-20020a621c45000000b00528ce53a4a6sm8147951pfc.196.2022.07.17.22.46.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 22:46:10 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 0/3] Add Richtek RTQ6056 support
Date:   Mon, 18 Jul 2022 13:46:00 +0800
Message-Id: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
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

 Documentation/ABI/testing/sysfs-bus-iio            |  10 +
 .../bindings/iio/adc/richtek,rtq6056.yaml          |  56 ++
 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rtq6056.c                          | 663 +++++++++++++++++++++
 5 files changed, 745 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
 create mode 100644 drivers/iio/adc/rtq6056.c

-- 
2.7.4

