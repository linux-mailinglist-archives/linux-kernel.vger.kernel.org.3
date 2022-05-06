Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606FA51DA3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442111AbiEFORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiEFOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:16:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2666F93;
        Fri,  6 May 2022 07:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOm0Th0bc8vF7tllpLuNixK1IhOx6pHPh2sIGdWvNjzaB00ZiNh6h9nxZOm4cNmwHMBpvABHenE9gpT3Ipe1DbwxHVEUiL+0Eexx9DTT1m1EfKL53Qs7zCQGa6DbtIc+0ZoPHf8xm0q5UAXCv+eck3Mag+Pu6pkQATyFBMgxu36Q9WNgdnBDAuUOu0hQiYw7Mcoh8DssTVgYX3340BJT6zZPJEpun0R83/J0+QgTwE/nwkWDE33kaPwoU9bfpxRkyUIU5tnF7guoDOodtKMejpKeMG6lIT1DIgtCczczuJdscZuVxKPp7awxFbMO5Qzz08kP5NPNcjTB0RpWFCQsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haLKfs+Ff1scJVqSXt7Wy2QPgOQxa7moyHpZzYD71f0=;
 b=BUC+ze03njSpIXxmY1f/X//MwzLdkToYp4/zIpWX09v/bSVTsSlPBqhccESrBceUmcHWdoQ1j5d3/FZHJUpeCECZxTWhsabFeZiM1IqYs8OOugNUE5oaEo2lNvcy7LGgG7u60Bh0BXb2n503ccP04F5gVciuHmilHTjVnQumwT706M6icAfT8LECAkxFJUZ8oOhMKwtGMOo0lgGsVweakmwGU4tnA4203rtKxeSTzvMwnjyo7WL8RlOJ9VlRVvVLNPbP9xHZ/+hpF8peU9HPDZPb1mZtf7YGKndDPgE6ZS2nfM8cSidjtrD2a5OCc/7rfiRv4eSnwPaKYGSzQa+f0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haLKfs+Ff1scJVqSXt7Wy2QPgOQxa7moyHpZzYD71f0=;
 b=Bqfwb9lqMZmKyQnqanyPs+Pghjj2kYWH3RsQut3n87xO6tY6yNUcXFXrBP499gHj8RbkZ5DWSKlMOs9tjS2gO2lAO34Cqwxoa+IjrfctgNL1ihaUGc/JDHReBjD708gMpbiNRNND7OQxpMK5Evo9MnB4duw8xCcm/ZHqW1cIO/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Fri, 6 May
 2022 14:13:09 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::28d3:b4fa:2319:83fb]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::28d3:b4fa:2319:83fb%5]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 14:13:09 +0000
Message-ID: <1344ed86-1505-a1af-1671-67106a4b9cf7@theobroma-systems.com>
Date:   Fri, 6 May 2022 16:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/3] media: ov5675: add device-tree support
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504135543.59522-1-foss+kernel@0leil.net>
 <20220504135543.59522-2-foss+kernel@0leil.net>
 <20220505074725.4aabembd4uh4tt23@uno.localdomain>
 <YnOKuGqQ74rGUz6q@valkosipuli.retiisi.eu>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <YnOKuGqQ74rGUz6q@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::32) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e819c3b2-629f-4c8a-5786-08da2f6a8c15
X-MS-TrafficTypeDiagnostic: PA4PR04MB7647:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB7647E99A7DFA419DF40D71DAC2C59@PA4PR04MB7647.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJ1mHCxhbu3nMLqWOjiHJ7WTtddxFuCLYfdYuQ1QCbqtEsUP/4C4xTI2jk3VLF5E39NhNBTtGf3xlnTY5CBPs+792eql8K+hut8s6J7cwZVEYNxmfOQtyK5eb7yUgh5Lscc8tQ3zNIn8CqEd6WF52aw6Ncep3zCzuG3ZxVygAIDN2rRe8eJEyqvGPgziUtKfGOPWm92Lss8hO6vF+4IKFISYPDBnP647n6ZAE1WQJ2BzyGRJ8hVNZp4S64olJcKlsMtnMF0Xk4GeCKm83g2wCwe67Yp20qQk3CdgfYRx2yfKrnTrHX26t8QAuxF2rgoMJwIm6VCzRRWEvv+QFyYmbgYHqDZPSiQWwflq9uQ+wd6/KZVWkn188NBu1XJ4UtYbH3JjBv1iSHx/+XSoa73pRzXS+eFZ0+msu+hBu7myKKdkdxz+yZ1maTZjYQBAq3aFyHs/M2z/lr/nq0maxFQnDxEwNa7F9wkcyJzVWw4r8Urwv2n4S/5VCz89h9uMGD70y2vtwYn/EzpZvmeCQnFGO1VVAd0Y4YFbUNI2nA4823W6EH9P3C8I4QqvLq8wH3LCs57wjGIb3zGC9CvLkVkLbmEq6VqaCCkER/cyum6fFa+dlYovw2mZivt7tzIkRX0nDj0745EbGgyGVCCazXT638slpM7r664Sfzbd4aLkwBfPxO4rUFzkPTObcWnZ0Ab1U0NJ/ErVQx4ZrjZsbZaEIAo3nLR9LQ/jx2rCOb+63EgJdjZiZ/oulEzlB/lILuMqgCuzdvKt1O+RxsengNqt2pprC5fJF9OOjsVedTVcNBFTsv8D5JaUdHZARlKnWV2k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2906002)(38100700002)(5660300002)(7416002)(44832011)(30864003)(86362001)(31696002)(966005)(6486002)(316002)(110136005)(8936002)(66556008)(66476007)(4326008)(8676002)(66946007)(6512007)(83380400001)(26005)(6506007)(2616005)(53546011)(186003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2MyZTV5aWwrVTgzUGdpeXg3cmcwdmNXV2ZRTmdJb1RzL1VrbFdOSjhQY2gr?=
 =?utf-8?B?VW9zTTVjMGRVT3hTSm5vVG13ZUdaQmdRVEVFTXZpK1dZTVBHYmhxeUw4QURB?=
 =?utf-8?B?Z1lheGo2b3VkUGNTcFA1eGc4RUlRbkpsZEs2bkFFQklGcW11WUYyY3RQcWpC?=
 =?utf-8?B?MUNWQ2xTTGcyWWxOa3hKRGx5NW1TRkwzTzdibFZxYnQ0MEVOMjhDaG9YRWY3?=
 =?utf-8?B?Y0ZQb0IrRHdBOFJUZ1JBZFJvTTcvRDBwQWtoc0tnVDZlUnBMeEpwUFplODVT?=
 =?utf-8?B?elVVaHM4V0YvU3MvSVV0U0JQYVMwVzVTeEZyK01ZSHJjcStGWnFOMjl0UWtJ?=
 =?utf-8?B?YXVNY1lUMGRFRUJzamdHcjRPTGp5SzRpMGdWcVZqVFNGbDB4M3BqemhPa2I0?=
 =?utf-8?B?cDhFdER6OU1POENKVE1xMzI3ZFRHRzZvT0xrcEp6Q0dDaEl5K0NCQU90cnYw?=
 =?utf-8?B?M2kwQjU5L2ZrYi9MdS9lbmhLMEQwbmZNa3hvUWdkZ0Nqa3ovMHdSWUVwNUZT?=
 =?utf-8?B?UnEySGo3M2I1ZjFCQjFxK0dnR3VWa1Qza3hRWUFwWndWSklwTjI3dXdybXNn?=
 =?utf-8?B?U1kwTVd0VjVWY2d0S29MZ3RxeG1TU2UzbXhlb3RJbVFXWWNGOWl3VjdqeTZL?=
 =?utf-8?B?L0JoMkE4ZjJqUmRqbTl6elpveEozSXFGM3Q2aXQ2eGNBcDE0dk1LcERscDRB?=
 =?utf-8?B?TU9xVTN4MHFHNGRRK25CTHozMmVheVU4eXkzRDVsWStGS2NqRHR1YXNnT0Qx?=
 =?utf-8?B?MUx3L1dyeVpZYUpEOVNzYkNqYzI5WFN0YU9pZUlBNkk1c1htSUdNbUJqU2tk?=
 =?utf-8?B?aFVrTnM2cjVDTjQwQ0JCbWtJbjFVOUpKOUFyWVpDRXZaKzJLMWFkN0ViRnRD?=
 =?utf-8?B?QkVXMjdyYW5qRVVwZlBRMFNKbmJVM3Jhc2NndnpVZ1NoVjdtOXluZ2pJaW5V?=
 =?utf-8?B?dW5hSXdSVWo3ZTFBMzVQcVlpeXA3bm12akc2VncrcVpGT0ZKVjhpZzFkWmY5?=
 =?utf-8?B?S0VwMlBnQU45NHJVdUtxR2tTdFJQK1grOE1DU2RvU0I1dXg3Y2hpYVZTd0JC?=
 =?utf-8?B?Wll5ZFhOYjdkcitMck96Tm9PSk16R2QrY0tMVUh3MGxXSEZGRFJHb1pXcHE1?=
 =?utf-8?B?OXZQRGY1c0ozSFJoaS96aytJalFWRk1ITUZzSE1raDNDZVl1WUo0M2VKTElw?=
 =?utf-8?B?dTgxa1VQb1ZRY2pLS0tMdVFwM0YxNEM3UllkZlc2TzFSNnVyejZMdGtKSlFI?=
 =?utf-8?B?NE9NYjdCbllHNHVQdElKSXVWMXJudlhKcmY0clZGQU1OM2RkZWYyd2lma01s?=
 =?utf-8?B?c0ZObU9VRTR0K2thOG9ocHJ2Z21XWjJtQTlpWlpETnpUNEZyTVZLSmU0bWV6?=
 =?utf-8?B?enliQkM1ZkF0WFprdjcvY3ZGSjl1VldPdlJWazVHL1N5aG1naHdLR2Iveiti?=
 =?utf-8?B?SmRieHFRZXJ2SUxRK01LUDNYRWtpcW1hRFl4NjhLMy9melBxV0c5NTJzWHNL?=
 =?utf-8?B?UVdMNXcxQzl0YnlkbnRGZW96aHFJSjE1WHZkamtsYXVGZUhVNHdwUGpCQnRt?=
 =?utf-8?B?cHdjYUVYYnZxMTdWYUl3T2x5YWxQNE1DSmFNSHVyRW5yc0RPbXQ5S0M4OWxZ?=
 =?utf-8?B?eFc1UWVha3Iwa3NOTGk3cjBJMTNCOFhreUE0anAzcHBnQXNUOVRxMmZXbUk3?=
 =?utf-8?B?TVJFd3dTZWJRNmdvN2dEanJ6K1JhUTJIMENXYmNlT281WEl1MSt1QWF4a3FM?=
 =?utf-8?B?emVnOXloQllUcEVFQUJoZ2pMMW80V1RhMDN5SHBtUmRVSEFYRk1vUkkzR2ZP?=
 =?utf-8?B?ZVJXd3NwOEVIcFpzcjQwV00yUGtkcmxsdnVIV0FLZU9oMlQ2eEFzQ0dCbmRX?=
 =?utf-8?B?KzVUUUsvV3J1c1lxcW1yL2ZkYmluQ2JIS0g5TkRaMGZjN1N6RlYvdFFoRmV1?=
 =?utf-8?B?U09sTWw0ZnZjdEw2U0tncWRES1BPWGhodU9pcnpRUnBKRlFLYW5CNXphMTdL?=
 =?utf-8?B?cnA1YS9ScTZFeVZBT0Q4UWFoUWFMSXdrMTd0dmEzYWJhOHdWQmpGNzNSYkNR?=
 =?utf-8?B?QVJQbVBIVW4xelRXUndGci9PdWxqVGxXamp3Zmt6YkZmdUxzRnAzcWY0cHBk?=
 =?utf-8?B?QkdNQ01OV25KQjZkeE5rT2Y1dEtkQ2dzcjlVMDREUVYzSjNRWldUU2pWbFU3?=
 =?utf-8?B?RXdTeS8yMnJldnhEcnpLMnhaU3R3dDJDQ2crK0Y4TFNyQmdMRm1DTStsZ0ZU?=
 =?utf-8?B?VDNoOUgrQkpncnlRVkl3MlFRTGlwUEUrTkhxVExIT2wzeU9XMXNEYnZtOGpS?=
 =?utf-8?B?cDlKT1ZQUU1xUThxTnJjNW1FV1R6OW5tdkJZdyszT3g2Y3JPSWhzaTFKYnFP?=
 =?utf-8?Q?Y+I6SrrbT5iv1c2uL7z1iZPkpZjY2EtLmqtBo?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e819c3b2-629f-4c8a-5786-08da2f6a8c15
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 14:13:09.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0L9ncoiomxtCSnoEHM34DhnLtS/Kc0m5LO6ZOGWUMo1YI5Wwg3i0Ip4dw0u1J/orJXvJyUGig0k3gsojJoGHvrP2YMAjlLCOqU7krbP2+pxOMobCr2Qrx9fsPgqjX2Oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sakari, Jacopo,

On 5/5/22 10:28, Sakari Ailus wrote:
> Hi Jacopo, Quentin,
> 
> On Thu, May 05, 2022 at 09:47:25AM +0200, Jacopo Mondi wrote:
>> Hi Quentin,
>>
>> On Wed, May 04, 2022 at 03:55:42PM +0200, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> Until now, this driver only supported ACPI. This adds support for
>>> Device Tree too.
>>>
>>> This is heavily inspired by device tree support addition to OV8856
>>> driver. The differentiation between ACPI and DT mode is done through an
>>> is_acpi_node check.
>>>
>>> Cc: Quentin Schulz <foss+kernel@0leil.net>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>> ---
>>>
>>> v2:
>>>   - fixed unused-const-variable warning by removing of_match_ptr in
>>>   of_match_table, reported by kernel test robot,
>>>
>>>   drivers/media/i2c/ov5675.c | 134 +++++++++++++++++++++++++++++++++----
>>>   1 file changed, 121 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>>> index 82ba9f56baec..ccbc8dc506ff 100644
>>> --- a/drivers/media/i2c/ov5675.c
>>> +++ b/drivers/media/i2c/ov5675.c
>>> @@ -3,10 +3,13 @@
>>>
>>>   #include <asm/unaligned.h>
>>>   #include <linux/acpi.h>
>>> +#include <linux/clk.h>
>>>   #include <linux/delay.h>
>>> +#include <linux/gpio/consumer.h>
>>>   #include <linux/i2c.h>
>>
>> #include <linux/mod_devicetable.h>
>>
>> for struct of_device_id
>>

Mmm.. Wondering why this is needed if it compiles fine without? What am 
I missing?

>>>   #include <linux/module.h>
>>>   #include <linux/pm_runtime.h>
>>> +#include <linux/regulator/consumer.h>
>>>   #include <media/v4l2-ctrls.h>
>>>   #include <media/v4l2-device.h>
>>>   #include <media/v4l2-fwnode.h>
>>> @@ -17,7 +20,7 @@
>>>
>>>   #define OV5675_LINK_FREQ_450MHZ		450000000ULL
>>>   #define OV5675_SCLK			90000000LL
>>> -#define OV5675_MCLK			19200000
>>> +#define OV5675_XVCLK_19_2		19200000
>>>   #define OV5675_DATA_LANES		2
>>>   #define OV5675_RGB_DEPTH		10
>>>
>>> @@ -76,6 +79,14 @@
>>>
>>>   #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
>>>
>>> +static const char * const ov5675_supply_names[] = {
>>> +	"avdd",		/* Analog power */
>>> +	"dovdd",	/* Digital I/O power */
>>> +	"dvdd",		/* Digital core power */
>>> +};
>>> +
>>> +#define OV5675_NUM_SUPPLIES	ARRAY_SIZE(ov5675_supply_names)
>>> +
>>>   enum {
>>>   	OV5675_LINK_FREQ_900MBPS,
>>>   };
>>> @@ -484,6 +495,9 @@ struct ov5675 {
>>>   	struct v4l2_subdev sd;
>>>   	struct media_pad pad;
>>>   	struct v4l2_ctrl_handler ctrl_handler;
>>> +	struct clk		*xvclk;
>>> +	struct gpio_desc	*reset_gpio;
>>> +	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
>>>
>>>   	/* V4L2 Controls */
>>>   	struct v4l2_ctrl *link_freq;
>>> @@ -944,6 +958,52 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
>>>   	return ret;
>>>   }
>>>
>>> +static void __ov5675_power_off(struct ov5675 *ov5675)
>>> +{
>>> +	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
>>> +
>>> +	if (is_acpi_node(dev_fwnode(&client->dev)))
>>> +		return;
>>> +
>>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
>>> +	usleep_range(1000, 1200);
>>> +
>>> +	regulator_bulk_disable(OV5675_NUM_SUPPLIES, ov5675->supplies);
>>> +	clk_disable_unprepare(ov5675->xvclk);
>>> +}
>>> +
>>> +static int __ov5675_power_on(struct ov5675 *ov5675)
>>> +{
>>> +	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
>>> +	int ret;
>>> +
>>> +	if (is_acpi_node(dev_fwnode(&client->dev)))
>>
>> A question for Sakari here:
>>
>> I have a similar series for ov5670, where I don't use is_acpi_node()
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.linuxtv.org_project_linux-2Dmedia_patch_20220329090133.338073-2D7-2Djacopo-40jmondi.org_&d=DwIBAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=d4bhfjobjD_6CMiuzFRtZy27p0ytvQuScDxLXtsaHnzywAfKYeap61kXxLuejvfT&s=pnMz66bcaCWlXZZEIqknW9Atqkxp28rKJFT4lllZhuQ&e=
>>
>> should this be done for all drivers supporting acpi && OF ?
> 
> It's better if you don't.
> 
> Regulators and GPIOs can be present in ACPI systems, too, I'm not sure
> about clocks (maybe not yet?). If you check for ACPI and then bail out
> here, the driver may not work on some systems.
> 

Yet, the driver does not use regulators and GPIOs and is only probed via 
ACPI.

The fact is that today, the ACPI version does not need any of this but 
the Device Tree version does. If the ACPI version would need to support 
regulators and GPIOs too, I'd say that's out of topic for this patch 
series. Especially since I do not have anything to test ACPI version.

I expect the suggested implementation to not break (nor improve!) 
anything on ACPI.

> On the other hand, you might be able to skip some of these delays in some
> cases if the related resource isn't there. The datasheet probably tells
> more of that.
> 

I don't trust the datasheet.. I discovered that I need to wait for 2ms 
AFTER the regulators have been turned on to release the reset gpio and 
not just 2ms of holding reset gpio. Even though the datasheet states 
that there's literally no minimum delay between the rising of the power 
rails and the release of reset gpio. So the way I did in this patchset 
is not always working (actually less often than it does... will fix that 
in v2).

> I guess the driver or the example driver name in documentation need
> some revising.
> 
>>
>>> +		return 0;
>>> +
>>> +	ret = clk_prepare_enable(ov5675->xvclk);
>>> +	if (ret < 0) {
>>> +		dev_err(&client->dev, "failed to enable xvclk: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
>>> +
>>> +	/* Reset pulse should be at least 2ms */
>>> +	usleep_range(2000, 2200);
>>> +
>>> +	ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, ov5675->supplies);
>>> +	if (ret) {
>>> +		clk_disable_unprepare(ov5675->xvclk);
>>> +		return ret;
>>> +	}
>>> +
>>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
>>> +
>>> +	usleep_range(1000, 1200);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static int __maybe_unused ov5675_suspend(struct device *dev)
>>>   {
>>>   	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>>> @@ -953,6 +1013,7 @@ static int __maybe_unused ov5675_suspend(struct device *dev)
>>>   	if (ov5675->streaming)
>>>   		ov5675_stop_streaming(ov5675);
>>>
>>> +	__ov5675_power_off(ov5675);
>>
>> So you plumb the device power/up down in the SYSTEM_SLEEP_PM_OPS() callbacks ?
>>
>> My understanding is that it would be better to create RUNTIME_PM_OPS()
>> for this, so that the device can be runtime suspended/resumed.

Can't test runtime PM for ACPI version and didn't want to risk breaking 
this support.

The point of this was to be of minimal impact on existing users. Also 
see 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c2c7a1e0d69221b9d489bfd8cf53262d6f82446

Not saying it is good, just pointing at the inspiration for this patch.

> 
> Yes, please. The driver already uses runtime PM.
> 

Does it? I only see SYSTEM_SLEEP_PM_OPS in the dev_pm_ops data 
structure. My reading of it is that it's not supported unless I add 
RUNTIME_PM_OPS? I'm probably missing some PM subsystem internals 
understanding though :/

c.f. 
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov5675.c#L1244

I have a doubt now we're still talking about this patch and not 
Jacopo's? At least I'm not sure to fully get what's being discussed here.

>>
>> Be aware my understanding of runtime_pm is limited, better check with
>> Sakari too (I'll ask him to have a look).
>>
>>>   	mutex_unlock(&ov5675->mutex);
>>>
>>>   	return 0;
>>> @@ -965,6 +1026,8 @@ static int __maybe_unused ov5675_resume(struct device *dev)
>>>   	int ret;
>>>
>>>   	mutex_lock(&ov5675->mutex);
>>> +
>>> +	__ov5675_power_on(ov5675);
>>>   	if (ov5675->streaming) {
>>>   		ret = ov5675_start_streaming(ov5675);
>>>   		if (ret) {
>>> @@ -1106,32 +1169,60 @@ static const struct v4l2_subdev_internal_ops ov5675_internal_ops = {
>>>   	.open = ov5675_open,
>>>   };
>>>
>>> -static int ov5675_check_hwcfg(struct device *dev)
>>> +static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
>>>   {
>>>   	struct fwnode_handle *ep;
>>>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>>   	struct v4l2_fwnode_endpoint bus_cfg = {
>>>   		.bus_type = V4L2_MBUS_CSI2_DPHY
>>>   	};
>>> -	u32 mclk;
>>> +	u32 xvclk_rate;
>>>   	int ret;
>>>   	unsigned int i, j;
>>>
>>>   	if (!fwnode)
>>>   		return -ENXIO;
>>>
>>> -	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
>>> +	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &xvclk_rate);
>>
>> Isn't "clock-frequency" a leftover from ACPI ? It shouldn't be in the OF
>> bindings either (you have it in 1/3).
>>
>> You can use the common clock framework API as you do below for OF and
>> parse "clock-frequency" only for ACPI, as far as I can tell.
> 
> Older bindings had clock-frequency on DT, too, but newer ones rely on the
> frequency being set using assigned-clock- stuff.
> 
> <URL:https://urldefense.proofpoint.com/v2/url?u=https-3A__hverkuil.home.xs4all.nl_spec_driver-2Dapi_camera-2Dsensor.html-23handling-2Dclocks&d=DwIBAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=d4bhfjobjD_6CMiuzFRtZy27p0ytvQuScDxLXtsaHnzywAfKYeap61kXxLuejvfT&s=TYhByXuRxctr7fGq94xBetcqW2gfnfZpGK3KyCZnCNA&e= >
> 
> But as discussed earlier, it's not possible to technically add these as
> required properties albeit it's almost certainly a bug if they're not
> present in dts.
> 

I assume this can be "enforced" via dt-bindings checks? So, what's the 
decision here? Do I go for the clock framework version and lose the 
enforcing or do I keep using this one clock-frequency property for both 
ACPI and DT?

> See e.g.
> 

Missing link maybe?

>>
>>>   	if (ret) {
>>>   		dev_err(dev, "can't get clock frequency");
>>>   		return ret;
>>>   	}
>>>
>>> -	if (mclk != OV5675_MCLK) {
>>> -		dev_err(dev, "external clock %d is not supported", mclk);
>>> +	if (!is_acpi_node(fwnode)) {
>>> +		ov5675->xvclk = devm_clk_get(dev, "xvclk");
>>> +		if (IS_ERR(ov5675->xvclk)) {
>>> +			ret = PTR_ERR(ov5675->xvclk);
>>> +			dev_err(dev, "failed to get xvclk: %d\n", ret);
>>> +			return ret;
>>> +		}
>>> +
>>> +		clk_set_rate(ov5675->xvclk, xvclk_rate);
>>> +		xvclk_rate = clk_get_rate(ov5675->xvclk);
>>
>>> +	}
>>> +
>>> +	if (xvclk_rate != OV5675_XVCLK_19_2) {
>>> +		dev_err(dev, "external clock rate %u is unsupported", xvclk_rate);
> 
> This would be nicer wrapped.
> 

I do not get your suggestion, can you rephrase please?

I want the rate to be checked both for ACPI and DT.

>>>   		return -EINVAL;
>>>   	}
>>>
>>> +	ov5675->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>>> +						     GPIOD_OUT_HIGH);
>>> +	if (IS_ERR(ov5675->reset_gpio)) {
>>> +		ret = PTR_ERR(ov5675->reset_gpio);
>>> +		dev_err(dev, "failed to get reset-gpios: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	for (i = 0; i < OV5675_NUM_SUPPLIES; i++)
>>> +		ov5675->supplies[i].supply = ov5675_supply_names[i];
>>> +
>>> +	ret = devm_regulator_bulk_get(dev, OV5675_NUM_SUPPLIES,
>>> +				      ov5675->supplies);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>   	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
>>>   	if (!ep)
>>>   		return -ENXIO;
>>> @@ -1186,6 +1277,8 @@ static int ov5675_remove(struct i2c_client *client)
>>>   	pm_runtime_disable(&client->dev);
>>>   	mutex_destroy(&ov5675->mutex);
>>>
>>> +	__ov5675_power_off(ov5675);
>>> +
>>>   	return 0;
>>>   }
>>>
>>> @@ -1195,25 +1288,31 @@ static int ov5675_probe(struct i2c_client *client)
>>>   	bool full_power;
>>>   	int ret;
>>>
>>> -	ret = ov5675_check_hwcfg(&client->dev);
>>> +	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
>>> +	if (!ov5675)
>>> +		return -ENOMEM;
>>> +
>>> +	ret = ov5675_get_hwcfg(ov5675, &client->dev);
>>>   	if (ret) {
>>> -		dev_err(&client->dev, "failed to check HW configuration: %d",
>>> +		dev_err(&client->dev, "failed to get HW configuration: %d",
>>>   			ret);
>>>   		return ret;
>>>   	}
>>>
>>> -	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
>>> -	if (!ov5675)
>>> -		return -ENOMEM;
>>> -
>>>   	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
>>>
>>> +	ret = __ov5675_power_on(ov5675);
>>> +	if (ret) {
>>> +		dev_err(&client->dev, "failed to power on: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>>   	full_power = acpi_dev_state_d0(&client->dev);
>>>   	if (full_power) {
>>>   		ret = ov5675_identify_module(ov5675);
>>>   		if (ret) {
>>>   			dev_err(&client->dev, "failed to find sensor: %d", ret);
>>> -			return ret;
>>> +			goto probe_power_off;
>>>   		}
>>>   	}
>>
>> Maybe you can also update the comment at the end of the probe function
>> to remove references to ACPI. As you wish.
>>
>> 	/*
>> 	 * Device is already turned on by i2c-core with ACPI domain PM.
>> 	 * Enable runtime PM and turn off the device.
>> 	 */
> 
> No need for such a comment --- nothing specific to this driver there.
> 

The comment is already there in the driver.

The issue being that if it's probed from ACPI, there's nothing to be 
done power wise (currently at least, in the current state of the 
driver). If it's probed via DT, I need to power the device manually.

Cheers,
Quentin
