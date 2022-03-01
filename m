Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F135F4C8AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiCALdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCALds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:33:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F412BB09;
        Tue,  1 Mar 2022 03:33:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTeGhrFrzPjUdcQnF3aUZuWh3QzaTTot+oxfgVbNgjK2gLiD4JzASTyTvJMblJgw9OsF73Cty8IntFV5JbzEQFlQv2LaNNmem17H8XhmC3dgkCS26kYyMc+WHSpBqhHm8oDLKduJQ3/u1WEmPcyctZ4Lews2b9AK4n1LHvN+TVDY/CmnFvJbuB3xQSS7srgyBgox+6jiQuaDRkqC7lBL28i/Hkw+e/uJTfv3PDC/SjDTXVb3hOOMCp7CxpblqPuZZKPKcOOkQx+NhVCJ/yIC0QxRlu/VvScXWpyGb/vMhcjke4G25QaRGvM1PIfBtGula09Rw8pXxhcNvHe950omeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHJuSQ8hfS7Uk4ZFFau1oG0cq5av/gkGe0cQaKZaTHQ=;
 b=loTyZq8vL9XOq/9aNHUPedUKhbxszbGEbnBBXbYAkQXrbdJ6YImUbcNnRVdcQcJsoE8Akt/hV6K3rryZY1XY2ps6oHdei4iP6du2TnN32NAmwsyne8Vm6ojZF/AB3mNalFgj43mL2hq/Z5iIkUJuCSHUQT4DXpA6WqcM4LeoVR0L5OFUGJLZJqWL3O4ugAkFB66F+s4SgyO7mZ8MuHZDIL7/vhAFbaax9NmxGIPIuDd+A9gTMFxfZ8tghnYohONb2adRPghIBfgvAtEPduWnjzf+o83JfbpsIJTSt4+c06EmKWrMFZuoI30Hhfq4nX9+wCU5oVPB8d4KGang9Zz5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHJuSQ8hfS7Uk4ZFFau1oG0cq5av/gkGe0cQaKZaTHQ=;
 b=MGJU/jw4KH2b4bwmWqXnu/16pEFGor43PbCvrbTcWtcdJOGbRTmgBEuz9MmZz9vjRC1KeOggu4ryBL7kq8CqmDiw6QZrHwfRSgW2RQeCvDjFxGDPNNK9uMhkrpnC/4zsiUbV33K3IfA2qkrCR9Xr7AwYwLYEKQW0LKsm6Y/tNkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by BN7PR08MB5457.namprd08.prod.outlook.com (2603:10b6:408:3b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 11:33:04 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379%6]) with mapi id 15.20.5017.026; Tue, 1 Mar 2022
 11:33:04 +0000
Date:   Tue, 1 Mar 2022 05:32:57 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/2] Input: add Imagis touchscreen driver
Message-ID: <20220301113257.GA22441@nixie71>
References: <20220223160749.37001-1-markuss.broks@gmail.com>
 <20220223160749.37001-3-markuss.broks@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223160749.37001-3-markuss.broks@gmail.com>
X-ClientProxiedBy: SA9PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:806:6e::26) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ade43e2b-cad0-4275-7719-08d9fb773fa7
X-MS-TrafficTypeDiagnostic: BN7PR08MB5457:EE_
X-Microsoft-Antispam-PRVS: <BN7PR08MB54574E5072DC5181A43A0ED0D3029@BN7PR08MB5457.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABABNvaMl0hcOqtTk/m7y4mfCEbWIa76CXfMJdhKUZrLGA9NX0+q1LEh0vs9ivtHPaAPNl6b1aujgWDUBRkvwfMCS8zF/ZqTdL6GJtYJuWGTTgKHCHX+vQkgE7zUR02jR/HtlJkenjXFCRiFheZSnzE6I6a1FSLWQ4035eUoUXUZAwBhcksy1Af4XQmRVC2KGBpZely3oRD9i89dgSlUgpg9nEgOKIDIAurCr+/pVPkHSZEDfuI5ZWTmtji/FbhrrQGswkhsu13HsNx05WETFHn774xsLjpIVP2iiF/uoPycpF6YpTtYEZscsfge275XPcFlT20ObqpEjaqx81y1BNMvQVwvgGk8kokJ54ZcAjDQpbRgObeG9BMjmht6Y3zMUMdxPLbkZPzA0Kqgyl78htk5bMss8N2FJZ/obFFmKFa8GL9BOzGFTFqYOMZ/Jhb1zQao0hdd9pvudOuTpbpmRFH05ldOoa/82d03I7SaCuA1tu6juMj/4VZK59DEyy25ePi6P4MirE5j9BfsdYbmZhWIrSId6TwcjLmJSPUSkBGGmN9XvDJmedudZIJOTQIw1Yq5JhOAF6hN8zA2y1up/DX2yM/XEpTKAaxSfox94z41xBuPWzSWRAfiiMiqAIZMZa1X9z+k8RQvd+RTEtbAXiSflZX39mmaob8BzvpD+bFOYAGgBknS9RIUZriVdujG8YiAs3F4fFt68Fjp1uB59g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(136003)(396003)(376002)(366004)(39830400003)(346002)(186003)(66556008)(1076003)(52116002)(5660300002)(7416002)(6486002)(8936002)(33656002)(6506007)(66946007)(38350700002)(38100700002)(2906002)(66476007)(6512007)(9686003)(8676002)(26005)(4326008)(6666004)(30864003)(54906003)(6916009)(508600001)(33716001)(83380400001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QeULpt0L4ZFoSJvRvuC+RxGv96icazNE0YBmM2lSChYDV8vpzSz37/5bCzHh?=
 =?us-ascii?Q?o1NXFQIahA8+gmTkywLBkO6quOKK25PU7OLmoMxo9BwEJoQXJCyVFA+MGngW?=
 =?us-ascii?Q?Tm8Cvflg7+CUV5DPP/2eeJC4uHRFTAXzs6WOxxtURloMPWRXoC3neqWllDS4?=
 =?us-ascii?Q?OgRr0dWXe5Zehzy7DDiK/ZfCESz6nd17tc/WP/pCq68UK4v/We3GfDreUe1u?=
 =?us-ascii?Q?hd2LFQqYONIuWS53qbkBJVssk41Owx047kPOQTKUwZZSLUSEkbFW+0HMgBIA?=
 =?us-ascii?Q?mtqgl4funL/8cH6rkIw/E+59cNt3PYi5Eoq5qef1OS2z09xGa6ewOK6i7edm?=
 =?us-ascii?Q?evImflPDAVfTXQRuVb9G7KCSstU75Vdp2FW4pAsS2cwdrzn2SSzTB1jfDtKX?=
 =?us-ascii?Q?ULX28kaVL6IgsF5WmDr+akRlspmvsthtjXBTpfcamqGJPU/c6V+q/Wm/Eqy2?=
 =?us-ascii?Q?x9CL84G/O3vsiXupT//juvxnqxDRJ99/uL2hIgWvMYJTjJEcNwzd5T8rfUFz?=
 =?us-ascii?Q?NzWiS8Y+RZvBHgFqw0n0DJ4s8xqGAizON/OVWenssP4o1FEulQa7QNQdk7ft?=
 =?us-ascii?Q?WwvDMpSfCEszusatAL5q9WNciDlnGrzNP2dQbm71qYK2pDsj22jRM8/A4klW?=
 =?us-ascii?Q?RKUI7VeW3H6yFUnIijnxRHHJkXophGBXY5XrGrULKoy14oQmxg0rigberLeR?=
 =?us-ascii?Q?G0lqVFBAfdqovOXx8phExjLPRQg32uWJ7jKgmEShTYAXDYErcR7SbigK7pBw?=
 =?us-ascii?Q?aRhuOjsDUlKlIiHUvT2IeoYQ1YLhRAdGxIBjE77lftpkeP+5Mp6H5xLFGjos?=
 =?us-ascii?Q?QBoOoNfMjAC9elMNyU+k6oUkuamRLph98Iq6ZYGklsrjlek8c1JyF7sZWc8+?=
 =?us-ascii?Q?Fyclm0OpHazC4zI5mWin07v19Y2jMLAUDgbG8B7xT0+5+bxEBLKNJmjro24+?=
 =?us-ascii?Q?DiqIsxLqK4bjCkycy22vVxolQEr9yT+/ivZNMYEGhCMwOqpV7tFSNx6u4SUP?=
 =?us-ascii?Q?rZDc9ZKdCvr7knmNjwiIjjtDuE7oMytMF3VR6LOErBL0hWc/wHGGtgIqDH8D?=
 =?us-ascii?Q?Nz6ZBQzy2XvM2DkcAH6BZbu6t3RyAj/vpgZoxD6BQObMICHmHlOxvlBU9O5i?=
 =?us-ascii?Q?9lA9ZIIk9gKSE71WAndPX9gTqJNxFPwGqXVnBcGLGHy7LkEafFWNKyxu2ULW?=
 =?us-ascii?Q?97AqTUBqWx8byHISSz5T3aHHDp+PA4eQBrk4a1MPmif7aYB6agUPfHqUBlBU?=
 =?us-ascii?Q?8F1UDHQMbl79a7wMQx/7rdB71PlJyast9LmlC+urtn9/MwXqbCg1ynLAGYf6?=
 =?us-ascii?Q?HIuJXUpbj6Br8YUpygl/J99bbtDrK1gS/HjeRF5HqZqoPWu8iSVjo0LmMAbi?=
 =?us-ascii?Q?RJpqfHKvVl2+KZU+k7DV93fO/3KQtf+CAVGl7Y+pPXNpFZlC1gaV2mMY3tto?=
 =?us-ascii?Q?ta/nFzXZX5Gkhh4m7AqnZzpftiqoaYsxOaMHlhnYjbxVqW4daM3wyRD1SNb0?=
 =?us-ascii?Q?Tx/C84a4mLxXIDWR1bPFzJvrl+E0uIxr7Fg8mD625OLDPFS18MgNlLuu/vML?=
 =?us-ascii?Q?ukqT7BHaRpGG9A0E2CRVW2vP776ugIYnhgzthVKw0dWvyHOakqt4vYUUWg3Y?=
 =?us-ascii?Q?PwvYLbv8qzPyq1XGDqxAstY=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade43e2b-cad0-4275-7719-08d9fb773fa7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 11:33:04.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT67073uEU9xX5eK87SMjJYLKX1Xh6+2yjN48N1l+ZOmbOpXg8G7B8scpxb2+pezNPAg8+0xMzOx9SrGiQRNJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB5457
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

On Wed, Feb 23, 2022 at 06:07:41PM +0200, Markuss Broks wrote:
> Add support for the IST3038C touchscreen IC from Imagis, based on
> downstream driver. The driver supports multi-touch (10 touch points)
> The IST3038C IC supports touch keys, but the support isn't added
> because the touch screen used for testing doesn't utilize touch keys.
> Looking at the downstream driver, it is possible to add support
> for other Imagis ICs of IST30**C series.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  MAINTAINERS                        |   6 +
>  drivers/input/touchscreen/Kconfig  |  10 +
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/imagis.c | 348 +++++++++++++++++++++++++++++
>  4 files changed, 365 insertions(+)
>  create mode 100644 drivers/input/touchscreen/imagis.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a899828a8d4e..3b99c60e9f4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9411,6 +9411,12 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
>  S:	Maintained
>  F:	drivers/usb/atm/ueagle-atm.c
>  
> +IMAGIS TOUCHSCREEN DRIVER
> +M:	Markuss Broks <markuss.broks@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +F:	drivers/input/touchscreen/imagis.c
> +
>  IMGTEC ASCII LCD DRIVER
>  M:	Paul Burton <paulburton@kernel.org>
>  S:	Maintained
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 2f6adfb7b938..f1414f0ad7af 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -638,6 +638,16 @@ config TOUCHSCREEN_MTOUCH
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mtouch.
>  
> +config TOUCHSCREEN_IMAGIS
> +	tristate "Imagis touchscreen support"
> +	depends on I2C
> +	help
> +	  Say Y here if you have an Imagis IST30xxC touchscreen.
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called imagis.
> +
>  config TOUCHSCREEN_IMX6UL_TSC
>  	tristate "Freescale i.MX6UL touchscreen controller"
>  	depends on ((OF && GPIOLIB) || COMPILE_TEST) && HAS_IOMEM
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 39a8127cf6a5..557f84fd2075 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
>  obj-$(CONFIG_TOUCHSCREEN_ILITEK)	+= ilitek_ts_i2c.o
> +obj-$(CONFIG_TOUCHSCREEN_IMAGIS)	+= imagis.o
>  obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+= imx6ul_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
>  obj-$(CONFIG_TOUCHSCREEN_IPROC)		+= bcm_iproc_tsc.o
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> new file mode 100644
> index 000000000000..5117d8674d82
> --- /dev/null
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define IST3038C_HIB_ACCESS		(0x800B << 16)
> +#define IST3038C_DIRECT_ACCESS		BIT(31)
> +#define IST3038C_REG_CHIPID		0x40001000
> +#define IST3038C_REG_HIB_BASE		0x30000100
> +#define IST3038C_REG_TOUCH_STATUS		(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
> +#define IST3038C_REG_TOUCH_COORD		(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
> +#define IST3038C_REG_INTR_MESSAGE		(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x4)
> +#define IST3038C_WHOAMI			0x38c
> +#define IST3038C_CHIP_ON_DELAY_MS		60
> +#define IST3038C_I2C_RETRY_COUNT		3
> +#define IST3038C_MAX_SUPPORTED_FINGER_NUM		10
> +#define IST3038C_X_MASK		GENMASK(23, 12)
> +#define IST3038C_X_SHIFT		12
> +#define IST3038C_Y_MASK		GENMASK(11, 0)
> +#define IST3038C_AREA_MASK		GENMASK(27, 24)
> +#define IST3038C_AREA_SHIFT		24
> +#define IST3038C_FINGER_COUNT_MASK		GENMASK(15, 12)
> +#define IST3038C_FINGER_COUNT_SHIFT		12
> +#define IST3038C_FINGER_STATUS_MASK		GENMASK(9, 0)
> +
> +struct imagis_ts {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct touchscreen_properties prop;
> +	struct regulator_bulk_data supplies[2];
> +};
> +
> +static int imagis_i2c_read_reg(struct imagis_ts *ts,
> +			       unsigned int reg, unsigned int *buffer)
> +{
> +	__be32 ret_be;
> +	__be32 reg_be = cpu_to_be32(reg);
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr = ts->client->addr,
> +			.flags = 0,
> +			.buf = (unsigned char *)&reg_be,
> +			.len = sizeof(reg_be),
> +		}, {
> +			.addr = ts->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = (unsigned char *)&ret_be,
> +			.len = sizeof(ret_be),
> +		},
> +	};
> +	int ret, error;
> +	int retry = IST3038C_I2C_RETRY_COUNT;
> +
> +	/* Retry in case the controller fails to respond */
> +	do {
> +		ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
> +		if (ret == ARRAY_SIZE(msg)) {
> +			*buffer = be32_to_cpu(ret_be);
> +			return 0;
> +		}
> +
> +		error = ret < 0 ? ret : -EIO;
> +		dev_err(&ts->client->dev,
> +			"%s - i2c_transfer failed: %d (%d)\n",
> +			__func__, error, ret);
> +	} while (--retry);
> +
> +	return error;
> +}
> +
> +static irqreturn_t imagis_interrupt(int irq, void *dev_id)
> +{
> +	struct imagis_ts *ts = dev_id;
> +	unsigned int finger_status, intr_message;
> +	int error, i, finger_count, finger_pressed;
> +
> +	error = imagis_i2c_read_reg(ts, IST3038C_REG_INTR_MESSAGE, &intr_message);
> +	if (error) {
> +		dev_err(&ts->client->dev, "failed to read the interrupt message\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	finger_count = (intr_message & IST3038C_FINGER_COUNT_MASK) >> IST3038C_FINGER_COUNT_SHIFT;
> +	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
> +	if (finger_count > IST3038C_MAX_SUPPORTED_FINGER_NUM) {
> +		dev_err(&ts->client->dev, "finger count is more than maximum supported\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	for (i = 0; i < finger_count; i++) {
> +		error = imagis_i2c_read_reg(ts, IST3038C_REG_TOUCH_COORD + (i * 4), &finger_status);
> +		if (error) {
> +			dev_err(&ts->client->dev, "failed to read coordinates for finger %d\n", i);
> +			return IRQ_HANDLED;
> +		}
> +		input_mt_slot(ts->input_dev, i);
> +		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
> +					   finger_pressed & BIT(i));
> +		touchscreen_report_pos(ts->input_dev, &ts->prop,
> +				       (finger_status & IST3038C_X_MASK) >> IST3038C_X_SHIFT,
> +				       finger_status & IST3038C_Y_MASK, 1);
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +				 (finger_status & IST3038C_AREA_MASK) >> IST3038C_AREA_SHIFT);
> +	}
> +	input_mt_sync_frame(ts->input_dev);
> +	input_sync(ts->input_dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int imagis_power_off(struct imagis_ts *ts)
> +{
> +	int error;
> +
> +	error = regulator_bulk_disable(ARRAY_SIZE(ts->supplies),
> +				       ts->supplies);
> +	if (error)
> +		dev_err(&ts->client->dev,
> +			"Failed to disable regulators: %d\n", error);
> +	return error;
> +}
> +
> +static int imagis_power_on(struct imagis_ts *ts)
> +{
> +	int error;
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies),
> +				      ts->supplies);
> +	if (error)
> +		dev_err(&ts->client->dev,
> +			"Failed to enable regulators: %d\n", error);
> +	return error;
> +}
> +
> +static int imagis_start(struct imagis_ts *ts)
> +{
> +	int error;
> +
> +	error = imagis_power_on(ts);
> +	if (error)
> +		return error;
> +
> +	msleep(IST3038C_CHIP_ON_DELAY_MS);
> +
> +	enable_irq(ts->client->irq);
> +	return error;
> +}
> +
> +static int imagis_stop(struct imagis_ts *ts)
> +{
> +	disable_irq(ts->client->irq);
> +
> +	return imagis_power_off(ts);
> +}
> +
> +static int imagis_input_open(struct input_dev *dev)
> +{
> +	struct imagis_ts *ts = input_get_drvdata(dev);
> +
> +	return imagis_start(ts);
> +}
> +
> +static void imagis_input_close(struct input_dev *dev)
> +{
> +	struct imagis_ts *ts = input_get_drvdata(dev);
> +
> +	imagis_stop(ts);
> +}
> +
> +static int imagis_init_input_dev(struct imagis_ts *ts)
> +{
> +	struct input_dev *input_dev;
> +	int error;
> +
> +	input_dev = devm_input_allocate_device(&ts->client->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	ts->input_dev = input_dev;
> +
> +	input_dev->name = "Imagis capacitive touchscreen";
> +	input_dev->phys = "input/ts";
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->open = imagis_input_open;
> +	input_dev->close = imagis_input_close;
> +
> +	input_set_drvdata(input_dev, ts);
> +
> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(input_dev, true, &ts->prop);
> +	if (!ts->prop.max_x || !ts->prop.max_y) {
> +		dev_err(&ts->client->dev,
> +			"Touchscreen-size-x and/or touchscreen-size-y not set in dts\n");
> +		return -EINVAL;
> +	}
> +
> +	error = input_mt_init_slots(input_dev, IST3038C_MAX_SUPPORTED_FINGER_NUM,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to initialize MT slots: %d", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to register input device: %d", error);
> +		return error;
> +	}
> +
> +	return 0;

It is largely personal preference, but this is shorter:

        error = input_register_device(...)
        if (error)
                dev_err(...)

        return error;

I mention this because you use the same style elsewhere.

> +}
> +
> +static int imagis_init_regulators(struct imagis_ts *ts)
> +{
> +	struct i2c_client *client = ts->client;
> +	int error = 0;

This variable is not much use; you can simply return devm_regulator_bulk_get()
directly.

> +
> +	ts->supplies[0].supply = "vdd";
> +	ts->supplies[1].supply = "vddio";
> +	error = devm_regulator_bulk_get(&client->dev,
> +					ARRAY_SIZE(ts->supplies),
> +					ts->supplies);
> +
> +	return error;
> +}
> +
> +static int imagis_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev;
> +	struct imagis_ts *ts;
> +	int chip_id, ret, error;
> +
> +	dev = &i2c->dev;

You can save this line by combining it with the definition of *dev above.

> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client = i2c;
> +
> +	error = imagis_init_regulators(ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "regulator init error: %d\n", error);
> +
> +	error = imagis_power_on(ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to enable regulators: %d\n", error);

As per my previous comments, you still seem to have unbalanced regulator
count because regulators are not turned back off after the driver is taken
down. You should add a device-managed action as with zet6223.c and other
drivers that do not implement a remove() callback.

If you do this, you do not need to call imagis_power_off() in each possible
error path as you have done below.

> +
> +	msleep(IST3038C_CHIP_ON_DELAY_MS);
> +
> +	ret = imagis_i2c_read_reg(ts, IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS, &chip_id);
> +	if (ret) {
> +		imagis_power_off(ts);
> +		return dev_err_probe(dev, error, "chip ID read failure: %d\n", ret);
> +	}

Why to use 'ret' here and 'error' everywhere else? Please drop the former.

> +
> +	if (chip_id != IST3038C_WHOAMI) {
> +		imagis_power_off(ts);
> +		return dev_err_probe(dev, -EINVAL, "unknown chip ID: 0x%x\n", chip_id);
> +	}
> +
> +	error = devm_request_threaded_irq(dev, i2c->irq,
> +					  NULL, imagis_interrupt,
> +					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					  "imagis-touchscreen", ts);
> +	if (error) {
> +		imagis_power_off(ts);
> +		return dev_err_probe(dev, error, "IRQ allocation failure: %d\n", error);
> +	}
> +
> +	error = imagis_init_input_dev(ts);
> +	if (error) {
> +		imagis_power_off(ts);
> +		return dev_err_probe(dev, error, "input subsystem init error: %d\n", error);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imagis_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct imagis_ts *ts = i2c_get_clientdata(client);
> +	int ret = 0;

Again, please use 'error' here.

> +
> +	mutex_lock(&ts->input_dev->mutex);
> +
> +	if (input_device_enabled(ts->input_dev))
> +		ret = imagis_stop(ts);
> +
> +	mutex_unlock(&ts->input_dev->mutex);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused imagis_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct imagis_ts *ts = i2c_get_clientdata(client);
> +	int ret = 0;

And here.

> +
> +	mutex_lock(&ts->input_dev->mutex);
> +
> +	if (input_device_enabled(ts->input_dev))
> +		ret = imagis_start(ts);
> +
> +	mutex_unlock(&ts->input_dev->mutex);
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id imagis_of_match[] = {
> +	{ .compatible = "imagis,ist3038c", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imagis_of_match);
> +#endif
> +
> +static struct i2c_driver imagis_ts_driver = {
> +	.driver = {
> +		.name = "imagis-touchscreen",
> +		.pm = &imagis_pm_ops,
> +		.of_match_table = of_match_ptr(imagis_of_match),
> +	},
> +	.probe_new = imagis_probe,
> +};
> +
> +module_i2c_driver(imagis_ts_driver);
> +
> +MODULE_DESCRIPTION("Imagis IST3038C Touchscreen Driver");
> +MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.35.0
> 

Kind regards,
Jeff LaBundy
