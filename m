Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3315401EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbiFGO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343624AbiFGO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:57:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766313DCD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5850DB820C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB62C385A5;
        Tue,  7 Jun 2022 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613828;
        bh=H0mipIM7/GL82Ffgavcgx1/F0jUiLihsOwl8096jq8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+ogv8pQ3j6HapgIWrc9ltPFKtYvoJWiYMMcAq3OBqe3TCRu5tjh85hoVJFjfEN9c
         SG2quHAHkyWVbL3PWUaFKO7gsOeaS4yfgWubE3pbYteljokQVeC/PQSqfdQt75IoEF
         kaUC5VTvoBD64e9y5CsM3Xyvm55BOTc8CO7zNm2RohRsbsXoly2Oen088JI9OpDoK3
         CfUFCdS1QpFdSojJuRceIW4Xy8f/g98D6AeALM0QNWQr6WDeRZWaKCuPzg0N9OPV8R
         kN4j/zuswPABTh7rIV/oZAIcy728ZuWJcfIBHWuoDdhtpgzpHvcROemxgN2DEZZdnZ
         fasn1s6ykCSuQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH v2 13/15] platform/chrome: cros_ec_proto: don't show MKBP version if unsupported
Date:   Tue,  7 Jun 2022 14:56:37 +0000
Message-Id: <20220607145639.2362750-14-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607145639.2362750-1-tzungbi@kernel.org>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
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

It wrongly showed the following message when it doesn't support MKBP:
"MKBP support version 4294967295".

Fix it.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No v1.  New in the series.

 drivers/platform/chrome/cros_ec_proto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index de6bc457e496..ee15a73eee38 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -506,13 +506,13 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
 						    EC_CMD_GET_NEXT_EVENT,
 						    &ver_mask);
-	if (ret < 0 || ver_mask == 0)
+	if (ret < 0 || ver_mask == 0) {
 		ec_dev->mkbp_event_supported = 0;
-	else
+	} else {
 		ec_dev->mkbp_event_supported = fls(ver_mask);
 
-	dev_dbg(ec_dev->dev, "MKBP support version %u\n",
-		ec_dev->mkbp_event_supported - 1);
+		dev_dbg(ec_dev->dev, "MKBP support version %u\n", ec_dev->mkbp_event_supported - 1);
+	}
 
 	/* Probe if host sleep v1 is supported for S0ix failure detection. */
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
-- 
2.36.1.255.ge46751e96f-goog

