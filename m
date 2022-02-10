Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D324B199F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbiBJXiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:38:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbiBJXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:38:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898255F64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:38:14 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i62so9480612ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9n2DdSbneN7v4fxKizWFeu7+3tSFKKa+21duzKl95Yk=;
        b=AK2McL5crq3P5W/HMrl+HVMBiBdnvJJs/I9DFxsN28iywuaN2UqJNQpufEM/5yB+NS
         WM8Ah7v54tNxhaygGs78Emy4tgph4sPVpst0aVD0SguR55ocuOu/qsF08EpW0Wo6U1tk
         qpnL9Snt8YrLfZRyjPxqcx31oSV0Szk7umC8BTcBZNlJIlKF5M44te4ICNt/Vq+7Ofls
         sv9Wi7ie72uM1j3zsENRKACYxiKCrC+kQFAKF4OXcd25TcneaY+BVbKSZq1hYZ7qX2Hh
         lQVNwMxWZZsr0i3Zg+dYucoa5y4DOQy2eMNRoLj/XhULZxe7PEV/GOvG2TIrXHiLtJi4
         nb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9n2DdSbneN7v4fxKizWFeu7+3tSFKKa+21duzKl95Yk=;
        b=XcyNqCB0i7E1jOgntG7qJ/GD89w4EX4kPLiwd5YZA7c+K2l/xM5o7xZcVsmwtNpJkS
         Omwy8Fx2I9Yc0KtT2cCuve0XVYYIktVILURUoymgwrjxN1PBP/rZW0/mNazdd2INNIZh
         tNVBS+akdnrKrISOxEpqHjgEdfd0hkhupaW/vTjaslc1dhZRXtHPhWocXVLm3qX+v9D2
         gcnUZ5P+D91AgZ6alRWKBobkXyIRVeq4oyWgmv3PZ39Ur4ZTBJoNpEUSx3HKZ3pYumG8
         6RNMZzsOdJkO8qW1W56OT47GWVRVScdcCFrr/BhHT2e7kcf3eO8dXNyZqtYF1mWI5Lz4
         MVRA==
X-Gm-Message-State: AOAM5306QP8QAhjXzyosn4qdYtk4hyXiTm/MWweCLxMy0JLNmrlQ+l9z
        PhSYKxg8kBtT+Dx8OAzPqOM=
X-Google-Smtp-Source: ABdhPJwQ659D3gO5ecBLF2AX0FyOLgCZ61yewOIUm7N0UW53PsKRiHqI+c9w8ufSKRcbdtxUOYhoAg==
X-Received: by 2002:a05:6602:2c08:: with SMTP id w8mr5090325iov.182.1644536293918;
        Thu, 10 Feb 2022 15:38:13 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id i30sm4549007ila.32.2022.02.10.15.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:38:13 -0800 (PST)
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
Subject: [PATCH 21/49] genirq/affinity: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:05 -0800
Message-Id: <20220210224933.379149-22-yury.norov@gmail.com>
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
2.32.0

