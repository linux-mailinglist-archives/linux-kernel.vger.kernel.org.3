Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3C4B19F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbiBKABQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:01:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbiBKABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:01:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002EB43;
        Thu, 10 Feb 2022 16:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpObEnlrvW67bnZbiEp5DkVvcBDUrhNrZzq1/Buaz+droaTG2MuZ2//4ylZ5aId8gj9NxNdqBgPnjob1ZKV4wYgL/bag32tUP2vx6b/bjwrc5AVx48ixX6NICR0iuqDJdhmPckAlUDyB6djF1Krw8KxwL9rHFOVPHblK4lJesOJbJpxUu87lahyKw2Ej4ECBXhIHbzfqTGlLK+JVOOISf+IptsY9NryNq4K3PuXvN94AyKFPxu88uIydNmL/l2ueOjxWoBWC0ORNmBh/qew0BN0ih5D4JiObUP1SbBYUACrpOpibwAmlhT8Q6nlUGW8xUA3AUuOnjjlqOLsXYf8Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eo/SHDyUd3QnuCCLiQT28eNZFBU/6/yDnaNOZYN/EE=;
 b=nHLotljsrDDmSiBdPLI1NONDKPAJAGp8rcfmLf91pUdI9jMbl1ItN6bFG/X25scL5ogJF80dacU981aEH3VTkW/BHzg/nLV3oLw23/BfIG2T981ibTqbVrJcuVucoFHR2IIEYIQmJ24nl9qpEOzFsaAAgJLyu6LtH+4fg1X+JEvbw4DPQby5dmx7EEcm2LS8H3ybRtHTf/WXNaaE8xRhU8Xy8Ujtbc4wclfX5ktBo1aQT4Nlai52qcK9Z6M34ctK9R/QDd4Ak7r4FjwhtWVyUpNQpiyvUmSBbBJ7ArTY2hoXkUnTtkw2Oub4hDRXXF9Zr2xRajj8Q6qFSad/RE5ohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eo/SHDyUd3QnuCCLiQT28eNZFBU/6/yDnaNOZYN/EE=;
 b=gKRfl8+m4AReM67tx+Xc291nvbg61i4iV6y9eEdA0IzL9OZqfE6qjDglMWaeKuXhUGDZNIrDtrH3+XW/x2/i6qrfmtKIEBlDgLiNJar372XnBoHcKnM8PoYFjzc5TrL5XdSxI8AWjY6EBA+zU+ojOV+0sImRJX0tU2RCKOvX100=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by CY4PR0801MB3667.namprd08.prod.outlook.com (2603:10b6:910:93::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 00:01:09 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 00:01:09 +0000
Date:   Thu, 10 Feb 2022 18:01:03 -0600
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
Subject: Re: [PATCH v2 2/2] Input: add Imagis touchscreen driver
Message-ID: <20220211000103.GA51220@nixie71>
References: <20220210163708.162866-1-markuss.broks@gmail.com>
 <20220210163708.162866-3-markuss.broks@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210163708.162866-3-markuss.broks@gmail.com>
X-ClientProxiedBy: SA9PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:806:a7::32) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5863d85-9cfa-407a-1fd0-08d9ecf19ba5
X-MS-TrafficTypeDiagnostic: CY4PR0801MB3667:EE_
X-Microsoft-Antispam-PRVS: <CY4PR0801MB366712B3F26220B2019EF410D3309@CY4PR0801MB3667.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evgVvn2a8bzFRjgFGkf24XyNHKtoQ+VRt9UXZwqiONrKybOiW/gyD+UJzWRF5cc4VI5dEl+ZnlWwBmdof9NbuL3B8+z+AJZbLbH7SEWeM3QynCJJxz1EyudDRUkF6mhlJdQg+eJgY0veeJEQKRulLJb3BQTPAKGD1zQMweUCeop5VSiR3OIzhF+O5RZ/HhId0b3dOr93jtcTAB8cKv33HNVArNRroShYE7bTVkcaoZG7IBRdRXwCxWohJKTY/lT613fFqIQ0v27OBf0cwB3+uZz7yFEbTtAbTZ6pqDwvzBbSdhWjYKFYar+x3R5ZaSowwH2AeLgruhS31fbXWe8BxPjdtx+/Q38Yn0L0sYg9/TKDoyd2eeQBkwP3qVIM/pHlkRaSccMIXDNS5lL0kInS/t+91LtinLr+XXsVQYXtsod6qDJlTUUsr1LGJ7kJea8FMlbjatHEglrHSd0jxZ81HOUKPODUh/TE4cTh/sps7KHwA4ZNzqvIb4qvYUGnf8My1V16Ml+R5vzi7hH6/WpZelg9KoaUOYEJOuyvbFO5lcL7X8eP57c73U4FLGUZYFfxdbS+/bkJ8kBeCFV6PP2uxlwEkL0FleJhO82ywXKJVYJScNCDoWxsGlgJcwveD6AjKAgzwTLWAUwpkYoRRohdVcxxwjpD6HF93MMEL+IW5NzIXGm3K/4viqUfrFWbvRYp7MBa+B/9dbNHN8lHii0RaV6maswS5Zrpt6obfusBebJariz3ppJqCtMRFaL/lAE3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(376002)(346002)(39830400003)(396003)(136003)(366004)(38350700002)(54906003)(33716001)(38100700002)(6916009)(316002)(8676002)(83380400001)(8936002)(4326008)(30864003)(9686003)(6512007)(508600001)(6506007)(6666004)(26005)(66476007)(66946007)(186003)(66556008)(6486002)(86362001)(2906002)(33656002)(52116002)(7416002)(5660300002)(1076003)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkcRJLBPFgMYqmLSQiU77rRamNciqtGeqjVS6Odrsg9jAD4ORaav404vdVra?=
 =?us-ascii?Q?yon+9RMPdp8KoTmI8AcCPlwhqv022JCXU289ubRr7FDe87kyw6dofq+n8WHY?=
 =?us-ascii?Q?EX5F8zo0PclcAvKyFJp76hLe8JXvcUJJF+DUpbY9q8WSdISMU9yMW/y8tXQT?=
 =?us-ascii?Q?d4XIzg2ad3dF+X6K6YFFQBJP0J8sf0tsgx8gGhDMXxBhENp+wf0jh1AT0xPk?=
 =?us-ascii?Q?0AjOXzFB+1JcrFtmmazagf6bZ7boLXWrpIR720MBlCVXOtqhbip46GKD70W1?=
 =?us-ascii?Q?qHJpodCIGfdzDpAiSfOONofF42fnHPPv6knHhZnGS3gxj9Zm0mTOogLk2UYf?=
 =?us-ascii?Q?bRnNE93hOaAmmnTj/sXYLKultzkSMmGU7A+cHAW1ula726O6cw/lCRQX942J?=
 =?us-ascii?Q?5H47us9M7gtK+h/4jpWgvTTRUKrUfAD0DvQ6p46xBrDSt0Cxp50y/fXl8u/J?=
 =?us-ascii?Q?ZMJ92IDOkK4M9Wdp1B7Dd7+Q0NSZBZSuwCKCSSZWG+JIkWPKMFyI0aA2hrK5?=
 =?us-ascii?Q?j5Rq6joDKo7J3UUdof98ozQL7NUrkvomsmccF1+v1svr04btCWZ+zoiyn1Vi?=
 =?us-ascii?Q?fpATIyDpbVziobEmi8vNXc2wTAc5UGRBofYJbD2s3/L92Kh4Uf97B+577QDK?=
 =?us-ascii?Q?G1g3ksUpzKY0VID2vhYqbIhTnSW2hHh3WF2wghnbmlKa5sQSQ1dNAy/f1AK8?=
 =?us-ascii?Q?n08gWQHbzN/fNrA8QVyY/+xQtWfwFMItpjdiCoq3laHfZj39tKckXePm1IqC?=
 =?us-ascii?Q?QAhDVbzrTOyCuPCM6fQuSurXj0KO9q/BYyuecMEFAfvhPtoEr4I7oqAyrquU?=
 =?us-ascii?Q?w5aelmUS5bxp5/RPwGLECpgPtwxPa/D01UaPVNZGwaL6owbnfI9h8m11ZfTh?=
 =?us-ascii?Q?IWAPNRHcgL/fk/A9BQYpJ7IgiK6n9+hHrzK5OWi+SxIW7tSPhSn67kVjuPdE?=
 =?us-ascii?Q?XO5Npz1Zp6vOTWKY52ripMPhIcfkYfgARS0F4BbdVDaR5p7w8hhKsWoIDJ94?=
 =?us-ascii?Q?G8bG+9YM3EWImu4x1zRCL7KmwRxSZghKqRaPdXnX2+G6wxoffMDBGwY2Vdjv?=
 =?us-ascii?Q?CxuO1Seuw9TwMDYD9h8lMAYFQHFulRy+YdfLT1NaSP3ET03IQK9z66jOK+B0?=
 =?us-ascii?Q?NNVCSqM/l5SA8OMRz/3h2DrV0KsjN1XvuQ4+QnWofUVQu6fyw5EzkzlzR0KU?=
 =?us-ascii?Q?MtXEWpiimWnBlxE6giv7NnC2SztBGlWyp2mSrp9z6EtY75cEprh7wq68q4RT?=
 =?us-ascii?Q?bkl67hHVeXQG8GYl3wdpo9f5IgR9ksrDkS7iBDWc4q+HQ4YhYxAUAKdpU3GB?=
 =?us-ascii?Q?9NsrmZeToMjN5A7/4P9EcFb+35gxiO/t/YibGZ1rSipwjvgfIsYzFxOKlgZn?=
 =?us-ascii?Q?3kpJ4gJniblgBjlsEuMg6Ogs6AArttKoMrppTqtOhmnpiAAEaa9ldZz0w82q?=
 =?us-ascii?Q?8enOObq+19CoF9MQaGjd6HHXS7KEUQt+/jFZe9283y0EpoL74TSeO3BH6dol?=
 =?us-ascii?Q?4PEgGjcIgZUrySjKpwXdypBGF6fhPRPWOHA4wI3z5mQoo46FgINAUCZUQL9D?=
 =?us-ascii?Q?79YJfoXMnvast8j3IG6gFyWFliIE7kxRFG5intvhBMlxcuXG+82Cy4O0HhAF?=
 =?us-ascii?Q?NmwmW4vvf8Ne5+H9AewRNg0=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5863d85-9cfa-407a-1fd0-08d9ecf19ba5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 00:01:09.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQmudTIIkG8jzoR5Bzv9VWq6QZzYJWGuaQUEn3Mde2HE1xmeqKupuhGBe1NBbRawlr9ikuLEyRSzJL/L+/SlJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0801MB3667
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

Neat little driver! Some humble feedback below.

On Thu, Feb 10, 2022 at 06:37:07PM +0200, Markuss Broks wrote:
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
>  drivers/input/touchscreen/imagis.c | 329 +++++++++++++++++++++++++++++
>  4 files changed, 346 insertions(+)
>  create mode 100644 drivers/input/touchscreen/imagis.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a899828a8d4e..f7f717ae926a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9405,6 +9405,12 @@ F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
>  
> +IMAGIS TOUCHSCREEN DRIVER
> +M:	Markuss Broks <markuss.broks@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +F:	drivers/input/touchscreen/imagis.c
> +
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 2f6adfb7b938..6810b4b094e8 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1367,4 +1367,14 @@ config TOUCHSCREEN_ZINITIX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zinitix.
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
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 39a8127cf6a5..989bb1d563d3 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -115,3 +115,4 @@ obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
>  obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
> +obj-$(CONFIG_TOUCHSCREEN_IMAGIS)	+= imagis.o
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> new file mode 100644
> index 000000000000..308f097a95c1
> --- /dev/null
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +
> +#define IST3038_ADDR_LEN		4
> +#define IST3038_DATA_LEN		4
> +#define IST3038_HIB_ACCESS		(0x800B << 16)
> +#define IST3038_DIRECT_ACCESS   BIT(31)
> +#define IST3038_REG_CHIPID      0x40001000
> +
> +#define IST3038_REG_HIB_BASE		(0x30000100)
> +#define IST3038_REG_TOUCH_STATUS        (IST3038_REG_HIB_BASE | IST3038_HIB_ACCESS)
> +#define IST3038_REG_TOUCH_COORD        (IST3038_REG_HIB_BASE | IST3038_HIB_ACCESS | 0x8)
> +#define IST3038_REG_INTR_MESSAGE        (IST3038_REG_HIB_BASE | IST3038_HIB_ACCESS | 0x4)
> +
> +#define IST3038C_WHOAMI			0x38c
> +#define CHIP_ON_DELAY				60 // ms
> +
> +#define I2C_RETRY_COUNT			3
> +
> +#define MAX_SUPPORTED_FINGER_NUM		10

Please prefix all #defines with a common namespace (e.g. IST3038C).

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
> +	unsigned int reg_be = __cpu_to_be32(reg);

Technically this type should be __be32. Also, why to use __cpu_to_be32 in
place of cpu_to_be32?

> +	struct i2c_msg msg[] = {
> +		{
> +			.addr = ts->client->addr,
> +			.flags = 0,
> +			.buf = (unsigned char *)&reg_be,
> +			.len = IST3038_ADDR_LEN,

I do not think we need these #defines; just use sizeof(reg_be).

> +		}, {
> +			.addr = ts->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = (unsigned char *)buffer,
> +			.len = IST3038_DATA_LEN,

Same here.

> +		},
> +	};
> +	int res;

For these return variables that may be positive or negative, it is more
common to use 'ret'.

> +	int error;
> +	int retry = I2C_RETRY_COUNT;
> +
> +	do {
> +		res = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
> +		if (res == ARRAY_SIZE(msg)) {
> +			*buffer = __be32_to_cpu(*buffer);
> +			return 0;
> +		}
> +
> +		error = res < 0 ? res : -EIO;
> +		dev_err(&ts->client->dev,
> +			"%s - i2c_transfer failed: %d (%d)\n",
> +			__func__, error, res);

Does this controller suffer some sort of erratum that requires I2C reads
to be retried? If so, it would be handy to include a comment here as to
why we do not expect the read to be successful right away.

> +	} while (--retry);
> +
> +	return error;
> +}
> +
> +static irqreturn_t imagis_interrupt(int irq, void *dev_id)
> +{
> +	struct imagis_ts *ts = dev_id;
> +	unsigned int finger_status, intr_message;
> +	int ret, i, finger_count, finger_pressed;

Please use 'error' for return values that only return 0 or an -errno.

> +
> +	ret = imagis_i2c_read_reg(ts, IST3038_REG_INTR_MESSAGE, &intr_message);
> +	if (ret) {
> +		dev_err(&ts->client->dev, "failed to read the interrupt message\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	finger_count = (intr_message >> 12) & 0xF;
> +	finger_pressed = intr_message & 0x3FF;

Please #define bit shift and masks, with GENMASK used for the latter.

> +	if (finger_count > 10) {
> +		dev_err(&ts->client->dev, "finger count is more than maximum supported\n");
> +		return IRQ_HANDLED;
> +	}

You seem to have #defined the maximum finger count but it is not used here.

> +
> +	for (i = 0; i < finger_count; i++) {
> +		ret = imagis_i2c_read_reg(ts, IST3038_REG_TOUCH_COORD + (i * 4), &finger_status);
> +		if (ret) {
> +			dev_err(&ts->client->dev, "failed to read coordinates for finger %d\n", i);
> +			return IRQ_HANDLED;
> +		}

Can this not be done in a bulk read so as to save up to 10 stop/starts?

Maybe it makes sense to define a bulk read function, with imagis_i2c_read
simply calling the bulk read function with a fixed length.

> +		input_mt_slot(ts->input_dev, i);
> +		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
> +					   (finger_pressed & BIT(i)) ? 1 : 0);

No need for the ternary operator here; just pass the boolean as-is.

> +		touchscreen_report_pos(ts->input_dev, &ts->prop,
> +				       (finger_status >> 12) & 0xFFF, finger_status & 0xFFF, 1);
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, (finger_status >> 24) & 0xFFF);
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
> +	msleep(CHIP_ON_DELAY);
> +
> +	enable_irq(ts->client->irq);

This is going to cause unbalanced irq enable/disable because you're calling
this function from probe.

> +	return 0;
> +}
> +
> +static int imagis_stop(struct imagis_ts *ts)
> +{
> +	int error;
> +
> +	disable_irq(ts->client->irq);
> +
> +	error = regulator_bulk_disable(ARRAY_SIZE(ts->supplies),
> +				       ts->supplies);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to disable regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;

This is largely personal preference, but this is shorter:

error = ...
if (error)
        dev_err(...);

return error;

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
> +	if (!input_dev) {
> +		dev_err(&ts->client->dev,
> +			"Failed to allocate input device.");
> +		return -ENOMEM;
> +	}

No need for a message here.

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
> +	input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);

WIDTH is advertised here but never reported in the interrupt handler.

> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(input_dev, true, &ts->prop);
> +	if (!ts->prop.max_x || !ts->prop.max_y) {
> +		dev_err(&ts->client->dev,
> +			"Touchscreen-size-x and/or touchscreen-size-y not set in dts\n");
> +		return -EINVAL;
> +	}
> +
> +	error = input_mt_init_slots(input_dev, MAX_SUPPORTED_FINGER_NUM,
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

I suggest using the device-managed version here, as you have no remove callback.

> +
> +	return 0;
> +}
> +
> +static int imagis_init_regulators(struct imagis_ts *ts)
> +{
> +	struct i2c_client *client = ts->client;
> +	int error;
> +
> +	ts->supplies[0].supply = "vdd";
> +	ts->supplies[1].supply = "vddio";

How does this work?

> +	error = devm_regulator_bulk_get(&client->dev,
> +					ARRAY_SIZE(ts->supplies),
> +					ts->supplies);
> +	if (error < 0) {
> +		dev_err(&client->dev, "Failed to get regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imagis_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev;
> +	struct imagis_ts *ts;
> +	int chip_id, ret;
> +
> +	dev = &i2c->dev;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client = i2c;
> +
> +	ret = devm_request_threaded_irq(dev, i2c->irq,
> +					NULL, imagis_interrupt,
> +					IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> +					"imagis-touchscreen", ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "IRQ allocation failure: %d\n", ret);

Are you sure it's safe to enable interrupts before the controller has
been powered?

> +
> +	ret = imagis_init_regulators(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regulator init error: %d\n", ret);
> +
> +	ret = imagis_start(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regulator enable error: %d\n", ret);
> +
> +	ret = imagis_i2c_read_reg(ts, IST3038_REG_CHIPID | IST3038_DIRECT_ACCESS, &chip_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "chip ID read failure: %d\n", ret);
> +
> +	if (chip_id == IST3038C_WHOAMI)
> +		dev_info(dev, "Detected IST3038C chip\n");

This should be dev_dbg, if at all.

> +	else
> +		return dev_err_probe(dev, -EINVAL, "unknown chip ID: 0x%x\n", chip_id);

Usually you want to ID the controller as early as possibe, to avoid wasting
time allocating resources if there is a problem.

> +
> +	ret = imagis_init_input_dev(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "input subsystem init error: %d\n", ret);
> +

Just for my own understanding, this controller needs no configuration or
register writes after power-on?

> +	return 0;
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

I would prefer to salvage the return value and return it after mutex unlock.

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
> +
> +	mutex_lock(&ts->input_dev->mutex);
> +
> +	if (input_device_enabled(ts->input_dev))
> +		imagis_start(ts);
> +
> +	mutex_unlock(&ts->input_dev->mutex);
> +
> +	return 0;
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
> +#endif
> +
> +static struct i2c_driver imagis_ts_driver = {
> +	.driver = {
> +		   .name = "imagis-touchscreen",
> +		   .pm = &imagis_pm_ops,
> +		   .of_match_table = of_match_ptr(imagis_of_match),
> +	},
> +	.probe_new	= imagis_probe,
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

