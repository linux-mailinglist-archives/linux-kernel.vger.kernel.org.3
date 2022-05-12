Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2655247F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbiELIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiELIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D726131
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 969C760DF3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE659C34100;
        Thu, 12 May 2022 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652344613;
        bh=+ElejYVrlc9ZxlHbkXbJTVjfLTw9jluzs88dkguwQgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfzeSAilNyMiEDlFz6+/GQvqlhIB+YMmSv6Z16tQsDN4voGg9l+/HWNz7yWnVYQH+
         1EXA/byEIWtixjtg4F74mb83x8ya0me0SPbmjBK7fZ5bpE08s7RLne9jMFTcfQbkE9
         6TQOH4HXf6GbffR2d3aVx7LDSO+MxISu5Xr1KWNIH4vO6Nv3yyL/RAtAmy/qkhvkrO
         nB+5XVqr/Jvoy0XnC87p8zgv5g/LzWViyoC4bgbqlI5RPIunlOKRjh06Kel7GFDKwA
         9gn+BtZKNSmb7ctk+njxxN7gjZ227vhjNLNA89v57hWzqKZVLcqofq94fvgF2RyWo7
         L2TaSIvlx+mpg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_prepare_tx()
Date:   Thu, 12 May 2022 16:36:24 +0800
Message-Id: <20220512083627.885338-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220512083627.885338-1-tzungbi@kernel.org>
References: <20220512083627.885338-1-tzungbi@kernel.org>
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

It is overkill to crash the kernel if the given message is oversize.

Drop the BUG_ON() and return -EINVAL instead.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 2d6d3fbfa905..9ce3374846ff 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -60,7 +60,8 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
 	int i;
 	u8 csum = 0;
 
-	BUG_ON(msg->outsize + sizeof(*request) > ec_dev->dout_size);
+	if (msg->outsize + sizeof(*request) > ec_dev->dout_size)
+		return -EINVAL;
 
 	out = ec_dev->dout;
 	request = (struct ec_host_request *)out;
@@ -176,7 +177,9 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 	if (ec_dev->proto_version > 2)
 		return prepare_packet(ec_dev, msg);
 
-	BUG_ON(msg->outsize > EC_PROTO2_MAX_PARAM_SIZE);
+	if (msg->outsize > EC_PROTO2_MAX_PARAM_SIZE)
+		return -EINVAL;
+
 	out = ec_dev->dout;
 	out[0] = EC_CMD_VERSION0 + msg->version;
 	out[1] = msg->command;
-- 
2.36.0.512.ge40c2bad7a-goog

