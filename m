Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDFE4936A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352558AbiASI56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352602AbiASI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:57:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73700C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:57:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so4335837wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7wH3Fy0QK4pLP8rp/pio349QaWy+exypBXARmLuDDM=;
        b=bCctUAfh6as+QX3kcgZKdBxST75OU+nLIz5K62rG6t/SuFaEAocBwB9keDSTnl3vaS
         2V64Xpmfp4Arb822opCRyH/fFmL3tHa+DImrnRtfGgNKMJqiUrBzinuACYPmxYihDWY6
         lY8KI3voYPkn7ogj981YCIExs1Xzs/FC/QCyIhIONq6BaJYKlA59GjPKVAn6ScPElPg4
         TZv4PSva3Deh2dsO9HDNxh6m2vSGjzw5P48SNc9yBfjcfgfmxdU9UMY05Wb6nvczMzSh
         7zy9Rz946ASpwK9yDb/EQ8vajW3YZA2T7moxO9Uv7pKTpa5PYpSWN07DBNz7t13xaG+k
         YvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7wH3Fy0QK4pLP8rp/pio349QaWy+exypBXARmLuDDM=;
        b=mQiZOE9DDUNc5aVLvsuj7jd/QuEgyQxX7t9G0ISCOdGcb5K9hrGc2ySr0Nf55Mb2zQ
         ami5w9eQ/B/k6j6sVsj264Ldr7TSElvfDP91EpE0eJRCB8ylEoZybrVX2RhIQEr6rC8M
         cQn+wAXxxAFqT13fj1BHFYZXyB6ZYrdStCAKj7aN/BFLqa1vkGrOVVGjh3Dgs+oDv9xu
         JGQ3BigJEVwOKrNiDaydPgZVhnba3JHeSLApNWZ5tV07b8vF2JCeO5Bd3mOPCnANrRWq
         I9zkb4l2i+10G9LpevDdsmYzNOSW+eE92jIhRbahjVWOs3zOZlRKPHkLUF7BpRda50Cp
         h87Q==
X-Gm-Message-State: AOAM530lFFaBaQrLIMgysPuxvkcrWtFZvxUSmGRLKwGyu6AxwyudlS3G
        JbHHxAB4aBViHz7lFFx78Mw1UQ==
X-Google-Smtp-Source: ABdhPJw0LpkicNpFOniPNUVbEPCYgytuw+4dzpi+UhI/PrbDb+20vJ0H2SDYb0u5lCXcegprD1h6jg==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr26224354wrs.388.1642582673924;
        Wed, 19 Jan 2022 00:57:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ef34:de48:dc4e:ad87])
        by smtp.gmail.com with ESMTPSA id 10sm4491454wmc.44.2022.01.19.00.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:57:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
Date:   Wed, 19 Jan 2022 09:57:14 +0100
Message-Id: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTPM hierarchy is the base to build on top of it a power budget
allocator. It reflects the power consumption of the group of devices
and allows to cap their power.

The core code is there but there is no way to describe the desired
hierarchy yet.

A first proposal introduced the description through configfs [1] but
was rejected [2].

A second proposal based on the device tree with a binding similar to
the power domains [3] was proposed but finally rejected [4].

This sixth version delegates the hierarchy creation to the SoC with a
specific and self-encapsulated code using an array to describe the tree. The
SoC DTPM driver defines an array of nodes pointing to their parents.  The
hierarchy description can integrate a DT node and in the future a SCMI node,
that means the description can mix different type of nodes.

As the DTPM tree depends on different devices which could be modules,
the SoC specific description must always be compiled as a module and
describe the module softdeps in order to let the userspace to handle
proper loading ordering.

In addition to the hierarchy creation, the devfreq dtpm support is also
integrated into this series.

This series was tested on a rock960 (revision B - rk3399 based) and a
db845c (Qualcomm sdm845 based).

[1] https://lore.kernel.org/all/20210401183654.27214-1-daniel.lezcano@linaro.org/
[2] https://lore.kernel.org/all/YGYg6ZeZ1181%2FpXk@kroah.com/
[3] https://lore.kernel.org/all/20211205231558.779698-1-daniel.lezcano@linaro.org/
[4] https://lore.kernel.org/all/YbfFapsmsjs4qnsg@robh.at.kernel.org/

Changelog:
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
 drivers/powercap/dtpm.c           | 170 ++++++++++++++++++++++++-
 drivers/powercap/dtpm_cpu.c       |  41 +++++-
 drivers/powercap/dtpm_devfreq.c   | 204 ++++++++++++++++++++++++++++++
 drivers/powercap/dtpm_subsys.h    |  22 ++++
 drivers/soc/rockchip/Kconfig      |   8 ++
 drivers/soc/rockchip/Makefile     |   1 +
 drivers/soc/rockchip/dtpm.c       |  59 +++++++++
 include/asm-generic/vmlinux.lds.h |  11 --
 include/linux/dtpm.h              |  33 +++--
 11 files changed, 519 insertions(+), 39 deletions(-)
 create mode 100644 drivers/powercap/dtpm_devfreq.c
 create mode 100644 drivers/powercap/dtpm_subsys.h
 create mode 100644 drivers/soc/rockchip/dtpm.c

-- 
2.25.1

