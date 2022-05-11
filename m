Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127CE523DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbiEKTrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347157AbiEKTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D63EAB4;
        Wed, 11 May 2022 12:47:07 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrx3AOrvD5JypgnotHDpSJeTOo7x5wLEoLi5p72nfLk=;
        b=F+fmKMx5gDV9ucqhoT/SZyVxQOp2WaP2iCQ8pkO+5Ko+o3ac+zk7Vfa4yz/gbX2cqclA3k
        BFybvKpFRL35+xPsmXEDuH/wmdatLCOqujXA94UIsmZoRwkfERRSzqpkJ/RvP4aRy/pfYC
        574nrnHsVNT/H3vXteRxywitn+F5lp3gU8ZSZzBFEtBkXIQ3sL8bfRxTJiMtoDyQcmmrtB
        GeGcm9ZzVovyl/EYxjQprKKVG1DzBco0Gl7jHmPuiR4otcT1z8cth2UVNloBSmdshdJkyj
        LDuGNK5TfZyETqe3yiHrmN0E0K0YtSzrstw3jfTPUVADbw/o3ODrCuiY6a2b4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrx3AOrvD5JypgnotHDpSJeTOo7x5wLEoLi5p72nfLk=;
        b=CNrRT1WMsPcgclEX3Jp9OHxB/wILZMoD//JOuYRKrjhQLZ7ATEv2ZgIvoZpgHDYFgqC4T3
        QYxqLjoLNh5cLmDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add new Alder Lake and Raptor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220504194413.1003071-2-kan.liang@linux.intel.com>
References: <20220504194413.1003071-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165229842488.4207.17360183875285961554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d773a73366bd54d0c75c533269fe2f0765ce42ee
Gitweb:        https://git.kernel.org/tip/d773a73366bd54d0c75c533269fe2f0765ce42ee
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 May 2022 12:44:10 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:08 +02:00

perf/x86/msr: Add new Alder Lake and Raptor Lake support

The new Alder Lake N and Raptor Lake P also support PPERF and SMI_COUNT
MSRs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220504194413.1003071-2-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 6d759f8..ac542f9 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -103,7 +103,9 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ROCKETLAKE:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
+	case INTEL_FAM6_RAPTORLAKE_P:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
