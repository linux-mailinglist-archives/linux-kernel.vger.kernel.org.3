Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EDC49D635
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiAZXfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiAZXfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE6C061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o131-20020a25d789000000b00614957c60dfso2409221ybg.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQ6TQFr4gRTQ/swcC+xKkGLDRXJXkBH2aopbD7J0zxg=;
        b=Pr7U0hRPExaZ9E+ynBOo965LQe1h01cgDN+CxtcAFUYTSLjAxl+OLWJBk1LVQ/J1yi
         fLRlyZ7av1/60b20IyH9nqcPf2YjVmQXbDieFeAKIjtXx408l6k60Br8y5eHsAyUMMjV
         jWoJ6FDL+o91GKzZC+8PIIRHfqX/D6SzCEWSLDbXqUbdYVqBc3l5zYXaguPHD5EiRb/m
         i19z24BAI2SMUwAT9goNJoOvjSY6FJHqxP/GeXDDbYb4z0kDK7/jDjIfAgfWBTFps6Pe
         Xg55DAUCISBxc09a5+ueJxmFo4V3KJ2SkrX7EMIy5jAa9pZROUd5on9oVc/WH+oITCcm
         cY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQ6TQFr4gRTQ/swcC+xKkGLDRXJXkBH2aopbD7J0zxg=;
        b=N+KuVuQhhdV1UUXiigRPas8+88MYbD55tZuGxtUnpwcMJ2rNPbcZNhgBjU7PuefT7i
         sModDNjThiQG6IovQWF3Hwl1vk5woQfXzHKgzmYpBmcYTD1C7q1lsRN8kb6jTZr98DaN
         ZWTviTHuk6Kl9zewCzGCtPpeCZQtX6SrUqRZJkriQnMhXHeRoV6lfgtRRjKQTbSaeset
         G6fRcTwXlWlN/m/XH8wYU9KvxUk6TK5urcDMBDSxL7F08Pxoq78IlxnUeEYj6F7FoJ/0
         ZLXeufxQcdPxuO5cFZ6iG58L1yZe6gb+yHx2TZk2sWkJejb9KTlwzMduX26rizlUZhBZ
         Kn/w==
X-Gm-Message-State: AOAM531Cl8CUVlM4FU3EeZt5sGxPaIQCRcskbBFgTDb4G+37AdxlXzQL
        8bfINX0GHXCy1KW6OoH9iZLvmtqVJLYFQvhPnHN0+kiVodajYAc90VogeVrzjyHWIP1CnB5qzt5
        s/ant8pe+nxb5D4VDhnMHBAFaMLcLbfR3xYPq+uLXvEBMVge9d1Nb2D2+koSgUAjGkB8w0jPs
X-Google-Smtp-Source: ABdhPJwPMK+zTZAwg7RhJoq5d38w//j01hjS0JDhy9D770OqdiD6H4hJ7KVdM5ckkTbIiTl3S97npMQFBK8V
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a05:6902:1145:: with SMTP id
 p5mr1805667ybu.315.1643240125953; Wed, 26 Jan 2022 15:35:25 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:46 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-6-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 05/13] perf/x86/amd: enable branch sampling priv level filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Branch Sampling features does not provide hardware filtering by
privilege level. The associated PMU counter does but not the branch sampling
by itself. Given how BRS operates there is a possibility that BRS captures
kernel level branches even though the event is programmed to count only at
the user level. This patch implements a workaround in software by removing
the branches which belong to the wrong privilege level. The privilege level
is evaluated on the target of the branch and not the source so as to be
compatible with other architectures. As a consequence of this patch, the
number of entries in the PERF_RECORD_BRANCH_STACK buffer may be less than
the maximum (16).  It could even be zero. Another consequence is that
consecutive entries in the branch stack may not reflect actual code path and
may have discontinuities, in case kernel branches were suppressed. But this
is no different than what happens on other architectures.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 3c13c484c637..40461c3ce714 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -92,10 +92,6 @@ int amd_brs_setup_filter(struct perf_event *event)
 	if ((type & ~PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_ANY)
 		return -EINVAL;
 
-	/* can only capture at all priv levels due to the way BRS works */
-	if ((type & PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_PLM_ALL)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -195,6 +191,21 @@ void amd_brs_disable_all(void)
 		amd_brs_disable();
 }
 
+static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+{
+	int type = event->attr.branch_sample_type;
+	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
+	int plm_u = PERF_SAMPLE_BRANCH_USER;
+
+	if (!(type & plm_k) && kernel_ip(to))
+		return 0;
+
+	if (!(type & plm_u) && !kernel_ip(to))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Caller must ensure amd_brs_inuse() is true before calling
  * return:
@@ -252,8 +263,6 @@ void amd_brs_drain(void)
 		if (to == BRS_POISON)
 			break;
 
-		rdmsrl(brs_from(brs_idx), from);
-
 		/*
 		 * Sign-extend SAMP_BR_TO to 64 bits, bits 61-63 are reserved.
 		 * Necessary to generate proper virtual addresses suitable for
@@ -261,6 +270,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
+		if (!amd_brs_match_plm(event, to))
+			continue;
+
+		rdmsrl(brs_from(brs_idx), from);
+
 		perf_clear_branch_entry_bitfields(br+nr);
 
 		br[nr].from = from;
-- 
2.35.0.rc0.227.g00780c9af4-goog

