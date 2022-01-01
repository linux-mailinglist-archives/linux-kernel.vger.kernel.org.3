Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8E48289A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiAAV6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 16:58:32 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48722 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiAAV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 16:58:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 44FEB614E2EE;
        Sat,  1 Jan 2022 22:58:24 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O1xi_jvJo9ku; Sat,  1 Jan 2022 22:58:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ECF2F614E2F1;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2WzYrs5O1-Md; Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 97B18614E2EE;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        anton.ivanov@cambridgegreys.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/4] um: irq: Restore O_ASYNC upon exit
Date:   Sat,  1 Jan 2022 22:58:10 +0100
Message-Id: <20220101215810.13260-5-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like with O_NONBLOCK, make sure UML clears O_ASYNC
upon exit when it set it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index a8873d9bc28b..e020bdccfa23 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -342,6 +342,7 @@ static void free_irq_by_irq_and_dev(unsigned int irq,=
 void *dev)
 				continue;
=20
 			os_del_epoll_fd(entry->fd);
+			os_clear_fd_async(entry->fd);
 			reg->events =3D 0;
 			update_or_free_irq_entry(entry);
 			goto out;
@@ -396,8 +397,10 @@ int deactivate_all_fds(void)
 	os_set_ioignore();
=20
 	/* we can no longer call kfree() here so just deactivate */
-	list_for_each_entry(entry, &active_fds, list)
+	list_for_each_entry(entry, &active_fds, list) {
 		os_del_epoll_fd(entry->fd);
+		os_clear_fd_async(entry->fd);
+	}
 	os_close_epoll_fd();
 	return 0;
 }
--=20
2.26.2

