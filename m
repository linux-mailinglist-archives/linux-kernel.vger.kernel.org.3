Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF4542ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiFHLK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiFHLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9721E303D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 491F2615BF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6796C3411D;
        Wed,  8 Jun 2022 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686496;
        bh=bPnqyf9AZKQ61p03l1ZhTBaGGia2Im8xpRcxv1K85hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZJBe4BPctuMS3xI7WkpvRptbond4MxlN5ysPKMwP9R9W9kRHAotuWVmUvzRnzJRq
         SC/xUS3w+jQOXbJnC5+BC+hWgHmcJPc8QxIy6CFFk5PH9udZLOiJWVbcjzkBqN7JkN
         YgV6C6ggBYYrWIqTb6ursL+OjgrxANfIf6ZVLxwcW5VDLI0ODtJFzZGCjshavQykXX
         r6cSE4TlMIvziJ0siULm83x9kM1tyDBFOIgIPYJPBK6k+Cez3lsrLqyp2drdbx8WJy
         hpCzS3JJVnCN/znzeU3LhfXjJMzYKxInZ5uFpSvoo3VbNtZV+uVVKp5gxGsf34SkHI
         rgPHrV/G4kllw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/23] platform/chrome: cros_ec_proto: handle empty payload in getting wake mask
Date:   Wed,  8 Jun 2022 11:07:34 +0000
Message-Id: <20220608110734.2928245-24-tzungbi@kernel.org>
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

cros_ec_get_host_event_wake_mask() expects to receive
sizeof(struct ec_response_host_event_mask) from send_command().  The
payload is valid only if the return value is positive.

Return -EPROTO if send_command() returns 0 in
cros_ec_get_host_event_wake_mask().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No v2.  New and separated from the original series.

 drivers/platform/chrome/cros_ec_proto.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 68a411e84744..5cbaaba26ff7 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -256,19 +256,23 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
 	msg->insize = sizeof(*r);
 
 	ret = send_command(ec_dev, msg);
-	if (ret >= 0) {
-		mapped = cros_ec_map_error(msg->result);
-		if (mapped) {
-			ret = mapped;
-			goto exit;
-		}
+	if (ret < 0)
+		goto exit;
+
+	mapped = cros_ec_map_error(msg->result);
+	if (mapped) {
+		ret = mapped;
+		goto exit;
 	}
-	if (ret > 0) {
-		r = (struct ec_response_host_event_mask *)msg->data;
-		*mask = r->mask;
-		ret = 0;
+
+	if (ret == 0) {
+		ret = -EPROTO;
+		goto exit;
 	}
 
+	r = (struct ec_response_host_event_mask *)msg->data;
+	*mask = r->mask;
+	ret = 0;
 exit:
 	kfree(msg);
 	return ret;
-- 
2.36.1.255.ge46751e96f-goog

