Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691E55100D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351700AbiDZOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351690AbiDZOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:49:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E051913CE9;
        Tue, 26 Apr 2022 07:45:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEE223A;
        Tue, 26 Apr 2022 07:45:53 -0700 (PDT)
Received: from localhost.localdomain (pierre123.nice.arm.com [10.34.129.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD22D3F73B;
        Tue, 26 Apr 2022 07:45:50 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     cristian.marussi@arm.com, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, Pierre Gondois <Pierre.Gondois@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1] PM: EM: Decrement policy counter
Date:   Tue, 26 Apr 2022 16:44:48 +0200
Message-Id: <20220426144448.43682-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

Fixes: e458716a92b57 ("PM: EM: Mark inefficiencies in CPUFreq")
In the above commit, cpufreq_cpu_get() is called without
a cpufreq_cpu_put(), permanently increasing the reference counts
of the policy struct.
Decrement the reference count once the policy struct is not used
anymore.

Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/power/energy_model.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 0153b0ca7b23..6219aaa454b5 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -259,6 +259,8 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
 			found++;
 	}
 
+	cpufreq_cpu_put(policy);
+
 	if (!found)
 		return;
 
-- 
2.25.1

