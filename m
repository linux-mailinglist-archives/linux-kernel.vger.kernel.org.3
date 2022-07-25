Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA11E57F801
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiGYBqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiGYBp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:45:56 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0EC130;
        Sun, 24 Jul 2022 18:45:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKFpxwI_1658713548;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKFpxwI_1658713548)
          by smtp.aliyun-inc.com;
          Mon, 25 Jul 2022 09:45:49 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [RESEND PATCH V2 5/5] riscv: crash_core: Export kernel vm layout, phys_ram_base
Date:   Mon, 25 Jul 2022 09:45:39 +0800
Message-Id: <20220725014539.1037627-6-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These infos are needed by the kdump crash tool. Since these values change
from time to time, it is preferable to export them via vmcoreinfo than to
change the crash's code frequently.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..6b76284a503c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -595,3 +595,34 @@ X2TLB
 -----
 
 Indicates whether the crashed kernel enabled SH extended mode.
+
+RISCV64
+=======
+
+VA_BITS
+-------
+
+The maximum number of bits for virtual addresses. Used to compute the
+virtual memory ranges.
+
+PAGE_OFFSET
+-----------
+
+Indicates the virtual kernel start address of direct-mapped RAM region.
+
+phys_ram_base
+-------------
+
+Indicates the start physical RAM address.
+
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
+-----------------------------------------------------------------------------
+KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
+----------------------------------------------------------------------
+
+Used to get the correct ranges:
+	MODULES_VADDR ~ MODULES_END : Kernel module space.
+	VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
+	VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
+	KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
+	KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
-- 
2.17.1

