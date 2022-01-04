Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61039484606
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiADQgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:36:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60808 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235367AbiADQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:35:59 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204FLlE9029256;
        Tue, 4 Jan 2022 17:35:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=+jWUHPERe/nevyKX3aqinPpPiMKKYwzJ7ruEcy/S6Pg=;
 b=PnbqfR3AHdZfDPPtgTZR3iBZIvYHE1obPniwFMAXOENKMnG1UFd2D5A04Fci427gvcYn
 1ZEZbe8OAECSecxdP64WLTgNBTy8IbCaU5OaT63dxcUsplu1WZQSClb5nCi89PsQ/I67
 CyAsFaOpXsiBZrXJwMBQNDMr9xKaGWs0MFME1PanCbOPp3ck4AfFMgXKeHES4GbwHYXn
 ux9tVwJQ76rVKVr4FJhJV/KUStH80IVIEtVAAyX1Rgu7o4/iWy+sv7ei+2nkYAfVor27
 p22Saf35leC0h5ow0p+x4koBG8kX06kqOWbslMq5lLV6bpDnoj8t9eSPsTGRY9yc3WVx oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcagrbv9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:35:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DFA610002A;
        Tue,  4 Jan 2022 17:35:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 30692245CC5;
        Tue,  4 Jan 2022 17:35:50 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 17:35:49
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v4] tty: rpmsg: Fix race condition releasing tty port
Date:   Tue, 4 Jan 2022 17:35:45 +0100
Message-ID: <20220104163545.34710-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_07,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tty_port struct is part of the rpmsg_tty_port structure.
The issue is that the rpmsg_tty_port structure is freed on
rpmsg_tty_remove while it is still referenced in the tty_struct.
Its release is not predictable due to workqueues.

For instance following ftrace shows that rpmsg_tty_close is called after
rpmsg_tty_release_cport:

     nr_test.sh-389     [000] .....   212.093752: rpmsg_tty_remove <-rpmsg_dev_
remove
             cat-1191    [001] .....   212.095697: tty_release <-__fput
      nr_test.sh-389     [000] .....   212.099166: rpmsg_tty_release_cport <-rpm
sg_tty_remove
             cat-1191    [001] .....   212.115352: rpmsg_tty_close <-tty_release
             cat-1191    [001] .....   212.115371: release_tty <-tty_release_str

As consequence, the port must be free only when user has released the TTY
interface.

This path :
- Introduce the .destruct port tty ops function to release the allocated
  rpmsg_tty_port structure.
- Introduce the .hangup tty ops function to call tty_port_hangup.
- Manages the tty port refcounting to trig the .destruct port ops,
- Introduces the rpmsg_tty_cleanup function to ensure that the TTY is
  removed before decreasing the port refcount.


Fixes: 7c0408d80579 ("tty: add rpmsg driver")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
delta vs V3 [1]: take into account Greg Kroah-Hartman's comments:
- remove uses of tty_vhangup instead of tty_port_tty_hangup.
- remove useless WARM_ON(!cport) in rpmsg_tty_cleanup.

Remaining point to clarify:
Is it a  benefict to use tty_vhangup as done in V3 [1] instead of
tty_hangup (called by tty_port_tty_hangup)?
In both cases, tty_kref_put calls queue_release_one_tty making the rest
of the release asynchronous.
-> proposal to address this in a separate patchset if needed (introducing
tty_port_tty_vhangup helper).

[1]https://lore.kernel.org/all/YcGN0fDn2hqAdrP9@kroah.com/T/#m4e02ed9ca71387f447b5dc35402f10f4313f44d2
of

Applied and tested on fa55b7dcdc43 ("Linux 5.16-rc1", 2021-11-14)
---
 drivers/tty/rpmsg_tty.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index dae2a4e44f38..29db413bbc03 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -50,10 +50,17 @@ static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len, void *p
 static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
+	struct tty_port *port;
 
 	tty->driver_data = cport;
 
-	return tty_port_install(&cport->port, driver, tty);
+	port = tty_port_get(&cport->port);
+	return tty_port_install(port, driver, tty);
+}
+
+static void rpmsg_tty_cleanup(struct tty_struct *tty)
+{
+	tty_port_put(tty->port);
 }
 
 static int rpmsg_tty_open(struct tty_struct *tty, struct file *filp)
@@ -106,12 +113,19 @@ static unsigned int rpmsg_tty_write_room(struct tty_struct *tty)
 	return size;
 }
 
+static void rpmsg_tty_hangup(struct tty_struct *tty)
+{
+	tty_port_hangup(tty->port);
+}
+
 static const struct tty_operations rpmsg_tty_ops = {
 	.install	= rpmsg_tty_install,
 	.open		= rpmsg_tty_open,
 	.close		= rpmsg_tty_close,
 	.write		= rpmsg_tty_write,
 	.write_room	= rpmsg_tty_write_room,
+	.hangup		= rpmsg_tty_hangup,
+	.cleanup	= rpmsg_tty_cleanup,
 };
 
 static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
@@ -137,8 +151,10 @@ static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
 	return cport;
 }
 
-static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
+static void rpmsg_tty_destruct_port(struct tty_port *port)
 {
+	struct rpmsg_tty_port *cport = container_of(port, struct rpmsg_tty_port, port);
+
 	mutex_lock(&idr_lock);
 	idr_remove(&tty_idr, cport->id);
 	mutex_unlock(&idr_lock);
@@ -146,7 +162,10 @@ static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
 	kfree(cport);
 }
 
-static const struct tty_port_operations rpmsg_tty_port_ops = { };
+static const struct tty_port_operations rpmsg_tty_port_ops = {
+	.destruct = rpmsg_tty_destruct_port,
+};
+
 
 static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 {
@@ -166,7 +185,8 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 					   cport->id, dev);
 	if (IS_ERR(tty_dev)) {
 		ret = dev_err_probe(dev, PTR_ERR(tty_dev), "Failed to register tty port\n");
-		goto err_destroy;
+		tty_port_put(&cport->port);
+		return ret;
 	}
 
 	cport->rpdev = rpdev;
@@ -177,12 +197,6 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 		rpdev->src, rpdev->dst, cport->id);
 
 	return 0;
-
-err_destroy:
-	tty_port_destroy(&cport->port);
-	rpmsg_tty_release_cport(cport);
-
-	return ret;
 }
 
 static void rpmsg_tty_remove(struct rpmsg_device *rpdev)
@@ -192,13 +206,11 @@ static void rpmsg_tty_remove(struct rpmsg_device *rpdev)
 	dev_dbg(&rpdev->dev, "Removing rpmsg tty device %d\n", cport->id);
 
 	/* User hang up to release the tty */
-	if (tty_port_initialized(&cport->port))
-		tty_port_tty_hangup(&cport->port, false);
+	tty_port_tty_hangup(&cport->port, false);
 
 	tty_unregister_device(rpmsg_tty_driver, cport->id);
 
-	tty_port_destroy(&cport->port);
-	rpmsg_tty_release_cport(cport);
+	tty_port_put(&cport->port);
 }
 
 static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
-- 
2.25.1

