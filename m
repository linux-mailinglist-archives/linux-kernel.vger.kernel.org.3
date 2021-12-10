Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D98470C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbhLJVGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbhLJVGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA11C0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so18175865ybe.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xddwdAJMp6I6Z0v7LWRJSLiJzn/lRzo6+JF/IV1IKTo=;
        b=MjCtIXKcQZrpd5IgWuJYPePULMskIFs3ccEIaUHB1pLPCQDSaLPJZFLicPyvdgMMNs
         QfrrqW6mGjnpYXaXoiZ9y8wtOn6xgx4OBcxPwn+5nVb9lbIE/vhCaXHzPFfnWZ97qMeC
         mQBrXCRrkiR2xpb02gzp7cHbujcBL/K8H7g4wfwNXBLqq+i9hcj1YROUA3uH21wdjlVU
         /+Fpimmw4MbMvLGB/5xBphbjpfQYohF3ffgqTAH/FGvNuZukB6E3advmWPGEVb8gsP/r
         ViXULqmyOCJhVsuaRfrsBcfVLDjZm7zQQ0aj2XdosEWS941Earnlmy8nyXBpFLs8l970
         2k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xddwdAJMp6I6Z0v7LWRJSLiJzn/lRzo6+JF/IV1IKTo=;
        b=xXU+TZhJE2aXbhHCLDAOS05qI+Wvscuw/GuFDk5Z0WEPAsDRUWnr5FquzeebQJTWVx
         AjvkDpuaREvnKknJfAS+SuiYfq7DxV4lddDvQ4oj2+hmCo6h7aj5qW7xQRZSoE0YI1BS
         GmukotsU3dkafLH+n6Lzl7c634vz+5Bhg8tOP4LKirKzd2DZcciS200RvQtJPfXTocTc
         qx5YoIY+RLnyP4ETAj++/DZxogNzxbBIx5gHJU595OMTa1Gigu5l/49FnEAcDUJcRMuU
         oTr7Gzsj/1GFsxkv3JCAoZzqf9RD0SQ+m92rZHcJAqNw+Je6kOfdBtdGGVGnBOPsKD2Z
         pc9w==
X-Gm-Message-State: AOAM530p13VCMkSFiPnnxprLj/3JtxshWOnjp2tcus5kJDHjv5h4b2z0
        0p4XfcM/cGc1P/H7xIza3vgNy/PDE5LVpCX8XPZUc5+r4nIsnGrWX125abRerCiWLR6f509Y/Uk
        0Z6L07NIU8pY6qAVy5fYsfXd1HUJYvm0+X6XfuMiTtf5zAEfn9CB/496NbawveFGAIpmQd3Ra
X-Google-Smtp-Source: ABdhPJxgC7ZAZ4kVQdXStCzXL7vd8jzXO5gOPJyUCRgQ635p86aIIvU46Ksf6MDChutj0jbOP84RpxCDWddy
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:328b:: with SMTP id
 y133mr16000904yby.233.1639170176284; Fri, 10 Dec 2021 13:02:56 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:19 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-5-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 04/14] perf/x86/amd: add branch-brs helper event for Fam19h BRS
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
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
2.34.1.173.g76aa8bc2d0-goog

