Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8786B478096
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhLPXbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:37 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46835 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhLPXbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:33 -0500
Received: by mail-oi1-f179.google.com with SMTP id s139so1086937oie.13;
        Thu, 16 Dec 2021 15:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fStO5BsDAphXFibF4lRjLZT7FGTV609d5dBo3Se1e80=;
        b=DH3e2j+RjRxqEdP9cMpZ6tr1ScZdqaRUfZt5RC+mrgInMDf5QTkW5tKkl6/pQSMnSQ
         b7ParZHLLrMKoL8GMVCbm0IPXXVJp53aCSU1FvCyvpP/RawcoSB8Q9RoHtWIKvnDvifk
         KWbfti1VP00YEfJYHYvGeXyRatrS+FKE3T6dmQ/E47rOsKLfYxVkPX1C/xX/Zg07b9/W
         qxFXvEuc2EXTy6Qy1n+TmG0X9hRi0+S/RLmyrU1vORkIPvGS17VzWFb//vAJrGu00cN4
         n1SJuFr5geXp6sN6wiMuJGwCtctI6llmr8pTeWXm+ZioF2S6tGA/4c7Wu0hVl6nci4kw
         y65g==
X-Gm-Message-State: AOAM533qJqbiCLNwqhfy7PM5G84abAbL1UQsTHPBcOsUHrWpc4K/Zk5s
        So6Cu7kIgiK/zKyRJwzmcg==
X-Google-Smtp-Source: ABdhPJx/pvFlJR8Gy0p3sOQ+0qXrZMYTlyfTf5U3XrIIVBVC1Am5JLBvV/CdZf5UED59JsXXYVeuaw==
X-Received: by 2002:aca:120f:: with SMTP id 15mr154257ois.132.1639697492411;
        Thu, 16 Dec 2021 15:31:32 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n11sm1256646oor.9.2021.12.16.15.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:31 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 4/6] ACPI / PPTT: Populate the cacheinfo.cpu_affinity_map
Date:   Thu, 16 Dec 2021 17:31:23 -0600
Message-Id: <20211216233125.1130793-5-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233125.1130793-1-robh@kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cacheinfo.cpu_affinity_map was added to list the possible CPUs a
cache is associated with. Populate the cpu_affinity_map when parsing the
ACPI PPTT for cacheinfo. With this, the cache CPU affinities are
represented in the same way for DT and ACPI.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/acpi/pptt.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 701f61c01359..686018f4e7ed 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -418,6 +418,30 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 	}
 }
 
+static void acpi_set_cache_cpumask(struct acpi_table_header *table,
+				   struct cacheinfo *this_leaf,
+				   struct acpi_pptt_processor *match_cpu_node)
+{
+	int cpu;
+
+	/*
+	 * If we found the cache first, we'd still need to walk from each cpu.
+	 */
+	for_each_possible_cpu(cpu) {
+		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		struct acpi_pptt_processor *cpu_node;
+		struct acpi_pptt_cache *cache;
+
+		cache = acpi_find_cache_node(table, acpi_cpu_id,
+					     this_leaf->type,
+					     this_leaf->level, &cpu_node);
+		if (!cache || cpu_node != match_cpu_node)
+			continue;
+
+		cpumask_set_cpu(cpu, &this_leaf->cpu_affinity_map);
+	}
+}
+
 static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 				 unsigned int cpu)
 {
@@ -435,10 +459,11 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 						   this_leaf->level,
 						   &cpu_node);
 		pr_debug("found = %p %p\n", found_cache, cpu_node);
-		if (found_cache)
+		if (found_cache) {
 			update_cache_properties(this_leaf, found_cache,
 			                        cpu_node, table->revision);
-
+			acpi_set_cache_cpumask(table, this_leaf, cpu_node);
+		}
 		index++;
 	}
 }
-- 
2.32.0

