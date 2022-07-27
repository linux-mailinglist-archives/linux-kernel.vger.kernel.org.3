Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECC3581E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiG0EDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiG0EDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:03:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97280175B0;
        Tue, 26 Jul 2022 21:03:14 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lt0QZ3vsXzWfxn;
        Wed, 27 Jul 2022 11:59:18 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 12:03:04 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 12:03:03 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v3 0/4] ARM: Convert to ARCH_STACKWALK
Date:   Wed, 27 Jul 2022 12:00:18 +0800
Message-ID: <20220727040022.139387-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly updates the ARM stack trace code to use the newer and
simpler arch_stack_walk() interface (see patches 3 and 4). Two issues
were fixed before that (see patches 1 and 2).

v3:
 - According to the discussion with Linus and Russell in v1:
   - Add a comment about "regs[1]" in patch 2, and remove the
     unnecessary ternary operator in the initialization of
     "frame->ex_frame".
   - Remove the patch "ARM: stacktrace: Allow stack trace saving for
     non-current tasks", and keep the check for not being able to
     unwind non-current tasks (including tasks running on other CPUs)
     when CONFIG_SMP=y in patch 4.
 - Rebase to linux-5.19-rc8.

v2: https://lore.kernel.org/lkml/20220713110020.85511-1-lihuafei1@huawei.com/
 - As suggested by Mark, the commit logs for patch 4 and 5 were
   refined for easy review.

v1: https://lore.kernel.org/lkml/20220712021527.109921-1-lihuafei1@huawei.com/

Li Huafei (4):
  ARM: stacktrace: Skip frame pointer boundary check for
    call_with_stack()
  ARM: stacktrace: Avoid duplicate saving of exception PC value
  ARM: stacktrace: Make stack walk callback consistent with generic code
  ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/stacktrace.h |   8 +-
 arch/arm/kernel/perf_callchain.c  |   9 +-
 arch/arm/kernel/return_address.c  |   9 +-
 arch/arm/kernel/stacktrace.c      | 191 ++++++++++++++----------------
 arch/arm/lib/call_with_stack.S    |   2 +
 6 files changed, 110 insertions(+), 110 deletions(-)

-- 
2.17.1

