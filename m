Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1584C25B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiBXIN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiBXIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:12:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC35D275CF;
        Thu, 24 Feb 2022 00:11:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7D41063;
        Thu, 24 Feb 2022 00:11:40 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1801B3F70D;
        Thu, 24 Feb 2022 00:11:37 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/4] Introduce "opp-microwatt" and 'advanced' Energy Model from DT
Date:   Thu, 24 Feb 2022 08:11:27 +0000
Message-Id: <20220224081131.27282-1-lukasz.luba@arm.com>
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
v3:
- added generic support in the OPP for "opp-microwatt"
- renamed _of_has_opp_microwatt_property() and return bool from it
- simplified _of_has_opp_microwatt_property() just checking 1st opp's power
- squashed the return ret; into return em_dev_register_perf_domain();
- added EM documentation update patch
v2 [2]

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20220207073036.14901-2-lukasz.luba@arm.com/
[2] https://lore.kernel.org/linux-pm/20220222140746.12293-1-lukasz.luba@arm.com/


Lukasz Luba (4):
  dt-bindings: opp: Add "opp-microwatt" entry in the OPP
  OPP: Add "opp-microwatt" supporting code
  OPP: Add support of "opp-microwatt" for advanced EM registration
  Documentation: EM: Describe new registration method using DT

 .../devicetree/bindings/opp/opp-v2-base.yaml  |  15 +++
 Documentation/power/energy-model.rst          |  10 ++
 drivers/opp/core.c                            |  20 ++++
 drivers/opp/of.c                              | 105 +++++++++++++++++-
 include/linux/pm_opp.h                        |  12 +-
 5 files changed, 159 insertions(+), 3 deletions(-)

-- 
2.17.1

