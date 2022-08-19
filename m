Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C8599593
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346919AbiHSHAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346939AbiHSHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:00:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08BC57B6;
        Fri, 19 Aug 2022 00:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU4xYXN9oDZ/yUSgoc/eH/QuiS6LZ+ogXNJFiTHIqrlHjSU/uqHJYa1FCOzEPbJs/Q9zkoTIpx9+MPeIBKM/y3AGl82gz5kdmA+jKKi9dqlSpmWsIGe3hH6m8fMiABslriAgumX4FfGK4oKDBALNrBsvj62rAqp/M7HxudNs2Bewcda+XVKPl2OccnyKHC6YO9FoZISgqHYe46s5rG+t4K6LGWboxg+gwkXdah4nqEVhD2ZPPU0xY8+3TeM9chZKYWtCD4DTEiSwTIe8ZZgm3AubBv+pcB64PJbYpgYrwBybkVn7iTygHm++H5TJ5NZlO8KHaxCIdop6du12pJqn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3UWGlXUGE7kDqs2tk6w1whSdABvOLxtHp+zAIJP9R8=;
 b=jCwPZyhe7ZmFTY2XCCNwSVB33sGa6mXGsnZKdZNwEmOgQOQtM28Z2uVEtmIIP9m/LppYjjOonj+R/28d1NJjURGrQlUwFCYqzNY5ihovwLZDevBKqoX7xjpI9+1+PWzmnePaG++zeCwxw0QDLe3H7ldzYFhWMfBFaSl4D/b0cwgXMid/Yn6q63aBp1iTLdGNB3QlaQtGsq9kqgU1B3SqS71AKUpOJOa2br964fmwCAK3XgaM0vkJgQ4mEKEz2S2OfQtnfWn6Xs7M1rf2CNAXlM1N3CvWvj5m6tqZmt9G0ZV1uVN3GG843R8jIXKPyl4ZvmYGgKpmpZXjB3RLdRR8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3UWGlXUGE7kDqs2tk6w1whSdABvOLxtHp+zAIJP9R8=;
 b=UlsCBaqvH+YCTPLUirB3Xr/YAuyMWPQsHgTQBoI0eC0ogmSbKlC7KX7BplBLiEgJouOr08gFWI+bQCOeuUeF9fujVPe/msiTz7FTqAD9BNFw5WOPVZPPnIkd3nJFsRgqxNYnQCD0rZ66GeVTsbGNaBAjAVp7Cu0hzb21bsobqFM=
Received: from DB6PR07CA0174.eurprd07.prod.outlook.com (2603:10a6:6:43::28) by
 AM5PR10MB1761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Fri, 19 Aug 2022 07:00:31 +0000
Received: from DBAEUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::e3) by DB6PR07CA0174.outlook.office365.com
 (2603:10a6:6:43::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 DBAEUR03FT017.mail.protection.outlook.com (100.127.142.243) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 07:00:30 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Fri, 19 Aug
 2022 09:00:29 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 19 Aug 2022 09:00:29 +0200
Received: from localhost.localdomain (10.167.0.81) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2375.31; Fri, 19 Aug 2022
 09:00:25 +0200
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <bcousson@baylibre.com>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>,
        <mkorpershoek@baylibre.com>, <davidgow@google.com>,
        <m.felsch@pengutronix.de>, <swboyd@chromium.org>,
        <fengping.yu@mediatek.com>, <y.oudjana@protonmail.com>,
        <rdunlap@infradead.org>, <colin.king@intel.com>,
        <Gireesh.Hiremath@in.bosch.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: [PATCH v3 2/3] driver: input: matric-keypad: add reduced matrix support
Date:   Fri, 19 Aug 2022 06:59:45 +0000
Message-ID: <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.0.81]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 977c3600-af60-4e2c-cbad-08da81b08149
X-MS-TrafficTypeDiagnostic: AM5PR10MB1761:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYf1o4yjqbVwKRM/Ts4cHWUOlBZHQY7qH7fDJrYNfXMG/jhmQMpzdnG6k6bWwvCjeaFClnu561VJ5O1samE9Sek+YUdBibLYGZtvMZKAXDMMuTKWw/j80xNDjUzoAFYDQPg0wGsZ5OXmNRyfsM2IStjX5niFaAcJ38vDBmLHoPp/0d2lCe0otClVQzjCrYYYgFaU98j5oCMKpliYVTN9aBBfFWKaPNOh4NwHmStxx8w/jacti+OxGbfOraBkpdzVDOXlPpGRyyqap0O0tsHbRo2KqT+7U0V8uTz2AD6TQOuNeMaH3ny0UeiP/seZmT1XO8KMOjvLkDrpLjAPq+4Z11Q+FJiYHULaql2cwjHYyPJpX1GNBD8XlaKYLlisnOb1w48BAPnhEQaHhJYYq9mTg+T1Pt6z4Ro95QqgzuwVqNGzHDIEp/Lb2nQW12kYS+uLEEGs2oQ+e7AcD52ho4s6OulWc8NWpAa1GCmGx5rKS9mM1XRGyNrRz0cgB45dfazthv/h7LAQxMVSBwkRUYtB3+oRbYsAOH7cKOgnbOSwb0eo5ci3Ip+5xbpYFbbSx1QdmoRBSHM8a6ODR0wUyB8ZOdXFu4FTr3Bfm+8qJuXxsFv3nMOmeLiUV2RsTVy1729lTLcasViIfpsnbMYU1m2VnCqrQPH6UYD6/7IxYhI9Uk0IJ8FTRCLiwHomIC49IyUCAjFIXuXi6xK8NiHecRYhNjl5lfhrwKJM34Qxm+nH5hqKnAXzVrLGjNqhSl2mtvq3RSR8Mk9TSOACfsxnR+cvEvMj+o2CXcrWMLUTx4ISkz8Ody1tD6N6RPBSbaLSJR9j
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(110136005)(70586007)(54906003)(70206006)(316002)(40480700001)(36860700001)(478600001)(8936002)(82960400001)(7049001)(5660300002)(7416002)(2906002)(86362001)(82740400003)(82310400005)(40460700003)(8676002)(41300700001)(2876002)(30864003)(4326008)(16526019)(81166007)(356005)(2616005)(921005)(107886003)(186003)(1076003)(47076005)(26005)(6666004)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 07:00:30.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977c3600-af60-4e2c-cbad-08da81b08149
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1761
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Add support to reduced matrix keypad driver.
Tested on Bosch Guardian Dtect board(TI-am335x).

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 drivers/input/keyboard/matrix_keypad.c | 559 +++++++++++++++++++++----
 include/linux/input/matrix_keypad.h    |  68 +--
 2 files changed, 520 insertions(+), 107 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index b99574edad9c..72c0663b6ed3 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -21,9 +21,30 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
+struct button_states {
+	uint8_t previous_state : 1;
+	uint8_t current_state : 1;
+};
+
+union button_event {
+	uint8_t clear_event;
+	struct {
+		uint8_t global_changed : 1;
+		uint8_t pressed : 1;
+		uint8_t released : 1;
+	} status;
+};
+
+struct button {
+	uint8_t key;
+	union button_event event;
+	struct button_states state;
+};
+
 struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
+	struct button *button_array;
 	unsigned int row_shift;
 
 	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
@@ -31,11 +52,34 @@ struct matrix_keypad {
 	uint32_t last_key_state[MATRIX_MAX_COLS];
 	struct delayed_work work;
 	spinlock_t lock;
+	int8_t current_line_gpio;
 	bool scan_pending;
 	bool stopped;
 	bool gpio_all_disabled;
 };
 
+struct keypad_info {
+	unsigned char mode;
+};
+
+static const struct keypad_info keypad_infos[] = {
+	{
+		.mode = GENERIC,
+	},
+	{
+		.mode = REDUCED,
+	},
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id matrix_keypad_dt_match[] = {
+	{ .compatible = "gpio-matrix-keypad", .data = &keypad_infos[0] },
+	{ .compatible = "gpio-matrix-keypad-reduced",
+	  .data = &keypad_infos[1] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, matrix_keypad_dt_match);
+#endif
 /*
  * NOTE: If drive_inactive_cols is false, then the GPIO has to be put into
  * HiZ when de-activated to cause minmal side effect when scanning other
@@ -78,7 +122,8 @@ static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 			 int row)
 {
 	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
-			!pdata->active_low : pdata->active_low;
+		       !pdata->active_low :
+		       pdata->active_low;
 }
 
 static void enable_row_irqs(struct matrix_keypad *keypad)
@@ -107,6 +152,247 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 	}
 }
 
+static void
+__activate_line_driving(const struct matrix_keypad_platform_data *pdata,
+			int line, bool on)
+{
+	bool level_on = pdata->active_low;
+
+	if (on)
+		gpiod_direction_output(pdata->desc_gpios[line], level_on);
+	else
+		gpiod_direction_input(pdata->desc_gpios[line]);
+}
+
+static void
+activate_line_driving(const struct matrix_keypad_platform_data *pdata, int line,
+		      bool on)
+{
+	__activate_line_driving(pdata, line, on);
+
+	if (on && pdata->col_scan_delay_us)
+		udelay(pdata->col_scan_delay_us);
+}
+
+static void button_init(struct button *btn, bool btn_hw_state, int key)
+{
+	btn->state.previous_state = btn_hw_state;
+	btn->state.current_state = btn_hw_state;
+	btn->event.clear_event = 0;
+	btn->key = key;
+}
+
+static bool check_button_changes(struct button *btn)
+{
+	/* Check if Button is pressed */
+	if ((!btn->state.previous_state) && btn->state.current_state)
+		btn->event.status.pressed = true;
+
+	/* Check if Button is released */
+	else if (btn->state.previous_state && (!btn->state.current_state))
+		btn->event.status.released = true;
+
+	if (btn->event.clear_event != 0)
+		btn->event.status.global_changed = true;
+
+	btn->state.previous_state = btn->state.current_state;
+
+	return btn->event.status.global_changed;
+}
+
+static union button_event get_and_clear_events(struct button *btn)
+{
+	union button_event temp = btn->event;
+
+	btn->event.clear_event = 0;
+
+	return temp;
+}
+
+static union button_event get_and_clear_btn_events(struct matrix_keypad *keypad,
+						   int btn_index)
+{
+	if (btn_index < keypad->pdata->num_of_buttons)
+		return get_and_clear_events(&keypad->button_array[btn_index]);
+	else
+		return get_and_clear_events(&keypad->button_array[0]);
+}
+
+static void button_hdl_init(struct matrix_keypad *keypad)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int row, col, index;
+	int i;
+
+	/* Init Button Objects, will be reinited once states are captured */
+	i = 0;
+	for (row = 1; row < pdata->num_line_gpios; row++)
+		for (col = 0; col < row; col++) {
+			index = (row * pdata->num_line_gpios) + col;
+			if (pdata->keycode[index] != pdata->keycode[0]) {
+				if (i < pdata->num_of_buttons) {
+					button_init(&keypad->button_array[i],
+						    false,
+						    pdata->keycode[index]);
+					i++;
+				}
+			}
+		}
+
+	pr_debug("[matrix-keypad]: %s Done\n", __func__);
+}
+
+static void on_button_event(struct matrix_keypad *keypad, int btn_index,
+			    union button_event btn_event,
+			    struct input_dev *input_dev)
+{
+	unsigned int key_code = 0;
+	int key_value = 0;
+
+	key_code = keypad->button_array[btn_index].key;
+
+	if (btn_event.status.pressed) {
+		key_value = 1;
+		pr_debug("[matrix-keypad]:%d Pressed\n", key_code);
+	}
+
+	if (btn_event.status.released) {
+		key_value = 0;
+		pr_debug("[matrix-keypad]:%d Released\n", key_code);
+	}
+
+	input_report_key(input_dev, key_code, key_value);
+	input_sync(input_dev);
+}
+
+static void process_button_events(struct matrix_keypad *keypad,
+				  struct input_dev *input_dev)
+{
+	int btn_index;
+
+	for (btn_index = 0; btn_index < keypad->pdata->num_of_buttons;
+	     btn_index++) {
+		const union button_event beEvent =
+			get_and_clear_btn_events(keypad, (int)btn_index);
+
+		if (beEvent.status.global_changed) {
+			on_button_event(keypad, (int)btn_index, beEvent,
+					input_dev);
+		}
+	}
+}
+
+static bool get_gpio_line_value(const struct matrix_keypad_platform_data *pdata,
+				int row)
+{
+	return gpiod_get_value(pdata->desc_gpios[row]) ? pdata->active_low :
+							 !pdata->active_low;
+}
+
+static uint8_t get_btn_index(struct matrix_keypad *keypad, int btn_key)
+{
+	uint8_t i;
+
+	for (i = 0; i < keypad->pdata->num_of_buttons; i++) {
+		if (keypad->button_array[i].key == btn_key)
+			break;
+	}
+	return i;
+}
+
+static void set_btn_state_by_hw(struct button *btn, bool buttonstate)
+{
+	btn->state.current_state = buttonstate;
+}
+
+static void poll_prepare(struct matrix_keypad *keypad)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+
+	keypad->current_line_gpio = 0;
+	activate_line_driving(pdata, (int)keypad->current_line_gpio, true);
+}
+
+static void poll_process(struct matrix_keypad *keypad,
+			 struct input_dev *input_dev)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	bool btn_changes_occured = false;
+	int btn_index;
+
+	for (btn_index = 0; btn_index < pdata->num_of_buttons; btn_index++) {
+		btn_changes_occured |=
+			check_button_changes(&keypad->button_array[btn_index]);
+	}
+
+	if (btn_changes_occured)
+		process_button_events(keypad, input_dev);
+
+	keypad->current_line_gpio = 0;
+}
+
+static void poll_update(struct matrix_keypad *keypad,
+			struct input_dev *input_dev)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	uint8_t *btn_keylines;
+	uint8_t number_of_buttons_pressed = 0;
+	uint8_t btn_index;
+	uint8_t btn_key;
+	uint16_t index;
+	int i;
+
+	btn_keylines =
+		kcalloc(pdata->num_line_gpios, sizeof(uint8_t), GFP_KERNEL);
+	for (i = 0; i < pdata->num_line_gpios; i++) {
+		index = (keypad->current_line_gpio * pdata->num_line_gpios) + i;
+		btn_key = pdata->keycode[index];
+		btn_keylines[i] = false;
+
+		if ((btn_key != pdata->keycode[0]) &&
+		    (get_gpio_line_value(pdata, (int)i) != false)) {
+			btn_keylines[i] = true;
+			number_of_buttons_pressed++;
+		}
+	}
+	if (number_of_buttons_pressed < 2) {
+		for (i = 0; i < pdata->num_line_gpios; i++) {
+			index = (keypad->current_line_gpio *
+				 pdata->num_line_gpios) +
+				i;
+			btn_key = pdata->keycode[index];
+			if (btn_key != pdata->keycode[0]) {
+				btn_index = get_btn_index(keypad, btn_key);
+				set_btn_state_by_hw(
+					&keypad->button_array[btn_index],
+					btn_keylines[i]);
+			}
+		}
+	}
+
+	kfree(btn_keylines);
+	activate_line_driving(pdata, (int)keypad->current_line_gpio, false);
+	keypad->current_line_gpio++;
+	activate_line_driving(
+		pdata, (int)(keypad->current_line_gpio % pdata->num_line_gpios),
+		true);
+}
+
+static void matrix_keypad_poll(struct input_dev *input)
+{
+	struct matrix_keypad *keypad = input_get_drvdata(input);
+	struct input_dev *input_dev = keypad->input_dev;
+
+	if (keypad->stopped == false) {
+		if (keypad->current_line_gpio ==
+		    keypad->pdata->num_line_gpios) {
+			poll_process(keypad, input_dev);
+		} else {
+			poll_update(keypad, input_dev);
+		}
+	}
+}
+
 /*
  * This gets the keys from keyboard and reports it to input subsystem
  */
@@ -127,7 +413,6 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	/* assert each column and read the row status out */
 	for (col = 0; col < pdata->num_col_gpios; col++) {
-
 		activate_col(pdata, col, true);
 
 		for (row = 0; row < pdata->num_row_gpios; row++)
@@ -150,8 +435,7 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 			code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
 			input_event(input_dev, EV_MSC, MSC_SCAN, code);
-			input_report_key(input_dev,
-					 keycodes[code],
+			input_report_key(input_dev, keycodes[code],
 					 new_state[col] & (1 << row));
 		}
 	}
@@ -186,7 +470,7 @@ static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
 	disable_row_irqs(keypad);
 	keypad->scan_pending = true;
 	schedule_delayed_work(&keypad->work,
-		msecs_to_jiffies(keypad->pdata->debounce_ms));
+			      msecs_to_jiffies(keypad->pdata->debounce_ms));
 
 out:
 	spin_unlock_irqrestore(&keypad->lock, flags);
@@ -204,7 +488,8 @@ static int matrix_keypad_start(struct input_dev *dev)
 	 * Schedule an immediate key scan to capture current key state;
 	 * columns will be activated and IRQs be enabled after the scan.
 	 */
-	schedule_delayed_work(&keypad->work, 0);
+	if (keypad->pdata->mode == GENERIC)
+		schedule_delayed_work(&keypad->work, 0);
 
 	return 0;
 }
@@ -217,7 +502,9 @@ static void matrix_keypad_stop(struct input_dev *dev)
 	keypad->stopped = true;
 	spin_unlock_irq(&keypad->lock);
 
-	flush_delayed_work(&keypad->work);
+	if (keypad->pdata->mode == GENERIC)
+		flush_delayed_work(&keypad->work);
+
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
 	 * we should disable them now.
@@ -236,7 +523,6 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 		if (enable_irq_wake(pdata->clustered_irq) == 0)
 			keypad->gpio_all_disabled = true;
 	} else {
-
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			if (!test_bit(i, keypad->disabled_gpios)) {
 				gpio = pdata->row_gpios[i];
@@ -296,8 +582,8 @@ static int matrix_keypad_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(matrix_keypad_pm_ops,
-			 matrix_keypad_suspend, matrix_keypad_resume);
+static SIMPLE_DEV_PM_OPS(matrix_keypad_pm_ops, matrix_keypad_suspend,
+			 matrix_keypad_resume);
 
 static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				   struct matrix_keypad *keypad)
@@ -316,9 +602,9 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	if (pdata->clustered_irq > 0) {
 		err = request_any_context_irq(pdata->clustered_irq,
-				matrix_keypad_interrupt,
-				pdata->clustered_irq_flags,
-				"matrix-keypad", keypad);
+					      matrix_keypad_interrupt,
+					      pdata->clustered_irq_flags,
+					      "matrix-keypad", keypad);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Unable to acquire clustered interrupt\n");
@@ -327,11 +613,10 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			err = request_any_context_irq(
-					gpiod_to_irq(pdata->row_gpios[i]),
-					matrix_keypad_interrupt,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
-					"matrix-keypad", keypad);
+				gpiod_to_irq(pdata->row_gpios[i]),
+				matrix_keypad_interrupt,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"matrix-keypad", keypad);
 			if (err < 0) {
 				dev_err(&pdev->dev,
 					"Unable to acquire interrupt for GPIO line %i\n",
@@ -361,30 +646,42 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
-
-	if (pdata->clustered_irq > 0) {
-		free_irq(pdata->clustered_irq, keypad);
+	if (pdata->mode == REDUCED) {
+		for (i = 0; i < pdata->num_line_gpios; i++)
+			gpiod_put(pdata->desc_gpios[i]);
 	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
-	}
+		if (pdata->clustered_irq > 0) {
+			free_irq(pdata->clustered_irq, keypad);
+		} else {
+			for (i = 0; i < pdata->num_row_gpios; i++)
+				free_irq(gpiod_to_irq(pdata->row_gpios[i]),
+					 keypad);
+		}
 
-	for (i = 0; i < pdata->num_row_gpios; i++)
-		gpiod_put(pdata->row_gpios[i]);
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			gpiod_put(pdata->row_gpios[i]);
 
-	for (i = 0; i < pdata->num_col_gpios; i++)
-		gpiod_put(pdata->col_gpios[i]);
+		for (i = 0; i < pdata->num_col_gpios; i++)
+			gpiod_put(pdata->col_gpios[i]);
+	}
 }
 
 #ifdef CONFIG_OF
 static struct matrix_keypad_platform_data *
 matrix_keypad_parse_dt(struct device *dev)
 {
+	const struct of_device_id *of_id =
+		of_match_device(matrix_keypad_dt_match, dev);
 	struct matrix_keypad_platform_data *pdata;
 	struct device_node *np = dev->of_node;
+	const struct keypad_info *info = of_id->data;
 	struct gpio_desc **gpios;
 	struct gpio_desc *desc;
 	int ret, i, nrow, ncol;
+	int8_t *keycode;
+	uint32_t *ptr;
+	int num_gpio;
+	int keymap;
 
 	if (!np) {
 		dev_err(dev, "device lacks DT data\n");
@@ -397,11 +694,23 @@ matrix_keypad_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	pdata->num_row_gpios = nrow = gpiod_count(dev, "row");
-	pdata->num_col_gpios = ncol = gpiod_count(dev, "col");
-	if (nrow <= 0 || ncol <= 0) {
-		dev_err(dev, "number of keypad rows/columns not specified\n");
-		return ERR_PTR(-EINVAL);
+	pdata->mode = info->mode;
+
+	if (pdata->mode == REDUCED) {
+		num_gpio = gpiod_count(dev, "line");
+		if (num_gpio <= 0) {
+			dev_err(dev, "number of gpio line not specified\n");
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		pdata->num_row_gpios = nrow = gpiod_count(dev, "row");
+		pdata->num_col_gpios = ncol = gpiod_count(dev, "col");
+
+		if (nrow <= 0 || ncol <= 0) {
+			dev_err(dev,
+				"number of keypad rows/columns not specified\n");
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
 	if (of_get_property(np, "linux,no-autorepeat", NULL))
@@ -415,34 +724,90 @@ matrix_keypad_parse_dt(struct device *dev)
 
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
 	of_property_read_u32(np, "col-scan-delay-us",
-						&pdata->col_scan_delay_us);
-
-	gpios = devm_kcalloc(dev,
-			     pdata->num_row_gpios + pdata->num_col_gpios,
-			     sizeof(*gpios),
-			     GFP_KERNEL);
-	if (!gpios) {
-		dev_err(dev, "could not allocate memory for gpios\n");
-		return ERR_PTR(-ENOMEM);
-	}
+			     &pdata->col_scan_delay_us);
+	if (pdata->mode == REDUCED) {
+		gpios = devm_kcalloc(dev, num_gpio, sizeof(*gpios), GFP_KERNEL);
+		if (!gpios)
+			return ERR_PTR(-ENOMEM);
+
+		for (i = 0; i < num_gpio; i++) {
+			desc = devm_gpiod_get_index(dev, "line", i, GPIOD_ASIS);
+			if (IS_ERR(desc))
+				return ERR_PTR(-EPROBE_DEFER);
+			gpios[i] = desc;
+		}
 
-	for (i = 0; i < nrow; i++) {
-		desc = devm_gpiod_get_index(dev, "row", i, GPIOD_IN);
-		if (IS_ERR(desc))
-			return ERR_PTR(ret);
-		gpios[i] = desc;
-	}
+		pdata->desc_gpios = gpios;
+		pdata->num_line_gpios = num_gpio;
+
+		if (!gpiod_is_active_low(pdata->desc_gpios[0]))
+			pdata->active_low = true;
+	} else {
+		gpios = devm_kcalloc(
+			dev, pdata->num_row_gpios + pdata->num_col_gpios,
+			sizeof(*gpios), GFP_KERNEL);
+		if (!gpios) {
+			dev_err(dev, "could not allocate memory for gpios\n");
+			return ERR_PTR(-ENOMEM);
+		}
+
+		for (i = 0; i < nrow; i++) {
+			desc = devm_gpiod_get_index(dev, "row", i, GPIOD_IN);
+			if (IS_ERR(desc))
+				return ERR_PTR(ret);
+			gpios[i] = desc;
+		}
+
+		for (i = 0; i < ncol; i++) {
+			desc = devm_gpiod_get_index(dev, "col", i, GPIOD_IN);
+			if (IS_ERR(desc))
+				return ERR_PTR(ret);
+			gpios[nrow + i] = desc;
+		}
 
-	for (i = 0; i < ncol; i++) {
-		desc = devm_gpiod_get_index(dev, "col", i, GPIOD_IN);
-		if (IS_ERR(desc))
-			return ERR_PTR(ret);
-		gpios[nrow + i] = desc;
+		pdata->row_gpios = gpios;
+		pdata->col_gpios = &gpios[pdata->num_row_gpios];
 	}
 
-	pdata->row_gpios = gpios;
-	pdata->col_gpios = &gpios[pdata->num_row_gpios];
+	if (pdata->mode == REDUCED) {
+		if (of_property_read_u32(np, "poll-interval-ms",
+					 &pdata->poll_interval_ms))
+			pdata->poll_interval_ms = 10;
 
+		of_property_read_u32(np, "number-of-buttons",
+				     &pdata->num_of_buttons);
+		if (pdata->num_of_buttons <= 0) {
+			dev_err(dev, "number of button not specified\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		keymap = device_property_count_u32(dev, "linux,keymap");
+		if (keymap <= 0 ||
+		    keymap > (pdata->num_line_gpios * pdata->num_line_gpios)) {
+			dev_err(dev, "linux,keymap property count is invalid");
+			return ERR_PTR(-ENXIO);
+		}
+
+		ptr = devm_kzalloc(dev, (keymap * sizeof(uint32_t)),
+				   GFP_KERNEL);
+		if (!ptr)
+			return ERR_PTR(-ENOMEM);
+
+		if (device_property_read_u32_array(dev, "linux,keymap", ptr,
+						   keymap)) {
+			dev_err(dev, "problem parsing keymap property\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		keycode = devm_kzalloc(dev, (keymap * sizeof(int8_t)),
+				       GFP_KERNEL);
+		if (!keycode)
+			return ERR_PTR(-ENOMEM);
+
+		pdata->keycode = keycode;
+		for (i = 0; i < keymap; i++)
+			pdata->keycode[i] = KEYCODE(ptr[i]);
+	}
 	return pdata;
 }
 #else
@@ -483,22 +848,58 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	keypad->pdata = pdata;
 	keypad->row_shift = get_count_order(pdata->num_col_gpios);
 	keypad->stopped = true;
-	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
+
+	if (pdata->mode == REDUCED) {
+		keypad->button_array = devm_kzalloc(
+			&pdev->dev,
+			sizeof(struct button) * (pdata->num_of_buttons),
+			GFP_KERNEL);
+		if (!keypad->button_array) {
+			dev_err(&pdev->dev,
+				"could not allocate memory for button array\n");
+			goto err_free_mem;
+			;
+		}
+
+		poll_prepare(keypad);
+
+		err = input_setup_polling(input_dev, matrix_keypad_poll);
+		if (err) {
+			dev_err(&pdev->dev,
+				"unable to set up polling, err=%d\n", err);
+			return err;
+		}
+
+		input_set_poll_interval(input_dev, pdata->poll_interval_ms);
+	} else {
+		INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
+	}
 	spin_lock_init(&keypad->lock);
 
-	input_dev->name		= pdev->name;
-	input_dev->id.bustype	= BUS_HOST;
-	input_dev->dev.parent	= &pdev->dev;
-	input_dev->open		= matrix_keypad_start;
-	input_dev->close	= matrix_keypad_stop;
-
-	err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
-					 pdata->num_row_gpios,
-					 pdata->num_col_gpios,
-					 NULL, input_dev);
-	if (err) {
-		dev_err(&pdev->dev, "failed to build keymap\n");
-		goto err_free_mem;
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->open = matrix_keypad_start;
+	input_dev->close = matrix_keypad_stop;
+
+	if (pdata->mode == REDUCED) {
+		err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
+						 pdata->num_line_gpios,
+						 pdata->num_line_gpios, NULL,
+						 input_dev);
+		if (err) {
+			dev_err(&pdev->dev, "failed to build keymap for reduced mode\n");
+			goto err_free_mem;
+		}
+	} else {
+		err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
+						 pdata->num_row_gpios,
+						 pdata->num_col_gpios, NULL,
+						 input_dev);
+		if (err) {
+			dev_err(&pdev->dev, "failed to build keymap for generic mode\n");
+			goto err_free_mem;
+		}
 	}
 
 	if (!pdata->no_autorepeat)
@@ -506,9 +907,13 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(input_dev, keypad);
 
-	err = matrix_keypad_init_gpio(pdev, keypad);
-	if (err)
-		goto err_free_mem;
+	if (pdata->mode == REDUCED) {
+		button_hdl_init(keypad);
+	} else {
+		err = matrix_keypad_init_gpio(pdev, keypad);
+		if (err)
+			goto err_free_mem;
+	}
 
 	err = input_register_device(keypad->input_dev);
 	if (err)
@@ -538,14 +943,6 @@ static int matrix_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id matrix_keypad_dt_match[] = {
-	{ .compatible = "gpio-matrix-keypad" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, matrix_keypad_dt_match);
-#endif
-
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
 	.remove		= matrix_keypad_remove,
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 8ad7d4626e62..d5ba9ec21752 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -6,18 +6,22 @@
 #include <linux/input.h>
 #include <linux/of.h>
 
-#define MATRIX_MAX_ROWS		32
-#define MATRIX_MAX_COLS		32
+#define MATRIX_MAX_ROWS 32
+#define MATRIX_MAX_COLS 32
 
-#define KEY(row, col, val)	((((row) & (MATRIX_MAX_ROWS - 1)) << 24) |\
-				 (((col) & (MATRIX_MAX_COLS - 1)) << 16) |\
-				 ((val) & 0xffff))
+#define KEY(row, col, val)                                                     \
+	((((row) & (MATRIX_MAX_ROWS - 1)) << 24) |                             \
+	 (((col) & (MATRIX_MAX_COLS - 1)) << 16) | ((val)&0xffff))
 
-#define KEY_ROW(k)		(((k) >> 24) & 0xff)
-#define KEY_COL(k)		(((k) >> 16) & 0xff)
-#define KEY_VAL(k)		((k) & 0xffff)
+#define KEY_ROW(k) (((k) >> 24) & 0xff)
+#define KEY_COL(k) (((k) >> 16) & 0xff)
+#define KEY_VAL(k) ((k)&0xffff)
 
-#define MATRIX_SCAN_CODE(row, col, row_shift)	(((row) << (row_shift)) + (col))
+#define MATRIX_SCAN_CODE(row, col, row_shift) (((row) << (row_shift)) + (col))
+#define KEYCODE(keymap) (keymap & 0xFFFF)
+
+#define GENERIC (1) /* keypad mode generic */
+#define REDUCED (2) /* keypad mode reduced */
 
 /**
  * struct matrix_keymap_data - keymap for matrix keyboards
@@ -30,7 +34,7 @@
  */
 struct matrix_keymap_data {
 	const uint32_t *keymap;
-	unsigned int	keymap_size;
+	unsigned int keymap_size;
 };
 
 /**
@@ -38,6 +42,7 @@ struct matrix_keymap_data {
  * @keymap_data: pointer to &matrix_keymap_data
  * @row_gpios: pointer to array of gpio numbers representing rows
  * @col_gpios: pointer to array of gpio numbers reporesenting colums
+ * @desc_gpios: actual number of gpio used devide in reduced mode
  * @num_row_gpios: actual number of row gpios used by device
  * @num_col_gpios: actual number of col gpios used by device
  * @col_scan_delay_us: delay, measured in microseconds, that is
@@ -46,6 +51,12 @@ struct matrix_keymap_data {
  * @clustered_irq: may be specified if interrupts of all row/column GPIOs
  *	are bundled to one single irq
  * @clustered_irq_flags: flags that are needed for the clustered irq
+ * @num_line_gpios: actual number of gpio line in reduced mode
+ * @num_of_buttons: number of physical buttons on keypad
+ *	in reduced mode
+ * @poll_interval_ms: interval to poll gpio in reduced mode
+ * @keycode: hold the keycode value
+ * @mode: flag to set mode
  * @active_low: gpio polarity
  * @wakeup: controls whether the device should be set up as wakeup
  *	source
@@ -61,32 +72,37 @@ struct matrix_keypad_platform_data {
 
 	struct gpio_desc **row_gpios;
 	struct gpio_desc **col_gpios;
+	struct gpio_desc **desc_gpios;
 
-	unsigned int	num_row_gpios;
-	unsigned int	num_col_gpios;
+	unsigned int num_row_gpios;
+	unsigned int num_col_gpios;
 
-	unsigned int	col_scan_delay_us;
+	unsigned int col_scan_delay_us;
 
 	/* key debounce interval in milli-second */
-	unsigned int	debounce_ms;
+	unsigned int debounce_ms;
+
+	unsigned int clustered_irq;
+	unsigned int clustered_irq_flags;
+	unsigned int num_line_gpios;
+	unsigned int num_of_buttons;
+	unsigned int poll_interval_ms;
 
-	unsigned int	clustered_irq;
-	unsigned int	clustered_irq_flags;
+	int8_t *keycode;
+	int8_t mode;
 
-	bool		active_low;
-	bool		wakeup;
-	bool		no_autorepeat;
-	bool		drive_inactive_cols;
+	bool active_low;
+	bool wakeup;
+	bool no_autorepeat;
+	bool drive_inactive_cols;
 };
 
 int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
-			       const char *keymap_name,
-			       unsigned int rows, unsigned int cols,
-			       unsigned short *keymap,
+			       const char *keymap_name, unsigned int rows,
+			       unsigned int cols, unsigned short *keymap,
 			       struct input_dev *input_dev);
-int matrix_keypad_parse_properties(struct device *dev,
-				   unsigned int *rows, unsigned int *cols);
-
+int matrix_keypad_parse_properties(struct device *dev, unsigned int *rows,
+				   unsigned int *cols);
 #define matrix_keypad_parse_of_params matrix_keypad_parse_properties
 
 #endif /* _MATRIX_KEYPAD_H */
-- 
2.20.1

