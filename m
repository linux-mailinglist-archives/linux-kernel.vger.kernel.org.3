Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0900587936
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiHBIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiHBImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB7C1BEB0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659429744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gzLDvQ7aWaj23CMbC0REd/onn9CKJJFu3RV6mIazrs=;
        b=Xp1UPP5ii4iyXaAydigSfRar46EdUQPO7gmNfsjGS+rfXTQAVXIj7cjBdvxIrwkhg/Ilxc
        j1UFdoXDG9HLU0N0BPz7uk423JkcJZOziBaMdbt5Z7Fc6c+gl61w0VCTq6aS54cAGlT4Il
        9uuuQMXnnNLlwIevTRhGrdHkTIBdc5g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-J1vX1i_rNjGZGR7kmqvMsQ-1; Tue, 02 Aug 2022 04:42:23 -0400
X-MC-Unique: J1vX1i_rNjGZGR7kmqvMsQ-1
Received: by mail-wr1-f72.google.com with SMTP id s24-20020adf9798000000b0021ed3f3dd75so3254033wrb.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4gzLDvQ7aWaj23CMbC0REd/onn9CKJJFu3RV6mIazrs=;
        b=eUbS/yaAgNCSbC1+YVLDR7BQrvxhQ++ZZn4dk4O17z1ZtA2c5c9szIGWnMRDJ4XhbJ
         qUKMc1EuchElX5IvP9YLNp5Qcev8bW0i5Ub8ywL3jHPRGqOWojM+2rnmWb4sdk67q3DU
         7VIDashNHo6X0rv7s+q5UHPvRrnfUw6TpMkgddkSTnW1+jHjAgKLAUBLexF+yXP9q+jC
         mBwErAFXHQ6VhsT5+bHR4tT9eOp8gjku8TUVZ2YBBvuQQs84qEdvmyIf0JGAOMY/ZQqJ
         r2WljJAU0sbtn6CdbXOo5RB92VZzWPg97NpVSSm/kMF+IkDHl0QPyeIY1Xk1uvI2Zz5w
         l1MA==
X-Gm-Message-State: AJIora88xsILnoRFGxinErcMdIYc5yCj1yC/C7daqbU1dle7k9EPxsMl
        63DhFdiqTtkowQa8ChUkLjbbpvoZyYQlx4wz4EnNMI1ka2xEtHxtSokt3o5GODpDDO6P8ZAMJqk
        SeLGtm3uo9qOpuX5B20DQoIOlG2L7v1817THXiMBCZZ2rzJFOQ7BLHcFnN7cRoSvPPrzuVbXDax
        Bj
X-Received: by 2002:a05:600c:a146:b0:3a3:1e79:4446 with SMTP id ib6-20020a05600ca14600b003a31e794446mr13768018wmb.158.1659429741610;
        Tue, 02 Aug 2022 01:42:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1te439EFrpVNkzNpR1rWgVUPi8JRsLzt6WMfD4BOYnGxBzLvyGLBPnePuCREG7Vbdo+SsE81w==
X-Received: by 2002:a05:600c:a146:b0:3a3:1e79:4446 with SMTP id ib6-20020a05600ca14600b003a31e794446mr13768000wmb.158.1659429741412;
        Tue, 02 Aug 2022 01:42:21 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003a31169a7f4sm24825800wmg.12.2022.08.02.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 01:42:20 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH v3 1/3] workqueue: Hold wq_pool_mutex while affining tasks to wq_unbound_cpumask
Date:   Tue,  2 Aug 2022 09:41:44 +0100
Message-Id: <20220802084146.3922640-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220802084146.3922640-1-vschneid@redhat.com>
References: <20220802084146.3922640-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unbind_workers() reads wq_unbound_cpumask to set the affinity of
freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.

This is made more obvious as of recent commit

  46a4d679ef88 ("workqueue: Avoid a false warning in unbind_workers()")

e.g.

unbind_workers()                             workqueue_set_unbound_cpumask()
  kthread_set_per_cpu(p, -1);
  if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
					       cpumask_copy(wq_unbound_cpumask, cpumask);
    WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);

Make workqueue_offline_cpu() invoke unbind_workers() with wq_pool_mutex
held.

Fixes: 10a5a651e3af ("workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs")
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aa8a82bc6738..97cc41430a76 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5143,14 +5143,15 @@ int workqueue_offline_cpu(unsigned int cpu)
 	if (WARN_ON(cpu != smp_processor_id()))
 		return -1;
 
+	mutex_lock(&wq_pool_mutex);
+
 	unbind_workers(cpu);
 
 	/* update NUMA affinity of unbound workqueues */
-	mutex_lock(&wq_pool_mutex);
 	list_for_each_entry(wq, &workqueues, list)
 		wq_update_unbound_numa(wq, cpu, false);
-	mutex_unlock(&wq_pool_mutex);
 
+	mutex_unlock(&wq_pool_mutex);
 	return 0;
 }
 
-- 
2.31.1

