Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60512542ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiFHLJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbiFHLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA520C25C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 70240CE1D6F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC70C34116;
        Wed,  8 Jun 2022 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686486;
        bh=ih26mD8gWYA0ngbk8TzR3WX1e7dsZX0JE4dyVo2c0rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDOBevCgDTOEGjAuYjLjPYoJn20fwiamYzo7covq5q2idZLhzzmfhXSeCXMo7XvHW
         U/W33TUIuDdu0JaB4tlNjq/fs9yQzos7xLoB2zoZaqRPYfejUFy1HxWzy09NJEZdv6
         6n9pbWtpWqbpdEXtlMni6PeThUi7UMNSZm02BgJm1OWmHpJmHtfQWnkLSr9CxgT4sh
         k8OZVqZQthF8dpRLZXNN97PVVWf3nwrpUnQpmn+NNZZz/9UlNza9cfJ5Nq4UD0F14z
         5nmwr+YFC1WkjvTXQ6IMrVMAYuhOwyfJZrGCK8rnXwpVKWeBUq2waHB9ii+r171zoF
         1PFVsPZ7twH8g==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/23] platform/chrome: cros_ec_proto: don't show MKBP version if unsupported
Date:   Wed,  8 Jun 2022 11:07:26 +0000
Message-Id: <20220608110734.2928245-16-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608110734.2928245-1-tzungbi@kernel.org>
References: <20220608110734.2928245-1-tzungbi@kernel.org>
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

It wrongly showed the following message when it doesn't support MKBP:
"MKBP support version 4294967295".

Fix it.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v2:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 8a53e989c7e2..efbabdcb31ae 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -508,13 +508,13 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
 						    EC_CMD_GET_NEXT_EVENT,
 						    &ver_mask);
-	if (ret < 0 || ver_mask == 0)
+	if (ret < 0 || ver_mask == 0) {
 		ec_dev->mkbp_event_supported = 0;
-	else
+	} else {
 		ec_dev->mkbp_event_supported = fls(ver_mask);
 
-	dev_dbg(ec_dev->dev, "MKBP support version %u\n",
-		ec_dev->mkbp_event_supported - 1);
+		dev_dbg(ec_dev->dev, "MKBP support version %u\n", ec_dev->mkbp_event_supported - 1);
+	}
 
 	/* Probe if host sleep v1 is supported for S0ix failure detection. */
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
-- 
2.36.1.255.ge46751e96f-goog

