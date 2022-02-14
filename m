Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEBA4B544E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355698AbiBNPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:14:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355687AbiBNPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:14:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D569143491
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46DA6CE186A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0E5C340E9;
        Mon, 14 Feb 2022 15:14:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UltiEhjb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644851678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfp7utboeSn1VJfqODeM2ek8DfqNBKhzS38Fxc/o7OQ=;
        b=UltiEhjb2okqcPOXidM8W5DiaGGOIgnLuHvzYYiZ6RS5x0vWTc0FA1oaucbfQQB9Dria9/
        boXrBpTF2BYy0NuaZ/E/f6oqH7bkkxUC62mqr7q2Cg+9R54gqo1/gs0WfsY2ksfe99ouQA
        7djuGDUINsSO/JG5IPui9r/CzTfk7a4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b1d57804 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 15:14:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        linux@dominikbrodowski.net, sultan@kerneltoast.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v3 2/2] random: invalidate crngs and batches in cpuhp prepare
Date:   Mon, 14 Feb 2022 16:14:15 +0100
Message-Id: <20220214151415.1108141-3-Jason@zx2c4.com>
In-Reply-To: <20220214151415.1108141-1-Jason@zx2c4.com>
References: <20220214151415.1108141-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a cpuhp prepare notifier, we can invalidate the keys
used by the per-cpu crngs and the batches used by per-cpu batched
entropy, so that if the cpus come back online, and the generation
counter happens to have cycled all the way around to where it was
before, it doesn't mistakenly use the old data. The chances of this
happening are exceedingly rare, but since we now have the notifier
setup, doing this is basically free.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2e25e3aa6506..6870b5068a75 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1229,6 +1229,14 @@ int random_prepare_cpu(unsigned int cpu)
 	 * since the MIX_INFLIGHT flag will be cleared.
 	 */
 	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
+
+	/*
+	 * We also want to invalidate per-cpu crngs and batches, so
+	 * that we always use fresh entropy.
+	 */
+	per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
+	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
+	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;
 	return 0;
 }
 
-- 
2.35.0

