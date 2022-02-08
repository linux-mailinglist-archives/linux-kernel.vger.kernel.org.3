Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231FC4AE4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389257AbiBHWd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386847AbiBHVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207B8C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b187-20020a251bc4000000b0061e15c5024fso190758ybb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IkSsAEe4tLZ7sPXk1cQDbdyI/ymKu70QdfkWphwdEME=;
        b=b79Z7mrt1T2rqjlQtvxG17JrcAsR5iLV5BcMxiBFygqW3qVgCsA77QfwZtD2vuQU7J
         cfEe2GM7sD1ayD+2/wyB3JjaXRE357xbtHNQozxQOmj5kA08Q2eBZFr8f9eWB00WxvdE
         udxuQSNKJXvYjAudABDXGuC60jf3ZP8UEmtoqgfLstZdnVHRo9AnvDrKwu631Kx1Ojgl
         s0uBonnRONcL6fZ3DMCpxqDiNnVw++0Z6Ps+n3yCQuis5Jj620sfzQVc8+yk1UH1OeIH
         fgYU0b9rkBxh4jfG1TjuBFZq17+JRhxD1O+H/GD7jyesjOw7sUJZOxbl0djhjp4T8fRn
         BQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IkSsAEe4tLZ7sPXk1cQDbdyI/ymKu70QdfkWphwdEME=;
        b=Ca6jWelzds8UEnn7aljyAvB6z+whHVovwsJE5i8uL5Iu3+xGpdX/5sowxVB6o93inl
         v++/ont6AeKQ+B+z8dDM65kNvltulh1D58HOqeWNFsXFcuh3IxyuVBgI5jtPpmdnp3ve
         mrI6ycW7WPnuIrU7HVCpNsyS0N+e4G9Z/qtJuFbZCcq7t//Gf90sEme8YfR7Q5UEshO9
         1mKuxekkmIps+tJGqXWz22Mhm5B6ULizax5Rp2m5zsLDc7LQyjdltbRPlhjIWQR1a/6R
         bnN0Z3t4+xiZLrrMXTcU9TeIyR2F3aHbyS62N2c6Emoibhbc0wgrK3xbfy1+T/ms4mYP
         8feg==
X-Gm-Message-State: AOAM533fqBvWz3Y3ZykSDTnuE+cMdt31Rd7kWcCoq7gd/31QSeJKzDUU
        jPkhPOzxNlJBLjKrwMDLZfVAgVeip2KmKDAV3SH1I/gEKjrdL8BlWrAnf2Aq2dKLFzDkzKtR1GG
        HdLj8MR/6LdWVKnFMdlDw68BcKJiDjhqM2uO7K6fw6HqS8WoYH0ZNaHQhSjqxU/IjiwOxLaNG
X-Google-Smtp-Source: ABdhPJxTVkfw8EifXuKk44o0hXOLcZKl9tvUeVIC23vGxANJlD9t8VEaIHcuXL1EJCskdf6PGZH7c2cLpSSQ
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a25:4d5:: with SMTP id 204mr6406319ybe.485.1644355024283;
 Tue, 08 Feb 2022 13:17:04 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:30 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-6-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 05/12] perf/x86/amd: enable branch sampling priv level filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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
2.35.0.263.gb82422642f-goog

