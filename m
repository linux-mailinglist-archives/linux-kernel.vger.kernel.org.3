Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764394DE6A9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 08:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiCSHU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiCSHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 03:20:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC6629C97C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 00:19:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g19so11347168pfc.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z8qKc5VVBPg1IRhLNVyUK1J5fxihYi2IheAZ3i/Q+w=;
        b=MnHqwf5aaNB4+54EyUsY0n0WVyd9AGmT8aRziaNvaFe0eq7/mAEWE0aLJuJq5ockGo
         3hTqrCJ/D8Z9GibW18PHcFnu8ockhfwqIMuqrXCGPOh2pCpk152ttmlidoc7EQPfOe7P
         yPX9wUwgPGdgF2D71AJYzNvg0lnciBtYCI+J7uLTKRUgZi/Fz7BtWnFOCjtBdgTMNqHX
         sEiTGmPEN1ZEjk/DHNyfGs6K/wZkOltwxfKOeXovPTt7qwuZjR9DlaERYG2ezMJK85Z6
         KekqVfUXLhN1WxGVzPbesFhlpjhzQJtom38NrPCmJ8acDLqScU1Rb69JQfh+wc0ygM33
         qxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z8qKc5VVBPg1IRhLNVyUK1J5fxihYi2IheAZ3i/Q+w=;
        b=q3hpng/1OeP9arl4dQWKSYsBhTu1xdae+dGh9OFhQCCs8JVZ88RaKcdis3XFgN/qO4
         JIAzruIT9kKIm+W3pWl171V6aginf84JK38MpFG84R6kqBgo93RSyOVa9lx5RX/kKT9y
         Xknr0i1YaPKzJqwr/A85AzjKVn9BSt9K5TlECguSiYFpb514x8+x/WG5rM0UEmdZOm9V
         CaXh76zdHXJP7n1XcxE5ND1XoZvUFPzbIz/aExuE/V7Pq4Wymwu9cy6gMJPFQ/MzALZ8
         FgwLyKK9cpWDjr/WWYwI/EsxBs4aOGGulrY0LbWwuFjFRnSgj3xyXmsEX2sNBMcDyca5
         6osA==
X-Gm-Message-State: AOAM532FtsrDayv5ZjrLBNqk2TWJxLxBQYIfy8fJnGx2YbXLZYBGYWgO
        pRMJ3AfWQnX4ZOBo7jI8cx4=
X-Google-Smtp-Source: ABdhPJwPPjIJAmHa4m3YxlpkZ2CFFFrOq7p11tnKTcUY31RutiHq9Tc/+MNRmnKJl+8Hs3c57UL8Cg==
X-Received: by 2002:a63:1e4b:0:b0:381:c48:928b with SMTP id p11-20020a631e4b000000b003810c48928bmr10256472pgm.139.1647674373614;
        Sat, 19 Mar 2022 00:19:33 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7888c000000b004f3fc6d95casm11825885pfe.20.2022.03.19.00.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 00:19:32 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] smp: Fix offline cpu check in flush_smp_call_function_queue
Date:   Sat, 19 Mar 2022 00:20:15 -0700
Message-Id: <20220319072015.1495036-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The check in flush_smp_call_function_queue() for callbacks that are sent
to offline CPUs currently checks whether the queue is empty.

However, flush_smp_call_function_queue() has just deleted all the
callbacks from the queue and moved all the entries into a local list.
This checks would only be positive if some callbacks were added in the
short time after llist_del_all() was called. This does not seem to be
the intention of this check.

Change the check to look at the local list to which the entries were
moved instead of the queue from which all the callbacks were just
removed.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Fixes: 8d056c48e4862 ("CPU hotplug, smp: flush any pending IPI callbacks before CPU offline")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d82439bac401..eb275b69d5f3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -582,7 +582,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
 	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
-		     !warned && !llist_empty(head))) {
+		     !warned && entry != NULL)) {
 		warned = true;
 		WARN(1, "IPI on offline CPU %d\n", smp_processor_id());
 
-- 
2.25.1

