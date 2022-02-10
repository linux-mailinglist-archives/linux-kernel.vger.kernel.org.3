Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46D4B19B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbiBJXmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:42:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbiBJXmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:42:40 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BA4AF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:42:40 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h11so5659016ilq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IfuV7BErsL/W0NpxTgurt/IeS+0DSJusaRrjkOZT71M=;
        b=V/sbZHygSE1dk4L3f+z50ccoEdc9sz/a/RRC4yulJXVwN6WdNnOhqjtQ5cK1rlbwpC
         mMMvV3GAPff6zbHgTIblif68WqzZegiNCcV8+EvQkiKppnfLw1/wFAQddm+MAuLz5hKn
         YJHfx/spl1RzxGn8l+lCGkhtEkCZryEYEk0XVL5UsN/rJX43G+VBpRb5VlBtQ3Lld4eW
         d8i3QirNuscL7GPG9HtrTU50V0QMM5olYoLQ6p/BehBgEqIM2qWzD8Fuhisb0Xfn+I4g
         z7bcSzNOZ2Ed+7oZBLJNvnIiQ1G9MDl6KXspbq41/2Cq6r94bgtfU6of+oGXWHNlkEKr
         zs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IfuV7BErsL/W0NpxTgurt/IeS+0DSJusaRrjkOZT71M=;
        b=JPbxmK5ScKnLqplFNg8upz1WZs3Had6Go2Cui/7FgL/o1SwoXJgnfou9ZhJ3PniOnF
         PT25qEVOiG46LAXNASoIY7GcGL0sL8fPI6+lOslet2c5Gh3VU3NYf83nI87Yj1JAdq+K
         ZZuVTjlAqxOk3pLAolp5W4Xa4cZJWKQCRwgcUmd1KmecexCaeXuyiX5XD8DvDzXi+rqA
         IBN9zfYt8R36Hz/vXOu/cyrt68/hbjCa0jApRithOH5lfdeIjwULsR0Y2kvL8IIBckHk
         SouFizYFG8P9yLuaAupHLnZjt6e6DGzlFR/rAMonOxLGOusTdfAaHgEXyw7711RFSLYJ
         S6cg==
X-Gm-Message-State: AOAM530dpx8NEU2czQRHdW5uxB76cIloO7sd5vSxJO5MH8UJw0XW17oN
        HxW+bjfj6b0nf1bhtCpeXnA=
X-Google-Smtp-Source: ABdhPJyMCRQgDaf6eA53pG3YvPxmIVTNvMprTGUlUaqGwilmflBxGPm7MqMOwsRkroMJ9y4fsTf4uw==
X-Received: by 2002:a05:6e02:1489:: with SMTP id n9mr4735605ilk.49.1644536559934;
        Thu, 10 Feb 2022 15:42:39 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id x10sm3286383ill.60.2022.02.10.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:42:39 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 23/49] clocksource: replace cpumask_weight with cpumask_empty in clocksource.c
Date:   Thu, 10 Feb 2022 14:49:07 -0800
Message-Id: <20220210224933.379149-24-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

clocksource_verify_percpu() calls cpumask_weight() to check if any bit of
a given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 95d7ca35bdf2..cee5da1e54c4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -343,7 +343,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpus_read_lock();
 	preempt_disable();
 	clocksource_verify_choose_cpus();
-	if (cpumask_weight(&cpus_chosen) == 0) {
+	if (cpumask_empty(&cpus_chosen)) {
 		preempt_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
-- 
2.32.0

