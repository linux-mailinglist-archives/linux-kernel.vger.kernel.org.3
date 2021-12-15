Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D5475C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244151AbhLOPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:48:24 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244149AbhLOPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:48:23 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFBenI7026247;
        Wed, 15 Dec 2021 16:31:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=23HHp83mfOENA/J6Flk/EYuVmm4kgOHgokfk9HKflYI=;
 b=R3Smg2GUitcS2TogP5SblesyHJrmHa9rR6Jc3inrwRCq2dc0cSetWU38fedfEZpYguVu
 ym1PSH6WIk/P+bRosAATqFvjcSlvuc5O1bpaGYTIWCF5n6T3UMKdJUDZcPPx8Ruz8bpB
 IghWNsBYa53PFZxnUdOKS/hp90sYIgo9qWtB9mMAaZ2w7NcaK0jXu48kNFqa/dxEy4r0
 sN+DQ2IPZ06+gfJZgn7mMm26OaW7M/Yu9zB/PpC7cgDJ5eO3sv96TG09/GwjzWOfuTVY
 JTeTu/Uz2durCzOkteEAee4nwWOsGsEyPY7W/MzJNjQtMsErkpWTaCpBzzVPXzBrh2EU og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cyfpxh5cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 16:31:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66D1710002A;
        Wed, 15 Dec 2021 16:31:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 594EB20A742;
        Wed, 15 Dec 2021 16:31:29 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 16:31:28
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v3] tty: rpmsg: Fix race condition releasing tty port
Date:   Wed, 15 Dec 2021 16:31:21 +0100
Message-ID: <20211215153121.30010-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_10,2021-12-14_01,2021-12-02_01
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
- Introduce the .destruct port ops function to release the allocated
  rpmsg_tty_port structure.
- Manages the tty port refcounting to trig the .destruct port ops,
- Introduces the rpmsg_tty_cleanup function to ensure that the TTY is
  removed before decreasing the port refcount.
- Uses tty_vhangup and tty_port_hangup instead of tty_port_tty_hangup.

Fixes: 7c0408d80579 ("tty: add rpmsg driver")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
delta vs V2: taking into account Jiri Slaby's comments:
 - Inline rpmsg_tty_release_cport in rpmsg_tty_destruct_port,
 - call tty_port_put in case of error in rpmsg_tty_probe,
 - use tty_port_get port return in rpmsg_tty_install to take into account
   NULL port return case.

Applied and tested on fa55b7dcdc43 ("Linux 5.16-rc1", 2021-11-14)
---
 drivers/tty/rpmsg_tty.c | 49 +++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index dae2a4e44f38..cdc590c63f03 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -50,10 +50,21 @@ static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len, void *p
 static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
+	struct tty_port *port = tty->port;
 
 	tty->driver_data = cport;
 
-	return tty_port_install(&cport->port, driver, tty);
+	port = tty_port_get(&cport->port);
+	return tty_port_install(port, driver, tty);
+}
+
+static void rpmsg_tty_cleanup(struct tty_struct *tty)
+{
+	struct tty_port *port = tty->port;
+
+	WARN_ON(!port);
+
+	tty_port_put(port);
 }
 
 static int rpmsg_tty_open(struct tty_struct *tty, struct file *filp)
@@ -106,12 +117,19 @@ static unsigned int rpmsg_tty_write_room(struct tty_struct *tty)
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
@@ -137,8 +155,10 @@ static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
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
@@ -146,7 +166,10 @@ static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
 	kfree(cport);
 }
 
-static const struct tty_port_operations rpmsg_tty_port_ops = { };
+static const struct tty_port_operations rpmsg_tty_port_ops = {
+	.destruct = rpmsg_tty_destruct_port,
+};
+
 
 static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 {
@@ -166,7 +189,8 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 					   cport->id, dev);
 	if (IS_ERR(tty_dev)) {
 		ret = dev_err_probe(dev, PTR_ERR(tty_dev), "Failed to register tty port\n");
-		goto err_destroy;
+		tty_port_put(&cport->port);
+		return ret;
 	}
 
 	cport->rpdev = rpdev;
@@ -177,28 +201,25 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
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
 {
 	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
+	struct tty_struct *tty;
 
 	dev_dbg(&rpdev->dev, "Removing rpmsg tty device %d\n", cport->id);
 
 	/* User hang up to release the tty */
-	if (tty_port_initialized(&cport->port))
-		tty_port_tty_hangup(&cport->port, false);
+	tty = tty_port_tty_get(&cport->port);
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
 
 	tty_unregister_device(rpmsg_tty_driver, cport->id);
 
-	tty_port_destroy(&cport->port);
-	rpmsg_tty_release_cport(cport);
+	tty_port_put(&cport->port);
 }
 
 static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
-- 
2.17.1

