Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21EB4974B2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiAWSnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiAWSl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED7C06176A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o64so14143486pjo.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a9TYPmGPsvgwUeMF0miMOaL4P3BFvKAG7ZDEborhqcw=;
        b=eQqSkdKb/R0sdmnpZUtNk+VSO8leZXruRoP6mdzgnjc+ouKL+ERWx3kc4JV3KSIcaj
         eSiZXZgMTwjIj3nzNC4k+VdtedXL5cZQm34+Lp95+RC3OVMiiSxNaZVTAWc+/mr4jaQK
         N7n5p4X8aPBCbwCtXVqyejJ/GU7GOtsLQItb1fzji1JsiWi2X9be5jD08yNGADBhKpP6
         9uGhHlVPV2JBdvVTmM/xVmt4DnAzfsy8AbzezIOxp4VL2azg9y5gjX1na+vR/dO0pumv
         IGb6zPvP5CX5BbGNKgZKsvq92ox1kQaQPSa/xPFNYwVJCQ6CUkkc9+2/234v3BpZSlrJ
         iSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9TYPmGPsvgwUeMF0miMOaL4P3BFvKAG7ZDEborhqcw=;
        b=mURZEtLXzwpbVLoAeZ3bARliY0A/DLwQKyuIZmAGKKEMtGlitVOKCPSw44N3SemaRF
         yWo4IsGvd/hn6oFqsiucnoH4XtCq40LlHLIuu2vMXfrK4ADgr0/pXHuwVgMMWzAqwTm4
         STxu0WPHIPX+g/aFq9N7bIuf1e6DDEB/vEDBRGSaiMqariHwmM/L6ikcIbs4+RnB7SiC
         HHxCFk9Nxe/+MY0uqMtRwQ2x6+tPuY4FRnEktcYpQ4fS+weHS2UVgc3f7IXz+pAI/8zT
         imB/m7sHCrC0v3PlcHtn1y7675Zs5Si+EcURa+iCEOrMAB4JekcKdQ03vhxdn7Zkenf8
         AC8w==
X-Gm-Message-State: AOAM531IZ2ViymrW8l2fFPtjWkVh7I4EuzS9zc73J0ZZFTjXFiKKNsGe
        +PASH0kkDwRViA20MgcS/Rw=
X-Google-Smtp-Source: ABdhPJwJ4wSV5vrFBDblt9Iik5xdBLS1XzYEZG8To1B2j4sSumFwtdIheE1VJnzdPK6bALklB0q0Cw==
X-Received: by 2002:a17:902:b10e:b0:14a:4a48:cac5 with SMTP id q14-20020a170902b10e00b0014a4a48cac5mr12003272plr.16.1642963316358;
        Sun, 23 Jan 2022 10:41:56 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z14sm5257693pfq.3.2022.01.23.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:56 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 41/54] arch/x86: replace cpumask_weight with cpumask_weight_eq where appropriate
Date:   Sun, 23 Jan 2022 10:39:12 -0800
Message-Id: <20220123183925.1052919-42-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smpboot code in somw places calls cpumask_weight() to compare the weight
of cpumask with a given number. We can do it more efficiently with
cpumask_weight_eq() because conditional cpumask_weight may stop traversing
the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/smpboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 617012f4619f..e851e9945eb5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1608,7 +1608,7 @@ static void remove_siblinginfo(int cpu)
 		/*/
 		 * last thread sibling in this cpu core going down
 		 */
-		if (cpumask_weight(topology_sibling_cpumask(cpu)) == 1)
+		if (cpumask_weight_eq(topology_sibling_cpumask(cpu), 1))
 			cpu_data(sibling).booted_cores--;
 	}
 
@@ -1617,7 +1617,7 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
-		if (cpumask_weight(topology_sibling_cpumask(sibling)) == 1)
+		if (cpumask_weight_eq(topology_sibling_cpumask(sibling), 1))
 			cpu_data(sibling).smt_active = false;
 	}
 
-- 
2.30.2

