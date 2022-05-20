Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F27352F2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352668AbiETSaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352658AbiETSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:30:52 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E730271D;
        Fri, 20 May 2022 11:30:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id s18-20020a056830149200b006063fef3e17so6043440otq.12;
        Fri, 20 May 2022 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5IbhIIo2Ex15+PJPCMxKef+LbGdFyZTyufuHty8qHo=;
        b=iq9/6y8GI/TnANp1RCAraEui+WiIgDl/46PyKF2k4/voiiysrmTm5qwem2BanLUGsZ
         v+kY1rEeCX8u92xfYlq7q1DYOqwJSOTsgKnY2N4MjHmnbBwhP7jtNWtFHxMCt2jG6wue
         Z6pNHGIZVLFG2BpQQdvoLKHuoLl7ziApc7pjmMNTh5GKkhk2KU7H237F7hnbyPYogH7v
         Ru7lde4tDF6iMYl9ZzQFfktw6Hj9fA5VlJnzhySo7/cq9wYSiTlVoUOfotB7YJVYu49d
         K1dgapC+aXcQkUaFmKB2nhLSG+s7OOj7UCVeQ8xRGuhVnf/v9iLV69I9A8IUz6S5KDtm
         SEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5IbhIIo2Ex15+PJPCMxKef+LbGdFyZTyufuHty8qHo=;
        b=PEiM2GuVFRzv1UjEHrWLnKd1FQtox3patVyY4p+zB10D4gnDSlCfoH7fVYUpSv6EDh
         tegtYVnkEID5hJLDTTjWSZoMwtldGIIJegjRBFdB1kdJtQtXzGw8Q7ev534IPxsn32D+
         mpiMyi/tZQ3/m3B0Y7kHihDimB/8vYUcdxgv9BAi9f0PNkJW5wuhYjZgo5t3SloJPS7U
         dodIAjpikwmyoDM3nPLUPJzmrf5nZWUF8mW3PqcAC5gHDSxcDD7iw6AboOqPVqi06t5b
         5eWlqTqzrzg7WUqS6yW0JK+l154SN5M6GH/BFFK1LM92gNieFKzSytFhqW1fGVxEhFLP
         xlIg==
X-Gm-Message-State: AOAM5313GvtEQGDRZCGHki5+OvKv3lVYBZ7y96iFYOqXd/W/1rCcdy7I
        B7oh4KdKhUxY++fMmwvTLhorHYhJ2JIHsg==
X-Google-Smtp-Source: ABdhPJwzaUYgQUwCeSVbbocaJLwqMJOJvR+2bwzwy/QIN/IXIC0gDQB0P3pkZezbWrVsPgHmh03J3g==
X-Received: by 2002:a05:6830:9c2:b0:606:1e0a:cc8d with SMTP id y2-20020a05683009c200b006061e0acc8dmr4475147ott.265.1653071451235;
        Fri, 20 May 2022 11:30:51 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id w12-20020a4ab6cc000000b0035eb4e5a6d0sm1339467ooo.38.2022.05.20.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:30:50 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, sre@kernel.org, jon.lin@rock-chips.com,
        zyw@rock-chips.com, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [RESEND 0/4 v7] power: supply: Add Support for RK817 Charger
Date:   Fri, 20 May 2022 13:30:33 -0500
Message-Id: <20220520183037.2566-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Resending due to missing cc of DT mailing list.

This series is to add support for the Rockchip rk817 battery charger
which is present in all Rockchip RK817 PMICs. The driver was written
as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
myself Chris Morgan <macromorgan@hotmail.com>.

The driver requires some basic parameters be described about the
battery in the devicetree such as the maximum capacity, the minimum
and maximum voltage for the battery, the maximum charge current, the
maximum charge voltage, and the value of sample resistors and sleep
currents.

The hardware itself contains an ADC capable of measuring the voltage,
current, and temperature of the battery (though my implementation of an
Odroid Go Advance lacks a thermistor for temperature). It also contains
a columb counter, registers for tracking the measured voltage and
current at boot, and a few bytes of nvram for storing data.

Changes from V6:
 - Updated devicetree binding patch to reference the required
   prerequisite patch in the correct manner (relocated it below the ---
   and pointed it to lore.kernel.org).

Changes from V5:
 - Renamed mfd-cell from "battery" to "charger".
 - Added note for devicetree binding documentation that it requires
   application of an additional pending patch (to convert documentation
   to yaml).

Changes from V4:
 - Massively redesigned the battery driver to improve measurement
   accuracy and reliability. Driver now checks values every 8
   seconds (mimicking BSP driver behavior), or whenever a plug event
   is detected.
 - Removed OCV, boot voltage, and boot current as values were found
   to be unreliable.
 - Updated first-boot behavior to perform a "best guess" at capacity.
 - Added ability to calibrate columb counter to full state of charge
   when charger reports full, and added ability calibrate full charge
   capacity when battery discharges from full charge to minimum
   voltage.
 - Expose state of charge as capacity (in percents).
 - Updated storing of values to nvram to preserve compatibility with
   BSP kernel.

Changes from V3:

 - Corrected issues in device tree documentation.
 - Added additional logic to battery to correct for columb counter
   drift when the device stays plugged in at a full charge state.

Changes from V2:

 - Updated devicetree bindings to use common property units.
 - Removed unneeded includes.
 - Updated rk817_chg_cur_to_reg to make more legible.
 - Simplified formula for displaying calibrated voltage.
 - Updated power supply type to POWER_SUPPLY_TYPE_USB.
 - Implemented get/put_unaligned macros for bulk reads and writes.
 - Changed numerous dev_err() to dev_err_probe().
 - Call power_supply_put_battery_info() at end of probe function.
 - Removed unneeded whitespace.

Changes from V1:

 - Fixed a CLANG warning regarding an uninitalized variable.
 - Fixed a CLANG warning regarding a pointer as a bool value always
   returning as true.
 - Added Maya Matuszczyk to the Signed-off-by.

Chris Morgan (4):
  dt-bindings: Add Rockchip rk817 battery charger support
  mfd: Add Rockchip rk817 battery charger support
  power: supply: Add charger driver for Rockchip RK817
  arm64: dts: rockchip: add rk817 chg to Odroid Go Advance

 .../bindings/mfd/rockchip,rk817.yaml          |   48 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |   26 +
 drivers/mfd/rk808.c                           |   16 +-
 drivers/power/supply/Kconfig                  |    6 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/rk817_charger.c          | 1157 +++++++++++++++++
 include/linux/mfd/rk808.h                     |   91 ++
 7 files changed, 1344 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1

