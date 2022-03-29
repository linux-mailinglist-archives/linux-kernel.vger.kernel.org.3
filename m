Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A44EAB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiC2KWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiC2KWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:22:50 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D19E85F94;
        Tue, 29 Mar 2022 03:21:06 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 177B71E80D85;
        Tue, 29 Mar 2022 18:20:31 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DkKIvnZ9PCZ3; Tue, 29 Mar 2022 18:20:28 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 8DE961E80D84;
        Tue, 29 Mar 2022 18:20:27 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com
Cc:     catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org,
        samitolvanen@google.com, ricarkol@google.com, justin.he@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] KVM: arm64: vgic: remove unnecessary type castings
Date:   Tue, 29 Mar 2022 03:20:59 -0700
Message-Id: <20220329102059.268983-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328103836.2829-1-yuzhe@nfschina.com>
References: <20220328103836.2829-1-yuzhe@nfschina.com>
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

remove unnecessary casts.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 arch/arm64/kvm/vgic/vgic-debug.c | 10 +++++-----
 arch/arm64/kvm/vgic/vgic-its.c   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
index f38c40a76251..78cde687383c 100644
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
@@ -229,8 +229,8 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 
 static int vgic_debug_show(struct seq_file *s, void *v)
 {
-	struct kvm *kvm = (struct kvm *)s->private;
-	struct vgic_state_iter *iter = (struct vgic_state_iter *)v;
+	struct kvm *kvm = s->private;
+	struct vgic_state_iter *iter = v;
 	struct vgic_irq *irq;
 	struct kvm_vcpu *vcpu = NULL;
 	unsigned long flags;
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 089fc2ffcb43..2e13402be3bd 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2143,7 +2143,7 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
 				void *ptr, void *opaque)
 {
-	struct its_device *dev = (struct its_device *)opaque;
+	struct its_device *dev = opaque;
 	struct its_collection *collection;
 	struct kvm *kvm = its->dev->kvm;
 	struct kvm_vcpu *vcpu = NULL;
-- 
2.25.1

