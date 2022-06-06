Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3083253E7EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiFFOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiFFOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E62C286D3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D6F61381
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E6BC3411F;
        Mon,  6 Jun 2022 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524722;
        bh=sKbLOjcvTC3/wmYtXtfhTTJamRUWHaDSmI+uYF6/kc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iX82aC1GgIgH+mRpaBr9kO47GvUTJIvV+I0oYDV3ZK+pElUiY2AhudzCCvu3v+Lgo
         DU19u833X95M85CvHy5HuaRHqOtxPZDjMqfes9X8JkFq5S4Qh8Hascgg/oRa+H0Bpt
         zi2IOYgL+8gG5jKJ3+3yydTJK2UAu1m8e3LFg1Z5QhK/cHX3GJtEDL9u+2q1QAzIfH
         +QmAwwv1gYypmZ5Z/NKNCn8YQn5p0YRGRsgsC7yNT3AiZUHpScSAIEipcZdW24CAlR
         gN65Q0mTkDI/WO9vCW3QuTXNPNQRFbZaUDLLbchuUDnCSdWPC6M4qz/pVxi5+8SvAe
         M+t7bO9t3/jdQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] platform/chrome: cros_ec_proto: remove redundant NULL check
Date:   Mon,  6 Jun 2022 14:10:43 +0000
Message-Id: <20220606141051.285823-6-tzungbi@kernel.org>
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

send_command() already checks if `ec_dev->pkt_xfer` is NULL.  Remove the
redundant check.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 629dce3e6ab3..1b851dcd20c9 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -281,9 +281,6 @@ static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
 	 */
 	int ret;
 
-	if (!ec_dev->pkt_xfer)
-		return -EPROTONOSUPPORT;
-
 	memset(msg, 0, sizeof(*msg));
 	msg->command = EC_CMD_PASSTHRU_OFFSET(devidx) | EC_CMD_GET_PROTOCOL_INFO;
 	msg->insize = sizeof(struct ec_response_get_protocol_info);
-- 
2.36.1.255.ge46751e96f-goog

