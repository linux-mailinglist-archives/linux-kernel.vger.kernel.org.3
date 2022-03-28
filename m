Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4C4E929B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiC1Kk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiC1KkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:40:24 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C49E38780;
        Mon, 28 Mar 2022 03:38:41 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id B2AE01E80D6F;
        Mon, 28 Mar 2022 18:38:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hTti3BhPV8W4; Mon, 28 Mar 2022 18:38:02 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 7D08B1E80D6E;
        Mon, 28 Mar 2022 18:38:01 +0800 (CST)
From:   yuzhe <yuzhe@nfschina.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        kernel-janitors@vger.kernel.org, yuzhe <yuzhe@nfschina.com>
Subject: [PATCH] KVM: arm64: vgic-debug: remove unnecessary type castings
Date:   Mon, 28 Mar 2022 03:38:36 -0700
Message-Id: <20220328103836.2829-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary castings, from "void *" to "struct kvm *"

Signed-off-by: yuzhe <yuzhe@nfschina.com>
---
 arch/arm64/kvm/vgic/vgic-debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
index f38c40a76251..927e5c1f650d 100644
--- a/arch/arm64/kvm/vgic/vgic-debug.c
+++ b/arch/arm64/kvm/vgic/vgic-debug.c
@@ -82,7 +82,7 @@ static bool end_of_vgic(struct vgic_state_iter *iter)
 
 static void *vgic_debug_start(struct seq_file *s, loff_t *pos)
 {
-	struct kvm *kvm = (struct kvm *)s->private;
+	struct kvm *kvm = s->private;
 	struct vgic_state_iter *iter;
 
 	mutex_lock(&kvm->lock);
@@ -110,7 +110,7 @@ static void *vgic_debug_start(struct seq_file *s, loff_t *pos)
 
 static void *vgic_debug_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct kvm *kvm = (struct kvm *)s->private;
+	struct kvm *kvm = s->private;
 	struct vgic_state_iter *iter = kvm->arch.vgic.iter;
 
 	++*pos;
@@ -122,7 +122,7 @@ static void *vgic_debug_next(struct seq_file *s, void *v, loff_t *pos)
 
 static void vgic_debug_stop(struct seq_file *s, void *v)
 {
-	struct kvm *kvm = (struct kvm *)s->private;
+	struct kvm *kvm = s->private;
 	struct vgic_state_iter *iter;
 
 	/*
@@ -229,7 +229,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 
 static int vgic_debug_show(struct seq_file *s, void *v)
 {
-	struct kvm *kvm = (struct kvm *)s->private;
+	struct kvm *kvm = s->private;
 	struct vgic_state_iter *iter = (struct vgic_state_iter *)v;
 	struct vgic_irq *irq;
 	struct kvm_vcpu *vcpu = NULL;
-- 
2.25.1

