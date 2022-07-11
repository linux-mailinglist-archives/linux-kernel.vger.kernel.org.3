Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45156F993
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiGKJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGKJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:04:47 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D01C36;
        Mon, 11 Jul 2022 02:04:46 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LhHvQ09VNz1L926;
        Mon, 11 Jul 2022 17:02:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 17:04:41 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 17:04:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v3 0/2] arm64: kdump: Function supplement and performance optimization
Date:   Mon, 11 Jul 2022 17:03:17 +0800
Message-ID: <20220711090319.1604-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

v2 --> v3:
1. Discard patch 3 in v2, a cleanup patch.

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

Zhen Lei (2):
  arm64: kdump: Provide default size when crashkernel=Y,low is not
    specified
  arm64: kdump: Support crashkernel=X fall back to reserve region above
    DMA zones

 .../admin-guide/kernel-parameters.txt         | 10 ++-----
 arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
 2 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.25.1

