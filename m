Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E974E3A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiCVIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCVIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C3891A817
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UghuFZbDMRSZLidajgSjDvLEyY5ro+FG5IdVl25tP4=;
        b=JPBBty7mILfKmE9HhJ30rYXEvFsWTb1Q1KLKc/FjbwLFQ8PGNczttd2SZNFSbhFUtplqZX
        y6EPkHLcSfKdidKDfEwlaJ2XddoXPPQ19zKFhA70uEYxLABO1onVDLivjPHOncBwOpOev9
        1HcXh8CzH7Lgt01dCwcXjGDv33wNXw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-J-WMDEvYOaG0bArrNjkg9g-1; Tue, 22 Mar 2022 04:10:52 -0400
X-MC-Unique: J-WMDEvYOaG0bArrNjkg9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 271D0801E67;
        Tue, 22 Mar 2022 08:10:52 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E39F1121324;
        Tue, 22 Mar 2022 08:10:43 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 19/22] KVM: arm64: Support SDEI ioctl commands on vCPU
Date:   Tue, 22 Mar 2022 16:07:07 +0800
Message-Id: <20220322080710.51727-20-gshan@redhat.com>
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports ioctl commands on vCPU to manage the various object.
It's primarily used by VMM to accomplish migration. The ioctl
commands introduced by this are highlighted as below:

   * KVM_SDEI_CMD_GET_VCPU_EVENT_COUNT
     Return the total count of vCPU events, which have been queued
     on the target vCPU.

   * KVM_SDEI_CMD_GET_VCPU_EVENT
   * KVM_SDEI_CMD_SET_VCPU_EVENT
     Get or set vCPU events.

   * KVM_SDEI_CMD_GET_VCPU_STATE
   * KVM_SDEI_CMD_SET_VCPU_STATE
     Get or set vCPU state.

   * KVM_SDEI_CMD_INJECT_EVENT
     Inject SDEI event.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h            |   1 +
 arch/arm64/include/uapi/asm/kvm_sdei_state.h |   9 +
 arch/arm64/kvm/arm.c                         |   3 +
 arch/arm64/kvm/sdei.c                        | 299 +++++++++++++++++++
 4 files changed, 312 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 64f00cc79162..ea4f222cf73d 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -180,6 +180,7 @@ int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
 int kvm_sdei_cancel_event(struct kvm_vcpu *vcpu, unsigned long num);
 void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu);
 long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
+long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vm(struct kvm *kvm);
 
diff --git a/arch/arm64/include/uapi/asm/kvm_sdei_state.h b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
index 2bd6d11627bc..149451c5584f 100644
--- a/arch/arm64/include/uapi/asm/kvm_sdei_state.h
+++ b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
@@ -75,6 +75,12 @@ struct kvm_sdei_vcpu_state {
 #define KVM_SDEI_CMD_GET_REGISTERED_EVENT_COUNT	4
 #define KVM_SDEI_CMD_GET_REGISTERED_EVENT	5
 #define KVM_SDEI_CMD_SET_REGISTERED_EVENT	6
+#define KVM_SDEI_CMD_GET_VCPU_EVENT_COUNT	7
+#define KVM_SDEI_CMD_GET_VCPU_EVENT		8
+#define KVM_SDEI_CMD_SET_VCPU_EVENT		9
+#define KVM_SDEI_CMD_GET_VCPU_STATE		10
+#define KVM_SDEI_CMD_SET_VCPU_STATE		11
+#define KVM_SDEI_CMD_INJECT_EVENT		12
 
 struct kvm_sdei_cmd {
 	__u32                                           cmd;
@@ -85,6 +91,9 @@ struct kvm_sdei_cmd {
 	union {
 		struct kvm_sdei_exposed_event_state     *exposed_event_state;
 		struct kvm_sdei_registered_event_state  *registered_event_state;
+		struct kvm_sdei_vcpu_event_state	*vcpu_event_state;
+		struct kvm_sdei_vcpu_state		*vcpu_state;
+		__u64					num;
 	};
 };
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ebfd504a1c08..3f532e1c4a95 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1387,6 +1387,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_finalize(vcpu, what);
 	}
+	case KVM_ARM_SDEI_COMMAND: {
+		return kvm_sdei_vcpu_ioctl(vcpu, arg);
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index d9cf494990a9..06895ac73c24 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -1567,6 +1567,305 @@ long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg)
 	return ret;
 }
 
+static long vcpu_ioctl_get_vcpu_event(struct kvm_vcpu *vcpu,
+				      struct kvm_sdei_cmd *cmd)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *vcpu_event;
+	struct kvm_sdei_vcpu_event_state *state;
+	void __user *user_state = (void __user *)(cmd->vcpu_event_state);
+	unsigned int count, i;
+	long ret = 0;
+
+	if (!cmd->count)
+		return 0;
+
+	state = kcalloc(cmd->count, sizeof(*state), GFP_KERNEL_ACCOUNT);
+	if (!state)
+		return -ENOMEM;
+
+	i = 0;
+	count = cmd->count;
+	list_for_each_entry(vcpu_event, &vsdei->critical_events, link) {
+		state[i++] = vcpu_event->state;
+		if (!--count)
+			break;
+	}
+
+	if (count) {
+		list_for_each_entry(vcpu_event, &vsdei->normal_events, link) {
+			state[i++] = vcpu_event->state;
+			if (!--count)
+				break;
+		}
+	}
+
+	if (copy_to_user(user_state, state, sizeof(*state) * cmd->count))
+		ret = -EFAULT;
+
+	kfree(state);
+	return ret;
+}
+
+static long vcpu_ioctl_set_vcpu_event(struct kvm_vcpu *vcpu,
+				      struct kvm_sdei_cmd *cmd)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+	struct kvm_sdei_vcpu_event *vcpu_event;
+	struct kvm_sdei_vcpu_event_state *state;
+	void __user *user_state = (void __user *)(cmd->vcpu_event_state);
+	unsigned int vcpu_event_count, i, j;
+	long ret = 0;
+
+	if (!cmd->count)
+		return 0;
+
+	state = kcalloc(cmd->count, sizeof(*state), GFP_KERNEL_ACCOUNT);
+	if (!state)
+		return -ENOMEM;
+
+	if (copy_from_user(state, user_state, sizeof(*state) * cmd->count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	vcpu_event_count = vsdei->critical_event_count +
+			   vsdei->normal_event_count;
+	for (i = 0; i < cmd->count; i++) {
+		if (!kvm_sdei_is_supported(state[i].num)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Check if the event has been exposed */
+		exposed_event = find_exposed_event(kvm, state[i].num);
+		if (!exposed_event) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		/* Check if the event has been registered */
+		registered_event = find_registered_event(kvm, state[i].num);
+		if (!registered_event) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		/*
+		 * Calculate the total count of the vcpu event instances.
+		 * We needn't a new vcpu event instance if it is existing
+		 * or a duplicated event.
+		 */
+		vcpu_event = find_vcpu_event(vcpu, state[i].num);
+		if (vcpu_event)
+			continue;
+
+		for (j = 0; j < cmd->count; j++) {
+			if (j != i && state[j].num == state[i].num)
+				break;
+		}
+
+		if (j >= cmd->count || i < j)
+			vcpu_event_count++;
+	}
+
+	/*
+	 * Check if the required count of vcpu event instances exceeds
+	 * the limit.
+	 */
+	if (vcpu_event_count > KVM_SDEI_MAX_EVENTS) {
+		ret = -ERANGE;
+		goto out;
+	}
+
+	for (i = 0; i < cmd->count; i++) {
+		/* The vcpu event might have been existing */
+		vcpu_event = find_vcpu_event(vcpu, state[i].num);
+		if (vcpu_event) {
+			vcpu_event->state.event_count += state[i].event_count;
+			continue;
+		}
+
+		vcpu_event = kzalloc(sizeof(*vcpu_event), GFP_KERNEL_ACCOUNT);
+		if (!vcpu_event) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		registered_event = find_registered_event(kvm, state[i].num);
+		exposed_event = registered_event->exposed_event;
+
+		vcpu_event->state            = state[i];
+		vcpu_event->registered_event = registered_event;
+		vcpu_event->vcpu             = vcpu;
+
+		registered_event->vcpu_event_count++;
+		if (kvm_sdei_is_critical(exposed_event->state.priority)) {
+			list_add_tail(&vcpu_event->link,
+				      &vsdei->critical_events);
+			vsdei->critical_event_count++;
+		} else {
+			list_add_tail(&vcpu_event->link,
+				      &vsdei->normal_events);
+			vsdei->normal_event_count++;
+		}
+	}
+
+out:
+	kfree(state);
+	return ret;
+}
+
+static long vcpu_ioctl_set_vcpu_state(struct kvm_vcpu *vcpu,
+				      struct kvm_sdei_cmd *cmd)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *critical_vcpu_event = NULL;
+	struct kvm_sdei_vcpu_event *normal_vcpu_event = NULL;
+	struct kvm_sdei_vcpu_state *state;
+	void __user *user_state = (void __user *)(cmd->vcpu_state);
+	long ret = 0;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL_ACCOUNT);
+	if (!state)
+		return -ENOMEM;
+
+	if (copy_from_user(state, user_state, sizeof(*state))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (kvm_sdei_is_supported(state->critical_num)) {
+		critical_vcpu_event = find_vcpu_event(vcpu,
+						      state->critical_num);
+		if (!critical_vcpu_event) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (kvm_sdei_is_supported(state->normal_num)) {
+		normal_vcpu_event = find_vcpu_event(vcpu, state->normal_num);
+		if (!normal_vcpu_event) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	vsdei->state          = *state;
+	vsdei->critical_event = critical_vcpu_event;
+	vsdei->normal_event   = normal_vcpu_event;
+
+	/*
+	 * To deliver the vCPU events if we don't have a valid handler
+	 * running. Otherwise, the vCPU events should be delivered when
+	 * the running handler is completed.
+	 */
+	if (!vsdei->critical_event && !vsdei->normal_event &&
+	    (vsdei->critical_event_count + vsdei->normal_event_count) > 0)
+		kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+out:
+	kfree(state);
+	return ret;
+}
+
+static long vcpu_ioctl_inject_event(struct kvm_vcpu *vcpu,
+				    struct kvm_sdei_cmd *cmd)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+	int index;
+
+	if (!kvm_sdei_is_supported(cmd->num))
+		return -EINVAL;
+
+	registered_event = find_registered_event(kvm, cmd->num);
+	if (!registered_event)
+		return -ENOENT;
+
+	exposed_event = registered_event->exposed_event;
+	index = kvm_sdei_vcpu_index(vcpu, exposed_event);
+	if (!kvm_sdei_is_registered(registered_event, index) ||
+	    !kvm_sdei_is_enabled(registered_event, index) ||
+	    kvm_sdei_is_unregister_pending(registered_event, index))
+		return -EPERM;
+
+	if (vsdei->state.masked)
+		return -EPERM;
+
+	return do_inject_event(vcpu, registered_event, false);
+}
+
+long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_cmd *cmd = NULL;
+	void __user *argp = (void __user *)arg;
+	long ret = 0;
+
+	if (!(ksdei && vsdei)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL_ACCOUNT);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(cmd, argp, sizeof(*cmd))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+	spin_lock(&vsdei->lock);
+
+	switch (cmd->cmd) {
+	case KVM_SDEI_CMD_GET_VCPU_EVENT_COUNT:
+		cmd->count = vsdei->critical_event_count +
+			     vsdei->normal_event_count;
+		if (copy_to_user(argp, cmd, sizeof(*cmd)))
+			ret = -EFAULT;
+		break;
+	case KVM_SDEI_CMD_GET_VCPU_EVENT:
+		ret = vcpu_ioctl_get_vcpu_event(vcpu, cmd);
+		break;
+	case KVM_SDEI_CMD_SET_VCPU_EVENT:
+		ret = vcpu_ioctl_set_vcpu_event(vcpu, cmd);
+		break;
+	case KVM_SDEI_CMD_GET_VCPU_STATE:
+		if (copy_to_user(cmd->vcpu_state, &vsdei->state,
+				 sizeof(vsdei->state)))
+			ret = -EFAULT;
+		break;
+	case KVM_SDEI_CMD_SET_VCPU_STATE:
+		ret = vcpu_ioctl_set_vcpu_state(vcpu, cmd);
+		break;
+	case KVM_SDEI_CMD_INJECT_EVENT:
+		ret = vcpu_ioctl_inject_event(vcpu, cmd);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	spin_unlock(&vsdei->lock);
+	spin_unlock(&ksdei->lock);
+
+out:
+	kfree(cmd);
+	return ret;
+}
+
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-- 
2.23.0

