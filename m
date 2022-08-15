Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348A759292F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiHOFt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHOFty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:49:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0DA15A37;
        Sun, 14 Aug 2022 22:49:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso7355129wma.3;
        Sun, 14 Aug 2022 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=uGggk8CyROOE6BuwirZsC/KnSOWSMiLrJqzu6p9PnyA=;
        b=jrBnoDWrR4s9Auzs0RG+NWUrx/IJNphLyUYno0ZIQbwi8MXIxaJollmppR1xwUYtZ0
         hADnwZdA7xhbtmgCawgWEuKxmC6R/nCOCf1LI1+Jy4AzDuo+IsHTgoRL5skxLV+hoS2w
         bIB7mB4aL9fYIbGymtuu/bToVn6r26/W/+38q/5HjC2xIgfzQuHgAgzcqWkt9ahO377v
         nBuS3dNgz5i0IcxVQhXVnEWlRfdKWR/r8U3n3vj7xxBQruiV9Zbbr2BczaqH/sm7XwNQ
         y/FzCOoGzIL2dcGtDAJXCNo5Sy/8AFlJLBFVb3RQDoaeYqDHCVrtVyK6RbJJjDmX8UqX
         gVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=uGggk8CyROOE6BuwirZsC/KnSOWSMiLrJqzu6p9PnyA=;
        b=aGwrgUOr2hZKcdjg1FtCQ/6zehuA9fDE9YMwouvHR+BctEaDKs0KAUxBVhIQcfiCj8
         AlV5y6vJmT6Aa9Dj6WQJj5jOt9ZE9bwOkO0bAmJcrYEWSbgIzNAm/k8a9wZEvSdLJOsj
         znYciVFIoRItNiba/SwAMY+Wg0Pg5zwdSHshZQc08dYLVk9SVRmGKTXmwmPbz9uh9PPT
         vkl689sqQwAX2EI0nsvrnpNZZs1oXLbAjq+wGIZn84KnTML5/Y0wizY27qbBZkk3jZb6
         Qo/edIAaOOKHYwnteg0BvIpx9Zjo4i6uKPNBDzAbzoU0vnwdonxNFXBglYexKi2IyCMO
         XPyA==
X-Gm-Message-State: ACgBeo029sn8Ew7oyf/cgBxp+PYOWylTjwEm9CnOugv7yMLTnses81Y5
        oiEW1xHs28enBy47/vGRkH0=
X-Google-Smtp-Source: AA6agR4Dby7NMGP6JE7UQ2XN5J0tHI2tE6HcbfxDjRSKwXC2imKvfQBMP5Rg5bmoDnJ66+5qjZNKVA==
X-Received: by 2002:a7b:c5d6:0:b0:3a5:125c:2dd4 with SMTP id n22-20020a7bc5d6000000b003a5125c2dd4mr8936899wmk.76.1660542592390;
        Sun, 14 Aug 2022 22:49:52 -0700 (PDT)
Received: from nz.home (host81-129-83-151.range81-129.btcentralplus.com. [81.129.83.151])
        by smtp.gmail.com with ESMTPSA id i5-20020adff305000000b0021ef34124ebsm6222984wro.11.2022.08.14.22.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 22:49:52 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id 5296064F6D5EF; Mon, 15 Aug 2022 06:49:51 +0100 (BST)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyich@gmail.com>, linux-ia64@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ia64: fix clock_getre(CLOCK_MONOTONIC) to report ITC frequency
Date:   Mon, 15 Aug 2022 06:49:44 +0100
Message-Id: <20220815054944.4130786-1-slyich@gmail.com>
X-Mailer: git-send-email 2.37.1
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

clock_gettime(CLOCK_MONOTONIC, &tp) is very precise on ia64 as it uses
ITC (similar to rdtsc on x86). It's not quite a hrtimer as it is a few
times slower than 1ns. Usually 2-3ns.

clock_getres(CLOCK_MONOTONIC, &res) never reflected that fact and
reported 0.04s precision (1/HZ value).

In https://bugs.gentoo.org/596382 gstreamer's test suite failed loudly
when it noticed precision discrepancy.

Before the change:

    clock_getres(CLOCK_MONOTONIC, &res) reported 250Hz precision.

After the change:

    clock_getres(CLOCK_MONOTONIC, &res) reports ITC (400Mhz) precision.

The patch is based on matoro's fix. It adds a bit of explanation why we
need to special-case arch-specific clock_getres().

CC: linux-ia64@vger.kernel.org
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 arch/ia64/kernel/sys_ia64.c           | 26 ++++++++++++++++++++++++++
 arch/ia64/kernel/syscalls/syscall.tbl |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index e14db25146c2..d5d47eb4608e 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -166,3 +166,29 @@ ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, u
 		force_successful_syscall_return();
 	return addr;
 }
+
+asmlinkage long
+ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *tp)
+{
+	/*
+	 * ia64's clock_gettime() syscall is implemented as a vdso call
+	 * fsys_clock_gettime(). Currently it handles only
+	 * CLOCK_REALTIME and CLOCK_MONOTONIC. Both are based on
+	 * 'ar.itc' counter which gets incremented at a constant
+	 * frequency. It's usually 400MHz, ~2.5x times slower than CPU
+	 * clock frequency. Which is almost a 1ns hrtimer, but not quite.
+	 *
+	 * Let's special-case these timers to report correct precision
+	 * based on ITC frequency and not HZ frequency for supported
+	 * clocks.
+	 */
+	switch (which_clock) {
+		case CLOCK_REALTIME:
+		case CLOCK_MONOTONIC:
+			s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
+			struct timespec64 rtn_tp = ns_to_timespec64(tick_ns);
+			return put_timespec64(&rtn_tp, tp);
+	}
+
+	return sys_clock_getres(which_clock, tp);
+}
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 78b1d03e86e1..72c929d9902b 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -240,7 +240,7 @@
 228	common	timer_delete			sys_timer_delete
 229	common	clock_settime			sys_clock_settime
 230	common	clock_gettime			sys_clock_gettime
-231	common	clock_getres			sys_clock_getres
+231	common	clock_getres			ia64_clock_getres
 232	common	clock_nanosleep			sys_clock_nanosleep
 233	common	fstatfs64			sys_fstatfs64
 234	common	statfs64			sys_statfs64
-- 
2.37.1

