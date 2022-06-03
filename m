Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1048453C2D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiFCAqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiFCAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:44:22 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA3D344F6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:44:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c4-20020a170902c2c400b0015f16fb4a54so3464809pla.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Tb5TEdt+uXDSL4SoIzZZFsxwZQPMR2JHTQw9ksqwQts=;
        b=pJrqvp20adHQPHwxo67IrBL6Ni2dd8QcTANk5X7fy/+VvSeosGEB9JVrjMTdMfncZd
         LHeLK/Z+hPmM2PC2dtvom4/9K/ElgYxycRPtYfhgU0o7xMme6A/X1PPz30F9rGKk0ACV
         0nhvHwnGhljMHW88UlLNxtmE4cACxtxZ9KMi+jj+z93ZM3zg91ziQ9Hj5p9pjRAK7gDH
         zHA5fUli1JgX2XbyrF0A5bQ88KFhcI7mfEg6GfSShptRNjPHh7tU8RsG9Ly5J0W5/enm
         mO7ZCt2flqB7ZQFZyAitnsIPw0Y0vEqEIh746X6suO9r4SLwRgwqvscozkteBGo5clZ6
         R4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Tb5TEdt+uXDSL4SoIzZZFsxwZQPMR2JHTQw9ksqwQts=;
        b=VFNz7KTMUQ1C+rXeK4mHOOFJNL7+R/DKbqCxQs6OyYm2NnQQj32DwWyKMdAyWe/McT
         uOdyPEPk6HNIx8+/QqLqPQaJreRMZuTA3H+Z0bKlrZqzcCh4YuV2SNMPON6fNg/t/T/8
         4uObddEVaJXJ+DETP4foNFIOhQ/qiGUIMN+OWfgdxoM71KQWlviQGVUpT6YRsQGtaaa8
         hxnyD6EIFugDFmk5wLgNT2JqsDZETJgIUI3e9z8zckj2paBeDr1Ix0mFUW+6He2FrSOb
         4XhzI6/YiKCiXJuasOe4z2xUm9D7Un/BdF687bYjQLn41gBn8snpHUPS//E0NMBVrBTC
         Ld0Q==
X-Gm-Message-State: AOAM532YR3BO21oM+cDcAOuNVsVt7K3nlVtRfsrJklcg3dJYcNl+4s0c
        S35tXSYXUlstBPflUZyVfn7QmS58NSI=
X-Google-Smtp-Source: ABdhPJzIw3yAqKK0Db9aZAs5dBKRwwzsmcWWK4AOkJUdNw7i4athrd2iUcoQdf6yvQdLXDnCqIBYu9xyHlM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:246:b0:153:84fe:a9b0 with SMTP id
 j6-20020a170903024600b0015384fea9b0mr7562370plh.163.1654217051960; Thu, 02
 Jun 2022 17:44:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:27 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-21-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 020/144] KVM: selftests: Make x86-64's register dump
 helpers static
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Make regs_dump() and sregs_dump() static, they're only implemented by
x86 and only used internally.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/kvm_util_internal.h     | 34 ------------------
 .../selftests/kvm/lib/x86_64/processor.c      | 36 ++-----------------
 2 files changed, 2 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index 0c7c44499129..544b90df2f80 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -88,40 +88,6 @@ struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
  */
 void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
 
-/*
- * Register Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   regs   - Registers
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the registers given by @regs, to the FILE stream
- * given by @stream.
- */
-void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent);
-
-/*
- * System Register Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   sregs  - System registers
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the system registers given by @sregs, to the FILE stream
- * given by @stream.
- */
-void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent);
-
 struct userspace_mem_region *
 memslot2region(struct kvm_vm *vm, uint32_t memslot);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 6113cf6bb238..93726d8cac44 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -19,8 +19,7 @@
 
 vm_vaddr_t exception_handlers;
 
-void regs_dump(FILE *stream, struct kvm_regs *regs,
-	       uint8_t indent)
+static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
 	fprintf(stream, "%*srax: 0x%.16llx rbx: 0x%.16llx "
 		"rcx: 0x%.16llx rdx: 0x%.16llx\n",
@@ -43,21 +42,6 @@ void regs_dump(FILE *stream, struct kvm_regs *regs,
 		regs->rip, regs->rflags);
 }
 
-/*
- * Segment Dump
- *
- * Input Args:
- *   stream  - Output FILE stream
- *   segment - KVM segment
- *   indent  - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the KVM segment given by @segment, to the FILE stream
- * given by @stream.
- */
 static void segment_dump(FILE *stream, struct kvm_segment *segment,
 			 uint8_t indent)
 {
@@ -75,21 +59,6 @@ static void segment_dump(FILE *stream, struct kvm_segment *segment,
 		segment->unusable, segment->padding);
 }
 
-/*
- * dtable Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   dtable - KVM dtable
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the KVM dtable given by @dtable, to the FILE stream
- * given by @stream.
- */
 static void dtable_dump(FILE *stream, struct kvm_dtable *dtable,
 			uint8_t indent)
 {
@@ -99,8 +68,7 @@ static void dtable_dump(FILE *stream, struct kvm_dtable *dtable,
 		dtable->padding[0], dtable->padding[1], dtable->padding[2]);
 }
 
-void sregs_dump(FILE *stream, struct kvm_sregs *sregs,
-		uint8_t indent)
+static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
 {
 	unsigned int i;
 
-- 
2.36.1.255.ge46751e96f-goog

