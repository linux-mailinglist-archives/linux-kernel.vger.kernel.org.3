Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A29542ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiFHLJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbiFHLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EA31B31B6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6B37B826EF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B859BC341C0;
        Wed,  8 Jun 2022 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686475;
        bh=wi1SDuwZmlg1s/vDvlK9MyTNq3HXQKP7FJaBG0WKmaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WnMOHBBeCjA3IgYldtXTPstCOEH/h0mUiwxTGvZTqa6r1dH9crdnkp5dxM8z1eyQQ
         bIP7+nkFjTHv/KE4VJuP/wVnS3NQ53mLV1cMlGkAKEchVkwdb797FfVzH7w1qcLuO5
         7Fmr45s1T6Q8kzVWMh1Bz0GqPJnZ8qVLYPfkpnyyTtgnrIeVkv/pzKCQsEzPBXm6SK
         mafZ6DXV+xGD2njDQXafynfNU5x9jLeJ8xupRk/B7aEwa2H4f1HFGyJ8KzOejkvcrf
         cNgLkfeq+/PzY71ON07CWbhhWq4hFrsOE5CLv94eWUIMC/TuBPAwD0gn420AgpvzQY
         2NlOtdiueFQYw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/23] platform/chrome: cros_ec_proto: use cros_ec_map_error()
Date:   Wed,  8 Jun 2022 11:07:17 +0000
Message-Id: <20220608110734.2928245-7-tzungbi@kernel.org>
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

Use cros_ec_map_error() in cros_ec_get_host_event_wake_mask().

The behavior of cros_ec_get_host_event_wake_mask() slightly changed.  It
is acceptable because the caller only needs it returns negative integers
for indicating errors.  Especially, the EC_RES_INVALID_COMMAND still
maps to -EOPNOTSUPP.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No change from v2.

Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 1b851dcd20c9..71ba6a56ad7c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -247,7 +247,7 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
 					    uint32_t *mask)
 {
 	struct ec_response_host_event_mask *r;
-	int ret;
+	int ret, mapped;
 
 	msg->command = EC_CMD_HOST_EVENT_GET_WAKE_MASK;
 	msg->version = 0;
@@ -256,10 +256,9 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
 
 	ret = send_command(ec_dev, msg);
 	if (ret >= 0) {
-		if (msg->result == EC_RES_INVALID_COMMAND)
-			return -EOPNOTSUPP;
-		if (msg->result != EC_RES_SUCCESS)
-			return -EPROTO;
+		mapped = cros_ec_map_error(msg->result);
+		if (mapped)
+			return mapped;
 	}
 	if (ret > 0) {
 		r = (struct ec_response_host_event_mask *)msg->data;
-- 
2.36.1.255.ge46751e96f-goog

