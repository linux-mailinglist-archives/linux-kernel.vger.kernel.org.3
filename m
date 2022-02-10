Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE34B1969
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345640AbiBJXZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:25:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345626AbiBJXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:25:01 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F009C5F59;
        Thu, 10 Feb 2022 15:25:01 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n17so9423204iod.4;
        Thu, 10 Feb 2022 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LzHqTGHmePwb1HFpWGG6zaHocU/Khr4mZgW/QCywhtg=;
        b=KoLazyQAnXN19qSU6nxWkSGgxQn6EmVBtr3qzwTfLRB+aGELf8bGFJhozbakQx1iEk
         PUxM6wzuTaKRHeTsIZprdOuj6sqTkkrYzDIMDi5E8i7nYXpUhdzxEBwdiYaAvlDeIx1t
         96VWVZ+975D/8O5jcAhI/mVegz8gGrktTeM2drEHa2GwMOUrikKDaXM3igq7417lQ3Lj
         Jlv8mrTTijUYUii2uunxvnpSZ4j+jz0TmvY27ElurL8V93UVXEPTvPxECxkFrNgnQ58g
         Hz5kP7ojDYf5OqRMRQows6fd45mycpx9LVjVxidT4apDBoraMBdlb0hNqNhzz/hXHq3S
         uPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LzHqTGHmePwb1HFpWGG6zaHocU/Khr4mZgW/QCywhtg=;
        b=2TI23dzxDGHKXONlvezeJa1UxDOjY1qKuRJNt3DTSURK8tvyvqwo41jgrZ1oOdRUrX
         cXlitWvv5zi2GksCFT2uSjZ3sIeDVBs/LDe0YnIY76v6sfQhgXOEFnwSoVROSeSH1YUa
         VNCxxNuepqeDBP3VAFnRv1lP/3hBW5j70l9fZi23DeM7Nr5nwkb9NEtEA5VYwbRiU9v1
         b3N/ZJYgew28mmEzLu+E2o+O+P/OBKSogz1mBUxzalGz2bl6151MAmAAQ4i9RYNnqFTq
         V/tbXkj4viRviboJs7YP9tuPrA39Z2WdHynNkLfwI0qkPWTmNFhoVE4JwtpS1tBnYNPk
         vnRA==
X-Gm-Message-State: AOAM530h3Kg2DMQiaFVPWRItpCgNzm94r92+wXYQGnNEvJKBWryIgCD4
        oKVp/evGmKFOB+ED0RN6Xxl+MJC0xwQSOA==
X-Google-Smtp-Source: ABdhPJzO7Wh2ZWhAjGAIU3578tz0nBbH5iZ7BL9c68JQSZumb6v58jDO8OJm/FlZeMxdi0nFwkVgBw==
X-Received: by 2002:a6b:500a:: with SMTP id e10mr5030200iob.157.1644535501349;
        Thu, 10 Feb 2022 15:25:01 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id k10sm487246ilo.8.2022.02.10.15.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:25:00 -0800 (PST)
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
Subject: [PATCH 15/49] arch/ia64: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:48:59 -0800
Message-Id: <20220210224933.379149-16-yury.norov@gmail.com>
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
2.32.0

