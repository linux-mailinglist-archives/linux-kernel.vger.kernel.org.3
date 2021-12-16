Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2031947809F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhLPXbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:45 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35672 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLPXbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:34 -0500
Received: by mail-ot1-f54.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso809051otr.2;
        Thu, 16 Dec 2021 15:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycz4c/Gy+gSmZUry4vxqmr8soODhiW4Pk4hS4ry0XPo=;
        b=I12Py2D0UcIzuNph1FKMMkWIcPQDGr6Y7Bm5ovLU3Nn4f0CUEGkrAtzptxnieavyQi
         bZ+8DBVpCKagkiQatcNHVdtGyzFGjiOTdP2rx/CWRaSr548QFV1f6qCDEU9/ITxRHL5k
         iPaXGYARhmXLUe7k7VwIp4Vwe2Ot996CbfmWPa4sHZscdCKPxO1iOHNg04JzcrHSRYPB
         9lALCo1GG9xPc9BtaC9z8Zqr3H8f1GDcBjmyQbKdGMSFy/RtAWaej67tm8R1fUXWK2kZ
         qB2hUZzmyHk3Kdxaowol1zlvaNh5eFWEVwb9kgDqHaK6gcSqKZt8VKvShn6bbwi+0KPc
         ePYQ==
X-Gm-Message-State: AOAM533MLgZt0xPfAJHwP5rvBtc3VhT/c8GRMIVgyRdJ+cLHkK51BxdX
        SLRnf/g0LhIJxTJNiYagZg==
X-Google-Smtp-Source: ABdhPJyh4CVWOSFgpPwp/C989LpGlcZ4EDHX0BCRj+KlvLZBQOUm6n+RD5gWqzZBNKys7NRir5sPEQ==
X-Received: by 2002:a9d:6001:: with SMTP id h1mr317714otj.257.1639697493658;
        Thu, 16 Dec 2021 15:31:33 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n11sm1256646oor.9.2021.12.16.15.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:33 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 5/6] cacheinfo: Use cpu_affinity_map for populating shared_cpu_map
Date:   Thu, 16 Dec 2021 17:31:24 -0600
Message-Id: <20211216233125.1130793-6-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233125.1130793-1-robh@kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a full map of possible shared CPUs, we can iterate over
just the cache's cpu_affinity_map instead of all online CPUs to populate
the shared_cpu_map.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/cacheinfo.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index c9e5b48fac42..d7129b2fa9dc 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -32,12 +32,6 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 }
 
 #ifdef CONFIG_OF
-static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
-					   struct cacheinfo *sib_leaf)
-{
-	return sib_leaf->fw_token == this_leaf->fw_token;
-}
-
 /* OF properties to query for a given cache type */
 struct cache_type_info {
 	const char *size_prop;
@@ -228,16 +222,6 @@ static int cache_setup_of_node(unsigned int cpu)
 }
 #else
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
-static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
-					   struct cacheinfo *sib_leaf)
-{
-	/*
-	 * For non-DT/ACPI systems, assume unique level 1 caches, system-wide
-	 * shared caches for all other levels. This will be used only if
-	 * arch specific code has not populated shared_cpu_map
-	 */
-	return !(this_leaf->level == 1);
-}
 #endif
 
 int __weak cache_setup_acpi(unsigned int cpu)
@@ -274,16 +258,15 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 			continue;
 
 		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
-		for_each_online_cpu(i) {
+		for_each_cpu(i, &this_leaf->cpu_affinity_map) {
 			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
 
 			if (i == cpu || !sib_cpu_ci->info_list)
 				continue;/* skip if itself or no cacheinfo */
+
 			sib_leaf = sib_cpu_ci->info_list + index;
-			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
-				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
-				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
-			}
+			cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
+			cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
 		}
 		/* record the maximum cache line size */
 		if (this_leaf->coherency_line_size > coherency_max_size)
-- 
2.32.0

