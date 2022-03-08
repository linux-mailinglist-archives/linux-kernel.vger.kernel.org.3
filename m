Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A472A4D1B79
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiCHPRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiCHPRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:17:19 -0500
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805B49C81
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:16:22 -0800 (PST)
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
        by freemail01.tom.com (Postfix) with ESMTP id 73F8A1E8C3DC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:16:20 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app01 (TOM SMTP Server) with SMTP ID -1075537059
          for <linux-kernel@vger.kernel.org>;
          Tue, 08 Mar 2022 23:16:20 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
        by freemail01.tom.com (Postfix) with ESMTP id 6798A1E8C3CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:16:18 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646752580; bh=FTUyeqP9ND6tbc1AQbw9ynrNsmhXbcmZue+wn4NbGCw=;
        h=From:To:Cc:Subject:Date:From;
        b=uRKWZDgwaKmU0liSzKswhNFPYu3XdBul7+b9pZQCWmL/lTNvSBSIcWR5wnvq38Mxh
         DNJoDuNCTY8n4wpIm/ePU0Zm0XPvAvMiJiul8UpAD9quD07lnJVM8T/H0A6PKFFTEf
         UJDs7tkY9PPI8MlMVbnR70q0slQDpLKJgllQ5JMk=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
        by antispam3.tom.com (Postfix) with ESMTP id AA7599C1C2A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:16:16 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
        by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OUvFBl7-fTrB for <linux-kernel@vger.kernel.org>;
        Tue,  8 Mar 2022 23:16:15 +0800 (CST)
Received: from localhost.localdomain (unknown [101.93.196.13])
        by antispam3.tom.com (Postfix) with ESMTPA id 6B3BC9C1BBF;
        Tue,  8 Mar 2022 23:16:12 +0800 (CST)
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
        yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Date:   Tue,  8 Mar 2022 23:16:06 +0800
Message-Id: <20220308151606.2563-1-sunmingbao@tom.com>
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
congestion-control. And this commit addresses the host side.

Implementation approach:
a new option called 'tcp_congestion' was created in fabrics opt_tokens
for 'nvme connect' command to passed in the congestion-control
specified by the user.
Then later in nvme_tcp_alloc_queue, the specified congestion-control
would be applied to the relevant sockets of the host side.

Signed-off-by: Mingbao Sun <tyler.sun@dell.com>
---
 drivers/nvme/host/fabrics.c | 12 ++++++++++++
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/tcp.c     | 20 +++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee79a6d639b4..79d5f0dbafd3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
+	{ NVMF_OPT_TCP_CONGESTION,	"tcp_congestion=%s"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -829,6 +830,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
+		case NVMF_OPT_TCP_CONGESTION:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			kfree(opts->tcp_congestion);
+			opts->tcp_congestion = p;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -947,6 +958,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
+	kfree(opts->tcp_congestion);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c3203ff1c654..25fdc169949d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -68,6 +68,7 @@ enum {
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
 	NVMF_OPT_DISCOVERY	= 1 << 22,
+	NVMF_OPT_TCP_CONGESTION	= 1 << 23,
 };
 
 /**
@@ -117,6 +118,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_io_queues;
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
+	const char		*tcp_congestion;
 	bool			duplicate_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index babbc14a4b76..3415e178a78b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1403,6 +1403,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	char ca_name[TCP_CA_NAME_MAX];
+	sockptr_t optval;
 	int ret, rcv_pdu_size;
 
 	mutex_init(&queue->queue_lock);
@@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
 
+	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
+		strncpy(ca_name, nctrl->opts->tcp_congestion,
+			TCP_CA_NAME_MAX-1);
+		optval = KERNEL_SOCKPTR(ca_name);
+		ret = sock_common_setsockopt(queue->sock, IPPROTO_TCP,
+					     TCP_CONGESTION, optval,
+					     strlen(ca_name));
+		if (ret) {
+			dev_err(nctrl->device,
+				"failed to set TCP congestion to %s: %d\n",
+				ca_name, ret);
+			goto err_sock;
+		}
+	}
+
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
 
@@ -2610,7 +2627,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE |
+			  NVMF_OPT_TCP_CONGESTION,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.26.2

