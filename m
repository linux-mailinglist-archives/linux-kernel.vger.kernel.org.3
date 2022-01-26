Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B6B49D633
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiAZXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiAZXfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B06EC061749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso2514003ybb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/x8UT6OHwNZk2oDIrUxyBKL03hhewb0+Y3ttSVyTmgQ=;
        b=A6bLsYgG1zkWkfe4m2XZTOjuirX/KBhuA46s7HjnKWxCeVNOEjeL+1dY2nWSl4vfcm
         FFuu8DVEb7ExOMLs2VlAOsXncYDF+IYO38uA8wsysJUh518AswCOClh9WIAC02hdTge1
         fP9mKIyfCWLH193ZlmRPe/fbtvxxU7pUCMUY9oVmh58NelKbKM4DS9ErFviJ1xg5AS3+
         RoGKe2o8523jCVa+jBZEjpN3Uh2/3Zy5DJsnf1XtMOVM8WMyb5R/kTbh7/tnUGhRsiAa
         tNDO31w8GmZoz8h9TZxD1y/rq9VhQ82f6C4Stj8yxMmvJmpMWXMTXdgrZvLAio+YFGVr
         GRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/x8UT6OHwNZk2oDIrUxyBKL03hhewb0+Y3ttSVyTmgQ=;
        b=dNcdpRWRyPuKrcqE1MzRhwOK5OA+IYFM7IXrTEYqldJjZXgRjBb/gqLa4g0PEQE4ZQ
         e8Be5QGol6IxkgIsOy7UXo7EtM/KP1PVr9f24KJT+8+3of4RR0BKZWuWMm7KQRGEOOvu
         GVSb4wIiasLk/sXKgZOw0cNg1fZ7RpsvpIitoLJr29PyDQIBbKTMAiG1Xlo0av49/IDm
         7S4SylhOeg2V95r32v9zKd9j2v4nmEUyUvP/SMcP5fHK50qcQl3ke1r95+0sHKUBg/AB
         lbwRZLvIqvjIZ3lzL6USOhuPunBuSUkwZ2DA5sYZI8idS2o8AUhhuasr2TFtHNWQKaaS
         rAJQ==
X-Gm-Message-State: AOAM533DS0Qq0xDr3JI0orky87YLmyU0vssLnEQiwFjtUJ5d3xe2HSby
        QqkFu7P5xtj31+QhCjQnO3m4j8FEuKtHrPpKS0t5Fp1pB1/yCN7B8e7/dkvHGWul7zXPDazGroc
        7kFAXFhhcm8XWZ2qyWguk/dBnW1KtwTjqFk1kmm05BBZ9WezQbmebbHt7Lmvp0UxhYTS62Ck+
X-Google-Smtp-Source: ABdhPJxdm5lhPoaQyo9mq+VRZ3CIgBal7zVBwBw1OEi8kc93Zv6CeBiGGl2FTswZGI6ymgr955omebmml7w/
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a81:347:: with SMTP id 68mr1ywd.40.1643240123407;
 Wed, 26 Jan 2022 15:35:23 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:45 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-5-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 04/13] perf/x86/amd: add branch-brs helper event for Fam19h BRS
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a pseudo event called branch-brs to help use the FAM Fam19h
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
2.35.0.rc0.227.g00780c9af4-goog

