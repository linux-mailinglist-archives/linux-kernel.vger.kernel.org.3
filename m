Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B64AE49C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387520AbiBHWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386846AbiBHVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C8C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a12-20020a056902056c00b0061dc0f2a94aso387895ybt.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hpYRwQLRBekfx+PCqt9/1HSAYQriRfUkssje8sUgZSw=;
        b=sOK4RMt818cUZPOEOHeyV19TBhn5uBFBKquSjktW5SYy6qRp9nBkRB82fA/OVrQjbT
         zau9QpGFLq0wy5gqkLyktdJ/aVwh/ojsgDGOtbvxJZf1hkv5G/7vXYBwFrpS1Uq3HNEI
         ue/kBM5PmsKiJMkyb6+pSVEC8gVxrSvyPnpj1zhvFbVmCaT4SVVJ1VUniIDOkdaBGCZi
         RhIurQT6LcLl3Db57CNeL4P9lc7NX4fzwSg5TwmKlwme9XdHYekJeq5d55zAR6qnAf84
         nkcHMYvnUwAWz1l4fHySz7vdZYVT+Vh4z/3jNBoPfLTrPKiZeUlfQT4zZ9AE9hlG2A++
         ftCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hpYRwQLRBekfx+PCqt9/1HSAYQriRfUkssje8sUgZSw=;
        b=hGti+he40Usil3qtJAxTfBSNRVnKBk3Kc+TiGa8agcqc7HYWqfeXslM+nm2PK3X94L
         v5zLsONo9PnK74Dbi60CsLCBRndO20sWP/V9wLaTKPsytDkaCPTsrB0zbhORjh13pVtN
         SP+1EGlt7fu5yX242mSzgfD0t++7XRhYoYoI9ziAS+nq4cxi4Ny3sZbHVnrtVmvVw6bB
         xZ3/YxjgM52uzej41gaoGAgP9BZGzzJaXBtRyiO9mkdQDxhK2Y5WE0LbiI3+HNqki8IG
         Tc6dLhs3ph6T74HhBBTa3XJN8aHCXrptJo+RSDtoekf+xTCH4Caa6ABIrnVNBJm1GSR/
         wNIA==
X-Gm-Message-State: AOAM5308KorsR5YhbklsNIe+JUUGWymk6ZSpd7vAa/jX8jJ9S/2KH/Je
        Iq98h3PtLG/m11xmi8bnuZ/fPvYCD2CrIbGz3l7cCovQkPJAzfncKMHdCds0oHaXEWXq3HQQnZJ
        +H1m6lt6dl6LkgEsg4d2Uefnc0LmqMFGNjR0i9pSzlX8I4lGUjS/SNKZ1WXYjjGkWeWZ37XEl
X-Google-Smtp-Source: ABdhPJz4tSKHW4S5Dd8IpdL9PG0xNiIntmhIVsFrDAE+HRTSNUI+YCx8meMBdWzz6F4B/Kf9Z3Kclf0o1xzY
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a25:e803:: with SMTP id
 k3mr6732621ybd.571.1644355021597; Tue, 08 Feb 2022 13:17:01 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:29 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-5-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 04/12] perf/x86/amd: add branch-brs helper event for Fam19h BRS
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

Add a pseudo event called branch-brs to help use the FAM Fam19h
Branch Sampling feature (BRS). BRS samples taken branches, so it is best used
when sampling on a retired taken branch event (0xc4) which is what BRS
captures.  Instead of trying to remember the event code or actual event name,
users can simply do:

$ perf record -b -e cpu/branch-brs/ -c 1000037 .....

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 44d8f618bb3e..597defee1e02 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1105,8 +1105,24 @@ static struct attribute_group group_caps_amd_brs = {
 	.is_visible = amd_brs_is_visible,
 };
 
+#define AMD_FAM19H_BRS_EVENT 0xc4 /* Fam19h RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
+EVENT_ATTR_STR(branch-brs, amd_branch_brs,
+	       "event=" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
+
+static struct attribute *amd_brs_events_attrs[] = {
+	EVENT_PTR(amd_branch_brs),
+	NULL,
+};
+
+static struct attribute_group group_events_amd_brs = {
+	.name       = "events",
+	.attrs      = amd_brs_events_attrs,
+	.is_visible = amd_brs_is_visible,
+};
+
 static const struct attribute_group *amd_attr_update[] = {
 	&group_caps_amd_brs,
+	&group_events_amd_brs,
 	NULL,
 };
 
-- 
2.35.0.263.gb82422642f-goog

