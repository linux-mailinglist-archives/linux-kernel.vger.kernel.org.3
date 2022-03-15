Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15D4DA38E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiCOT5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351520AbiCOT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7E0C56202
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NOP9prtXyYaC99zyW2N0VAiUPDFFpIu7D6Ekw1Kx0TQ=;
        b=dPsooM6VEOz4ZOUnxUcFa+WaosWGriYE57pMO0y6BVYmIfHNs1ZbAaT4KXSd9B0RtPCLjV
        8RVxsR7GQC1PcnUNKF0WYkpEpFfhMelXCix+3I9eyxMjcvRmfWpom9go7TXZa+RO9i7Kzz
        NthySzHR5PVPrCveOXCixEKKIeoXDLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-8aNx8NiiMlGiJrR9n7w-9Q-1; Tue, 15 Mar 2022 15:55:28 -0400
X-MC-Unique: 8aNx8NiiMlGiJrR9n7w-9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29B631010360;
        Tue, 15 Mar 2022 19:55:28 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB151404D8ED;
        Tue, 15 Mar 2022 19:55:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C19F9416F542; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153314.182117582@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:42 -0300
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
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v12 10/13] KVM: x86: process isolation work from VM-entry code path
References: <20220315153132.717153751@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM-entry code path is an entry point similar to userspace return
when task isolation is concerned.

Call isolation_exit_to_user_mode before VM-enter.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v12
- Add missing kvm-entry.h change			(Frederic)

v11
- Add TIF_TASK_ISOL bit to thread info flags and use it
  to decide whether to perform task isolation work on
  return to userspace                                   (Frederic W. Weisbecker)

 include/linux/entry-kvm.h |    4 +++-
 kernel/entry/kvm.c        |   18 ++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

Index: linux-2.6/kernel/entry/kvm.c
===================================================================
--- linux-2.6.orig/kernel/entry/kvm.c
+++ linux-2.6/kernel/entry/kvm.c
@@ -2,6 +2,7 @@
 
 #include <linux/entry-kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/task_isolation.h>
 
 static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 {
@@ -22,6 +23,9 @@ static int xfer_to_guest_mode_work(struc
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			tracehook_notify_resume(NULL);
 
+		if (ti_work & _TIF_TASK_ISOL)
+			task_isol_exit_to_user_mode();
+
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
 		if (ret)
 			return ret;
Index: linux-2.6/include/linux/entry-kvm.h
===================================================================
--- linux-2.6.orig/include/linux/entry-kvm.h
+++ linux-2.6/include/linux/entry-kvm.h
@@ -18,7 +18,7 @@
 
 #define XFER_TO_GUEST_MODE_WORK						\
 	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	 _TIF_NOTIFY_RESUME | _TIF_TASK_ISOL | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 


