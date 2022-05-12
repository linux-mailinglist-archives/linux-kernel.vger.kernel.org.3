Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA2524827
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiELIog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiELIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:44:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E523ED1E;
        Thu, 12 May 2022 01:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naOxQhwLFc2/ZguO7mHDUNAqnW7X9O4xw2mZiY1oaObVN6xrBP/R81LA8Px4a9xVzuh+5mCdu+wTiKzuXG4B9Rn75zXF4kYDLEZNeIMOuYJolChR99HqFmihVacyzpn+0eTghRhkyhpydCdKZNFJUjUggvrcuogjBgb8pRUaQ4pzJ2MNt9Roth1LjI/RLYcpnDDmRXwYbDFhOsFoC8tlXl8z1nwFxmCqYWesVaIHqaid41bnvLBFgalKf0hnrSA133XGBoWgmzITh2st1+xzQnBFjY6V+GRdL7q4d7qTLApq//SejIODgF6uTWrvluk16hxm18PRjKKOc6nemDQ5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSTCNlfvpOpnPGO0tkaCeVdrxkFSbanvIifdF1hCB/E=;
 b=Y6nF0hj+bn4HR9O3by20k4DkitkmmUvy3GFiJ532xFXOWS43cn5Fv7Sqjh9NOwbwQDg7jiLd0hmajH/3gPCDuVAXwg33B5CwGm7wWOoJZtEO5GEcHI0olDSG8T8xh0rHiBb+He7GzZ2WT1GRPuu4HLfnujcvQiwbFHKXyusUEHQu83KWonkFXMHNE/ecK4jQggX1ZOgKty1xfV/XrqF+OHUXpLqXYd2vPVu5vb/QjBpruOa8KJXOPFI3inpCP4IzJo84enEo7vpwCjUlH3QTPhKo+nx7XuGP9iHfDe6misOZidIGphO8sq5OUZz83Ps629d1B+5JDG6YdS3Y8zhOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSTCNlfvpOpnPGO0tkaCeVdrxkFSbanvIifdF1hCB/E=;
 b=l/MO8Rh7ErhPXReTwcEr79O4EtHgHsGS0tpPZbgX36y0DDcsPmV1I8R9rQLjDxVZWJrvx9U/RqwXix88GncTHxAuHkp3we/7rP5v3mBWiTc+JJAzkr6nPBbDTBgq/yo68BdEanQrcf/wspJd+dT/+b70uyhHnUT9iJ4QWUgajlq+ZF4chZS1cp175RLUVyJ5D/hwc29osIMJwq6PuI2ShCndsQBiEH+M01nn4Pb5vKFSkKy3PN+jnhrtkMSM4FEpnEUVSS6AIWXeKBmAXbnFMVncR2qBAVGUv5giE2yXTp0jtvsoaff32yqFpEoxQMpGLEcjekIa9bKEWCYRcbIaQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13)
 by PA4PR10MB4606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:103::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 08:44:27 +0000
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7574:7fdc:9b12:30be]) by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7574:7fdc:9b12:30be%8]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 08:44:27 +0000
Date:   Thu, 12 May 2022 10:44:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v2 4/4] leds: simatic-ipc-leds-gpio: add GPIO version of
 Siemens driver
Message-ID: <20220512104424.1430c9a3@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220511153905.13980-5-henning.schild@siemens.com>
References: <20220511153905.13980-1-henning.schild@siemens.com>
        <20220511153905.13980-5-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::10) To DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ed::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e70e3b7-8cef-467e-05fa-08da33f39f48
X-MS-TrafficTypeDiagnostic: PA4PR10MB4606:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB460658EFC091DF21408E9AC385CB9@PA4PR10MB4606.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xP5oR3SuquLK4pvzMLpnfsP1HFQ82jYjC4ATrPuX5gI5L0f0CutAvUi45xgRz8l64jvUNtFx3wE4Q4uOXpHP1LQQjgZ9F1gjktyHDc1JFx2tY2s8USDqvDSdwqAHbNgO0zafz+ytMbhBgQ4OY93BP2VO8QkUW5w1BA92uXYZfDr06oEar+KpbToViJWRfMAr8GYOKuDAe2e9VkbZrsevgp0IeNJ/J+zdqbPCDQQoqost2wUKIP+jt7OSlWEitX+eTwnYtcANI6kCmep4nCXqavItKiqmevmyjm+RjaOv0vz3hQSXtpyby0pzhChgeX74FUnHP+bxoUpIvbj90w1LfFaKazdq3xW1MqsQsq157bIW32MWQnofMwPY+89WkX5dhQGNzxBxtujN+sScTBlSLpqZYxylX9Isz3jB07H1a0foREc2pi6aNEfPfvXXYY3VEbIw8J17TxAgUo3S0obImK29LE1svQJgIiM1hBCoUqoHFao34BL/QJ8ZapXoDIQ0dytW33zk3ezKxQpy0Jac/vtUTw6bGNUTVyyuEIERngBGr2IPXea0FSkt4S8H1PbkNJjsj2OeAz705WcehdB/WfFAgAQFOmfu5nz9I9+n93PxKLgOTonUX2fFriE0Pp5M4rPLcHZK7KoeSqVUK+zu1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(6666004)(6506007)(316002)(26005)(6512007)(9686003)(82960400001)(54906003)(6916009)(2906002)(38100700002)(5660300002)(86362001)(66946007)(66556008)(8676002)(4326008)(83380400001)(66476007)(107886003)(186003)(44832011)(1076003)(30864003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vY4xPUhyCnbRcvtlusRG74nYAE0PhDE3uOhkmuife1eGpqci/qot4nVEvSI?=
 =?us-ascii?Q?9YaqoJshwxd99+cINpW4AtDCbA43NdEut+0mgOqnBUgatLQUym4UmsP3+hXR?=
 =?us-ascii?Q?afbFnoudPa8dJsQZasR5x4Mk/LQHxfrYhal2EH4R0Sy9AXdeCTUMag9ntYcE?=
 =?us-ascii?Q?KNZ+C3zLs/uD9f5tACJk8aa5EMaejr51tPtaLlXMgAMJByMyqF4xMuekmdl+?=
 =?us-ascii?Q?6WYcBE5YiRvPO0LeXhwVSll8apIuhkfET7zXnvfPaEJgm5hmnlKYfV2vurr2?=
 =?us-ascii?Q?3mHNZjEur7HxqxL+/4hZCJY7iXT7NlBTzblmF+mJXcEXVa2Y3qQysWd0tV+w?=
 =?us-ascii?Q?5lHpuFc09FKNizYdPYzaFVvHKftECC0UYCDVv+7q0ZgdwICTM7MS3+YSBKWD?=
 =?us-ascii?Q?oxstG9GuC9nv7qGKtBN8k3fU9zfcC5Gkqi3AqnIm9LD/FH6PLrx/WcE8uFry?=
 =?us-ascii?Q?kE8zkv3v49cwxNNSGpVY/36dKXvmTHW9OwY9KjWmlaXuPU0esUcSTRmLSXJj?=
 =?us-ascii?Q?73MoEneEL1xW9c1j3ltR0J+IrR2uipwRN2pF7+udR0XjBl2CX7mAZeQclI98?=
 =?us-ascii?Q?x9EvixOR7wDqbKKk4RA16brsGOHi+X9QuNJrYnbvJXc5Gc7r9pNnvNosCnZ5?=
 =?us-ascii?Q?7lZh4rGrorKQmuFGJRJvxAWOLme/kJKfiVStvKroSeOqzZnoto+T0mgoHUyD?=
 =?us-ascii?Q?C8qPZDCHbF3HM/+IMgvfEvCrmkH7dZkpGgH/k+27GQAuFZdnlxHgif9Lol7K?=
 =?us-ascii?Q?ALpQF3+SphMiGmgTycuGBEMnVfCTdkCIRRXwRAqMqx34TvTInhTN9exVwOrA?=
 =?us-ascii?Q?p/LYCOUWEtbXA0B2A3LY9HdKKtTl0qqoGDS2PV08NdDcwaCdBs4EldbNMI/S?=
 =?us-ascii?Q?pqP+WHgrqo2b/AAY59oRBfigbs6MlJA3IGGbkiTU1YcqayG1b0GPOsc2YLuO?=
 =?us-ascii?Q?UwJrFhupyTh0XUqHmJQqua0IZAjugQ3E0qVZqo5rhrByj/mvG3DE/ukgjohK?=
 =?us-ascii?Q?nCxbYtWxAqZtlA0qNzhxaPFdiAgLKgcbz55f6ISXgDAxVk232CzvNVOgkkyN?=
 =?us-ascii?Q?XfBAV5BkP9WbKDyN6b1hZfGk5Uc33GeQv+ZxTlQNZdLaTtXgfxFf26xmousa?=
 =?us-ascii?Q?xzBStOYvbzvrdUzKKOcdUuspdnkzBlbOWovhNVk/ABQadP9EKGiBBLCTN3DB?=
 =?us-ascii?Q?FlwvSlc2gth/uHsiN9rNG2JkacBXHEhl/wm2TInUwqiP1hnXx2WZ3sTcnBtm?=
 =?us-ascii?Q?dyyKIk9gWtPPnG1/ov4Zg2J7QMlErHiOmkuHjxP3N+Z5LrWqTNMgBTTd6vt+?=
 =?us-ascii?Q?Sd639EGEvY9rFSr3oaTtDvnU8H+8E2/T4tFZfGC6Vddf6UBR9e569J+JWOew?=
 =?us-ascii?Q?rl1z75Qdn2zwkMOEgoTOB6QkTQmkA1vNE/0pHN5ScsxO/P1e147otYtY+FiQ?=
 =?us-ascii?Q?ENswqNlTSWk1//q/62bCmnmHr46WQwKI4D5HGGbzynbpXhIUcxN6PClf+/1a?=
 =?us-ascii?Q?lvflle5YJ4srOSkiOVk1aX3CBXaBzJ+ohaGBMV39T0HAR2OvIC4KRWPPquHE?=
 =?us-ascii?Q?F9asr/T/XBv5nvx2zcYG280vj+nb7p855ut0mmsr8VR2UmpIvkNszVmxAEP8?=
 =?us-ascii?Q?rIoJPD9eZaazadT/cwMey/SC2/6frYMSH4QtJg/5hmRcGTuZUCIBBQjA4x4Z?=
 =?us-ascii?Q?kaPmvoUsHpTGz6edkedWCHVmWosL4wWSCvariUeYebRpv5QVn8SC/ZzBn7QZ?=
 =?us-ascii?Q?564SeeOCKI6a5FQYSOJ/2sbL0AemwVc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e70e3b7-8cef-467e-05fa-08da33f39f48
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 08:44:27.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAt3WaGDOKhI4Cm3votVozaKGxxetdKT+dV07xwXjt7Po3iVylWy8E8Vav+F9bK73cFdjIK98HDemjeZ2e7Ylx1dWGbSo+z5SmSRqlT6NJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4606
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 11 May 2022 17:39:05 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> On Apollo Lake the pinctrl drivers will now come up without ACPI. Use
> that instead of open coding it.
> Create a new driver for that which can later be filled with more GPIO
> based models, and which has different dependencies.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/Kconfig                 |  12 ++-
>  drivers/leds/simple/Makefile                |   3 +-
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 108
> ++++++++++++++++++++ drivers/leds/simple/simatic-ipc-leds.c      |
> 80 +-------------- drivers/platform/x86/simatic-ipc.c          |   5
> +- 5 files changed, 129 insertions(+), 79 deletions(-)
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
> 
> diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
> index 9293e6b36c75..9d2487908743 100644
> --- a/drivers/leds/simple/Kconfig
> +++ b/drivers/leds/simple/Kconfig
> @@ -3,10 +3,20 @@ config LEDS_SIEMENS_SIMATIC_IPC
>  	tristate "LED driver for Siemens Simatic IPCs"
>  	depends on LEDS_CLASS
>  	depends on SIEMENS_SIMATIC_IPC
> -	select P2SB if X86
>  	help
>  	  This option enables support for the LEDs of several
> Industrial PCs from Siemens.
>  
>  	  To compile this driver as a module, choose M here: the
> module will be called simatic-ipc-leds.
> +
> +config LEDS_SIEMENS_SIMATIC_IPC_GPIO

I wonder if i really should introduce a new switch here or just carry
this one under LEDS_SIEMENS_SIMATIC_IPC

For a v3 i will likely put two modules under that one config switch.

Henning

> +	tristate "LED driver for Siemens Simatic IPCs, GPIO based"
> +	depends on SIEMENS_SIMATIC_IPC
> +	depends on LEDS_GPIO
> +	help
> +	  This option enables support for the LEDs of several
> Industrial PCs
> +	  from Siemens.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called simatic-ipc-leds-gpio.
> diff --git a/drivers/leds/simple/Makefile
> b/drivers/leds/simple/Makefile index 8481f1e9e360..e1df74fb5915 100644
> --- a/drivers/leds/simple/Makefile
> +++ b/drivers/leds/simple/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)		+=
> simatic-ipc-leds.o
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_GPIO)	+=
> simatic-ipc-leds-gpio.o diff --git
> a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c new file mode 100644
> index 000000000000..552b65a72e04 --- /dev/null +++
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for GPIO based LEDs
> + *
> + * Copyright (c) Siemens AG, 2022
> + *
> + * Authors:
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> +	.dev_id = "leds-gpio",
> +	.table = {
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6,
> GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7,
> GPIO_ACTIVE_HIGH),
> +	}
> +};
> +
> +static const struct gpio_led simatic_ipc_gpio_leds[] = {
> +	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
> +	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
> +	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
> +	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
> +	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
> +	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
> +};
> +
> +static const struct gpio_led_platform_data
> simatic_ipc_gpio_leds_pdata = {
> +	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
> +	.leds		= simatic_ipc_gpio_leds,
> +};
> +
> +static struct platform_device *simatic_leds_pdev;
> +
> +static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
> +{
> +	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
> +	platform_device_unregister(simatic_leds_pdev);
> +
> +	return 0;
> +}
> +
> +static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
> +{
> +	struct gpio_desc *gpiod;
> +	int err;
> +
> +	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
> +	simatic_leds_pdev = platform_device_register_resndata(NULL,
> +		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
> +		&simatic_ipc_gpio_leds_pdata,
> +		sizeof(simatic_ipc_gpio_leds_pdata));
> +	if (IS_ERR(simatic_leds_pdev)) {
> +		err = PTR_ERR(simatic_leds_pdev);
> +		goto out;
> +	}
> +
> +	/* PM_BIOS_BOOT_N */
> +	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, 0);
> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
> +		goto out;
> +	}
> +	gpiod_set_value(gpiod, 0);
> +	gpiod_put(gpiod);
> +
> +	/* PM_WDT_OUT */
> +	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, 0);
> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
> +		goto out;
> +	}
> +	gpiod_set_value(gpiod, 0);
> +	gpiod_put(gpiod);
> +
> +	return 0;
> +out:
> +	simatic_ipc_leds_gpio_remove(pdev);
> +
> +	return err;
> +}
> +
> +static struct platform_driver simatic_ipc_led_gpio_driver = {
> +	.probe = simatic_ipc_leds_gpio_probe,
> +	.remove = simatic_ipc_leds_gpio_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	}
> +};
> +
> +module_platform_driver(simatic_ipc_led_gpio_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_SOFTDEP("pre: platform:leds-gpio");
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/leds/simple/simatic-ipc-leds.c
> b/drivers/leds/simple/simatic-ipc-leds.c index
> 2e7597c143d8..4894c228c165 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds.c +++
> b/drivers/leds/simple/simatic-ipc-leds.c @@ -15,7 +15,6 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> -#include <linux/platform_data/x86/p2sb.h>
>  #include <linux/platform_data/x86/simatic-ipc-base.h>
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
> @@ -24,7 +23,7 @@
>  #define SIMATIC_IPC_LED_PORT_BASE	0x404E
>  
>  struct simatic_ipc_led {
> -	unsigned int value; /* mask for io and offset for mem */
> +	unsigned int value; /* mask for io */
>  	char *name;
>  	struct led_classdev cdev;
>  };
> @@ -39,21 +38,6 @@ static struct simatic_ipc_led
> simatic_ipc_leds_io[] = { { }
>  };
>  
> -/* the actual start will be discovered with p2sb, 0 is a placeholder
> */ -static struct resource simatic_ipc_led_mem_res =
> DEFINE_RES_MEM_NAMED(0, 0, KBUILD_MODNAME); -
> -static void __iomem *simatic_ipc_led_memory;
> -
> -static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
> -	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
> -	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
> -	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
> -	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
> -	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
> -	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
> -	{ }
> -};
> -
>  static struct resource simatic_ipc_led_io_res =
>  	DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2,
> KBUILD_MODNAME); 
> @@ -89,28 +73,6 @@ static enum led_brightness
> simatic_ipc_led_get_io(struct led_classdev *led_cd) return
> inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF :
> led_cd->max_brightness; } 
> -static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
> -				    enum led_brightness brightness)
> -{
> -	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> -	void __iomem *reg = simatic_ipc_led_memory + led->value;
> -	u32 val;
> -
> -	val = readl(reg);
> -	val = (val & ~1) | (brightness == LED_OFF);
> -	writel(val, reg);
> -}
> -
> -static enum led_brightness simatic_ipc_led_get_mem(struct
> led_classdev *led_cd) -{
> -	struct simatic_ipc_led *led = cdev_to_led(led_cd);
> -	void __iomem *reg = simatic_ipc_led_memory + led->value;
> -	u32 val;
> -
> -	val = readl(reg);
> -	return (val & 1) ? LED_OFF : led_cd->max_brightness;
> -}
> -
>  static int simatic_ipc_leds_probe(struct platform_device *pdev)
>  {
>  	const struct simatic_ipc_platform *plat =
> pdev->dev.platform_data; @@ -118,9 +80,7 @@ static int
> simatic_ipc_leds_probe(struct platform_device *pdev) struct
> simatic_ipc_led *ipcled; struct led_classdev *cdev;
>  	struct resource *res;
> -	void __iomem *reg;
> -	int err, type;
> -	u32 val;
> +	int err;
>  
>  	switch (plat->devmode) {
>  	case SIMATIC_IPC_DEVICE_227D:
> @@ -135,51 +95,19 @@ static int simatic_ipc_leds_probe(struct
> platform_device *pdev) }
>  			ipcled = simatic_ipc_leds_io;
>  		}
> -		type = IORESOURCE_IO;
>  		if (!devm_request_region(dev, res->start,
> resource_size(res), KBUILD_MODNAME)) { dev_err(dev, "Unable to
> register IO resource at %pR\n", res); return -EBUSY;
>  		}
>  		break;
> -	case SIMATIC_IPC_DEVICE_127E:
> -		res = &simatic_ipc_led_mem_res;
> -		ipcled = simatic_ipc_leds_mem;
> -		type = IORESOURCE_MEM;
> -
> -		err = p2sb_bar(NULL, 0, res);
> -		if (err)
> -			return err;
> -
> -		/* do the final address calculation */
> -		res->start = res->start + (0xC5 << 16);
> -		res->end = res->start + SZ_4K - 1;
> -
> -		simatic_ipc_led_memory = devm_ioremap_resource(dev,
> res);
> -		if (IS_ERR(simatic_ipc_led_memory))
> -			return PTR_ERR(simatic_ipc_led_memory);
> -
> -		/* initialize power/watchdog LED */
> -		reg = simatic_ipc_led_memory + 0x500 + 0x1D8; /*
> PM_WDT_OUT */
> -		val = readl(reg);
> -		writel(val & ~1, reg);
> -
> -		reg = simatic_ipc_led_memory + 0x500 + 0x1C0; /*
> PM_BIOS_BOOT_N */
> -		val = readl(reg);
> -		writel(val | 1, reg);
> -		break;
>  	default:
>  		return -ENODEV;
>  	}
>  
>  	while (ipcled->value) {
>  		cdev = &ipcled->cdev;
> -		if (type == IORESOURCE_MEM) {
> -			cdev->brightness_set =
> simatic_ipc_led_set_mem;
> -			cdev->brightness_get =
> simatic_ipc_led_get_mem;
> -		} else {
> -			cdev->brightness_set =
> simatic_ipc_led_set_io;
> -			cdev->brightness_get =
> simatic_ipc_led_get_io;
> -		}
> +		cdev->brightness_set = simatic_ipc_led_set_io;
> +		cdev->brightness_get = simatic_ipc_led_get_io;
>  		cdev->max_brightness = LED_ON;
>  		cdev->name = ipcled->name;
>  
> diff --git a/drivers/platform/x86/simatic-ipc.c
> b/drivers/platform/x86/simatic-ipc.c index 26c35e1660cb..ca3647b751d5
> 100644 --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -51,6 +51,7 @@ static int register_platform_devices(u32 station_id)
>  {
>  	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
>  	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
> +	char *pdevname = KBUILD_MODNAME "_leds";
>  	int i;
>  
>  	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
> @@ -64,10 +65,12 @@ static int register_platform_devices(u32
> station_id) }
>  
>  	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
> +		if (ledmode == SIMATIC_IPC_DEVICE_127E)
> +			pdevname = KBUILD_MODNAME "_leds_gpio";
>  		platform_data.devmode = ledmode;
>  		ipc_led_platform_device =
>  			platform_device_register_data(NULL,
> -				KBUILD_MODNAME "_leds",
> PLATFORM_DEVID_NONE,
> +				pdevname, PLATFORM_DEVID_NONE,
>  				&platform_data,
>  				sizeof(struct simatic_ipc_platform));
>  		if (IS_ERR(ipc_led_platform_device))

