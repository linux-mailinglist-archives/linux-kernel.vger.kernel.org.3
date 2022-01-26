Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95A49D038
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiAZRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiAZRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:00:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BEC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:00:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i65so249240pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Onl1JpmjZEa6zJu2g35kLpJMmMBIoxN/vI9o07uZnSE=;
        b=vG81hp3GKcDmDaHOEl5NZqjWXqgKUrX8vpZ4U+RfzlWC0F5JUgHlxzbXhrzgfjS//A
         HUeiYP+XaNjRlzyClU0pNEVdAgc/UC/0hICDjqLbIw8LfYGJ4jUW+PffSJFnRHLctw6A
         0V627+CXnH7SJVSr2BOcS8aAGbFY3INNRdSF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Onl1JpmjZEa6zJu2g35kLpJMmMBIoxN/vI9o07uZnSE=;
        b=uP8lSuLxA6xc/hS0YdkZLij23x9wzWNkw1YBoOI8QksTLMS9yHiE5BrQxH8iZ0S6lL
         T+Nfrtab5D8A9wIjhw4enYdE19RaVs/uhAodiuu4ht7FX/MYiFI0E21Rvg0aHPrrAeVf
         wwvW+4ueRod0+Q/XF1p16Yos57nCPxhXKEO72EQCyf6ceVhMMNdIvCSlFtAEkLOimLKU
         IdloQ9JacrNgg6wlE6dvd2I1P73d5Un2vCpW4x+MZV83ZGdnWNLbuvKFG1ZzVVfUjBAi
         GOP3xWiq6lw1WGlMpzTqpOiBu5MytRvt+rg7YnXLo3rnc2n2Jpl8OYAMGIWy2UnnS5YP
         Ubag==
X-Gm-Message-State: AOAM533WZrSTgEtY6zkmKcgQSj5jWc7PZKxzAuugC+sHj95CdQEUuGJK
        upMfLjur461yYj6wom+MuhTasA==
X-Google-Smtp-Source: ABdhPJzhTWxkvUgBtwM91u+cYKbIdx3dFiNFTCB+D62IGdpTAENUFNPgH4+d0xS7tt+MSUEXK5AAeQ==
X-Received: by 2002:aa7:9009:0:b0:4c6:fe2f:6a94 with SMTP id m9-20020aa79009000000b004c6fe2f6a94mr11307661pfo.25.1643216441424;
        Wed, 26 Jan 2022 09:00:41 -0800 (PST)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id q6sm17540644pgb.85.2022.01.26.09.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:00:41 -0800 (PST)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        akpm@linux-foundation.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [PATCH 2/2] dax/kmem: Update spanned page stat of origin device node
Date:   Thu, 27 Jan 2022 02:00:02 +0900
Message-Id: <20220126170002.19754-2-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126170002.19754-1-tome01@ajou.ac.kr>
References: <20220126170002.19754-1-tome01@ajou.ac.kr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device memory adds to the online NUMA node, the number of spanned
pages of the original device NUMA node should be updated.

By this patch, we can monitor the current spanned pages of each node
more accurately.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 drivers/dax/kmem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..f63a739ac790 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/memory_hotplug.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -48,6 +49,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	struct dax_kmem_data *data;
 	int i, rc, mapped = 0;
 	int numa_node;
+	int dev_node;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -147,6 +149,18 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 
 	dev_set_drvdata(dev, data);
 
+	/* Update spanned_pages of the device numa node */
+	dev_node = dev_to_node(dev);
+	if (dev_node != numa_node && dev_node < numa_node) {
+		struct pglist_data *pgdat = NODE_DATA(dev_node);
+		struct zone *zone = &pgdat->node_zones[ZONE_DEVICE];
+		unsigned long start_pfn = zone->zone_start_pfn;
+		unsigned long nr_pages = NODE_DATA(numa_node)->node_spanned_pages;
+
+		shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
+		update_pgdat_span(pgdat);
+	}
+
 	return 0;
 
 err_request_mem:
-- 
2.17.1

