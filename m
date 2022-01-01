Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6037482897
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiAAV61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 16:58:27 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48712 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiAAV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 16:58:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 05DD1614E2F2;
        Sat,  1 Jan 2022 22:58:24 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id s2QX--ih1H1p; Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A41F2614E2F0;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GLwt1eU-o2h7; Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 45C9C614E2EF;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        anton.ivanov@cambridgegreys.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/4] um: chan: Restore blocking mode upon exit
Date:   Sat,  1 Jan 2022 22:58:09 +0100
Message-Id: <20220101215810.13260-4-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that O_NONBLOCK is cleared upon exit if UML sets it.
Otherwise stdin/out behaves strange after UML terminates.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/chan.h      | 1 +
 arch/um/drivers/chan_kern.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/drivers/chan.h b/arch/um/drivers/chan.h
index c37cc4f26f91..6b8c462f146e 100644
--- a/arch/um/drivers/chan.h
+++ b/arch/um/drivers/chan.h
@@ -22,6 +22,7 @@ struct chan {
 	unsigned int output:1;
 	unsigned int opened:1;
 	unsigned int enabled:1;
+	unsigned int fd_blocking:1;
 	int fd;
 	const struct chan_ops *ops;
 	void *data;
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 86be115b5890..6d512589fa50 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -102,6 +102,7 @@ static int open_one_chan(struct chan *chan)
 	}
=20
 	chan->fd =3D fd;
+	chan->fd_blocking =3D ret;
=20
 	chan->opened =3D 1;
 	return 0;
@@ -223,6 +224,8 @@ static void close_one_chan(struct chan *chan, int del=
ay_free_irq)
 	if (chan->ops->close !=3D NULL)
 		(*chan->ops->close)(chan->fd, chan->data);
=20
+	os_set_fd_block(chan->fd, chan->fd_blocking);
+
 	chan->opened =3D 0;
 	chan->fd =3D -1;
 }
--=20
2.26.2

