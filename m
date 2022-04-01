Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93BB4EE8A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbiDAG5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbiDAG46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:56:58 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 23:55:08 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0290FD2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:55:08 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id VAB00056;
        Fri, 01 Apr 2022 14:52:56 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2308.21; Fri, 1 Apr 2022 14:52:57 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] KVM: PPC: Book3S HV: fix the return value of kvm_age_rmapp()
Date:   Fri, 1 Apr 2022 02:52:52 -0400
Message-ID: <20220401065252.36472-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022401145256c1c7b0e9cca863817d7f78b2247f8888
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value type defined in the function kvm_age_rmapp() is
"bool", but the return value type defined in the implementation of the
function kvm_age_rmapp() is "int".

Change the return value type to "bool".

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 0aeb51738ca9..9a83894ca743 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -879,7 +879,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	struct revmap_entry *rev = kvm->arch.hpt.rev;
 	unsigned long head, i, j;
 	__be64 *hptep;
-	int ret = 0;
+	bool ret = false;
 	unsigned long *rmapp;
 
 	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
@@ -887,7 +887,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	lock_rmap(rmapp);
 	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
 		*rmapp &= ~KVMPPC_RMAP_REFERENCED;
-		ret = 1;
+		ret = true;
 	}
 	if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
 		unlock_rmap(rmapp);
@@ -919,7 +919,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 				rev[i].guest_rpte |= HPTE_R_R;
 				note_hpte_modification(kvm, &rev[i]);
 			}
-			ret = 1;
+			ret = true;
 		}
 		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	} while ((i = j) != head);
-- 
2.27.0

