Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873A4A88DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352347AbiBCQoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352354AbiBCQoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:44:01 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22D3C061401
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:44:01 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id u25so2081398vkk.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dL7Kyw5R5uEJ5iFptCvOaKv8TqVxuhvnFOanF/ug8Oo=;
        b=MR8jXVkyACJhcck+4dcIScEcJjdlILboYDi4bqSv/6PZ8vBTWUY9vgbyWmkv4L/15Q
         FtimY0idlQDbZUTEV6rjD0xK50eicfInFXj/KAqbBZx+/tiI/11qsBWxJWE2MiAFXpOA
         /FNHgzWKuvmXWqOkq1muNBj+A2wx5HLtsHpFIY2ndlCa9hIDZgbgMK5TczXwoGmETExB
         FrOt7tpZowyB0etKJbSK6ojlEgVQ07mYW3A4TZTCmejaIh/8yLC+kSwulqt0/pn+MeM2
         ciAwu3tFxEG46MI470mmhgPU7yW2gNwBIIAq3litWGQK53yT6iAypK5CNOL+cpubsYQr
         5lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dL7Kyw5R5uEJ5iFptCvOaKv8TqVxuhvnFOanF/ug8Oo=;
        b=QFgRTNawdPW2Z0ZPj6emKdppLXwvLYgHCjzPmbxew+et0CGhznAW7JbEp7SmiKEZvU
         1jOGwWBGOpise8chz9IjDxMh54oXo4dkbcXsfk7WdBZotQGGsStJaRUEEJgp5wixOTGB
         FyxzzbR/FxlCCK1KLlHHyMMoIV6v3VI6X28/9FnCUlntDjnmvkV6bpNrnHCODdatsqU6
         AmG9Nenh92/XBd+qaz0A5LrnbJ8AyvAgmY4xYewt405GVone8+jcT1q0gHil52qwmQSm
         2c2ZhneaEi3INXe/FKH70zGWoUWTzIeeJiYlsyrRKw5s2rx2YNkCO1yhaQ8+smVtiGBc
         zYtA==
X-Gm-Message-State: AOAM532D2Ez/yh1Yt1eBNEY3Upen9H5qFs9naX3xA8psmdpBkeF2iR1T
        O4lRgQP3GwU8W8c2DJ2USeoACNAGee8HD9dOJZ5WW4aAkEtcjm5jkwMMfpwYM0jQ35XaKwgfvJg
        7obz94JaKrF1vIDmEmdJd4eOLiunSn2BF4VZM4urzMEJh2KirsU35Q/ELQHEsxOR1IiJn9iaHSn
        kxt4ACLxPzgjlh6qI9
X-Google-Smtp-Source: ABdhPJxUoacAYoBRc2lU1MnrO2thZNWlOT7k9ldUA5Uo6JdpNTbP0+ss+QIEqv7t+aG2BNl+L+GRew==
X-Received: by 2002:a1f:2d10:: with SMTP id t16mr15067999vkt.36.1643906640835;
        Thu, 03 Feb 2022 08:44:00 -0800 (PST)
Received: from localhost (host8.190-224-49.telecom.net.ar. [190.224.49.8])
        by smtp.gmail.com with ESMTPSA id k203sm6696515vka.56.2022.02.03.08.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:44:00 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v6 2/6] mm/mmzone: Tag pg_data_t with crypto capabilities
Date:   Thu,  3 Feb 2022 13:43:24 -0300
Message-Id: <20220203164328.203629-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new member in the pg_data_t struct tell whether the node
corresponding to that pg_data_t is able to do hardware memory encryption.

This will be read from sysfs.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/mmzone.h | 3 +++
 mm/page_alloc.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 936dc0b6c226..cec51e7a01d9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -871,6 +871,9 @@ typedef struct pglist_data {
 	struct task_struct *kcompactd;
 	bool proactive_compact_trigger;
 #endif
+
+	bool crypto_capable;
+
 	/*
 	 * This is a per-node reserve of pages that are not available
 	 * to userspace allocations.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..8bcbd6fa0089 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7592,6 +7592,7 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
+	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
 
 	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
 		(u64)start_pfn << PAGE_SHIFT,
-- 
2.30.2

