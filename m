Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49474521C44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbiEJOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbiEJOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:07:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460EF216071;
        Tue, 10 May 2022 06:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3tKvfPo3nEkzVhjzeK4DuJjmCQ/IagaKWS4qDzyjAgfV/ntR/LgesItRSW4231fmUL4vD9ZhcqzsRItySwcQbNCUYC55tvOeuv3WnT4X6FveKODQEwfRlQhsG6xjapojPqtYSiOsiNw5D6aC0Seh5ZdQbYWVR9WqfM6A/PIAdvPjdb1sw1Gfrsp3PSlSv9DCNeIACoKUPrBSW5tJh3gkAQ9qRWFIabhUlMBjm4BHkrgwztl7nafcIfI8aK3L82/ikwOZznKE5wNu5L8FCUYJUWTZcScMYNvKzzpMHCyjc5jqS6LdqPIjfwIR3T7sZbM/MPBSW2Kn5md27uzBA7GEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPPsHrsAm1NHnponQzSUB5Dln3BZh17qEQ1FXPW8uKU=;
 b=ST49cXlKYEuc32iqlEC7+3a1st5Z6wthHdSzOa5CLyQmigzUPbR54z9GKHf5pMH36dNNWAGAB9Vga63JjciaHM9NvNQGRY4qyN0Ka+FWcLrXk9CFCTiI8bYEG2Il5lmMH7acDDA7COAHyDlmm4aiGg4pkrE4BpX/zfT2Jukwf89CSzXg8sbldIu3Wqpp9uXgj6TdE25pvjpL5mv+AOAkPucuNOnoB4G9dOQ0g0fO+axr59D+4JjpUsuwtyctongPY3da7Bb79oqH7BGCN0koNG/5Mft4V88O7VBeCFTJjLzLDbIHwGcC35LFCA7iwt8kRhLH9d/Wez2yyRkesSYFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPPsHrsAm1NHnponQzSUB5Dln3BZh17qEQ1FXPW8uKU=;
 b=TzfEk1dJ7c+zsZEsSQLFGc+F8vRPY+jVBhJfetA8FA31q7DBawzPX04PgB68c0ErFr+Z+GqsQXtgG1IUhV50TKf43D/utX0f4vlYUsfJrlaeGfUS1fEj1eyjk2iZQiQj5HbTmJA5zUhahH/blZdIsbdnVadh19O0M9vJeapypkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6)
 by AM9PR04MB8873.eurprd04.prod.outlook.com (2603:10a6:20b:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 13:42:05 +0000
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::b81a:594b:4dc8:2ae5]) by DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::b81a:594b:4dc8:2ae5%3]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:42:04 +0000
Message-ID: <49e53ae4-1be9-fae1-6c93-3ce7c16f3ada@theobroma-systems.com>
Date:   Tue, 10 May 2022 15:42:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/4] media: ov5675: add device-tree support and support
 runtime PM
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-2-foss+kernel@0leil.net>
 <20220510094607.2ijaw6we6jml2bv7@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220510094607.2ijaw6we6jml2bv7@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0375.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::19) To DB9PR04MB9378.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4048ba-56b9-45ee-33f8-08da328ade7e
X-MS-TrafficTypeDiagnostic: AM9PR04MB8873:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB88732A9F7A2C35576FB1DDADC2C99@AM9PR04MB8873.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebsS1HpwGljb/xaKyQDCkN8ZsUoPTNEouElEazcCLGZM5ZoxTKRA6DDuSlQr97+t3+6ZhPEV2v7v/K1XVuRHTOfQ1uo4MIHRM0we+OqpnO2U7coCbnMboTjUm6p13P13HnRj7ZvoA8mOfkOy/ux1S4Aaz1+Y1pAkzm5aiSqanuBwpkrxWLRhcz0DS1/dofIrDKZf4XyzP5uZugzkgMz29SVYqkJ8cvHj803Xi71YMQSvPyHq1Iw8Wm3EivMtlOLF9FYsusVITU1NyjOaH0c7+unN0oLiv5wOJEDlOCiR8QYrCTmYh/wPOBnllR9Y/znAyZHsD2R6tAIxp0tBuWn+kq+c+LnN0qfoy5s1dGtu0c/++wzS74NUotZN4ItvuwH0IgdWk0DlsRpgWBoyllchQ1PseJnxzyVLp3AMCAIPsqA68H0c9X1GWy6QnT4XK0LEubxtSaPQVKPUIGrTzYnfyfJko5izulzLPL7WTZh0TTgLn8+CuL5TQHyW59xhX74X5qSP6RtiVuL2L9+FfabK/ZLVP9yq5ZDwaoc5S76iQbHOqSWjwp0b/+OdTLSO75we2lv80uG3PcGH6rgPd0FPjE8OJJoUpGeCWSm5M3d5RLOYh3F6kvT+ivppBajjh3YaH8JRFVrKsbd+jRh0QGITpeksZIYjiNlrdNxqe8BFE6ncCCJVZ5kUvqIWlqglyEhQk1qPvqaRVAUcHh2Wqmly4N/jH6p/mElBWofw7HdcOFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9378.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(2616005)(8676002)(66476007)(66556008)(66946007)(31696002)(86362001)(4326008)(110136005)(316002)(5660300002)(26005)(6512007)(31686004)(53546011)(6506007)(38100700002)(2906002)(186003)(83380400001)(44832011)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEF6cHF3dlI1aVhjdjVUN3pLMlBrbEJseDMvaWVxczZyWndjRkJUTFRmNmtS?=
 =?utf-8?B?N1ZOR21kdGdrTmMzaTZ4N1JWUUx0U2g3RjRvb3oxaG5IdVk1L2FlYTRpYmI0?=
 =?utf-8?B?Vmp6KytiRnhpLzRlRlFyMXNocXhRRjg5Zkxkck1CRm01SzFONlV1SFZNTVhM?=
 =?utf-8?B?UG9ZZlBsYnhoU3UvT21LbnZkc1MvM2svNTNDN3VsK3hRTWptSjUzYmJwb29Z?=
 =?utf-8?B?NWhPZUZUNTNxVEV5SkNoVVZzcUQ4bVQvVmVFbEJIbWZ5ZTBaazUxZ2RpNlNl?=
 =?utf-8?B?Y1ZqUER2U2ZFTmZNMEMvdVdjV1NRVC9kSGRTbStNbUpDK2oya2FPWWNUd2xz?=
 =?utf-8?B?bGIveTdQNUlmU1h6a0hjWWdHVWY5U25nSzByY1Q5VVBtV1VQYjBVZXBka1Q3?=
 =?utf-8?B?NW56MlNpeXEvcnhyY3RneHJuV2VBcmgvbW5ORjVpcmh4V0hpNmVHRGJWTlE3?=
 =?utf-8?B?UkZDMkRaRS95ZVArNktoZCtoZ29kVEJvUXh0S3NXemJ2eVdvQnpEV01BcFRH?=
 =?utf-8?B?cXZYWm53VEdmekFlWlVZYW1kVWtneFFpQ05OZ1I3T2REK3VnVmpOZGZ3ZEds?=
 =?utf-8?B?QXhWaTJPY0NMYTdialM2ZXN2UzNzSzFta2g1dXZxNFJUc2liUU9ZT2pDazdj?=
 =?utf-8?B?bVpleW9KR2h2WUJCSmpNOHJLbmh6UENzVGxnL3Z2ZXJFRHE1REZUZEU4Nlhh?=
 =?utf-8?B?aVZjbDFaemExNnc2Y2J3aW5KdGJOYzBGQzFVL0RhWENPaHZIVlZUMHNjNnIx?=
 =?utf-8?B?U0hKRitlNUVNUlAvdVBOMVV4M2JITGZ5M28wdC9oamt1cWdkV3MvRXE2YTVL?=
 =?utf-8?B?UHQySGRodW9ENlh6MGM4M0pPMUpncTBPL2tNNmt6Q0hWeWxTdThOdDY4OGNB?=
 =?utf-8?B?TU54Z1FOU1VsRVRKdDJyTy8wb0NRWndQZ1R5bm5ldGZqYzlXaWZPbFVsdUZo?=
 =?utf-8?B?aGJYbys2RDFHUHg5cWF0QWk0OGxkeVR5bFU2dDVEMXhBOXNrSlh5UUNyd2l4?=
 =?utf-8?B?Qm5QdWNtSy9ZbVdTY0QvUmd5ZUFrUXYxbnRKb25GdXFMMHRPampNbmdZK3lL?=
 =?utf-8?B?RjR6VFlUVHVHdy9tQ2VlZ0k0SDU1d0VzN2hjRWMyc2p0cmNXeU95RTJrUnNM?=
 =?utf-8?B?RWVRZmd0V0diVE83Tm5wVWpjQTZLTWpGU3lDSVdvMlJWRzczM3QvbVJteUhi?=
 =?utf-8?B?Q1ZOSUVZYTViUGdwaXhmN3laUXl1bXVJa2E3YmE0c1VJM1BTYkNiTTRVQWMy?=
 =?utf-8?B?RXVVaEFCdE1HSGFpbG5XZHQ3RWxnem83VzNFN3IxcU5xckw3aTh2ZlFHNkVB?=
 =?utf-8?B?ZnpjL09Vd1FZOGl2OXExSEEwbXdUSS9NWVJrazVMLzVPWHAyYlVtVnV0RHZP?=
 =?utf-8?B?YTlqZFAzd1UvY2R4R3haaUhWYkRuWEJQM04yZmpOSmZtaEs4VFIwR0E4Yzkr?=
 =?utf-8?B?cFgyd1hSS3ArVDk5YjRVMGV0bUNlRjNvbnE0c1NCb09iMzRIQ2pHMEtrazN1?=
 =?utf-8?B?TjhyUG1pSWQrMnY3SFE5ME92TXN0RmpPTHRJZ0VvUGNLaXRtMUp3dVBGeWFN?=
 =?utf-8?B?RGliSzJHV2FwMldjZTl6bUZwZ0JCZ2VHSkJVeUJ1bFAzMW5UV1M2NkVXS1lG?=
 =?utf-8?B?M1k2L2hPRW55em9OU0tRSERPRHF3MnpwU2t3MUdLTEg5cVZrMEQ3bThsNGxo?=
 =?utf-8?B?ZmNuYmF6TUJib0tCLzVoK1pJTWVZOUhpSWZBQnpTaW9pTTBueHRHSjd6eXIw?=
 =?utf-8?B?aFVDbElRQkZ5Q1BzWFUxSjBFRVRsT2kwV3ZRWFRDcGk2bTAwWlczemNrZ00r?=
 =?utf-8?B?dkVvOVdwVVRGbnR3RFhtbGQ1dVY1N0RiaDRvaEhiYmJWYXJXaTBzK0hRdm1G?=
 =?utf-8?B?NmZ3cGtBYy83LzJMQ1ZzcUVaWStVcG42aGcrUStGRVZmZE1SYU1VeC96d25R?=
 =?utf-8?B?cVVVNVJPTVladStJMTMzTWJzTDlVNDZlMzJqTUJVTUNpNW1ITkR5TkJzVG0y?=
 =?utf-8?B?Q2p3amlPUWJTc1VTbUpjZ3RTOGNHZDB0bkk4Z0ZRNnFKN0gxLzEyQ09KYzhX?=
 =?utf-8?B?cndPYVNRS3p1MCtDRXhnbDl5ekIzNGY2SDdqY1U2c1F4QUZ6M2ZjcWVaYzkz?=
 =?utf-8?B?dmo4OWZ4alZreUxtTm5USndsRUlOejFlN3Z4UXlwTjlaVjBZUTJkQld4azdh?=
 =?utf-8?B?TkRVeXNlK21MbGt4SHJKNDhySVpPZldXSzZzOEtrNVh5QTVmM1lKakpNOGh3?=
 =?utf-8?B?UVBKTytmdWZZMUhqOXRieWdPM21tWDhNd0lybENqdUMvL2c0MklUcmNMcVVk?=
 =?utf-8?B?M3BTNTlXMzJsMi9xME84cDJoazZyQ0gzZXNucGxXNXl5Z1hEdjVPWmI1Szk1?=
 =?utf-8?Q?U+0g7Vm1tX+npg0R95qCrbVg5LG6nh53KsRsG?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4048ba-56b9-45ee-33f8-08da328ade7e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9378.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:42:04.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QauiV+9zAQU4Ocz0RUYZvNI1+mm4VZDKwixk7Q7jTtcU6CtmMTCzfaS2fYenWazZ5MNoY+sNmPsSHxjqzHqhE1AINCDQcY6sWtKCNu357f0T4Sz6dvG3ul5C8L1Yq5Bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8873
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 5/10/22 11:46, Jacopo Mondi wrote:
> Hi Quentin,
> 
> On Mon, May 09, 2022 at 04:32:24PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Until now, this driver only supported ACPI. This adds support for
>> Device Tree too while enabling clock and regulators in runtime PM.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Thanks for addressing all comments on the previous version.
> 
> Looks good to me!

Unfortunately the sensor disagrees :/

For some reasons, the first three power-on + power-off are successful 
(sometimes only the first two) and then the sensor is not working until 
next cold boot. I got lucky when I tested the patch before sending, much 
less now.

I'm looking into it, don't know how long it will take to get the runtime 
PM fixed. Please hold onto those patches (well.. technically patches 3/4 
and 4/4 don't depend on anything from this patch, so feel free to merge 
those once reviewed).

Cheers,
Quentin

> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> Thanks
>    j
> 
>> ---
>>
>> v3:
>>   - added linux/mod_devicetable.h include,
>>   - moved delay for reset pulse right after the regulators are enabled,
>>   - removed check on is_acpi_node in favor of checks on presence of OF
>>   properties (e.g. devm_clk_get_optional returns NULL),
>>   - moved power management out of system suspend/resume into runtime PM
>>   callbacks,
>>   - removed ACPI specific comment since it's not specific to this driver,
>>   - changed devm_clk_get to devm_clk_get_optional,
>>   - remove OF use of clock-frequency (handled by devm_clk_get_optional
>>   directly),
>>   - removed name of clock (only one, so no need for anything explicit)
>>   when requesting a clock from OF,
>>   - wrapped lines to 80 chars,
>>
>> v2:
>>   - fixed unused-const-variable warning by removing of_match_ptr in
>>   of_match_table, reported by kernel test robot,
>>
>>   drivers/media/i2c/ov5675.c | 143 +++++++++++++++++++++++++++++++------
>>   1 file changed, 122 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>> index 82ba9f56baec..cee380196774 100644
>> --- a/drivers/media/i2c/ov5675.c
>> +++ b/drivers/media/i2c/ov5675.c
>> @@ -3,10 +3,14 @@
>>
>>   #include <asm/unaligned.h>
>>   #include <linux/acpi.h>
>> +#include <linux/clk.h>
>>   #include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/i2c.h>
>> +#include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <media/v4l2-ctrls.h>
>>   #include <media/v4l2-device.h>
>>   #include <media/v4l2-fwnode.h>
>> @@ -17,7 +21,7 @@
>>
>>   #define OV5675_LINK_FREQ_450MHZ		450000000ULL
>>   #define OV5675_SCLK			90000000LL
>> -#define OV5675_MCLK			19200000
>> +#define OV5675_XVCLK_19_2		19200000
>>   #define OV5675_DATA_LANES		2
>>   #define OV5675_RGB_DEPTH		10
>>
>> @@ -76,6 +80,14 @@
>>
>>   #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
>>
>> +static const char * const ov5675_supply_names[] = {
>> +	"avdd",		/* Analog power */
>> +	"dovdd",	/* Digital I/O power */
>> +	"dvdd",		/* Digital core power */
>> +};
>> +
>> +#define OV5675_NUM_SUPPLIES	ARRAY_SIZE(ov5675_supply_names)
>> +
>>   enum {
>>   	OV5675_LINK_FREQ_900MBPS,
>>   };
>> @@ -484,6 +496,9 @@ struct ov5675 {
>>   	struct v4l2_subdev sd;
>>   	struct media_pad pad;
>>   	struct v4l2_ctrl_handler ctrl_handler;
>> +	struct clk		*xvclk;
>> +	struct gpio_desc	*reset_gpio;
>> +	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
>>
>>   	/* V4L2 Controls */
>>   	struct v4l2_ctrl *link_freq;
>> @@ -944,6 +959,50 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
>>   	return ret;
>>   }
>>
>> +static int ov5675_power_off(struct device *dev)
>> +{
>> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>> +	struct ov5675 *ov5675 = to_ov5675(sd);
>> +
>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
>> +	usleep_range(1000, 1200);
>> +
>> +	regulator_bulk_disable(OV5675_NUM_SUPPLIES, ov5675->supplies);
>> +	clk_disable_unprepare(ov5675->xvclk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ov5675_power_on(struct device *dev)
>> +{
>> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>> +	struct ov5675 *ov5675 = to_ov5675(sd);
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(ov5675->xvclk);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to enable xvclk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
>> +
>> +	ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, ov5675->supplies);
>> +	if (ret) {
>> +		clk_disable_unprepare(ov5675->xvclk);
>> +		return ret;
>> +	}
>> +
>> +	/* Reset pulse should be at least 2ms */
>> +	usleep_range(2000, 2200);
>> +
>> +	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
>> +
>> +	usleep_range(1000, 1200);
>> +
>> +	return 0;
>> +}
>> +
>>   static int __maybe_unused ov5675_suspend(struct device *dev)
>>   {
>>   	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>> @@ -1106,32 +1165,60 @@ static const struct v4l2_subdev_internal_ops ov5675_internal_ops = {
>>   	.open = ov5675_open,
>>   };
>>
>> -static int ov5675_check_hwcfg(struct device *dev)
>> +static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
>>   {
>>   	struct fwnode_handle *ep;
>>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>   	struct v4l2_fwnode_endpoint bus_cfg = {
>>   		.bus_type = V4L2_MBUS_CSI2_DPHY
>>   	};
>> -	u32 mclk;
>> +	u32 xvclk_rate;
>>   	int ret;
>>   	unsigned int i, j;
>>
>>   	if (!fwnode)
>>   		return -ENXIO;
>>
>> -	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
>> +	ov5675->xvclk = devm_clk_get_optional(dev, NULL);
>> +	if (IS_ERR(ov5675->xvclk))
>> +		return dev_err_probe(dev, PTR_ERR(ov5675->xvclk),
>> +				     "failed to get xvclk: %ld\n",
>> +				     PTR_ERR(ov5675->xvclk));
>>
>> -	if (ret) {
>> -		dev_err(dev, "can't get clock frequency");
>> -		return ret;
>> +	if (ov5675->xvclk) {
>> +		xvclk_rate = clk_get_rate(ov5675->xvclk);
>> +	} else {
>> +		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
>> +					       &xvclk_rate);
>> +
>> +		if (ret) {
>> +			dev_err(dev, "can't get clock frequency");
>> +			return ret;
>> +		}
>>   	}
>>
>> -	if (mclk != OV5675_MCLK) {
>> -		dev_err(dev, "external clock %d is not supported", mclk);
>> +	if (xvclk_rate != OV5675_XVCLK_19_2) {
>> +		dev_err(dev, "external clock rate %u is unsupported",
>> +			xvclk_rate);
>>   		return -EINVAL;
>>   	}
>>
>> +	ov5675->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>> +						     GPIOD_OUT_HIGH);
>> +	if (IS_ERR(ov5675->reset_gpio)) {
>> +		ret = PTR_ERR(ov5675->reset_gpio);
>> +		dev_err(dev, "failed to get reset-gpios: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < OV5675_NUM_SUPPLIES; i++)
>> +		ov5675->supplies[i].supply = ov5675_supply_names[i];
>> +
>> +	ret = devm_regulator_bulk_get(dev, OV5675_NUM_SUPPLIES,
>> +				      ov5675->supplies);
>> +	if (ret)
>> +		return ret;
>> +
>>   	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
>>   	if (!ep)
>>   		return -ENXIO;
>> @@ -1186,6 +1273,9 @@ static int ov5675_remove(struct i2c_client *client)
>>   	pm_runtime_disable(&client->dev);
>>   	mutex_destroy(&ov5675->mutex);
>>
>> +	if (!pm_runtime_status_suspended(&client->dev))
>> +		ov5675_power_off(&client->dev);
>> +
>>   	return 0;
>>   }
>>
>> @@ -1195,25 +1285,31 @@ static int ov5675_probe(struct i2c_client *client)
>>   	bool full_power;
>>   	int ret;
>>
>> -	ret = ov5675_check_hwcfg(&client->dev);
>> +	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
>> +	if (!ov5675)
>> +		return -ENOMEM;
>> +
>> +	ret = ov5675_get_hwcfg(ov5675, &client->dev);
>>   	if (ret) {
>> -		dev_err(&client->dev, "failed to check HW configuration: %d",
>> +		dev_err(&client->dev, "failed to get HW configuration: %d",
>>   			ret);
>>   		return ret;
>>   	}
>>
>> -	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
>> -	if (!ov5675)
>> -		return -ENOMEM;
>> -
>>   	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
>>
>> +	ret = ov5675_power_on(&client->dev);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to power on: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	full_power = acpi_dev_state_d0(&client->dev);
>>   	if (full_power) {
>>   		ret = ov5675_identify_module(ov5675);
>>   		if (ret) {
>>   			dev_err(&client->dev, "failed to find sensor: %d", ret);
>> -			return ret;
>> +			goto probe_power_off;
>>   		}
>>   	}
>>
>> @@ -1243,11 +1339,6 @@ static int ov5675_probe(struct i2c_client *client)
>>   		goto probe_error_media_entity_cleanup;
>>   	}
>>
>> -	/*
>> -	 * Device is already turned on by i2c-core with ACPI domain PM.
>> -	 * Enable runtime PM and turn off the device.
>> -	 */
>> -
>>   	/* Set the device's state to active if it's in D0 state. */
>>   	if (full_power)
>>   		pm_runtime_set_active(&client->dev);
>> @@ -1262,12 +1353,15 @@ static int ov5675_probe(struct i2c_client *client)
>>   probe_error_v4l2_ctrl_handler_free:
>>   	v4l2_ctrl_handler_free(ov5675->sd.ctrl_handler);
>>   	mutex_destroy(&ov5675->mutex);
>> +probe_power_off:
>> +	ov5675_power_off(&client->dev);
>>
>>   	return ret;
>>   }
>>
>>   static const struct dev_pm_ops ov5675_pm_ops = {
>>   	SET_SYSTEM_SLEEP_PM_OPS(ov5675_suspend, ov5675_resume)
>> +	SET_RUNTIME_PM_OPS(ov5675_power_off, ov5675_power_on, NULL)
>>   };
>>
>>   #ifdef CONFIG_ACPI
>> @@ -1279,11 +1373,18 @@ static const struct acpi_device_id ov5675_acpi_ids[] = {
>>   MODULE_DEVICE_TABLE(acpi, ov5675_acpi_ids);
>>   #endif
>>
>> +static const struct of_device_id ov5675_of_match[] = {
>> +	{ .compatible = "ovti,ov5675", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ov5675_of_match);
>> +
>>   static struct i2c_driver ov5675_i2c_driver = {
>>   	.driver = {
>>   		.name = "ov5675",
>>   		.pm = &ov5675_pm_ops,
>>   		.acpi_match_table = ACPI_PTR(ov5675_acpi_ids),
>> +		.of_match_table = ov5675_of_match,
>>   	},
>>   	.probe_new = ov5675_probe,
>>   	.remove = ov5675_remove,
>> --
>> 2.35.3
>>
