Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648D25B273C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiIHT5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiIHT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28843FDBA3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JcghkbSjULMePVbzbb4JaxRiOu/Uf2FtD3sfj5LZVkY=;
        b=cHa49sv3fkI7hTHTiyFhaGQbK2Tm1UFHNh0rAyhbRrAj5uahOVl/DBFDVtB3PazSCRY/NE
        gccRFMFYeUEj14JSZdxa8rRegGxf0xPV42I/R6pbY4EW6JRPhgf9B4i0vMq2sxpttBSsQb
        u8nvzo3O+UwMBFFqsLuy2sccwFkIKIg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-7U62WPpDN0OgBWAW-PRmqQ-1; Thu, 08 Sep 2022 15:57:16 -0400
X-MC-Unique: 7U62WPpDN0OgBWAW-PRmqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 773313C0CD59;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44D85112131E;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 27B84418859B; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908195111.915923599@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:29:05 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Prasad Pandit <ppandit@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH 6/7] perf_event_open: check for block interference CPUs
References: <20220908192859.546633738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating perf events, return an error rather
than interfering with CPUs tagged as block interference.

Note: this patch is incomplete, installation of perf context 
on block interference CPUs via task context is not performed.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/kernel/events/core.c
===================================================================
--- linux-2.6.orig/kernel/events/core.c
+++ linux-2.6/kernel/events/core.c
@@ -54,6 +54,7 @@
 #include <linux/highmem.h>
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -12391,6 +12392,26 @@ not_move_group:
 
 	WARN_ON_ONCE(ctx->parent_ctx);
 
+	block_interf_read_lock();
+	if (!task) {
+		if (move_group) {
+			for_each_sibling_event(sibling, group_leader) {
+				if (block_interf_cpu(sibling->cpu)) {
+					err = -EPERM;
+					goto err_block_interf;
+				}
+			}
+			if (block_interf_cpu(group_leader->cpu)) {
+				err = -EPERM;
+				goto err_block_interf;
+			}
+		}
+		if (block_interf_cpu(event->cpu)) {
+			err = -EPERM;
+			goto err_block_interf;
+		}
+	}
+
 	/*
 	 * This is the point on no return; we cannot fail hereafter. This is
 	 * where we start modifying current state.
@@ -12464,6 +12485,8 @@ not_move_group:
 		put_task_struct(task);
 	}
 
+	block_interf_read_unlock();
+
 	mutex_lock(&current->perf_event_mutex);
 	list_add_tail(&event->owner_entry, &current->perf_event_list);
 	mutex_unlock(&current->perf_event_mutex);
@@ -12478,6 +12501,8 @@ not_move_group:
 	fd_install(event_fd, event_file);
 	return event_fd;
 
+err_block_interf:
+	block_interf_read_unlock();
 err_locked:
 	if (move_group)
 		perf_event_ctx_unlock(group_leader, gctx);


