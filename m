Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0207478091
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhLPXbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:33 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35398 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLPXba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:30 -0500
Received: by mail-oi1-f180.google.com with SMTP id m6so1171584oim.2;
        Thu, 16 Dec 2021 15:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJxuQtRLTVfIiHxosQQwj5MJ9jgW00UdvVH4T37a4e0=;
        b=XBuaIGSmeZnCZwdW/QkU7UDvP7DuL7eUGodLzs7bCXGQOUuHRTMsE/9o44IZ20G+Sw
         lNKu0KdKuuBCdGPrgT6dOQ3A0xyf4KsXNKScDfVrCaRtquNEmE8kn6w3blxbj00eF922
         d6syGkP8OgQqxS5QFw0lUswOyWWDNf37VUT0c4YUyr/swTKDVu50Q+HE1v962Z/EqBCw
         25GgI92WBOgKGocMUpc/FqZ7tEyi9EXBD7q5rpVaUPUUsPk+w9omSWEMEx1D9OWuAkM5
         /Mmx062hWGqLKbasCxuAUDDD/UOPKPtPAljOZLx8Ua+teKhp06ZImk5+IGbTwCaysaff
         EWgg==
X-Gm-Message-State: AOAM5318Rgkfayjgo1VrkRn73VB+PqAda10IP4daYGrleLXxkZ94bmkS
        w5guH6RASBDHi9MXjUMEb/LG5V9hzQ==
X-Google-Smtp-Source: ABdhPJy3osxEec/uFfDfvEc9vw+RCg25N1CQDsD8MFEWyLn67kai6YEnfUJhllbsJNoUI1R1/4kVtg==
X-Received: by 2002:a05:6808:4d2:: with SMTP id a18mr136647oie.99.1639697489825;
        Thu, 16 Dec 2021 15:31:29 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n11sm1256646oor.9.2021.12.16.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:29 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
Date:   Thu, 16 Dec 2021 17:31:21 -0600
Message-Id: <20211216233125.1130793-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233125.1130793-1-robh@kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the minimum CPU h/w id of the CPUs associated with the cache for the
cache 'id'. This will provide a stable id value for a given system. As
we need to check all possible CPUs, we can't use the shared_cpu_map
which is just online CPUs. There's not a cache to CPUs mapping in DT, so
we have to walk all CPU nodes and then walk cache levels.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Loop with for_each_possible_cpu instead of for_each_of_cpu_node as
   we will need the logical cpu numbers.
---
 drivers/base/cacheinfo.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 66d10bdb863b..21accddf8f5f 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -136,6 +136,36 @@ static bool cache_node_is_unified(struct cacheinfo *this_leaf,
 	return of_property_read_bool(np, "cache-unified");
 }
 
+static void cache_of_set_id(struct cacheinfo *this_leaf, struct device_node *np)
+{
+	int cpu;
+	unsigned long min_id = ~0UL;
+
+	for_each_possible_cpu(cpu) {
+		u64 id;
+		struct device_node *cache_node, *cpu_node;
+
+		cache_node = cpu_node = of_get_cpu_node(cpu, NULL);
+		id = of_get_cpu_hwid(cpu_node, 0);
+		while ((cache_node = of_find_next_cache_node(cache_node))) {
+			if (cache_node == np) {
+				if (id < min_id) {
+					min_id = id;
+					of_node_put(cache_node);
+					break;
+				}
+			}
+			of_node_put(cache_node);
+		}
+		of_node_put(cpu_node);
+	}
+
+	if (min_id != ~0UL) {
+		this_leaf->id = min_id;
+		this_leaf->attributes |= CACHE_ID;
+	}
+}
+
 static void cache_of_set_props(struct cacheinfo *this_leaf,
 			       struct device_node *np)
 {
@@ -151,6 +181,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 	cache_get_line_size(this_leaf, np);
 	cache_nr_sets(this_leaf, np);
 	cache_associativity(this_leaf);
+	cache_of_set_id(this_leaf, np);
 }
 
 static int cache_setup_of_node(unsigned int cpu)
-- 
2.32.0

