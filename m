Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59459F895
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiHXL0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiHXL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:26:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8557FF93
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNT3M2u9vX2ya3AmRkPuYn+oeycq8KYcfDtHMl2BwWVA/bS8Ffd8KUIb1B7+jE4ImMNIwq7eizKRLWh5moUZG1cGMpOy5Yq4g8AsVjqcuWl9DlcY7lfuHs4SyFpdsQxvo+DrsFtoWoT6umcdw85OAQa/4rdct8FQJG7nuDStMoPzeVSohcHGyDydv61y44ykcJBywquQqKsL1L7MaesXxfoWp38aoOXL1o+C5hQJvJH5ddmuzkgj69cY3iJZJZ8R8I0vTQmCfDJALDXQ8PWXNa9MsA0aULBJ4r4E5obNjzeF2deHTZ62LDd9ojSoGqIbEuQktOwj4ZYL+PqD8R7+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGY6zJ/7hFrAGWarjqTBEhaXiYgS/fBxD1Up+ksDVow=;
 b=ZrMo7cgQEXfECM1/xmRIAztUs2bbDWwI76zbTeSs82tscNKGucYz12rE7RyBRXMLu3hSLgF5N8M84RAJEIfepDTVRl1rZD7UQSDnvp89NCsHZygVq+dKIu941+fXtxkc5Wn0/mi3bisrcjks09zgXFHHLtDyG9TlZVVsrf+bCMxk0fts1vpPUIztVHsSupPQwM/hWTaXXEtWszi4L267UhDZy4HIC+rcuBzkYPChsJNAj9oH5A2umkjQSQSIJaEytH7rgsCKEWibIJVxiwh58nxp9dHXkJpq35dVeHTT/kmyoKMFVDU0FIKjR/zsQRFbHDKU7VCY3Nxq5cICXwrYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGY6zJ/7hFrAGWarjqTBEhaXiYgS/fBxD1Up+ksDVow=;
 b=tzbbrVorm167nqblneQxpNshKTXxM+5c4sx5UzVZi3+yjfl1WakOQRDiXOha9tUc1sX3etA81LtFBbYg/ppVBoQGLE9e953qubUw/o45aJ8+WLLloksTA0dG6ivsVlWdbAAKRZkuv51TDWmft1ZtsDZ0M8kir/HrS/GKj0f8PYMjfIAphYdKyEvPI/1fC+8NfcjiOvJ3BsVpmaqKWc2DHMtsn232JArHjcLyLOaqNnEEvEcgmaEaq6O/TC0bomgxC1x0prVL+MPaic+W6BkNPj9sbGafv2fGQdLtVoYHXaVmtncT7tLbqwl27AKWdqc+zIVZoIJixlT/xGxegdGJgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 11:26:46 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb%4]) with mapi id 15.20.5546.021; Wed, 24 Aug 2022
 11:26:46 +0000
Message-ID: <d380c319-6266-ecd2-095e-1fdddbed6640@suse.com>
Date:   Wed, 24 Aug 2022 13:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/5] drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT
 display driver
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-3-cmirabil@redhat.com>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20220823174158.45579-3-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::7) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1463a1da-840e-40b2-ca4a-08da85c3875c
X-MS-TrafficTypeDiagnostic: DBAPR04MB7366:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvW2DsnQSIcxdNRJvuTrrnXOj59zH2pBXiqAREbXz/yQk5iN4oTjxqQkJ9YetRm8K5EPJmXZRFRvE8Ea+OKInZ1ztvYenTFh0AILaF7kMN1ifgvDwekggk27vm05WvjIMPlwaH+V610jJPC2rIaOB8/9pifvNHJBCW43LtndOvgWFZw2dYkwuO4JJ7j6uhcCUNAmDsaLMWORjSeM+ZfLbGn2nL7g8BmKpf1HZnMSn0G0Vzln7h7sSj8Mn4FEzusXFLzvjyXtadPb2BvaRtidtaQv+SsLN82d9P83ZVsuX6FdhXXwnkr24OUoa3W0DI24v3fCR0+q8jPlkp6IS1LFg+GwfXu+xFHFtN2pNnsLc2xKdoVeMBI7KRLwFyL63m30NwU6LP5nbTVMt5t/xxeltL83RVVwhdXi4rIqdU0dNYm9UQKeESJhBM+S5fy4JtOlrqU6u8DaBecAQhtm7k6quvbaTf90Nc7tHNAwXxU2mm3F1vkOkhNuWk9iwFkZunBvQ0tKDMt4du99hw6A4cuzjZMF0yilSN0+h2Vfa3vewj7u3fk+bb9bsOFLjZ14ne3tzEz+246aTjUEMDaWVyNJLSqbQzDawpZco5eTPodXL6KFE92RbSs9nicT3fBCTSAFmIm5c2J+4mRt8T+KsdNeo82o40MXjAsVZF0Efn1FB7gBzxH6ppQXkEmffrl/kfmqF0JMAUB581XgQ/S9culKqv3z+2G7ELQfqycYomiEL0wYi/CnslY3yhl0mihsJAon+MtNzi5s8tTSD0Iov8CgGpjMwyq+wj4lyI9aVQRfjbPuiMITkBb2HRXPAHpBr++9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(366004)(396003)(8936002)(66556008)(31686004)(4326008)(66946007)(66476007)(8676002)(7416002)(2906002)(54906003)(5660300002)(316002)(478600001)(6486002)(966005)(6506007)(41300700001)(26005)(53546011)(6512007)(2616005)(38100700002)(31696002)(86362001)(83380400001)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtWR1UwY3hSYTFXZGwwY09HSnNxelpmNllmYnM5eGxkaW5sQnBRVWgzZ2RF?=
 =?utf-8?B?S2RJTzZ6K1hyaWZvRkkxK0pNQTl3UjNLdkRLdldxMmptZkEzeFBzZjJFbVVN?=
 =?utf-8?B?VjhsU081NlV4ZjBjbURGeTJLT21maGpBeDAyMnFuTE9VczJsOVhoc2Zyb3lu?=
 =?utf-8?B?MDF4UTJPRnZkK0IxelRnbk83NlR2Sk9JdnAyL1JoYnNiSFBvNW5kc2g4SXBL?=
 =?utf-8?B?NEhCZk9HQm5FRkVhQ0JFS0YxMk5aWERmTEdNUEMvMytmT2o5djhTYUtQL0R2?=
 =?utf-8?B?bnJuSXJ5S3k5bGJBTlZzdlJUcGJqNlNobmlMeFA2ZStSWkZ6SENBdzZlcXgr?=
 =?utf-8?B?NWlpMVdmZEpyayt2Sld4eW1pZm1BaGw3RmJMYktCbExsTVNsTmRhamgrRkNL?=
 =?utf-8?B?Vm5DRjlFb3BPWmhCUGF5L3JKdmlYMms0YUUvUXZwOUt5THVJTjVkV1FZR2Q4?=
 =?utf-8?B?NzZPNlVaVnFrQjZaSlNENi9lN2F1RFgxOVNKS0N2dGxnZC9xb0xVazJxSTBU?=
 =?utf-8?B?Sk02N3krVVNDMmRTdGVBczIyVnEvTnJnVldXWHcyVm9HeW44em43MGRjWXYy?=
 =?utf-8?B?TnhiUEp2UXNOTkhkcGpiYUFYNzRSMzErUXVQaFgwWmRscEJoc2g3Ri9WeGg5?=
 =?utf-8?B?NmY1SHF3WE5rTGk3WnpCSmV6OFF5RksyVklvZzE4TWIwY296bEVzRzliaStB?=
 =?utf-8?B?eE00RGk3WjhsYWRDSnIzNjMxSHJKRnFiZ0pOVmJseDc0aEszajYzMGpza0xp?=
 =?utf-8?B?LzdiMW1zci9TREZhL1UvbUJtcUNFa1FVdTc1bVNiOEx4NVkyWndTdmFnYnJm?=
 =?utf-8?B?ckttT1N0L2VramRSM0tNakp1aTdNQ2FyVTdFOE5OclFPZlJjVk9DbmV1Sm8r?=
 =?utf-8?B?Z2tMYWVyZ1NrWCswYjdqTlZwNW53TWZXdDNYVy9hckNoODdGQ1Z1ZStFWG82?=
 =?utf-8?B?dFRPNEdHZWFULzhtckN6bFdTVm9Ralp6NUVkUW9JQW1sUzZXVUYzOUJFVFJM?=
 =?utf-8?B?bk5RT1hndExkMWg5OFUwYmlYYTRRei90cnJzZ0NGVUkzcDFPYmhsWGJoTnVI?=
 =?utf-8?B?T3JtU0pJeWZ1TU9FY293cDJlZ3R2YW9hRW10bVN2NklJNGFlQ2h1dWMwZjlk?=
 =?utf-8?B?RE9XaWFKSHdGdkdqSGJxekdzYjVRSWg5ZU15WXdMQkx0YTJKZEZDMU9QeDJ6?=
 =?utf-8?B?aUF1ZDN3bzZnS0RiQ2ZIWkY2enJlTEhyUEtncEZ4emN6ZE1oc0JFNjV3aDl5?=
 =?utf-8?B?TVNoUkIxTThyWnhvTHI1WnZ0WGhqTVhjVDJQMEpvcmRvMjVaandjdUYwdVg3?=
 =?utf-8?B?RW1Qdmg4cTNGajA4YytYK0dRMXNVT1RvWHlGbU5zajM3L3V1SXloQnlqUDFr?=
 =?utf-8?B?N0dwMnVxa1VrbEhUTlRVc2FiN2hqaXJQUzNKRjg4cTFEK0dtVTNVam5CNFgz?=
 =?utf-8?B?T2Q3YVJpMElpaHN6cHQ5Q1N6M1ZFaW9DeWpmblFPQklFajBYSDhvYjFZUEU3?=
 =?utf-8?B?V1FkTmxqMUtuVCtQREtJTGVxY1F3NHhneFZQWk53R3F6NVpaWXhHMis0QTM5?=
 =?utf-8?B?Z2RMVUN6eDJmc3lOaWpLbVRmMWpZTFg0cnNKK3A0SXRYeVRFMUhDSGR4ZWpo?=
 =?utf-8?B?UnlnMUlxZi9rV1NJa3ltemFFeWlGMUU4cW1jMDFhNlJ5N0tnQ2UrUU1EVW50?=
 =?utf-8?B?M1BReERtS2FMcW84MjN4Zm9yaDR5VXFzSjBZTUJodjNGT2FOSTAramFQM1do?=
 =?utf-8?B?K3VjMDZ1dWUxMllkeWVoQ2ROY3IzQkt0emY2enJPd0taSFVkYzlOT3lHWGY3?=
 =?utf-8?B?N255UGZvQkRmUUV2dEM2M1lFN0xSUHhqY2cwczBLcm4wZVg3ejRpQmFwMUNy?=
 =?utf-8?B?ZEZXWm40ZTFiRnZaOTlGS2tpbThZdVlBT3pvYkFCMHYxcFhkUS9KeE1OY1Fh?=
 =?utf-8?B?R1E4R01HaUpzOVkxc3NkVHJlVlc0VjVDSEpSeEhDUFpDUUtvdWc1NUo0WHdY?=
 =?utf-8?B?MGtRVG1leFhWK0tOdGwwczRueW5uUXZrUCtJUzcvcC8wM0N1UXkxcWZPMDIr?=
 =?utf-8?B?bUlqNm9sMmZNcUtEZnpIcjB1L25aRXhhU05KdEVEU1gyMmowaGtNN3NuRjh0?=
 =?utf-8?Q?HxFrffn/P/fWm932PsklK7zY2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1463a1da-840e-40b2-ca4a-08da85c3875c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 11:26:46.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqIt/P64eS/SBKUpl2zDmPTXV9Y28XcQ35so6eYdlF4Qm7/cit3oUtPxcwL7tAwlLouuCRRBmorL7GpTbexXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2022 19:41, Charles Mirabile wrote:
> This patch adds the driver for the 8x8 RGB LED matrix display
> on the Sense HAT. It appears as a character device named sense-hat
> in /dev/. That special file is 192 bytes large and contains 64
> RGB triplets (3 bytes each) one for each pixel in row major order.
> 
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>

As this is a 8x8 pixel display, I think it makes no sense to implement this as a 
tiny DRM driver, so:

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/auxdisplay/Kconfig            |   8 +
>   drivers/auxdisplay/Makefile           |   1 +
>   drivers/auxdisplay/sensehat-display.c | 205 ++++++++++++++++++++++++++
>   3 files changed, 214 insertions(+)
>   create mode 100644 drivers/auxdisplay/sensehat-display.c
> 
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 64012cda4d12..9bad1aade7a0 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -203,6 +203,14 @@ config ARM_CHARLCD
>   	  line and the Linux version on the second line, but that's
>   	  still useful.
>   
> +config SENSEHAT_DISPLAY
> +	tristate "Raspberry Pi Sense HAT display driver"
> +	depends on I2C
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	 This is a driver for the Raspberry Pi Sensehat 8x8 RBG-LED matrix
> +	 you can access it as a misc device at /dev/sense-hat
> +
>   menuconfig PARPORT_PANEL
>   	tristate "Parallel port LCD/Keypad Panel support"
>   	depends on PARPORT
> diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
> index 6968ed4d3f0a..30b2b7934046 100644
> --- a/drivers/auxdisplay/Makefile
> +++ b/drivers/auxdisplay/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_HT16K33)		+= ht16k33.o
>   obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
>   obj-$(CONFIG_LCD2S)		+= lcd2s.o
>   obj-$(CONFIG_LINEDISP)		+= line-display.o
> +obj-$(CONFIG_SENSEHAT_DISPLAY)	+= sensehat-display.o
> diff --git a/drivers/auxdisplay/sensehat-display.c b/drivers/auxdisplay/sensehat-display.c
> new file mode 100644
> index 000000000000..08c0c4338f3e
> --- /dev/null
> +++ b/drivers/auxdisplay/sensehat-display.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Raspberry Pi Sense HAT 8x8 LED matrix display driver
> + * http://raspberrypi.org
> + *
> + * Copyright (C) 2015 Raspberry Pi
> + * Copyright (C) 2021 Charles Mirabile, Joel Savitz
> + *
> + * Original Author: Serge Schneider
> + * Revised for upstream Linux by: Charles Mirabile, Joel Savitz
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/miscdevice.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>
> +
> +#define DISPLAY_SMB_REG 0x00
> +#define RGB_555_MASK 0x1f
> +#define NUM_LEDS 8
> +#define NUM_CHANNELS 3
> +
> +struct sensehat_display {
> +	struct platform_device *pdev;
> +	struct miscdevice mdev;
> +	struct mutex rw_mtx;
> +	u8 vmem[NUM_LEDS][NUM_LEDS][NUM_CHANNELS];
> +	struct regmap *regmap;
> +};
> +
> +#define VMEM_SIZE sizeof_field(struct sensehat_display, vmem)
> +
> +
> +static int sensehat_update_display(struct sensehat_display *display)
> +{
> +	int i, j, k, ret;
> +	u8 buff[NUM_LEDS][NUM_CHANNELS][NUM_LEDS];
> +
> +	for (i = 0; i < NUM_LEDS; ++i)
> +		for (j = 0; j < NUM_LEDS; ++j)
> +			for (k = 0; k < NUM_CHANNELS; ++k)
> +				buff[i][k][j] =
> +					display->vmem[i][j][k] & RGB_555_MASK;
> +
> +	ret = regmap_bulk_write(display->regmap, DISPLAY_SMB_REG, buff,
> +				VMEM_SIZE);
> +	if (ret < 0)
> +		dev_err(&display->pdev->dev,
> +			"Update to 8x8 LED matrix display failed");
> +	return ret;
> +}
> +
> +static loff_t sensehat_display_llseek(struct file *filp, loff_t offset,
> +				      int whence)
> +{
> +	return fixed_size_llseek(filp, offset, whence, VMEM_SIZE);
> +}
> +
> +static ssize_t sensehat_display_read(struct file *filp, char __user *buf,
> +				     size_t count, loff_t *f_pos)
> +{
> +	struct sensehat_display *sensehat_display =
> +		container_of(filp->private_data, struct sensehat_display, mdev);
> +	ssize_t ret = -EFAULT;
> +
> +	if (*f_pos < 0 || *f_pos >= VMEM_SIZE)
> +		return 0;
> +	count = min_t(size_t, count, VMEM_SIZE - *f_pos);
> +
> +	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
> +		return -ERESTARTSYS;
> +	if (copy_to_user(buf, *f_pos + (u8 *)sensehat_display->vmem, count))
> +		goto out;
> +	*f_pos += count;
> +	ret = count;
> +out:
> +	mutex_unlock(&sensehat_display->rw_mtx);
> +	return ret;
> +}
> +
> +static ssize_t sensehat_display_write(struct file *filp, const char __user *buf,
> +				      size_t count, loff_t *f_pos)
> +{
> +	struct sensehat_display *sensehat_display =
> +		container_of(filp->private_data, struct sensehat_display, mdev);
> +	int ret = -EFAULT;
> +
> +	if (*f_pos < 0 || *f_pos >= VMEM_SIZE)
> +		return -EFBIG;
> +	count = min_t(size_t, count, VMEM_SIZE - *f_pos);
> +
> +	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
> +		return -ERESTARTSYS;
> +	if (copy_from_user(*f_pos + (u8 *)sensehat_display->vmem, buf, count))
> +		goto out;
> +	ret = sensehat_update_display(sensehat_display);
> +	if (ret < 0) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +	*f_pos += count;
> +	ret = count;
> +out:
> +	mutex_unlock(&sensehat_display->rw_mtx);
> +	return ret;
> +}
> +
> +static const struct file_operations sensehat_display_fops = {
> +	.owner = THIS_MODULE,
> +	.llseek = sensehat_display_llseek,
> +	.read = sensehat_display_read,
> +	.write = sensehat_display_write,
> +};
> +
> +static int sensehat_display_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	struct sensehat_display *sensehat_display =
> +		devm_kmalloc(&pdev->dev, sizeof(*sensehat_display), GFP_KERNEL);
> +	if (!sensehat_display)
> +		return -ENOMEM;
> +
> +	sensehat_display->pdev = pdev;
> +
> +	dev_set_drvdata(&pdev->dev, sensehat_display);
> +
> +	sensehat_display->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!sensehat_display->regmap) {
> +		dev_err(&pdev->dev,
> +			"unable to get sensehat regmap");
> +		return -ENODEV;
> +	}
> +
> +	memset(sensehat_display->vmem, 0, VMEM_SIZE);
> +
> +	mutex_init(&sensehat_display->rw_mtx);
> +
> +	ret = sensehat_update_display(sensehat_display);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Could not communicate with sensehat");
> +		return ret;
> +	}
> +
> +	sensehat_display->mdev = (struct miscdevice){
> +		.minor = MISC_DYNAMIC_MINOR,
> +		.name = "sense-hat",
> +		.mode = 0666,
> +		.fops = &sensehat_display_fops,
> +	};
> +
> +	ret = misc_register(&sensehat_display->mdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Could not register 8x8 LED matrix display.");
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev,
> +		 "8x8 LED matrix display registered with minor number %i",
> +		 sensehat_display->mdev.minor);
> +
> +	return 0;
> +}
> +
> +static int sensehat_display_remove(struct platform_device *pdev)
> +{
> +	struct sensehat_display *sensehat_display = dev_get_drvdata(&pdev->dev);
> +
> +	misc_deregister(&sensehat_display->mdev);
> +	return 0;
> +}
> +
> +static const struct of_device_id sensehat_display_device_id[] = {
> +	{ .compatible = "raspberrypi,sensehat-display" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sensehat_display_device_id);
> +
> +static struct platform_driver sensehat_display_driver = {
> +	.probe = sensehat_display_probe,
> +	.remove = sensehat_display_remove,
> +	.driver = {
> +		.name = "sensehat-display",
> +		.of_match_table = sensehat_display_device_id,
> +	},
> +};
> +
> +module_platform_driver(sensehat_display_driver);
> +
> +MODULE_DESCRIPTION("Raspberry Pi Sense HAT 8x8 LED matrix display driver");
> +MODULE_AUTHOR("Charles Mirabile <cmirabil@redhat.com>");
> +MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
> +MODULE_LICENSE("GPL");
