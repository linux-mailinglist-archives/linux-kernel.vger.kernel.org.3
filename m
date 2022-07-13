Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2D5734D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiGMLCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiGMLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:02:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69918FFE05;
        Wed, 13 Jul 2022 04:02:51 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjZPR17BgzVfg0;
        Wed, 13 Jul 2022 18:59:07 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:02:49 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:02:48 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <broonie@kernel.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>,
        <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2 0/5] ARM: Convert to ARCH_STACKWALK
Date:   Wed, 13 Jul 2022 19:00:15 +0800
Message-ID: <20220713110020.85511-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly updates the ARM stack trace code to use the newer and
simpler arch_stack_walk() interface. Two issues were fixed before that
(see patch 1 and 2), as well as allowing stack_trace_save_tsk() to
trace non-current tasks (see patch 3).

v2:
 - As suggested by Mark, the commit logs for patch 4 and 5 were
   refined for easy review.

v1: https://lore.kernel.org/lkml/20220712021527.109921-1-lihuafei1@huawei.com/

Li Huafei (5):
  ARM: stacktrace: Skip frame pointer boundary check for
    call_with_stack()
  ARM: stacktrace: Avoid duplicate saving of exception PC value
  ARM: stacktrace: Allow stack trace saving for non-current tasks
  ARM: stacktrace: Make stack walk callback consistent with generic code
  ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/stacktrace.h |   8 +-
 arch/arm/kernel/perf_callchain.c  |   9 +-
 arch/arm/kernel/return_address.c  |   9 +-
 arch/arm/kernel/stacktrace.c      | 195 +++++++++++++-----------------
 arch/arm/lib/call_with_stack.S    |   2 +
 6 files changed, 105 insertions(+), 119 deletions(-)

-- 
2.17.1

