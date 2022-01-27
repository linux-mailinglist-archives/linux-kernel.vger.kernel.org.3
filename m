Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DAB49E933
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbiA0Riz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244724AbiA0Rit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643305129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bOWN9FXEc7z7mFU0QXKsnKn5eCQYgShYsehuFbTvhU8=;
        b=RJSp7Lkh2aZ3qUgKkZ8x89rZCXbVmJshfVVxqGuZeTZAmthHRSVHFj0tmNH05VgTAnE/LU
        OohgA8oZz5QUkbNiUJ1wzNJ3GeY5Hs4SQF7uhUKOotfk/ljgSYNdN6IgV0kzM0DMA+85+1
        XvofLFyfHUf6AiP9IuSLmMjHLFpDrKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-bbIU9EO1PB-uwOKb4K6jKw-1; Thu, 27 Jan 2022 12:38:45 -0500
X-MC-Unique: bbIU9EO1PB-uwOKb4K6jKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8FF100C663;
        Thu, 27 Jan 2022 17:38:44 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A46D74E9A;
        Thu, 27 Jan 2022 17:38:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3E62A417130B; Thu, 27 Jan 2022 14:38:05 -0300 (-03)
Message-ID: <20220127173206.862057978@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 27 Jan 2022 14:30:45 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v10 08/10] KVM: x86: process isolation work from VM-entry code path
References: <20220127173037.318440631@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM-entry code path is an entry point similar to userspace return
when task isolation is concerned.

Call isolation_exit_to_user_mode before VM-enter.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/entry-kvm.h |    4 +++-
 kernel/entry/kvm.c        |   18 ++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

Index: linux-2.6/kernel/entry/kvm.c
===================================================================
--- linux-2.6.orig/kernel/entry/kvm.c
+++ linux-2.6/kernel/entry/kvm.c
@@ -2,8 +2,11 @@
 
 #include <linux/entry-kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/task_isolation.h>
 
-static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
+static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
+				   unsigned long ti_work,
+				   unsigned long task_isol_work)
 {
 	do {
 		int ret;
@@ -25,15 +28,19 @@ static int xfer_to_guest_mode_work(struc
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
 		if (ret)
 			return ret;
+		if (task_isol_work)
+			task_isol_exit_to_user_mode();
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched() ||
+		 task_isol_work);
 	return 0;
 }
 
 int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 {
 	unsigned long ti_work;
+	unsigned long task_isol_work;
 
 	/*
 	 * This is invoked from the outer guest loop with interrupts and
@@ -44,9 +51,9 @@ int xfer_to_guest_mode_handle_work(struc
 	 * to disable interrupts here.
 	 */
 	ti_work = read_thread_flags();
-	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
+	if (!(ti_work & XFER_TO_GUEST_MODE_WORK) || task_isol_work)
 		return 0;
 
-	return xfer_to_guest_mode_work(vcpu, ti_work);
+	return xfer_to_guest_mode_work(vcpu, ti_work, task_isol_work);
 }
 EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
Index: linux-2.6/include/linux/entry-kvm.h
===================================================================
--- linux-2.6.orig/include/linux/entry-kvm.h
+++ linux-2.6/include/linux/entry-kvm.h
@@ -8,6 +8,7 @@
 #include <linux/seccomp.h>
 #include <linux/sched.h>
 #include <linux/tick.h>
+#include <linux/task_isolation.h>
 
 /* Transfer to guest mode work */
 #ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
@@ -76,8 +77,9 @@ static inline void xfer_to_guest_mode_pr
 static inline bool __xfer_to_guest_mode_work_pending(void)
 {
 	unsigned long ti_work = read_thread_flags();
+	unsigned long task_isol_work = task_isol_has_work();
 
-	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
+	return !!((ti_work & XFER_TO_GUEST_MODE_WORK) || task_isol_work);
 }
 
 /**


