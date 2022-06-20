Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2177551C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbiFTNO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344163AbiFTNKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:10:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD801C904
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0554615A9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42549C3411C;
        Mon, 20 Jun 2022 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730283;
        bh=16nBY2m/Aj2zdFDS3tCaYV6N0rsguEXFeJBhHKTJaIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0V8JlbTx5xzjqrt1IQiNRu3vNZ2n/7cafJEdTMfbgQWbvFzUVJAFMJmL0RPYwQsO
         2Xj8vhwSAxz+ZDAfSJdNo5maUAfrKludCeMkL7SVwQ1lMjTmSD3VVDEeZNnigTm1HE
         zfJmIfFPD4hQXpsDueqxyHwzH8ZcKOlAtbtiOZoLYrphnRLaIvpC3yz5bwtjcFj5Pl
         UeBTkxEpjI/DYK82YDbHwLQirxU6Qji1RMrnYbz1a4EwpUwxAMavUBT+xqs7oJZBGt
         adqpwgdi8fqEJj+9rZkQAiqoLdVEDzs1UT6dmrRsxdbiW7xXS+8ScOJ8QGIum4v5UV
         cSIpCypUIyQhg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 04/17] habanalabs/gaudi: send device reset notification
Date:   Mon, 20 Jun 2022 16:04:19 +0300
Message-Id: <20220620130432.1180451-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Cohen <talcohen@habana.ai>

Device reset event, indicates that the device shall be reset -
after a short delay. In such case, the driver sends a notification
towards the User process. This allows the User process
to be able to take several debug actions for system
diagnostic purposes.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8f37297b2c3b..b7460c30aa51 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8054,13 +8054,20 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 reset_device:
 	reset_required = true;
 
-	if (hdev->asic_prop.fw_security_enabled && !reset_direct)
+	if (hdev->asic_prop.fw_security_enabled && !reset_direct) {
 		flags = HL_DRV_RESET_HARD | HL_DRV_RESET_BYPASS_REQ_TO_FW | fw_fatal_err_flag;
-	else if (hdev->hard_reset_on_fw_events)
+		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
+	} else if (hdev->hard_reset_on_fw_events) {
 		flags = HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY | fw_fatal_err_flag;
-	else
+		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
+	} else {
 		reset_required = false;
+	}
 
+	/* despite reset doesn't execute. a notification on
+	 * occurred event needs to be sent here
+	 */
+	hl_notifier_event_send_all(hdev, event_mask);
 	if (reset_required)
 		hl_device_reset(hdev, flags);
 	else
-- 
2.25.1

