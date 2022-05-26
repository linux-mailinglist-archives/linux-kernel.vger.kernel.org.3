Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD95352E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbiEZRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiEZRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:54:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F98C03BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:30 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z186-20020a6233c3000000b00510a6bc2864so1309565pfz.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FRI3yOd2jBqllb9cCkfyWs3M3poFKw/VaB/vECthXc0=;
        b=qaLYC8O0iC/49VvNbNC4/d+/0PPNhyiS1NmDCxgYJI6YRSk4bOI/2G1qfmi5uArvAr
         +ihmPwxft3+Xie9rw/VuqSYu1q+T7tg4iaOwyNwsEYOG7Y5ckgHyhSLDjMC7dvl4H0Sa
         3UDvXdYrW1B2M3pqqDVFxus5CHojluv1mp8W6eVqHHIX/XI1Xejr4k6xpx1hKYpyjTzh
         q8fV6/jUKCI/EEG/JaukT2qQDAMPhS87QdMSAfoaDLGOe1zNnKoulrhr3ybYJ7d4NbGd
         5th9CjEyr4mSvsn/ncspBqPm7JyDzgZfS0wmfaioWvJ4HZIUe27gUvYj2ytH3T2aa8I/
         GQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FRI3yOd2jBqllb9cCkfyWs3M3poFKw/VaB/vECthXc0=;
        b=PqKJnaKH2FKqFZDBXm9udohwJEXAMlIZryKeHgbpkEYjXkeNdm4U0alXbgRK8HXJFD
         yf2xMUtoTiCx7VFKO6EKddilZ37G2QH7DqZ/NA04l5ehWGA8Offkj2YyNDBqDfdGfWlx
         zRZTUwVQar99Xbh0J5VVCnsBKDqw5VCPo1cJv9V6VYnvIHRbSkfvSmGmsdHxMJY9p5zK
         GjCumhfnkR7DjlrLr7HprUrz4d1PiPYOhLn2ir22Ur23+UEDphiCtubNmx/Oo9Wn7HY8
         jj6nm9IMrDyRGXeF17m2BUsgfOalNMD499EkL4F8/dkX3tex1GwAwoMawqcXtnEmtECy
         Hgog==
X-Gm-Message-State: AOAM532lID3w/ZRSsIUB31ElSx3rH6wkSlHZEF8dEr7hcZMDKThImgBq
        Um1tS4WZo0EQQnos3qau92j32xVcDm4D
X-Google-Smtp-Source: ABdhPJwiQksr/pw7CYHck0RR+tFA/cI985RJqtaX3uK/hhC4hDNVaZ2egzRl+njfFBnFaWvq9tHOXyPjVXcH
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90b:1192:b0:1e0:63f3:c463 with SMTP id
 gk18-20020a17090b119200b001e063f3c463mr184161pjb.1.1653587669619; Thu, 26 May
 2022 10:54:29 -0700 (PDT)
Date:   Thu, 26 May 2022 17:54:08 +0000
In-Reply-To: <20220526175408.399718-1-bgardon@google.com>
Message-Id: <20220526175408.399718-12-bgardon@google.com>
Mime-Version: 1.0
References: <20220526175408.399718-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v8 11/11] KVM: selftests: Cache binary stats metadata for
 duration of test
From:   Ben Gardon <bgardon@google.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
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
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 ++++++++++---------
 .../selftests/kvm/lib/kvm_util_internal.h     |  5 +++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 33d4d64c1391..a32b7b4352b9 100644
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
@@ -2694,34 +2700,30 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
 void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 		   size_t max_elements)
 {
-	struct kvm_stats_desc *stats_desc;
-	struct kvm_stats_header header;
 	struct kvm_stats_desc *desc;
 	size_t size_desc;
-	int stats_fd;
 	int i;
 
-	stats_fd = vm_get_stats_fd(vm);
-
-	read_stats_header(stats_fd, &header);
-
-	stats_desc = read_stats_descriptors(stats_fd, &header);
+	if (!vm->stats_fd) {
+		vm->stats_fd = vm_get_stats_fd(vm);
+		read_stats_header(vm->stats_fd, &vm->stats_header);
+		vm->stats_desc = read_stats_descriptors(vm->stats_fd,
+							&vm->stats_header);
+	}
 
-	size_desc = get_stats_descriptor_size(&header);
+	size_desc = get_stats_descriptor_size(&vm->stats_header);
 
-	for (i = 0; i < header.num_desc; ++i) {
-		desc = (void *)stats_desc + (i * size_desc);
+	for (i = 0; i < vm->stats_header.num_desc; ++i) {
+		desc = (void *)vm->stats_desc + (i * size_desc);
 
 		if (strcmp(desc->name, stat_name))
 			continue;
 
-		read_stat_data(stats_fd, &header, desc, data, max_elements);
+		read_stat_data(vm->stats_fd, &vm->stats_header, desc,
+			       data, max_elements);
 
 		break;
 	}
-
-	free(stats_desc);
-	close(stats_fd);
 }
 
 /* VM disable NX huge pages
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
2.36.1.124.g0e6072fb45-goog

