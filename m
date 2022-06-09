Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BF54469E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiFIIvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiFIIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441123BDC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6708E619BD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED794C341C0;
        Thu,  9 Jun 2022 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764628;
        bh=PPW9kWyUtvh6O+9p8p4bHoodFe3Jhm8gBrr0zshmtH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nD1WawmXL8edgmvR2XUYkuIuVV3SCFIIHq7/RPjcuWyBsYdL7lDDv4LExceL6o68V
         50Z40LjhhwHVe5bBpP/OuAAU0m8bThKK/6Ghs/ZY4svsKqgaWjwC6jdVY4Lv1HqtyX
         VTyo/IvkdPoddYATq1SAlV7THSLCPpifSb9BbidP0MECLQuDxcxI+255j2HS/YCu9M
         3V7ou3Pz0KhlMnR/ZaXm3GjLTSfjxbuUTW+xRhGqgVUIvaqLMi0eQIl9Y8W9G45jXw
         mvrHgJ5oBFjSo/zlezI/wiLYgYAedTaNO66PZvX9vYqitJ/MY/uy0WwP/FSstPhSmF
         qX3d8v2xAWnMw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/21] platform/chrome: cros_ec_proto: handle empty payload in getting info legacy
Date:   Thu,  9 Jun 2022 08:49:48 +0000
Message-Id: <20220609084957.3684698-13-tzungbi@kernel.org>
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

cros_ec_get_proto_info_legacy() expects to receive
sizeof(struct ec_response_hello) from send_command().  The payload is
valid only if the return value is positive.

Return -EPROTO if send_command() returns 0 in
cros_ec_get_proto_info_legacy().

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v3:
- Add R-b tag.

Changes from v2:
- Separate Kunit test to another patch.

 drivers/platform/chrome/cros_ec_proto.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 04b9704ed302..473654f50bca 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -356,7 +356,7 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
 	struct cros_ec_command *msg;
 	struct ec_params_hello *params;
 	struct ec_response_hello *response;
-	int ret;
+	int ret, mapped;
 
 	ec_dev->proto_version = 2;
 
@@ -377,12 +377,18 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
 		goto exit;
 	}
 
-	ret = cros_ec_map_error(msg->result);
-	if (ret) {
+	mapped = cros_ec_map_error(msg->result);
+	if (mapped) {
+		ret = mapped;
 		dev_err(ec_dev->dev, "EC responded to v2 hello with error: %d\n", msg->result);
 		goto exit;
 	}
 
+	if (ret == 0) {
+		ret = -EPROTO;
+		goto exit;
+	}
+
 	response = (struct ec_response_hello *)msg->data;
 	if (response->out_data != 0xa1b2c3d4) {
 		dev_err(ec_dev->dev,
-- 
2.36.1.255.ge46751e96f-goog

