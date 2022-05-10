Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5052206C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbiEJQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346675AbiEJPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:53:04 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458B532DA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:33 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id h13so12911960qvh.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bur4fxX/BrvprtCkzJ/rZNHI8r/mAEcHC8jDO+mfnuQ=;
        b=e7ZZlkybHOWLJx+oXUj0vXRSFyZd8IYa9ACjNcnatMK/JMp+ySDRPjT8uYOTAK8/7w
         lqdT156i0/jzgVElyb+JwrSMtOu7v0GL3YWJ/fVSU5cW3QFxtamzQa9GVDD0UzcDykJY
         FIc14I3NO0kojfKSu1255m+u3SDIOzbm4qF54SSdjoTRnnHt3C6qwPArhu3xwKIqccDG
         XQa+XqwN+qG41jvzVVIwOo5+4AHBpRv6jNutI5YRL/nE25gadkwFtzGt8sn4oazHvIiW
         bplPPpKcV5366Bm++v20GW3o574omfVzA9MtlUOaq+E/lSmy9fxyNUvfA2K0bbH3mLIq
         3/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bur4fxX/BrvprtCkzJ/rZNHI8r/mAEcHC8jDO+mfnuQ=;
        b=PlxTk68XAEXlbvtv6hWiXsWwkQHcUJ4gV8HxZyGd14OQfxRs49C12Z/ISKn3qQ6pU9
         1WslQQ/Y0XLjqzPVXSCi2hO11DtGk/uhJ3LRXxinqnkrslQN6aiD2dWC6caPTZlxYfwV
         1dl3cynVrf7b0mP24vmqGxy/WdjRKMrk/tU5kFdtai0F6R9K1YjAp3pmeowgW/HnHSa6
         +pYlp2qpZvFUgwmee72FKWH12cFlXtIlwcNE32Vd+vWgZizd2XVsF9pC9Q44iN+w8HyS
         vwAWX8nBIWWh5t9F4YJ+obm3lT8ZeuN6EmC/lximiaGNB6pnWu2XeWg2buhDde73nyUM
         /QMQ==
X-Gm-Message-State: AOAM531EEfoAwCyBeEvrPb2t7k3PctYicoCi/QRh6E6AAX+YMoqNKWZC
        my2+g3FVY+NR2nNJ+508OFo=
X-Google-Smtp-Source: ABdhPJwQdNePPFuFx14UNaElb8MMSTHODZBDKbBYDNtA5BGS6X1s0xUxFjgIKXYwJ3SqCHWVDWzl6g==
X-Received: by 2002:a0c:8001:0:b0:45a:a28a:99ef with SMTP id 1-20020a0c8001000000b0045aa28a99efmr18155233qva.99.1652197699995;
        Tue, 10 May 2022 08:48:19 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id m19-20020ac84453000000b002f39b99f674sm9248352qtn.14.2022.05.10.08.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:19 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 19/22] sched/core: replace cpumask_weight() with cpumask_weight_eq() where appropriate
Date:   Tue, 10 May 2022 08:47:47 -0700
Message-Id: <20220510154750.212913-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
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

cpumask_weight_eq() is better than cpumask_weight() because it may
return earlier depending on condition.

CC: Ben Segall <bsegall@google.com>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Valentin Schneider <vschneid@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 07b8f35cbe36..6bbd5e880984 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9234,7 +9234,7 @@ int sched_cpu_activate(unsigned int cpu)
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight_eq(cpu_smt_mask(cpu), 2))
 		static_branch_inc_cpuslocked(&sched_smt_present);
 #endif
 	set_cpu_active(cpu, true);
@@ -9310,7 +9310,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight_eq(cpu_smt_mask(cpu), 2))
 		static_branch_dec_cpuslocked(&sched_smt_present);
 
 	sched_core_cpu_deactivate(cpu);
-- 
2.32.0

