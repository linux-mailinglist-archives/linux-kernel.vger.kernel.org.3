Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C74B79A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiBOVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:23:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiBOVXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:23:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7ECDB84D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E9B61917
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1CEC340EB;
        Tue, 15 Feb 2022 21:23:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="m8HIgyBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644960188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBa9wueJoGb7LxuMzbvrV62ilts8LkBCNQfxIqDAz2s=;
        b=m8HIgyBalfmKrwyVHWHZVY/qWQW9jNtjaj4jJY43LvVEakS6gV2vbr84BHwcM70hQQMTpp
        DJvLkiU5z8veBKfa1a8kkLSxoEtGtjMLHZY2BtYaN+AYjbhEFj82BRTRYfujrfWZ/I1IE/
        M96uJ7Kbn27f+I1+4tikCSKPXwAMifg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c92f5e54 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 15 Feb 2022 21:23:08 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        linux@dominikbrodowski.net, sultan@kerneltoast.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v4 2/2] random: invalidate crngs and batches in cpuhp prepare
Date:   Tue, 15 Feb 2022 22:22:55 +0100
Message-Id: <20220215212255.273253-3-Jason@zx2c4.com>
In-Reply-To: <20220215212255.273253-1-Jason@zx2c4.com>
References: <20220215212255.273253-1-Jason@zx2c4.com>
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
index a3cc147406b0..41188a49d43e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1233,6 +1233,14 @@ int random_prepare_cpu(unsigned int cpu)
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
 #endif
-- 
2.35.0

