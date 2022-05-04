Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8012E519D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348429AbiEDK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348313AbiEDK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:57:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0550D2655B;
        Wed,  4 May 2022 03:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNZE/CYqEkZFeuG5P4rVi3t+sdK4stYrnn5t5cu+9NPaVLgsGKUwCL6C9OMi0l2obGf6xB9RKmlcHi7SZITfO0W+55YsOtwnUOu39dR4ZDLpltklThtxzOl862sUoGys8zdkFDPGoyeLlJmjfXGZUmVo9StagDLMBRrDUx2gP95gwH4cp+NMYay/J9FR4u+3bXi9Z86HKlKFzWYZt64AWo7eV0HxJUzesT+XoE0zOoAIq+UHLwH2M5KbFe6ZBTgqdU/Pdr08WYtmohBLvr4UOj6QPQEg7vTfHLoSx2bbPuObVktjwB1Z43eGA/GkqnaRZIr2k1G/Cgf9g4L1Uxy3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5RZHOkRXBlYIxIn9v0R9x6IIQgHpI82NE1vHKj5aLk=;
 b=gi6zUdvEGxQONKKDzmokfVfuxPpvrt+LJHYbVJ9BAa5jsBO1cG2ePNymL9q2ZL3PhWZTAZpHmx6fovLu819JFZLFqTBXBwhmZz8ym4swq5Azk/cdviUeV7fopQfeGiVFM9exvFk8jld8izm/+TN21MhRIlwQG1fNny24BzWMDgVjqzyqlYOoyEKxKTbwFMFomMXbED59HW7vkWztQ+O6NqV5Hp80KUMhc6T6WOYhirU2qpE8TTEEavQwo5cPu3XW3SP5Qc2kEjb+4krHJlCLT5eDK9l9qLl2NEeUGd+PST5H7PxZ1d3RppFYHdUj1XKmxmwBodO3/e8Jm280DQvpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5RZHOkRXBlYIxIn9v0R9x6IIQgHpI82NE1vHKj5aLk=;
 b=ln3Xy5pBvqOBvDcx5awIBgZQOixI96blHcCa/BX+EUxdACph2BOXk8AGlzxlctQIc0uHc0prpxXDOKkIYWfY0+bhTKEKHptLyYVO/1JXpaBDzspqYY0hpDgEE6ddoO1UDXbj3eFZgSxnXPOAgoF6VAhm/LCb9vnSHwujoB3RZjc=
Received: from AM0PR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::18) by PAXPR10MB4875.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:202::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 10:53:25 +0000
Received: from VE1EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:168:cafe::93) by AM0PR01CA0113.outlook.office365.com
 (2603:10a6:208:168::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Wed, 4 May 2022 10:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT023.mail.protection.outlook.com (10.152.18.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 10:53:25 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Wed, 4 May
 2022 12:53:20 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Wed, 4 May 2022 12:53:19 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Wed, 4 May 2022
 12:53:16 +0200
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
Subject: [PATCH 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad driver
Date:   Wed, 4 May 2022 10:52:52 +0000
Message-ID: <20220504105254.1576-2-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220504105254.1576-1-Gireesh.Hiremath@in.bosch.com>
References: <20220504105254.1576-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba412d6-5839-49ba-71be-08da2dbc5058
X-MS-TrafficTypeDiagnostic: PAXPR10MB4875:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB4875296F7A7DDDB80AD39A34A6C39@PAXPR10MB4875.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCWPiTPZpKkbaow/Po75BusbUUGqWVINhgVdpPMQNT8QTtbxUM8qbFtCYK5f+jA4vszH1M91zLNL5xlVjKMt8zdV4kL+Br5VM3EazECkrBfXIDn076UvkLDy3bEd/i3wUVLvIanlNacPEBhINUPB5npfDM+OyoCngIHYaA6ZQ4lAeMFGvxFcm05CbkikwZcDO9tNx6U+6uEP7exKYE3XThrcROkSrrqZ1l7G/iV9ESIu19gUDvQ56drXgot0EAcFtBDuDJVXeXF9T15gMZlYrYZuQxBi1NPS5Q2hCETNX8AhtInD09bJWnIK6LMqc2Q5XRe5xoMZy0TYGvM+GBt4g7nTULMmXCz7lnLjlikK+VD3IUkhf99KlByRl1OPcTeTJD9jHgvngM4ZmL2Qze8qcHnYl7w1XNOBSTqhAOm9AWcaQ+ugYAd93CpXRJQM2ni4EuT/ellq/xqycwmE5s2e4vB/P0NvtYKYJk7SdoGcdKIO81yGu4Rfi1ELT+Zxxwvsgj8F7yIqKUUeYgbsYALWwe5/nH8wtzrwcma0jmeylWnkCZkB0Kp7GNVgw8asrQ6CWkVztSr8lNUBnECdEFr+GsbPDoZY7XSlsolwcJxPYhClDpz2CXD2e/5lBpjtRdXoqIjHRt6varuWlSj7aey9iV3MQuBmTQbBR2/I2m+bwTpX0/1jlIh7p4fz6nkJb/rVj7ffSYS7lSoXlJ5cgA9V4KoV/12BvFQ0vSg8Tm0aiws=
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(8936002)(316002)(16526019)(5660300002)(336012)(36860700001)(2906002)(2876002)(186003)(26005)(30864003)(54906003)(6666004)(110136005)(86362001)(508600001)(7416002)(82960400001)(107886003)(83380400001)(7049001)(82310400005)(1076003)(2616005)(356005)(921005)(40460700003)(81166007)(4326008)(8676002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 10:53:25.0327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba412d6-5839-49ba-71be-08da2dbc5058
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4875
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

add support for keypad driver running on Bosch Guardian
Dtect board using TI-am335x cpu. Driver implementation
is based on matrix_keypad.c

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 drivers/input/keyboard/Kconfig            |  10 +
 drivers/input/keyboard/Makefile           |   1 +
 drivers/input/keyboard/mt_matrix_keypad.c | 741 ++++++++++++++++++++++
 include/linux/input/mt_matrix_keypad.h    |  63 ++
 4 files changed, 815 insertions(+)
 create mode 100644 drivers/input/keyboard/mt_matrix_keypad.c
 create mode 100644 include/linux/input/mt_matrix_keypad.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4ea79db8f134..a55ee8656194 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -303,6 +303,16 @@ config KEYBOARD_MATRIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called matrix_keypad.
 
+config KEYBOARD_MT_MATRIX
+        tristate "GPIO driven MT matrix keypad support"
+        depends on GPIOLIB || COMPILE_TEST
+        help
+	  This driver enable support for GPIO driven
+	  mt matrix keypad.
+
+          To compile this driver as a module, choose M here: the
+          module will be called mt_matrix_keypad.
+
 config KEYBOARD_HIL_OLD
 	tristate "HP HIL keyboard support (simple driver)"
 	depends on GSC || HP300
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 721936e90290..c7686d338b5d 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
+obj-$(CONFIG_KEYBOARD_MT_MATRIX)	+= mt_matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
 obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
diff --git a/drivers/input/keyboard/mt_matrix_keypad.c b/drivers/input/keyboard/mt_matrix_keypad.c
new file mode 100644
index 000000000000..9310faf8b237
--- /dev/null
+++ b/drivers/input/keyboard/mt_matrix_keypad.c
@@ -0,0 +1,741 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  GPIO driven mt matrix keyboard driver
+ *
+ *  Copyright (c) 2008 Marek Vasut <marek.vasut@gmail.com>
+ *  Copyright (c) 2017 vinay <VinayKumar.Shettar@in.bosch.com>
+ *
+ *  Based on matrix_keypad.c
+ *
+ */
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/input/mt_matrix_keypad.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+
+#define MODULE_NAME "mt-matrix-keypad"
+
+struct mt_matrix_keypad {
+	struct mt_matrix_keypad_platform_data *pdata;
+	struct input_dev *input_dev;
+
+	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
+
+	struct delayed_work work;
+	spinlock_t lock;
+	bool scan_pending;
+	bool stopped;
+	bool gpio_all_disabled;
+};
+
+static bool
+get_gpio_line_value(const struct mt_matrix_keypad_platform_data *pdata,
+		    int row);
+static void
+activate_line_driving(const struct mt_matrix_keypad_platform_data *pdata,
+		      int line, bool on);
+
+void init_phase(struct mt_matrix_keypad_platform_data *pdata)
+{
+	pdata->phase_state.phase_prepare = -1;
+	pdata->phase_state.phase_start = 0;
+	pdata->phase_state.phase_update_button = pdata->num_line_gpios;
+}
+
+void button_init(struct button *btn, bool btn_hw_state, int key)
+{
+	btn->state.boPrevious = btn_hw_state;
+	btn->state.boCurrentStateOfHw = btn_hw_state;
+	btn->state.boCurrentStateOfSw = false;
+	btn->state.boCurrent = btn_hw_state;
+	btn->state.boEnabled = true;
+	btn->state.boStateAtInit = btn_hw_state;
+	btn->event.ui8Register = 0;
+	btn->key = key;
+}
+
+const struct button_states get_button_state(struct button *btn)
+{
+	return btn->state;
+}
+
+union typeEvent get_and_clear_events(struct button *btn)
+{
+	union typeEvent beTemp = btn->event;
+
+	btn->event.ui8Register = 0;
+
+	return beTemp;
+}
+
+uint8_t get_btn_index(struct mt_matrix_keypad_platform_data *pdata, int btn_key)
+{
+	uint8_t i;
+
+	for (i = 0; i < pdata->num_of_button; i++) {
+		if (pdata->button_array[i].key == btn_key)
+			break;
+	}
+	return i;
+}
+
+void set_btn_state_by_hw(struct button *btn, bool boButtonState)
+{
+	btn->state.boCurrentStateOfHw = boButtonState;
+}
+
+bool check_button_changes(struct button *btn)
+{
+	btn->state.boPrevious = btn->state.boCurrent;
+	btn->state.boCurrent =
+		btn->state.boCurrentStateOfHw || btn->state.boCurrentStateOfSw;
+
+	/* Check if Button is pressed */
+	if ((btn->state.boPrevious == false) &&
+	    (btn->state.boCurrent == true)) {
+		btn->event.status.boPressed = true;
+	}
+
+	/* Check if Button is released */
+	else if ((btn->state.boPrevious == true) &&
+		 (btn->state.boCurrent == false)) {
+		btn->event.status.boReleased = true;
+	}
+
+	if (btn->event.ui8Register != 0)
+		btn->event.status.boGlobalChanged = true;
+
+	return btn->event.status.boGlobalChanged;
+}
+
+const struct button_states
+get_btn_id_state(const struct mt_matrix_keypad_platform_data *pdata,
+		 int btn_index)
+{
+	if (btn_index < pdata->num_of_button)
+		return get_button_state(&pdata->button_array[btn_index]);
+	else
+		return get_button_state(&pdata->button_array[0]);
+}
+
+union typeEvent
+get_and_clear_btn_events(const struct mt_matrix_keypad_platform_data *pdata,
+			 int btn_index)
+{
+	if (btn_index < pdata->num_of_button)
+		return get_and_clear_events(&pdata->button_array[btn_index]);
+	else
+		return get_and_clear_events(&pdata->button_array[0]);
+}
+
+void button_hdl_init(struct mt_matrix_keypad_platform_data *pdata)
+{
+	int row, col, index;
+	int i;
+
+	pdata->scan_phase = pdata->phase_state.phase_prepare;
+	pdata->intialize_buttons = true;
+
+	/* Init Button Objects, will be reinited once states are captured */
+	i = 0;
+	for (row = 1; row < pdata->num_line_gpios; row++)
+		for (col = 0; col < row; col++) {
+			index = (row * pdata->num_line_gpios) + col;
+			if (pdata->button_matrix[index] !=
+			    pdata->button_matrix[0]) {
+				if (i < pdata->num_of_button) {
+					button_init(
+						&pdata->button_array[i], false,
+						pdata->button_matrix[index]);
+					i++;
+				}
+			}
+		}
+
+	pr_debug("[%s]: %s Done\n", MODULE_NAME, __func__);
+}
+
+bool on_button_event(const struct mt_matrix_keypad_platform_data *pdata,
+		     int btn_index, union typeEvent btn_event,
+		     struct input_dev *input_dev)
+{
+	bool any_btn_served = true;
+	unsigned int key_code = 0;
+	int key_value = 0;
+
+	key_code = pdata->button_array[btn_index].key;
+
+	if (btn_event.status.boPressed) {
+		key_value = 1;
+		pr_debug("[%s]:%d Pressed\n", MODULE_NAME, key_code);
+	}
+
+	if (btn_event.status.boReleased) {
+		key_value = 0;
+		pr_debug("[%s]:%d Released\n", MODULE_NAME, key_code);
+	}
+
+	input_report_key(input_dev, key_code, key_value);
+	input_sync(input_dev);
+	return any_btn_served;
+}
+
+void process_button_events(const struct mt_matrix_keypad_platform_data *pdata,
+			   struct input_dev *input_dev)
+{
+	int btn_index;
+	bool any_btn_served = false;
+
+	for (btn_index = 0; btn_index < pdata->num_of_button; btn_index++) {
+		const union typeEvent beEvent =
+			get_and_clear_btn_events(pdata, (int)btn_index);
+
+		if (beEvent.status.boGlobalChanged) {
+			const struct button_states bsState =
+				get_btn_id_state(pdata, (int)btn_index);
+
+			if (bsState.boEnabled) {
+				any_btn_served |=
+					on_button_event(pdata, (int)btn_index,
+							beEvent, input_dev);
+			}
+		}
+	}
+}
+
+void update_buttons(struct mt_matrix_keypad_platform_data *pdata,
+		    struct input_dev *input_dev)
+{
+	if (pdata->scan_phase == pdata->phase_state.phase_prepare) {
+		pdata->scan_phase = pdata->phase_state.phase_start;
+		activate_line_driving(pdata, (int)pdata->scan_phase, true);
+	} else if (pdata->scan_phase ==
+		   pdata->phase_state.phase_update_button) {
+		bool btn_changes_occured = false;
+		int btn_index;
+
+		if (pdata->intialize_buttons) {
+			int i;
+
+			pdata->intialize_buttons = false;
+
+			for (i = 0; i < pdata->num_of_button; i++) {
+				const bool btn_curr_hw_state =
+					get_button_state(
+						&pdata->button_array[i])
+						.boCurrentStateOfHw;
+				button_init(&pdata->button_array[i],
+					    btn_curr_hw_state,
+					    pdata->button_array[i].key);
+			}
+		}
+
+		for (btn_index = 0; btn_index < pdata->num_of_button;
+		     btn_index++) {
+			btn_changes_occured |= check_button_changes(
+				&pdata->button_array[btn_index]);
+		}
+
+		if (btn_changes_occured)
+			process_button_events(pdata, input_dev);
+
+		pdata->scan_phase = pdata->phase_state.phase_start;
+	} else {
+		uint8_t *btn_keylines;
+		uint8_t number_of_buttons_pressed = 0;
+		uint8_t btn_index;
+		uint8_t btn_key;
+		uint16_t index;
+		int i;
+
+		btn_keylines = kcalloc(pdata->num_line_gpios, sizeof(uint8_t),
+				       GFP_KERNEL);
+		for (i = 0; i < pdata->num_line_gpios; i++) {
+			index = (pdata->scan_phase * pdata->num_line_gpios) + i;
+			btn_key = pdata->button_matrix[index];
+			btn_keylines[i] = false;
+
+			if ((btn_key != pdata->button_matrix[0]) &&
+			    (get_gpio_line_value(pdata, (int)i) != false)) {
+				btn_keylines[i] = true;
+				number_of_buttons_pressed++;
+			}
+		}
+		if (number_of_buttons_pressed < 2) {
+			for (i = 0; i < pdata->num_line_gpios; i++) {
+				index = (pdata->scan_phase *
+					 pdata->num_line_gpios) +
+					i;
+				btn_key = pdata->button_matrix[index];
+				if (btn_key != pdata->button_matrix[0]) {
+					btn_index =
+						get_btn_index(pdata, btn_key);
+					set_btn_state_by_hw(
+						&pdata->button_array[btn_index],
+						btn_keylines[i]);
+				}
+			}
+		}
+
+		kfree(btn_keylines);
+		activate_line_driving(pdata, (int)pdata->scan_phase, false);
+		pdata->scan_phase++;
+		activate_line_driving(
+			pdata, (int)(pdata->scan_phase % pdata->num_line_gpios),
+			true);
+	}
+}
+
+/*
+ * NOTE: normally the GPIO has to be put into HiZ when de-activated to cause
+ * minmal side effect when scanning other columns, here it is configured to
+ * be input, and it should work on most platforms.
+ */
+static void
+__activate_line_driving(const struct mt_matrix_keypad_platform_data *pdata,
+			int line, bool on)
+{
+	bool level_on = pdata->active_low;
+
+	if (on)
+		gpio_direction_output(pdata->line_gpios[line], level_on);
+	else
+		gpio_direction_input(pdata->line_gpios[line]);
+}
+
+static void
+activate_line_driving(const struct mt_matrix_keypad_platform_data *pdata,
+		      int line, bool on)
+{
+	__activate_line_driving(pdata, line, on);
+
+	if (on && pdata->col_scan_delay_us)
+		udelay(pdata->col_scan_delay_us);
+}
+
+static bool
+get_gpio_line_value(const struct mt_matrix_keypad_platform_data *pdata, int row)
+{
+	return gpio_get_value(pdata->line_gpios[row]) ? pdata->active_low :
+							!pdata->active_low;
+}
+
+/*
+ * This gets the keys from keyboard and reports it to input subsystem
+ */
+static void mt_matrix_keypad_scan(struct work_struct *work)
+{
+	struct mt_matrix_keypad *keypad =
+		container_of(work, struct mt_matrix_keypad, work.work);
+	struct input_dev *input_dev = keypad->input_dev;
+	struct mt_matrix_keypad_platform_data *pdata = keypad->pdata;
+
+	if (keypad->stopped == false) {
+		update_buttons(pdata, input_dev);
+		schedule_delayed_work(
+			&keypad->work,
+			msecs_to_jiffies(keypad->pdata->debounce_ms));
+	}
+}
+
+static int mt_matrix_keypad_start(struct input_dev *dev)
+{
+	struct mt_matrix_keypad *keypad = input_get_drvdata(dev);
+
+	keypad->stopped = false;
+	/*
+	 * memory access initiated before the memory barrier
+	 * will be complete before passing the barrier
+	 */
+	mb();
+
+	/*
+	 * Schedule an immediate key scan to capture current key state;
+	 * columns will be activated and IRQs be enabled after the scan.
+	 */
+	schedule_delayed_work(&keypad->work, 0);
+
+	return 0;
+}
+
+static void mt_matrix_keypad_stop(struct input_dev *dev)
+{
+	struct mt_matrix_keypad *keypad = input_get_drvdata(dev);
+
+	keypad->stopped = true;
+	/*
+	 * memory access initiated before the memory barrier
+	 * will be complete before passing the barrier
+	 */
+	mb();
+	cancel_delayed_work_sync(&keypad->work);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void mt_matrix_keypad_enable_wakeup(struct mt_matrix_keypad *keypad)
+{
+	const struct mt_matrix_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int gpio;
+	int i;
+
+	if (pdata->clustered_irq > 0) {
+		if (enable_irq_wake(pdata->clustered_irq) == 0)
+			keypad->gpio_all_disabled = true;
+	} else {
+		for (i = 0; i < pdata->num_line_gpios; i++) {
+			if (!test_bit(i, keypad->disabled_gpios)) {
+				gpio = pdata->line_gpios[i];
+
+				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
+					__set_bit(i, keypad->disabled_gpios);
+			}
+		}
+	}
+}
+
+static void mt_matrix_keypad_disable_wakeup(struct mt_matrix_keypad *keypad)
+{
+	const struct mt_matrix_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int gpio;
+	int i;
+
+	if (pdata->clustered_irq > 0) {
+		if (keypad->gpio_all_disabled) {
+			disable_irq_wake(pdata->clustered_irq);
+			keypad->gpio_all_disabled = false;
+		}
+	} else {
+		for (i = 0; i < pdata->num_line_gpios; i++) {
+			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
+				gpio = pdata->line_gpios[i];
+				disable_irq_wake(gpio_to_irq(gpio));
+			}
+		}
+	}
+}
+
+static int mt_matrix_keypad_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mt_matrix_keypad *keypad = platform_get_drvdata(pdev);
+
+	mt_matrix_keypad_stop(keypad->input_dev);
+
+	if (device_may_wakeup(&pdev->dev))
+		mt_matrix_keypad_enable_wakeup(keypad);
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int mt_matrix_keypad_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mt_matrix_keypad *keypad = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&pdev->dev))
+		mt_matrix_keypad_disable_wakeup(keypad);
+
+	pinctrl_pm_select_default_state(dev);
+
+	mt_matrix_keypad_start(keypad->input_dev);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mt_matrix_keypad_pm_ops, mt_matrix_keypad_suspend,
+			 mt_matrix_keypad_resume);
+
+static int mt_matrix_keypad_init_gpio(struct platform_device *pdev,
+				      struct mt_matrix_keypad *keypad)
+{
+	const struct mt_matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i, err;
+
+	for (i = 0; i < pdata->num_line_gpios; i++) {
+		err = gpio_request(pdata->line_gpios[i], "mt_kbd_row");
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to request GPIO%d for ROW%d\n",
+				pdata->line_gpios[i], i);
+			goto err_free_rows;
+		}
+
+		gpio_direction_input(pdata->line_gpios[i]);
+	}
+
+	return 0;
+
+err_free_rows:
+	while (--i >= 0)
+		gpio_free(pdata->line_gpios[i]);
+
+	i = pdata->num_line_gpios;
+	return err;
+}
+
+static void mt_matrix_keypad_free_gpio(struct mt_matrix_keypad *keypad)
+{
+	const struct mt_matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	for (i = 0; i < pdata->num_line_gpios; i++)
+		gpio_free(pdata->line_gpios[i]);
+}
+
+#ifdef CONFIG_OF
+static struct mt_matrix_keypad_platform_data *
+mt_matrix_keypad_parse_dt(struct device *dev)
+{
+	struct mt_matrix_keypad_platform_data *pdata = NULL;
+	struct device_node *np = dev->of_node;
+	unsigned int *gpios;
+	struct button *button_array;
+	int8_t *button_matrix;
+	uint16_t keycode;
+	uint32_t *ptr;
+	int keymap;
+	int i;
+
+	if (!np) {
+		dev_err(dev, "device lacks DT data\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->num_line_gpios = of_gpio_named_count(np, "line-gpios");
+	if (pdata->num_line_gpios <= 0) {
+		dev_err(dev, "number of gpio line not specified\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_get_property(np, "linux,no-autorepeat", NULL))
+		pdata->no_autorepeat = true;
+
+	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
+			of_property_read_bool(np, "linux,wakeup"); /* legacy */
+
+	if (of_get_property(np, "gpio-activelow", NULL))
+		pdata->active_low = true;
+
+	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
+	of_property_read_u32(np, "col-scan-delay-us",
+			     &pdata->col_scan_delay_us);
+	of_property_read_u32(np, "number-of-button", &pdata->num_of_button);
+	if (pdata->num_of_button <= 0) {
+		dev_err(dev, "number of button not specified\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	button_array =
+		devm_kzalloc(dev,
+			     sizeof(struct button) * (pdata->num_of_button),
+			     GFP_KERNEL);
+	if (!button_array) {
+		dev_err(dev, "could not allocate memory for button array\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pdata->button_array = button_array;
+
+	gpios = devm_kzalloc(dev,
+			     sizeof(unsigned int) * (pdata->num_line_gpios),
+			     GFP_KERNEL);
+	if (!gpios) {
+		dev_err(dev, "could not allocate memory for gpios\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < pdata->num_line_gpios; i++)
+		gpios[i] = of_get_named_gpio(np, "line-gpios", i);
+
+	pdata->line_gpios = gpios;
+
+	keymap = device_property_count_u32(dev, "linux,keymap");
+	if (keymap <= 0 ||
+	    keymap > (pdata->num_line_gpios * pdata->num_line_gpios)) {
+		dev_err(dev, "linux,keymap property count is more");
+		return ERR_PTR(-ENXIO);
+	}
+
+	ptr = kcalloc(keymap, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	if (device_property_read_u32_array(dev, "linux,keymap", ptr, keymap)) {
+		dev_err(dev, "problem parsing keymap property\n");
+		kfree(ptr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	button_matrix =
+		devm_kzalloc(dev, (keymap * sizeof(int8_t)), GFP_KERNEL);
+	if (!button_matrix) {
+		dev_err(dev, "could not allocate memory for button matrix\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pdata->button_matrix = button_matrix;
+	for (i = 0; i < keymap; i++) {
+		keycode = KEYCODE(ptr[i]);
+		pdata->button_matrix[i] = keycode;
+	}
+	kfree(ptr);
+
+	return pdata;
+}
+
+#else
+static inline struct mt_matrix_keypad_platform_data *
+mt_matrix_keypad_parse_dt(struct device *dev)
+{
+	dev_err(dev, "no platform data defined\n");
+
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
+static int mt_matrix_keypad_probe(struct platform_device *pdev)
+{
+	struct mt_matrix_keypad_platform_data *pdata;
+	struct mt_matrix_keypad *keypad;
+	struct input_dev *input_dev;
+	int err;
+	int row, col, index;
+
+	dev_info(&pdev->dev, "[%s]: Probe\n", MODULE_NAME);
+	pdata = dev_get_platdata(&pdev->dev);
+
+	if (!pdata) {
+		pdata = mt_matrix_keypad_parse_dt(&pdev->dev);
+		if (IS_ERR(pdata)) {
+			dev_err(&pdev->dev, "Mt platform data not defined\n");
+			return PTR_ERR(pdata);
+		}
+	}
+
+	err = pdata->line_gpios[0];
+	if (err < 0)
+		return dev_err_probe(
+			&pdev->dev, err,
+			"Could not register gpio chip for mt matrix keypad\n");
+
+	keypad = kzalloc(sizeof(struct mt_matrix_keypad), GFP_KERNEL);
+	input_dev = input_allocate_device();
+
+	if (!keypad || !input_dev) {
+		dev_err(&pdev->dev, "[%s]: Allocation Failed\n", MODULE_NAME);
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	init_phase(pdata);
+	keypad->input_dev = input_dev;
+	keypad->pdata = pdata;
+	keypad->stopped = true;
+	INIT_DELAYED_WORK(&keypad->work, mt_matrix_keypad_scan);
+	spin_lock_init(&keypad->lock);
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->open = mt_matrix_keypad_start;
+	input_dev->close = mt_matrix_keypad_stop;
+
+	if (!pdata->no_autorepeat)
+		__set_bit(EV_REP, input_dev->evbit);
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+
+	for (row = 1; row < pdata->num_line_gpios; row++) {
+		for (col = 0; col < row; col++) {
+			index = (row * pdata->num_line_gpios) + col;
+			if (pdata->button_matrix[index] !=
+			    pdata->button_matrix[0]) {
+				input_set_capability(
+					input_dev, EV_KEY,
+					pdata->button_matrix[index]);
+			}
+		}
+	}
+
+	input_set_drvdata(input_dev, keypad);
+	err = mt_matrix_keypad_init_gpio(pdev, keypad);
+
+	if (err)
+		goto err_free_mem;
+
+	button_hdl_init(pdata);
+
+	err = input_register_device(keypad->input_dev);
+
+	if (err)
+		goto err_free_gpio;
+
+	device_init_wakeup(&pdev->dev, pdata->wakeup);
+	platform_set_drvdata(pdev, keypad);
+
+	return 0;
+
+err_free_gpio:
+	mt_matrix_keypad_free_gpio(keypad);
+
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(keypad);
+	return err;
+}
+
+static int mt_matrix_keypad_remove(struct platform_device *pdev)
+{
+	struct mt_matrix_keypad *keypad = platform_get_drvdata(pdev);
+
+	device_init_wakeup(&pdev->dev, 0);
+	input_unregister_device(keypad->input_dev);
+	mt_matrix_keypad_free_gpio(keypad);
+	kfree(keypad);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mt_matrix_keypad_dt_match[] = {
+	{ .compatible = "gpio-mt-matrix-keypad" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt_matrix_keypad_dt_match);
+#endif
+
+static struct platform_driver mt_matrix_keypad_driver = {
+	.probe		= mt_matrix_keypad_probe,
+	.remove		= mt_matrix_keypad_remove,
+	.driver		= {
+		.name	= "mt-matrix-keypad",
+		.pm	= &mt_matrix_keypad_pm_ops,
+		.of_match_table = of_match_ptr(mt_matrix_keypad_dt_match),
+	},
+};
+module_platform_driver(mt_matrix_keypad_driver);
+
+MODULE_AUTHOR("vinay");
+MODULE_DESCRIPTION("GPIO Driven Mt Matrix Keypad Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mt-matrix-keypad");
diff --git a/include/linux/input/mt_matrix_keypad.h b/include/linux/input/mt_matrix_keypad.h
new file mode 100644
index 000000000000..8c5fbf109dbc
--- /dev/null
+++ b/include/linux/input/mt_matrix_keypad.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MT_MATRIX_KEYPAD_H
+#define _MT_MATRIX_KEYPAD_H
+
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/of.h>
+
+#define MATRIX_MAX_ROWS 32
+#define KEYCODE(keymap) (keymap & 0xFFFF)
+
+struct button_states {
+	uint8_t boPrevious : 1;
+	uint8_t boCurrent : 1;
+	uint8_t boCurrentStateOfHw : 1;
+	uint8_t boCurrentStateOfSw : 1;
+	uint8_t boEnabled : 1;
+	uint8_t boStateAtInit : 1;
+};
+
+union typeEvent {
+	uint8_t ui8Register;
+	struct {
+		uint8_t boGlobalChanged : 1;
+		uint8_t boPressed : 1;
+		uint8_t boReleased : 1;
+	} status;
+};
+
+struct button {
+	uint8_t key;
+	union typeEvent event;
+	struct button_states state;
+};
+
+struct phase {
+	int phase_prepare;
+	int phase_start;
+	int phase_update_button;
+};
+
+struct mt_matrix_keypad_platform_data {
+	const struct mt_keymap_data *keymap_data;
+	const unsigned int *line_gpios;
+	unsigned int num_line_gpios;
+	unsigned int num_of_button;
+	unsigned int col_scan_delay_us;
+	unsigned int debounce_ms;
+	unsigned int clustered_irq;
+	unsigned int clustered_irq_flags;
+
+	bool active_low;
+	bool wakeup;
+	bool no_autorepeat;
+	bool intialize_buttons;
+
+	int8_t scan_phase;
+	int8_t *button_matrix;
+	struct button *button_array;
+	struct phase phase_state;
+};
+
+#endif /* _MT_MATRIX_KEYPAD_H */
-- 
2.20.1

