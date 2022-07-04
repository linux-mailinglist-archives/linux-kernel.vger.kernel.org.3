Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271C75658CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiGDOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiGDOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F0FEE14
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:39:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g7so4349052pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNqvcKgo1+oe7KfjMD3BFid/MOvuDJRgw+z7dh4MpHg=;
        b=Rd5z8PJTAKeEtJxaGAFVCmXX2MztOoimi+HPammxoFcq0O6PnXW8JfFMtMvJp6haX4
         N0zM5V0tjiNuFmpytb88WSTWOEnwywt0C6qP1EwTsCDXaX2dInDbnhxIPMzTowViP1bP
         2ZZ8/AF9jglxfgKev3K+HAyB5vDOTavQMonRtdUVliPhnplSEZp0J+Phxb256DXUP32N
         E8SeZl8emqoBykXys17iDBDX+yrMLpLX/i11Cw85FEGSHDf827M85rRFl6o1PwCBvFQI
         9B2n8L/5a6tMWzeIMGJL0m/ktzJI4GTnown2/j8btygQDhMAxvhMCNWQyAWIb5NajTOL
         xu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNqvcKgo1+oe7KfjMD3BFid/MOvuDJRgw+z7dh4MpHg=;
        b=isu1nOLYGfYFzFcXhJFwd2JtDsqIHBT/fUZ0qJdE4ZKfGSzhECBmFOxz0LJLXLPlyl
         TKxVNVNzeaQf+3/NjllU3mVHYaoPvoV8xTXTWH9n3SUm2Uydyqp0k+QP2z8bdwIRIN24
         ctTqCHWotBzv7kZRxXdBgXArEBnUrbHUvD4GHU2lLPjAPZnFpVizdn7oDRU3ItVjULQg
         LzAL7SyhKpSKny75WMIzz+RIHMc+e8bgFXPiYOrG3p4lEz+9U+njT2++ERgEjamaDyBr
         jw5ueOxd46hnQHn2YgkBcvlXd5kvRY4BnUjZk8tJ3sD5Kx4R0X3dV/DUU3+dDe0H0hmD
         APoQ==
X-Gm-Message-State: AJIora/HAYSdTl8i5xPvbXpXVA+Y82kj6DG2dArzxsh4r4iCJS1lvLCw
        PU2uamfWMrx4U0WHlLPOLBE=
X-Google-Smtp-Source: AGRyM1tcLyesZ4LqtcBwRRAPb3M8h4Y5icA5Z0GODpjLR7sKbKnD1cHPy3oh6p6Bf2qsw7Zg6nFYVA==
X-Received: by 2002:a63:6c42:0:b0:3fe:465:7a71 with SMTP id h63-20020a636c42000000b003fe04657a71mr25203899pgc.101.1656945545785;
        Mon, 04 Jul 2022 07:39:05 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:39:05 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] locking/qspinlock: paravirt use simple trylock in case idx overflows
Date:   Tue,  5 Jul 2022 00:38:17 +1000
Message-Id: <20220704143820.3071004-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704143820.3071004-1-npiggin@gmail.com>
References: <20220704143820.3071004-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mcs node overflow fallback locking case does not have to use
pv_hybrid_queued_unfair_trylock as the trylock, which reduces the
differences between pv and !pv cases.

This was likely an artifact of function renaming making it use the pv
trylock, which is not a bug but it is unexpected.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 1d5b3443772c..cef0ca7d94e1 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -798,13 +798,8 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool parav
 	 */
 	if (unlikely(idx >= MAX_NODES)) {
 		lockevent_inc(lock_no_node);
-		if (paravirt) {
-			while (!pv_hybrid_queued_unfair_trylock(lock))
-				cpu_relax();
-		} else {
-			while (!queued_spin_trylock(lock))
-				cpu_relax();
-		}
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
 		goto release;
 	}
 
-- 
2.35.1

