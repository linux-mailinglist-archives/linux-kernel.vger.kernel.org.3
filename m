Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4635AC62A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiIDTad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiIDTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:30:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C42D1E5
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:30:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u6so8860144eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eQ0wwoXomODSOHYfgmsXCfhMZdEoQj3yqUmJitWV+MQ=;
        b=dXf4c/Tzcv21P7fD7Ag0pnDRZGDqOOvgqeSFm7p5NydAwk0eeYidMglHZG6La5CcuP
         cXmjT/zX9XjkKGxugoBnRBDK8XvkdNlvheFsKmt5NYQQ+TihcQFKEqJwFPI3ybO6QehM
         cZkvvHrai8ymubn/Cq0EiOWlaiuU/8F0wVZwzp8PYg6FQVq73v5jmEifPHNJIDPqDAqn
         lhfHM7AYkS5VrOedXeoWQTC83AiuALgmYT+GRCElFLLme+nZSZRO6NWpF24GlsYgDpho
         DoHsGkjmXWjs5U3CK8N5CBtSSa1EhhSq3qnljm07nJxJK947H2zE1qY2X6byioIrTuqO
         5Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eQ0wwoXomODSOHYfgmsXCfhMZdEoQj3yqUmJitWV+MQ=;
        b=yPumeC7KlFYpr2qjHUDY20rq2nvHtKFZEQjXn4bL1AjBm7FwuBNlUvUifJ7aiQcaEA
         U6h/+5cbfpSpuNKiA7O9KF2WSaQXn2TNmyYOxic5dGlfyrjzn6nGyfDkhiKKVu8dVObu
         n0jvYtiXKDl7IB5o9oRxXr1ifa14vSCPyBAvzs9n0qFy87jceBz2tkEpS5DoDSnXd5ID
         vrbg35dvT3/mPLGOETkPJmO8W7+PKwuxH5hoKnmWdLxFTWn0Agr+3mLrxVKf+5P5HMx9
         rh1BlEIKeuFAyZrI7HGredAZ6NIgygq1sn6E4XOrGTQc7PS65e07lg0WJ66MgUL4/JuU
         PF9w==
X-Gm-Message-State: ACgBeo2AAwxWwuXlhRAQF/WMU8J7lE1UZb+Zv7LwJo1ajG7FjusJ+woR
        Ir+o5iEqiHm5OoFk1L+oAtE=
X-Google-Smtp-Source: AA6agR42ZNV+5bPUSS4sIWh6RcAfYnOjDyIHLz+jgojN92I7FVTj/urf2/e2hnAWd8S4BfVxtui/6A==
X-Received: by 2002:aa7:da86:0:b0:44e:91c8:eb4f with SMTP id q6-20020aa7da86000000b0044e91c8eb4fmr551279eds.252.1662319828656;
        Sun, 04 Sep 2022 12:30:28 -0700 (PDT)
Received: from jyo.local (dslb-002-205-066-233.002.205.pools.vodafone-ip.de. [2.205.66.233])
        by smtp.googlemail.com with ESMTPSA id gz28-20020a170907a05c00b0072b92daef1csm4095170ejc.146.2022.09.04.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 12:30:28 -0700 (PDT)
From:   Jeungwoo Yoo <casionwoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Remove d-cache clean operation at preserve_boot_args().
Date:   Sun,  4 Sep 2022 21:30:19 +0200
Message-Id: <20220904193020.65556-1-casionwoo@gmail.com>
X-Mailer: git-send-email 2.34.3
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

Kernel expects only the clean operation as a booting requirement in
arm64 architecture [1], therefore, the kernel has to invalidate any
cache entries after accessing a memory in the booting time (before
enabling D-cache and MMU) not to overwrite the memory with the stale
cache entry.

Same applied in preserve_boot_args(), kernel saves boot arguments into
'boot_args' and invalidates the corresponding cache entry. However,
according to the 'dcache_inval_poc()' implementation, the cache entry
will be not only invalidated but also cleaned. That means if there is a
stale cache entry corresponding to the address of the 'boot_args', the
saved boot arguments in 'boot_args' will be overwritten by the stale
cache entry. Therefore, it uses 'dv ivac' instruction directly instead
of calling 'dcache_inval_poc()'.

The address of the 'boot_args' is aligned to the cache line size and the
size of 'boot_args' is 32 byte (8 byte * 4), therefore, a single
invalidate operation is enough to invalidate the cache line belonging to
the 'boot_args'.

Sometimes clean operation is required not to lose any contents in the
cache entry but not the target of the invalidation. However, in this
case, there is no valid cache entries at a very early booting stage and
preserve_boot_args() is not called by any other (non-primary) CPUs.
Therefore, this invalidation operation will not introduce any problems.

[1] in Documentation/arm64/booting.rst:
The address range corresponding to the loaded kernel image must be
cleaned to the PoC.

Co-developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>

Co-developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>

Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
---
 arch/arm64/kernel/head.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cefe6a73ee54..916227666b07 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -121,9 +121,7 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 
 	dmb	sy				// needed before dc ivac with
 						// MMU off
-
-	add	x1, x0, #0x20			// 4 x 8 bytes
-	b	dcache_inval_poc		// tail call
+	dc	ivac, x0			// Invalidate potentially stale cache line
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
-- 
2.34.3

