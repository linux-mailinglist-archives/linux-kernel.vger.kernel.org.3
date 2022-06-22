Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0E55414E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356813AbiFVEMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356846AbiFVELY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:11:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B134649
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E7EEB81C0D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D3CC3411B;
        Wed, 22 Jun 2022 04:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655871070;
        bh=zWU7zFcTL4T6L1wZvGirAOoq71xYc+4bCfTaybkkAlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quYfJrYHUmuZ+AhU+871xttFH040ddFEL/6Fr3iGCXFAfe65jX8+8MpgEVwxCa61P
         ci6+2fvebHkohtanHFFvCjGGZPj0kJzPPxvazu1ax7vdci3PftVGY3V4ENf/+eFkW6
         pXdjktFpmYhyCm85g0sv+S9VS98jDiMnQKcB8QcJNKuU/OD4Zic/aB563gxsbMvswo
         AybncbTtGEJ7M0SyMW6vn++U63teXSarL6tOBKHHVaHPZCbMzYLL5gnDpBGwPswe80
         HpRqEe8DTXd5DmhEojS0DN8ZFnjLYuW0wI65KqyXEucsbkxThJA9+Ue2hB8AKVgV9Q
         LbpSCcwPYyGeA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] platform/chrome: cros_ec_proto: add Kunit test for cros_ec_map_error()
Date:   Wed, 22 Jun 2022 04:10:35 +0000
Message-Id: <20220622041040.202737-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622041040.202737-1-tzungbi@kernel.org>
References: <20220622041040.202737-1-tzungbi@kernel.org>
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

cros_ec_cmd_xfer_status() is the only exported function that calls
static function cros_ec_map_error().

Add Kunit test for cros_ec_map_error() through calling
cros_ec_cmd_xfer_status().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 6464f6101fd3..be3ac77abdf9 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -2004,6 +2004,54 @@ static void cros_ec_proto_test_cmd_xfer_status_xfer_error(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, -EPROTO);
 }
 
+static void cros_ec_proto_test_cmd_xfer_status_return_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret, i;
+	struct cros_ec_command msg;
+	static const int map[] = {
+		[EC_RES_SUCCESS] = 0,
+		[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
+		[EC_RES_ERROR] = -EIO,
+		[EC_RES_INVALID_PARAM] = -EINVAL,
+		[EC_RES_ACCESS_DENIED] = -EACCES,
+		[EC_RES_INVALID_RESPONSE] = -EPROTO,
+		[EC_RES_INVALID_VERSION] = -ENOPROTOOPT,
+		[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
+		/*
+		 * EC_RES_IN_PROGRESS is special because cros_ec_send_command() has extra logic to
+		 * handle it.  Note that default cros_kunit_ec_xfer_mock_default_ret == 0 thus
+		 * cros_ec_xfer_command() in cros_ec_wait_until_complete() returns 0.  As a result,
+		 * it returns -EPROTO without calling cros_ec_map_error().
+		 */
+		[EC_RES_IN_PROGRESS] = -EPROTO,
+		[EC_RES_UNAVAILABLE] = -ENODATA,
+		[EC_RES_TIMEOUT] = -ETIMEDOUT,
+		[EC_RES_OVERFLOW] = -EOVERFLOW,
+		[EC_RES_INVALID_HEADER] = -EBADR,
+		[EC_RES_REQUEST_TRUNCATED] = -EBADR,
+		[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
+		[EC_RES_BUS_ERROR] = -EFAULT,
+		[EC_RES_BUSY] = -EBUSY,
+		[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
+		[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
+		[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
+		[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
+	};
+
+	memset(&msg, 0, sizeof(msg));
+
+	for (i = 0; i < ARRAY_SIZE(map); ++i) {
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, i, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		ret = cros_ec_cmd_xfer_status(ec_dev, &msg);
+		KUNIT_EXPECT_EQ(test, ret, map[i]);
+	}
+}
+
 static void cros_ec_proto_test_release(struct device *dev)
 {
 }
@@ -2086,6 +2134,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return0),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_normal),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_xfer_error),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_return_error),
 	{}
 };
 
-- 
2.37.0.rc0.104.g0611611a94-goog

