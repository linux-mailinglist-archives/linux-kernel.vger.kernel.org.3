Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2359AF8D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiHTSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiHTSUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:20:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A90220DA;
        Sat, 20 Aug 2022 11:18:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso3966344wmr.3;
        Sat, 20 Aug 2022 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cYBHUIn55vLm6CUc16PtybcrqekGb4Mr9+yD70pZA9M=;
        b=SUeZCA3lhzL+9rOzSf8SjaYAIEbGkTK8S5/ZOdu2VNNDNPP3z+Bz/wd1r4ojiv4Ser
         m89hIZIJwJxR6j4ao54iF/ffUVD6s/+tr4nYSb2vNveS3rG1o+ZSZbjTaCefomLDO06H
         JYkZuN38DxJFuiD/jdJQka4qH8YF/zuWFGLsHtXcSVfxvwp9U+qOYow8hjnCjpcOC+KW
         5LWqbVW1/RB/JuhUFQDvn/Hq3UEOLmkMqmTvU/gDkW6SIx45FOk49e0Nf8fqd8gOrw+A
         S7q3EyM7BMhRBsjOuiWxJA5qNKVXDIofuwCbkPzNgHofS/Yy08ebyDG407EcA6PHAP7X
         8PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cYBHUIn55vLm6CUc16PtybcrqekGb4Mr9+yD70pZA9M=;
        b=a4n/7tAA5n4MAac8w1xwnSxXUIbGSHdOArMc28vkXuUq2TvJIR5awqiMMNlNzhZJvF
         0gHh/A3sr/WjKeQ5VCY9mf6RIQOtd4l304Lkzee5IZtRDzgkpxRM34uixkb3U9E6pBrX
         rRRoiEVAL2VRVoasAWi4UK2tCjArApAPJ9KtIqS5N0XtKtGn/K6erJ/RK5cCZEsbw+rG
         I+kGymlXEQPasNlTBqzn/x9SDSh5+INP/zZBexreznYXQENSLxaGH1tw5M43orOViB1t
         uggxlf/saKhzxSJAfXlWoUey3CAsrH8jnVsNLKk73sckNvwR4AZiS+7ePypxHSckxLt+
         1Rtg==
X-Gm-Message-State: ACgBeo0ldYfFmdwtWB4ZP31c9CXq3C+A5SzFsIyEn2wom1MyafqvfsOX
        3zP+OUO5JsEO8n6BRwfKgnI=
X-Google-Smtp-Source: AA6agR66zUV41P/Odl07VZnLEDkmtZUpjv7dLDJGjiip2OdlOFY1pRiSPhXcFnOQcXOh4bmfh2uCjw==
X-Received: by 2002:a05:600c:190f:b0:3a5:f6dc:f542 with SMTP id j15-20020a05600c190f00b003a5f6dcf542mr7868929wmq.130.1661019504740;
        Sat, 20 Aug 2022 11:18:24 -0700 (PDT)
Received: from nz.home (host81-129-83-151.range81-129.btcentralplus.com. [81.129.83.151])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600000c300b00225285b8136sm7105821wrx.38.2022.08.20.11.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:18:24 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id CB82E674845D7; Sat, 20 Aug 2022 19:18:23 +0100 (BST)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyich@gmail.com>,
        =?UTF-8?q?=C3=89meric=20Maschino?= <emeric.maschino@gmail.com>,
        linux-ia64@vger.kernel.org,
        matoro <matoro_mailinglist_kernel@matoro.tk>
Subject: [PATCH v2] ia64: fix clock_getres(CLOCK_MONOTONIC) to report ITC frequency
Date:   Sat, 20 Aug 2022 19:18:13 +0100
Message-Id: <20220820181813.2275195-1-slyich@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820191751.26b125af@nz>
References: <20220820191751.26b125af@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The patch is based on matoro's fix. I added a bit of explanation why we
need to special-case arch-specific clock_getres().

CC: Émeric Maschino <emeric.maschino@gmail.com>
CC: linux-ia64@vger.kernel.org
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: matoro <matoro_mailinglist_kernel@matoro.tk>
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
Change since v1:
- No code or in-code comment change
- CCed Émeric
- Added matoro's S-O-B the way matoro comfortable with
- Fixed Subject typo s/clock_getre/clock_getres/
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

