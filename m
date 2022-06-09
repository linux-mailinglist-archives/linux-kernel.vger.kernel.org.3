Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD85544686
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242655AbiFIIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbiFIIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD043389
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9723619C2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45397C34114;
        Thu,  9 Jun 2022 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764625;
        bh=qT9HHzpCPbOfweuAb1jcncAnFhfIOxUfMjm69+qjQJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsXLve99cAnKjrIYtBPJlQudQ27+xYonnmjQOSkXVUdmP1mt482HaDpX4yP8jMoKF
         ksgfzy08QO6/sNG4TbY3x71zoiiC/pCK/+lpb2U298ATydLrTh9sObQK3PlEek4s95
         dLMwyAyYgHMFQ2j8jD4CqijGRcGIEoAl3R3H6ZKeew59ddfOHGYxigQSC/4dmPywaM
         megsi5B8t0/r5bP6/7MrSWGrVwMHHOHVgzfSUldqrK5p1nLqulZqL72KObmrz0lWre
         o6TdqdWNzcKys5Iv7EBSDw3ixVZWw9sUNzZqiqJW/CVn2+lqyqWAOa+u2y9pWc3YMr
         HK9P48ntgwcDw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/21] platform/chrome: cros_ec_proto: handle empty payload in getting proto info
Date:   Thu,  9 Jun 2022 08:49:45 +0000
Message-Id: <20220609084957.3684698-10-tzungbi@kernel.org>
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

cros_ec_get_proto_info() expects to receive
sizeof(struct ec_response_get_protocol_info) from send_command().  The
payload is valid only if the return value is positive.

Return -EPROTO if send_command() returns 0 in cros_ec_get_proto_info().

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v3:
- Add R-b tag.

Changes from v2:
- Separate Kunit test to another patch.

 drivers/platform/chrome/cros_ec_proto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 893b76703da6..6f5be9e5ede4 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -314,6 +314,11 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 		goto exit;
 	}
 
+	if (ret == 0) {
+		ret = -EPROTO;
+		goto exit;
+	}
+
 	info = (struct ec_response_get_protocol_info *)msg->data;
 
 	switch (devidx) {
-- 
2.36.1.255.ge46751e96f-goog

