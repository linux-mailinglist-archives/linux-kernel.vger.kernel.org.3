Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA20B4D2886
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiCIFi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiCIFiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:38:18 -0500
Received: from smtp.tom.com (smtprz14.163.net [106.3.154.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AF915FC86
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:37:20 -0800 (PST)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id 0F0DAB00D54
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:37:18 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID 1559286216
          for <linux-kernel@vger.kernel.org>;
          Wed, 09 Mar 2022 13:37:18 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id F1C13B00D46
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:37:17 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646804237; bh=MUh5KVNE2W4JLszfknRl0oZMTR+2Hb8TA8gRL7Ml8FY=;
        h=From:To:Cc:Subject:Date:From;
        b=dBkLykuegjCYgs/29jw8bX+MG1DKtbQbXhdlYpEviHRgW0qTE8+GpmxQ/lHj4k7ag
         SGJc+H9NwX2Hb2QjG+UoogiuRVjWxIKvz33zN3A4vGPfE4aI2Stt+lcUn/nwW0jSke
         MG+/H9Vy/Aa5/f3V9/mKiYFZJMziFkek7Dt9YNxM=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id DFD95D415B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:37:17 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8WGa6UERejBq for <linux-kernel@vger.kernel.org>;
        Wed,  9 Mar 2022 13:37:16 +0800 (CST)
Received: from localhost.localdomain (unknown [101.93.196.13])
        by antispam1.tom.com (Postfix) with ESMTPA id 5CB87D4155F;
        Wed,  9 Mar 2022 13:37:15 +0800 (CST)
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
        yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH v2 1/2] nvmet-tcp: support specifying the congestion-control
Date:   Wed,  9 Mar 2022 13:37:11 +0800
Message-Id: <20220309053711.2561-1-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mingbao Sun <tyler.sun@dell.com>

congestion-control could have a noticeable impaction on the
performance of TCP-based communications. This is of course true
to NVMe_over_TCP.

Different congestion-controls (e.g., cubic, dctcp) are suitable for
different scenarios. Proper adoption of congestion control would benefit
the performance. On the contrary, the performance could be destroyed.

Though we can specify the congestion-control of NVMe_over_TCP via
writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
changes the congestion-control of all the future TCP sockets that
have not been explicitly assigned the congestion-control, thus bringing
potential impaction on their performance.

So it makes sense to make NVMe_over_TCP support specifying the
congestion-control. And this commit addresses the target side.

Implementation approach:
the following new file entry was created for user to specify the
congestion-control of each nvmet port.
'/sys/kernel/config/nvmet/ports/X/tcp_congestion'
Then later in nvmet_tcp_add_port, the specified congestion-control
would be applied to the listening socket of the nvmet port.

Signed-off-by: Mingbao Sun <tyler.sun@dell.com>
---
 drivers/nvme/target/configfs.c | 37 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 27 +++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..644e89bb0ee9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -222,6 +222,41 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_trsvcid);
 
+static ssize_t nvmet_tcp_congestion_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			port->tcp_congestion ? port->tcp_congestion : "");
+}
+
+static ssize_t nvmet_tcp_congestion_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int len;
+	char *buf;
+
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	buf = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	kfree(port->tcp_congestion);
+	port->tcp_congestion = buf;
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, tcp_congestion);
+
 static ssize_t nvmet_param_inline_data_size_show(struct config_item *item,
 		char *page)
 {
@@ -1597,6 +1632,7 @@ static void nvmet_port_release(struct config_item *item)
 	list_del(&port->global_entry);
 
 	kfree(port->ana_state);
+	kfree(port->tcp_congestion);
 	kfree(port);
 }
 
@@ -1605,6 +1641,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_treq,
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
+	&nvmet_attr_tcp_congestion,
 	&nvmet_attr_addr_trtype,
 	&nvmet_attr_param_inline_data_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69637bf8f8e1..76a57c4c3456 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -145,6 +145,7 @@ struct nvmet_port {
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
+	const char			*tcp_congestion;
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 83ca577f72be..3b72e782c901 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1657,8 +1657,10 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 	struct nvmet_tcp_port *port =
 		container_of(w, struct nvmet_tcp_port, accept_work);
 	struct socket *newsock;
+	struct inet_connection_sock *icsk, *icsk_new;
 	int ret;
 
+	icsk = inet_csk(port->sock->sk);
 	while (true) {
 		ret = kernel_accept(port->sock, &newsock, O_NONBLOCK);
 		if (ret < 0) {
@@ -1666,6 +1668,16 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 				pr_warn("failed to accept err=%d\n", ret);
 			return;
 		}
+
+		if (port->nport->tcp_congestion) {
+			icsk_new = inet_csk(newsock->sk);
+			if (icsk_new->icsk_ca_ops != icsk->icsk_ca_ops) {
+				pr_warn("congestion abnormal: expected %s, actual %s.\n",
+					icsk->icsk_ca_ops->name,
+					icsk_new->icsk_ca_ops->name);
+			}
+		}
+
 		ret = nvmet_tcp_alloc_queue(port, newsock);
 		if (ret) {
 			pr_err("failed to allocate queue\n");
@@ -1693,6 +1705,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
 	__kernel_sa_family_t af;
+	char ca_name[TCP_CA_NAME_MAX];
+	sockptr_t optval;
 	int ret;
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
@@ -1741,6 +1755,19 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
 
+	if (nport->tcp_congestion) {
+		strncpy(ca_name, nport->tcp_congestion, TCP_CA_NAME_MAX-1);
+		optval = KERNEL_SOCKPTR(ca_name);
+		ret = sock_common_setsockopt(port->sock, IPPROTO_TCP,
+					     TCP_CONGESTION, optval,
+					     strlen(ca_name));
+		if (ret) {
+			pr_err("failed to set port socket's congestion to %s: %d\n",
+			       ca_name, ret);
+			goto err_sock;
+		}
+	}
+
 	ret = kernel_bind(port->sock, (struct sockaddr *)&port->addr,
 			sizeof(port->addr));
 	if (ret) {
-- 
2.26.2

