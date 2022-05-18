Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6423452B620
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiERJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiERJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:18:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1B20F6C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2CBAB81EEF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F234C34113;
        Wed, 18 May 2022 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865517;
        bh=QyFJZzEsnEsrlWMWXjof8oPuhELGLvpS5gdy1Ruuuug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ8nNnOFTHP2OIXelVrkUf4+jpbb7chiaCx1Q4napWwuqZvsjfqmWHKWUxGn5DUfQ
         Vc7f86+sIjT4dU9NfbnD5E2Yvza44XD5oRkL0kGJ5t+3HIQHGVWnduIe1tOAr3NipU
         uRxu2QhM91rXfQo6IFqX8mzHsv87j8tYcSAldamFcZ/8RXPnWogpVQiYxxrMX6nvqd
         gESqERjl/smC4+yvcfjI6GUQmuXhmQixKSVKyxHrkTWZtNrzimUjmQ3RyOUs8i9xln
         wwuzfPwYCZOcNo7kgtzCwBLhJgrUy/n/g1BMfLUG/Odd1l3Puy9+Ucu5kFDV3sETYI
         molyAKtOjNWvg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org, dianders@chromium.org
Subject: [PATCH 4/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_check_result()
Date:   Wed, 18 May 2022 17:18:14 +0800
Message-Id: <20220518091814.2028579-5-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220518091814.2028579-1-tzungbi@kernel.org>
References: <20220518091814.2028579-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_check_result() is used to check if the EC communication success but
EC responded EC_RES_IN_PROGRESS.  It should return 0 even if EC wasn't
happy about the host command.

Add Kunit tests for cros_ec_check_result().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 61abb18ac00b..25c4fca5c165 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -132,6 +132,46 @@ static void cros_ec_proto_test_prepare_tx_bad_msg_outsize(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 }
 
+static void cros_ec_proto_test_check_result(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct cros_ec_command *msg = priv->msg;
+	int ret, i;
+	static enum ec_status status[] = {
+		EC_RES_SUCCESS,
+		EC_RES_INVALID_COMMAND,
+		EC_RES_ERROR,
+		EC_RES_INVALID_PARAM,
+		EC_RES_ACCESS_DENIED,
+		EC_RES_INVALID_RESPONSE,
+		EC_RES_INVALID_VERSION,
+		EC_RES_INVALID_CHECKSUM,
+		EC_RES_UNAVAILABLE,
+		EC_RES_TIMEOUT,
+		EC_RES_OVERFLOW,
+		EC_RES_INVALID_HEADER,
+		EC_RES_REQUEST_TRUNCATED,
+		EC_RES_RESPONSE_TOO_BIG,
+		EC_RES_BUS_ERROR,
+		EC_RES_BUSY,
+		EC_RES_INVALID_HEADER_VERSION,
+		EC_RES_INVALID_HEADER_CRC,
+		EC_RES_INVALID_DATA_CRC,
+		EC_RES_DUP_UNAVAILABLE,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(status); ++i) {
+		msg->result = status[i];
+		ret = cros_ec_check_result(ec_dev, msg);
+		KUNIT_EXPECT_EQ(test, ret, 0);
+	}
+
+	msg->result = EC_RES_IN_PROGRESS;
+	ret = cros_ec_check_result(ec_dev, msg);
+	KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
+}
+
 static int cros_ec_proto_test_init(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv;
@@ -159,6 +199,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_prepare_tx_legacy_bad_msg_outsize),
 	KUNIT_CASE(cros_ec_proto_test_prepare_tx_normal),
 	KUNIT_CASE(cros_ec_proto_test_prepare_tx_bad_msg_outsize),
+	KUNIT_CASE(cros_ec_proto_test_check_result),
 	{}
 };
 
-- 
2.36.0.550.gb090851708-goog

