Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927054C10E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbiFOFNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345236AbiFOFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DE27FD5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73AD061690
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E4FC3411F;
        Wed, 15 Jun 2022 05:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269994;
        bh=pMu/iPTPt+7snGnGf7n7Le6i011YyhLzHZlK+Kum9iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZO+PAazBmnEIlX9gNI2US1eLAX8sqXpT/ZmgnrbiUqf1/pyOYuMI6je9Do44OAJvl
         hGpQjFUkew4YHj1PLHCpjzfQ7/QM+hBJCqulx8xQZAkoMPgVK7d/eKizqyqZMFGAiN
         NvnPtg8lCpESXJM+Q7gXjmJ3WTAS35imI3vhlQOz/NuT1AaIZuiBgTaGB7wdjTylQf
         gF1J+RJ+DjMgDCHYMAAEf097ZkqHAD8oE2y0GV9Q4u+UE/8buMj814xlGYVu7CD3oo
         sAcL10+o8t1VxmZx3/6/5AoQ7Pq6J702HGi0Z1J7imfSZ80Rx0leQaw2Sfn15XfcIl
         iMLhWcdV//tIA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] platform/chrome: cros_ec_proto: return standard error codes for EC errors
Date:   Wed, 15 Jun 2022 05:12:46 +0000
Message-Id: <20220615051248.1628156-10-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615051248.1628156-1-tzungbi@kernel.org>
References: <20220615051248.1628156-1-tzungbi@kernel.org>
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

cros_ec_wait_until_complete() checks `msg->result` for
EC_CMD_GET_COMMS_STATUS.  However, it doesn't return standard error codes
like most of others.

Use cros_ec_map_error() to align them.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 49772a4c5353..5323edddb540 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -138,7 +138,7 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
 {
 	struct cros_ec_command *msg;
 	struct ec_response_get_comms_status *status;
-	int ret = 0, i;
+	int ret = 0, i, mapped;
 
 	msg = kzalloc(sizeof(*msg) + sizeof(*status), GFP_KERNEL);
 	if (!msg)
@@ -160,8 +160,11 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
 			break;
 
 		*result = msg->result;
-		if (msg->result != EC_RES_SUCCESS)
+		mapped = cros_ec_map_error(msg->result);
+		if (mapped) {
+			ret = mapped;
 			break;
+		}
 
 		if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
 			break;
-- 
2.36.1.476.g0c4daa206d-goog

