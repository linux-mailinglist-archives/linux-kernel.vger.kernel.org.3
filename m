Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AA2497495
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiAWSly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbiAWSlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012D4C061765
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so13568216pju.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/VgvGoSrjM7RHhvz4oz6UhP4t05IzW+FafmG/hxmK+g=;
        b=LtksDaUoKFgi6fsMPm0LDpUgQbJ1garCGl3knzuF4lCLaZ3c+Yrsn7OJJn4xT3yZMz
         qsEjgH5T23Sp6vKj0Xf98AkY37c6l52KvNWIc9u+gUXjEquq5MdjBegeB3QhUjG9VeoK
         kHMzkjDe3KwpVy01jvSDVT4RTAFNuKoRpg9WQ+bXRSqKI7x3EREi1itGAmmnmMX9zyAb
         OgfvbBkheON1V3OLU/a7FTndsUWqMzFAPMeI5mkD9gnX41YSkLDgoF6gMv8ptI1H9ksB
         gq+VEGbDrkrXDa2G0Fs0rQSEvAOsF2abSE0i4tOqxQTeF+nuNpz4uuApyqxnnvsc2ctR
         mUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VgvGoSrjM7RHhvz4oz6UhP4t05IzW+FafmG/hxmK+g=;
        b=ZrxLW4dY87+plWGg5teMhR+hj2Y4dR1xeuxNvv7fd4MpmO28zgahhxxMms9P7L+W4I
         HHz7WvIfkMM695j2+fmmKBPNHDEYlJdbaCdQHO3wV22tgPkhQkCqQxC3GwziGt6z7UHe
         LVhLAvtsCHhpoI/PJigAt3bdLrBumoHbr9jrwOcarFaTps4t6YEsKuOFn4LVr0AQdJvM
         G8CyHBo5UMedSvpnD8FvN9DPtPZo2XsmaLT7vi+/a6QRPP6bLchTQRMx+PjTky5V1+sx
         Y6q/r8WFPC9CCsPsp3couLf35zQtRiLgSGwGT3ZRLss9YVtpGplEsK/DkiRjcuxNSC+x
         hvQw==
X-Gm-Message-State: AOAM533nogohVX8ybw0z9EAsqfn6D4XLTKmUUrRomjJV0FbWO5ijAGtn
        UkVfNEzHIbIrUdM05wGubkE=
X-Google-Smtp-Source: ABdhPJxM5+OvTM7zV5jkK8eH28BzzoNvH/Nv9KCuB2FTZ9Fcl9QZ0o8NEWTqi1guXckSoVXq6LTshg==
X-Received: by 2002:a17:902:b489:b0:14a:4747:9917 with SMTP id y9-20020a170902b48900b0014a47479917mr11450174plr.26.1642963267529;
        Sun, 23 Jan 2022 10:41:07 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id l13sm10214049pgs.16.2022.01.23.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:07 -0800 (PST)
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
Subject: [PATCH 25/54] mm/vmstat: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:56 -0800
Message-Id: <20220123183925.1052919-26-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 4057372745d0..f56f11e3eef5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2035,7 +2035,7 @@ static void __init init_cpu_node_state(void)
 	int node;
 
 	for_each_online_node(node) {
-		if (cpumask_weight(cpumask_of_node(node)) > 0)
+		if (!cpumask_empty(cpumask_of_node(node)))
 			node_set_state(node, N_CPU);
 	}
 }
@@ -2062,7 +2062,7 @@ static int vmstat_cpu_dead(unsigned int cpu)
 
 	refresh_zone_stat_thresholds();
 	node_cpus = cpumask_of_node(node);
-	if (cpumask_weight(node_cpus) > 0)
+	if (!cpumask_empty(node_cpus))
 		return 0;
 
 	node_clear_state(node, N_CPU);
-- 
2.30.2

