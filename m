Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001D555414A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356949AbiFVEMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356841AbiFVELZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD36C34B9A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C868E618DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55506C341C5;
        Wed, 22 Jun 2022 04:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655871075;
        bh=WYVxy9PScO2gU3QXfVPFYV1xcw46gvTAXm4A59rJWJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SobO0/+GpLPt+g4JTb4RMoY6jAz7VJ2D/n3Hj+V+YdyL2mn1ZtumYWyL87Nth+J9I
         exFJ+F9heveHNxlI5mR11NOVWZ81oIwD9o8j3Yo15fws4wPFQ0YIATVk7BhjTck+XZ
         iqIZHJ1CZNuaWLuHf3Bv3GmXY9klhpMtSGEH3+SNIb5Wu7ZnCUzZFvNLsUnIkra1qS
         8O39Uets8txqMWA0yHb9CX2GTzuRDTx+lPcMR0uNNWymMyd5mckbymgGEqQk7WfSAX
         X89FHFjIwDrTe4nHpSQ0D1Lf3sSV5iHzRidQSedHrZfFgjAJwgFsHjMQonP5ibJn9T
         bNppRq27067hw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] platform/chrome: cros_ec_proto: add Kunit tests for get_sensor_count
Date:   Wed, 22 Jun 2022 04:10:39 +0000
Message-Id: <20220622041040.202737-7-tzungbi@kernel.org>
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

cros_ec_get_sensor_count() gets number of MEMS sensors.

Add Kunit tests for cros_ec_get_sensor_count().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 153 +++++++++++++++++++
 drivers/platform/chrome/cros_kunit_util.c    |  22 +++
 drivers/platform/chrome/cros_kunit_util.h    |   7 +
 3 files changed, 182 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 93c1700deaef..6b26ce3104f4 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -2442,6 +2442,156 @@ static void cros_ec_proto_test_check_features_not_cached(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_get_sensor_count_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_dev ec;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec.ec_dev = ec_dev;
+	ec.dev = ec_dev->dev;
+	ec.cmd_offset = 0;
+
+	/* For EC_CMD_MOTION_SENSE_CMD. */
+	{
+		struct ec_response_motion_sense *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_motion_sense *)mock->o_data;
+		data->dump.sensor_count = 0xbf;
+	}
+
+	ret = cros_ec_get_sensor_count(&ec);
+	KUNIT_EXPECT_EQ(test, ret, 0xbf);
+
+	/* For EC_CMD_MOTION_SENSE_CMD. */
+	{
+		struct ec_params_motion_sense *data;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_motion_sense));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
+
+		data = (struct ec_params_motion_sense *)mock->i_data;
+		KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
+	}
+}
+
+static void cros_ec_proto_test_get_sensor_count_xfer_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_dev ec;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec.ec_dev = ec_dev;
+	ec.dev = ec_dev->dev;
+	ec.cmd_offset = 0;
+
+	/* For EC_CMD_MOTION_SENSE_CMD. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, -EPROTO, EC_RES_SUCCESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	ret = cros_ec_get_sensor_count(&ec);
+	KUNIT_EXPECT_EQ(test, ret, -EPROTO);
+
+	/* For EC_CMD_MOTION_SENSE_CMD. */
+	{
+		struct ec_params_motion_sense *data;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_motion_sense));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
+
+		data = (struct ec_params_motion_sense *)mock->i_data;
+		KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
+	}
+}
+
+static void cros_ec_proto_test_get_sensor_count_legacy(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret, i;
+	struct cros_ec_dev ec;
+	struct {
+		u8 readmem_data;
+		int expected_result;
+	} test_data[] = {
+		{ 0, 0 },
+		{ EC_MEMMAP_ACC_STATUS_PRESENCE_BIT, 2 },
+	};
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->cmd_readmem = cros_kunit_readmem_mock;
+	ec.ec_dev = ec_dev;
+	ec.dev = ec_dev->dev;
+	ec.cmd_offset = 0;
+
+	for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
+		/* For EC_CMD_MOTION_SENSE_CMD. */
+		{
+			mock = cros_kunit_ec_xfer_mock_addx(test, -EPROTO, EC_RES_SUCCESS, 0);
+			KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+		}
+
+		/* For readmem. */
+		{
+			cros_kunit_readmem_mock_data = kunit_kzalloc(test, 1, GFP_KERNEL);
+			KUNIT_ASSERT_PTR_NE(test, cros_kunit_readmem_mock_data, NULL);
+			cros_kunit_readmem_mock_data[0] = test_data[i].readmem_data;
+
+			cros_kunit_ec_xfer_mock_default_ret = 1;
+		}
+
+		ret = cros_ec_get_sensor_count(&ec);
+		KUNIT_EXPECT_EQ(test, ret, test_data[i].expected_result);
+
+		/* For EC_CMD_MOTION_SENSE_CMD. */
+		{
+			struct ec_params_motion_sense *data;
+
+			mock = cros_kunit_ec_xfer_mock_next();
+			KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+			KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
+			KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
+			KUNIT_EXPECT_EQ(test, mock->msg.insize,
+					sizeof(struct ec_response_motion_sense));
+			KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
+
+			data = (struct ec_params_motion_sense *)mock->i_data;
+			KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
+		}
+
+		/* For readmem. */
+		{
+			KUNIT_EXPECT_EQ(test, cros_kunit_readmem_mock_offset, EC_MEMMAP_ACC_STATUS);
+		}
+	}
+}
+
 static void cros_ec_proto_test_release(struct device *dev)
 {
 }
@@ -2537,6 +2687,9 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_get_host_event_normal),
 	KUNIT_CASE(cros_ec_proto_test_check_features_cached),
 	KUNIT_CASE(cros_ec_proto_test_check_features_not_cached),
+	KUNIT_CASE(cros_ec_proto_test_get_sensor_count_normal),
+	KUNIT_CASE(cros_ec_proto_test_get_sensor_count_xfer_error),
+	KUNIT_CASE(cros_ec_proto_test_get_sensor_count_legacy),
 	{}
 };
 
diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
index 3ede971e82ee..d37c334b416d 100644
--- a/drivers/platform/chrome/cros_kunit_util.c
+++ b/drivers/platform/chrome/cros_kunit_util.c
@@ -105,6 +105,24 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void)
 }
 EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
 
+int cros_kunit_readmem_mock_offset;
+EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_offset);
+u8 *cros_kunit_readmem_mock_data;
+EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_data);
+int cros_kunit_readmem_mock_ret;
+EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_ret);
+
+int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
+			    unsigned int bytes, void *dest)
+{
+	cros_kunit_readmem_mock_offset = offset;
+
+	memcpy(dest, cros_kunit_readmem_mock_data, bytes);
+
+	return cros_kunit_readmem_mock_ret;
+}
+EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock);
+
 void cros_kunit_mock_reset(void)
 {
 	cros_kunit_ec_xfer_mock_default_ret = 0;
@@ -112,6 +130,10 @@ void cros_kunit_mock_reset(void)
 	cros_kunit_ec_pkt_xfer_mock_called = 0;
 	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_in);
 	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_out);
+
+	cros_kunit_readmem_mock_offset = 0;
+	cros_kunit_readmem_mock_data = NULL;
+	cros_kunit_readmem_mock_ret = 0;
 }
 EXPORT_SYMBOL_GPL(cros_kunit_mock_reset);
 
diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
index ae4080cb13f1..88134c9f1acf 100644
--- a/drivers/platform/chrome/cros_kunit_util.h
+++ b/drivers/platform/chrome/cros_kunit_util.h
@@ -35,6 +35,13 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
 						  int ret, int result, size_t size);
 struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void);
 
+extern int cros_kunit_readmem_mock_offset;
+extern u8 *cros_kunit_readmem_mock_data;
+extern int cros_kunit_readmem_mock_ret;
+
+int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
+			    unsigned int bytes, void *dest);
+
 void cros_kunit_mock_reset(void);
 
 #endif
-- 
2.37.0.rc0.104.g0611611a94-goog

