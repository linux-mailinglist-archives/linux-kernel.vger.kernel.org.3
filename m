Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA534A9DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376953AbiBDRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376927AbiBDRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H4/GSfK7LX7rMbwfu9JXq5F6IxvrFPX++baTh2jcvqs=;
        b=BnRq46lGrKJVKzmwRXuwN+KVHDnqO1xXjzIzwo8UCyvu9m4Ix3Jvg2Fs81ptFvyxgDvaI7
        OGtrQNyQ42FcXezlecNIlPbP5KrvbluzR8U46LSWddtkDAZYZU7c01qXs6zqPLN9/Q2+yq
        y9OSwCxIMAFDnjN/hNl+DzYfYqoKc/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-vzM7fDzqPGqwFJmj0qR2DQ-1; Fri, 04 Feb 2022 12:37:11 -0500
X-MC-Unique: vzM7fDzqPGqwFJmj0qR2DQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75CF9835BC5;
        Fri,  4 Feb 2022 17:37:09 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F4037D3D7;
        Fri,  4 Feb 2022 17:37:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9C02A41692CC; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.897857855@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:47 -0300
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
Subject: [patch v11 10/13] KVM: x86: process isolation work from VM-entry code path
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM-entry code path is an entry point similar to userspace return
when task isolation is concerned.

Call isolation_exit_to_user_mode before VM-enter.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
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


