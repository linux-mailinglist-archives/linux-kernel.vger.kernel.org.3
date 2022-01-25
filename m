Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3149BA32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587823AbiAYRUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587568AbiAYRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:18:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA0C06175C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:18:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c23so5500032wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5mFzd7DvgqAHtEGdNhKrSA7iqlVt7Wcb1H8I+i732Y=;
        b=T4Rxal21LhPN5/dmpXnWEduyScRqg/rryykYOzKIQ/fEm8ad8RN8xao+Z4GywZpqD8
         KgQg9Jg4cZiv7VfwHcWApGqCVlWdde7oEfF6IWGWe3xCB16sMnM/kkyM93H5AfpdisZP
         +JAsLnV3w6I2tFDrCtq6E8/xI/yiw6uLz/UpEdQRCkNCG194MYB4qLDUczzRw6OgCSit
         UoIb6Ru1FBD1J2cxFQUEvOT7etQYftJgWZySxtDWvtZBZ2GxEzraA4h0kWwqIFxEsRQx
         yRVJsxAilc4v6rQCMfydEfs7K2J/mpT5/73/ZgTPGomSLpTeOVrKGtFvcR5vjJD82GvU
         VYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5mFzd7DvgqAHtEGdNhKrSA7iqlVt7Wcb1H8I+i732Y=;
        b=1EnO9I1La3GVzUlx1rQxezzq7l9qTWfN2gyt8cXxo0ngArqLAMBNVzd6EDobxn7qdN
         fZNNt41MHKAJjcyy0cxfSOECr0zCpy6c88zAWf4sp11tj/z470GkM+O9sK5cnyrIlv9B
         YVdr8pM5jdwDhkm/zKiXStPyaZz8JCcvFX1ueKlHT04Tcwc0UMinqCcB5RB6jC3olP1K
         mImeDsIt4QfkdR0Nk9SWdfABaYQ3AQsdbstRudXyd5y26sc37Oa/8nasLiqJ24pavEh2
         S2xSkjqm3Njp9xcXz34NuOycE0RTJ+YIKjh4XqLf1Vg95UdJghG0O2cGw9WrIz6XfR11
         9z1A==
X-Gm-Message-State: AOAM5314xCQZymUqjihV+nirCfur5GWnB20fQVPuXzK/cTSR+vWI8Ppx
        +m47HIUvImflPQN56xT/NP9mAw==
X-Google-Smtp-Source: ABdhPJz8iisKAmEQZfGCdwSA1fIN4zu6Ez8xWTyGjVID3fzGuK5l8/zCSUV9Fk99PhhcbmTaQ6AKrg==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr19039430wrw.310.1643131100164;
        Tue, 25 Jan 2022 09:18:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.gmail.com with ESMTPSA id t18sm17561901wri.34.2022.01.25.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:18:19 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
Date:   Tue, 25 Jan 2022 18:18:04 +0100
Message-Id: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTPM hierarchy is the base to build on top of it a power budget allocator.
It reflects the power consumption of the group of devices and allows to cap
their power.

The core code is there but there is no way to describe the desired hierarchy
yet.

A first proposal introduced the description through configfs [1] but was
rejected [2].

A second proposal based on the device tree with a binding similar to the power
domains [3] was proposed but finally rejected [4].

This version delegates the hierarchy creation to the SoC with a specific and
self-encapsulated code using an array to describe the tree. The SoC DTPM driver
defines an array of nodes pointing to their parents.  The hierarchy description
can integrate a DT node and in the future a SCMI node, that means the
description can mix different type of nodes.

As the DTPM tree depends on different devices which could be modules, the SoC
specific description must always be compiled as a module and describe the
module softdeps in order to let the userspace to handle proper loading
ordering.

In addition to the hierarchy creation, the devfreq dtpm support is also
integrated into this series.

This series was tested on a rock960 (revision B - rk3399 based) and a db845c
(Qualcomm sdm845 based).

[1] https://lore.kernel.org/all/20210401183654.27214-1-daniel.lezcano@linaro.org/
[2] https://lore.kernel.org/all/YGYg6ZeZ1181%2FpXk@kroah.com/
[3] https://lore.kernel.org/all/20211205231558.779698-1-daniel.lezcano@linaro.org/
[4] https://lore.kernel.org/all/YbfFapsmsjs4qnsg@robh.at.kernel.org/

Changelog:
   V7:
   - Added a couple of comments if a node in the hierarchy fails to create
   - Fixed a double free in dtpm_devfreq in the error path

   V6:
   - Switched the init table to a subsystem arrays
   - Checked 'setup' function is set before calling it
   - Moved out of the loop the 'of_node_put'
   - Explicitely add DTPM_NODE_VIRTUAL in documentation
   - Moved powercap_register_control_type() into the hierarchy creation function
   - Removed the sdm845 description
   - Made rk3399 always as a module and added module softdeps

   V5:
   - Remove DT bindings
   - Added description with an array
   - Added simple description for rk3399 and sdm845
   - Moved dtpm table to the data section

   V4:
   - Added missing powerzone-cells
   - Changed powerzone name to comply with the pattern property

   V3:
   - Remove GPU section as no power is available (yet)
   - Remove '#powerzone-cells' conforming to the bindings change
   - Removed required property 'compatible'
   - Removed powerzone-cells from the topmost node
   - Removed powerzone-cells from cpus 'consumers' in example
   - Set additionnal property to false

   V2:
   - Added pattern properties and stick to powerzone-*
   - Added required property compatible and powerzone-cells
   - Added additionnal property
   - Added compatible
   - Renamed to 'powerzones'
   - Added missing powerzone-cells to the topmost node
   - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
   - Move description in the SoC dtsi specific file
   - Fixed missing prototype warning reported by lkp@

   V1: Initial post

Daniel Lezcano (5):
  powercap/drivers/dtpm: Convert the init table section to a simple
    array
  powercap/drivers/dtpm: Add hierarchy creation
  powercap/drivers/dtpm: Add CPU DT initialization support
  powercap/drivers/dtpm: Add dtpm devfreq with energy model support
  rockchip/soc/drivers: Add DTPM description for rk3399

 drivers/powercap/Kconfig          |   8 ++
 drivers/powercap/Makefile         |   1 +
 drivers/powercap/dtpm.c           | 192 +++++++++++++++++++++++++++-
 drivers/powercap/dtpm_cpu.c       |  41 ++++--
 drivers/powercap/dtpm_devfreq.c   | 203 ++++++++++++++++++++++++++++++
 drivers/powercap/dtpm_subsys.h    |  22 ++++
 drivers/soc/rockchip/Kconfig      |   8 ++
 drivers/soc/rockchip/Makefile     |   1 +
 drivers/soc/rockchip/dtpm.c       |  59 +++++++++
 include/asm-generic/vmlinux.lds.h |  11 --
 include/linux/dtpm.h              |  33 +++--
 11 files changed, 540 insertions(+), 39 deletions(-)
 create mode 100644 drivers/powercap/dtpm_devfreq.c
 create mode 100644 drivers/powercap/dtpm_subsys.h
 create mode 100644 drivers/soc/rockchip/dtpm.c

-- 
2.25.1

