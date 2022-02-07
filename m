Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6964AB5FF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiBGHnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244572AbiBGHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:38:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C40F5C043184;
        Sun,  6 Feb 2022 23:38:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 184751396;
        Sun,  6 Feb 2022 23:30:52 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.15.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2C1A3F73B;
        Sun,  6 Feb 2022 23:30:49 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, dietmar.eggemann@arm.com, lukasz.luba@arm.com,
        Pierre.Gondois@arm.com
Subject: [PATCH 2/2] powercap: DTPM: Check Energy Model type for power values scale
Date:   Mon,  7 Feb 2022 07:30:36 +0000
Message-Id: <20220207073036.14901-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207073036.14901-1-lukasz.luba@arm.com>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model power values might be in an abstract scale. In such case
it's safe to bail out during the registration, since the PowerCap
framework supports only micro-Watts.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..e6bcde081de4 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -188,7 +188,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd)
+	if (!pd || !(pd->flags & EM_PERF_DOMAIN_MILLIWATTS))
 		return -EINVAL;
 
 	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
-- 
2.17.1

