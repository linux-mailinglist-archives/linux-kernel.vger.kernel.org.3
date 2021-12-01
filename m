Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B5C46445E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345970AbhLABGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbhLABFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:51 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8EC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:30 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id w5-20020a634745000000b0030a5bee70e8so11192901pgk.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nbg/h0I8XirbIIyIbV47l3idrODYDcJnufBzeoebMkw=;
        b=jCZhulDZMqTetxq2h8/odVGqzzUeOrnnZ5A+GNMtvWCz5Rz8TFvhe3vPlx7NHxx71K
         bc+PsqtSYwyf1Bt6X97RmyFoj+B9X9obPQPLWxn2tk8TnbyV/GofuNcFnMoR7s7FNhSP
         GkkULELVbPO0JSXiGqL4sm9sD4cBcRfgNnarrDFPkzgEVjb595byt+W56QrlGvExdLS+
         PMWs0/np/1oGsQGNZfwSc28kmaFqcyhYfMaT6uO0NJBAP44nRFhMmXLf4gP5tc08IAJZ
         mSlOVK1XCSkJK6oYlUiqVezGGgFG+PkngoTGf1sNcas3+0ssEXVUStv0lA3ic7vV3IcJ
         hgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nbg/h0I8XirbIIyIbV47l3idrODYDcJnufBzeoebMkw=;
        b=QfKocHKVtpZGQ/x7TEwkACajHGzKHB6gREWTXSM15jINRt3e8GqfDotOmpKBkksg1Q
         wm8acAzm+eg9W9XbK+dv9NMLlHpeEVRfE7gCT7PMubACd98K04Yamg9+AF6E0VgkJSJp
         lQcDeG/fzAuf+1ztL0YI6f3qg86BpEjvoNpet+Ba2HY904eOOHP+MQdSygcv4OVftn2u
         WTNQSExadyWQC6Gl7TzkJ3Zp7laf0CglnLPbUddABSfYwRdFlGBjCaXxfhxFnpsaRCWr
         thyK/jhPHHL4V825QufchjVsZ19x+NCy2dJUs1hw3k6TmZYWMKDFp7MbQszx2FmLO0Se
         9LnQ==
X-Gm-Message-State: AOAM532ho3m2cXHTLsxDQq9dRS902fpQBv5BdS/vBYKlO5z1G/YnTZrY
        7IDl3+UsPusD+CfRrjESn3bLVAA48iOjF6X7uXoLCpktG7gJ03JW2vRPDTtWDRuo1MCfoxTBOqy
        +ZXf11WavqrNmUp72sczf/MTCDIMHSHfe5PTJkSTP+lY1OJkY2Ui5l6lEsnRHydI9xtQ+m1PN
X-Google-Smtp-Source: ABdhPJyHtcawrGS1IY7GcwuLJgch+wL8fr+1/XMpn/vYcv0gTVky7kqVUHp4ROdNP9aq12uRuMqPj4bH8eK+
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a17:90a:db01:: with SMTP id
 g1mr3190021pjv.33.1638320550390; Tue, 30 Nov 2021 17:02:30 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:08 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-5-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 04/13] perf/x86/amd: add branch-brs helper event for Fam19h BRS
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
2.34.0.rc2.393.gf8c9666880-goog

