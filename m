Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3C0542EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiFHLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiFHLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E681C287F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4271615E9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71951C341C5;
        Wed,  8 Jun 2022 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686479;
        bh=rEQq7TqpSemfpsFB73dL2/FazuLAtoO+u/JSFRyGWQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2pFYi1I0TidC1idSxs+LZbBvJrrtpXFJ/trZa4tu426NKAEoltkmthTqa1bb7Zzc
         1l8TUAbma7UYPqKrhymI3xAAKSqqAMerD/+kzV6afpjh5wiuePWCVPLadMWcJeLTMh
         H5DhdnbDhqYgHbA8e0xMI/1k6GyJuKtufcX6opnHGUW73dayc/et94Gt5a0NDgzA0Z
         V1MOwA9z3WcPhA1NxqytCHJD8qngzRDwutYuzNpwXSErZp6TR5wRWEYsFFl44BAwYN
         kaWXr9K44jG+LVlA9aIsOZS+7Up41FeYVSQtHSmUNQHJXieluxxi0qW6M6LP7ULwJw
         nq/JNNj5KV/ZQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/23] platform/chrome: cros_ec_proto: handle empty payload in getting proto info
Date:   Wed,  8 Jun 2022 11:07:20 +0000
Message-Id: <20220608110734.2928245-10-tzungbi@kernel.org>
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

cros_ec_get_proto_info() expects to receive
sizeof(struct ec_response_get_protocol_info) from send_command().  The
payload is valid only if the return value is positive.

Return -EPROTO if send_command() returns 0 in cros_ec_get_proto_info().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v2:
- Separate Kunit test to another patch.

 drivers/platform/chrome/cros_ec_proto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 893b76703da6..6f5be9e5ede4 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -314,6 +314,11 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 		goto exit;
 	}
 
+	if (ret == 0) {
+		ret = -EPROTO;
+		goto exit;
+	}
+
 	info = (struct ec_response_get_protocol_info *)msg->data;
 
 	switch (devidx) {
-- 
2.36.1.255.ge46751e96f-goog

