Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6E8518C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbiECSfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbiECSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:34:51 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290663F8AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:31:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a11-20020a170902900b00b0015ebbae6dd9so809139plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kdhiU9fwdUmCUThSgoTZng+IDRrmraex/lfG5pPhseg=;
        b=c8DzY+1F+9gWJxr1pR9f+htywCO1jkCNviVAvOHO019VMJ2e5OILY0r5nmZJBc+l7A
         Gwt3R7gK6uP809S23n7mTj2sgBSIPR59yCQy0r3V03W5Kyh72v1VMdFmDEwjqOCwLeT5
         9n/jwpwUnGU8eZkJ9HWCY4Ww2OWYkhmWA3tvEhAP0C/WHoLMx+3pzECx/tMk5vBeGk5i
         rZ6a863DDoqtaEOcMTei0/unIGLeuiEvCwGE8q0A/g32UcWogIeTDuN2S1E43Krcs8j7
         ww0TAtnJkRFeVMuSHwWqVeZKn3v09y7dGsMGEArk3MMiOVlFjRKt0no3x73rE70wh00N
         2IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kdhiU9fwdUmCUThSgoTZng+IDRrmraex/lfG5pPhseg=;
        b=y+xgrDeZVcXgvAECO/HhkPmcYw4RFI7F3lF5MC/K3Q4+qbXxBJHLolUpfOR0upLe2T
         2S8PoDeJADKpuM87l9Ze2dXj5Wn49GPMPA/i1x5ElC+IoZD647jOIWVmsUkreEfH8cJv
         r8b0b2IyvJEveYnWmpf3xVRXulsPZwbXG8nVripViCq5QR0sxYBMi5F+7PG6EKCBAcvm
         TtRfW/C6hkVXFFtx8OcQ9qwlJcXZ/tMbBzpcStUmCfKrDYdMJxbCrZX/Y9+36sEJCEt2
         8GVZ7J3ma4LrnTWvfuu2AOL442RFs8O26Ryl8PmVjad+2IaFSSlnzDgZ131XmHRhwrGF
         ebWg==
X-Gm-Message-State: AOAM531mRaZbaxa9lCpicgowP8QJ9szyI9mcuHM0HKNfRD6RZQDD1sjO
        qsgDLzZcuyN/OC25xCp8rbFEPTBhdXyULh3rh6ztxYSKQ9DvQyTrWgT1u6PWB+zY4pmD/c1CNAj
        /O8w+QGC4uVihC3kl0Sgdriff5mju0ygPxzmCSwDtp9Sjj6MXrx59EegcdeljI6LKI+P3Uhy1
X-Google-Smtp-Source: ABdhPJxlCSSj5oS9+YkkTe2pxdKzfgfB0SGrTOFE9i3HpygSw76Igjy+5YIFfuGMaV2X+WJZag9fF/HyoIhX
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90b:f03:b0:1d9:a8e9:9e35 with SMTP id
 br3-20020a17090b0f0300b001d9a8e99e35mr6253446pjb.48.1651602665962; Tue, 03
 May 2022 11:31:05 -0700 (PDT)
Date:   Tue,  3 May 2022 18:30:45 +0000
In-Reply-To: <20220503183045.978509-1-bgardon@google.com>
Message-Id: <20220503183045.978509-12-bgardon@google.com>
Mime-Version: 1.0
References: <20220503183045.978509-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v7 11/11] KVM: selftests: Cache binary stats metadata for
 duration of test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
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

In order to improve performance across multiple reads of VM stats, cache
the stats metadata in the VM struct.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c    | 31 ++++++++++---------
 .../selftests/kvm/lib/kvm_util_internal.h     |  5 +++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0ec7efc2900d..4bb012efcc88 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -736,6 +736,12 @@ void kvm_vm_free(struct kvm_vm *vmp)
 	if (vmp == NULL)
 		return;
 
+	/* Free cached stats metadata and close FD */
+	if (vmp->stats_fd) {
+		free(vmp->stats_desc);
+		close(vmp->stats_fd);
+	}
+
 	/* Free userspace_mem_regions. */
 	hash_for_each_safe(vmp->regions.slot_hash, ctr, node, region, slot_node)
 		__vm_mem_region_delete(vmp, region, false);
@@ -2703,37 +2709,32 @@ int read_stat_data(int stats_fd, struct kvm_stats_header *header,
 static int __vm_get_stat(struct kvm_vm *vm, const char *stat_name,
 			 uint64_t *data, ssize_t max_elements)
 {
-	struct kvm_stats_desc *stats_desc;
-	struct kvm_stats_header header;
 	struct kvm_stats_desc *desc;
 	size_t size_desc;
-	int stats_fd;
 	int ret = -EINVAL;
 	int i;
 
-	stats_fd = vm_get_stats_fd(vm);
-
-	read_stats_header(stats_fd, &header);
-
-	stats_desc = read_stats_desc(stats_fd, &header);
+	if (!vm->stats_fd) {
+		vm->stats_fd = vm_get_stats_fd(vm);
+		read_stats_header(vm->stats_fd, &vm->stats_header);
+		vm->stats_desc = read_stats_desc(vm->stats_fd, &vm->stats_header);
+	}
 
-	size_desc = sizeof(struct kvm_stats_desc) + header.name_size;
+	size_desc = sizeof(struct kvm_stats_desc) + vm->stats_header.name_size;
 
 	/* Read kvm stats data one by one */
-	for (i = 0; i < header.num_desc; ++i) {
-		desc = (void *)stats_desc + (i * size_desc);
+	for (i = 0; i < vm->stats_header.num_desc; ++i) {
+		desc = (void *)vm->stats_desc + (i * size_desc);
 
 		if (strcmp(desc->name, stat_name))
 			continue;
 
-		ret = read_stat_data(stats_fd, &header, desc, data,
-				     max_elements);
+		ret = read_stat_data(vm->stats_fd, &vm->stats_header, desc,
+				     data, max_elements);
 
 		break;
 	}
 
-	free(stats_desc);
-	close(stats_fd);
 	return ret;
 }
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index a03febc24ba6..e753edd7b8d3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -67,6 +67,11 @@ struct kvm_vm {
 	vm_vaddr_t idt;
 	vm_vaddr_t handlers;
 	uint32_t dirty_ring_size;
+
+	/* Cache of information for binary stats interface */
+	int stats_fd;
+	struct kvm_stats_header stats_header;
+	struct kvm_stats_desc *stats_desc;
 };
 
 struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid);
-- 
2.36.0.464.gb9c8b46e94-goog

