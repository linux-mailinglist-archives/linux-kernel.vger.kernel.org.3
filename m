Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6693A546800
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiFJOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349401AbiFJOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:01:46 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757A2B72CB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654869704;
  x=1686405704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d28BFi0/VBb4bixwduhrFurpMjara8WE4vvBx38KIlM=;
  b=AdpReraq0AkSip49aWoRClfjN7eVD7yOg5a0Hs45GnA0QlTdmFoMtmpZ
   QQXgUuFgSoWtlV7dtc7HRkESCGamdr4nd0sAl+rvLtfh04vYR1c0u41LW
   yk1j81ly7OYyFENBoeOZiC2F3mrqujITE9nAwaYF69hcsHGSECLvSLmXg
   mKMmPgx84uuNBCttj4dg339C94id9YMf2Oo4Mky8VVYiQJmoulN7GqyCh
   lwy7sKQtMm7pmmbGkK/N7sa6V6kT9x50P4BBABQPrc3CrDmppi4pBc9EM
   dkgxi36MLdrrlhrVEkh7ZiSK20aDPlYrkdKdjAs/eYKoTRpJuCcQqmH4D
   w==;
From:   =?UTF-8?q?Ludvig=20P=C3=A4rsson?= <ludvig.parsson@axis.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <kernel@axis.com>,
        =?UTF-8?q?Ludvig=20P=C3=A4rsson?= <ludvig.parsson@axis.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: arm_scmi: Fix incorrect error propagation
Date:   Fri, 10 Jun 2022 16:00:55 +0200
Message-ID: <20220610140055.31491-1-ludvig.parsson@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scmi_voltage_descriptors_get() will incorrecly return an
error code if the last iteration of the for loop that
retrieves the descriptors is skipped due to an error.
Skipping an iteration in the loop is not an error, but
the `ret` value from the last iteration will be
propagated when the function returns.

Fix by not saving return values that should not be
propagated. This solution also minimizes the risk of
future patches accidentally reintroducing this bug.

Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
---
 drivers/firmware/arm_scmi/voltage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 9d195d8719ab..49b75375d3ff 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -225,9 +225,8 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 
 		/* Retrieve domain attributes at first ... */
 		put_unaligned_le32(dom, td->tx.buf);
-		ret = ph->xops->do_xfer(ph, td);
 		/* Skip domain on comms error */
-		if (ret)
+		if (ph->xops->do_xfer(ph, td))
 			continue;
 
 		v = vinfo->domains + dom;
@@ -249,9 +248,8 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 				v->async_level_set = true;
 		}
 
-		ret = scmi_voltage_levels_get(ph, v);
 		/* Skip invalid voltage descriptors */
-		if (ret)
+		if (scmi_voltage_levels_get(ph, v))
 			continue;
 
 		ph->xops->reset_rx_to_maxsz(ph, td);
-- 
2.20.1

