Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70E04C8819
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiCAJgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiCAJgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:36:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 708C5BC1B;
        Tue,  1 Mar 2022 01:36:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03A7CED1;
        Tue,  1 Mar 2022 01:36:06 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.20.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F9AE3F73D;
        Tue,  1 Mar 2022 01:36:03 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 0/4] Introduce "opp-microwatt" and Energy Model from DT
Date:   Tue,  1 Mar 2022 09:35:20 +0000
Message-Id: <20220301093524.8870-1-lukasz.luba@arm.com>
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
v4:
- changed calculation of power, summing add all supliers power for an opp
- added opp debugfs for u_watt
- added patternProperties in dt-bindings for this new opp-microwatt
- changed the EM opp registration flow and used one EM api registration call
- changed name of _get_opp_power() to _get_dt_power()
- removed 'advanced' word from the new paragraph and content in EM doc changes
v3 [2]

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20220207073036.14901-2-lukasz.luba@arm.com/
[2] https://lore.kernel.org/linux-pm/20220224081131.27282-1-lukasz.luba@arm.com/

Lukasz Luba (4):
  dt-bindings: opp: Add "opp-microwatt" entry in the OPP
  OPP: Add "opp-microwatt" supporting code
  OPP: Add support of "opp-microwatt" for advanced EM registration
  Documentation: EM: Describe new registration method using DT

 .../devicetree/bindings/opp/opp-v2-base.yaml  |  23 ++++
 Documentation/power/energy-model.rst          |  10 ++
 drivers/opp/core.c                            |  25 +++++
 drivers/opp/debugfs.c                         |   3 +
 drivers/opp/of.c                              | 104 +++++++++++++++++-
 include/linux/pm_opp.h                        |  12 +-
 6 files changed, 174 insertions(+), 3 deletions(-)

-- 
2.17.1

