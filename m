Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDA54A160
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352095AbiFMVaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353195AbiFMV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:29:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB1BFC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:43 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t24-20020a170902b21800b00168e27c3c2aso1670723plr.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2HZEMfRIxWFvhgNolJdHE+4fmvokBk1d/agQn4Bf6T4=;
        b=RdGzy/6cYG/hqt377t5RGc5j2qzeneOwISpagbEXNwhnJRGvEuJRIOJNxRgc1uaD9J
         z1XHzQ3qx6rtvshQtkND+/6k5zcdfEmAGAQe4MBNv37e95zUI5qlEr+ukkA7NSdUsA1z
         SRcW9mBtWtFzBGnm/P9jSA8P/+/B31FIzTXSkjfDUHBHwnMuu6nFLEgVutqEPjNF2Njr
         I6aapXMjXkcuw4mTcC+r8vW3kDTpnhz1sSNktr6TUaIlqZg7AJ94G0IPUs8ZUmEDzxES
         JsjLZl1f2MpBzRN6+L3kZ6u7UkB6aktI6zG3HWkWXJN/vQ/rnFhG9lnuDv6PFe1YDY69
         nI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2HZEMfRIxWFvhgNolJdHE+4fmvokBk1d/agQn4Bf6T4=;
        b=e25NBaTEcm/0/OoxAskAY4ZmVRmwZ2c6DhpRvrR1JDdnBoA04DAooF5YQIdC4r3BGY
         eiOGVB0ZhzwkIx+Y5+QUc683lkPJhMRGhGqu0puhgp+ynqT29N61W3IQ3VefXMsYggPU
         EeJvb+PQXPu4pdv6OmB30I6xsYvDWMNj+ggbonF2BpndIIWsf6/IFjm7iEasc5tiKu2D
         wDr/6UTE8hexNBI7VfCAsW8HtrZFJgFlIllyAErODZ8dI0PN/YyGNdSJvx6hj8ylOR6Q
         GZtwrxa8sISU8cFemYu8gUj4nWaMWHcddVhu9mdWe/szcP/kLhCxeHxYoPzOjEwJo8M5
         lAkw==
X-Gm-Message-State: AJIora9Hx8tqWKShpB5/Mo7DUvkhqwy+Zjk5sxt0WB/FcdqvVek18iDM
        FIeZiFK82cmWEF+0NM4OC15RYIjbLOAt
X-Google-Smtp-Source: AGRyM1vSLQ762BI4fr+CHdSH7bPhrBuiIxkFdEVnBv9ahJasB6kow7g6SLnoXz4WYJnTfC/qn+sEUP/QTeGX
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90b:1192:b0:1e2:da25:4095 with SMTP id
 gk18-20020a17090b119200b001e2da254095mr737030pjb.240.1655155542892; Mon, 13
 Jun 2022 14:25:42 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:25:23 +0000
In-Reply-To: <20220613212523.3436117-1-bgardon@google.com>
Message-Id: <20220613212523.3436117-11-bgardon@google.com>
Mime-Version: 1.0
References: <20220613212523.3436117-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v9 10/10] KVM: selftests: Cache binary stats metadata for
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve performance across multiple reads of VM stats, cache
the stats metadata in the VM struct.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  5 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 ++++++++++---------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 537b8a047d6e..daf201174d2a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -84,6 +84,11 @@ struct kvm_vm {
 	vm_vaddr_t idt;
 	vm_vaddr_t handlers;
 	uint32_t dirty_ring_size;
+
+	/* Cache of information for binary stats interface */
+	int stats_fd;
+	struct kvm_stats_header stats_header;
+	struct kvm_stats_desc *stats_desc;
 };
 
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0d97142a590e..787aeb0c61f3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -551,6 +551,12 @@ void kvm_vm_free(struct kvm_vm *vmp)
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
@@ -1942,32 +1948,28 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
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
-- 
2.36.1.476.g0c4daa206d-goog

