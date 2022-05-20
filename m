Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4859A52E79C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbiETIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbiETIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:32:17 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E1253A75;
        Fri, 20 May 2022 01:31:19 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K6OsWj029143;
        Fri, 20 May 2022 10:31:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Tqs+xiYCFI/8hHPXJbtrZX5TEbiaS90HqfCz+Xzn8qU=;
 b=GhiDIvS3rGfr2I1AJ0Yyd08HBT/vGRKwQWuxQpg1FOLRh+ClBHMAkcmFKoENL2uVVvJj
 bUL+gX8TSyV8bY0Ox53NEBldyWC5DqmYvxsCH+aNSRQuJS88qvWGz0j2NJImerSTu6Fp
 EOvsGLZUOFHLLTJ4rVzQ8NyMCn5khnnfo94FMIjasmRCn+6orjFWTyvwg3HRjO1D0kj/
 pNHS0ltq+Ce5PqUArGPSZjc7+1KfvKX/Tm4+IJQL5fkku9Mk+WsiuIOOW6zW5M9HOH5E
 VNafwc6GzxlPKHUc/7dzVhVykr6KwETotSUq+zGWTYgjuFjDTT0p4CXPsy5ISel1MAVc 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21j9f7ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:31:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22F2D100034;
        Fri, 20 May 2022 10:31:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1789221512E;
        Fri, 20 May 2022 10:31:13 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:31:12 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 09/10] rpmsg: tty : Add the support of the flow control
Date:   Fri, 20 May 2022 10:29:39 +0200
Message-ID: <20220520082940.2984914-10-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
References: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Software flow control support based on the RPMsg flow
control channel.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/tty/rpmsg_tty.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index 29db413bbc03..fc1dc4a5ca9d 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -30,6 +30,7 @@ struct rpmsg_tty_port {
 	struct tty_port		port;	 /* TTY port data */
 	int			id;	 /* TTY rpmsg index */
 	struct rpmsg_device	*rpdev;	 /* rpmsg device */
+	bool			flow_stopped; /* remote device flow control */
 };
 
 static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len, void *priv, u32 src)
@@ -106,6 +107,9 @@ static unsigned int rpmsg_tty_write_room(struct tty_struct *tty)
 	struct rpmsg_tty_port *cport = tty->driver_data;
 	int size;
 
+	if (cport->flow_stopped)
+		return 0;
+
 	size = rpmsg_get_mtu(cport->rpdev->ept);
 	if (size < 0)
 		return 0;
@@ -118,6 +122,28 @@ static void rpmsg_tty_hangup(struct tty_struct *tty)
 	tty_port_hangup(tty->port);
 }
 
+static void rpmsg_tty_throttle(struct tty_struct *tty)
+{
+	struct rpmsg_tty_port *cport = tty->driver_data;
+	int ret;
+
+	/* Disable remote transmission */
+	ret = rpmsg_set_flow_control(cport->rpdev->ept, RPMSG_ADDR_ANY, 0);
+	if (ret && ret != ENXIO)
+		dev_err(tty->dev, "cannot send control (%d)\n", ret);
+};
+
+static void rpmsg_tty_unthrottle(struct tty_struct *tty)
+{
+	struct rpmsg_tty_port *cport = tty->driver_data;
+	int ret;
+
+	/* Enable remote transmission */
+	ret = rpmsg_set_flow_control(cport->rpdev->ept, RPMSG_ADDR_ANY, 1);
+	if (ret && ret != ENXIO)
+		dev_err(tty->dev, "cannot send control (%d)\n", ret);
+};
+
 static const struct tty_operations rpmsg_tty_ops = {
 	.install	= rpmsg_tty_install,
 	.open		= rpmsg_tty_open,
@@ -126,6 +152,8 @@ static const struct tty_operations rpmsg_tty_ops = {
 	.write_room	= rpmsg_tty_write_room,
 	.hangup		= rpmsg_tty_hangup,
 	.cleanup	= rpmsg_tty_cleanup,
+	.throttle	= rpmsg_tty_throttle,
+	.unthrottle	= rpmsg_tty_unthrottle,
 };
 
 static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
@@ -162,11 +190,32 @@ static void rpmsg_tty_destruct_port(struct tty_port *port)
 	kfree(cport);
 }
 
+static void rpmsg_tty_dtr_rts(struct tty_port *port, int raise)
+{
+	if (!port->tty)
+		return;
+
+	if (raise)
+		rpmsg_tty_unthrottle(port->tty);
+	else
+		rpmsg_tty_throttle(port->tty);
+}
+
 static const struct tty_port_operations rpmsg_tty_port_ops = {
 	.destruct = rpmsg_tty_destruct_port,
+	.dtr_rts  = rpmsg_tty_dtr_rts,
 };
 
 
+static int rpmsg_tty_dsr_cts(struct rpmsg_device *rpdev, void *priv, u32 state)
+{
+	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
+
+	cport->flow_stopped = !state;
+
+	return 0;
+}
+
 static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 {
 	struct rpmsg_tty_port *cport;
@@ -225,6 +274,7 @@ static struct rpmsg_driver rpmsg_tty_rpmsg_drv = {
 	.probe		= rpmsg_tty_probe,
 	.callback	= rpmsg_tty_cb,
 	.remove		= rpmsg_tty_remove,
+	.signals        = rpmsg_tty_dsr_cts,
 };
 
 static int __init rpmsg_tty_init(void)
-- 
2.25.1

