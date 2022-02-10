Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB264B19BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbiBJXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:44:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245292AbiBJXov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:44:51 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFCF01
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:44:52 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j12so7284895qtr.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kme7HdDPBLdZ4YQtPbT4M8C1s/pmrIz1qdi0gwByHEo=;
        b=Bk7rx9gKhdGsR9i8jgVS556YE2ujf0DSOvVCpTdc9PT65IOYqaQn9aot/Y9Xwof7ki
         cOnVYvWJbPeDast2MgmpVU8Y4Imurlc5MhQl99D0snMgl+6Gu4ehybSGgqRGOefPOoBX
         5PEfm69qkAlLEYPK6MkW0jclxUqt7bd8ulqPZGiRaFYvX9dZSOUqEUCbmBDOYFYCflDj
         g0rF49yNULJKrkgSYVUWolWWUDbQHWS3s4jqHjk5D/DAtrm+AgzV8WvsVC9KB33nSjTz
         AtmQPfPBeTjUMZLE49hquJI0Dt7lAFl1HT2b050DpuOl8+hOzXAF14k5nUPeiK20UT0y
         Zq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kme7HdDPBLdZ4YQtPbT4M8C1s/pmrIz1qdi0gwByHEo=;
        b=8NMMxHdqzyP5UXIcQ/EXyYFLfZ3t/IR7pXZPCfgAqWdznms6k1zhZ18X/sglbcf1Ev
         b/VC3GlQ4A8V3Mhjk0zrq3eOqESlGreUOikpcuq63e0ZFLrQ1ZbiVi/D5+f2vzjqonP7
         YFm8Agoei65WwOD8rrdtrsdLA1AAnWmse7p6T617XDv/gEuIWaccgQ3HVeMBxq0sNMFu
         kw1FUxzVvUnZxaBBMNjrRihE8aL/PthtN0j5LRPgYAnljMKXrRmNZ3HGLQrIj3tRWOad
         C9rpszFzRY9mx2AJc9dP5YOTrh3M2rnbm7Z9CgSqO464KDkEWEWLqHt3hpc/MZhJp7uk
         PRog==
X-Gm-Message-State: AOAM532OkOP93G0gn0SkWD8MIqyJBBX0PRxo9dCFGvpM0lIvltUR19yk
        cmc5TtLOOCc/TJHyGrj0Ut4=
X-Google-Smtp-Source: ABdhPJweRk+ewB0DrkLNcDIrsEhPbiqs1Kx+pnRXJsHT5Dn4ekm9Sd6GVVslYeAffagwYjFFuj89hQ==
X-Received: by 2002:ac8:5711:: with SMTP id 17mr6533353qtw.287.1644536691131;
        Thu, 10 Feb 2022 15:44:51 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id w10sm12500893qtj.73.2022.02.10.15.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:44:50 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 24/49] mm/vmstat: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:08 -0800
Message-Id: <20220210224933.379149-25-yury.norov@gmail.com>
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

mm/vmstat.c code calls cpumask_weight() to check if any bit of a given
cpumask is set. We can do it more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 mm/vmstat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index d5cc8d739fac..27a94afd4ee5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2041,7 +2041,7 @@ static void __init init_cpu_node_state(void)
 	int node;
 
 	for_each_online_node(node) {
-		if (cpumask_weight(cpumask_of_node(node)) > 0)
+		if (!cpumask_empty(cpumask_of_node(node)))
 			node_set_state(node, N_CPU);
 	}
 }
@@ -2068,7 +2068,7 @@ static int vmstat_cpu_dead(unsigned int cpu)
 
 	refresh_zone_stat_thresholds();
 	node_cpus = cpumask_of_node(node);
-	if (cpumask_weight(node_cpus) > 0)
+	if (!cpumask_empty(node_cpus))
 		return 0;
 
 	node_clear_state(node, N_CPU);
-- 
2.32.0

