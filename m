Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A07A525ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377027AbiEMEmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377001AbiEMEl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8A9C2F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3210C6193E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94919C34116;
        Fri, 13 May 2022 04:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652416916;
        bh=DUjbqOiPwSotTkZmud2YzJPM3OuvMaOA+B4B15eN5pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdyoEmQj+SYNv2mOLGGst/beMLUNkickm8rJrk9M16dps/yhPSR9O7yXrXk3BzIb1
         LZ+1/L/1/vMyMWOfmn/78fioIUovUkHnyVI/vNWeEeBnYrdOy96fazazodXZzocDdv
         XgKKUxoAMQo+MIgArsi3XGLUfGNLmOzzvCr+RWYrVAsNq/SKDaKdz3nHnaZP7pR/ki
         akLIPFN2owWcsX4NQB1z+8+OPnW7Ce43re0yNagbMmgFzQ8UBP0GiF5DhvDOW3phpH
         arfGSDd87A0G3lPhLNyZFC3daprfGg41B1mZDWwH380ysNjEjRyUsmc7J0zdFQ++Zt
         Te9iV+fETR/tw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_prepare_tx()
Date:   Fri, 13 May 2022 12:41:39 +0800
Message-Id: <20220513044143.1045728-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220513044143.1045728-1-tzungbi@kernel.org>
References: <20220513044143.1045728-1-tzungbi@kernel.org>
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

It is overkill to crash the kernel if the given message is oversize.

Drop the BUG_ON() and return -EINVAL instead.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 2d6d3fbfa905..9ce3374846ff 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -60,7 +60,8 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
 	int i;
 	u8 csum = 0;
 
-	BUG_ON(msg->outsize + sizeof(*request) > ec_dev->dout_size);
+	if (msg->outsize + sizeof(*request) > ec_dev->dout_size)
+		return -EINVAL;
 
 	out = ec_dev->dout;
 	request = (struct ec_host_request *)out;
@@ -176,7 +177,9 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 	if (ec_dev->proto_version > 2)
 		return prepare_packet(ec_dev, msg);
 
-	BUG_ON(msg->outsize > EC_PROTO2_MAX_PARAM_SIZE);
+	if (msg->outsize > EC_PROTO2_MAX_PARAM_SIZE)
+		return -EINVAL;
+
 	out = ec_dev->dout;
 	out[0] = EC_CMD_VERSION0 + msg->version;
 	out[1] = msg->command;
-- 
2.36.0.550.gb090851708-goog

