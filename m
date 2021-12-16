Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A547809A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhLPXbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:39 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34361 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhLPXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:31 -0500
Received: by mail-ot1-f43.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso810007otj.1;
        Thu, 16 Dec 2021 15:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4o9kmT6MVqI4c+B16gX5bvAJwnYM06bebAI8lgZufvw=;
        b=xsgwhi/9Zy2IB4a3hVrF1hCi90QfrqkyLiGx/7i/C/QMxAxyvJOT2iryoEIOgOA6qh
         BMjY4ONCCoc3mqalNSKylGY+Ewh8a8zUwrXQgive+aA/Ufi6rCK3J/EF1+C4eClslcLc
         7UpQglfybcoi8CDK76w22NM10e8oWTvwfQhT7zhPNCnYCRFkjT9AqTn2MXcch9aHZ73X
         mRRMF2rtulEMAkZJMG32u04JuHhuaY2KwphqHfMZmaTUuTag/4UIMoW0XGIGCuS4WrbS
         YutEAfZ33vG2tS6Cc7LPjq30iiYzGtLM0ZtpA+SqzemlSFu8CHXP25PRNlwrR1hfyD3W
         gzJg==
X-Gm-Message-State: AOAM531tS0QCLliXA/LJ9ICGRrUt9hlhT9xXS9Ep1qee6FiOPx7QhmUQ
        Wp4ujPq0+RSe8M1a/HjXMgJ4LmLhrw==
X-Google-Smtp-Source: ABdhPJwJPckhRY71EAGczW5EOQ0K0FofxnZ4dWNjrtnwwnajnzwS1hMcl3WucPCL0Utsr711wG02+g==
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr335246oto.312.1639697491144;
        Thu, 16 Dec 2021 15:31:31 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n11sm1256646oor.9.2021.12.16.15.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/6] cacheinfo: Add cpu_affinity_map to store affinity for all CPUs
Date:   Thu, 16 Dec 2021 17:31:22 -0600
Message-Id: <20211216233125.1130793-4-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233125.1130793-1-robh@kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, getting the cache CPU affinity for all possible CPUs requires
walking the DT or ACPI tables. As that is already done once (for each
CPU online event), let's save the affinity for possible CPUs so it can be
retrieved later.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/cacheinfo.c  | 1 +
 include/linux/cacheinfo.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 21accddf8f5f..c9e5b48fac42 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -149,6 +149,7 @@ static void cache_of_set_id(struct cacheinfo *this_leaf, struct device_node *np)
 		id = of_get_cpu_hwid(cpu_node, 0);
 		while ((cache_node = of_find_next_cache_node(cache_node))) {
 			if (cache_node == np) {
+				cpumask_set_cpu(cpu, &this_leaf->cpu_affinity_map);
 				if (id < min_id) {
 					min_id = id;
 					of_node_put(cache_node);
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index b2e7f3e40204..37652cfdd8dc 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -56,7 +56,8 @@ struct cacheinfo {
 	unsigned int ways_of_associativity;
 	unsigned int physical_line_partition;
 	unsigned int size;
-	cpumask_t shared_cpu_map;
+	cpumask_t cpu_affinity_map;	/* possible CPUs */
+	cpumask_t shared_cpu_map;	/* online CPUs */
 	unsigned int attributes;
 #define CACHE_WRITE_THROUGH	BIT(0)
 #define CACHE_WRITE_BACK	BIT(1)
-- 
2.32.0

