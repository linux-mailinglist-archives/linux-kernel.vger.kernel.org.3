Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959324E23CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbiCUKAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346144AbiCUJ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:59:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17E2333E90;
        Mon, 21 Mar 2022 02:58:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732E5106F;
        Mon, 21 Mar 2022 02:58:12 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F8753F766;
        Mon, 21 Mar 2022 02:58:09 -0700 (PDT)
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
Subject: [RESEND][PATCH 8/8] powercap: DTPM: Check for Energy Model type
Date:   Mon, 21 Mar 2022 09:57:29 +0000
Message-Id: <20220321095729.20655-9-lukasz.luba@arm.com>
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

The Energy Model power values might be artificial. In such case
it's safe to bail out during the registration, since the PowerCap
framework supports only micro-Watts.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index bca2f912d349..f5eced0842b3 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -211,7 +211,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd)
+	if (!pd || em_is_artificial(pd))
 		return -EINVAL;
 
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
-- 
2.17.1

