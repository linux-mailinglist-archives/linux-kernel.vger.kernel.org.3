Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817F52F12C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351956AbiETQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiETQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:58:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14217CCB0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:58:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r71so8265464pgr.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22VYB4T0o3Xx37r6WzE/yRi7X69aRZykYG7kv0kLkSc=;
        b=C7LFan5PqLdVGZ+SLr58PsijHS3RB+16zSt4N6ivoF0HMXoFw95k2a7Tqa1/HMd5IU
         9n2zU8Gxt/DU2VqMD54csSNMdDt/EnPrAZvDjjZqiILpZxYTz7FBz+EV3MIwjA3uNuwv
         mU6XEtfQ4XDM6KUSVL5BfK0Tg1K5PsixHwiTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22VYB4T0o3Xx37r6WzE/yRi7X69aRZykYG7kv0kLkSc=;
        b=MLltcJQIgv8YHGWSjdJD3g6Bh4QlZgg+7k2hOUyf7tFjCujj08Ct0+Wa5Qnn9YTsAS
         EzjKdH38bNFWoBZBNCE0+1MuGxXdYWMQLLTi0kw3vprnCQc6e8PkgOSgOcSuD82AbVwa
         BASLM8eu5Mb/w4K4lzwATigVsimmKNVlsU1vFuk8rdvtF3VfqOm81TI4vlaBhZ/4rrQV
         JfyqVODs+aXAZAGH999vUoJah4zMMdxVvS6RIwHydlVVk5OfvlsBeca52yGYYh0UA9qD
         kyCA6I9TueCIMcF2GHhP+oGlghsXA5JP8nJYRqHbyMSQrHr/dI86RRCJsvFmeoS2oSyW
         LeXQ==
X-Gm-Message-State: AOAM531u8nLQqB3grBtURPxGpTCYB944i4mmo/PKAY8bksfKsdeerxUN
        9JzE1KOoSe/HqgNCSuzFrBocaQ==
X-Google-Smtp-Source: ABdhPJxWPot6oORC1hw50slsbOsGg151ejSp2qFewqjsWtKPqh5y+k+oVBK7GOtX8jukwW4N66sT8w==
X-Received: by 2002:a05:6a00:150e:b0:518:4c71:a4f with SMTP id q14-20020a056a00150e00b005184c710a4fmr6693196pfu.86.1653065908740;
        Fri, 20 May 2022 09:58:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y128-20020a62ce86000000b0050dc7628130sm2160515pfg.10.2022.05.20.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:58:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] sched/psi: Bounds-check state iterator against NR_PSI_STATES
Date:   Fri, 20 May 2022 09:58:26 -0700
Message-Id: <20220520165826.2140252-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; h=from:subject; bh=96ERcq4/37jGE44pucdcOxXhbh+wwhtX7CbW5PQiYz8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBih8iyWfLgscTtC99j+4R/ab67I/4djDbaFdXpzNGg 9rL3pdWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYofIsgAKCRCJcvTf3G3AJhXyD/ 9jOsyiaoTIS7iCfMhmESXAz7TMTibz8+6weHuHRObONX/fPd4/7iopQKYSyepC2+eBSYlXJU923Ngk j6z5J7xlIXG+rOHej0ZsB1vdllvSJjE+IQRgSf7DKad0JQVBCnbKwrMY0L6L7FvkjHf1OZCLd8ob38 Rcn6uyWp5uOeTlNikh+v3Ho9bb7wlta3DVVfHWsv6C43oYsfkmeWD2DcHaIgfKI0F5i5eekjpnxPyD Zj2sXn0gSh1i9P5iqqS7vBiZrgYn6IpViofXPmlUWtZseGVSNJQwdFUfAePlXozXC3ULumgo01J6C6 LtHLZHZNTUMRYU6NycFmkOJOjwrGGfP4adoZblCZeEFcJ1Icm2L4iec2gm77JkYdYqNEDSBDwK7m0G r4WsoBxoK3+lmeVrgpyMxenpce2likM74I9IfJj122gUuKaq16XTnh8yjCAJvVu5/82ytnuNMzA5VS XexCfcTVvNNVarsglGU4MYY0xfqvvmORHWAXWgqBi0HZH99J2xUovsYsKiscwfhy994rQ84nsM9AvC Hs6Osi5AMmTo9Eupca0R5I2XzimNq0ClYLGkDRetDET2WEGEOupe2pOtRwkwOIMhlmgh3w2XwEK1eW M3ECKu5yMW7MV12Wc0vJGRzUslZdFRuSI9iL5BBrOMLOv4A83wKZolnRtRXw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 cannot tell that "t" will be bounded by NR_PSI_STATES, which could
lead to walking off the end of the tasks array, which is NR_PSI_STATES in
size. Explicitly bounds-check "t" as part of the loop.

In file included from ../kernel/sched/build_utility.c:97:
../kernel/sched/psi.c: In function 'psi_group_change':
../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
  730 |                         groupc->tasks[t]++;
      |                         ~~~~~~~~~~~~~^~~
In file included from ../include/linux/psi.h:6,
                 from ../kernel/sched/build_utility.c:36:
../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
   84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
      |                      ^~~~~
../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
  730 |                         groupc->tasks[t]++;
      |                         ~~~~~~~~~~~~~^~~
../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
   84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
      |                      ^~~~~

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e35997..827f16a79936 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -725,7 +725,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		}
 	}
 
-	for (t = 0; set; set &= ~(1 << t), t++)
+	for (t = 0; set && t < ARRAY_SIZE(groupc->tasks); set &= ~(1 << t), t++)
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
-- 
2.32.0

