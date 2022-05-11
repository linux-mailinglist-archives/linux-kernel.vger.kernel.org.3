Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF2523DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347276AbiEKTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347164AbiEKTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056B3ED1E;
        Wed, 11 May 2022 12:47:08 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXFptadzFMutXplH5G75HHsBNh0vW8tb7dFItB/edtA=;
        b=acB+EvQ30bctROCwAVeVcUG0HJ1B/l2+uOh/NHaWWItmvuG65LmF4dFbmG/G3FGzu8Xz+4
        N33HO30vch6SEP31UwBN7urF7fZSRJPcEDvoFuuzfYRtA6kAgfSjzbEW92t3Vw+WOkuETg
        eEAsyrrGcXlYLIGta2YK04fXryyK7VD4y/A4IU8AOJkih/gvcS1g9DyMYdNvZ9/KZCf4oA
        nDKLbTAk7pgxRw6VVGPE2uX4J7LWTjqH9gR4iUg0R33OjslWNd5/4Bx434m5DXJIMzvf+X
        IR3d1O64udNMc5eqDaULQiws34MayUiY4/TyF3JtyYjIuheVagNNV01d0+zhQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXFptadzFMutXplH5G75HHsBNh0vW8tb7dFItB/edtA=;
        b=2wDLL0TOwqXsgpU3utQm9lThMk9eZgOC4NOW/wZS9fi51kOPYAWpCvxgZjibE/JAVruNZP
        M2i79ZQkox4NO6Cw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add new Alder Lake and Raptor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220504194413.1003071-1-kan.liang@linux.intel.com>
References: <20220504194413.1003071-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165229842585.4207.14170896439135247906.tip-bot2@tip-bot2>
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

Commit-ID:     c2a960f7c5741cc4f03b4e587afeb89ad53c32c5
Gitweb:        https://git.kernel.org/tip/c2a960f7c5741cc4f03b4e587afeb89ad53c32c5
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 May 2022 12:44:09 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:08 +02:00

perf/x86: Add new Alder Lake and Raptor Lake support

>From PMU's perspective, there is no difference for the new Alder Lake N
and Raptor Lake P.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220504194413.1003071-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fc7f458..955ae91 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6216,7 +6216,9 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
+	case INTEL_FAM6_RAPTORLAKE_P:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
