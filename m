Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148C746B2FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhLGGkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhLGGkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:40:14 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20EC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 22:36:45 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id p19so13318788qtw.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 22:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1alM6+AhJgDYrpwHehRie8355PfIbOCgstqykLiCQqs=;
        b=YpmaD+mNT6M8DTCGsxnNUoPkAcw0RUoyy/gG3VfhdaGarFz2blKer6btNc5brw0MCj
         mrFv9NF9agHjoOPUCGT8ykaAcWUlViSp8p45IlKZ8mx46TcZtHg7t+3+aQuLeaQrJdzQ
         RJ/g1MeehSCr7ozKBj4nvvSgEHzbAPQ8YxXJclQAd1H/O+TiFUDZTxRQcDjW5oO984lu
         956aX9NrtE4sBi+ZnUbcf+cEc+2/96HqesLPvpBzNMh6Ko3z4j4CUbzUL6ZOpvEiR6B0
         71JV5lnKvqTCAyWt7BRBk5mJeHTN8wEQ1UKMmlFSwmCRIHaUe1+1tkXD1BKUuUrZJr7G
         gGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1alM6+AhJgDYrpwHehRie8355PfIbOCgstqykLiCQqs=;
        b=dazI9HZlKaueviBoM1b2g2TmtAG5AveHlx45yzzH7hpkcjKI+xQZvq5ZWn3jl1ICC7
         fs7FIBoXssELuRDyJfruxukyyu44IWc0Jg9JnrZDiRZhSw4hGQUtXoYQrmXjK9589m3j
         rXM+8oLsIrO/audCGy7apDdhMGXFl5AirIRuIB46fpb7Q5dOPJ8AErUL7Nr8jiRz6xB8
         rFIgpXWUZiZIMWL98tbOgEmE6V8d+f7ROg5MMBP1YlQGYfXjsO+S1rCC/Y41tIyHizMa
         G7Z6HX9ZCwFCdmMDEs7LH6hOkb7bX3zZA/XWF7rs2H5QvQXFEepzvMBy7TZSweFOZK6n
         BSqQ==
X-Gm-Message-State: AOAM532l5bZVyim9eVIBiDOa6MSSJ2uJzEwVQ/TAQzEjynU0iWZQeR1e
        tBbf6qCXf1vFdBc26T1Gitk=
X-Google-Smtp-Source: ABdhPJyLFtkeYCzsdOO/qlhIHmssT7sa4UcpZFhKfhTG5zc4yrJe3pn1YWiFMx943h1dOzBygKO1Mw==
X-Received: by 2002:ac8:5a84:: with SMTP id c4mr45073384qtc.565.1638859004383;
        Mon, 06 Dec 2021 22:36:44 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:6fa5])
        by smtp.gmail.com with ESMTPSA id w19sm7319304qkw.49.2021.12.06.22.36.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 22:36:43 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     ying.huang@intel.com
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        feng.tang@intel.com, hasanalmaruf@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mgorman@techsingularity.net, mhocko@suse.com, osalvador@suse.de,
        peterz@infradead.org, riel@surriel.com, shakeelb@google.com,
        shy828301@gmail.com, weixugc@google.com, ziy@nvidia.com
Subject: Re: [PATCH -V10 RESEND 2/6] NUMA balancing: optimize page placement for memory tiering system
Date:   Tue,  7 Dec 2021 01:36:39 -0500
Message-Id: <20211207063639.83762-1-hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207022757.2523359-3-ying.huang@intel.com>
References: <20211207022757.2523359-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

>+void set_numabalancing_state(bool enabled)
>+{
>+	if (enabled)
>+		sysctl_numa_balancing_mode = NUMA_BALANCING_NORMAL;
>+	else
>+		sysctl_numa_balancing_mode = NUMA_BALANCING_DISABLED;
>+	__set_numabalancing_state(enabled);
>+}
>+

One of the properties of optimized NUMA Balancing for tiered memory is we
are not going to scan top-tier nodes as promotion doesn't make sense there
(implemented in the next patch [3/6]). However, if a system has only
single memory node with CPU, does it make sense to run
`NUMA_BALANCING_NORMAL` mode there? What do you think about downgrading to
`NUMA_BALANCING_MEMORY_TIERING` mode if a user setup NUMA Balancing on
the default mode of `NUMA_BALANCING_NORMAL` on a single toptier memory
node?

>diff --git a/mm/vmscan.c b/mm/vmscan.c
>index c266e64d2f7e..5edb5dfa8900 100644
>--- a/mm/vmscan.c
>+++ b/mm/vmscan.c
>@@ -56,6 +56,7 @@
>
> #include <linux/swapops.h>
> #include <linux/balloon_compaction.h>
>+#include <linux/sched/sysctl.h>
>
> #include "internal.h"
>
>@@ -3919,6 +3920,12 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
> 	return false;
> }
>
>+/*
>+ * Keep the free pages on fast memory node a little more than the high
>+ * watermark to accommodate the promoted pages.
>+ */
>+#define NUMA_BALANCING_PROMOTE_WATERMARK	(10UL * 1024 * 1024 >> PAGE_SHIFT)
>+
> /*
>  * Returns true if there is an eligible zone balanced for the request order
>  * and highest_zoneidx
>@@ -3940,6 +3947,15 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
> 			continue;
>
> 		mark = high_wmark_pages(zone);
>+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
>+		    numa_demotion_enabled &&
>+		    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE) {
>+			unsigned long promote_mark;
>+
>+			promote_mark = min(NUMA_BALANCING_PROMOTE_WATERMARK,
>+					   pgdat->node_present_pages >> 6);
>+			mark += promote_mark;
>+		}
> 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
> 			return true;
> 	}

This can be moved to a different patch. I think, this patch [2/6] can be
splitted into two basic patches -- 1. NUMA Balancing interface for tiered
memory and 2. maintaining a headroom for promotion.

Instead of having a static value for `NUMA_BALANCING_PROMOTE_WATERMARK`
what about decoupling the allocation and reclamation and add a user-space
interface for controling them?

Do you think patch [2/5] and [3/5] of this series can be merged to your
current patchset?

https://lore.kernel.org/all/cover.1637778851.git.hasanalmaruf@fb.com/

Best,
Hasan
