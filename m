Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A9E4A8677
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351250AbiBCOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351271AbiBCOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006D1C061758;
        Thu,  3 Feb 2022 06:33:29 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8Eis3E343wJukn0Qs+ZCxjKMVQXcpmkBUevDbt703M=;
        b=e+PFzZLWFc95518iWlviz/XTbJUtxCZHylha79PA/Umnk/UtxzkMtaIeVg43sUMVXt+Nc1
        N65ObgwlhWxyrgWxlDl25re9tYU0s45VSyOPBVT0cThT7EemNkSDT+dS+kV2I1bjluwVRT
        bdtThfkVHEJXjPqQI1TzUExulogBhnL7quLhJApWdPH8ysGuq5QT161xtaqmO9geSwdVks
        GVbmICSTJsU+aOOGqDf+TSr06pd8plCXzfeMQyGk/ZGD83mjHWnAX4U+NcM5ONEIjaGIdg
        4Xm/uQAOXnbvF/h6gk7imJ1IEgivLkcCobFN1BMuCbjpIrV4Qs+hjqgDckMiCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8Eis3E343wJukn0Qs+ZCxjKMVQXcpmkBUevDbt703M=;
        b=KVjTgdYvzIZ47MMw60rJkNTg3WBfj9ubcdkGnuFZax/Q8rHQacwsn2/HD4LjVV+ujNzdiy
        LUvViroV0kebj5BA==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Allow kernel address filter when not
 filtering the kernel
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131072453.2839535-6-adrian.hunter@intel.com>
References: <20220131072453.2839535-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164389880765.16921.7539496032097645173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     58b2ff2c18b1e1d7232b8007a5698ec4ee7a7a0d
Gitweb:        https://git.kernel.org/tip/58b2ff2c18b1e1d7232b8007a5698ec4ee7a7a0d
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 31 Jan 2022 09:24:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:43 +01:00

perf/core: Allow kernel address filter when not filtering the kernel

The so-called 'kernel' address filter can also be useful for filtering
fixed addresses in user space.  Allow that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220131072453.2839535-6-adrian.hunter@intel.com
---
 kernel/events/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2889b82..afbf388 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10515,8 +10515,6 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		 */
 		if (state == IF_STATE_END) {
 			ret = -EINVAL;
-			if (kernel && event->attr.exclude_kernel)
-				goto fail;
 
 			/*
 			 * ACTION "filter" must have a non-zero length region
