Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6583B55C976
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbiF1Ctu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbiF1Ctm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB0210C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E59B612C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DB2C341CB;
        Tue, 28 Jun 2022 02:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656384581;
        bh=nrsyhpna2MkleoX4LAm7NeEoXbnlHT1oLd8f6M7XSgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dObOlwdWptdzyi5xajcZoXkyYtzYoz8nxt0pruw+vYhqpvTehluN3QKGPNRVNsjwx
         Fje/EqiO+/n/+uxQOWEutyixspWUMs/IuxrwcUW47c57FwhTdpoUvvaMxGKzbGXh9+
         wrWARaQS8mHlmfzC+de8kYFKeXgy+3vACrchG2wLswxBhuAFyas/fq2jKNovqPeA06
         rwJ10ApZcwBfu/nUoDmlQ9neyQFYbV1jdqZvthtYBvJWti19ZqOLi6TZByzaISRNWq
         R2zWUbFD8Sm3Xt6fFTVBCpip3dY7yYo3bQvu0rJChP9d1WnYYmz9xcXmxvp5iXsYpT
         HThv+snhCO5aA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 07/11] platform/chrome: cros_ec_proto: return -EAGAIN when retries timed out
Date:   Tue, 28 Jun 2022 02:49:09 +0000
Message-Id: <20220628024913.1755292-8-tzungbi@kernel.org>
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

While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
cros_ec_wait_until_complete() doesn't return an error code.

Return -EAGAIN in the case instead.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 466ecb063bd6..49772a4c5353 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -167,6 +167,9 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
 			break;
 	}
 
+	if (i >= EC_COMMAND_RETRIES)
+		ret = -EAGAIN;
+
 	kfree(msg);
 	return ret;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

