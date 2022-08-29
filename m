Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4105A525E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiH2Q6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiH2Q5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:57:52 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018F9A992
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:51 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id w18so6497826qki.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zW4GDIEe2Qgi6AwNzILkHhwRcwKq5tQG490STX0GYHg=;
        b=O66zgSuGYrDx9PCKOHUV+YWYwh4N6Ofh19ojJ5QT8Rp6YEfQhOnd8QOgB6A5h7vuTF
         /LkMA3jevijbW49nwjY7KxUB/ON2g2z56KleP0tga4d4zlrZ9kxQ/XnMxPxC0dIwW7JE
         /8nFp6cwmMPLk2FYy7fBP975jZwnczQERMQnaJEQDVj/V8bUizPnGiZqCKmU+Vubqr/O
         7udLbMIQGNJGyl8lzeD9hj+VU6igFNElgEct/nTZwzxKk8tA1quf5+Bd7B+cTgcMEzb6
         tOYKgYARngff/nyX8e51hJ3+2IfMffrOXMgBNQ3H2uQPdGQ4naS0ZUju6sSEgilNmdrd
         Dr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zW4GDIEe2Qgi6AwNzILkHhwRcwKq5tQG490STX0GYHg=;
        b=adc5ee/lqO5UdBvIntlTwMurmO6X3GhJRlfVOfWY+RypJZx5zWt88KOCTvv1Ka2EzM
         zNiGDJdHX667QHafjv4pnIenj0wA0VrRYZgTsUvAO27vqyLkzdghKmEKD0+C4mmLvasE
         YuXhEy2/oXOLCa1Kaj6iQUEDmOQ2Jt/bNLiuIOFEq7ssinwck/Rrki9KG1AAuxc1p9ny
         vbOgm6Slbva9DzPLxKeDI9vMiB8qrHTbl2KLc3Z76gyu3R0g7hZM2ssItcLVFk5RfigT
         pch0HEn/vc+K+vA4cty10ZH4ekDziTIs/X30e/NBJCFcVLN9WVn6Fx/rLmQIKs/VIBhL
         pRcg==
X-Gm-Message-State: ACgBeo29DYBiUcKXKcdpWrRnwzjRedH0LVRrK5OoJOIkhHWZK1DozinV
        sZxf+xOS7l+uBXXfCSRkYjpMB4j5NaY=
X-Google-Smtp-Source: AA6agR7XAaEK4rM5IBiMcY9zjCGrMHqOu54hsPBwuMN8EFuYqCTWFSTeG/0py9mV0YHU8MfoHu0Cgg==
X-Received: by 2002:ae9:e714:0:b0:6ba:5364:d75a with SMTP id m20-20020ae9e714000000b006ba5364d75amr9270164qka.560.1661792270718;
        Mon, 29 Aug 2022 09:57:50 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5d44:81a:c7bc:27d1])
        by smtp.gmail.com with ESMTPSA id c6-20020a05620a268600b006be68f9bdddsm6598095qkp.133.2022.08.29.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:57:50 -0700 (PDT)
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
Subject: [PATCH 0/4] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits mess
Date:   Mon, 29 Aug 2022 09:57:44 -0700
Message-Id: <20220829165748.1008477-1-yury.norov@gmail.com>
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

Yury Norov (4):
  smp: add set_nr_cpu_ids()
  lib/cpumask: delete misleading comment
  lib/cpumask: deprecate nr_cpumask_bits
  lib/cpumask: add FORCE_NR_CPUS config option

 arch/loongarch/kernel/setup.c |  2 +-
 arch/mips/kernel/setup.c      |  2 +-
 arch/x86/kernel/smpboot.c     |  4 ++--
 arch/x86/xen/smp_pv.c         |  2 +-
 include/linux/cpumask.h       | 15 +++------------
 include/linux/smp.h           |  9 +++++++++
 kernel/smp.c                  |  6 ++++--
 lib/Kconfig                   | 10 ++++++++++
 8 files changed, 31 insertions(+), 19 deletions(-)

-- 
2.34.1

