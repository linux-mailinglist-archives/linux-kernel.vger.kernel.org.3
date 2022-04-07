Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF314F88F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiDGUj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiDGUjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:39:03 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42EE34F4BB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:25:34 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id i20-20020a4a9294000000b003247837949fso3518761ooh.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ttp8IxtKJKPUakVwxQg0lhCvSddOi7aLBcfebKk42ns=;
        b=AXZXM/cAx13p3RYWxNJaUGmlRacSq1QL5lMWv61BaTrp9oPlZp8HG9mVrtSq7fq+Mf
         F/Tml2ALcltBYbBG9GFaFUPaNDXWWWhXpRnbK0df8PmkEmwC50IPbtt0YCzR3xOMipT+
         CNFJFaIm+O1WOVjTo0GlkiUElwT/mA5dEmDYdaWJDY7YRqF8VoSeRMwA/wtA27GRAWg7
         aUm5lSoOY8CylUjGuyjzYgLqq5ZIg1QI9trDoW7gSlUSv1hYhAADvwihD8mmFOwq+UMp
         XdVDkF/FLUX39Bbe+fOjH+ctPxjbHFGDJVUCab7P8S6xOWBeS/s3bo8yKoag5jhmZ/DR
         WhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ttp8IxtKJKPUakVwxQg0lhCvSddOi7aLBcfebKk42ns=;
        b=B30PYQE7s0ydNBFVI2MevtAYaunehOW0eNdt5xsUVzHtNeEVil///7NOndB/My2TeS
         vHca+3shRfCWkXMKoDvWtYNWe9JZMSxWH6E7X1oiasux3hQ8b7ZOv8hBStqg8LkNIWEv
         w+8AslJ5NjOS2inS/R6dAOe7ET9hYKiTmuVfQnyMGCee5L0pISzNU0+l0e/qFvAjhiVg
         wjQy0K9j3w4lw5rHq3xMAVucAF7i0kmRpicOwyMumeWi+C1igDdKbfa9rZ2Cy6OK2bdN
         yjaOpwAEDC24wnG0MhwqGOTbXiBg7b7IT/6UlfQKPWW/P8XiZLgvEiHswYnjife8LAUE
         x0Ag==
X-Gm-Message-State: AOAM531bT0rbV+XaQ3GYVKd52debY7W29qRykfzDUc7Hj7u1CuUlkkD4
        Y8J8B0gFxOx2jUUz+R8f9Kls3v56vtI=
X-Google-Smtp-Source: ABdhPJwo1BVePnrcUC0qxZ77M6SEcawIn9uhBgssdl+AXrfS1AiII8QNXU3LqD1TGXpHvAStGWw05HdlneY=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:469d:83b1:de7b:c47f])
 (user=pgonda job=sendgmr) by 2002:a05:6902:100e:b0:637:7536:6582 with SMTP id
 w14-20020a056902100e00b0063775366582mr11575220ybt.355.1649361551821; Thu, 07
 Apr 2022 12:59:11 -0700 (PDT)
Date:   Thu,  7 Apr 2022 12:59:08 -0700
Message-Id: <20220407195908.633003-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v3] KVM: SEV: Mark nested locking of vcpu->lock
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svm_vm_migrate_from() uses sev_lock_vcpus_for_migration() to lock all
source and target vcpu->locks. Mark the nested subclasses to avoid false
positives from lockdep.

Warning example:
============================================
WARNING: possible recursive locking detected
5.17.0-dbg-DEV #15 Tainted: G           O
--------------------------------------------
sev_migrate_tes/18859 is trying to acquire lock:
ffff8d672d484238 (&vcpu->mutex){+.+.}-{3:3}, at: sev_lock_vcpus_for_migration+0x7e/0x150
but task is already holding lock:
ffff8d67703f81f8 (&vcpu->mutex){+.+.}-{3:3}, at: sev_lock_vcpus_for_migration+0x7e/0x150
other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0
       ----
  lock(&vcpu->mutex);
  lock(&vcpu->mutex);
 *** DEADLOCK ***
 May be due to missing lock nesting notation
3 locks held by sev_migrate_tes/18859:
 #0: ffff9302f91323b8 (&kvm->lock){+.+.}-{3:3}, at: sev_vm_move_enc_context_from+0x96/0x740
 #1: ffff9302f906a3b8 (&kvm->lock/1){+.+.}-{3:3}, at: sev_vm_move_enc_context_from+0xae/0x740
 #2: ffff8d67703f81f8 (&vcpu->mutex){+.+.}-{3:3}, at: sev_lock_vcpus_for_migration+0x7e/0x150

Fixes: b56639318bb2b ("KVM: SEV: Add support for SEV intra host migration")
Reported-by: John Sperbeck<jsperbeck@google.com>
Suggested-by: David Rientjes <rientjes@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>

---

V3
 * Updated signature to enum to self-document argument.
 * Updated comment as Seanjc@ suggested.

Tested by running sev_migrate_tests with lockdep enabled. Before we see
a warning from sev_lock_vcpus_for_migration(). After we get no warnings.

---
 arch/x86/kvm/svm/sev.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75fa6dd268f0..f66550ec8eaf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1591,14 +1591,26 @@ static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 	atomic_set_release(&src_sev->migration_in_progress, 0);
 }
 
+/*
+ * To suppress lockdep false positives, subclass all vCPU mutex locks by
+ * assigning even numbers to the source vCPUs and odd numbers to destination
+ * vCPUs based on the vCPU's index.
+ */
+enum sev_migration_role {
+	SEV_MIGRATION_SOURCE = 0,
+	SEV_MIGRATION_TARGET,
+	SEV_NR_MIGRATION_ROLES,
+};
 
-static int sev_lock_vcpus_for_migration(struct kvm *kvm)
+static int sev_lock_vcpus_for_migration(struct kvm *kvm,
+					enum sev_migration_role role)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i, j;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (mutex_lock_killable(&vcpu->mutex))
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (mutex_lock_killable_nested(
+			    &vcpu->mutex, i * SEV_NR_MIGRATION_ROLES + role))
 			goto out_unlock;
 	}
 
@@ -1745,10 +1757,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 		charged = true;
 	}
 
-	ret = sev_lock_vcpus_for_migration(kvm);
+	ret = sev_lock_vcpus_for_migration(kvm, SEV_MIGRATION_SOURCE);
 	if (ret)
 		goto out_dst_cgroup;
-	ret = sev_lock_vcpus_for_migration(source_kvm);
+	ret = sev_lock_vcpus_for_migration(source_kvm, SEV_MIGRATION_TARGET);
 	if (ret)
 		goto out_dst_vcpu;
 
-- 
2.35.1.1178.g4f1659d476-goog

