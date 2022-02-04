Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF24A9DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbiBDRiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377045AbiBDRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=meBYTrvQY3Vzaw6ouSwzbarO8+EcbkWn/cKrybubalA=;
        b=As+NSAJl2PlGhqzCMwkQUVoCh5G42BfHc+oP4Yp4srKW6hmDE3gf9HiCrm8yr1l5NzlL0w
        QJaMC4KDbLENhnhHE2Bh4mNXzD936p9cildHPoEY2uep4AxNj7uztITzBk0EW5443J0Ptt
        5Bxa4RNRYEDGymsvLyE9S5T93wSDXhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-qPJobStOO-ivGJ3dYYyzrw-1; Fri, 04 Feb 2022 12:37:44 -0500
X-MC-Unique: qPJobStOO-ivGJ3dYYyzrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E6AC801B2D;
        Fri,  4 Feb 2022 17:37:43 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F8927DE50;
        Fri,  4 Feb 2022 17:37:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 722D2416D5C7; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.491925589@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:38 -0300
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
        linux-s390@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v11 01/13] s390: add support for TIF_TASK_ISOL
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TIF_TASK_ISOL handling for s390.

Cc: linux-s390@vger.kernel.org
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/arch/s390/include/asm/thread_info.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/thread_info.h
+++ linux-2.6/arch/s390/include/asm/thread_info.h
@@ -73,6 +73,7 @@ void arch_setup_new_exec(void);
 #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
 #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
 #define TIF_PER_TRAP		10	/* Need to handle PER trap on exit to usermode */
+#define TIF_TASK_ISOL		11	/* task isolation work pending */
 
 #define TIF_31BIT		16	/* 32bit process */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
@@ -97,6 +98,7 @@ void arch_setup_new_exec(void);
 #define _TIF_ISOLATE_BP		BIT(TIF_ISOLATE_BP)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
 #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
+#define _TIF_TASK_ISOL		BIT(TIF_TASK_ISOL)
 
 #define _TIF_31BIT		BIT(TIF_31BIT)
 #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)


