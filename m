Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3754E84D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiFPREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiFPREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:04:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AD1B18372
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:04:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD3511FB;
        Thu, 16 Jun 2022 10:04:02 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B76BC3F73B;
        Thu, 16 Jun 2022 10:04:01 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, robin.murphy@arm.com,
        nicola.mazzucato@arm.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Relax CLOCK_DESCRIBE_RATES out-of-spec checks
Date:   Thu, 16 Jun 2022 18:03:47 +0100
Message-Id: <20220616170347.2800771-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
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

A reply to CLOCK_DESCRIBE_RATES issued against a non rate-discrete clock
should be composed of a triplet of rates descriptors (min/max/step)
returned all in one reply message.

This is not always the case when dealing with some SCMI server deployed in
the wild: relax such constraint while maintaining memory safety by checking
carefully the returned payload size.

While at that cleanup a stale debug printout.

Fixes: 7bc7caafe6b1 ("firmware: arm_scmi: Use common iterators in the clock protocol")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c     | 26 +++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/driver.c    |  1 +
 drivers/firmware/arm_scmi/protocols.h |  3 +++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index c7a83f6e38e5..3ed7ae0d6781 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -194,6 +194,7 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
 }
 
 struct scmi_clk_ipriv {
+	struct device *dev;
 	u32 clk_id;
 	struct scmi_clock_info *clk;
 };
@@ -223,6 +224,29 @@ iter_clk_describe_update_state(struct scmi_iterator_state *st,
 	st->num_returned = NUM_RETURNED(flags);
 	p->clk->rate_discrete = RATE_DISCRETE(flags);
 
+	/* Warn about out of spec replies ... */
+	if (!p->clk->rate_discrete &&
+	    (st->num_returned != 3 || st->num_remaining != 0)) {
+		dev_warn(p->dev,
+			 "Out-of-spec CLOCK_DESCRIBE_RATES reply for %s - returned:%d remaining:%d rx_len:%zd\n",
+			 p->clk->name, st->num_returned, st->num_remaining,
+			 st->rx_len);
+
+		/*
+		 * A known quirk: a triplet is returned but num_returned != 3
+		 * Check for a safe payload size and fix.
+		 */
+		if (st->num_returned != 3 && st->num_remaining == 0 &&
+		    st->rx_len == sizeof(*r) + sizeof(__le32) * 2 * 3) {
+			st->num_returned = 3;
+			st->num_remaining = 0;
+		} else {
+			dev_err(p->dev,
+				"Cannot fix out-of-spec reply !\n");
+			return -EPROTO;
+		}
+	}
+
 	return 0;
 }
 
@@ -255,7 +279,6 @@ iter_clk_describe_process_response(const struct scmi_protocol_handle *ph,
 
 		*rate = RATE_TO_U64(r->rate[st->loop_idx]);
 		p->clk->list.num_rates++;
-		//XXX dev_dbg(ph->dev, "Rate %llu Hz\n", *rate);
 	}
 
 	return ret;
@@ -275,6 +298,7 @@ scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 	struct scmi_clk_ipriv cpriv = {
 		.clk_id = clk_id,
 		.clk = clk,
+		.dev = ph->dev,
 	};
 
 	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_RATES,
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c1922bd650ae..8b7ac6663d57 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1223,6 +1223,7 @@ static int scmi_iterator_run(void *iter)
 		if (ret)
 			break;
 
+		st->rx_len = i->t->rx.len;
 		ret = iops->update_state(st, i->resp, i->priv);
 		if (ret)
 			break;
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index c679f3fb8718..51c31379f9b3 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -179,6 +179,8 @@ struct scmi_protocol_handle {
  * @max_resources: Maximum acceptable number of items, configured by the caller
  *		   depending on the underlying resources that it is querying.
  * @loop_idx: The iterator loop index in the current multi-part reply.
+ * @rx_len: Size in bytes of the currenly processed message; it can be used by
+ *	    the user of the iterator to verify a reply size.
  * @priv: Optional pointer to some additional state-related private data setup
  *	  by the caller during the iterations.
  */
@@ -188,6 +190,7 @@ struct scmi_iterator_state {
 	unsigned int num_remaining;
 	unsigned int max_resources;
 	unsigned int loop_idx;
+	size_t rx_len;
 	void *priv;
 };
 
-- 
2.32.0

