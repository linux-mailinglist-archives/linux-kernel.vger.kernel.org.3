Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B22A553A61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353359AbiFUTVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiFUTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:21:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C198F27B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:21:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B878A168F;
        Tue, 21 Jun 2022 12:21:00 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB7223F792;
        Tue, 21 Jun 2022 12:20:58 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 07/20] cacheinfo: Use cache identifiers to check if the caches are shared if available
Date:   Tue, 21 Jun 2022 20:20:21 +0100
Message-Id: <20220621192034.3332546-8-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621192034.3332546-1-sudeep.holla@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
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

The cache identifiers is an optional property on most of the platforms. The
presence of one must be indicated by the CACHE_ID valid bit in the attributes.

We can use the cache identifiers provided by the firmware to check if any
two cpus share the same cache instead of relying on the fw_token generated
and set in the OS.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 2aa9e8e341b7..167abfa6f37d 100644
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
2.36.1

