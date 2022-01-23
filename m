Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2325549747F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbiAWSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbiAWSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:42 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318BC06175F;
        Sun, 23 Jan 2022 10:40:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so7872549pgc.1;
        Sun, 23 Jan 2022 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KWn9RMzA0EUrBxcMa6INAn/WVMY8I9S/vbZ+cvBsro8=;
        b=FEY4hkDCe+Bsb7dfhGhUPLZa3Mw0PtBQkOfweZG+4g+/AQd4KD6MMYPm2IDe5hdOX+
         dkS3dA+wGDjARWWN5zO+u2yDzeYbGG5IN02WiGuELJoafSGPci3NnnLTdh9I8IhX7fti
         IpZ5jdcKQ0bOMVbXM9UFM6PgySOQy8PN/gr/8ncHmWzSzsjnyDIxkh9Zl6kXWPt+9/JC
         EfexkcP1u+e9NGbS8fqX0N1v0PcG40IfxWO1qSi6HVNUzwqETgbERn2BGZG4SW3pKOSA
         LnMk3qdAMIJw9tW9NvT+99rYqWeMvl91UnjK3COqKpRkCgyEYPdAn318dKt59hcjMA5Y
         Oj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWn9RMzA0EUrBxcMa6INAn/WVMY8I9S/vbZ+cvBsro8=;
        b=sPOPwlZishlFtZKSSIkea6+dos7H9o88E6jperQcZg8nv4sm9ou8fTgspNg5bWBqEx
         FWO/KVoQSBA1JPII5qHBh+xufOWa15+mh6nRpaHFRk2a1t+XVltkJz+fNRxRx71ucs0e
         kTbk3tfKeXJhOYVifCIm3hSq80cxnt/h43p969ztzcNYDxbCzumWNxfNVAM9K8KmT7Eh
         oIr92xPu38rppGv5fGka05S5FuH+9BIFCxqS5nd+6djpM3XpePFqYRluVejFATc8wydN
         S2EY6apwUsaVWahcQpXf6khTV3mGruSpI/h2gU6jtsT4oJ86jdnuUlkx9KeNnqziMVii
         zlPw==
X-Gm-Message-State: AOAM53031B3Ivz7/kcJqZbIlfGqcBbBJ9kk9/4fRf1wG1FNnJALNKk3z
        Gj4X017ekgk7bskuKazRFvY=
X-Google-Smtp-Source: ABdhPJwjqrtFluXvvrz63pW7odh2ArGWcrHPjVu1LB3+cE21kXqVjNBk4w7GSgYFMwwe6AGVJYJ/Ag==
X-Received: by 2002:a63:2d6:: with SMTP id 205mr3524267pgc.64.1642963231993;
        Sun, 23 Jan 2022 10:40:31 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f9sm9845631pgf.94.2022.01.23.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:31 -0800 (PST)
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
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yang Guang <yang.guang5@zte.com.cn>, linux-ia64@vger.kernel.org
Subject: [PATCH 14/54] arch/ia64: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:45 -0800
Message-Id: <20220123183925.1052919-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_arch() calls cpumask_weight() to check if any bit of a given cpumask
is set. We can do it more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/ia64/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 5010348fa21b..fd6301eafa9d 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -572,7 +572,7 @@ setup_arch (char **cmdline_p)
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 	prefill_possible_map();
 #endif
-	per_cpu_scan_finalize((cpumask_weight(&early_cpu_possible_map) == 0 ?
+	per_cpu_scan_finalize((cpumask_empty(&early_cpu_possible_map) ?
 		32 : cpumask_weight(&early_cpu_possible_map)),
 		additional_cpus > 0 ? additional_cpus : 0);
 #endif /* CONFIG_ACPI_NUMA */
-- 
2.30.2

