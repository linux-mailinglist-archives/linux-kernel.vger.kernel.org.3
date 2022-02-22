Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8E4BFA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiBVOJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiBVOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:09:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB59614ACAB;
        Tue, 22 Feb 2022 06:08:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7550E106F;
        Tue, 22 Feb 2022 06:08:51 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 35D693F5A1;
        Tue, 22 Feb 2022 06:08:49 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] Introduce 'advanced' Energy Model in DT
Date:   Tue, 22 Feb 2022 14:07:44 +0000
Message-Id: <20220222140746.12293-1-lukasz.luba@arm.com>
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
It adds a new callback in OPP framework to parse the OPP node entry and
read the "opp-microwatt". It's going to only work with OPP-v2, but it's
agreed to be OK.

Comments, suggestions are very welcome.

changelog:
v2:
- implemented Viresh idea to add "opp-microwatt" into the OPP node entry in DT
v1 [2]

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20220207073036.14901-2-lukasz.luba@arm.com/
[2] https://lore.kernel.org/linux-pm/20220221225131.15836-1-lukasz.luba@arm.com/

Lukasz Luba (2):
  dt-bindings: opp: Add 'opp-microwatt' entry in the OPP
  OPP: Add 'opp-microwatt' parsing for advanced EM registration

 .../devicetree/bindings/opp/opp-v2-base.yaml  |  7 ++
 drivers/opp/of.c                              | 70 +++++++++++++++++++
 2 files changed, 77 insertions(+)

-- 
2.17.1

