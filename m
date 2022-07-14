Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCD57496E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiGNJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiGNJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:45:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E531DD1;
        Thu, 14 Jul 2022 02:45:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b8so2328967pjo.5;
        Thu, 14 Jul 2022 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XEas1ADySh71w4N2jTpweq2zN8MLhza/tU18I8h10bw=;
        b=M+eqwzvQMJa8u3DFy2EUoHHuRYe3lJJvu1/ax374Rc9wwtME0Z2xuWnxmG67wJJjrF
         MJO2s0hsuYvBDePoNgKg6+ZjMG0is4AGeh0eX9XbwJkIbsB3rLCToiJVHePLmbvl9VPN
         w8GcntpMhON6VBqeCUFEoc4bPT9bMxaer59M2OdJEnWNLxqj0bIqBXa18Wi8Zt5tHz5Y
         m3F6To9xSqu73YzVyuMZmNYOzugrKj3JI+XUmRXmHnhXLC50w9YxZLBftmXklThLNlci
         yM5f3Hh90hsFqTQiln3bHmoMmvI+kRr4sUNrJyLI0vJNEmx0B/ramu40PEgMf3OyzwuT
         XHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XEas1ADySh71w4N2jTpweq2zN8MLhza/tU18I8h10bw=;
        b=OlKYAYDN/RRD2xvvLdL6gMsApdkuL8mg1oCWpSXoqgTDw29kZLVFfvsnVdDIpU9Fq/
         btxlULjgWneOkvQDnjZ8jyHa133SaArGJf04t8MUItd0MKhZQK+SRx3CityTiZd9Mr3R
         WdPmzRg0O5RduSMZ3BHicg2bZJ9qo/DWFepD+aXwtJFIv69PjcTmUOJoEdpUbbnViPgh
         9SNhRvZnryXn0ekGrBWcQsbbW6Oy3wFTCaFo8g/+y8UBR2zFHbjRoEFqGchCKuWYCECa
         uEs12U57YOdDVbwNO3WGcvbKyb+tloC1I3jfkDITYVBdUcYvuP+ub9sWs4HQDJqQ1eTL
         VCsQ==
X-Gm-Message-State: AJIora8raStOLOlMb1F20Qbgk9yHD10PZOj+nvMODxLymzpQ8SIdGkwF
        FzG6arhRd2x6blzkCJ+/OtQq6AWa+oA=
X-Google-Smtp-Source: AGRyM1u4Furf/aD14WXMcgLav/OpgmqphaTZ7TRYxSfdW3AYfCbnXr4jKtc9p58eiYvXxWvk4c3zaQ==
X-Received: by 2002:a17:90a:ff17:b0:1ef:8b4b:8cc0 with SMTP id ce23-20020a17090aff1700b001ef8b4b8cc0mr9020293pjb.155.1657791933733;
        Thu, 14 Jul 2022 02:45:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:488:5f89:217d:a3c8:f1ea:4115])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b0052acb753b8bsm1169233pfk.158.2022.07.14.02.45.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:45:32 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 0/3] Add Richtek RTQ6056 support
Date:   Thu, 14 Jul 2022 17:45:22 +0800
Message-Id: <1657791925-23929-1-git-send-email-u0084500@gmail.com>
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
 drivers/iio/adc/rtq6056.c                          | 664 +++++++++++++++++++++
 5 files changed, 746 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
 create mode 100644 drivers/iio/adc/rtq6056.c

-- 
2.7.4

