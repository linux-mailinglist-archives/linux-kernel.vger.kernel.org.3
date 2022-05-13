Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FF525AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377044AbiEMEmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377009AbiEMEmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBABA30A3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D21361924
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07896C34118;
        Fri, 13 May 2022 04:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652416918;
        bh=k9vGXmtsSs9khxIspmJ56bJIMiqhhowKnt4sI6Qo+yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6bf+w5Ut4EZUXKjvtsfHaksGcI9H+7+LEISgkD+gHK/tnTgSlLtJgTc4aZqmuCNd
         U1tyrU+ODgK6ikyyATYYJe97GyfmliRjHpETtsIHKVZwyQhxJkqC2bL5AJ0icNPMJ1
         1JAANlBp9rBr5pHbfckU9WrBLG2gP5CMImat+yfpGymGDkw+OY1UDmemIobQPY/30x
         rPn2DusB+HIu/yXVPmVHxVz2DXNm1G+oXJ4P9k+1ARdGxYYk3TtzaW2QGTjcgJ8m6e
         9x9+ljrtz7znJC7SUqHq/viXgO8xW+1xab6dsW/vEwFbZKO1ZMabgIpxi09+D6CnrA
         qJ3VcYkmp/jqg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_get_host_event()
Date:   Fri, 13 May 2022 12:41:40 +0800
Message-Id: <20220513044143.1045728-5-tzungbi@kernel.org>
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

It is overkill to crash the kernel if the `ec_dev` doesn't support MKBP
event but gets called into cros_ec_get_host_event().

Drop the BUG_ON() and return error (0 in the case) instead.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 9ce3374846ff..ff767dccdf0f 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -817,7 +817,8 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 {
 	u32 host_event;
 
-	BUG_ON(!ec_dev->mkbp_event_supported);
+	if (!ec_dev->mkbp_event_supported)
+		return 0;
 
 	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
 		return 0;
-- 
2.36.0.550.gb090851708-goog

