Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0020349748E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiAWSlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbiAWSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE35C06175A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:40:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so15465787pjj.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LzUduzolyZ+4xt2vAObi0ehcZor8t7e5g8GsVVH/1TU=;
        b=I3KQk9RairbI2xGbFTQyBvOz1r8XmtL+1VMHv+8xfIG0laBeuSNtG38Ni3Hyl9YL4M
         tYU9Sf/7ekYcztKvrRATglZw1d8PZGncVS4Rp3bAFA2DenPxej7qVnw70zkXgcXrFx5g
         1vGrqTWhPoydoQcCLlQ4Siqv/nNxaW+AzbY4JPfOB+R72HGbj3qay8HOiyb/wLh7WkqO
         aW4XGpT8J9XHyJ01oBonS/Jw0jZaJCUrqSsxVdnynxHPs3WM4X2INHUWlpNtWYRAPW5i
         OZ3hY/KwVxyiFP0uFF9M47OdXE73OymBsIpsxT0h9LbsC+hN1SbPHe93ikxnWjJ8foVq
         ZdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LzUduzolyZ+4xt2vAObi0ehcZor8t7e5g8GsVVH/1TU=;
        b=NLJZMZybQAOwPlvjmHTCPxXiwj/ClgSpXwCn5rISpFC/KKFO2cgcrNrfOtb/jYIUKv
         MdYFvy9tX1qatH1ST2g4qMPV2Eu8UmLGLwOGp4Mm0WWPE0el5v8v9KTwNfrHG/k0rvxr
         r52oWwfyZsJIojhGq89Er0NXEj/L+hUuFeCOuoPPA4CkL0OzCY1KUQs/Z/jpcrsRD5zO
         AYOW0YTPvZP1OX4MQ8dMxWyqv62TduiywTnLExZafZckhSB9lo3jI4Pq8IvEXq+gdZcu
         Ceu8InWGS+WKJZgG15cdZNAKbeKVz6kMzSsQRMeXX16ZP7CwlOpcGuoWx7NTflsuZ0a6
         hvag==
X-Gm-Message-State: AOAM5310iTePJFO/sLUNucfaGejgZj3NOSXYFd/LDHOKvikSbdr2Futf
        lwiS1hu6acocQX59NMDDnV8=
X-Google-Smtp-Source: ABdhPJxJh2Q2GUvN1TLZh6ILSvNRlzZ4CZKgjgsTzypxj1R8sL8XUzs0nMFTl1sFjrsuWNMxUZJjjw==
X-Received: by 2002:a17:90a:6c05:: with SMTP id x5mr8005739pjj.172.1642963251555;
        Sun, 23 Jan 2022 10:40:51 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d18sm13942816pfv.173.2022.01.23.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:51 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 20/54] kernel/irq: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:51 -0800
Message-Id: <20220123183925.1052919-21-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__irq_build_affinity_masks() calls cpumask_weight() to check if
any bit of a given cpumask is set. We can do it more efficiently with
cpumask_empty() because cpumask_empty() stops traversing the cpumask as
soon as it finds first set bit, while cpumask_weight() counts all bits
unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/irq/affinity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff8919dc9b..18740faf0eb1 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -258,7 +258,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct node_vectors *node_vectors;
 
-	if (!cpumask_weight(cpu_mask))
+	if (cpumask_empty(cpu_mask))
 		return 0;
 
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
-- 
2.30.2

