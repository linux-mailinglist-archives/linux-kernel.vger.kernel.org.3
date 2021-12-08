Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2833446DBE6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhLHTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhLHTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:20:24 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A4C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:16:52 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r15-20020a63ec4f000000b002e582189837so1799067pgj.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+rUb4EcNLHXprRGqicoOenA63+zorwY5WA3oAPDA1u8=;
        b=fwDpE7kawJMsXyteTfbEn8A3BclDGm4jhjcP0qfEWLJ61ICFBv7/rCgod5IaDpJXAb
         jeTB4HtI0CygoWMsq7BMbR7naWpCTFnlRzFsG/M/kk5TSzzQo5u+d5dKDLXUIOLKKxQC
         566AnHZoV3fev/pLoGZwBtvQTJcXlolt74D3M9MqNHeXrEwaQ/n34Vmk2lXULruuYQak
         Dtw6eFHQjeSJwv40pulCVICe4pFev1wUQ0aiKn6BeRpvhHJFIc610xiIxWNOjLG7WWxs
         RN5f0ClQJZ5/DUlHFFVJFnrVhz0axJS951fcpkufW5wD5pk+X+jSwQCTvBviS4lr9X19
         fOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+rUb4EcNLHXprRGqicoOenA63+zorwY5WA3oAPDA1u8=;
        b=DX4G+davlIAgj2sHYdmpUY3DZyy25iORlRHqZlb/GtWhE/aSHzUpsCqDTlSeQeso0Z
         MOJqFwibEvle32bJkY+AQbev5kYfREzDAs8eweQd3FYXLkWSG5QKVHtC6cP7MNSy2Z4W
         qbJrVU4hKHlky1llI2zxfgKGBFQx8zHIfZtjRnU+m7SC+UhxNgU1/7yhg78SL6y3ipG9
         pVejJeKUz3LQ9omjgXfVpfbRbFGNj82iGhyw0gfYTF1YchFqv4obTuE9WBlIMt1N+sll
         CdVtGjNFhciRawSCv+udx9hIy8IV+MkEtz8kFgpvUHYpm43lG6kTeVn79GBxRe6sqwoo
         fCtQ==
X-Gm-Message-State: AOAM5317qRCCV7iAKvwh6hcMvL1o3dEz3UnjrG4k4j9omj0Ghxx5rYKu
        TQu112qsAMKDSnTlFuEU4vOxOZwusxNmSOczQuvNb8hAMNy7sSxe5+BTeDke8Nx/bqihJd2dDmG
        eOOyFjmeepZDzP/h7ohtf6uaTdpYiuY7nUHF12+WwEUrL3RV+xv3dmiUhfGFU1fbPSc2dyQ==
X-Google-Smtp-Source: ABdhPJyQ05g7P13b2YRufccjN8TF/Br/V30j4aaI/54yAgNMPP03l7wreqeDrWzZObJQbWGgl2jnInka1fM=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:ff20:12b0:c79e:3e6b])
 (user=pgonda job=sendgmr) by 2002:a17:90a:6f61:: with SMTP id
 d88mr9548836pjk.109.1638991012130; Wed, 08 Dec 2021 11:16:52 -0800 (PST)
Date:   Wed,  8 Dec 2021 11:16:42 -0800
In-Reply-To: <20211208191642.3792819-1-pgonda@google.com>
Message-Id: <20211208191642.3792819-4-pgonda@google.com>
Mime-Version: 1.0
References: <20211208191642.3792819-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 3/3] selftests: sev_migrate_tests: Add mirror command tests
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

Add tests to confirm mirror vms can only run correct subset of commands.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Marc Orr <marcorr@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 .../selftests/kvm/x86_64/sev_migrate_tests.c  | 55 +++++++++++++++++--
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index 4bb960ca6486..80056bbbb003 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -21,7 +21,7 @@
 #define NR_LOCK_TESTING_THREADS 3
 #define NR_LOCK_TESTING_ITERATIONS 10000
 
-static void sev_ioctl(int vm_fd, int cmd_id, void *data)
+static int __sev_ioctl(int vm_fd, int cmd_id, void *data, __u32 *fw_error)
 {
 	struct kvm_sev_cmd cmd = {
 		.id = cmd_id,
@@ -30,11 +30,20 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
 	};
 	int ret;
 
-
 	ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
-	TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
+	*fw_error = cmd.error;
+	return ret;
+}
+
+static void sev_ioctl(int vm_fd, int cmd_id, void *data)
+{
+	int ret;
+	__u32 fw_error;
+
+	ret = __sev_ioctl(vm_fd, cmd_id, data, &fw_error);
+	TEST_ASSERT(ret == 0 && fw_error == SEV_RET_SUCCESS,
 		    "%d failed: return code: %d, errno: %d, fw error: %d",
-		    cmd_id, ret, errno, cmd.error);
+		    cmd_id, ret, errno, fw_error);
 }
 
 static struct kvm_vm *sev_vm_create(bool es)
@@ -226,6 +235,42 @@ static void sev_mirror_create(int dst_fd, int src_fd)
 	TEST_ASSERT(!ret, "Copying context failed, ret: %d, errno: %d\n", ret, errno);
 }
 
+static void verify_mirror_allowed_cmds(int vm_fd)
+{
+	struct kvm_sev_guest_status status;
+
+	for (int cmd_id = KVM_SEV_INIT; cmd_id < KVM_SEV_NR_MAX; ++cmd_id) {
+		int ret;
+		__u32 fw_error;
+
+		/*
+		 * These commands are allowed for mirror VMs, all others are
+		 * not.
+		 */
+		switch (cmd_id) {
+		case KVM_SEV_LAUNCH_UPDATE_VMSA:
+		case KVM_SEV_GUEST_STATUS:
+		case KVM_SEV_DBG_DECRYPT:
+		case KVM_SEV_DBG_ENCRYPT:
+			continue;
+		default:
+			break;
+		}
+
+		/*
+		 * These commands should be disallowed before the data
+		 * parameter is examined so NULL is OK here.
+		 */
+		ret = __sev_ioctl(vm_fd, cmd_id, NULL, &fw_error);
+		TEST_ASSERT(
+			ret == -1 && errno == EINVAL,
+			"Should not be able call command: %d. ret: %d, errno: %d\n",
+			cmd_id, ret, errno);
+	}
+
+	sev_ioctl(vm_fd, KVM_SEV_GUEST_STATUS, &status);
+}
+
 static void test_sev_mirror(bool es)
 {
 	struct kvm_vm *src_vm, *dst_vm;
@@ -243,6 +288,8 @@ static void test_sev_mirror(bool es)
 	if (es)
 		sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 
+	verify_mirror_allowed_cmds(dst_vm->fd);
+
 	kvm_vm_free(src_vm);
 	kvm_vm_free(dst_vm);
 }
-- 
2.34.1.400.ga245620fadb-goog

