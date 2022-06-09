Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43B544685
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbiFIIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbiFIIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02AB2AC6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9475BB82C89
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3B4C34114;
        Thu,  9 Jun 2022 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764631;
        bh=FuHJEPkhi9pGFBwQJd3k04GT6ckgjnbCG+2grfpJ114=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbuYdlNerWOumMXOC1zCmNGxek/p3TJnSFiPkUI62Rd+0DmwCMe14hL24diMslSzm
         ojMqWz4lo3D7A1OjLN8vnoWKRx2bZ5lLEl8jCFXsIoMVivNMkUsJWWT5BVTSbi2V+x
         pc2Y2KSFvr0IG+1PBBCnqfvqSPTIwT69m3Vp3Te4zfm4ASpQgtQeFkA0r+c4Jqn24b
         XU3wzqGSuHR9ZRKkF4uzuV/qPpz12BTzqsrWJjl1r7HTacISD1nzOY+lCiXErFfD/c
         W7aG4Jc6ZueunKXqp9GpxzD4PZ8kwpkbfEvHz+m9yPJ1PFFsY0Di0qRXjyVXqWXrXm
         t1DWEHINSmWlA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/21] platform/chrome: cros_ec_proto: return 0 on getting cmd mask success
Date:   Thu,  9 Jun 2022 08:49:50 +0000
Message-Id: <20220609084957.3684698-15-tzungbi@kernel.org>
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

cros_ec_get_host_command_version_mask() used to return value from
send_command() which is number of available bytes for input payload on
success (i.e. sizeof(struct ec_response_get_cmd_versions)).

However, the callers don't need to know how many bytes are available.

Don't return number of available bytes.  Instead, return 0 on success;
otherwise, negative integers on error.

Also remove the unneeded `ver_mask` initialization as the callers should
take it only if cros_ec_get_host_command_version_mask() returns 0.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v3:
- Add R-b tag.

Changes from v2:
- Separate Kunit test to another patch.
- Rephrase the commit message.

Changes from v1:
- Return 0 on success; otherwise, negative intergers.

 drivers/platform/chrome/cros_ec_proto.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index e6e9b5b59e58..20a1f8f7e70d 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -453,6 +453,7 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 	if (ret > 0) {
 		rver = (struct ec_response_get_cmd_versions *)msg->data;
 		*mask = rver->version_mask;
+		ret = 0;
 	}
 
 	kfree(msg);
@@ -470,7 +471,7 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 int cros_ec_query_all(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
-	u32 ver_mask = 0;
+	u32 ver_mask;
 	int ret;
 
 	/* First try sending with proto v3. */
@@ -509,9 +510,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	}
 
 	/* Probe if MKBP event is supported */
-	ret = cros_ec_get_host_command_version_mask(ec_dev,
-						    EC_CMD_GET_NEXT_EVENT,
-						    &ver_mask);
+	ret = cros_ec_get_host_command_version_mask(ec_dev, EC_CMD_GET_NEXT_EVENT, &ver_mask);
 	if (ret < 0 || ver_mask == 0) {
 		ec_dev->mkbp_event_supported = 0;
 	} else {
@@ -521,10 +520,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	}
 
 	/* Probe if host sleep v1 is supported for S0ix failure detection. */
-	ret = cros_ec_get_host_command_version_mask(ec_dev,
-						    EC_CMD_HOST_SLEEP_EVENT,
-						    &ver_mask);
-	ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
+	ret = cros_ec_get_host_command_version_mask(ec_dev, EC_CMD_HOST_SLEEP_EVENT, &ver_mask);
+	ec_dev->host_sleep_v1 = (ret == 0 && (ver_mask & EC_VER_MASK(1)));
 
 	/* Get host event wake mask. */
 	ret = cros_ec_get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
-- 
2.36.1.255.ge46751e96f-goog

