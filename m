Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3284F3F73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380234AbiDEUEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573044AbiDERsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:48:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0675D1110
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:46:41 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b18-20020a63d812000000b0037e1aa59c0bso424pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cMTfDoOyyWLXLeBs6Ru7ToFxgfyCJggJkw0OXJMsEV8=;
        b=nMfcorGlUtXECOW5K6EgdcUsQAcrop5tc3p5tTcoHcmFQiM5G5UW0zRhxr26er4OAr
         s5v6PQmrcXR71vJMJDEVfVEi6/BGDusf+GDkbu49tMPrbowlSFMgbHig8rD6DZQZmHS/
         gTgnI4kYoSwt8c9IAifAu8FjUB03lSAsOwDTfv4kzBKiHU0OL9rQtUzoK2zqYD2KA11X
         nFbw2gOlMW++pZybJgMCWKH5eIObGH2WsSttfM4SljNf6flXef8ppdyyjRZcy6syqETb
         Qz+OoSYfRbFJuVp2fxQw2x7mz/1KezSRobYkumFfNg+k6O320lkst6vJRzOrzHfYxTYo
         fojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cMTfDoOyyWLXLeBs6Ru7ToFxgfyCJggJkw0OXJMsEV8=;
        b=tyRR/Uv0t2b8/mYPBoK7E8rgyQ2jeL26tVlgX0ZubKawS62oS1Q8ymM9Hh1yEdNRoM
         eqPYyyVv4zDrLV2I3yh8pYA2OWTr3eo5jdV+H7FFfiepV1as8AAYzm0LdOh8Z9caJivz
         dh0CUrzsZt4SnxRec4buFbCyZP9EZ/3W6o1elhYkLl69taB7v3dJpIjCNsfncNxO/Upf
         ws6VvNLzs2PztYe2tHF72mXosMqqL0nSRbPUizS8NPi1uVyh3H+n6dKlttqIydg/Sgsj
         RIESeMRBWHR/lKwAf/O848DF18XBlW81R3PtxS8DdRL/NKVgz96fzXm7dbdujRAnHanJ
         joOQ==
X-Gm-Message-State: AOAM5330zdGDbHCKuqhubGaHxwIrniV3V7QYsCst7cFAXTnm6C4RaEXU
        uuRysbRsVE9mtjjNcZdm4LzSbN3aU/g=
X-Google-Smtp-Source: ABdhPJyyh/3pCquJqcSiGkL89OJvx9V1mCcnl2ur+7wPBn4VOBCz5evBX3VHphcCk3xlVaHFHjDW5vPwJhk=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:9f5c:353e:771c:7686])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:8c5:b0:4fe:134d:30d3 with SMTP id
 s5-20020a056a0008c500b004fe134d30d3mr4801602pfu.3.1649180801244; Tue, 05 Apr
 2022 10:46:41 -0700 (PDT)
Date:   Tue,  5 Apr 2022 10:46:37 -0700
Message-Id: <20220405174637.2074319-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2] KVM: SEV: Mark nested locking of vcpu->mutex
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svm_vm_migrate_from() uses sev_lock_vcpus_for_migration() to lock all
source and target vcpu->mutex. Mark the nested subclasses to avoid false
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

Tested by running sev_migrate_tests with lockdep enabled. Before we see
a warning from sev_lock_vcpus_for_migration(). After we get no warnings.

---
 arch/x86/kvm/svm/sev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75fa6dd268f0..673e1ee2cfc9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1591,14 +1591,21 @@ static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 	atomic_set_release(&src_sev->migration_in_progress, 0);
 }
 
+#define SEV_MIGRATION_SOURCE 0
+#define SEV_MIGRATION_TARGET 1
 
-static int sev_lock_vcpus_for_migration(struct kvm *kvm)
+/*
+ * To avoid lockdep warnings callers should pass @vm argument with either
+ * SEV_MIGRATION_SOURCE or SEV_MIGRATE_TARGET. This allows subclassing of all
+ * vCPU mutex locks.
+ */
+static int sev_lock_vcpus_for_migration(struct kvm *kvm, int vm)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i, j;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (mutex_lock_killable(&vcpu->mutex))
+		if (mutex_lock_killable_nested(&vcpu->mutex, i * 2 + vm))
 			goto out_unlock;
 	}
 
@@ -1745,10 +1752,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
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
2.35.1.1094.g7c7d902a7c-goog

