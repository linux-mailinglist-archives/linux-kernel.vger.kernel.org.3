Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745EB470882
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbhLJSYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:24:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55034 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLJSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:24:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65AE41F37E;
        Fri, 10 Dec 2021 18:21:05 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F43313BFF;
        Fri, 10 Dec 2021 18:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZsWJM46as2HgKAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 10 Dec 2021 18:21:02 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     axboe@kernel.dk
Cc:     oleg@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)
Date:   Fri, 10 Dec 2021 10:20:58 -0800
Message-Id: <20211210182058.43417-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_each_pid_thread(PIDTYPE_PGID) can race with a concurrent
change_pid(PIDTYPE_PGID) that can move the task from one hlist
to another while iterating. Serialize ioprio_get to take
the tasklist_lock in this case, just like it's set counterpart.

Fixes: d69b78ba1de (ioprio: grab rcu_read_lock in sys_ioprio_{set,get}())
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
This is basically a resend of https://lore.kernel.org/all/20200817003148.23691-3-dave@stgolabs.net/
with Oleg's ack and without the ioprio_set part as this was fixed
later after this patch was lost for whatever reason.

 block/ioprio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/ioprio.c b/block/ioprio.c
index 313c14a70bbd..6f01d35a5145 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -220,6 +220,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 				pgrp = task_pgrp(current);
 			else
 				pgrp = find_vpid(who);
+			read_lock(&tasklist_lock);
 			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 				tmpio = get_task_ioprio(p);
 				if (tmpio < 0)
@@ -229,6 +230,8 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 				else
 					ret = ioprio_best(ret, tmpio);
 			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+			read_unlock(&tasklist_lock);
+
 			break;
 		case IOPRIO_WHO_USER:
 			uid = make_kuid(current_user_ns(), who);
-- 
2.26.2

