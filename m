Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717AD5AA409
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiIBAGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiIBAGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:06:14 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD301277D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:04:53 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 200-20020a6217d1000000b00538090d37f3so158502pfx.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=5gPjCSpHzU5Z7eKGiC471fWp4jVAqCZ8Pi31iwjnHEs=;
        b=SsVyZGnCRUq9Ewn7TYsETMlR9U1gmzntjJQ8CXjn4iA9jvrkrjVmnbn8j0pxbksuRj
         sLKpginlNiaIHoQyFirkZO3FJAwtsb5nbwyEtSa7g6xQ0Bk5hrKEQuD7DEfTw5I5I2n0
         q5hdZPSUeN7LtrpKkfB12gpFg2WKUhbsIiJzbVtNwysOrv+EO2XZdzC/fMHN9BRgKCyf
         fhuij0B0/pK6Da3cr6bmnJavz+IdoMHuALY1d2yG52ZW3zBeLk8x7PCUD5rQfMukS065
         WOjGtH/2wOOmy+wsl9MNxUIPrCP6bt3QvewTusOeQtlrbTm2oLNa54Qq8SVG5KFmkafE
         eHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5gPjCSpHzU5Z7eKGiC471fWp4jVAqCZ8Pi31iwjnHEs=;
        b=bmE2kTf0JMrR6d3IU69gfpYYudOUO9bVCykhDkMo0sHYpur/cFjMnJxcqPKYTff7uZ
         A01bMjLehIV05yIPIXfWsLw2IwWM0ko0s2PvjN/gLzDhW6C8C54L5hDtR74uR0RbzGBC
         1Xw+LF7Z8h80xObOeWStkObE07MEN3jLzaS0hne6iSaJQ0VdWCaD7d05TOZFCe2VKczy
         n1xx7x8LMv0Bpuhr2j5tZbe2wBW76EMiF2vth7xOyeAoXD2bBc2ioK9M2hBxay32ps0Z
         sKKNWRuaiV4S7cNctUWrTdzuQXHONV/UodqriW5H7SDAzH32wf2rJAGCDhR5IXmS3nZM
         wCTw==
X-Gm-Message-State: ACgBeo1fdQqwKgxMQ5FV5XkkcQ77nc5hZFSQE+IzcDxi98Y+gA5SKKmU
        gdzY1sSnRGmJhMjfV4pekAiZ6XgKeWZ5dJemAkpsTly69WNZZ5DpyJ9vjjVK0dZbjEE5jNyIe/z
        toYltu8B4LIYHmM3cgYajmPuHuCn/JD0HfuoNmzVjf2WaBCtW+TmE4Ee2M1K5r/txsmEtfftjsK
        JTESnHbQI=
X-Google-Smtp-Source: AA6agR7A9AXCsK9vWhBhcRvfcuE0NhJfrCrpJ5upBa+Pj+o9RLC3146s3SWxJSks7/8b3E00FD0CmjLvdhHgvoTuWw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a63:de02:0:b0:428:9e02:5f3e with SMTP
 id f2-20020a63de02000000b004289e025f3emr28708564pgg.592.1662077093155; Thu,
 01 Sep 2022 17:04:53 -0700 (PDT)
Date:   Fri,  2 Sep 2022 00:04:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902000439.875476-1-dionnaglaze@google.com>
Subject: [PATCH 1/2] x86/sev: Add KVM commands for instance certs
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
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

The /dev/sev device has the ability to store host-wide certificates for
the key used by the AMD-SP for SEV-SNP attestation report signing,
but for hosts that want to specify additional certificates that are
specific to the image launched in a VM, we need a different way to
communicate those certificates.

This patch adds two new KVM ioctl commands: KVM_SEV_SNP_{GET,SET}_CERTS

The certificates that are set with this command are expected to follow
the same format as the host certificates, but that format is opaque
to the kernel.

The new behavior for custom certificates is that the extended guest
request command will now return the overridden certificates if they
were installed for the instance. The error condition for a too small
data buffer is changed to return the overridden certificate data size
if there is an overridden certificate set installed.

Setting a 0 length certificate returns the system state to only return
the host certificates on an extended guest request.

We also increase the SEV_FW_BLOB_MAX_SIZE another 4K page to allow
space for an extra certificate.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c   | 111 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h   |   1 +
 include/linux/psp-sev.h  |   2 +-
 include/uapi/linux/kvm.h |  12 +++++
 4 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a35cd9f33f16..f1d846081213 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1636,6 +1636,7 @@ static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_free;
 
 	sev->snp_certs_data = certs_data;
+	sev->snp_certs_len = 0;
 
 	return context;
 
@@ -1940,6 +1941,86 @@ static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int snp_get_instance_certs(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct kvm_sev_snp_get_certs params;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (!sev->snp_context)
+		return -EINVAL;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
+			   sizeof(params)))
+		return -EFAULT;
+
+	/* No instance certs set. */
+	if (!sev->snp_certs_len)
+		return -ENOENT;
+
+	if (params.certs_len < sev->snp_certs_len) {
+		/* Output buffer too small. Return the required size. */
+		params.certs_len = sev->snp_certs_len;
+
+		if (copy_to_user((void __user *)(uintptr_t)argp->data, &params,
+				 sizeof(params)))
+			return -EFAULT;
+
+		return -EINVAL;
+	}
+
+	if (copy_to_user((void __user *)(uintptr_t)params.certs_uaddr,
+			 sev->snp_certs_data, sev->snp_certs_len))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int snp_set_instance_certs(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct kvm_sev_snp_set_certs params;
+	void *new_certs = NULL, *to_certs = sev->snp_certs_data;
+	unsigned long length = SEV_FW_BLOB_MAX_SIZE;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (!sev->snp_context)
+		return -EINVAL;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
+			   sizeof(params)))
+		return -EFAULT;
+
+	if (params.certs_len > SEV_FW_BLOB_MAX_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Setting a length of 0 is the same as "uninstalling" instance-
+	 * specific certificates.
+	 */
+	if (params.certs_len == 0) {
+		sev->snp_certs_len = 0;
+		return 0;
+	}
+
+	/* Page-align the length */
+	length = (params.certs_len + PAGE_SIZE - 1) & PAGE_MASK;
+
+	if (copy_from_user(to_certs,
+			   (void __user *)(uintptr_t)params.certs_uaddr,
+			   params.certs_len)) {
+		return -EFAULT;
+	}
+
+	sev->snp_certs_len = length;
+
+	return 0;
+}
+
 int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -2038,6 +2119,12 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_SNP_LAUNCH_FINISH:
 		r = snp_launch_finish(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SNP_GET_CERTS:
+		r = snp_get_instance_certs(kvm, &sev_cmd);
+		break;
+	case KVM_SEV_SNP_SET_CERTS:
+		r = snp_set_instance_certs(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
@@ -3361,8 +3448,28 @@ static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gp
 	if (rc)
 		goto unlock;
 
-	rc = snp_guest_ext_guest_request(&req, (unsigned long)sev->snp_certs_data,
-					 &data_npages, &err);
+	/*
+	 * If the VMM has overridden the certs, then we change the error message
+	 * if the size is inappropriate for the override. Otherwise we use a
+	 * regular guest request and copy back the instance certs.
+	 */
+	if (sev->snp_certs_len) {
+		if ((data_npages << PAGE_SHIFT) < sev->snp_certs_len) {
+			rc = -EINVAL;
+			err = SNP_GUEST_REQ_INVALID_LEN;
+			goto datalen;
+		}
+		rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &req,
+				   (int *)&err);
+	} else {
+		rc = snp_guest_ext_guest_request(
+			&req, (unsigned long)sev->snp_certs_data, &data_npages,
+			&err);
+	}
+datalen:
+	if (sev->snp_certs_len)
+		data_npages = sev->snp_certs_len >> PAGE_SHIFT;
+
 	if (rc) {
 		/*
 		 * If buffer length is small then return the expected
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e68b3aab57d6..9030a295cdf5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -93,6 +93,7 @@ struct kvm_sev_info {
 	void *snp_context;      /* SNP guest context page */
 	struct srcu_struct psc_srcu;
 	void *snp_certs_data;
+	unsigned int snp_certs_len; /* Size of instance override for certs */
 	struct mutex guest_req_lock;
 
 	u64 sev_features;	/* Features set at VMSA creation */
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 859bbbcd5fa3..3d1811ffd9af 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -24,7 +24,7 @@
 #define __psp_pa(x)	__pa(x)
 #endif
 
-#define SEV_FW_BLOB_MAX_SIZE	0x4000	/* 16KB */
+#define SEV_FW_BLOB_MAX_SIZE	0x5000	/* 20KB */
 
 /**
  * SEV platform state
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index db9eb36da3ec..d47b36dc681d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1717,6 +1717,8 @@ enum sev_cmd_id {
 	KVM_SEV_SNP_LAUNCH_START,
 	KVM_SEV_SNP_LAUNCH_UPDATE,
 	KVM_SEV_SNP_LAUNCH_FINISH,
+	KVM_SEV_SNP_GET_CERTS,
+	KVM_SEV_SNP_SET_CERTS,
 
 	KVM_SEV_NR_MAX,
 };
@@ -1864,6 +1866,16 @@ struct kvm_sev_snp_launch_finish {
 	__u8 pad[6];
 };
 
+struct kvm_sev_snp_get_certs {
+	__u64 certs_uaddr;
+	__u64 certs_len;
+};
+
+struct kvm_sev_snp_set_certs {
+	__u64 certs_uaddr;
+	__u64 certs_len;
+};
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-- 
2.37.2.789.g6183377224-goog

