Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4176F5ADBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiIEXJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiIEXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:08:38 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079269F69
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:08:28 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m5so7100065qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5nia01YVD1nOxZpuw1Ju3+MSuIMcZP6UORERwrWolic=;
        b=Hcj7b7/mvchl/778193I7X2cHOU66rPsy7p0dNS9j8Gi3qP9idutbicIcbR+6j0op0
         nF1C02g+0KMG/tbH/e1NnKiJvUPilOaJbLGJw8/XM3ttHJSpRCC5QdIPiMYmAb6ZAAjI
         qk06hGPXUQnasmdjdkKSqpgBCqnrSabABX2FOaOaRBgYFc2hygQBy8tDmps797rdfX2m
         QSf5ckbUXWlIKWyykf0dQo7K2nbRR6KB2+O4ZVDQD3G8xeSy0ryTFffmjfUyja8/EYcY
         AgqhmEszZgWYj4V6z6HKlnfeP255UZw4k+x73+bpGnuS1kSDl3oDVG2Wpj8mFsMmJHUb
         htxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5nia01YVD1nOxZpuw1Ju3+MSuIMcZP6UORERwrWolic=;
        b=En8JA61nokFpZ4Tl3bT3yWzErm6zBQA/bybdWi/+KVwPV1yUUzRcYOf2xXAgftLVCZ
         hJZvSRdBW9dlaFnvyOocUHn5ecJoEpB0N6t2HOB5fJJfij9x5Dg7e5OKHOMQN7FRTp+X
         Fak8e8WReGu6qclhedqo8RMhjxmIBoR217D6khRD+ex3rTjHAMlL6JfqCDt83bxLR9rh
         14otGCSG8fTmzS2vj5lLnaTwH4SskbefSJJb84Z1PaR4TeuMIXPS+15TQ+NlUuVrmc9W
         /F0fG+fD+r14APsS7thZD320rGYUkqfB8jhegZqjESLaVplzHZfmMs8WXMKBjfNOTjEg
         ddsA==
X-Gm-Message-State: ACgBeo0pfS7+Q7/hHtFA9Qrt84smvcnfF/y/xKYRk5yE2czJf1Wq/nHu
        Dc9iFuBE1JEJpLSg/sEOrOPyVF2MfBs=
X-Google-Smtp-Source: AA6agR6TyDOcWsBx7ANttUfOkGRDfVaPJJ6/zKxgOsfByiGkVBlSfVsUnp/Z3X+WlI2U5osgYW+6vA==
X-Received: by 2002:a05:620a:69c:b0:6bb:ebec:39c1 with SMTP id f28-20020a05620a069c00b006bbebec39c1mr33966927qkh.600.1662419307078;
        Mon, 05 Sep 2022 16:08:27 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:dde1:6b3e:62e9:1461])
        by smtp.gmail.com with ESMTPSA id o11-20020ac872cb000000b003422c7ccbc5sm7954128qtp.59.2022.09.05.16.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 16:08:26 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 4/5] lib/cpumask: deprecate nr_cpumask_bits
Date:   Mon,  5 Sep 2022 16:08:19 -0700
Message-Id: <20220905230820.3295223-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905230820.3295223-1-yury.norov@gmail.com>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
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

Cpumask code is written in assumption that when CONFIG_CPUMASK_OFFSTACK
is enabled, all cpumasks have boot-time defined size, otherwise the size
is always NR_CPUS.

The latter is wrong because the number of possible cpus is always
calculated on boot, and it may be less than NR_CPUS.

On my 4-cpu arm64 VM the nr_cpu_ids is 4, as expected, and nr_cpumask_bits
is 256, which corresponds to NR_CPUS. This not only leads to useless
traversing of cpumask bits greater than 4, this also makes some cpumask
routines fail.

For example, cpumask_full(0b1111000..000) would erroneously return false
in the example above because tail bits in the mask are all unset.

This patch deprecates nr_cpumask_bits and wires it to nr_cpu_ids
unconditionally, so that cpumask routines will not waste time traversing
unused part of cpu masks. It also fixes cpumask_full() and similar
routines.

As a side effect, because now a length of cpumasks is defined at run-time
even if CPUMASK_OFFSTACK is disabled, compiler can't optimize corresponding
functions.

It increases kernel size by ~2.5KB if OFFSTACK is off. This is addressed in
the following patch.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 8bac1dee8448..e01fba8ecc27 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -46,13 +46,8 @@ static inline void set_nr_cpu_ids(unsigned int nr)
 }
 #endif
 
-#ifdef CONFIG_CPUMASK_OFFSTACK
-/* Assuming NR_CPUS is huge, a runtime limit is more efficient.  Also,
- * not all bits may be allocated. */
+/* Deprecated. Always use nr_cpu_ids. */
 #define nr_cpumask_bits	nr_cpu_ids
-#else
-#define nr_cpumask_bits	((unsigned int)NR_CPUS)
-#endif
 
 /*
  * The following particular system cpumasks and operations manage
-- 
2.34.1

