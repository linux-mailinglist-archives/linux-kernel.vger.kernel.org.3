Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C57E4FC062
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbiDKPZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiDKPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:24:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66FDC2314E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:22:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195A91570;
        Mon, 11 Apr 2022 08:22:43 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.40.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65FC23F73B;
        Mon, 11 Apr 2022 08:22:41 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
        Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 0/2] cpu/hotplug: Fix cpuhp_cpu_state used before init
Date:   Mon, 11 Apr 2022 16:22:31 +0100
Message-Id: <20220411152233.474129-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's possible to trigger a case where the cpuhp_cpu_state::cpu
member is used before it has been initialised. This can cause CPU 0 to
be erroneously marked as dying and trigger a scheduler panic (full
details in v1[1]).

The two patches here fix the root cause by removing the 'cpu' member
altogether and to prevent similar confusion in the future ensure that
the cpuhp_cpu_state structures are initialised before any hotplugging
occurs.

Changes since v2[2]:
 * Remove the cpu member altogether (first patch)
 * Move the initialisation of cpuhp_cpu_state as suggested by tglx
   (second patch)

[1] https://lore.kernel.org/all/20220225134918.105796-1-steven.price@arm.com/
[2] https://lore.kernel.org/all/20220316153637.288199-1-steven.price@arm.com/

Steven Price (2):
  cpu/hotplug: Remove the 'cpu' member of cpuhp_cpu_state
  cpu/hotplug: Initialise all cpuhp_cpu_state structs earlier

 kernel/cpu.c | 58 ++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

-- 
2.25.1

