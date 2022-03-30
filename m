Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDEA4EC7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348031AbiC3PJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343989AbiC3PIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD374A27E1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FB31477;
        Wed, 30 Mar 2022 08:06:57 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 357633F73B;
        Wed, 30 Mar 2022 08:06:56 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 18/22] firmware: arm_scmi: Use common iterators in Perf protocol
Date:   Wed, 30 Mar 2022 16:05:47 +0100
Message-Id: <20220330150551.2573938-19-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Perf protocol use the common iterator protocol helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 117 ++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 48 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 9e046fd121b9..e1aa0ed67971 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -272,66 +272,87 @@ static int opp_cmp_func(const void *opp1, const void *opp2)
 	return t1->perf - t2->perf;
 }
 
-static int
-scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
-			      struct perf_dom_info *perf_dom)
+struct scmi_perf_ipriv {
+	u32 domain;
+	struct perf_dom_info *perf_dom;
+};
+
+static void iter_perf_levels_prepare_message(void *message,
+					     unsigned int desc_index,
+					     const void *priv)
 {
-	int ret, cnt;
-	u32 tot_opp_cnt = 0;
-	u16 num_returned, num_remaining;
-	struct scmi_xfer *t;
-	struct scmi_opp *opp;
-	struct scmi_msg_perf_describe_levels *dom_info;
-	struct scmi_msg_resp_perf_describe_levels *level_info;
+	struct scmi_msg_perf_describe_levels *msg = message;
+	const struct scmi_perf_ipriv *p = priv;
 
-	ret = ph->xops->xfer_get_init(ph, PERF_DESCRIBE_LEVELS,
-				      sizeof(*dom_info), 0, &t);
-	if (ret)
-		return ret;
+	msg->domain = cpu_to_le32(p->domain);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->level_index = cpu_to_le32(desc_index);
+}
 
-	dom_info = t->tx.buf;
-	level_info = t->rx.buf;
+static int iter_perf_levels_update_state(struct scmi_iterator_state *st,
+					 const void *response, void *priv)
+{
+	const struct scmi_msg_resp_perf_describe_levels *r = response;
 
-	do {
-		dom_info->domain = cpu_to_le32(domain);
-		/* Set the number of OPPs to be skipped/already read */
-		dom_info->level_index = cpu_to_le32(tot_opp_cnt);
+	st->num_returned = le16_to_cpu(r->num_returned);
+	st->num_remaining = le16_to_cpu(r->num_remaining);
 
-		ret = ph->xops->do_xfer(ph, t);
-		if (ret)
-			break;
+	return 0;
+}
 
-		num_returned = le16_to_cpu(level_info->num_returned);
-		num_remaining = le16_to_cpu(level_info->num_remaining);
-		if (tot_opp_cnt + num_returned > MAX_OPPS) {
-			dev_err(ph->dev, "No. of OPPs exceeded MAX_OPPS");
-			break;
-		}
+static int
+iter_perf_levels_process_response(const struct scmi_protocol_handle *ph,
+				  const void *response,
+				  struct scmi_iterator_state *st, void *priv)
+{
+	struct scmi_opp *opp;
+	const struct scmi_msg_resp_perf_describe_levels *r = response;
+	struct scmi_perf_ipriv *p = priv;
 
-		opp = &perf_dom->opp[tot_opp_cnt];
-		for (cnt = 0; cnt < num_returned; cnt++, opp++) {
-			opp->perf = le32_to_cpu(level_info->opp[cnt].perf_val);
-			opp->power = le32_to_cpu(level_info->opp[cnt].power);
-			opp->trans_latency_us = le16_to_cpu
-				(level_info->opp[cnt].transition_latency_us);
+	opp = &p->perf_dom->opp[st->desc_index + st->loop_idx];
+	opp->perf = le32_to_cpu(r->opp[st->loop_idx].perf_val);
+	opp->power = le32_to_cpu(r->opp[st->loop_idx].power);
+	opp->trans_latency_us =
+		le16_to_cpu(r->opp[st->loop_idx].transition_latency_us);
+	p->perf_dom->opp_count++;
 
-			dev_dbg(ph->dev, "Level %d Power %d Latency %dus\n",
-				opp->perf, opp->power, opp->trans_latency_us);
-		}
+	dev_dbg(ph->dev, "Level %d Power %d Latency %dus\n",
+		opp->perf, opp->power, opp->trans_latency_us);
 
-		tot_opp_cnt += num_returned;
+	return 0;
+}
 
-		ph->xops->reset_rx_to_maxsz(ph, t);
-		/*
-		 * check for both returned and remaining to avoid infinite
-		 * loop due to buggy firmware
-		 */
-	} while (num_returned && num_remaining);
+static int
+scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
+			      struct perf_dom_info *perf_dom)
+{
+	int ret;
+	void *iter;
+	struct scmi_msg_perf_describe_levels *msg;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_perf_levels_prepare_message,
+		.update_state = iter_perf_levels_update_state,
+		.process_response = iter_perf_levels_process_response,
+	};
+	struct scmi_perf_ipriv ppriv = {
+		.domain = domain,
+		.perf_dom = perf_dom,
+	};
+
+	iter = ph->hops->iter_response_init(ph, &ops, MAX_OPPS,
+					    PERF_DESCRIBE_LEVELS,
+					    sizeof(*msg), &ppriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	ret = ph->hops->iter_response_run(iter);
+	if (ret)
+		return ret;
 
-	perf_dom->opp_count = tot_opp_cnt;
-	ph->xops->xfer_put(ph, t);
+	if (perf_dom->opp_count)
+		sort(perf_dom->opp, perf_dom->opp_count,
+		     sizeof(struct scmi_opp), opp_cmp_func, NULL);
 
-	sort(perf_dom->opp, tot_opp_cnt, sizeof(*opp), opp_cmp_func, NULL);
 	return ret;
 }
 
-- 
2.32.0

