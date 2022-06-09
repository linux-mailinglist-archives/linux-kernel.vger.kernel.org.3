Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC0544681
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiFIIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242504AbiFIIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1061E152D9F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC851619C5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5AC34114;
        Thu,  9 Jun 2022 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764620;
        bh=AVQPAlvoed25CjITUiMu/d9gzA0bFkUaJK7QzC+hnrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRoljWwoEO76w7GvrJugwFacv8tQgZt+u7WU9sUetCVyfBFSR1QUVZSIW0OtJ8D/0
         wFWLPi4KE1dTBYmOtaFaaDQK12R767npgj9eyFZibWuW23KD+A2SjpnXk/FL0uiemr
         TMqVxvjDyP4hvd6NseJKiWCY7DsQlKzYeAHqP7YMRt98mC7W+NaWTixkjo2suC9pJy
         9E4wl5w1yQt7q/J99CMYrVD9QOmRWNOTS1ucGpGUToYoutE9Sxe2YL65RW9rSda1rA
         2HTrigsuQf0fwOTTNG6yy1FwjSKCuUPWT4MNr9PtX/QQDZ+GXuMEO2QuUnI6CAlZ43
         DLPES+wWCffLA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/21] platform/chrome: cros_ec_proto: remove redundant NULL check
Date:   Thu,  9 Jun 2022 08:49:41 +0000
Message-Id: <20220609084957.3684698-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609084957.3684698-1-tzungbi@kernel.org>
References: <20220609084957.3684698-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

send_command() already checks if `ec_dev->pkt_xfer` is NULL.  Remove the
redundant check.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No change from v2 and v3.

Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 629dce3e6ab3..1b851dcd20c9 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -281,9 +281,6 @@ static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
 	 */
 	int ret;
 
-	if (!ec_dev->pkt_xfer)
-		return -EPROTONOSUPPORT;
-
 	memset(msg, 0, sizeof(*msg));
 	msg->command = EC_CMD_PASSTHRU_OFFSET(devidx) | EC_CMD_GET_PROTOCOL_INFO;
 	msg->insize = sizeof(struct ec_response_get_protocol_info);
-- 
2.36.1.255.ge46751e96f-goog

