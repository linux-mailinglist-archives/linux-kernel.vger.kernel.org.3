Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2EE57C147
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiGUADb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiGUADZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA02F74787
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658361804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYesQTXIGdo47yQu+QowHw+8l05Pgun0K3Pva/sDbSk=;
        b=Vw4L9QwghI9mAElfEXQXAMwcYjbgTFaVP7E6kgMS/9LqMVhVFOqzhhywyLyP3JzS+DmCWs
        QPO3pSKq5IaBSY1nQ2/L6N6M4LYvOCo5LbPAbgqDaY42gSwz803uY/S1VAEVdJRkGU/vO0
        HrEyVxdMpD6akCseOwJsBzlkcCWiBBI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-U2izdY9vNd6Es9tHyKoYNg-1; Wed, 20 Jul 2022 20:03:23 -0400
X-MC-Unique: U2izdY9vNd6Es9tHyKoYNg-1
Received: by mail-qv1-f69.google.com with SMTP id e1-20020ad44181000000b00472f8ad6e71so10532710qvp.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYesQTXIGdo47yQu+QowHw+8l05Pgun0K3Pva/sDbSk=;
        b=MEMh3Wu81Qsrk6QYFDeHjDSSjSLkN4itGXX9t0y9lvWgz6dtR0MO6zH1kTHL9tFztn
         6E5lsFVS5GzEx9eZbADfVpfH6w/7Kyqf9Zu+62TCeEgHHaOmeW4HV7GuW2EF0HE+bInz
         lSTlNUgcKtbWKMjB/Y1KMkqCh42cvCgGbRoHBWLa53OOyxLZ1l0hu755pWIowrpG/ba0
         tQiyHYXk4O6vurv4HKEh272Va3s+z6BEb2Fkmy5BNK8GViiF1yCn3DNuGNrglghdq5o0
         FN+ia/9Cgwvf2HMfM367zHhfkOi1dSv1YiHd5UjZuPKljOYB07ElGnQLlY+LRrOfj/uY
         pr2w==
X-Gm-Message-State: AJIora8Uh95hrSdPqDSHTwSSaiohpby8oZ6dyU8FUxnRy0/FDmURCuDP
        LgimHO59iYRSXIVOFA4R5rhw+nG4pYNuqNXXuHwMiqQuZNV1ZN9pG4hU8NgUuf/fBi5FIh6MMan
        9eLHGBOn6kQgfJJ89GS7APJa8WkUdqAPSFSRW7SNoZC9Di6RVBh8iZCTwjXo8YVntDXiYrHLFQA
        ==
X-Received: by 2002:a05:6214:2a84:b0:473:2958:2b02 with SMTP id jr4-20020a0562142a8400b0047329582b02mr32042145qvb.122.1658361802195;
        Wed, 20 Jul 2022 17:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v59tccxm2kEE0GOfREC1qZsXxxMExtmQCtk56QjVayvWjveIoVQM2AJ2cuAgdIySuuVl0NQw==
X-Received: by 2002:a05:6214:2a84:b0:473:2958:2b02 with SMTP id jr4-20020a0562142a8400b0047329582b02mr32042102qvb.122.1658361801787;
        Wed, 20 Jul 2022 17:03:21 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm418640qtk.52.2022.07.20.17.03.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Jul 2022 17:03:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v2 1/3] mm/gup: Add FOLL_INTERRUPTIBLE
Date:   Wed, 20 Jul 2022 20:03:16 -0400
Message-Id: <20220721000318.93522-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220721000318.93522-1-peterx@redhat.com>
References: <20220721000318.93522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have had FAULT_FLAG_INTERRUPTIBLE but it was never applied to GUPs.  One
issue with it is that not all GUP paths are able to handle signal delivers
besides SIGKILL.

That's not ideal for the GUP users who are actually able to handle these
cases, like KVM.

KVM uses GUP extensively on faulting guest pages, during which we've got
existing infrastructures to retry a page fault at a later time.  Allowing
the GUP to be interrupted by generic signals can make KVM related threads
to be more responsive.  For examples:

  (1) SIGUSR1: which QEMU/KVM uses to deliver an inter-process IPI,
      e.g. when the admin issues a vm_stop QMP command, SIGUSR1 can be
      generated to kick the vcpus out of kernel context immediately,

  (2) SIGINT: which can be used with interactive hypervisor users to stop a
      virtual machine with Ctrl-C without any delays/hangs,

  (3) SIGTRAP: which grants GDB capability even during page faults that are
      stuck for a long time.

Normally hypervisor will be able to receive these signals properly, but not
if we're stuck in a GUP for a long time for whatever reason.  It happens
easily with a stucked postcopy migration when e.g. a network temp failure
happens, then some vcpu threads can hang death waiting for the pages.  With
the new FOLL_INTERRUPTIBLE, we can allow GUP users like KVM to selectively
enable the ability to trap these signals.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 33 +++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf3d0d673f6b..c09eccd5d553 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2941,6 +2941,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_INTERRUPTIBLE  0x100000 /* allow interrupts from generic signals */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/mm/gup.c b/mm/gup.c
index 551264407624..f39cbe011cf1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -933,8 +933,17 @@ static int faultin_page(struct vm_area_struct *vma,
 		fault_flags |= FAULT_FLAG_WRITE;
 	if (*flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
-	if (locked)
+	if (locked) {
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+		/*
+		 * FAULT_FLAG_INTERRUPTIBLE is opt-in. GUP callers must set
+		 * FOLL_INTERRUPTIBLE to enable FAULT_FLAG_INTERRUPTIBLE.
+		 * That's because some callers may not be prepared to
+		 * handle early exits caused by non-fatal signals.
+		 */
+		if (*flags & FOLL_INTERRUPTIBLE)
+			fault_flags |= FAULT_FLAG_INTERRUPTIBLE;
+	}
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
 	if (*flags & FOLL_TRIED) {
@@ -1322,6 +1331,22 @@ int fixup_user_fault(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(fixup_user_fault);
 
+/*
+ * GUP always responds to fatal signals.  When FOLL_INTERRUPTIBLE is
+ * specified, it'll also respond to generic signals.  The caller of GUP
+ * that has FOLL_INTERRUPTIBLE should take care of the GUP interruption.
+ */
+static bool gup_signal_pending(unsigned int flags)
+{
+	if (fatal_signal_pending(current))
+		return true;
+
+	if (!(flags & FOLL_INTERRUPTIBLE))
+		return false;
+
+	return signal_pending(current);
+}
+
 /*
  * Please note that this function, unlike __get_user_pages will not
  * return 0 for nr_pages > 0 without FOLL_NOWAIT
@@ -1403,11 +1428,11 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		 * Repeat on the address that fired VM_FAULT_RETRY
 		 * with both FAULT_FLAG_ALLOW_RETRY and
 		 * FAULT_FLAG_TRIED.  Note that GUP can be interrupted
-		 * by fatal signals, so we need to check it before we
+		 * by fatal signals of even common signals, depending on
+		 * the caller's request. So we need to check it before we
 		 * start trying again otherwise it can loop forever.
 		 */
-
-		if (fatal_signal_pending(current)) {
+		if (gup_signal_pending(flags)) {
 			if (!pages_done)
 				pages_done = -EINTR;
 			break;
-- 
2.32.0

