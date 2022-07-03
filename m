Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D06569E78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiGGJT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiGGJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:19:57 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143932EC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:19:55 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CIB00150;
        Thu, 07 Jul 2022 17:19:50 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.9; Thu, 7 Jul 2022 17:19:51 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mpe@ellerman.id.au>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] KVM: PPC: Use the arg->size directly for kvm_vm_ioctl_create_spapr_tce
Date:   Sun, 3 Jul 2022 13:29:32 -0400
Message-ID: <20220703172932.11329-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20227071719503b43df983e69e9535cfd506721407631
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use arg->size directly may be better for code readability.Because, the
variable of size has not been found for special purpose  at present.
Also,We can reduce the use of a variable.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index d6589c4fe889..5f74ffb88e82 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -294,14 +294,14 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	struct kvmppc_spapr_tce_table *stt = NULL;
 	struct kvmppc_spapr_tce_table *siter;
 	struct mm_struct *mm = kvm->mm;
-	unsigned long npages, size = args->size;
+	unsigned long npages;
 	int ret;
 
 	if (!args->size || args->page_shift < 12 || args->page_shift > 34 ||
 		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
 		return -EINVAL;
 
-	npages = kvmppc_tce_pages(size);
+	npages = kvmppc_tce_pages(args->size);
 	ret = account_locked_vm(mm, kvmppc_stt_pages(npages), true);
 	if (ret)
 		return ret;
@@ -314,7 +314,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	stt->liobn = args->liobn;
 	stt->page_shift = args->page_shift;
 	stt->offset = args->offset;
-	stt->size = size;
+	stt->size = args->size;
 	stt->kvm = kvm;
 	mutex_init(&stt->alloc_lock);
 	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
-- 
2.27.0

