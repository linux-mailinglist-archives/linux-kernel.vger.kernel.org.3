Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BC24F4E41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588434AbiDFAP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573544AbiDETUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:20:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B73DEBB90
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:18:07 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649186285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69oCF78NKr1jl3sMedzA5+keaKCiGKe+Lwryd6u9+Y4=;
        b=iooJrb7NzGc5sceMz1JIDxoTm5+DArmCDQ1EzZzHPd14qYEvpZ3hzotJ6lvR6kaLUZHd0x
        vDTF283VzULVRwCDEM8azIbwiC/jHa1zkgEtP3OMvBkpHa3XSC1rWFSE/XWuyHCj9Hquyv
        7OwZvi3c+959JDcLo9LUyMjtAv2ulb+KY+AFtLI/pVd5V1B9XNpbuO277F6xaxg2Xyb0bK
        zZ7vrxdVAXRnxtrBRkfLRpyrYKSyG2pRWL+pqibppfweTp3X/KDc6HBt8JAsc3QDZ32mOA
        f9bQeOayvqbz9DTDW0/q/AI6BEeSGtdHyL885qRorhroWvqbZIJAUHAE5wyYoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649186285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69oCF78NKr1jl3sMedzA5+keaKCiGKe+Lwryd6u9+Y4=;
        b=LZzmf/FdVllf6Du1IsHVYJpfEemSP6ZKguYyqaxXSolfyK+cDtqCKw2kUX8I8hNVj1ej+r
        etWs0YDH0bGSnhAQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/2] timers: Initialize base::next_expiry_recalc during prepare cpu
Date:   Tue,  5 Apr 2022 21:17:31 +0200
Message-Id: <20220405191732.7438-2-anna-maria@linutronix.de>
In-Reply-To: <20220405191732.7438-1-anna-maria@linutronix.de>
References: <20220405191732.7438-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When base::next_expiry_recalc is not initialized to false during cpu
bringup in HOTPLUG_CPU and is accidently true and no timer is queued in the
meantime, the loop through the wheel to find __next_timer_interrupt() might
be done for nothing.

Therefore initialize base::next_expiry_recalc to false in
timers_prepare_cpu().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021ad459..4af98e77cd78 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1950,6 +1950,7 @@ int timers_prepare_cpu(unsigned int cpu)
 		base = per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry_recalc = false;
 		base->timers_pending = false;
 		base->is_idle = false;
 	}
-- 
2.20.1

