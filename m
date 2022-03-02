Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E34CA3AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiCBLaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiCBLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:30:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2F9831214;
        Wed,  2 Mar 2022 03:29:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C43C13D5;
        Wed,  2 Mar 2022 03:29:27 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62C4C3F70D;
        Wed,  2 Mar 2022 03:29:25 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 0/5] Introduce "opp-microwatt" and Energy Model from DT
Date:   Wed,  2 Mar 2022 11:29:12 +0000
Message-Id: <20220302112917.27270-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set solves a few issues:
1. It allows to register EM from DT, when the voltage information is not
   available. (Some background of the issues present on Chromebook devices
   can be checked at [1].)
2. It allows to register 'advanced' EM from the DT, which is more accurate
   and reflects total power (dynamic + static).

Implementation details:
Existing machinery in the OPP framework now handles "opp-microwatt", similarly
to "opp-microamp". It also has helper exported function to get power from OPP.
For the EM, it adds a new callback in OPP framework to use this new API and
read power while having an opp pointer. It's agreed to work with OPP-v2.

Comments, suggestions are very welcome.

changelog:
v5:
- added dual-macro to conditionally setup needed callback and compile
  on !EM kernel gently
- removed 'advanced' word from OPP patch header description
v4 [2]

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20220207073036.14901-2-lukasz.luba@arm.com/
[2] https://lore.kernel.org/linux-pm/20220301093524.8870-1-lukasz.luba@arm.com/


Lukasz Luba (5):
  dt-bindings: opp: Add "opp-microwatt" entry in the OPP
  OPP: Add "opp-microwatt" supporting code
  PM: EM: add macro to set .active_power() callback conditionally
  OPP: Add support of "opp-microwatt" for EM registration
  Documentation: EM: Describe new registration method using DT

 .../devicetree/bindings/opp/opp-v2-base.yaml  |  23 ++++
 Documentation/power/energy-model.rst          |  10 ++
 drivers/opp/core.c                            |  25 ++++
 drivers/opp/debugfs.c                         |   3 +
 drivers/opp/of.c                              | 108 +++++++++++++++++-
 include/linux/energy_model.h                  |   2 +
 include/linux/pm_opp.h                        |  12 +-
 7 files changed, 179 insertions(+), 4 deletions(-)

-- 
2.17.1

