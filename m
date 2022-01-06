Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D96485E59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbiAFCAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbiAFCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:00:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778BC061245;
        Wed,  5 Jan 2022 18:00:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j16so1429544pll.10;
        Wed, 05 Jan 2022 18:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=j+UPXoWRvsd6TQosqFJ7PGvRf0qHNZTzVG3paYmH9/Q=;
        b=khvko3Zbz4x0sAGpKeDa3PCZ4sE5mhYBt7NLiYvtKozLns/Ah2LYvyiOtSYGNx9oz9
         lumUA8hqvzq9bCBx3YBY4N20Aj6ihrb5TzGkfPmnBLLnGuf4O9XfP+bu8xwXjDJEx9OW
         o2EID33jx9zz/VW52/LQWlaFYzPH/TFrKbH+x3+040OfK4vXZdFxBw04WwvDCcXUNz3g
         5sWKPWK8WGZeCYYXLDc7zCYvtMXNumQr4D88TqGtebFQ39BJdkxq2v0f7idN/TYSH5be
         CMDc0NX1xtyMMFI7iCPlkeVLIinivobaCIhOlzdv0Zt6l715VDP+3P9ivPInS0StmgsG
         ebug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j+UPXoWRvsd6TQosqFJ7PGvRf0qHNZTzVG3paYmH9/Q=;
        b=ItWWOSMka8h9/YxQKsiNdXTD0xjOYS/hPi+m+LZWdcxt8t7FeX8NBFb+OSASh0EUoz
         Po/9/exVRE4KPAR1DCzzBnYuqsqO31yweosidj4e/KGHkohKPmeyOYIETpqoFrSi4+XO
         9jikUrdIaQTnIDHaWPAGuyqPNd1+6B2ctcpbdZ2Jzg9YM6jEiM4GDS7U4hEg5inn4uxy
         iHO4owl8FEfO/8Ab+iQF3STR/b2lGioiT2zNphpBZqoRDcbnDll3x6N+9kBQ+j38jwvs
         QZJJkLVEkGftMCybFHDaXTLIZHX2GGv1RSu+nQeINhAOuLcSiW2SdQUwu1Ut75AReapd
         OH0A==
X-Gm-Message-State: AOAM532MB29OvLA19SCnoftdpi/ODkH/BZYszcvnDurFDLJlzSi/3xl1
        ugCBO8dg8e1+pE9EY+ayrOs=
X-Google-Smtp-Source: ABdhPJx0YKc92T7hynlSfX5GCrQyxPEOqcZ1MCHdFPyYbHTlk/sUkhwg1cMz6XAZdPJRqQGb8d+STA==
X-Received: by 2002:a17:90b:3842:: with SMTP id nl2mr7487376pjb.80.1641434401193;
        Wed, 05 Jan 2022 18:00:01 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t21sm256600pgn.28.2022.01.05.17.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 18:00:00 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v3 0/2] Add cpuidle driver for Sunplus SP7021
Date:   Thu,  6 Jan 2022 10:00:06 +0800
Message-Id: <cover.1641432983.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for cpuidle driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and 
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Edwin Chiu (2):
  dt-bingings:arm:sunplus:add sp7021 compatible string to
    sunplus,idle-state.yaml
  cpuidle:sunplus:create cpuidle driver for sunplus sp7021

 .../bindings/arm/sunplus/sunplus,idle-state.yaml   |  59 ++++++++
 MAINTAINERS                                        |   9 ++
 drivers/cpuidle/Kconfig.arm                        |   7 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-sunplus.c                  | 167 +++++++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h      |  19 +++
 6 files changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
 create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

-- 
2.7.4

