Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7435846C43D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhLGUOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbhLGUOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:14:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B1C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:10:41 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a207-20020a621ad8000000b004aed6f7ec3fso236775pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CbiJgjuiMmKmQFa6pEpseMO0LTAhytjoaRC6slXEpKE=;
        b=gUMuFI4z/URWDBWUdNrOFJIIujXSqYVgBfksy2P07Tr2z+ao7wRFBZzFkqGpCq2Lni
         ZG9s2859v9fSpVtjrbKbEjSyupJPFqcEQFiDS9d9E8TSuyibrw/5b9ZxCyYkwC2jWh66
         A/NMesp82UCuL4l4oMz2rBGXCXtaEy6mxQd0U9oa8UMhPZVoRtHlaq20ENXJl39YpFrD
         obeEGsED+fg0yEMi5r75lybIjnhcn/Ygmpm0XcQebOTYZhTgd4kVQF6NHkdBkCeaZm+D
         3Piz2/ft7bpy6syz9ALyCXqiQEwQaaeYpNA7wQXy9McGJDITminPeQvuK/e8QtuBUQbB
         BFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CbiJgjuiMmKmQFa6pEpseMO0LTAhytjoaRC6slXEpKE=;
        b=JZ8TATxJVHC0jEjm4i39jHvVFO4V+rOR5Jcme6pBSih4tyFX/qkSfCHEH+cliDE6iV
         sqZpXdz9LwNXpgAuvaQX6q5+s0QhKGNBSb4Qm1boo13KyMnTQZ2vPHMWxwUK92QLwZtJ
         NXUBRyoebJLhjOYyBkHOnssObqjNYof6WRw5Qv2qLCp5gMLSnxY3BCMbLNJICWXRxuZr
         YZ44oGve+99ingPDgaICa4d6J+VMZEiSH4kAaFVNZK1JxQbg0ppZcw8uLG4abS1aQ+qi
         fqmwhycWZrAeJAlp+8eZ6MhTBLqAOhLYT3mz4QJhic3VcSRI/poKVIb5HLkhY6GApqjS
         Bu/w==
X-Gm-Message-State: AOAM531aC1q5DmDCEHNYI5A1Cv/dUq0G2GJZVu4N6cteTXBfHn5def2Q
        N+ZCcMNawl3a4fiGCgc9eAeGJlUVSRorJhu7xit90FUl00SChyFe81I61F+5Rd1uuYPoAZHoyLW
        ELQ+JrO3dviFHx6PCj/XC3GoXy/AAqm4853+rOgNqVBiw6+eJKuFyIjO2Yag32oaNQqfCiQ==
X-Google-Smtp-Source: ABdhPJz1KoOqKwrWbjG2HPgU1efvxtZPMLCO/nOcg2SyzISPmBpyRDmFYFT+ImWbAtoQxUh59HM2+5RQEpU=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:46ed:9c47:8229:475d])
 (user=pgonda job=sendgmr) by 2002:a62:8c44:0:b0:4ad:56f7:aa0c with SMTP id
 m65-20020a628c44000000b004ad56f7aa0cmr1262531pfd.36.1638907840741; Tue, 07
 Dec 2021 12:10:40 -0800 (PST)
Date:   Tue,  7 Dec 2021 12:10:34 -0800
Message-Id: <20211207201034.1392660-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH] selftests: sev_migrate_tests: Fix sev_ioctl()
From:   Peter Gonda <pgonda@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEST_ASSERT in SEV ioctl was allowing errors because it checked return
value was good OR the FW error code was OK. This TEST_ASSERT should
require both (aka. AND) values are OK. Removes the LAUNCH_START from the
mirror VM because this call correctly fails because mirror VMs cannot
call this command.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Marc Orr <marcorr@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index 29b18d565cf4..8e1b1e737cb1 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -31,7 +31,7 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
 	int ret;
 
 	ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
-	TEST_ASSERT((ret == 0 || cmd.error == SEV_RET_SUCCESS),
+	TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
 		    "%d failed: return code: %d, errno: %d, fw error: %d",
 		    cmd_id, ret, errno, cmd.error);
 }
@@ -228,9 +228,6 @@ static void sev_mirror_create(int dst_fd, int src_fd)
 static void test_sev_mirror(bool es)
 {
 	struct kvm_vm *src_vm, *dst_vm;
-	struct kvm_sev_launch_start start = {
-		.policy = es ? SEV_POLICY_ES : 0
-	};
 	int i;
 
 	src_vm = sev_vm_create(es);
@@ -241,7 +238,7 @@ static void test_sev_mirror(bool es)
 	/* Check that we can complete creation of the mirror VM.  */
 	for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
 		vm_vcpu_add(dst_vm, i);
-	sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_START, &start);
+
 	if (es)
 		sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 
-- 
2.34.1.400.ga245620fadb-goog

