Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90358542EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiFHLI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiFHLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE711F7025
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05730B826ED
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61BCC341C7;
        Wed,  8 Jun 2022 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686481;
        bh=Um6SwSY/R7iCUAQw7u/d1daMAEsUQQfyx1jfmVt5HZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADqOpWIx5guELp4hDEkdG5npLO9m52yfVwf77Q9BvFAgzJUa+8Ezwg8FqOjkyrKPN
         cE4kP14WK+hO0+5p4ymhuUVhDJXA+LwS9kqoUFOri0JSXSg0PJEqpQytmQn6W3+nFj
         YZK+ThLHJfrHJU9/ODSZpZP6jKct+DCQTk+JcncohkCt1RJqneGP3Bkbx+UojYr5ti
         vG5QkEMYhSdJsvuqIPrqMT7yKH140204klMK/F4aYoSb9Ncql2UYsdGY56D0b8WDxT
         cLcVrT1n12owxDMtxbOYXb3unVn/4Zu3C0sheKFrwioPQx6YvueMWkjBomHl58o4QE
         +cR9gQb0JMYNA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/23] platform/chrome: cros_ec_proto: add Kunit test for getting legacy info
Date:   Wed,  8 Jun 2022 11:07:22 +0000
Message-Id: <20220608110734.2928245-12-tzungbi@kernel.org>
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

cros_ec_get_proto_info_legacy() expects to receive
sizeof(struct ec_response_hello) from send_command().  The payload is
valid only if the return value is positive.

Add a Kunit test for returning 0 from send_command() in
cros_ec_get_proto_info_legacy().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No v2.  New and separated from the original series.

 drivers/platform/chrome/cros_ec_proto_test.c | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 8e47cb70dc8b..63071af81c94 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -751,6 +751,54 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_query_all_legacy_return0(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* For cros_ec_get_proto_info() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_get_proto_info_legacy(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, -EPROTO);
+	KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
+
+	/* For cros_ec_get_proto_info() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_get_proto_info_legacy(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_hello));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_hello));
+	}
+}
+
 static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv = test->priv;
@@ -1135,6 +1183,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_xfer_error),
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return_error),
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_data_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
 	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
-- 
2.36.1.255.ge46751e96f-goog

