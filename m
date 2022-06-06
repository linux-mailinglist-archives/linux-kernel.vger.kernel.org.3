Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B313C53E62B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiFFOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239624AbiFFOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919E2286E9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 282BF61376
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B6C3411D;
        Mon,  6 Jun 2022 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524723;
        bh=RnH0fzWxCPD22wn/jU3q2AjRqABY470RtTuq54kRfkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YU1ySO20vnU/I4kEoWJpb5Cgjv8Q6VZj0WOIy7HkSn+JMIompxbX0eALuqhpLAeaz
         QWrRzTCPMdXRI704uTPD9x3UoETZBWWICwOL6iOGtoerVdnWQNRMxLZRjMkWDumdCu
         GG/N7Po0i+7GQZGRhZQDzqnrztNr8BxzaH1lU2UGFsiPps1IFDtkZSvY5xPwFOds7V
         kIk0Ydno6EbX5Ur58u3z+I9reP4E7dnuLhI3I+xzJFHGL6AOViq3CmDvt1AtduULiC
         7xxLF7F931ZbtnXJLLETUrRXuu1khcJgSJhFT98AZzkAdtBm+fzAbszoY6X3KoNLRh
         FtysHshIe7m4w==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] platform/chrome: cros_ec_proto: use cros_ec_map_error()
Date:   Mon,  6 Jun 2022 14:10:44 +0000
Message-Id: <20220606141051.285823-7-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606141051.285823-1-tzungbi@kernel.org>
References: <20220606141051.285823-1-tzungbi@kernel.org>
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

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
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

