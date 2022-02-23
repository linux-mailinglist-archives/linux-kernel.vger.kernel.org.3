Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FFA4C0BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiBWF0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbiBWFZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:25:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C456D863
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a25d387000000b006245d830ca6so12323810ybf.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wpN/U5eluX6Jnat+pEDX2C0UlbFhsXsgqK2IMjW00B0=;
        b=eO68TZsayJUnzF9ppfHaPSwA9f3cpJtiM/bQv1NjIx1viksnomhVCZg/OPfesExCQe
         GPBpKhmjuCayGTZhMCQafKSmuYZ+smeOmFtUbvbkWS5siPQw7nd2sd5jds4KSpKgIMG1
         5rAZMh+2rFOS1AHpWlupbprjH1FaaIPoFdMADMVIZrEncJu5IwxbAAD77jq17vk7nHI/
         pHx7Yx3y5+Ja+7mdhxYJ7U+IEaib+spU25N1cAyqYIyEgycYL490w9sjOc0zBhbj55fl
         oXav/h9TUMbHXVfYpZ1MYXyKyDqxgCsBYAWNUi6HD47X/71tlKLWuj7QNFucy0Ul1WpD
         v86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wpN/U5eluX6Jnat+pEDX2C0UlbFhsXsgqK2IMjW00B0=;
        b=k2kUzrY4SYQ1HwTRTHRX/y3uVPy+8UlCLEeL4nxFjlWas06/df1Fl83rU7Hv8gKpAx
         MOul15VkOZw9ffwRfTqz6Ak0DusQgIN4ACmO/bS16ch+Xtb2G/1kqXFu6Gw4fp6qMLpC
         B0pBVExtvGkEEuVuLALsSgLdBYyEZ1RTW8VhXrQwAJ6hrtVdBf0uZpp6dnu6cU1Q4zWo
         gKSx4GzVf4yawcjfcCuRqkHbd5InP97qxxfs+8ax0B4Jw0pCfx9T7/GvkYQIHw/fl5MS
         SFUGyU4FCGVVTYTdRfadPbeh9nWmRy6yavrWpTQQ1d45GjF/3Brv3Ax6NNhQIFzUe0d7
         sTBQ==
X-Gm-Message-State: AOAM530cHnGssKhipa0WA2hrdzG1BTcJexjPlrLe7+dkaeMTyXbRo3AL
        0G4uTJHSr14jGeVZEUHMlhs++AnCANEKWaBq8KNzbz2P+G40+ZBu0HtX8l6yR74azszgzNnFpl1
        JdA3ImlrWGbTJUFPF9d3DhyC//20tj9U08kjgZkcNkrIojCvYxf6jOb8baEVUjlXwPdrE6x4B
X-Google-Smtp-Source: ABdhPJy8YBcGGLS1CDa1jQAvWHy6IX+C9Fx9N9t0vFRpgYOq3ptmbXD9mdu9QbdYBQ3ESjXtAc+9DWkF+HCP
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a81:7141:0:b0:2d3:d549:23f8 with SMTP id
 m62-20020a817141000000b002d3d54923f8mr27573261ywc.87.1645593872454; Tue, 22
 Feb 2022 21:24:32 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:21:57 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-22-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 21/47] mm: asi: Add support for locally non-sensitive
 VM_USERMAP pages
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, jmattson@google.com,
        pjt@google.com, oweisse@google.com, alexandre.chartre@oracle.com,
        rppt@linux.ibm.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_USERMAP pages can be mapped into userspace, which would overwrite
the asi_mm field, so we restore that field when freeing these pages.

Signed-off-by: Junaid Shahid <junaids@google.com>


---
 mm/vmalloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ea94d8a1e2e9..a89866a926f6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2424,6 +2424,14 @@ static void asi_unmap_vm_area(struct vm_struct *area)
 	 */
 	if (area->flags & (VM_GLOBAL_NONSENSITIVE | VM_LOCAL_NONSENSITIVE))
 		asi_unmap(area->asi, area->addr, get_vm_area_size(area), true);
+
+	if (area->flags & VM_USERMAP) {
+		uint i;
+
+		for (i = 0; i < area->nr_pages; i++)
+			if (PageLocalNonSensitive(area->pages[i]))
+				area->pages[i]->asi_mm = area->asi->mm;
+	}
 }
 
 #else
-- 
2.35.1.473.g83b2b277ed-goog

