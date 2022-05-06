Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8151D24C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389556AbiEFHdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389530AbiEFHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:32:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A866FA4;
        Fri,  6 May 2022 00:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHGbgVHy22B5m0rmW1fXFbIbYo00oxGMhp/3n3Nca3gOIzXdxtFuc1/vUjanJ1BQ9Xuj1DYCA6+z2lm+ZqOMw92/FIi6xBVAsEwjQ/wY3ymFRAZx1H6WRPiQqF5U5FRwZspusf2gEFX/pf6oIzLXnJGRdOGpSmI+YKsOiUF1BLwzB8DAbXYYI3KRsA+cHt9u9NSnpeLhEwzYKVNaLbbgQc3oB4vIRwpwzLcg/XS4k9SbWUh50dRSmEjQ1+Rl+6fzNU+CNFhGisx5ZSWOzgjEV11N60uMjK+OSxKDLzyNTztsZ3PyO+QDIL1bPWeHQlDEHy6R+cdGIEWSxfay1GUnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8z00E7ZdFiRUl9Fd1jKHeOcRV4DCnmrn9eYMdtP8IA=;
 b=KuhWXymuHdVoacMXbLD2TQ3bJhgWnSWnwQK2ySOSIdF6C0pcrzFayiHnJG5yGeO/N9Rd+ewU2n43HTWRV07pPiZFhoEb96gwK8GPvE0zcKLi1LbfjxXkQpV5qwRketk2B3svIJNbJD7UmhTOtmcRmGAIqmqaf9ULYvqsV8y4L7QcJuB2oZtNz05PhFlNODRUx+1qCqLvd6++2bguMWM7oyGZHt0ZLvMR3FJlNDGEMwCDS7mYO4hn/YLvT3zzmdLcLwF3A/1yxeLP4VWC0D3o3myimBekmXUIcitu1tFttPaFibDG5Bpgjegj3X5MlU8gQVz4TuWqlFY587sGDtFFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8z00E7ZdFiRUl9Fd1jKHeOcRV4DCnmrn9eYMdtP8IA=;
 b=aqGgyt0+reTBmiIqoVJFptSTIPM4/aYVKRfYht/RJwaQnF0ZtQj+IWC3RMFjVVPQKF/T4UK47e3NSObseyzVxNVJSP9brTeVdYUc8q4/v1cEZUcCHOnAwMXyY48zJIqun9pZM8pMqRcW2BGkEDzmGvJccyukpYKB4L3MYbzXCVk=
Received: from AS9PR06CA0143.eurprd06.prod.outlook.com (2603:10a6:20b:467::20)
 by DB9PR10MB5908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Fri, 6 May
 2022 07:29:12 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:467:cafe::ac) by AS9PR06CA0143.outlook.office365.com
 (2603:10a6:20b:467::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18 via Frontend
 Transport; Fri, 6 May 2022 07:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.199) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 07:29:11 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 6 May
 2022 09:29:07 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 6 May 2022 09:29:07 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 6 May 2022
 09:29:02 +0200
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
Subject: [PATCH v2 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad driver
Date:   Fri, 6 May 2022 07:27:35 +0000
Message-ID: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
References: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14644c87-9770-48aa-e1cf-08da2f321da6
X-MS-TrafficTypeDiagnostic: DB9PR10MB5908:EE_
X-Microsoft-Antispam-PRVS: <DB9PR10MB5908426D9A3A9BF7D739FA7EA6C59@DB9PR10MB5908.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wqKfN+FX6YaKCyxzEB8+XQxZZUxzm4YPh2U9T4yZ4LanDrJhLafd6OoN07ormBw8fi8n7jhE5bM7mNP9MXy6isELD/2EHZo84mfy42eujo2qMWauOu1JLVxATnYYnXA7FifQAnDmdM9d/SGIaR+i5Zgs0/0lV0amxqtAEoPVGxlxY1dUsXxDfItBR0cQv9nCZI+uesWTMzZHy280+z6yXAX3JVDvDh0i5otqU8mInzYa2U/0ds6YHCOWhUWjaehmhZ4GX9Hi5jII1ekielN4Kt0AG89xOAZpCO7Sk82nnoHdqYuak3ggFzprE6GiyULGPEOobhvaN9owz9l/SIe6GvTIrw1DzMK/F7wEXYT627y11ZmgP6+eREjMuzFkvGvTIx/wHl7iN6CNZtStwKvqale1PBgdJAm3aSCeP7/AURHIFXo/BDNlgA3nTHohQWJaqzh+5bQBeRspaC4+t99uNEESgOxyYvVnYtAWHA/QgYTXGDq1KifuTv+CHBVu9geY4sjqcomRFlczYcPW4aHW3pZQkPi0c7bYjVVR7iYqizgsf+phia0YIJ6lghB8R370SDqqdClIM/YdxPbabb+owzsiFoRgKOdL3vQNp3onshebC6C3UcLWaIxWfGZcJ0mS4UDpHsoSoZFvfJ6/UtQ2g0+UsrXW9x1nMnfHlSHwkh9ukJUipJ5Lb181iNkJJkCZnQiJ8/toCtkeYqQYTNLjcuKuwt8kiMdDzx8Sg2YaAk=
X-Forefront-Antispam-Report: CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(107886003)(40460700003)(1076003)(2616005)(6666004)(508600001)(81166007)(5660300002)(86362001)(921005)(356005)(8676002)(70586007)(70206006)(82960400001)(4326008)(82310400005)(83380400001)(26005)(54906003)(30864003)(7416002)(110136005)(2906002)(2876002)(8936002)(316002)(16526019)(186003)(36860700001)(47076005)(336012)(7049001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:29:11.7911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14644c87-9770-48aa-e1cf-08da2f321da6
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5908
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Hi Marco,

Changes since v1: resolved compilation warnings

>On 22-05-04, Gireesh.Hiremath@in.bosch.com wrote:
>> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
>>
>> The existing matric_keypad.c use different gpio line for row and colunm,
>> where in mt_matrix_kepad.c use same gpio line for row as well as column.
>> a key can be placed at each intersection of a unique row number
>> not equal to a unique column and they are diagonally symmetric.
>> Advantage of this is with existed gpio line we can get more keys
>>
>> example: in matrix_keypad.c for 5 gpio line possible matrix is 2X3 or 3X2
>> and maximum possible keys are 6 but
>> in mt_matrix_kepad.c for same 5 gpio line possible matrix is 5X5 and maximum
>> possible buttons are 10, below table will discribe that
>
>Nobody should stop you to increase the amount of max. possible keys, so
>this isn't a real block.
>> 	------------------------------------------------------
>> 	|Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
>> 	------------------------------------------------------
>> 	| GPIO 0 |  X    | KEY_9  | KEY_2  | KEY_3  | KEY_1  |
>> 	------------------------------------------------------
>> 	| GPIO 1 | KEY_9 |  X     | KEY_6  | KEY_5  |  KEY_0 |
>> 	------------------------------------------------------
>> 	| GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
>> 	------------------------------------------------------
>> 	| GPIO 3 | KEY_3 | KEY_5  | KEY_4  |  X     | KEY_8  |
>> 	------------------------------------------------------
>> 	| GPIO 4 | KEY_1 |  KEY_0 | KEY_7  | KEY_8  |  X     |
>> 	------------------------------------------------------
>> 	X - invalid key
>> 	KEY_x - preferred key code
>
>That should be pointed somewhere very clearly, thanks for the
>description. Also what is than the benefit of the original matrix_keypad
>driver?

we have special keypad for Bosch measuring tools, which is not completely
matric keypad so we have derived from matrix_kepad.c to make our keypad
to work.

In this keypad there may or may not have keymap for all gpio line
as below

	------------------------------------------------------
	|Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
	------------------------------------------------------
	| GPIO 0 |  X    | KEY_9  | KEY_2  |  X     | KEY_1  |
	------------------------------------------------------
	| GPIO 1 | KEY_9 |  X     | KEY_6  |  X     |   X    |
	------------------------------------------------------
	| GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
	------------------------------------------------------
	| GPIO 3 |  X    |  X     | KEY_4  |  X     | KEY_8  |
	------------------------------------------------------
	| GPIO 4 | KEY_1 |  X     | KEY_7  | KEY_8  |  X     |
	------------------------------------------------------
   X - invalid key

example DTS

    line-gpios = <
             &gpio1 24 1     /*gpio_56*/
             &gpio1 23 1     /*gpio_55*/
             &gpio1 22 1     /*gpio_54*/
             &gpio1 20 1     /*gpio_52*/
             &gpio1 16 1     /*gpio_48*/
     >;
     linux,keymap = <
             0x00000000 /* row 0, col 0, KEY_RESERVED */
             0x0001000a /* row 0, col 1, KEY_9 */
             0x00020003 /* row 0, col 2, KEY_2 */
             0x00030000 /* row 0, col 3, KEY_RESERVED */
             0x00040002 /* row 0, col 4, KEY_1 */
             0x0100000a /* row 1, col 0, KEY_9 */
             0x01010000 /* row 1, col 1, KEY_RESERVED */
             0x01020007 /* row 1, col 2, KEY_6 */
             0x01030000 /* row 1, col 3, KEY_RESERVED */
             0x01040000 /* row 1, col 4, KEY_RESERVED */
             0x02000003 /* row 2, col 0, KEY_2 */
             0x02010007 /* row 2, col 1, KEY_6 */
             0x02020000 /* row 2, col 2, KEY_RESERVED */
             0x02030005 /* row 2, col 3, KEY_4 */
             0x02040008 /* row 2, col 4, KEY_7 */
             0x03000000 /* row 3, col 0, KEY_RESERVED */
             0x03010000 /* row 3, col 1, KEY_RESERVED */
             0x03020005 /* row 3, col 2, KEY_4 */
             0x03030000 /* row 3, col 3, KEY_RESERVED */
             0x03040009 /* row 3, col 4, KEY_8 */
             0x04000002 /* row 4, col 0, KEY_1 */
             0x04010000 /* row 4, col 1, KEY_RESERVED */
             0x04020008 /* row 4, col 2, KEY_7 */
             0x04030009 /* row 4, col 3, KEY_8 */
             0x04040000 /* row 4, col 4, KEY_RESERVED */
     >;

>
>> both matric_keypad.c and mt_matrix_kepad.c logically operate differently,
>> my openion is not to merge both.
>
>IMHO from the user/system-integrator pov it is looking the same and so
>one driver should be fine. To distinguish between both modes we could
>add dt-property or add a new dt-compatible like "gpio-matrix-keypad-v2".
>

as mentioned above our keypad is not complete matrix keypad  and it will
not be compatible with matrix_keypad diver. that is the reason we derived
mt matrix keypad driver.

to avoid confusion, we will rename the driver as bosch_mt_keypad.c
if you suggest.

>Regards,
>  Marco

Regards
Gireesh Hiremath

 drivers/input/keyboard/Kconfig            |  10 +
 drivers/input/keyboard/Makefile           |   1 +
 drivers/input/keyboard/mt_matrix_keypad.c | 741 ++++++++++++++++++++++
 include/linux/input/mt_matrix_keypad.h    |  85 +++
 4 files changed, 837 insertions(+)
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
index 000000000000..2664ce3c2653
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
+struct button_states get_button_state(struct button *btn)
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
+	for (i = 0; i < pdata->num_of_buttons; i++) {
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
+struct button_states
+get_btn_id_state(const struct mt_matrix_keypad_platform_data *pdata,
+		 int btn_index)
+{
+	if (btn_index < pdata->num_of_buttons)
+		return get_button_state(&pdata->button_array[btn_index]);
+	else
+		return get_button_state(&pdata->button_array[0]);
+}
+
+union typeEvent
+get_and_clear_btn_events(const struct mt_matrix_keypad_platform_data *pdata,
+			 int btn_index)
+{
+	if (btn_index < pdata->num_of_buttons)
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
+				if (i < pdata->num_of_buttons) {
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
+	for (btn_index = 0; btn_index < pdata->num_of_buttons; btn_index++) {
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
+			for (i = 0; i < pdata->num_of_buttons; i++) {
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
+		for (btn_index = 0; btn_index < pdata->num_of_buttons;
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
+	of_property_read_u32(np, "number-of-buttons", &pdata->num_of_buttons);
+	if (pdata->num_of_buttons <= 0) {
+		dev_err(dev, "number of button not specified\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	button_array =
+		devm_kzalloc(dev,
+			     sizeof(struct button) * (pdata->num_of_buttons),
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
index 000000000000..46dfe49c5fe1
--- /dev/null
+++ b/include/linux/input/mt_matrix_keypad.h
@@ -0,0 +1,85 @@
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
+	unsigned int num_of_buttons;
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
+void init_phase(struct mt_matrix_keypad_platform_data *pdata);
+void button_init(struct button *btn, bool btn_hw_state, int key);
+struct button_states get_button_state(struct button *btn);
+union typeEvent get_and_clear_events(struct button *btn);
+uint8_t get_btn_index(struct mt_matrix_keypad_platform_data *pdata,
+		      int btn_key);
+void set_btn_state_by_hw(struct button *btn, bool boButtonState);
+bool check_button_changes(struct button *btn);
+struct button_states
+get_btn_id_state(const struct mt_matrix_keypad_platform_data *pdata,
+		 int btn_index);
+union typeEvent
+get_and_clear_btn_events(const struct mt_matrix_keypad_platform_data *pdata,
+			 int btn_index);
+void button_hdl_init(struct mt_matrix_keypad_platform_data *pdata);
+bool on_button_event(const struct mt_matrix_keypad_platform_data *pdata,
+		     int btn_index, union typeEvent btn_event,
+		     struct input_dev *input_dev);
+void process_button_events(const struct mt_matrix_keypad_platform_data *pdata,
+			   struct input_dev *input_dev);
+void update_buttons(struct mt_matrix_keypad_platform_data *pdata,
+		    struct input_dev *input_dev);
+#endif /* _MT_MATRIX_KEYPAD_H */
-- 
2.20.1

