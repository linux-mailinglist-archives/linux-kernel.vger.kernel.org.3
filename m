Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC4455CBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiF1CuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbiF1Ctr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB1DCE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E76B81C0E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BE4C34115;
        Tue, 28 Jun 2022 02:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656384583;
        bh=CRx51XgSdj0MtbthQC0H1WA4XmHqBiDh8m06ANT9P8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvUvL9Leqn1cWbcbHO3EZhyVEImtkdWx2xILnPVbJqLg58/LjDbg7JIJkJ+uT7tPP
         qVicWOB/Oyglsx87ewW5ZTNQuLb/zsHop17LzYJbQXTqbnObcw70qibDAo90vfJLag
         vdypsC90/0rIIiO06vkJ9rC6itP1yA13Qt8ICjxkrjN2A78F4IgsRe3jH2pMu98w7M
         CXqKAZ/tSirPhmGw3tYELEITKT04Po9SPtVTchadjCz72sK/uMA+ZOJX3fhlxaX3NT
         btG+v3iTMkDCUAgXvu6u6n5t5MbKcNS7gDA6miTPcHppVXqwwetCzht38MFNleFNcq
         8h42T9YnYvOkA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 09/11] platform/chrome: cros_ec_proto: return standard error codes for EC errors
Date:   Tue, 28 Jun 2022 02:49:11 +0000
Message-Id: <20220628024913.1755292-10-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220628024913.1755292-1-tzungbi@kernel.org>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.0.rc0.161.g10f37bed90-goog

