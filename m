Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46A24E48FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiCVWRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiCVWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48353A44
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w1-20020a5b08c1000000b00633be107f28so4650407ybq.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SbI28V3sKLSa4XoImm+sfIA9Q4EtRHUUKQBKqzRI7DY=;
        b=DTSsjBhp5gYYpEzRMYZjo1IxELiQU46lI4846oN1VTD5AoO0wUANZAeEzy98aM+AZJ
         HX3uctWKzV5DexeN8XQ3JT30wXgLQmW5i7kUTPy4OEEV4RnBdqEP62VncCRhzvFQxbNW
         p4h4X0Jonj5IszUCjmXkKcbBp70WzW8Fk4Ju/jhMGfltnPSLp/RK8i/elAzGDAqoOtyo
         feGwk+nIswbQB2anC/ZqAoA8VO1eJlCyBjcxVcHGci7gLPDDgabV2RAOzH7oynwmCmcY
         rKJ+tXWRv80B7KvSftznyU8MmnRXAnjVtdGAjiSELU6MLLtTZYNNbV6BTCd3C4jiLbeo
         BXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SbI28V3sKLSa4XoImm+sfIA9Q4EtRHUUKQBKqzRI7DY=;
        b=EVIY28H3q7Mwng7WmeByq4ASCuje5vf4aqFVk1jt8d0hK8U1imBhovajFQeYLMd3uI
         a013TKyYSQ4CGtcgGUSPP8PLfuHt7Ni5cPYwlqwoRSDUlVHWdqh19PaU0qI+c7KWf0rP
         Ec9A23OQOB/kYZTY95iIOMZmhbG7/+crY8V8iPJOX21uiKW0CJKcsfHUEMT/14X/Mcgr
         kCypyf5K8Tn5ygPYO5uQxDFrMGv8euqaaV6toO4MiXpusAXBfJjKmGjWI2DbdMrzM+YH
         Jj3V6prImSUN+8Xfw7kTvVXSrUssqWavOUSmyc7wwsPUeMReGpUIbdXT/ueCVmnwPtsT
         xUJA==
X-Gm-Message-State: AOAM533YOEiOkXzccZKP5iW0+Q3V+4WaRmq8kqm51RjVLyugZ0tD/MmB
        ic0Rryx3s02fkX+dENgrW5oXZIYJU4Uol4+X7U1CFlUvhNbuJjjEaGVebeKUkVx78bFePH3BSGK
        jiGv11JrLllI8dlVbXDXqsg4ejWPyCJdIvIBSBGzqQzgaw+AWJTbQQE8vIzsWEjOlP8MkNeYx
X-Google-Smtp-Source: ABdhPJzzv2CTC+EpZ16zirkZ23P+0poq/22QQ+iK1T3zJntMo1771uM4p0PDBfElPR7fZy8uQ9ZUB8wX2931
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a25:f506:0:b0:628:9da9:cf44 with SMTP id
 a6-20020a25f506000000b006289da9cf44mr29522401ybe.595.1647987335151; Tue, 22
 Mar 2022 15:15:35 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:08 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-5-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 04/13] perf/x86/amd: add branch-brs helper event for Fam19h BRS
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

Add a pseudo event called branch-brs to help use the FAM Fam19h
Branch Sampling feature (BRS). BRS samples taken branches, so it is best used
when sampling on a retired taken branch event (0xc4) which is what BRS
captures.  Instead of trying to remember the event code or actual event name,
users can simply do:

$ perf record -b -e cpu/branch-brs/ -c 1000037 .....

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c7ac70d8ed9a..f7bce8364fe4 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1145,8 +1145,23 @@ static struct attribute_group group_caps_amd_brs = {
 	.is_visible = amd_brs_is_visible,
 };
 
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
2.35.1.894.gb6a874cedc-goog

