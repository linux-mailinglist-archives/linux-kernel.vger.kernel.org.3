Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9864B96B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiBQDgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:36:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBQDgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:36:09 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005CA29ADC6;
        Wed, 16 Feb 2022 19:35:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtUvlAjbQlqzB63TMLO3kUVT0Ayi4hfpbSr9kVc1nMKEzFo6Yv4ZnVNVz0vOhDHrqom5a+9b/mFKNsHaEq3bhfgNs94TesbXZc60/bDWDFoxPOAhWcrYqZhE6u6bCSzOltO9vzRxd63zWuaTd39+CEFWOGznGye11j5sSr/9R6ukFKc6US43IJfbLELsvcj6R9HdfYHIA/bXBrMfN2YW9WjjxzGLf34P2/EMuBmTyImYp+ZiOmg7ZfHM4pAPzWd6y0s2sU1xNk5qHrH3tFeljBoG+p7eq27JXGpMsyZ39bRAKz0Wf1H4g7CtwanIhcjGLB8/pa38FaICba7jeitIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJVtoxZGDYp6qekdbdi1IQp9LTF+4N7N6Ry428DELyY=;
 b=kYJUnrdk2KKGa5X6PHkKrzzkcKaOy+fxFAdNAC0Dxnizxj0eOGM48tIe2gcTlfLnBT/J8z3x0amzBgA1It4nYNkqmlDiZc2lLId464Bo/f3vl5hMV4NCGAPvoUMztw1cw/2IdjpHupJvnO7R6KlGBmNCQpzazNUT3SfZPQ0aghqFG61eZmcwqHicp1Xm+pR7f7mh1Wu3wm33xUx3F9BSNLm+7jGHGqNXv3vMospUZ5dBhdhvd+ckdr9rAxQnNzlIjNY9gkSPPhYOcVRb03MY2LWzhv3KMaFv3xe6n4MLEGZc3+xJ6KOVPllt98AEDrbiwTpwxcUEcZmoe5igh0OMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJVtoxZGDYp6qekdbdi1IQp9LTF+4N7N6Ry428DELyY=;
 b=LHnXiaemUDzwbd7LXTCZ+sv1kxsR9P5fpff8pL+SbxXDUtwEa/HxRkbCB3fKMGZblccJyKmXkFwnQ6c6VWWO9P91+plcRi8SEjhPFfzBNX8/3lKQJS8rkFrsx+NNuoenZIM8zzsmNos/psmSLgh1fYPHkaOKib0ilsqsmtE87eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SA2PR08MB6540.namprd08.prod.outlook.com (2603:10b6:806:117::20)
 by DM6PR08MB4316.namprd08.prod.outlook.com (2603:10b6:5:a4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 03:35:48 +0000
Received: from SA2PR08MB6540.namprd08.prod.outlook.com
 ([fe80::e9a7:f155:7bff:6112]) by SA2PR08MB6540.namprd08.prod.outlook.com
 ([fe80::e9a7:f155:7bff:6112%8]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 03:35:48 +0000
Date:   Wed, 16 Feb 2022 21:35:43 -0600
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
Subject: Re: [PATCH v5 2/2] Input: add Imagis touchscreen driver
Message-ID: <20220217033543.GA35183@nixie71>
References: <20220216134302.5153-1-markuss.broks@gmail.com>
 <20220216134302.5153-3-markuss.broks@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216134302.5153-3-markuss.broks@gmail.com>
X-ClientProxiedBy: SN4PR0401CA0032.namprd04.prod.outlook.com
 (2603:10b6:803:2a::18) To SA2PR08MB6540.namprd08.prod.outlook.com
 (2603:10b6:806:117::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f390c7e5-15c6-490b-b26a-08d9f1c6965c
X-MS-TrafficTypeDiagnostic: DM6PR08MB4316:EE_
X-Microsoft-Antispam-PRVS: <DM6PR08MB4316487BA3ED29985D50959FD3369@DM6PR08MB4316.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpt2Q9+YmlTxjFlTna32jFZYFRU8y2D3Mvbj4wk1FwP7cugTj8xDylms4+rm8Cb5peC0+1vUuzyJt38SC8qSME5sD7kyADzzvYfZfPeagcr9/nGIphx4w5bBWGSpvTAoYmaNHiTpPQqSNhULgMJBp+5a5BwYHpImciwu0KBZNU6SMReCde0iA6oT0MZzcGZvmvXdF2zMgMyLKP1WKNinRkBTDQ3aemWcNitND9ImZx+MJMq4eJZ6McGIv8xDdf0jMwoL6yHrBrBe7G5sjzsWT8sBuUQbYmxHqqxDiL6Zbr8Q+QTC2J5mHTT84eYAUekIQ1q1NVV2gAl4FiUqaCeHAAhgwKZEMlfhcjbDRtfrlRiJpYXlfFS/oJZRoic2I3CgvFVlSD4WZUC9etmdeW6Kywj0rW+MWcSPrYRuZ+Ubo0nvp42fyYljJd/A4Qk6Z4qRfkZlOIdIygjEyH/Nt+dhTCIz8LtLtbnMXmCTyq+tSegV+RtGSBhnQaLHEo8Xal6Li9GmafEeyg4VcPivyGsuNdiFS4aCh51wfCqBmC++ZKMN6GAvW9x+6iKdwjOhWnOPitduwWQBkhtS6LQ8E75H7c3t6VxTFG2yQ0+G9ki4kFlCWfCUHwuK9SUtrqHrNW7xYPEmEY/8ZF66nn2+/P17O7T1bdO2Wf3d3Nkue67MnsECA4FrlahXsDjkvMxsYUZm4+E+SCXi/+cRo0kCqOO23Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR08MB6540.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(39830400003)(136003)(346002)(366004)(376002)(396003)(52116002)(30864003)(316002)(8936002)(8676002)(66556008)(4326008)(83380400001)(86362001)(2906002)(6666004)(186003)(6512007)(6506007)(508600001)(26005)(9686003)(33716001)(1076003)(6916009)(38350700002)(38100700002)(33656002)(6486002)(7416002)(54906003)(66946007)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9n+OPi24QhiflR/Fjfcli6FsRqFYpXH4LjmvVJFNiQWmA41tsyZW1/ziKAiA?=
 =?us-ascii?Q?lNfRb07YEwUOP00Kk7EsiJ3Z1I+bZwP4cKACZUEDzW4TvQuKX76iCOQO8YF/?=
 =?us-ascii?Q?wvf90/ZlROkMMOedTzQooC28LJ9fp18IQ+KQezK15ZK/AeTv8oV+SzH2RH1N?=
 =?us-ascii?Q?NLLa2DckXdXjG43gjJSimi/sjHOmFi91k5bZSbbx26J02FDU2y+8nSLCS1f7?=
 =?us-ascii?Q?mx3x6bY8S0ibpUf3eTbkSR3rzcDP0An2Eqt3V9FNxd3KUzYEkyv9kLUyvoHZ?=
 =?us-ascii?Q?e5HR7FgtZSU2uBj5RUMgzYJxs+/Cl7W3Jlkw4GlNpIJVi6cYr2qTcu0X9m6L?=
 =?us-ascii?Q?QC9CrdHiF0hcdN0+5Iq0N7KuWRSq9jLZICbe+kCrxUxgCoL+qyvTrMiKRGmp?=
 =?us-ascii?Q?4MauM1CdAFXaZSdpBaoGjsnKWo7PeRVSuF8VuwQ28DLnrYuz1NLrL0wY6Qek?=
 =?us-ascii?Q?9QWIckzbJFV4KI7SMUX/qMs2w6SkpriCMUNCUNY1kzsIRbbRWVrq1wOUW1WN?=
 =?us-ascii?Q?g3VUm+/LucuMqf69CCxTmSOr9vZU2gYa5+DWl0Ey8pr7rml/CkQCxsLPuwz/?=
 =?us-ascii?Q?dG5uINrk/RAwrEHxPLOaA8R/LwlxUjUmitefTtiCC8hZQzfu+jHMmvc9+/7t?=
 =?us-ascii?Q?bB4h2WiNTV/LyWbzbBPpYsniGdv5xaCoP2hVjDRt8+OKJMh4ryr+7OFS3OwY?=
 =?us-ascii?Q?BR1AfZtVE48PBUGs8b/MMRVo5K1XhEhakepnYl5WeqXgoxmCp6wIenfuuL4j?=
 =?us-ascii?Q?PFDHCJNZQpzr5eD99bjKa9V6yCZ2yWpyK/sHb0knOBgg+1+Gw1glbB07VfNs?=
 =?us-ascii?Q?lvhwNmOyF5642h7YA4oq/jOjY+qOYUgNKNTzohPQfcPPYWpnl6Mt4yIfsUjQ?=
 =?us-ascii?Q?JYoRMO0HJezX2NJwfy4xOzrQaRutUDeTGFkSvsSy2l3tbcgmAhjcEmJkaPbL?=
 =?us-ascii?Q?lDPM7FrIEB7JMn913Q8WejHqya/MLEuirouctTY2asCRLp6S2Knmkkvb8+OL?=
 =?us-ascii?Q?2bxhskfzcJsOGbJLGjQJ9ixJOOppoBrwtxH9l1iI/wXvQY7Xq/PjxUVCskla?=
 =?us-ascii?Q?W1nAL9/nRFz6jHxdgDnHtJgxs5nwV7qp168v/O1H6nOaPQSAesD7CizCqJGI?=
 =?us-ascii?Q?Af/sdTR2Y2D5z5mtX3O8z8MqsNshSnYGEIoLbR+jq2FsafoqmJL4xAdQUCqR?=
 =?us-ascii?Q?jNkerns7HN/OD6k4eFcQmbJCo6ZK8UkTr54Z/gv8vbqhYy1ZlHb2l+Z+AK0g?=
 =?us-ascii?Q?anjf1OSfh+KOsAqHGFj5pwHbtJFGbmNxGnrWNtWe1tb8fcLPRtLX0VLdUYia?=
 =?us-ascii?Q?EnJt1KxE2kCJo1gfn0AER+Ssf01kmjDAQ8Kqm9qSnjUv4NESC098vTDPHA74?=
 =?us-ascii?Q?AEmZUJCiHC7W9m4uQWTNdkIQ6vQbh+1qs549YIO0iZLtNuhhubaRdZVvAeAH?=
 =?us-ascii?Q?Jn6jb9O0iDsVwlnjWtkVjEawxU/olqdoO6rC6xgZ56DbL2EwaNF0lvJH8dGM?=
 =?us-ascii?Q?7Wv7lG2n4UDK01F0+PWH6lP0i2ihZOw/u8n1WAT5fwu1LnQ/dDi5Yj7GHqZU?=
 =?us-ascii?Q?NT9EmjxucPfKdWKejciix0dDZJj47aIU8Q6zdxj7/wnx5f0njkacmMdISCuA?=
 =?us-ascii?Q?Aagg7UrxtYZjS8L8x/iHwIk=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f390c7e5-15c6-490b-b26a-08d9f1c6965c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR08MB6540.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 03:35:48.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+r1bcrA020j8f59KxF0TPPzXdkUgDYk/jT7MU13lmG5ggotNY0VeTIhlm80j18Hgv73OPAo2ALWwOWNFt8w8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

On Wed, Feb 16, 2022 at 03:43:01PM +0200, Markuss Broks wrote:
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
>  drivers/input/touchscreen/imagis.c | 341 +++++++++++++++++++++++++++++
>  4 files changed, 358 insertions(+)
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
> index 2f6adfb7b938..a0f929506228 100644
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
> +		Say Y here if you have an Imagis IST30xxC touchscreen.
> +		If unsure, say N.
> +
> +		To compile this driver as a module, choose M here: the
> +		module will be called imagis.

Please adhere to the indentation scheme used throughout the rest of
this file.

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
> index 000000000000..df26b90371c3
> --- /dev/null
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -0,0 +1,341 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +

Please explicitly include bits.h.

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
> +#define IST3038C_CHIP_ON_DELAY		60 // ms

IST3038C_CHIP_ON_DELAY_MS

Did checkpatch not complain about the C++ style comment?

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
> +			.buf = (unsigned char *)buffer,
> +			.len = sizeof(reg_be),
> +		},
> +	};
> +	int ret, error;
> +	int retry = IST3038C_I2C_RETRY_COUNT;
> +
> +	do { // The controller might need several reads until it returns a value
> +		ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
> +		if (ret == ARRAY_SIZE(msg)) {
> +			*buffer = be32_to_cpu(*buffer);
> +			return 0;
> +		}

Please follow the kernel style guidelines for comments. I was also
hoping to see more detail as to why this is necessary. The loop in
and of itself is enough to suggest the controller may fail, but why?

Does the datasheet or an errata document ask for this?

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

Can the controller actually report more than 10 contacts?

If so, what is the reason to bail? Is this the controller's way of saying
that the remaining register contents may be garbage?

Or, can the controller report more contacts than it has available registers
for X/Y? That seems odd.

These kind of controller-specific properties are handy to accompany with a
comment.

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
> +static int imagis_start(struct imagis_ts *ts)
> +{
> +	int error;
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies),
> +				      ts->supplies);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to enable regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	msleep(IST3038C_CHIP_ON_DELAY);
> +
> +	enable_irq(ts->client->irq);
> +	return 0;
> +}
> +
> +static int imagis_stop(struct imagis_ts *ts)
> +{
> +	int error = 0;

Nit: any reason to initialize this to zero, then immediately change it below?

> +
> +	disable_irq(ts->client->irq);
> +
> +	error = regulator_bulk_disable(ARRAY_SIZE(ts->supplies),
> +				       ts->supplies);
> +	if (error)
> +		dev_err(&ts->client->dev,
> +			"Failed to disable regulators: %d\n", error);
> +	return error;
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

Just confirming: does this controller require you to write the resolution
back to any internal scaling registers?

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
> +}
> +
> +static int imagis_init_regulators(struct imagis_ts *ts)
> +{
> +	struct i2c_client *client = ts->client;
> +	int error = 0;
> +
> +	ts->supplies[0].supply = "vdd";
> +	ts->supplies[1].supply = "vddio";

You haven't responded to my question about this pair of statements, as
well as a couple other questions from my previous review.

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
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client = i2c;
> +
> +	ret = imagis_init_regulators(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regulator init error: %d\n", ret);
> +

As mentioned earlier, please use 'error' for return variables that only
return zero or negative values.

> +	ret = regulator_bulk_enable(ARRAY_SIZE(ts->supplies),
> +				    ts->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulators: %d\n", ret);
> +
> +	msleep(IST3038C_CHIP_ON_DELAY);
> +
> +	ret = imagis_i2c_read_reg(ts, IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS, &chip_id);
> +	if (ret) {
> +		dev_err(dev, "chip ID read failure: %d\n", ret);
> +		goto error_probe;
> +	}
> +
> +	if (chip_id == IST3038C_WHOAMI) {
> +		dev_dbg(dev, "Detected IST3038C chip\n");
> +	} else {
> +		dev_err(dev, "unknown chip ID: 0x%x\n", chip_id);
> +		ret = -EINVAL;
> +		goto error_probe;
> +	}

It's personal preference, but this seems cleaner:

if (chip_id != ...) {
        /* ... */
        goto ...
}

dev_dbg(...);

And again, it's personal preference, but the dev_dbg is a bit pointless.
The presence of the device in /dev/input is enough to show the device
made it through probe.

> +
> +	ret = devm_request_threaded_irq(dev, i2c->irq,
> +					NULL, imagis_interrupt,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					"imagis-touchscreen", ts);
> +	if (ret) {
> +		dev_err(dev, "IRQ allocation failure: %d\n", ret);
> +		goto error_probe;
> +	}

I think you have unbalanced regulator enable/disable here. Based on
the above flags, it seems you are relying on the open callback to
call imagis_start which then enables interrupts.

However, that also enables regulators once more which will increase
the refcount. Even if the close callback runs before the driver
is detached, the regulators will be left enabled.

Maybe you need to add a device-managed action to disable regulators;
this will also allow you to get rid of the teardown path below the
error_probe label as well as a second return variable.

> +
> +	ret = imagis_init_input_dev(ts);
> +	if (ret) {
> +		dev_err(dev, "input subsystem init error: %d\n", ret);
> +		goto error_probe;
> +	}
> +	return 0;
> +
> +error_probe:
> +	error = regulator_bulk_disable(ARRAY_SIZE(ts->supplies),
> +				       ts->supplies);
> +	if (error)
> +		dev_err(dev, "Failed to disable regulators: %d\n", error);
> +	return ret;
> +}
> +
> +static int __maybe_unused imagis_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct imagis_ts *ts = i2c_get_clientdata(client);
> +
> +	mutex_lock(&ts->input_dev->mutex);
> +
> +	if (input_device_enabled(ts->input_dev))
> +		imagis_stop(ts);

Again, please pass the return value as you have done below.

> +
> +	mutex_unlock(&ts->input_dev->mutex);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imagis_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct imagis_ts *ts = i2c_get_clientdata(client);
> +	int ret = 0;

Again, please use 'error' here.

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
> +MODULE_DEVICE_TABLE(i2c, imagis_of_match);

MODULE_DEVICE_TABLE(of, ...);

> +#endif
> +
> +static struct i2c_driver imagis_ts_driver = {
> +	.driver = {
> +		   .name = "imagis-touchscreen",
> +		   .pm = &imagis_pm_ops,
> +		   .of_match_table = of_match_ptr(imagis_of_match),
> +	},
> +	.probe_new	= imagis_probe,

No extraneous spaces please.

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
