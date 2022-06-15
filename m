Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8854C10A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbiFOFN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiFOFNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74F25EB1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02FF8B81BF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3B3C341C8;
        Wed, 15 Jun 2022 05:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269988;
        bh=eh0wHoBVv18wEv+R8ggGvnitBSyOqK/G5EAzt9lOmDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yt6hKy+q5jlj//QHdEMotgEX4SCsX6VksZfcJLmvBrSCgEjbj1WPuLitNbK9+X6sC
         HYBF2o6ffImHUQ2HHDHjFOHSrscqV/kzcG4U0eLMZcQJOGaD8jTfGUX7KzhUygvD5I
         jFkfGtRWO8Gpu3tYP1cuiwEUaYcpsOAcfiCsk5GcmXBEajxrKNg/VGsz9K7ZS3ov8N
         1WW/4os/TJQbny/tyt6s9C0VANaH0P2QC/WEWDX5xujWxF2/62C+2CpBwHJ6AIqs8h
         7v+c5kYRWNMFlTFv2ED0reJHkgDyeSyTWm/6HGlL2riJjJ0Wgao2NgWWGXPLLmsBjn
         OkE4OrWNIRcJg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] platform/chrome: cros_ec_proto: separate cros_ec_xfer_command()
Date:   Wed, 15 Jun 2022 05:12:41 +0000
Message-Id: <20220615051248.1628156-5-tzungbi@kernel.org>
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

cros_ec_send_command() has extra logic to handle EC_RES_IN_PROGRESS.
Separate the command transfer part into cros_ec_xfer_command() so
that other functions can re-use it.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b02fd1414e52..0cec013be3d3 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -107,7 +107,7 @@ static int prepare_tx_legacy(struct cros_ec_device *ec_dev,
 	return EC_MSG_TX_PROTO_BYTES + msg->outsize;
 }
 
-static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
 {
 	int ret;
 	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
@@ -123,14 +123,21 @@ static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_co
 		 * the EC is trying to use protocol v2, on an underlying
 		 * communication mechanism that does not support v2.
 		 */
-		dev_err_once(ec_dev->dev,
-			     "missing EC transfer API, cannot send command\n");
+		dev_err_once(ec_dev->dev, "missing EC transfer API, cannot send command\n");
 		return -EIO;
 	}
 
 	trace_cros_ec_request_start(msg);
 	ret = (*xfer_fxn)(ec_dev, msg);
 	trace_cros_ec_request_done(msg, ret);
+
+	return ret;
+}
+
+static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+{
+	int ret = cros_ec_xfer_command(ec_dev, msg);
+
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
 		struct cros_ec_command *status_msg;
-- 
2.36.1.476.g0c4daa206d-goog

