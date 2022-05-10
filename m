Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22652205B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbiEJQBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347258AbiEJPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:10 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80927CEB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:13 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id w3so13494728qkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzOa2Y6OHG3zOOzih/UHA/mPrL2daZ9U5xSUAySq5NU=;
        b=YVhCf3kv6LNcxdYGCaM/o5jNWq1DDbQfDYf/9LDqfd66iJk7/HfHCtJNlQiAQIKeZM
         87oKMPsmHN93oL4KtTqgJFQbFKzHw0V6h2LmGBrwzWvzOprPZEgRZD+MBCHRem0ivFxV
         jHqIEiKw11O06Ak3pj601EFWZgX+rUr7z1sudH+YjBYe32I1ZukX8vw99o7YtpaChpda
         dVCXY2yMJ0cZ2Xo1/IwU0vU8N9j4Obm21gk6VAFr+fuwK+8y+8d2oE4kgp3RnLKvu6Am
         L6gFw7fABYZU42euETFajBlYYWce93rcd+txWWzkD+TrA2yTyRIZzfg/TBGphP5FGdso
         CSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzOa2Y6OHG3zOOzih/UHA/mPrL2daZ9U5xSUAySq5NU=;
        b=6LLLTdSG0NTGB6qrWpCOFPlTz6etya7zXIRZ6hy/EDtqd1s5vZ0E10Pv7etlMX+yGL
         PLLKAscbBa2R43zC7xHkFdKScBVIl0e5CWuIbiRkRPOKVQUEtZ9vnG43gOujiYlH3zqJ
         lUD4FYbQMD9y5E/1NPOsxGXpaIQw/zM2U0S/+zMpHvo9OUUzRhM3aGk4s6g1y1lwsV5u
         CoBwSGtELEpEzd/J1AEnfXAnVkVhwPaKcLosOBcso9jARJJy9F+Ic26QRyUAdbe7JEMu
         R0H8EZAHGtay96ZLh7P1if2fLguwCivoAHqpp1DApy0+g4gORgT2LORTo0WYZG5tdgwr
         qR+w==
X-Gm-Message-State: AOAM533cHZA56K++nqhLln7EBp7zvH+qA0cCXuvlufEC02FSMAHh8Rf1
        lD2HnVets6mp3v6PUmfCWT8=
X-Google-Smtp-Source: ABdhPJx9CpLX7r2qnlTmMtmnvI9rvpGDbklOgnbqs5MleVgT3HRf2xKTGDSyanO7fV9Jdddep/WekA==
X-Received: by 2002:a05:620a:9d2:b0:69f:c168:7a35 with SMTP id y18-20020a05620a09d200b0069fc1687a35mr15982489qky.575.1652197692368;
        Tue, 10 May 2022 08:48:12 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id g15-20020ac87d0f000000b002f3e127be41sm2487642qtb.20.2022.05.10.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:12 -0700 (PDT)
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
Cc:     Yury Norov <yury.norov@gmail.com>,
        Balbir Singh <sblbir@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org
Subject: [PATCH 13/22] x86: smp: move cpumask_weight() out of for-loop in remove_siblinginfo
Date:   Tue, 10 May 2022 08:47:41 -0700
Message-Id: <20220510154750.212913-14-yury.norov@gmail.com>
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

Because argument of the function is constant inside for_each_cpu()
loop, the cpumask_weight() does the same work O(NR_CPUS) times, while
it may be calculated only once.

This patch moves cpumask_weight() out of the loop and replaces it
with cpumask_weight_eq(). While here, fix comment format.

CC: Balbir Singh <sblbir@amazon.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: H. Peter Anvin <hpa@zytor.com>
CC: Huang Rui <ray.huang@amd.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Paul E. McKenney <paulmck@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Sean Christopherson <seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tim Chen <tim.c.chen@linux.intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5e7f9532a10d..7d948f79ef31 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1605,13 +1605,14 @@ static void remove_siblinginfo(int cpu)
 {
 	int sibling;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	bool last_thread_sibling = cpumask_weight_eq(topology_sibling_cpumask(cpu), 1);
 
 	for_each_cpu(sibling, topology_core_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
-		/*/
+		/*
 		 * last thread sibling in this cpu core going down
 		 */
-		if (cpumask_weight(topology_sibling_cpumask(cpu)) == 1)
+		if (last_thread_sibling)
 			cpu_data(sibling).booted_cores--;
 	}
 
-- 
2.32.0

