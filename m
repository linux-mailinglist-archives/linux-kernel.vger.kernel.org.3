Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A18F4CCCD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiCDFMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiCDFM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:12:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F06617E36F;
        Thu,  3 Mar 2022 21:11:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7FK5UzYSMklJG8Yq1KxSPHEfeGIWIvhqWuhBIIIIa4b1AhSzS+js/BB1cHkPuHE2mR2bR3jBjNQh1Ns5cB/4Xo5GI15TeS2d6sWCvn6WXVugNT0glUVCQABupromELVznxg/SunHNPG8YAo3ES9TrB7fnlC6S6+jfdl6V2Ih4EV137IP4Rk6LitQIgqri4/vVB0Pqccq8FLoxaG5wvGvNGC2rZbl7+sniMz7DouH5AkvySdSUahaHSy3RUAbuJrlXhuHB14M3f+zfiyGRQf64v0aEF2ShdHnKaEFe8Bt1ScJgohJWteD5knvlDOLP5HkYuuK0edRnsIGjZwEPCvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4/3pNGmsEnlcNANp8acRKeMv7MDkxM+uRpJWF6ZByA=;
 b=WZkbWZv0y78eNFwgiNf575MrgRaBiSfEPFBUVGY2N7i/tKmVG/s4AheFsQ0ZoEVJYVOcU+8/1ULZxxA2Ih2VjEjPNCC4aNd+KnVcNCEGUj4zY+NZsReamHdiFR0BP1g29r7jUdxPYTQ8MNSgy6jOgkXuQlItvh0Vf4wvaN28ZRCkm6EzZAT6mF60zHFhLWui9YbnFht0A5/hWoLvo3GCYnMDKRo8U/LijpOStLY34u61+cIHZI2+4qBrxUpiKoBB/pJutpaCUvxBYmIwGDMr3HbgZPiE23mM42QBxGo1A2lk/yGAUYVhJd0P5JAHdGaT6qUxKBpu1l0kLvapn3wYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4/3pNGmsEnlcNANp8acRKeMv7MDkxM+uRpJWF6ZByA=;
 b=fUqdlAWWcGwL71rMPIxGKDYetTXHQtrplnW6seGb4wuAgupCJfRqLFe3tYowZnBZFrU4z4vPl3vF1+3PQX7AVl+CLdST0RDoa8WaGeil2Hqx0uc9zolB1fIaLxIeEw+4tahU9hQzYQbwiUJ3BHfLhmqW2IyLZuFgPBbLMx8yeRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by BN7PR08MB4017.namprd08.prod.outlook.com (2603:10b6:406:87::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 05:11:36 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 05:11:35 +0000
Date:   Thu, 3 Mar 2022 23:11:27 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        rydberg@bitmath.com, sfr@canb.auug.org.au,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 2/2] Input: add Imagis touchscreen driver
Message-ID: <20220304051127.GA21279@nixie71>
References: <20220303163133.1418-1-markuss.broks@gmail.com>
 <20220303163133.1418-3-markuss.broks@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303163133.1418-3-markuss.broks@gmail.com>
X-ClientProxiedBy: SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37)
 To SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0844fa79-5a39-4424-ac6b-08d9fd9d73e3
X-MS-TrafficTypeDiagnostic: BN7PR08MB4017:EE_
X-Microsoft-Antispam-PRVS: <BN7PR08MB4017AA7C44FDD6CF10C22A18D3059@BN7PR08MB4017.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecn2fuEagPyXOMeehCD098QF2EgjyosJP4iMWxc5qQ6Efb1L1Qk5EdcmpAVoWdlCY+yrEwZ3Pih4tFbveGuxUmSSQNk8psBZJC1iSxECYRJtO8H37ojkWn+ju+0/NQmPsKjZt97j/c3elcOnXRVgSfoPyiHsYHEpvlVfj9hq/mvcymFDe6ub6L+r6qKTAk9K65W7p9phzfr+BNyWyJlBqffmJjEg+9EZUjTSZqTOIJEese7FsGKk9lFQIJOH8DTuF14Y/9QWru1PylajXUwZaSs4lwsb0dHw1i3ug9gqwfOwV1pY+Hq+gDFfgd9ho72IIdu0+rE2lpm7nfoD+CNMpaV0w/JaKke3zIiJvJsa8rTGkqMsw0f4FhFSLLvvnh2sKXXqvnjr7zilJHdYy0mS/noPtZDzEZtAu8vWOruEQlviYi+yJEeoJ2LdpMpX89ATK99oRMnOqR8yg7Qc6ySmWyU1r6FzvgtOL5CneVGp1pEuuncNvKqNahvql0DryKd7Z+j5c8ezG4kOKPBMtfmyELI5zPMpXwTa05wvNw3Gi9kLP7D7mDmFWSxFcGWAjtQBYlG68tJNROnk9LstnR5K+QKDwbxtKYSapFs1AXu4WGAmBCf7ODE7rbBDNfMy8tF9p/hEc2L34+Ln32C2WrXBkp9ExdgMj58JaEaqlT1i77sJgt+g69ddFZi8YIjUiokXZLB6hQrSvSbQRRZlshrCSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(346002)(508600001)(38350700002)(38100700002)(8936002)(26005)(1076003)(186003)(52116002)(6506007)(6512007)(6666004)(9686003)(33716001)(6486002)(8676002)(2906002)(86362001)(66946007)(33656002)(30864003)(6916009)(7416002)(4326008)(83380400001)(66556008)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4mR3524/7DmocVq1dBrsnFTTX6Ahttyv0DdV6bdabesNRDpvd/4V59+Wiiy?=
 =?us-ascii?Q?16/2iVPJoW5crw+Bco8yW2WwvJOYK0Ss+945F6wXB0WUrlH2fivhgmOhruTq?=
 =?us-ascii?Q?b8vNX01HWH58zcJF9X6DsxIw4uuvgugBwIxdUI+ANAbKjeJrKOjDh8JCg9CX?=
 =?us-ascii?Q?tMa4gGaWXA3QQHgKz8J/l8QCY9q1MsY2mGB1N6aba0+cYnfUD4qPJVYEmvmm?=
 =?us-ascii?Q?zCah7fTkEzxJhACmWEZwtTQ20BN/JA2vpL+K53aD04ESHgOe8DiP9ED/cG1m?=
 =?us-ascii?Q?4MoQMl8yJUrcS2CriaEBoWBiwAB7Ilv/2XLgjNUAx7HJABaBoNAp2bfUAUol?=
 =?us-ascii?Q?4gG+C5wm7qfGKAM2rKh7d6smBe0vEVjcClTiH0VVyHceSZoq07sscAMnfj+6?=
 =?us-ascii?Q?RbraP6v89VAzyHXZ9q5tU5ji3JLAZKkFqu8YFXJb2Bux2GicITtSfZKMyvyJ?=
 =?us-ascii?Q?Dg2GvZXnYnArse/jdc4aKnghYQlrKx8kwE4osCMPVWzeZCueV695oUyWDlps?=
 =?us-ascii?Q?ltb7310nVmFMYvWfeLjAXBjF5g+oLYdFpetRlwBBfM52We0WTk5k1imcQ7hp?=
 =?us-ascii?Q?Etr7j2pHjfRHFyvfcNMP5DcwUA0bfSZvVXLN6qPUADepHPEGT2GoiKVdbGSk?=
 =?us-ascii?Q?AulmdGWeogiEglG1H8n1FiETDc3MYWkFNJttP4TVlnoP+z2cQie3tblq6g/o?=
 =?us-ascii?Q?gF6zXTEmn/DQhX1rWFs4GBSEPBwBItwRseV42zIyaCBPeGkGPVUEFhamDHO0?=
 =?us-ascii?Q?r514dHFdQEhRokkUO+f1Y3tLSTxVnA/js90jnaCli+JbwtZWF9O8RM0E/62/?=
 =?us-ascii?Q?mXEC7dovq9oL1yA0nrZ30eqMpbyhwCfQKF1mW264JiyGXJ9LAWjSVVwTqfzA?=
 =?us-ascii?Q?MLuUCK4/Gz3mwKLm7pwOUM5V2rOpL5Mv92nAnfsqmZfcGk5K1+UIRHyg277C?=
 =?us-ascii?Q?edC4ykUADXJ5PYJ9C8cUCwrzHYclW30Tka4Xe8ekLQ8zcTIOvEOlbKTynWiP?=
 =?us-ascii?Q?hYX9Z9n3qBqoM+XazfApQYp7nrtE6ac4IUCmV9vw3IfBdPA+WugRAIwEniQr?=
 =?us-ascii?Q?nezslyKkCm8ghvAKgCQVNiyVVDh5N8AYUAeqBS8kwfyHtISfN6886ChASa7l?=
 =?us-ascii?Q?XVgybhCsOaUoem0D/mDzWIeFZaXLDPpEzJpmFaeMl9NTLwwP06uqJKCSF8XG?=
 =?us-ascii?Q?mXogZq0tJ8PJ5powj31cqb53Su47GdPmFUj+mBjGXtuy3UOf0pdtknGk4wEz?=
 =?us-ascii?Q?dNh0hUX/+UcV0kKZRhO+nUKJAG6K6+TWuvXAB8zu1ouVK9sv6ocEd8u7il7H?=
 =?us-ascii?Q?5/v/nDgP9PC4EkEsvadf8LpwCuPrffPk+H4p7DTW7IBc7hIUXQLD5Yrs2+Cy?=
 =?us-ascii?Q?ba/PijYcw/Vfj7HfxbM5lnmJeSeTsLHZg1DBUb/7k/nV0GXSDo2lcJJKzoki?=
 =?us-ascii?Q?b88O7oQh/txoIsBWbOKepVp3eVTBvklurLkt04ChpU7qHym5zb77FLFZhZDU?=
 =?us-ascii?Q?2i7u/l0gx5Sjj9et3VSZd5rxJzsn0cVHH3ap94DDwz/Ox6MRwR5IMCOXrqU1?=
 =?us-ascii?Q?ioJz3IgXTWkDD9m+BeMuVXx2L52nsX2kxcSWZev0WyrDE4V3HS6wRVsxbRlA?=
 =?us-ascii?Q?kvz93/jFvleHaImKWs6pFYo=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0844fa79-5a39-4424-ac6b-08d9fd9d73e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:11:35.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i92obF2gRglvROu0X8yoM4A1J9jbtLsSIvUBS/6CF8ZLqUodInjYGmP2Q5Ed+iMHisd/qWqqnXDr0xmvHBE5/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4017
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

Great work driving this one to the finish line. I caught four remaining
minor items; once they are fixed for v10, please feel free to add my:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

On Thu, Mar 03, 2022 at 06:31:33PM +0200, Markuss Broks wrote:
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
>  drivers/input/touchscreen/imagis.c | 331 +++++++++++++++++++++++++++++
>  4 files changed, 348 insertions(+)
>  create mode 100644 drivers/input/touchscreen/imagis.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7ea92ce1b1d..feab0c765d4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9509,6 +9509,12 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
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
> index 000000000000..5776bd5c0422
> --- /dev/null
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -0,0 +1,331 @@
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
> +static void imagis_power_off(void *_ts)
> +{
> +	struct imagis_ts *ts = _ts;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
> +}
> +
> +static int imagis_power_on(struct imagis_ts *ts)
> +{
> +	int error;
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);

Please update as follows:

        error = regulator_bulk_enable(...);
        if (error)
                return error;

        msleep(...);

        return 0;

If the regulators failed to be enabled and the driver needs to bail, there
is no reason to sleep before doing so.

> +	msleep(IST3038C_CHIP_ON_DELAY_MS);
> +
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

This same delay is already administered from imagis_power_on(); I assume it
is a duplicate?

> +
> +	enable_irq(ts->client->irq);
> +	return error;

Nit: error would only ever be zero by this point, so consider simply returning
zero as you have done in imagis_stop() below.

> +}
> +
> +static int imagis_stop(struct imagis_ts *ts)
> +{
> +	disable_irq(ts->client->irq);
> +
> +	imagis_power_off(ts);
> +
> +	return 0;
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
> +	if (error)
> +		dev_err(&ts->client->dev,
> +			"Failed to register input device: %d", error);
> +
> +	return error;
> +}
> +
> +static int imagis_init_regulators(struct imagis_ts *ts)
> +{
> +	struct i2c_client *client = ts->client;
> +
> +	ts->supplies[0].supply = "vdd";
> +	ts->supplies[1].supply = "vddio";
> +	return devm_regulator_bulk_get(&client->dev,
> +				       ARRAY_SIZE(ts->supplies),
> +				       ts->supplies);
> +
> +}
> +
> +static int imagis_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct imagis_ts *ts;
> +	int chip_id, error;
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
> +	error = devm_add_action_or_reset(dev, imagis_power_off, ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to install poweroff action: %d\n", error);

Note that devm_add_action_or_reset() is special in that if it fails, it
will call the callback which is imagis_power_off().

In this case, you would disable regulators before they have even been
enabled which will cause a stack dump. To solve this problem, move the
call to devm_add_action_or_reset() from here, to...

> +
> +	error = imagis_power_on(ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to enable regulators: %d\n", error);

...here.

> +
> +	error = imagis_i2c_read_reg(ts, IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS, &chip_id);
> +	if (error)
> +		return dev_err_probe(dev, error, "chip ID read failure: %d\n", error);
> +
> +	if (chip_id != IST3038C_WHOAMI)
> +		return dev_err_probe(dev, -EINVAL, "unknown chip ID: 0x%x\n", chip_id);
> +
> +	error = devm_request_threaded_irq(dev, i2c->irq,
> +					  NULL, imagis_interrupt,
> +					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					  "imagis-touchscreen", ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "IRQ allocation failure: %d\n", error);
> +
> +	error = imagis_init_input_dev(ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "input subsystem init error: %d\n", error);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imagis_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct imagis_ts *ts = i2c_get_clientdata(client);
> +	int error = 0;
> +
> +	mutex_lock(&ts->input_dev->mutex);
> +
> +	if (input_device_enabled(ts->input_dev))
> +		error = imagis_stop(ts);
> +
> +	mutex_unlock(&ts->input_dev->mutex);
> +
> +	return error;
> +}
> +
> +static int __maybe_unused imagis_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct imagis_ts *ts = i2c_get_clientdata(client);
> +	int error = 0;
> +
> +	mutex_lock(&ts->input_dev->mutex);
> +
> +	if (input_device_enabled(ts->input_dev))
> +		error = imagis_start(ts);
> +
> +	mutex_unlock(&ts->input_dev->mutex);
> +
> +	return error;
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
> 2.20.1
> 

Kind regards,
Jeff LaBundy
