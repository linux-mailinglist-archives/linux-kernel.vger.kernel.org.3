Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89349748F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiAWSlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiAWSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEA7C061771;
        Sun, 23 Jan 2022 10:40:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i1so3819214pla.0;
        Sun, 23 Jan 2022 10:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mN17EzppG4ynDyxtSQ4OI8cPa8nEXu8EGM7JWhlGQJ0=;
        b=DPUMC+f8vFIQ4C+keKENcS1CZWerPnD3IRPXyE6h/2QcbBF/Wu0tlG5aDajxt2jKzz
         R77TXcmefxVIyjDUH0SbTh1R81w3+ZjleGO8L8GbGqNycuZPsi9R1xIoeZU6CxcA52bW
         kuMsn6KUX3+efxJQKY9q9xe25lwJeLNjJYypvJ4iwlen2xiBcr8fBQRpJT57a1zbmNqq
         ZEolRzFj16zWoBqUTbH6ftmKyfB4GX6z+03CiemxUY6JVGCfhyyq0eIzS6jeVIzyBiVs
         6CiqnsuFmHULvTE5lW9PsqmKJNLema9/DCoXl7ozQltvAJZFoFsPhbte6bb5pEylNiMp
         kfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN17EzppG4ynDyxtSQ4OI8cPa8nEXu8EGM7JWhlGQJ0=;
        b=O0Eq5RmckDujcjRofgLWxeDiwuLp+jNJ969g40g8wfYPf1N1sSIVIgtMlAqFHCIE4a
         Pv43TIm8jo0bUmhGZwCPglf8xdH9JbZDuYS+NB7GcHCLcooa6kgkZ/uGrXnIMPeXrH14
         lIWPCiaqlpIlkEjLSA8d/PjPYoXTN05DtzJ3RTCNWh67imefvcm03yka0oLTfRiO0YWY
         xEDoJX5Fhh20HvQuzYhZIrtx24fh0efjjoRKB/PfBGxhVp1RKv8f/DGSvHAraLICqaPO
         0wwUcbyn1WCLx44rcQSJdxUk04tDAcK2LelSkXtvAp1MEQDSQn7EjGAf3J4N7Jk/1DDD
         78oA==
X-Gm-Message-State: AOAM532hBgbZr9t7jtGSkjGgvQEDDjIzaBuR0UARZKwhlaq4pw7mBLON
        cjLLKysHsSUSYE2msrM6HGg=
X-Google-Smtp-Source: ABdhPJz6lZ1os7HUxApPqwpmn5620+izBGVNFDoMgaNBOkggq3kvy803tDVOr4KKVQpxK2I/EoWfqA==
X-Received: by 2002:a17:902:ed82:b0:14a:9ad8:a146 with SMTP id e2-20020a170902ed8200b0014a9ad8a146mr11639698plj.55.1642963254650;
        Sun, 23 Jan 2022 10:40:54 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id t2sm9752456pgt.12.2022.01.23.10.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:54 -0800 (PST)
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
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 21/54] kernel: replace cpumask_weight with cpumask_empty in padata.c
Date:   Sun, 23 Jan 2022 10:38:52 -0800
Message-Id: <20220123183925.1052919-22-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

padata_do_parallel() calls cpumask_weight() to check if any bit of a
given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/padata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 18d3a5c699d8..e5819bb8bd1d 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -181,7 +181,7 @@ int padata_do_parallel(struct padata_shell *ps,
 		goto out;
 
 	if (!cpumask_test_cpu(*cb_cpu, pd->cpumask.cbcpu)) {
-		if (!cpumask_weight(pd->cpumask.cbcpu))
+		if (cpumask_empty(pd->cpumask.cbcpu))
 			goto out;
 
 		/* Select an alternate fallback CPU and notify the caller. */
-- 
2.30.2

