Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1789E542EDB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiFHLKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiFHLIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD220E17E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 630A2B826EF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507ECC385A5;
        Wed,  8 Jun 2022 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686494;
        bh=91zlbVfzDWVDmRvUs0dc1MJ+g1g9qLWtwftW+Qb5tW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPA1hWySenJFqGrj6+7lWMa1aVxuHbzoJezLDmnSv6E+wREpQPPgEprjMAKgU+cpQ
         kAaAeLVjV/XnRNjpx3EEut5ljzzBg9gCXzUJ9dmww+SGtxG+xVLm0+1UtGxWatRL6k
         WKaq4nXzswFw0srodkw+ru72We9yA+G5XZNJYe7lbw04eVbkWzk1y/OvPdlL213w8Z
         fRa8a+kqV8Qu0C/WCpAgKHCXOQZ73j9i4M2lxM+Ll/x2zd5AqSxF/OQtBLe5O+s5u9
         2kpEYtsSObBTi3xc+sH5DAl5OsE+Oxiqo5tRg5o/yqA90j5C/9kswBLRzHxPiYiYdp
         hYQ3d+PSnPHEg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/23] platform/chrome: cros_ec_proto: return 0 on getting wake mask success
Date:   Wed,  8 Jun 2022 11:07:32 +0000
Message-Id: <20220608110734.2928245-22-tzungbi@kernel.org>
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

cros_ec_get_host_event_wake_mask() used to return value from
send_command() which is number of bytes for input payload on success
(i.e. sizeof(struct ec_response_host_event_mask)).

However, the callers don't need to know how many bytes are available.

Don't return number of available bytes.  Instead, return 0 on success;
otherwise, negative integers on error.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v2:
- Separate Kunit test to another patch.

Changes from v1:
- Return 0 on success; otherwise, negative intergers.

 drivers/platform/chrome/cros_ec_proto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 9e95f9e4b2f8..68a411e84744 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -236,7 +236,7 @@ EXPORT_SYMBOL(cros_ec_check_result);
  *
  * @ec_dev: EC device to call
  * @msg: message structure to use
- * @mask: result when function returns >=0.
+ * @mask: result when function returns 0.
  *
  * LOCKING:
  * the caller has ec_dev->lock mutex, or the caller knows there is
@@ -266,6 +266,7 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
 	if (ret > 0) {
 		r = (struct ec_response_host_event_mask *)msg->data;
 		*mask = r->mask;
+		ret = 0;
 	}
 
 exit:
-- 
2.36.1.255.ge46751e96f-goog

