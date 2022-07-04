Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D307F5651F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiGDKRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiGDKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:16:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3DB0DFA4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033C6D6E;
        Mon,  4 Jul 2022 03:16:30 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6AF63F792;
        Mon,  4 Jul 2022 03:16:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v6 07/21] cacheinfo: Use cache identifiers to check if the caches are shared if available
Date:   Mon,  4 Jul 2022 11:15:51 +0100
Message-Id: <20220704101605.1318280-8-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220704101605.1318280-1-sudeep.holla@arm.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache identifiers is an optional property on most of the platforms.
The presence of one must be indicated by the CACHE_ID valid bit in the
attributes.

We can use the cache identifiers provided by the firmware to check if
any two cpus share the same cache instead of relying on the fw_token
generated and set in the OS.

Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 4d21a1022fa9..e331b399adeb 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -44,6 +44,10 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
 		return !(this_leaf->level == 1);
 
+	if ((sib_leaf->attributes & CACHE_ID) &&
+	    (this_leaf->attributes & CACHE_ID))
+		return sib_leaf->id == this_leaf->id;
+
 	return sib_leaf->fw_token == this_leaf->fw_token;
 }
 
@@ -56,7 +60,8 @@ bool last_level_cache_is_valid(unsigned int cpu)
 
 	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
 
-	return !!llc->fw_token;
+	return (llc->attributes & CACHE_ID) || !!llc->fw_token;
+
 }
 
 bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y)
-- 
2.37.0

