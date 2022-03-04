Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF74CD177
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiCDJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiCDJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:42:00 -0500
Received: from smtp.tom.com (smtprz14.163.net [106.3.154.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57631B01B6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:40:38 -0800 (PST)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id 4C852B00D4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:29:16 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID 1887978912
          for <linux-kernel@vger.kernel.org>;
          Fri, 04 Mar 2022 17:29:16 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id 2A9E3B00D70
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:29:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646386156; bh=a8O+cqlKrcAi4SPISzPwhi3ONqz/CHSJ1yBQ/iW1LBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaTz/KHMSN8lazFwZ859MuANQQZSWw6HJumLrrfsawRSgD9SEFfr5VpBPJq03BRi8
         LFp5E7dgwDV0TSQ77YLVrxxYfrQeHMM3WgaDpR+lCZUxJ3UsFHLxMkIl6kY7FWZeZA
         Y7lonHTfGQqou9Oidn2NbLM6+TzCSGCtOfKma1f0=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id F3D45D41598
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:29:15 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RI0BWn6DzwPT for <linux-kernel@vger.kernel.org>;
        Fri,  4 Mar 2022 17:29:14 +0800 (CST)
Received: from localhost.localdomain (unknown [39.144.44.23])
        by antispam1.tom.com (Postfix) with ESMTPA id 74437D41530;
        Fri,  4 Mar 2022 17:29:12 +0800 (CST)
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
        yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Date:   Fri,  4 Mar 2022 17:27:54 +0800
Message-Id: <20220304092754.2721-3-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220304092754.2721-1-sunmingbao@tom.com>
References: <20220304092754.2721-1-sunmingbao@tom.com>
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
 drivers/nvme/host/fabrics.c | 24 ++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/tcp.c     | 20 +++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee79a6d639b4..6d946f758372 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <net/tcp.h>
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -548,6 +549,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
+	{ NVMF_OPT_TCP_CONGESTION,	"tcp_congestion=%s"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -560,6 +562,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
 	uuid_t hostid;
+	bool ecn_ca;
+	u32 key;
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -829,6 +833,25 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
+			key = tcp_ca_get_key_by_name(NULL, p, &ecn_ca);
+			if (key == TCP_CA_UNSPEC) {
+				pr_err("congestion control %s not found.\n",
+				       p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(opts->tcp_congestion);
+			opts->tcp_congestion = p;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -947,6 +970,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
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
index 6cbcc8b4daaf..cb2c7d7371d4 100644
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
 
@@ -2611,7 +2628,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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

