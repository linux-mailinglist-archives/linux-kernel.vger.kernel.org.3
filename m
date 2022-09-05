Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08B45ADBB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIEXIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIEXIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:08:37 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF067CA8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:08:23 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a15so7083459qko.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 16:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PXDyNYAp8OMxsVSHWjGo5Scrwxu72x89/SDYjoWilCk=;
        b=pmmJwWs1yIczqiHgmAH6VF4Q8GewCKk7x+LpyS+k6b6kOsOi6JOZ8UuXje3m9BWxas
         5MRx2oN0S5l5YT2V2bombkIxnqURh/XihpSMFeo6y4obEx0epsjB7nnazZBxyyG/Uoxs
         EYh00n9pkoa4sad7uZEhtNCGQ+oWy9uhMONYmFo33C73bZNjsyyFCvhZjGlg57pPnuZu
         Kfq7hV24M6H6cZgT99O/zeTwB4H5CLY7rkdBdlny4UPwGrxeh5zJ0T1OoDnTeLuTWx28
         qVRN8389YzHcFPXMkZsYFLAvvjAf5eUpaF0/7osmV/lb1+4EHYNPbSZvbpzZ2Weawz1V
         /PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PXDyNYAp8OMxsVSHWjGo5Scrwxu72x89/SDYjoWilCk=;
        b=pj/VA9ASUAJp+V7Z/72SQlbIvwb+LBEpKzXDXsDSluF2UhgikcutkYdjoK5g9dUL/f
         Q1neWR3b3j4OTMF/0V9dHC30kwjtXLzrT2HFQG/ThrHQYZ99Z2SiMYrQav5vIyRsqICJ
         H4Sheulwft4dmDaMEdRbNCDxyKn94tZY/RT/1k574JxDIYUZQHME6+TkYF4XSfNGfUhH
         OQQ+3C08mVXIw9XXsgBmKpsYHTOA0BkkH+X2PxrlaMhvo6e7q60r1TcQEnV4JeLY6lLl
         gizrK3kuQfGTS7kg21ABOJZ4OKJa7WtiEd3WventHpJwV9eKuJefERToQeuzTmrIx+Jb
         OATw==
X-Gm-Message-State: ACgBeo2wkettlZB+vmomJNCj6jqTH4wYby1FyM8GRQElFcE6px4oMeGE
        YStVFf9BH6KgNHvXYYPMHyo/LQN/p5U=
X-Google-Smtp-Source: AA6agR4xlXwJXHbEjBgYaYyixegauoapofWxJF7lSedDYjp7FruVEy1NwsnNAztbbl+PVjCb9S8QUw==
X-Received: by 2002:a05:620a:4512:b0:6bb:7db2:3600 with SMTP id t18-20020a05620a451200b006bb7db23600mr32536370qkp.299.1662419302477;
        Mon, 05 Sep 2022 16:08:22 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:dde1:6b3e:62e9:1461])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a0bc800b006bba46e5eeasm9566369qki.37.2022.09.05.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 16:08:22 -0700 (PDT)
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
Subject: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits mess
Date:   Mon,  5 Sep 2022 16:08:15 -0700
Message-Id: <20220905230820.3295223-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

cpumask subsystem uses nr_cpu_ids and nr_cpumask_bits interchangeably
despite that the variables have different meaning and purpose. It makes
some cpumask functions broken.

This series cleans that mess and adds new config FORCE_NR_CPUS that
allows to optimize cpumask subsystem if the number of CPUs is known
at compile-time.

After some testing I found build broken when SMP is on and NR_CPUS == 1.
This is addressed in a new patch #1, and in the following patch #2 that
now declares set_nr_cpu_ids in cpumask.h (was in smp.h).

v1: https://lore.kernel.org/lkml/20220829165748.1008477-1-yury.norov@gmail.com/T/#mecbd787f8d1bff1454a4ec2fe46ad6dc168df695
v2:
 - don't declare nr_cpu_ids if NR_CPUS == 1;
 - move set_nr_cpu_ids() from smp.h to cpumask.h to avoid errors in some
   inclusion paths;
 - drop 'default n' in FORCE_NR_CPUS option description;
 - rebase on top of v6.0-rc4.

Yury Norov (5):
  smp: don't declare nr_cpu_ids if NR_CPUS == 1
  smp: add set_nr_cpu_ids()
  lib/cpumask: delete misleading comment
  lib/cpumask: deprecate nr_cpumask_bits
  lib/cpumask: add FORCE_NR_CPUS config option

 arch/loongarch/kernel/setup.c |  2 +-
 arch/mips/kernel/setup.c      |  2 +-
 arch/x86/kernel/smpboot.c     |  4 ++--
 arch/x86/xen/smp_pv.c         |  2 +-
 include/linux/cpumask.h       | 22 +++++++++++-----------
 kernel/smp.c                  |  6 ++++--
 lib/Kconfig                   |  9 +++++++++
 7 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.34.1

