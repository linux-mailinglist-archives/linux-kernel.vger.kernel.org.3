Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0634A973E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357915AbiBDJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357909AbiBDJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:57:50 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E936C061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:57:50 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ah7so17639087ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxfD0UgE96vrL30pUVU0FAbTN615U3BGwMMRqFNLsKM=;
        b=l3PoTKI1GCpIJezXfi5avA1DKNi4n8bOq69QBqoo8FmHj7aJWRRGOA6bmk8oLuS5mR
         FCzNKKu7JaA4fWDCRqbevWIGkJhNG3JH4c0gr651ai1f3wYcKR3nTfHdBCIK7Dzd+KzY
         bfymTQqCBxjZZCBbNEfHVLNBmXcb91MC/vEBlMHiblSMzFBTMqTtcDzGB+PTAWiY8oMy
         MJ5ZQVysXZbl9/wn/K2SpUlyx4wCyWfwp6AqqU2S6ODyKAIX921mJ2vSiGGeagn2KR7e
         mut+qFNj/4IOC5EGqsUSsVyy5gwtDndk0L6sCJF3ONNmYOyrGrFRA8RBxGIcEie9N58N
         A6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TxfD0UgE96vrL30pUVU0FAbTN615U3BGwMMRqFNLsKM=;
        b=N10iRk0twD/ZT5qshS+CzLUcovJD6g87o3XQrdB+EKRcdiZPMtj0FCgeZ/AoZ3WQk/
         Qxpa1Zx3EdpgkLLY0SWJR7CcQ0YbbnD1Lw0S0k365x98J2WNYuskAV4p1xaMuZqxuPGA
         nnPtaf/bnq2upNm2u6I+1us50TojJ/JMeT9SmdAmZjJrysDBGKyUExc9WraK9GKUkpyY
         my+bTVaOm48CSUaGuRufb1J4Sv38GriiujECENcLq7tr77H9rvdT5kLhmoDpv9wggiM8
         x3gYlml2ohqXVK/H6Qq9y+MZI3McKvd83jbhbynFxXOnfOnevX9oGRGzyN3L6PLvi065
         iJ1w==
X-Gm-Message-State: AOAM532j6GF4gSX566uznUPUCYllWPxe2yI4s9yJnY/X9bDvGxVzEeUT
        sSk64ZKjg0iIsWKGzwYb7eXx7w0cF8ETdA==
X-Google-Smtp-Source: ABdhPJwY3DBC3lKZo17PJVeaUfBx1jO0gC0bwu2XVtreCP0t7qWBYF5tvLwnwFYx3oPEuNRb5+sroQ==
X-Received: by 2002:a17:907:2ce6:: with SMTP id hz6mr1780120ejc.89.1643968668723;
        Fri, 04 Feb 2022 01:57:48 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id n21sm617619edq.27.2022.02.04.01.57.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Feb 2022 01:57:48 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Alex Helms <alexander.helms.jy@renesas.com>,
        David Cater <david.cater.jc@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v9 0/2] Renesas 8T49N241 device driver
Date:   Fri,  4 Feb 2022 10:57:37 +0100
Message-Id: <cover.1643968653.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

driver is under review for quite a long time with very small change
required. I have added that reported changes to driver and sending new
version.

Please also ignore "No changes since v1) in patches. It is created by
patman (tool I use for sending patches).

Thanks,
Michal

Changes in v9:
- Integrate issues reported by Dan
  https://lore.kernel.org/all/202110281624.lV6hDzvG-lkp@intel.com/
Changes in v8:
 * Use __ffs instead of ffs
 * Change from 64 bit to 32 bit division
 * Minor math changes to avoid possible overflow
Changes in v7:
 * Rebase on v5.15-rc6
 * Rename renesas24x_* functions to r8t49n24x_*
 * Implement determine_rate instead of round_rate
 * Implement prepare/unprepare
 * Use devm_clk_get_optional and ensure clk0, clk1, and xtal are attempted before dev_err_probe
 * Use ffs() in __renesas_bits_to_shift
 * Remove regmap read/write retry
 * More consistent debug logging
 * Resolved many C related naming and initialization issues
Changes in v6:
 * Rebase on v5.15-rc1
 * Ensure Rob's Reviewed-by tag is included
Changes in v5:
 * Rebase on v5.14-rc2
 * Move driver files from clk/renesas to clk
Changes in v4:
 * Add vendor prefix to dt binding compatible property
 * Remove clock-names description in dt binding
 * Remove redundant 'input-' prefix on clock names
 * Clarify the settings property in dt binding, add data type
 * Fix define spacing
Changes in v3:
 * Clarify settings property in device tree bindings schema is optional
Changes in v2:
 * Correct missing semicolon in 8t49n24x-core.c

(no changes since v1)

Alex Helms (2):
  dt-bindings: Add binding for Renesas 8T49N241
  clk: Add ccf driver for Renesas 8T49N241

 .../bindings/clock/renesas,8t49n241.yaml      | 190 +++++
 MAINTAINERS                                   |   7 +
 drivers/clk/8t49n24x-core.c                   | 752 ++++++++++++++++++
 drivers/clk/8t49n24x-core.h                   | 242 ++++++
 drivers/clk/8t49n24x.c                        | 565 +++++++++++++
 drivers/clk/Kconfig                           |  21 +
 drivers/clk/Makefile                          |   2 +
 7 files changed, 1779 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml
 create mode 100644 drivers/clk/8t49n24x-core.c
 create mode 100644 drivers/clk/8t49n24x-core.h
 create mode 100644 drivers/clk/8t49n24x.c

-- 
2.35.0

