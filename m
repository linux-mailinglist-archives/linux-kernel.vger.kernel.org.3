Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F256522F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiGDKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiGDKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:23:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E8DCE30
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:23:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB2A14BF;
        Mon,  4 Jul 2022 03:23:10 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFA413F792;
        Mon,  4 Jul 2022 03:23:07 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 3/7] firmware: arm_scmi: Generalize FastChannel support
Date:   Mon,  4 Jul 2022 11:22:37 +0100
Message-Id: <20220704102241.2988447-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704102241.2988447-1-cristian.marussi@arm.com>
References: <20220704102241.2988447-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize existing FastChannel support used in Perf protocol and make it
available to possibly any protocol refactoring the common code into a
couple of new scmi_proto_helpers_ops routines.

Make Perf protocol FC use this new infrastructure.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 165 ++++++++++++++++++++
 drivers/firmware/arm_scmi/perf.c      | 215 ++++++--------------------
 drivers/firmware/arm_scmi/protocols.h |  22 +++
 3 files changed, 231 insertions(+), 171 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6ba1faaf5422..00b7f2aff4ec 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -19,6 +19,7 @@
 #include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/hashtable.h>
@@ -1259,10 +1260,174 @@ static int scmi_iterator_run(void *iter)
 	return ret;
 }
 
+struct scmi_msg_get_fc_info {
+	__le32 domain;
+	__le32 message_id;
+};
+
+struct scmi_msg_resp_desc_fc {
+	__le32 attr;
+#define SUPPORTS_DOORBELL(x)		((x) & BIT(0))
+#define DOORBELL_REG_WIDTH(x)		FIELD_GET(GENMASK(2, 1), (x))
+	__le32 rate_limit;
+	__le32 chan_addr_low;
+	__le32 chan_addr_high;
+	__le32 chan_size;
+	__le32 db_addr_low;
+	__le32 db_addr_high;
+	__le32 db_set_lmask;
+	__le32 db_set_hmask;
+	__le32 db_preserve_lmask;
+	__le32 db_preserve_hmask;
+};
+
+static void
+scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
+			     u8 describe_id, u32 message_id, u32 valid_size,
+			     u32 domain, void __iomem **p_addr,
+			     struct scmi_fc_db_info **p_db)
+{
+	int ret;
+	u32 flags;
+	u64 phys_addr;
+	u8 size;
+	void __iomem *addr;
+	struct scmi_xfer *t;
+	struct scmi_fc_db_info *db = NULL;
+	struct scmi_msg_get_fc_info *info;
+	struct scmi_msg_resp_desc_fc *resp;
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	if (!p_addr) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	ret = ph->xops->xfer_get_init(ph, describe_id,
+				      sizeof(*info), sizeof(*resp), &t);
+	if (ret)
+		goto err_out;
+
+	info = t->tx.buf;
+	info->domain = cpu_to_le32(domain);
+	info->message_id = cpu_to_le32(message_id);
+
+	/*
+	 * Bail out on error leaving fc_info addresses zeroed; this includes
+	 * the case in which the requested domain/message_id does NOT support
+	 * fastchannels at all.
+	 */
+	ret = ph->xops->do_xfer(ph, t);
+	if (ret)
+		goto err_xfer;
+
+	resp = t->rx.buf;
+	flags = le32_to_cpu(resp->attr);
+	size = le32_to_cpu(resp->chan_size);
+	if (size != valid_size) {
+		ret = -EINVAL;
+		goto err_xfer;
+	}
+
+	phys_addr = le32_to_cpu(resp->chan_addr_low);
+	phys_addr |= (u64)le32_to_cpu(resp->chan_addr_high) << 32;
+	addr = devm_ioremap(ph->dev, phys_addr, size);
+	if (!addr) {
+		ret = -EADDRNOTAVAIL;
+		goto err_xfer;
+	}
+
+	*p_addr = addr;
+
+	if (p_db && SUPPORTS_DOORBELL(flags)) {
+		db = devm_kzalloc(ph->dev, sizeof(*db), GFP_KERNEL);
+		if (!db) {
+			ret = -ENOMEM;
+			goto err_db;
+		}
+
+		size = 1 << DOORBELL_REG_WIDTH(flags);
+		phys_addr = le32_to_cpu(resp->db_addr_low);
+		phys_addr |= (u64)le32_to_cpu(resp->db_addr_high) << 32;
+		addr = devm_ioremap(ph->dev, phys_addr, size);
+		if (!addr) {
+			ret = -EADDRNOTAVAIL;
+			goto err_db_mem;
+		}
+
+		db->addr = addr;
+		db->width = size;
+		db->set = le32_to_cpu(resp->db_set_lmask);
+		db->set |= (u64)le32_to_cpu(resp->db_set_hmask) << 32;
+		db->mask = le32_to_cpu(resp->db_preserve_lmask);
+		db->mask |= (u64)le32_to_cpu(resp->db_preserve_hmask) << 32;
+
+		*p_db = db;
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	dev_dbg(ph->dev,
+		"Using valid FC for protocol %X [MSG_ID:%u / RES_ID:%u]\n",
+		pi->proto->id, message_id, domain);
+
+	return;
+
+err_db_mem:
+	devm_kfree(ph->dev, db);
+
+err_db:
+	*p_addr = NULL;
+
+err_xfer:
+	ph->xops->xfer_put(ph, t);
+
+err_out:
+	dev_warn(ph->dev,
+		 "Failed to get FC for protocol %X [MSG_ID:%u / RES_ID:%u] - ret:%d. Using regular messaging.\n",
+		 pi->proto->id, message_id, domain, ret);
+}
+
+#define SCMI_PROTO_FC_RING_DB(w)			\
+do {							\
+	u##w val = 0;					\
+							\
+	if (db->mask)					\
+		val = ioread##w(db->addr) & db->mask;	\
+	iowrite##w((u##w)db->set | val, db->addr);	\
+} while (0)
+
+static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
+{
+	if (!db || !db->addr)
+		return;
+
+	if (db->width == 1)
+		SCMI_PROTO_FC_RING_DB(8);
+	else if (db->width == 2)
+		SCMI_PROTO_FC_RING_DB(16);
+	else if (db->width == 4)
+		SCMI_PROTO_FC_RING_DB(32);
+	else /* db->width == 8 */
+#ifdef CONFIG_64BIT
+		SCMI_PROTO_FC_RING_DB(64);
+#else
+	{
+		u64 val = 0;
+
+		if (db->mask)
+			val = ioread64_hi_lo(db->addr) & db->mask;
+		iowrite64_hi_lo(db->set | val, db->addr);
+	}
+#endif
+}
+
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
+	.fastchannel_init = scmi_common_fastchannel_init,
+	.fastchannel_db_ring = scmi_common_fastchannel_db_ring,
 };
 
 /**
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index bbb0331801ff..521458fda355 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -10,7 +10,6 @@
 #include <linux/bits.h>
 #include <linux/of.h>
 #include <linux/io.h>
-#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -35,6 +34,12 @@ enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_NAME_GET = 0xc,
 };
 
+enum {
+	PERF_FC_LEVEL,
+	PERF_FC_LIMIT,
+	PERF_FC_MAX,
+};
+
 struct scmi_opp {
 	u32 perf;
 	u32 power;
@@ -115,43 +120,6 @@ struct scmi_msg_resp_perf_describe_levels {
 	} opp[];
 };
 
-struct scmi_perf_get_fc_info {
-	__le32 domain;
-	__le32 message_id;
-};
-
-struct scmi_msg_resp_perf_desc_fc {
-	__le32 attr;
-#define SUPPORTS_DOORBELL(x)		((x) & BIT(0))
-#define DOORBELL_REG_WIDTH(x)		FIELD_GET(GENMASK(2, 1), (x))
-	__le32 rate_limit;
-	__le32 chan_addr_low;
-	__le32 chan_addr_high;
-	__le32 chan_size;
-	__le32 db_addr_low;
-	__le32 db_addr_high;
-	__le32 db_set_lmask;
-	__le32 db_set_hmask;
-	__le32 db_preserve_lmask;
-	__le32 db_preserve_hmask;
-};
-
-struct scmi_fc_db_info {
-	int width;
-	u64 set;
-	u64 mask;
-	void __iomem *addr;
-};
-
-struct scmi_fc_info {
-	void __iomem *level_set_addr;
-	void __iomem *limit_set_addr;
-	void __iomem *level_get_addr;
-	void __iomem *limit_get_addr;
-	struct scmi_fc_db_info *level_set_db;
-	struct scmi_fc_db_info *limit_set_db;
-};
-
 struct perf_dom_info {
 	bool set_limits;
 	bool set_perf;
@@ -360,40 +328,6 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 	return ret;
 }
 
-#define SCMI_PERF_FC_RING_DB(w)				\
-do {							\
-	u##w val = 0;					\
-							\
-	if (db->mask)					\
-		val = ioread##w(db->addr) & db->mask;	\
-	iowrite##w((u##w)db->set | val, db->addr);	\
-} while (0)
-
-static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
-{
-	if (!db || !db->addr)
-		return;
-
-	if (db->width == 1)
-		SCMI_PERF_FC_RING_DB(8);
-	else if (db->width == 2)
-		SCMI_PERF_FC_RING_DB(16);
-	else if (db->width == 4)
-		SCMI_PERF_FC_RING_DB(32);
-	else /* db->width == 8 */
-#ifdef CONFIG_64BIT
-		SCMI_PERF_FC_RING_DB(64);
-#else
-	{
-		u64 val = 0;
-
-		if (db->mask)
-			val = ioread64_hi_lo(db->addr) & db->mask;
-		iowrite64_hi_lo(db->set | val, db->addr);
-	}
-#endif
-}
-
 static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
 				   u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -426,10 +360,12 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3 && !max_perf && !min_perf)
 		return -EINVAL;
 
-	if (dom->fc_info && dom->fc_info->limit_set_addr) {
-		iowrite32(max_perf, dom->fc_info->limit_set_addr);
-		iowrite32(min_perf, dom->fc_info->limit_set_addr + 4);
-		scmi_perf_fc_ring_db(dom->fc_info->limit_set_db);
+	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].set_addr) {
+		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
+
+		iowrite32(max_perf, fci->set_addr);
+		iowrite32(min_perf, fci->set_addr + 4);
+		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
 	}
 
@@ -468,9 +404,11 @@ static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	if (dom->fc_info && dom->fc_info->limit_get_addr) {
-		*max_perf = ioread32(dom->fc_info->limit_get_addr);
-		*min_perf = ioread32(dom->fc_info->limit_get_addr + 4);
+	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].get_addr) {
+		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
+
+		*max_perf = ioread32(fci->get_addr);
+		*min_perf = ioread32(fci->get_addr + 4);
 		return 0;
 	}
 
@@ -505,9 +443,11 @@ static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	if (dom->fc_info && dom->fc_info->level_set_addr) {
-		iowrite32(level, dom->fc_info->level_set_addr);
-		scmi_perf_fc_ring_db(dom->fc_info->level_set_db);
+	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
+		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
+
+		iowrite32(level, fci->set_addr);
+		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
 	}
 
@@ -542,8 +482,8 @@ static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	if (dom->fc_info && dom->fc_info->level_get_addr) {
-		*level = ioread32(dom->fc_info->level_get_addr);
+	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
+		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
 		return 0;
 	}
 
@@ -572,100 +512,33 @@ static int scmi_perf_level_limits_notify(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static bool scmi_perf_fc_size_is_valid(u32 msg, u32 size)
-{
-	if ((msg == PERF_LEVEL_GET || msg == PERF_LEVEL_SET) && size == 4)
-		return true;
-	if ((msg == PERF_LIMITS_GET || msg == PERF_LIMITS_SET) && size == 8)
-		return true;
-	return false;
-}
-
-static void
-scmi_perf_domain_desc_fc(const struct scmi_protocol_handle *ph, u32 domain,
-			 u32 message_id, void __iomem **p_addr,
-			 struct scmi_fc_db_info **p_db)
-{
-	int ret;
-	u32 flags;
-	u64 phys_addr;
-	u8 size;
-	void __iomem *addr;
-	struct scmi_xfer *t;
-	struct scmi_fc_db_info *db;
-	struct scmi_perf_get_fc_info *info;
-	struct scmi_msg_resp_perf_desc_fc *resp;
-
-	if (!p_addr)
-		return;
-
-	ret = ph->xops->xfer_get_init(ph, PERF_DESCRIBE_FASTCHANNEL,
-				      sizeof(*info), sizeof(*resp), &t);
-	if (ret)
-		return;
-
-	info = t->tx.buf;
-	info->domain = cpu_to_le32(domain);
-	info->message_id = cpu_to_le32(message_id);
-
-	ret = ph->xops->do_xfer(ph, t);
-	if (ret)
-		goto err_xfer;
-
-	resp = t->rx.buf;
-	flags = le32_to_cpu(resp->attr);
-	size = le32_to_cpu(resp->chan_size);
-	if (!scmi_perf_fc_size_is_valid(message_id, size))
-		goto err_xfer;
-
-	phys_addr = le32_to_cpu(resp->chan_addr_low);
-	phys_addr |= (u64)le32_to_cpu(resp->chan_addr_high) << 32;
-	addr = devm_ioremap(ph->dev, phys_addr, size);
-	if (!addr)
-		goto err_xfer;
-	*p_addr = addr;
-
-	if (p_db && SUPPORTS_DOORBELL(flags)) {
-		db = devm_kzalloc(ph->dev, sizeof(*db), GFP_KERNEL);
-		if (!db)
-			goto err_xfer;
-
-		size = 1 << DOORBELL_REG_WIDTH(flags);
-		phys_addr = le32_to_cpu(resp->db_addr_low);
-		phys_addr |= (u64)le32_to_cpu(resp->db_addr_high) << 32;
-		addr = devm_ioremap(ph->dev, phys_addr, size);
-		if (!addr)
-			goto err_xfer;
-
-		db->addr = addr;
-		db->width = size;
-		db->set = le32_to_cpu(resp->db_set_lmask);
-		db->set |= (u64)le32_to_cpu(resp->db_set_hmask) << 32;
-		db->mask = le32_to_cpu(resp->db_preserve_lmask);
-		db->mask |= (u64)le32_to_cpu(resp->db_preserve_hmask) << 32;
-		*p_db = db;
-	}
-err_xfer:
-	ph->xops->xfer_put(ph, t);
-}
-
 static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 				     u32 domain, struct scmi_fc_info **p_fc)
 {
 	struct scmi_fc_info *fc;
 
-	fc = devm_kzalloc(ph->dev, sizeof(*fc), GFP_KERNEL);
+	fc = devm_kcalloc(ph->dev, PERF_FC_MAX, sizeof(*fc), GFP_KERNEL);
 	if (!fc)
 		return;
 
-	scmi_perf_domain_desc_fc(ph, domain, PERF_LEVEL_SET,
-				 &fc->level_set_addr, &fc->level_set_db);
-	scmi_perf_domain_desc_fc(ph, domain, PERF_LEVEL_GET,
-				 &fc->level_get_addr, NULL);
-	scmi_perf_domain_desc_fc(ph, domain, PERF_LIMITS_SET,
-				 &fc->limit_set_addr, &fc->limit_set_db);
-	scmi_perf_domain_desc_fc(ph, domain, PERF_LIMITS_GET,
-				 &fc->limit_get_addr, NULL);
+	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
+				   PERF_LEVEL_SET, 4, domain,
+				   &fc[PERF_FC_LEVEL].set_addr,
+				   &fc[PERF_FC_LEVEL].set_db);
+
+	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
+				   PERF_LEVEL_GET, 4, domain,
+				   &fc[PERF_FC_LEVEL].get_addr, NULL);
+
+	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
+				   PERF_LIMITS_SET, 8, domain,
+				   &fc[PERF_FC_LIMIT].set_addr,
+				   &fc[PERF_FC_LIMIT].set_db);
+
+	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
+				   PERF_LIMITS_GET, 8, domain,
+				   &fc[PERF_FC_LIMIT].get_addr, NULL);
+
 	*p_fc = fc;
 }
 
@@ -789,7 +662,7 @@ static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 
 	dom = pi->dom_info + scmi_dev_domain_id(dev);
 
-	return dom->fc_info && dom->fc_info->level_set_addr;
+	return dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr;
 }
 
 static bool scmi_power_scale_mw_get(const struct scmi_protocol_handle *ph)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 99d36d503d1e..2f3bf691db7c 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -215,6 +215,19 @@ struct scmi_iterator_ops {
 				struct scmi_iterator_state *st, void *priv);
 };
 
+struct scmi_fc_db_info {
+	int width;
+	u64 set;
+	u64 mask;
+	void __iomem *addr;
+};
+
+struct scmi_fc_info {
+	void __iomem *set_addr;
+	void __iomem *get_addr;
+	struct scmi_fc_db_info *set_db;
+};
+
 /**
  * struct scmi_proto_helpers_ops  - References to common protocol helpers
  * @extended_name_get: A common helper function to retrieve extended naming
@@ -230,6 +243,9 @@ struct scmi_iterator_ops {
  *			provided in @ops.
  * @iter_response_run: A common helper to trigger the run of a previously
  *		       initialized iterator.
+ * @fastchannel_init: A common helper used to initialize FC descriptors by
+ *		      gathering FC descriptions from the SCMI platform server.
+ * @fastchannel_db_ring: A common helper to ring a FC doorbell.
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
@@ -239,6 +255,12 @@ struct scmi_proto_helpers_ops {
 				    unsigned int max_resources, u8 msg_id,
 				    size_t tx_size, void *priv);
 	int (*iter_response_run)(void *iter);
+	void (*fastchannel_init)(const struct scmi_protocol_handle *ph,
+				 u8 describe_id, u32 message_id,
+				 u32 valid_size, u32 domain,
+				 void __iomem **p_addr,
+				 struct scmi_fc_db_info **p_db);
+	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
 };
 
 /**
-- 
2.32.0

