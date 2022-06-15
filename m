Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F260854C118
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbiFOFNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbiFOFNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80452934C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6340CB81BF1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B805C34115;
        Wed, 15 Jun 2022 05:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269996;
        bh=i5w06+KIfprfZwCkANiW0+X0QAOeYszoT4dilim9fog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DybqA0Q1enn3Y1tSudMj/BYzmP+bjyjVHRZvu1POpFKmPqGKOrRbg3KowDHPkSpEK
         aKXeEV1o6foB+kdGXLJ/u2PrRHdvbXm7qz7TSic0tfpGvCSF8/2/87NVGHArV6wilL
         JR4XONlDiClP6iy9vrdhQ6jUjTkS+o0ejEeh5q/O2cfvC/AxIku8UYhrZ4n/rZ3tXv
         ZJS5SjY3/ATLYJBMpU7rplFbthYpSZkYNO26TUYLx3Nxg0h++1pfYn2hXFsP22yt2j
         5hcvDxBYVjp/93LXre9FoM/lv3QstxTKusFfXA87ZXd32vMrv8/tc08DWo7kb/ALT5
         PeiuiK0oCOSqw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] platform/chrome: cros_ec_proto: add Kunit test for empty payload
Date:   Wed, 15 Jun 2022 05:12:47 +0000
Message-Id: <20220615051248.1628156-11-tzungbi@kernel.org>
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

cros_ec_wait_until_complete() sends EC_CMD_GET_COMMS_STATUS which expects
to receive sizeof(struct ec_response_get_comms_status) from
cros_ec_xfer_command().

Add Kunit test and expect to receive an error code when
cros_ec_xfer_command() returns 0.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 2a6b099fbfd9..7d45e5022221 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -1934,6 +1934,36 @@ static void cros_ec_proto_test_cmd_xfer_in_progress_return_error(struct kunit *t
 	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
 }
 
+static void cros_ec_proto_test_cmd_xfer_in_progress_return0(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	/* For the first host command to return EC_RES_IN_PROGRESS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For EC_CMD_GET_COMMS_STATUS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EPROTO);
+
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
+}
+
 static void cros_ec_proto_test_release(struct device *dev)
 {
 }
@@ -2013,6 +2043,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_xfer_error),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return_error),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return0),
 	{}
 };
 
-- 
2.36.1.476.g0c4daa206d-goog

