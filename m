Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAA4E48FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiCVWRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiCVWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:07 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A8553B45
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c6-20020a621c06000000b004fa7307e2e0so7409636pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xr6XYf8jb8sbPWyL/uYgYyRzO0ukjO2H3fyJviEcQXg=;
        b=rGalqej0UnCyQ05se0hm7gNO6QXvs6QeB1cZfj7jAd+Jr+SwvJzUHYJ5roglDEbXCJ
         002Wlp1UQgVnPwhz/4tqCVbqBhi/f+Jgorx/odjWpzbabpQr6+eI6V1fBVgGyPfBdaMY
         TXYrKICh1pI9QUc0JfbvkaPsjwLjMYr7lTMg04UDiD9c/+AHkNorbxOPMrvHFdAulqjT
         Zvlzb57gEHzGDmMkX5xufPP9Cri6K3UeFUY0afY1IoJhOcPIF80HulEIs/s23NqrTBBv
         90p5Ew2EKPpqXBTKrDzn7AHanshLC0rLfLUYZmYkctrZh7iFuSn77yD1Mfduyt2Tsg2b
         jyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xr6XYf8jb8sbPWyL/uYgYyRzO0ukjO2H3fyJviEcQXg=;
        b=cdIwL4JyB/absE1uTFsFbZVChRMoARhdxnBKnzyBQqOcD2wjpagUGrDgB542jaHPcp
         j+3WLHZO8Vp6JkAWus6rC0PVNv7tVOROlD1cet8JFIleXcQiedDd8QnzfdIdbOu5nDw8
         aYeA6FoKVL57509/W5cOuvW74B2jOF8d/NKSa0DKsVT/eqb5f17akF0RC/HNBrMjoqgs
         EpPwoYtMCUBB9bfVlilN+UfDilh8qvdX3ghBYlszb8g28ehSuriQNj4bG9WEsbvb66Yf
         t8Q5UGid8cZPifFMxVdvuOPuUGuAkI1kOE/ULK93hmWDyybLE+Bm4pEFRqXp4NEGN/Sa
         x1Gg==
X-Gm-Message-State: AOAM531SyCWdo++uufuEEVoOI4Vs3BdeCPmvefEO+5GPWpHiBoT2vHxK
        MCdbLpdk/Yp4d6XJIA54bIiw/i5F87sOdYvBn04GkMJD1kXk3TdtPa9pbfD0XqxWONZE7s23+e4
        kH1kEsdNGXasIzMGs0axItjNwM7notwoCyTfSwVa82wexLhtkujMBzaYnFtlkuvUXoC5gABdW
X-Google-Smtp-Source: ABdhPJwd9yM6lWfV46wsN89JqFFozvJBmep7JOnBfXXRCzFhjivuXQ9HOcb5Onpis8jt46RzPzdAXqbCwLqG
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:aa7:943a:0:b0:4f6:adc9:d741 with SMTP id
 y26-20020aa7943a000000b004f6adc9d741mr30858044pfo.30.1647987337937; Tue, 22
 Mar 2022 15:15:37 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:09 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-6-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 05/13] perf/x86/amd: enable branch sampling priv level filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
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

The AMD Branch Sampling features does not provide hardware filtering by
privilege level. The associated PMU counter does but not the branch sampling
by itself. Given how BRS operates there is a possibility that BRS captures
kernel level branches even though the event is programmed to count only at
the user level.

Implement a workaround in software by removing the branches which belong to
the wrong privilege level. The privilege level is evaluated on the target of
the branch and not the source so as to be compatible with other architectures.
As a consequence of this patch, the number of entries in the
PERF_RECORD_BRANCH_STACK buffer may be less than the maximum (16).  It could
even be zero. Another consequence is that consecutive entries in the branch
stack may not reflect actual code path and may have discontinuities, in case
kernel branches were suppressed. But this is no different than what happens
on other architectures.

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
2.35.1.894.gb6a874cedc-goog

