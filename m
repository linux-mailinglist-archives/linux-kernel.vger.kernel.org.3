Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6D4EC7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347964AbiC3PJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347931AbiC3PIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC013A1456
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7C21477;
        Wed, 30 Mar 2022 08:06:54 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8EA3F73B;
        Wed, 30 Mar 2022 08:06:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 16/22] firmware: arm_scmi: Use common iterators in Clock protocol
Date:   Wed, 30 Mar 2022 16:05:45 +0100
Message-Id: <20220330150551.2573938-17-cristian.marussi@arm.com>
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

Make SCMI Clock protocol use the common iterator protocol helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 150 ++++++++++++++++++------------
 1 file changed, 90 insertions(+), 60 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index b46b43a99871..48ce7ef9c74b 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -162,81 +162,111 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
 		return 1;
 }
 
-static int
-scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
-			      struct scmi_clock_info *clk)
-{
-	u64 *rate = NULL;
-	int ret, cnt;
-	bool rate_discrete = false;
-	u32 tot_rate_cnt = 0, rates_flag;
-	u16 num_returned, num_remaining;
-	struct scmi_xfer *t;
-	struct scmi_msg_clock_describe_rates *clk_desc;
-	struct scmi_msg_resp_clock_describe_rates *rlist;
+struct scmi_clk_ipriv {
+	u32 clk_id;
+	struct scmi_clock_info *clk;
+};
 
-	ret = ph->xops->xfer_get_init(ph, CLOCK_DESCRIBE_RATES,
-				      sizeof(*clk_desc), 0, &t);
-	if (ret)
-		return ret;
+static void iter_clk_describe_prepare_message(void *message,
+					      const unsigned int desc_index,
+					      const void *priv)
+{
+	struct scmi_msg_clock_describe_rates *msg = message;
+	const struct scmi_clk_ipriv *p = priv;
 
-	clk_desc = t->tx.buf;
-	rlist = t->rx.buf;
+	msg->id = cpu_to_le32(p->clk_id);
+	/* Set the number of rates to be skipped/already read */
+	msg->rate_index = cpu_to_le32(desc_index);
+}
 
-	do {
-		clk_desc->id = cpu_to_le32(clk_id);
-		/* Set the number of rates to be skipped/already read */
-		clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
+static int
+iter_clk_describe_update_state(struct scmi_iterator_state *st,
+			       const void *response, void *priv)
+{
+	u32 flags;
+	struct scmi_clk_ipriv *p = priv;
+	const struct scmi_msg_resp_clock_describe_rates *r = response;
 
-		ret = ph->xops->do_xfer(ph, t);
-		if (ret)
-			goto err;
+	flags = le32_to_cpu(r->num_rates_flags);
+	st->num_remaining = NUM_REMAINING(flags);
+	st->num_returned = NUM_RETURNED(flags);
+	p->clk->rate_discrete = RATE_DISCRETE(flags);
 
-		rates_flag = le32_to_cpu(rlist->num_rates_flags);
-		num_remaining = NUM_REMAINING(rates_flag);
-		rate_discrete = RATE_DISCRETE(rates_flag);
-		num_returned = NUM_RETURNED(rates_flag);
+	return 0;
+}
 
-		if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
-			dev_err(ph->dev, "No. of rates > MAX_NUM_RATES");
+static int
+iter_clk_describe_process_response(const struct scmi_protocol_handle *ph,
+				   const void *response,
+				   struct scmi_iterator_state *st, void *priv)
+{
+	int ret = 0;
+	struct scmi_clk_ipriv *p = priv;
+	const struct scmi_msg_resp_clock_describe_rates *r = response;
+
+	if (!p->clk->rate_discrete) {
+		switch (st->desc_index + st->loop_idx) {
+		case 0:
+			p->clk->range.min_rate = RATE_TO_U64(r->rate[0]);
 			break;
-		}
-
-		if (!rate_discrete) {
-			clk->range.min_rate = RATE_TO_U64(rlist->rate[0]);
-			clk->range.max_rate = RATE_TO_U64(rlist->rate[1]);
-			clk->range.step_size = RATE_TO_U64(rlist->rate[2]);
-			dev_dbg(ph->dev, "Min %llu Max %llu Step %llu Hz\n",
-				clk->range.min_rate, clk->range.max_rate,
-				clk->range.step_size);
+		case 1:
+			p->clk->range.max_rate = RATE_TO_U64(r->rate[1]);
+			break;
+		case 2:
+			p->clk->range.step_size = RATE_TO_U64(r->rate[2]);
+			break;
+		default:
+			ret = -EINVAL;
 			break;
 		}
+	} else {
+		u64 *rate = &p->clk->list.rates[st->desc_index + st->loop_idx];
 
-		rate = &clk->list.rates[tot_rate_cnt];
-		for (cnt = 0; cnt < num_returned; cnt++, rate++) {
-			*rate = RATE_TO_U64(rlist->rate[cnt]);
-			dev_dbg(ph->dev, "Rate %llu Hz\n", *rate);
-		}
+		*rate = RATE_TO_U64(r->rate[st->loop_idx]);
+		p->clk->list.num_rates++;
+		//XXX dev_dbg(ph->dev, "Rate %llu Hz\n", *rate);
+	}
+
+	return ret;
+}
 
-		tot_rate_cnt += num_returned;
+static int
+scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
+			      struct scmi_clock_info *clk)
+{
+	int ret;
 
-		ph->xops->reset_rx_to_maxsz(ph, t);
-		/*
-		 * check for both returned and remaining to avoid infinite
-		 * loop due to buggy firmware
-		 */
-	} while (num_returned && num_remaining);
+	void *iter;
+	struct scmi_msg_clock_describe_rates *msg;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_clk_describe_prepare_message,
+		.update_state = iter_clk_describe_update_state,
+		.process_response = iter_clk_describe_process_response,
+	};
+	struct scmi_clk_ipriv cpriv = {
+		.clk_id = clk_id,
+		.clk = clk,
+	};
+
+	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_RATES,
+					    CLOCK_DESCRIBE_RATES,
+					    sizeof(*msg), &cpriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	ret = ph->hops->iter_response_run(iter);
+	if (ret)
+		return ret;
 
-	if (rate_discrete && rate) {
-		clk->list.num_rates = tot_rate_cnt;
-		sort(clk->list.rates, tot_rate_cnt, sizeof(*rate),
-		     rate_cmp_func, NULL);
+	if (!clk->rate_discrete) {
+		dev_dbg(ph->dev, "Min %llu Max %llu Step %llu Hz\n",
+			clk->range.min_rate, clk->range.max_rate,
+			clk->range.step_size);
+	} else if (clk->list.num_rates) {
+		sort(clk->list.rates, clk->list.num_rates,
+		     sizeof(clk->list.rates[0]), rate_cmp_func, NULL);
 	}
 
-	clk->rate_discrete = rate_discrete;
-
-err:
-	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-- 
2.32.0

