Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75DC567420
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiGEQY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGEQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:24:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E62DD2;
        Tue,  5 Jul 2022 09:24:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 67so2311515pfy.5;
        Tue, 05 Jul 2022 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9MddCrzTwLfRkOlESSfVx3wXNPCZEfx6UGiuSKxMkeg=;
        b=AoxpogtpH8sLb/3byFsKc2EpFn2WDcCmWarazZYyaQ2+riREksf5Lbz5XjQgtGh4Hb
         dDuRV1kkz4SzaNp9set58olO7FsV5qjg7PViojPRLK5VWrG68gzfbgzNGZym9j+eR1YG
         P0tMzHsTxlid5LRbNKgLAQsmNV/Hqw6Lg9LBH4nukLHPD6+bGvNiW9VsP8ZE0lVhPW1m
         QOoj7xts8Zt6pO9t6DdJm0XPAPb2lMyN288AaHeIVxsztWwmrCbnEAzKC6kf7gecj5uN
         6QQxR3lkL3tqTOvTnwia2rGLhj0US2WMpIwTkb65eUq5G0RsJ2y0x3bftPxWMFp3V5g1
         RlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9MddCrzTwLfRkOlESSfVx3wXNPCZEfx6UGiuSKxMkeg=;
        b=ZIfqsPKsfGZEipITEl3041XVGlM7rBO/8WOuL9myYarKiKiJe5kf5U4oo6QPI2bqCt
         ogErHmUhvnXeE+HIxXpRpwXdLeeVnIRzIJwtVGQDGxfgsZRqASRX4NDP5kU9wCytEK+Q
         5z4ORSjdfmncm+TAAF43q1h/z/oHwoXwvtY9x+FGHf/LODpjPfjgA9w1ssIu2IPKKbLv
         4xrbOZijgPwfQAlBp1o/UP4wYRQaFP+JZEUK79tUA7pqBNsMv6kugdCWfvKL75XDBP6s
         ZPMGIfSPBgCZdy8Lc/qfSZdp85apPUGX2PBgEYHJMhlx9TmXJTDCdBU93V5Q9slkRmn1
         hm5w==
X-Gm-Message-State: AJIora8EFPlq6rd1WUF8w6Zk0qWLRtfWY2Suf6a/Tj4aBav/ra3MEmiC
        qkWJf2LWEuB/HUdIqGQZXP4=
X-Google-Smtp-Source: AGRyM1tEfAsxbKKD8Hx9HfFPtM+NSLGylzQWTtM0Skkfw9TRxs6DS0mW/84vc+4Ad980+pPstwohEg==
X-Received: by 2002:a65:6a55:0:b0:411:fbda:1e6b with SMTP id o21-20020a656a55000000b00411fbda1e6bmr17851698pgu.225.1657038263000;
        Tue, 05 Jul 2022 09:24:23 -0700 (PDT)
Received: from localhost.localdomain (1-171-10-134.dynamic-ip.hinet.net. [1.171.10.134])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090a579200b001ec932d7592sm15290896pji.9.2022.07.05.09.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2022 09:24:22 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] Add Richtek RTQ6056 support
Date:   Wed,  6 Jul 2022 00:24:10 +0800
Message-Id: <1657038252-31360-1-git-send-email-u0084500@gmail.com>
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

