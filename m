Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D744497498
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiAWSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiAWSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:17 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7966C061755
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i65so13769829pfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HHGGgmQVmFZBmg7DQxGJPvdjEjZRhNrQASscNGanVdc=;
        b=EH/6cSa9YHoSM91y5ppgiQJWPTpXdG2h1ASsA1/BQXv7gF9h/mYO8png7AQzQ0PAHf
         j4VJRE+ZUXzbDygTfHwyInQ8nSymy4SRByDkAF5PbljjJssj/ISvNZYH57UV09qGoPuw
         LZVsthHIjt3JVJ4eYc5AcRvOlwzJgZ/JCdXft3FvsB0+UX3xKG761HQk0DVzrwArnBsZ
         CVChd9PanY0ZkBcfFw2y26HoT7nigXGb3ncN2czDrLbJOwgV/eFW7y26qkcOB48q3EWg
         IAPNxN9I+AUoD038aGCuWKHyG9dl08IJUEoVfXbWuGJ1h2E+cb5cs91xPZVVz2Qq4IBu
         /Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHGGgmQVmFZBmg7DQxGJPvdjEjZRhNrQASscNGanVdc=;
        b=Hu42dJwLJu1nN/t/ZKZkXJYkqI8AvG6k0gwGO8G+kJ106z8eGyMN3q1PWsG9GozugT
         kLx/WhJ0PB76SQFV5mxCCMs6y9VNQFjwzjflxXRShc9r1lXJvDJ9dOA4J3JlgduKb0pw
         F+6OBEMbMyq6LwGmnPeTyQbBlfXMquIhvTSVCjxnftQkVpnDYcoMZ7gUdU1Yem+AagR7
         U9qSXtsHN9zaqK2q+wuoZPxzaxoRf/rPqvEMCkzY7XTvrfXn3jllN5ni7/uxg6BFhB8s
         TIbWTTkxXuhcCifkpe86pSP3kx4wg6AtRaacSP+aBAc6fFd1Qsat4LO31GHDEmTSRo6w
         HcYg==
X-Gm-Message-State: AOAM531SI4pjG0YtSadLNCMS25iihL+WWHTHFclVso22x8u9s/Ce/VAa
        173so8/vBJtm05oy/hVRHxk=
X-Google-Smtp-Source: ABdhPJyY/FkXD5OW6boCRJO4lG8VZ8gHvKX7Ug3rqmHXPLFay/JetkbpKroBAMlbdm088ksQ2leZGA==
X-Received: by 2002:a63:a00a:: with SMTP id r10mr9334290pge.553.1642963276432;
        Sun, 23 Jan 2022 10:41:16 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id nv13sm4817821pjb.18.2022.01.23.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:16 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 28/54] arch/x86: replace bitmap_weight with bitmap_weight_{eq,gt,ge,lt,le} where appropriate
Date:   Sun, 23 Jan 2022 10:38:59 -0800
Message-Id: <20220123183925.1052919-29-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__init_one_rdt_domain in rdtgroup.c code calls bitmap_weight() to compare
the weight of bitmap with a given number. We can do it more efficiently
with bitmap_weight_lt because conditional bitmap_weight() may stop
traversing the bitmap earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e23ff03290b8..9d42e592c1cf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2752,7 +2752,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	 * bitmap_weight() does not access out-of-bound memory.
 	 */
 	tmp_cbm = cfg->new_ctrl;
-	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
+	if (bitmap_weight_lt(&tmp_cbm, r->cache.cbm_len, r->cache.min_cbm_bits)) {
 		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
-- 
2.30.2

