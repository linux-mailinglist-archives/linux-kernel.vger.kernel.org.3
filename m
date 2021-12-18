Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2353479AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhLRNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhLRNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:00:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB4AC061401
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 05:00:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z206so3440313wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGCcvzc1i7joV1yi0Wsfc4TZ47/jx0wkTHcok5ASBnw=;
        b=zesNCHewQp/51E4hzbWSP9jOj9oguraG6Ze+qcquEUnT4l5P8eeYMg3k5Yxia9YS4G
         IL9GhAYZVbdwE8HLXU9mH3tO56LpGjJI0eV09cOR/iyNvn+D1D92h8I16O+ciRg3/Aqm
         vZJwllKsf4vBrLSCHcZrKoceNpvfw56xBDB3+eVxGspKkQluGMkBv1sjOMkhb72+j4yT
         DewQhmpHqx8N7BZfTs1KslrUw5wEGcLHLTMPOKh2Jq5z1Ox2szEDiTmVqpDJL8sludfH
         oXQ0qH1EEiM/33Q3bIiHONfaYCS6mkpUv78EWgu+cs/jeKoPoKUFU0pIWG4q1tJvbfeU
         JMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGCcvzc1i7joV1yi0Wsfc4TZ47/jx0wkTHcok5ASBnw=;
        b=4sOmEc6xgoQv4pttSbw3U6zj/MtkId2+ajOYhlHcEjhUNOvu+QwKgIw2HeiMsRIm0C
         kAFFLanoQZo3tMElLchgwKYkLp7HceXipbg1LIZfyB8zbetdeX2OE0y7Qe5KobIfJohH
         Ma2XS164Zp/6NMZlydb0TfiufHduCWbHvR6XpHAArVfQwivSm68PHVcmnR7EvN8ghuL0
         rq8Y0W5PyRyJR6RCEXG2qOW37fk1QV8I8YAIXkqB+ulSFLwvZrK4zSakg6g0bzM7Ih0J
         hBrt+ma8oGhLC8UedapZWp5iMfP4Lg7aeE1n84YTKmw3z3Nyl+XG3MqkWs++yoPspOEO
         AtBw==
X-Gm-Message-State: AOAM532htyGJHFRvFTYlqcQgTeEYOJcwvJFuEkfXScU3BGYFJ7CWNpD8
        KKFZHh3WrXycIS9qYOYtthwBgw==
X-Google-Smtp-Source: ABdhPJw+R3Cvou/c038819emKCk0uPHBpsJVNGcmY1AM9dDl6mdDk20jvdAvz5Su6dTUYlyJVo7+LQ==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr6178586wmg.176.1639832430625;
        Sat, 18 Dec 2021 05:00:30 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1f0f:c9b8:ee5c:5c2f])
        by smtp.gmail.com with ESMTPSA id j16sm1465785wms.12.2021.12.18.05.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 05:00:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org
Subject: [PATCH v5 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
Date:   Sat, 18 Dec 2021 14:00:08 +0100
Message-Id: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
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

This fifth version delegates the hierarchy creation to the SoC with a
specific and self-encapsulated code using an array to describe the tree. The
SoC DTPM driver defines an array of nodes pointing to their parents.  The
hierarchy description can integrate a DT node and in the future a SCMI node,
that means the description can mix different type of nodes.

In addition to the hierarchy creation, the devfreq dtpm support is also
integrated into this series.

This series was tested on a rock960 (revision B - rk3399 based) and a
db845c (Qualcomm sdm845 based).

[1] https://lore.kernel.org/all/20210401183654.27214-1-daniel.lezcano@linaro.org/
[2] https://lore.kernel.org/all/YGYg6ZeZ1181%2FpXk@kroah.com/
[3] https://lore.kernel.org/all/20211205231558.779698-1-daniel.lezcano@linaro.org/
[4] https://lore.kernel.org/all/YbfFapsmsjs4qnsg@robh.at.kernel.org/

Changelog:
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

Daniel Lezcano (6):
  powercap/drivers/dtpm: Move dtpm table from init to data section
  powercap/drivers/dtpm: Add hierarchy creation
  powercap/drivers/dtpm: Add CPU DT initialization support
  powercap/drivers/dtpm: Add dtpm devfreq with energy model support
  rockchip/soc/drivers: Add DTPM description for rk3399
  qcom/soc/drivers: Add DTPM description for sdm845

 drivers/powercap/Kconfig          |   8 ++
 drivers/powercap/Makefile         |   1 +
 drivers/powercap/dtpm.c           | 155 ++++++++++++++++++++++-
 drivers/powercap/dtpm_cpu.c       |  37 ++++--
 drivers/powercap/dtpm_devfreq.c   | 201 ++++++++++++++++++++++++++++++
 drivers/soc/qcom/Kconfig          |   9 ++
 drivers/soc/qcom/Makefile         |   1 +
 drivers/soc/qcom/dtpm.c           |  65 ++++++++++
 drivers/soc/rockchip/Kconfig      |   8 ++
 drivers/soc/rockchip/Makefile     |   1 +
 drivers/soc/rockchip/dtpm.c       |  56 +++++++++
 include/asm-generic/vmlinux.lds.h |   4 +-
 include/linux/dtpm.h              |  21 +++-
 13 files changed, 551 insertions(+), 16 deletions(-)
 create mode 100644 drivers/powercap/dtpm_devfreq.c
 create mode 100644 drivers/soc/qcom/dtpm.c
 create mode 100644 drivers/soc/rockchip/dtpm.c

-- 
2.25.1

