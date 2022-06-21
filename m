Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A97553268
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiFUMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiFUMoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:44:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A41140A7;
        Tue, 21 Jun 2022 05:44:43 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LS5kz5jl2z1KC0B;
        Tue, 21 Jun 2022 20:42:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 20:44:41 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 20:44:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v2 0/3] arm64: kdump: Function supplement and performance optimization
Date:   Tue, 21 Jun 2022 20:42:45 +0800
Message-ID: <20220621124249.1315-1-thunder.leizhen@huawei.com>
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
1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
   is specified but "crashkernel=Y,low" is not specified.
2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
   will be considered in later versions.
3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
   But to avoid subsequent duplication of effort, I'm glad it was accepted.


v1:
After the basic functions of "support reserving crashkernel above 4G on arm64
kdump"(see https://lkml.org/lkml/2022/5/6/428) are implemented, we still have
three features to be improved.
1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
   the default crash low memory size is provided.
2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
   fall back to reserve region from high memory(above DMA zones).
3. If crashkernel=X,high is used, page mapping is performed only for the crash
   high memory, and block mapping is still used for other linear address spaces.
   Compared to the previous version:
   (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
       mapping, leave it to the next time.
   (2) The implementation method is modified. Now the implementation is simpler
       and clearer.

Zhen Lei (3):
  arm64: kdump: Provide default size when crashkernel=Y,low is not
    specified
  arm64: kdump: Support crashkernel=X fall back to reserve region above
    DMA zones
  arm64: kdump: Remove some redundant checks in map_mem()

 .../admin-guide/kernel-parameters.txt         | 10 ++-----
 arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
 arch/arm64/mm/mmu.c                           | 25 ++++++++---------
 3 files changed, 39 insertions(+), 24 deletions(-)

-- 
2.25.1

