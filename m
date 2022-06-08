Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF255542ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiFHLKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbiFHLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172CC150B6D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA6DB826EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D46C385A2;
        Wed,  8 Jun 2022 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686490;
        bh=G25cS5bKvqVIH1PCkuL/Lx3jXmwJIqxuGBbJk1fnY50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+1iDtV86K0FJMxqMn90RCpnzbCCPnuD4vXSWgx2N9yDVtDLhf5DP9tGX1s/LxTmm
         FZ0V5GKJOPDIPQEADP2cmfjxAFUedsgyOC9p1kfAaypVUoWcC2gwXHv7ADv6cU/vFI
         Vx4X76vdYeYNHl5PMAJgA/dbPR3NWXFJUeDkHX7FnjxycozMtzMGgUJo3PGWyd4/9K
         hqveyn7CyALLyaMUon4iD+UxD8rSzbqAUrRtx0Qy28+ASB/59WVm7LACyNRnqtqbW6
         xaQUQegSZ694WYmDUcsekUrms0orvK1CQkftx0a4Xa1WfNmD3KJx+W6/pcrSS1RNOw
         0WgSPKmut5ZaQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/23] platform/chrome: cros_ec_proto: check `msg->result` in getting cmd mask
Date:   Wed,  8 Jun 2022 11:07:29 +0000
Message-Id: <20220608110734.2928245-19-tzungbi@kernel.org>
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

cros_ec_get_host_command_version_mask() should check if EC wasn't happy
by checking `msg->result`.

Use cros_ec_map_error() and return the error code if any.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No v2.  New and separated from the original series.

 drivers/platform/chrome/cros_ec_proto.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 06bc7db1213e..6a5771361383 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -428,13 +428,12 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
  * the caller has ec_dev->lock mutex or the caller knows there is
  * no other command in progress.
  */
-static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
-	u16 cmd, u32 *mask)
+static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev, u16 cmd, u32 *mask)
 {
 	struct ec_params_get_cmd_versions *pver;
 	struct ec_response_get_cmd_versions *rver;
 	struct cros_ec_command *msg;
-	int ret;
+	int ret, mapped;
 
 	msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)),
 		      GFP_KERNEL);
@@ -450,14 +449,20 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 	pver->cmd = cmd;
 
 	ret = send_command(ec_dev, msg);
-	if (ret > 0) {
-		rver = (struct ec_response_get_cmd_versions *)msg->data;
-		*mask = rver->version_mask;
-		ret = 0;
+	if (ret < 0)
+		goto exit;
+
+	mapped = cros_ec_map_error(msg->result);
+	if (mapped) {
+		ret = mapped;
+		goto exit;
 	}
 
+	rver = (struct ec_response_get_cmd_versions *)msg->data;
+	*mask = rver->version_mask;
+	ret = 0;
+exit:
 	kfree(msg);
-
 	return ret;
 }
 
-- 
2.36.1.255.ge46751e96f-goog

