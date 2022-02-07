Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10944AC5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389825AbiBGQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378708AbiBGQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:17:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D3C0401F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:17:14 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217FM5tp006777;
        Mon, 7 Feb 2022 16:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NdP/KVml5UAVIjivNvlz5bWTZh89/20zy0jE1C+VOZo=;
 b=iwEeuZuuRUpmBpIZWWjUXny6rshOMV7UlY+VOFmHgGVhJ60Hb5lCJ1xny8W0N/3dXyQH
 D7l4ISE/JmWvV9CtRNid6cSvTZEl261vDcpaN2/AKnMVJuIcq5RRlpQxU7uzl/Zj6TE7
 xVmUVr57WJ4DCw2qXWbOo4yGU3KMNBuJcsi9YruFTtb+Fd8jWoWma/ra4aQhFdyyZBKd
 /3sSWyEsbE85bj+mUquxRxaUdhAzgYZMjai17LkQ8lSUg9gwOQ3UraG3nrUCSL0BQ388
 ot+aW89waTB7+hs6jiLqZk4wyKL/46IGhZorOKkZoPbzh3rrQ8u/NS10ZXiXQNWbirWb OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22st176f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 16:16:49 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 217FplBh022294;
        Mon, 7 Feb 2022 16:16:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22st175e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 16:16:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 217G7eJ3026432;
        Mon, 7 Feb 2022 16:16:47 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3e1gv9ruus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 16:16:47 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 217GGjHa29819232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 16:16:46 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D81286E04E;
        Mon,  7 Feb 2022 16:16:45 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50E3F6E052;
        Mon,  7 Feb 2022 16:16:45 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.55.47])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 16:16:45 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, mingo@redhat.com,
        alistair@popple.id.au, rostedt@goodmis.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: Add trace events in initialization path
Date:   Mon,  7 Feb 2022 10:16:40 -0600
Message-Id: <20220207161640.35605-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DHPAjkvnzdhpJrx5Rm3il7roCQzTp9ZA
X-Proofpoint-ORIG-GUID: Ziz0m5OQMAaJ-ONkcz6JBupq3eF6Cfk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definitions for trace events to show the scanning flow.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c                   | 11 ++-
 drivers/fsi/fsi-master-aspeed.c          |  2 +
 include/trace/events/fsi.h               | 86 ++++++++++++++++++++++++
 include/trace/events/fsi_master_aspeed.h | 12 ++++
 4 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 59ddc9fd5bca..3a7b78e36701 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -24,9 +24,6 @@
 
 #include "fsi-master.h"
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/fsi.h>
-
 #define FSI_SLAVE_CONF_NEXT_MASK	GENMASK(31, 31)
 #define FSI_SLAVE_CONF_SLOTS_MASK	GENMASK(23, 16)
 #define FSI_SLAVE_CONF_SLOTS_SHIFT	16
@@ -95,6 +92,9 @@ struct fsi_slave {
 	u8			t_echo_delay;
 };
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsi.h>
+
 #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
@@ -524,6 +524,8 @@ static int fsi_slave_scan(struct fsi_slave *slave)
 			dev->addr = engine_addr;
 			dev->size = slots * engine_page_size;
 
+			trace_fsi_dev_init(dev);
+
 			dev_dbg(&slave->dev,
 			"engine[%i]: type %x, version %x, addr %x size %x\n",
 					dev->unit, dev->engine_type, version,
@@ -1006,6 +1008,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	crc = crc4(0, cfam_id, 32);
 	if (crc) {
+		trace_fsi_slave_invalid_cfam(master, link, cfam_id);
 		dev_warn(&master->dev, "slave %02x:%02x invalid cfam id CRC!\n",
 				link, id);
 		return -EIO;
@@ -1080,6 +1083,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	if (rc)
 		goto err_free;
 
+	trace_fsi_slave_init(slave);
+
 	/* Create chardev for userspace access */
 	cdev_init(&slave->cdev, &cfam_fops);
 	rc = cdev_device_add(&slave->cdev, &slave->dev);
diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 0bed2fab8055..7cec1772820d 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -449,11 +449,13 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 {
 	struct fsi_master_aspeed *aspeed = dev_get_drvdata(dev);
 
+	trace_fsi_master_aspeed_cfam_reset(true);
 	mutex_lock(&aspeed->lock);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
 	usleep_range(900, 1000);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
 	mutex_unlock(&aspeed->lock);
+	trace_fsi_master_aspeed_cfam_reset(false);
 
 	return count;
 }
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index 9832cb8e0eb0..c9a72e8432b8 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -122,6 +122,92 @@ TRACE_EVENT(fsi_master_break,
 	)
 );
 
+TRACE_EVENT(fsi_slave_init,
+	TP_PROTO(const struct fsi_slave *slave),
+	TP_ARGS(slave),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	master_n_links)
+		__field(int,	idx)
+		__field(int,	link)
+		__field(int,	chip_id)
+		__field(__u32,	cfam_id)
+		__field(__u32,	size)
+	),
+	TP_fast_assign(
+		__entry->master_idx = slave->master->idx;
+		__entry->master_n_links = slave->master->n_links;
+		__entry->idx = slave->cdev_idx;
+		__entry->link = slave->link;
+		__entry->chip_id = slave->chip_id;
+		__entry->cfam_id = slave->cfam_id;
+		__entry->size = slave->size;
+	),
+	TP_printk("fsi%d: idx:%d link:%d/%d cid:%d cfam:%08x %08x",
+		__entry->master_idx,
+		__entry->idx,
+		__entry->link,
+		__entry->master_n_links,
+		__entry->chip_id,
+		__entry->cfam_id,
+		__entry->size
+	)
+);
+
+TRACE_EVENT(fsi_slave_invalid_cfam,
+	TP_PROTO(const struct fsi_master *master, int link, uint32_t cfam_id),
+	TP_ARGS(master, link, cfam_id),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	master_n_links)
+		__field(int,	link)
+		__field(__u32,	cfam_id)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->master_n_links = master->n_links;
+		__entry->link = link;
+		__entry->cfam_id = cfam_id;
+	),
+	TP_printk("fsi%d: cfam:%08x link:%d/%d",
+		__entry->master_idx,
+		__entry->cfam_id,
+		__entry->link,
+		__entry->master_n_links
+	)
+);
+
+TRACE_EVENT(fsi_dev_init,
+	TP_PROTO(const struct fsi_device *dev),
+	TP_ARGS(dev),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	link)
+		__field(int,	type)
+		__field(int,	unit)
+		__field(int,	version)
+		__field(__u32,	addr)
+		__field(__u32,	size)
+	),
+	TP_fast_assign(
+		__entry->master_idx = dev->slave->master->idx;
+		__entry->link = dev->slave->link;
+		__entry->type = dev->engine_type;
+		__entry->unit = dev->unit;
+		__entry->version = dev->version;
+		__entry->addr = dev->addr;
+		__entry->size = dev->size;
+	),
+	TP_printk("fsi%d: slv%d: t:%02x u:%02x v:%02x %08x@%08x",
+		__entry->master_idx,
+		__entry->link,
+		__entry->type,
+		__entry->unit,
+		__entry->version,
+		__entry->size,
+		__entry->addr
+	)
+);
 
 #endif /* _TRACE_FSI_H */
 
diff --git a/include/trace/events/fsi_master_aspeed.h b/include/trace/events/fsi_master_aspeed.h
index a355ceacc33f..0fff873775f1 100644
--- a/include/trace/events/fsi_master_aspeed.h
+++ b/include/trace/events/fsi_master_aspeed.h
@@ -72,6 +72,18 @@ TRACE_EVENT(fsi_master_aspeed_opb_error,
 		)
 	);
 
+TRACE_EVENT(fsi_master_aspeed_cfam_reset,
+	TP_PROTO(bool start),
+	TP_ARGS(start),
+	TP_STRUCT__entry(
+		__field(bool,	start)
+	),
+	TP_fast_assign(
+		__entry->start = start;
+	),
+	TP_printk("%s", __entry->start ? "start" : "end")
+);
+
 #endif
 
 #include <trace/define_trace.h>
-- 
2.27.0

