Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC474DA38D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351522AbiCOT4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351507AbiCOT4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6B604ECFC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=meBYTrvQY3Vzaw6ouSwzbarO8+EcbkWn/cKrybubalA=;
        b=asIEN5CJqZsj7ssJ43wRUqaIERAZDc0QVgt7pbFdtil3TBuYDvBctU0XIScJ59GSBCCqG/
        uuoMtpnGVkno1FvedrcO6z3Rn0PqHoqwmXf/M91JcYNfZb1QZQE3eYXDSp2ElwvU0BCdX3
        VwAChoFBLIMNLWuEqfcAl/TcnhV0wR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-IAwM9wyZOL-SeCAmyk_k2A-1; Tue, 15 Mar 2022 15:55:26 -0400
X-MC-Unique: IAwM9wyZOL-SeCAmyk_k2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BBBD18A0169;
        Tue, 15 Mar 2022 19:55:26 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7933C4C7A3;
        Tue, 15 Mar 2022 19:55:25 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B1475416D5D2; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153313.774280787@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:33 -0300
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
Subject: [patch v12 01/13] s390: add support for TIF_TASK_ISOL
References: <20220315153132.717153751@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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


