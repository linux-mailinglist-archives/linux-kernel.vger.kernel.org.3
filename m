Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855A4A866B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbiBCOdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:33:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbiBCOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:31 -0500
Date:   Thu, 03 Feb 2022 14:33:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DghpKRiUTr7+jBgEPqSNTZlDDDSbF07vlFyhmMhXdmU=;
        b=FndXhJYDKl9AV/KWkFeOEdoAUPYbIDtz3z057ANlmNkkjg32AkLzfkme71O+2kcBICVln+
        PxIlSzloFoDr5EGPyy9e76P+ZLbDjC5ZTX99T8IPko5aEPT/St9fKesnkCH2u6gQGW4XhT
        2KUfNZ12/sJVwQFrO1BEDJzqbYUV6N17GYh0pXOGhQVGG4vBVuqpGKbwShsVq8jrHiUA8N
        9RNWX1PQEn4wsFMuE4j52NN0RGjrwjmV8i8XS9faaTw2oS0yAjGtNQofY7KARP52l0vGXl
        P9xuOmkgEkx8NgG2BpPfFWhLDAF9p5ka+ZHPXyLO2WifrABJNniEdZ/Unam2qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DghpKRiUTr7+jBgEPqSNTZlDDDSbF07vlFyhmMhXdmU=;
        b=bhEZkcMLyA0CGq7pdWLw93mHCUycUJKuTebOaQgDshYqpcLUnH4nkNBaku6OQfjxaclZnS
        PhJYTAZgvet8vUAg==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix address filter parser for multiple filters
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131072453.2839535-4-adrian.hunter@intel.com>
References: <20220131072453.2839535-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164389880921.16921.13721416537841626758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d680ff24e9e14444c63945b43a37ede7cd6958f9
Gitweb:        https://git.kernel.org/tip/d680ff24e9e14444c63945b43a37ede7cd6958f9
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 31 Jan 2022 09:24:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:42 +01:00

perf/core: Fix address filter parser for multiple filters

Reset appropriate variables in the parser loop between parsing separate
filters, so that they do not interfere with parsing the next filter.

Fixes: 375637bc524952 ("perf/core: Introduce address range filtering")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220131072453.2839535-4-adrian.hunter@intel.com
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 76c754e..2889b82 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10558,8 +10558,11 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 			}
 
 			/* ready to consume more filters */
+			kfree(filename);
+			filename = NULL;
 			state = IF_STATE_ACTION;
 			filter = NULL;
+			kernel = 0;
 		}
 	}
 
