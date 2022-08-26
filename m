Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C55A2531
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbiHZJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbiHZJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:56:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B706071BF0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:56:21 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDZrt6YDzzcfh3;
        Fri, 26 Aug 2022 17:53:02 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:56:20 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:56:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/2] arm: Replace this_cpu_* with raw_cpu_* in panic_bad_stack()
Date:   Fri, 26 Aug 2022 17:51:10 +0800
Message-ID: <20220826095112.289-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
Update commit message of two patches.

v1:
I'm analyzing a strange problem these days, and I find that there are some areas in
panic_bad_stack() that can be optimized. That is, replace this_cpu_* with raw_cpu_* .

Just optimization, it is unlikely to cause the following exception nesting, because of
"lr : __bad_stack+0x88/0x8c".

[20220819163739]Unable to handle kernel paging request at virtual address f7ffff94901b8048
[20220819163739]Mem abort info:
[20220819163739]  ESR = 0x96000004
[20220819163739]  EC = 0x25: DABT (current EL), IL = 32 bits
[20220819163739]  SET = 0, FnV = 0
[20220819163739]  EA = 0, S1PTW = 0
[20220819163739]Data abort info:
[20220819163739]  ISV = 0, ISS = 0x00000004
[20220819163739]  CM = 0, WnR = 0
[20220819163739][f7ffff94901b8048] address between user and kernel address ranges
[20220819163739]Internal error: Oops: 96000004 [#1] PREEMPT SMP
[20220819163739]Modules linked in: ...
[20220819163740]CPU: 2 PID: 1272 Comm: 00002SWDLMain Tainted: G        W  O      5.10.0 #1
[20220819163740]Hardware name: hisilicon,hi1213-fpga (DT)
[20220819163740]pstate: 000003c5 (nzcv DAIF -PAN -UAO -TCO BTYPE=--)
[20220819163740]pc : __bad_stack+0x4c/0x8c
[20220819163740]lr : __bad_stack+0x88/0x8c
[20220819163740]sp : ffffff953ffa8160
[20220819163740]x29: f7ffff953ffa8120 x28: f7ffff94901b8040 
[20220819163740]x27: ffffffeb72ea6940 x26: ffffffebeee6cf10 
[20220819163740]x25: ffffffebef627000 x24: 0000000000000000 
[20220819163740]x23: 00000000600003c5 x22: f7ffffebeee11904 
[20220819163740]x21: ffffff953ffa82b0 x20: 0000007fffffffff 
[20220819163740]x19: f7ffffc0133ab898 x18: 0000000000000000 
[20220819163740]x17: 0000000000000000 x16: ffffffebef32f0a0 
[20220819163740]x15: 00000000624057a0 x14: 953325a7da350fb3 
[20220819163740]x13: 09bbbe32ce2b3c11 x12: c15a0e2d1991997b 
[20220819163740]x11: 0bc8be839e7850d0 x10: cafa1cb223203045 
[20220819163740]x9 : f36bed299e5840dc x8 : ffffffc0133aba48 
[20220819163740]x7 : ffffff953b1b0480 x6 : ffffffebef3e1000 
[20220819163740]x5 : 0000000000000000 x4 : 0000000000000001 
[20220819163740]x3 : f7ffffc0133ab750 x2 : 0000000000000025 
[20220819163740]x1 : 0000000096000004 x0 : ffffff953ffa8160 
[20220819163740]Call trace:
[20220819163740] __bad_stack+0x4c/0x8c
[20220819163740]Code: a90d6ffa a90e77fc 910543f5 d538411c (f9400794) 
[20220819163740]---[ end trace 07532bfa2c24851c ]---
[20220819163740]Kernel panic - not syncing: Oops: Fatal exception

Zhen Lei (2):
  arm64/traps: Replace this_cpu_* with raw_cpu_* in panic_bad_stack()
  ARM: replace this_cpu_* with raw_cpu_* in panic_bad_stack()

 arch/arm/kernel/traps.c   | 4 ++--
 arch/arm64/kernel/traps.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

