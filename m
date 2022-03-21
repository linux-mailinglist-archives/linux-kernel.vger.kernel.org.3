Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0724E23D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbiCUJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346153AbiCUJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:59:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E96B25E90;
        Mon, 21 Mar 2022 02:58:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10FD4106F;
        Mon, 21 Mar 2022 02:58:06 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 351C33F766;
        Mon, 21 Mar 2022 02:58:03 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: [RESEND][PATCH 6/8] Documentation: EM: Add artificial EM registration description
Date:   Mon, 21 Mar 2022 09:57:27 +0000
Message-Id: <20220321095729.20655-7-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220321095729.20655-1-lukasz.luba@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description about new artificial EM registration and use cases.
Update also the documentation with the new .get_cost() callback
description and usage.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index fd29ed2506c0..feb257b7f350 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -123,6 +123,26 @@ allows a platform to register EM power values which are reflecting total power
 (static + dynamic). These power values might be coming directly from
 experiments and measurements.
 
+Registration of 'artificial' EM
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There is an option to provide a custom callback for drivers missing detailed
+knowledge about power value for each performance state. The callback
+.get_cost() is optional and provides the 'cost' values used by the EAS.
+This is useful for platforms that only provide information on relative
+efficiency between CPU types, where one could use the information to
+create an abstract power model. But even an abstract power model can
+sometimes be hard to fit in, given the input power value size restrictions.
+The .get_cost() allows to provide the 'cost' values which reflect the
+efficiency of the CPUs. This would allow to provide EAS information which
+has different relation than what would be forced by the EM internal
+formulas calculating 'cost' values. To register an EM for such platform, the
+driver must set the flag 'milliwatts' to 0, provide .get_power() callback
+and provide .get_cost() callback. The EM framework would handle such platform
+properly during registration. A flag EM_PERF_DOMAIN_ARTIFICIAL is set for such
+platform. Special care should be taken by other frameworks which are using EM
+to test and treat this flag properly.
+
 Registration of 'simple' EM
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.17.1

