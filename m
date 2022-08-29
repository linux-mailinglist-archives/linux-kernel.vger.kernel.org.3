Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AB5A5263
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiH2Q6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiH2Q55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:57:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4D9A9AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s22so4003430qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nxyi/lkNkq6gnwZzVfM6b9wH0jEP3m9DYKXN3rYV0f4=;
        b=hdErUyBmH3jAdvJY7oq9Oyjz3AeiA97KYXXVCmmfFF+0AxX7XKd5Q4GLp5gOYHsoIr
         ux3qjuCpV/IowDld0/tbVMLWrjTBpZs7JMNa6lyAO+1l/uWppuPwFruzgFuOu5v1Uubm
         DI/t5ZBW5qm2CiyniShfBJ0FM1iZxTa4MGoKFoHRfEKJexK+IyA2GuWAP8hMqpqHM9nl
         Z0UQ2A88beTZ8OIdoaoEudFKUmOybJnwQTH1LSzyXzKITAQYwdotGn3EvWtIS2Bf6UA2
         H9E6nnR83P4RymJ75b+HxuDoKePRIxNxFyG7k2ZFrUGgDLX5w8XDHRfZLwyFRkGDQ4N3
         09mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nxyi/lkNkq6gnwZzVfM6b9wH0jEP3m9DYKXN3rYV0f4=;
        b=j5cENjq0VX7GTGIh7f4q6F0v9ktdX0zBZeOqEncEvF7EBrA+kIEO6IZXlN6K5095dd
         wy7KwhIh4aKoOP6lIcU7CxiWVP4XLvHOLkBnmJKuUEXE1ZZzmcDRdVvXxl5uj3odmbH3
         hEPqjL6O9TLj7ydbWjVID4d2FocE6qX/EOeoAEmgNmyh/Vl8m4Zh4PuTJGW4XVT6E+4I
         2qRClcP6g8XPyPeb/5C/2TLYRdABwcKaHm6cBE/rgvFE0IaEVCdrT81xteSL0HQFZom6
         mnWPbaeWHJwT1kZg2D5BzGYJjw8gkMGP9w5okuQlueQ/Fkqpf9EPlGLjjPKAzgmAD77R
         XoaA==
X-Gm-Message-State: ACgBeo0EaUekEh/CbCDNANK+uVnPKFnOy5liORjRb0xBXeOnmu/z7lsL
        xzzHROzcsp8J0X77VZnAV60OmbpDKu8=
X-Google-Smtp-Source: AA6agR5/m5z8JvXmhzWj58EUn4m+KfVf5R5M4QqVKIdiELD2vpOyCPXyTQV1xeTxsvPGJ4AbNN6pHQ==
X-Received: by 2002:a05:620a:842:b0:6bb:b876:35d0 with SMTP id u2-20020a05620a084200b006bbb87635d0mr8872940qku.163.1661792273735;
        Mon, 29 Aug 2022 09:57:53 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5d44:81a:c7bc:27d1])
        by smtp.gmail.com with ESMTPSA id 14-20020ac84e8e000000b003436103df40sm5597027qtp.8.2022.08.29.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:57:53 -0700 (PDT)
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
Subject: [PATCH 3/4] lib/cpumask: deprecate nr_cpumask_bits
Date:   Mon, 29 Aug 2022 09:57:47 -0700
Message-Id: <20220829165748.1008477-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829165748.1008477-1-yury.norov@gmail.com>
References: <20220829165748.1008477-1-yury.norov@gmail.com>
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
index f70bf9ffa9d3..b7b863cf8831 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -41,13 +41,8 @@ typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
 extern unsigned int nr_cpu_ids;
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

