Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3374C46445F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346015AbhLABGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbhLABFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:53 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E341C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:33 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r35-20020a635163000000b0032513121db6so8170610pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=syNDdMZBXOcj13QhT+Ox2xQqsfIBzH7x4swyDVQvpbc=;
        b=fWCb6Lv5vzO628o5+BHTK+SAk//ERpn3IBh/UNF12Bw/Lbo4jvza8xLchsR6uddxny
         8kH9ecJZcgewUpMCR9Th3VddSoCYz8Kt+56kg6zoI3WZB+tx1RtTN3glfwk7fqT21Lm9
         i6Lef0sSqqBA3/5oUXN7bidU4e0UGQbDHfk/8QHfI4tmgIVOCrwsjZR1lMyLYe/kRlQd
         T2aLNvmV5fDvlzQDWRdJxNhAdaziycyrMMpj8i4pWIQysvhmFOuGMcd5R9zYDeQN0W9c
         tbbq/ILlG+KDsxSPa58cDOAlw57+vSv7CVuHIPE/KlCt8+fZaJS++8Hfvwj6Weol1F4W
         ekKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=syNDdMZBXOcj13QhT+Ox2xQqsfIBzH7x4swyDVQvpbc=;
        b=MLY/L53A8G/J/lhNq2pTpSuVQeGOnJcB3RYwSszLA9UthPoOnqwNOHFDvc+ygh0qQE
         dXVRpA//g4tIAsQDzn8hhmh5IRYu4jvXxf3Z++LNfN9z7CXbxqKE+WC4rxapkN/7Y2Ec
         D1kRLOXySgJuLYyBWkSHGt1PThXr7ol+TMdRDQ5rSZxTK4HWOeVcH4O2ipYh319ymzwH
         uHJbo/NaW0GoeZdDStIsIr4Z8hQd69ydlSuuaQpsUKdRE7s8h8htrMuo4m9eebWCsLDB
         lT0gpsBmqyx/736cpMXEFMf6xCXRtU0HkaQAVmMuZfh0faiCF8lx9eQLsiWeeoM/WWf+
         yTrw==
X-Gm-Message-State: AOAM533Yb1xkyvv3L63l0+4b5wLZTdAgDKmREfnCYxdEq2abVQGD676u
        sq8muwl9UdIpRlnzhVhpsntcdhpi97BkgZwLAxH26YAVUJa6Z4G0XPxBGi5fHvlDQF5kSeGJEq3
        pdzkGsMBxx0Wm66F97pExY7iBH70mbzCn/3k7GIC9vibMLWAzwrX2IVaY+OGTuA7cLE1io4Rp
X-Google-Smtp-Source: ABdhPJzugcgya/PO0nIy0b6eTzgrsQ8pY34SrDFuYlS+99cnFG23q/Mv0IGp33XrLsMMckY6K76CHVw2XVL1
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a63:a556:: with SMTP id
 r22mr181986pgu.587.1638320552451; Tue, 30 Nov 2021 17:02:32 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:09 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-6-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 05/13] perf/x86/amd: enable branch sampling priv level filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
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
index 851b03bcbea2..1e5524494631 100644
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
2.34.0.rc2.393.gf8c9666880-goog

