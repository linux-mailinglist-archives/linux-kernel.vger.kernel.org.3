Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0F4F384A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376562AbiDELW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiDEIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E782DD73;
        Tue,  5 Apr 2022 01:36:56 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqGsUCInYJYqWGB26mzQqRN8NkW0Zsnxq2+XJepJuUU=;
        b=ILw5lX6p/mtGsKepArwIjEXIpxARCMAfYOsmgzbd83cg+b4Nnicp2RRRKmiZ6umyPoSOMt
        +eCyH3gvVcXXQeGZSz1fPKPneod+pnPYSEZyUAIqRUg1ufkoynT2IruzzSU69GUUN3Ob7o
        qspTuhSrahSlS/KvPReUTvamQLr/Xvi+d40bBsiLyv0v57pwH9oserscSVLa26Jsn5FZCi
        /xpLyjbeIwAJ6Rq1FkbKKoUa8NhUV8MHPFY5IkQboyTF9/u9h77FTqeSzKvaUAiF45yA2G
        Jvfx21IgsXEQAz6fmQvVodcHaZA6Mka3t4b+n61eOyfx99c/D3qZqqNXXJ4oZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqGsUCInYJYqWGB26mzQqRN8NkW0Zsnxq2+XJepJuUU=;
        b=6U0FV8dOtit+6wg6WFsb26EKeQ5GLFxlmBlwW8NoKUV89YMBxFcmo2Yonu2sn+aI5HX8Tr
        9QG6wij5o6vnSSAQ==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Add branch-brs helper event for Fam19h BRS
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322221517.2510440-5-eranian@google.com>
References: <20220322221517.2510440-5-eranian@google.com>
MIME-Version: 1.0
Message-ID: <164914780166.389.13309204242151647922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     44175993efbae04e8b2d7f7795ff512c3a726db0
Gitweb:        https://git.kernel.org/tip/44175993efbae04e8b2d7f7795ff512c3a726db0
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 22 Mar 2022 15:15:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:37 +02:00

perf/x86/amd: Add branch-brs helper event for Fam19h BRS

Add a pseudo event called branch-brs to help use the FAM Fam19h
Branch Sampling feature (BRS). BRS samples taken branches, so it is best used
when sampling on a retired taken branch event (0xc4) which is what BRS
captures.  Instead of trying to remember the event code or actual event name,
users can simply do:

$ perf record -b -e cpu/branch-brs/ -c 1000037 .....

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220322221517.2510440-5-eranian@google.com
---
 arch/x86/events/amd/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c7ac70d..f7bce83 100644
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
 
