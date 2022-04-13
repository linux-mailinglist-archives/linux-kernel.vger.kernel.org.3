Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351E4FF54F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiDMK7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiDMK7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:59:44 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 03:57:20 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCB5A17B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:57:19 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id IGR00011;
        Wed, 13 Apr 2022 18:55:11 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2308.21; Wed, 13 Apr 2022 18:55:12 +0800
From:   Deming <wangdeming@inspur.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] powerpc/xive: remove unused parameter
Date:   Wed, 13 Apr 2022 06:55:07 -0400
Message-ID: <20220413105507.1729-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202241318551125e62aa8a26dedd8ece4937ffc9f6d7d
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

From: Deming Wang <wangdeming@inspur.com>

the parameter xc balongng to xive_cleanup_single_escalation is unused,so we
need to remove it.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 arch/powerpc/kvm/book3s_xive.c        | 5 ++---
 arch/powerpc/kvm/book3s_xive.h        | 3 +--
 arch/powerpc/kvm/book3s_xive_native.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index c0ce553..12693db 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1180,8 +1180,7 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
  * stale_p (because it has no easy way to address it).  Hence we have
  * to adjust stale_p before shutting down the interrupt.
  */
-void xive_cleanup_single_escalation(struct kvm_vcpu *vcpu,
-				    struct kvmppc_xive_vcpu *xc, int irq)
+void xive_cleanup_single_escalation(struct kvm_vcpu *vcpu, int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
 	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
@@ -1222,7 +1221,7 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
 		if (xc->esc_virq[i]) {
 			if (kvmppc_xive_has_single_escalation(xc->xive))
-				xive_cleanup_single_escalation(vcpu, xc,
+				xive_cleanup_single_escalation(vcpu,
 							xc->esc_virq[i]);
 			free_irq(xc->esc_virq[i], vcpu);
 			irq_dispose_mapping(xc->esc_virq[i]);
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 09d0657..f779ebb 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -306,8 +306,7 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
 int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
 				  bool single_escalation);
 struct kvmppc_xive *kvmppc_xive_get_device(struct kvm *kvm, u32 type);
-void xive_cleanup_single_escalation(struct kvm_vcpu *vcpu,
-				    struct kvmppc_xive_vcpu *xc, int irq);
+void xive_cleanup_single_escalation(struct kvm_vcpu *vcpu, int irq);
 int kvmppc_xive_compute_vp_id(struct kvmppc_xive *xive, u32 cpu, u32 *vp);
 int kvmppc_xive_set_nr_servers(struct kvmppc_xive *xive, u64 addr);
 bool kvmppc_xive_check_save_restore(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index f81ba6f..99c23a4 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -93,7 +93,7 @@ void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu)
 		/* Free the escalation irq */
 		if (xc->esc_virq[i]) {
 			if (kvmppc_xive_has_single_escalation(xc->xive))
-				xive_cleanup_single_escalation(vcpu, xc,
+				xive_cleanup_single_escalation(vcpu,
 							xc->esc_virq[i]);
 			free_irq(xc->esc_virq[i], vcpu);
 			irq_dispose_mapping(xc->esc_virq[i]);
-- 
1.8.3.1

