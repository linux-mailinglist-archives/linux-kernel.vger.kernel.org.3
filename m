Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3C49FE21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350122AbiA1QgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350097AbiA1QgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:36:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF6C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:05 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f17so11986302wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TceRxuk2fQE3djY5Tb2lWnPhhHwofkfTcUwbKOvdyI=;
        b=vVmuf7RRpu6VRa3zvcn34asve1SGLN1cn1oojFVCC8TyE9u/WYi73McT7s7ILNZTm8
         /ajq4N/os8jZxw8vHpVU8abJUGIMc5jlKNVoyDI/vGt2V8VGwh/0Lr39qN3RTrfYfLk5
         kR5dmJpuV6tdIMDnvYjkP9529o7VrRgJ1XQ4N0B1MAMKulxa93lh6ynqc4+YKF//AxZW
         GuwY7wcMJc3cQx/C2ytNiMU0LtK+8zgtdF74OsullakR6JOv1C9RUy2j4+LzXbFIJ5jK
         CddXGIYwiHcxw8Yy5+M9CCUczk4RSlDNFGRKTyX8TNnXgEHmsDoRnIoYehKbuZZePbAp
         hu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TceRxuk2fQE3djY5Tb2lWnPhhHwofkfTcUwbKOvdyI=;
        b=V+amJwhkSSLIw0JDcn3rejG+7D/CLNGsHmd9TbcX6eakg0m8RsnV8xUt5U+ESOnwpi
         yLYPThDsFmMdotyPjeBb0lIKJQ3tjw5jg3E2bpbYnQymBSere/BT77nKNtsW9uqeEbCq
         4K7RuYT+jH8idB+w3mNBwq/+4Ze/BOxAWMBI80S7gdosLNYmHwO4dUto80fTpz+ErI0Q
         TPP7S3umRZxwWz3fo9jk2umhfNg9INzeXqNT7Cno6QR9QA7SVJWkqpB4N+engoke7Kk2
         tiX7JS8y9XZdTfZTkK/U3Ga5oEzxxIEv/5lSpY9aEUUf0ryQnk08xr7yb+9SstbP4doH
         ttJw==
X-Gm-Message-State: AOAM532XZVOK208rtwTB1MFjMMCSz2/6r/OugrrfbNEydN1byUoSOOfm
        l28ld3H8C0LLWKydfrwvs4AcCg==
X-Google-Smtp-Source: ABdhPJwlsnRDe760kCFZnGg4E9DX6U0EsgF0aATukMI2rRQ99YHdR6TiAPpD6lc6K2xCeDCbMdqzFQ==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr7934942wro.373.1643387763678;
        Fri, 28 Jan 2022 08:36:03 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f39:b962:8b8e:9851])
        by smtp.gmail.com with ESMTPSA id m6sm5734745wrw.54.2022.01.28.08.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:36:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, robh@kernel.org, lukasz.luba@arm.com,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v8 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
Date:   Fri, 28 Jan 2022 17:35:32 +0100
Message-Id: <20220128163537.212248-1-daniel.lezcano@linaro.org>
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
   V8:
   - Add '/* sentinel */' in the last array entry
   - Remove Panfrost dependency in the dtpm rockchip module's Kconfig

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

