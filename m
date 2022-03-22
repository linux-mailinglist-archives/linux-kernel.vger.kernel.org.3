Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A474E4900
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiCVWR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiCVWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177EB5370C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h16-20020a056902009000b00628a70584b2so15494833ybs.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rjDM4PZxQVnGsW8D6ZRUNvFtAvJliadKtjfByZf01o0=;
        b=JkuuGgSvC6W5z4yYL1/b9HdlCLYiUXwRQRC5UyKU13aVKsMav/zd2hTZwzFQWxezAU
         vb1VUUPu0wjVanlY5/XuggY99TEpTxETb4C7qWfPFYilicVrRGUcn+VdP1m5JYDXN0jx
         qag8N+JDE1MqrY1aEDVRjfjjtk2mMZ7kOD/hr+y4oqrYhCFJg3XZ4H+YuQH2IgOBpZui
         WVh258SKoUbt/dYevxp92eb23Tvo4/2gC+uLrhzwkkoeyC2rEAGXTG6ESz5n+FhpPcwE
         Dz6lnPJn6FBw5zLuFIyn+KCIcj/hymZxm6C2dpYbyTnNL/cGx8/LbxCmcA4nkpn9bsxx
         rItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rjDM4PZxQVnGsW8D6ZRUNvFtAvJliadKtjfByZf01o0=;
        b=bOU7dvcYWP584svdr7qCtfLr3r7ezAJcBApTwdzCuewsudtu3pfOCpGt3T1NfouErQ
         Sglui3SmHggCE/XteX+sl/AFyZ9yUt/SuY2u71ujZPOixG0V/p0ZrzQ10iSyc9O5CPtq
         nxRDG4vdd+MwZryxOpwWHCFcHyGgLDBqb1yk7orJAhTAdQgmsf8aV6ExPe/ncVxkZWai
         nM93kYgy9qMK7oepAF8B65JqZknAZp131lN9sgRqJUAkME8QEzWpiVbUrmeWqLJkFsp+
         kP7pk+uybj02vN3gM2SCcakA3e5oi/EunKbrldGUo7E8lrN9WxTFyz6Bbh7gJje/6rco
         olmg==
X-Gm-Message-State: AOAM530sPJmeRQ5eEVRiwQdL/4lZ0ySFLgcN68uc7QhUrEYyKvRk20FX
        asKGK6U7ttI9EE6/pl4Tr9LKH+V6uC1PlL4i4juNB3x5L7+uDzxAdy//5b9/mqoVQ9oBzmHdA+v
        wNzF1umT2QwMbJVr8dYXrTaVof+o+nHgMly1Mapi4fV/gU2PhCwfWuhQCKrMzT51j+IS0Thiy
X-Google-Smtp-Source: ABdhPJy2169MxJ6wk/bRojYugdoldDuP5WWPT/h2dbIbJ2zV2sHAvMwofe9TGpX72Wqtl9w/BJ8w+KU496DH
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a0d:c6c4:0:b0:2d6:f343:fa99 with SMTP id
 i187-20020a0dc6c4000000b002d6f343fa99mr31888711ywd.142.1647987340238; Tue, 22
 Mar 2022 15:15:40 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:10 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-7-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 06/13] perf/x86/amd: add AMD branch sampling period adjustment
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

Add code to adjust the sampling event period when used with the Branch
Sampling feature (BRS). Given the depth of the BRS (16), the period is
reduced by that depth such that in the best case scenario, BRS saturates at
the desired sampling period. In practice, though, the processor may execute
more branches. Given a desired period P and a depth D, the kernel programs
the actual period at P - D. After P occurrences of the sampling event, the
counter overflows. It then may take X branches (skid) before the NMI is
caught and held by the hardware and BRS activates. Then, after D branches,
BRS saturates and the NMI is delivered.  With no skid, the effective period
would be (P - D) + D = P. In practice, however, it will likely be (P - D) +
X + D. There is no way to eliminate X or predict X.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/core.c       |  7 +++++++
 arch/x86/events/perf_event.h | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c2a890caeb0a..ed285f640efe 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1374,6 +1374,13 @@ int x86_perf_event_set_period(struct perf_event *event)
 	    x86_pmu.set_topdown_event_period)
 		return x86_pmu.set_topdown_event_period(event);
 
+	/*
+	 * decrease period by the depth of the BRS feature to get
+	 * the last N taken branches and approximate the desired period
+	 */
+	if (has_branch_stack(event))
+		period = amd_brs_adjust_period(period);
+
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3485a4cf0241..25b037b571e4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1263,6 +1263,14 @@ static inline bool amd_brs_active(void)
 	return cpuc->brs_active;
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	if (period > x86_pmu.lbr_nr)
+		return period - x86_pmu.lbr_nr;
+
+	return period;
+}
+
 #else /* CONFIG_CPU_SUP_AMD */
 
 static inline int amd_pmu_init(void)
@@ -1287,6 +1295,10 @@ static inline void amd_brs_disable_all(void)
 {
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	return period;
+}
 #endif /* CONFIG_CPU_SUP_AMD */
 
 static inline int is_pebs_pt(struct perf_event *event)
-- 
2.35.1.894.gb6a874cedc-goog

