Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278DD52206D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbiEJQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346666AbiEJPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:53:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845E22BF3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bs17so3927567qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+Ob9aaMTI9Q+iaXKEuKQQeHui5qUx1+hsZMR4tLjS0=;
        b=m3JS2xWyHZGT8NFfxmxtIl4Kh3WtP3p6ktBysoXoKHQZfpMSS9mj954iRRts2BK+4x
         5V7E5hhsNujN1HE8zQf3BHFx1jVQxVL+bxJuXYr+VOSXa6/Z7UImjZDP5QW4s4KLQSGK
         O7ntbMP8KnCG3UuHo9UfUeBGDeg2ZmRlt27poMwOoedmk9qHCjOAiyBFhNS+6u5OfNiB
         x8kBJJnNjkDuLTj3HJOhxJF0WYU/EflANRB7UiVs3ebeAqc3iROH9kbT7WxXa7cJSARi
         bfohBsS4MHhavuITe9Vnw034NHl85wD+fvOAN3sngzOFJ9q5K+SKxhlLW1RwJcdoNJWh
         MBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+Ob9aaMTI9Q+iaXKEuKQQeHui5qUx1+hsZMR4tLjS0=;
        b=rv1DyD3ZvkLqjVqXfWnuZrFE12RkR97Ghgfhjcqare3woqIwrChOGQ5tELlzPVSS9i
         uLXsGNNtBl3aMNWhpui99aVtbS7ubreNu+kX2Lvzem8iDQDVpetn5r/0iyz510xstmmd
         etIRLIewxo/jvrsA35rFLSfTKS8NQv7m94+Nwc0VNHJ2Ad6u6YcV2ddR0THb/NUAcfZ/
         3Lb9w4DN/Y21t2GQmmqLqe3KRB05AESwjH2LJwuO4SDZAD4R3ZgumVq3yPeRkB6cWGdh
         /SJbzotk3KBmD689xOPbB2vQDbG47UCk1YXHnuAnDMrOg6Z5+7YpJ7q/kP8QfMUCYsO6
         qOig==
X-Gm-Message-State: AOAM53178kEBuoCGs+/29ZygyRm0NoXwO/CTXPIIRHx3YXTVUoHmcZXs
        4PGDYu6o+T1sT09UmHicMck=
X-Google-Smtp-Source: ABdhPJy7WcqEGMFnf1b1ICGoUibKPJ7NRXwYXnzdxR/WUgi4c3o3Cpj0wm14DTQWFGpYYDNwuZqdgA==
X-Received: by 2002:a05:620a:4142:b0:6a0:4a07:2027 with SMTP id k2-20020a05620a414200b006a04a072027mr14025416qko.517.1652197713811;
        Tue, 10 May 2022 08:48:33 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id j133-20020a37a08b000000b0069fc13ce1ddsm8907813qke.14.2022.05.10.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:33 -0700 (PDT)
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
Subject: [PATCH 20/22] sched/topology: replace cpumask_weight() with cpumask_weight_eq() where appropriate
Date:   Tue, 10 May 2022 08:47:48 -0700
Message-Id: <20220510154750.212913-21-yury.norov@gmail.com>
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

Replace cpumask_weight() with cpumask_weight_eq(..., 1) because it
may return earlier.

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
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05b6c2ad90b9..860137913b18 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -168,7 +168,7 @@ static const unsigned int SD_DEGENERATE_GROUPS_MASK =
 
 static int sd_degenerate(struct sched_domain *sd)
 {
-	if (cpumask_weight(sched_domain_span(sd)) == 1)
+	if (cpumask_weight_eq(sched_domain_span(sd), 1))
 		return 1;
 
 	/* Following flags need at least 2 groups */
@@ -1999,7 +1999,7 @@ void sched_update_numa(int cpu, bool online)
 	 * Scheduler NUMA topology is updated when the first CPU of a
 	 * node is onlined or the last CPU of a node is offlined.
 	 */
-	if (cpumask_weight(cpumask_of_node(node)) != 1)
+	if (!cpumask_weight_eq(cpumask_of_node(node), 1))
 		return;
 
 	sched_reset_numa();
-- 
2.32.0

