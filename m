Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBAB518631
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiECONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiECONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:13:09 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8AD13879A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:09:36 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-oMQ1o89_P1OFVqVbHMOxmg-1; Tue, 03 May 2022 10:09:26 -0400
X-MC-Unique: oMQ1o89_P1OFVqVbHMOxmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F4060199704F;
        Tue,  3 May 2022 13:40:20 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E6439E89;
        Tue,  3 May 2022 13:40:18 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Containers <containers@lists.linux.dev>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 1/4] ipc: Use the same namespace to modify and validate
Date:   Tue,  3 May 2022 15:39:54 +0200
Message-Id: <b3cb9a25cce6becbef77186bc1216071a08a969b.1651584847.git.legion@kernel.org>
In-Reply-To: <cover.1651584847.git.legion@kernel.org>
References: <87sfprudal.fsf@email.froward.int.ebiederm.org> <cover.1651584847.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the 1f5c135ee509 ("ipc: Store ipc sysctls in the ipc namespace") I
missed that in addition to the modification of sem_ctls[3], the change
is validated. This validation must occur in the same namespace.

Link: https://lore.kernel.org/lkml/875ymnvryb.fsf@email.froward.int.ebiederm.org/
Fixes: 1f5c135ee509 ("ipc: Store ipc sysctls in the ipc namespace")
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 15210ac47e9e..d1d5204cf589 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -68,7 +68,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
 	if (!ret)
-		ret = sem_check_semmni(current->nsproxy->ipc_ns);
+		ret = sem_check_semmni(ns);
 
 	/*
 	 * Reset the semmni value if an error happens.
-- 
2.33.3

