Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD948A396
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbiAJXZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:25:14 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:8982 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241114AbiAJXZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:25:10 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4JXqg80kSzzFc;
        Tue, 11 Jan 2022 00:25:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1641857108; bh=SWMesIYH9Hnl7fgsSQQBcw9HyR3V/1EFi/nRU0shPBw=;
        h=Date:From:Subject:To:Cc:From;
        b=e3+0o8RjO+4qypXkVrEKHgQIXtZGeYczOG26XAgU6QA6aeU+kbI60FQ9W8IWQLiJx
         mqyj9mT7vPhTlJx3UO+QycptCCMkfUSODDHPRG9P2oPnfi6aPo+gfR4qdMzZX9pF3C
         VMGTK8mAryZhmNZu+hsYETvEdWj1uBloe7ECRgNxXmsJ9z8FfqQ5JgGu3llz+597Zd
         G1cDGVfu+gQdf4sJ+MtiMWrBpPF7XnQrYKuFJFnjTiNWG1Of5BN42TK3W+QqJuee0y
         ZnLba3ICEFcw5QSx3tbmIJzHv527YeUPpav2+kxbZuHoDzepBJNCdQnS/+4lH+ZXYX
         3L9BzckAzBC/A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.4 at mail
Date:   Tue, 11 Jan 2022 00:25:06 +0100
Message-Id: <87ddcac4c4e017a42e20dbbfcb8343468a0efc12.1641857023.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] dm integrity: use alloc_ordered_workqueue() for
 dm-integrity-wait
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the requirement for ordering of dm-integrity-wait work
explicit.  No behaviour change because of commit 5c0338c68706
("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered").

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 7af242de3202..6dc9aebf8487 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4212,7 +4212,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	 * If this workqueue were percpu, it would cause bio reordering
 	 * and reduced performance.
 	 */
-	ic->wait_wq = alloc_workqueue("dm-integrity-wait", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	ic->wait_wq = alloc_ordered_workqueue("dm-integrity-wait", WQ_MEM_RECLAIM);
 	if (!ic->wait_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
-- 
2.30.2

