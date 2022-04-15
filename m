Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A550274C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351728AbiDOJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351706AbiDOJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:22:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD31C906
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:19:38 -0700 (PDT)
Message-ID: <20220415091921.014937522@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650014377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A2Bd4Iuntr6LsfOvKP9T0K7+QZfm+hdiWWJ5DcSeC7o=;
        b=UR0CYmeHCzZKQeVIOlwqI3keptYofbrykXAiQmgYGEdHHd6pykRNCiXZ4+p+l3J9iwv741
        E1ULf/j5frMjn0MZbiLy0Ri9aff1VtYQrBdmOjSkfq6CkwDJWRVW32o4VVqXGX/97BopDT
        pEuuHj0lhaG/liN21zaZ1w55yQ+tNJx1ERjYgBLK0evpMsu0d6Urzyxx0jJxKM84HBqcHe
        PMgkjMV6Z+rN/x0Y12pMLXfoJfOT+Jo0FYAm+YnopyuTc0KD6mMWXNiyslFX6d/WLZSnbo
        sMuZH3mjv6rXk9uFkYS2FcdTpdS4CT62cu56pIobjcLy9CPppcads3V0BBXUjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650014377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A2Bd4Iuntr6LsfOvKP9T0K7+QZfm+hdiWWJ5DcSeC7o=;
        b=qU4J3AR2oTOqy5ZlXpBxfqO9ifItbnuBd7TS7vduOzIuO9YkkmBRy2WQV6050DrKm2dOBE
        jbZGZvX9ILBuSaBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [patch 2/3] timekeeping: Mark tk_clock_read() __always_inline
References: <20220415091223.187169221@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 11:19:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilers can uninline this which makes the notrace annotation of the NMI
safe accessors moot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -186,7 +186,7 @@ static inline void tk_update_sleep_time(
  * a read of the fast-timekeeper tkrs (which is protected by its own locking
  * and update logic).
  */
-static inline u64 tk_clock_read(const struct tk_read_base *tkr)
+static __always_inline u64 tk_clock_read(const struct tk_read_base *tkr)
 {
 	struct clocksource *clock = READ_ONCE(tkr->clock);
 

