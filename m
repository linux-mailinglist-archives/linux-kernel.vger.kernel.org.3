Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3FD4CA3BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiCBLab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbiCBLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:30:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7047E7DA89;
        Wed,  2 Mar 2022 03:29:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6611424;
        Wed,  2 Mar 2022 03:29:35 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECE963F70D;
        Wed,  2 Mar 2022 03:29:32 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 3/5] PM: EM: add macro to set .active_power() callback conditionally
Date:   Wed,  2 Mar 2022 11:29:15 +0000
Message-Id: <20220302112917.27270-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302112917.27270-1-lukasz.luba@arm.com>
References: <20220302112917.27270-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model is able to use new power values coming from DT. Add a new
macro which is helpful in setting the .active_power() callback
conditionally in setup time. The dual-macro implementation handles both
kernel configurations: w/ EM and w/o EM built-in.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 6377adc3b78d..9f3c400bc52d 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -116,6 +116,7 @@ struct em_data_callback {
 			    struct device *dev);
 };
 #define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
+#define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
@@ -264,6 +265,7 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 #else
 struct em_data_callback {};
 #define EM_DATA_CB(_active_power_cb) { }
+#define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)
 
 static inline
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-- 
2.17.1

