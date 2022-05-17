Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A61529DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244819AbiEQJZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiEQJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:25:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9337011;
        Tue, 17 May 2022 02:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzGsqGEUzojbbvjcd/1edZbaJrkpjyjHnL1geTFtMdGL4sOfGRYSnhdMlqarzxS6uB3Uw3vbXz9Ulrxwtf0HoSWfJoCKQyhS8uULCIFKzBRsjBbfFua6JvHaI8ejb/jm1i+ruRxFEVjKo90lSO0CPDwsznSpLpXTdTJCXquu++9YMBLboepo+uF6XerKozMcYCYslsc1D2SHyVXfZTKAFw+uhBwJzHr6OMeaV+BBXgu0zgwjPyD9xcIMpUKDRyKPmnz4VGC+bvcUpZWKREa2ASqyWjTRUIBXTJEDi6KFlhn15rkdda56F107MGXABhDnFMQgJf1F0OshN9GU1NxBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/70/UzSLiCi+paFYt6qZsJBS0h+j4iU0s8TKG5piyLw=;
 b=DFXbpqatEmrCn3vClDpp5xruPDV76p1lE6sVYGvYdt1Q6+/eh9TP++zeKG08912C5HJmZA/PCAhvY3wl/bB1I8kunQpnFoGCE27pqTleZBypozwFdeCEmEFUTQ1uZRFWwG5rwNjDovRpO0FJeu0/alPRBukkP8I0baX4Pby3vySfKzNpvhtw71MmByacGsXf90u8uA4r/DVws8/Lm8n1cVzaeJyTqhYWrZmyG0kpG3K8zV2AgZcomL5XvPJNVmx4KdXIiFTaq+zFgv15SEFBaokj5MBwI+YyRJxYIJvMK/zooiPdNwIeVmjxuHNvK94o54Fp4eHjJ5PiwtvX8eayBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/70/UzSLiCi+paFYt6qZsJBS0h+j4iU0s8TKG5piyLw=;
 b=IqJo5eeietANQpcgg1HbzPbg9lapwxQ+35iw5JTYBEvLF+LTD/94yjArA+yMhGK3eNNHbyVMAikNWj0LC4ojsrDOS+sHzB+fCetFN1A4f3Av7CYyvgREJ+X4vBW6/BTDgC9UID37PA14YncPB2QsdolbXo3xscNussTbdkXZyjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AS8PR04MB7893.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 09:25:19 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::e443:c646:c299:5512]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::e443:c646:c299:5512%7]) with mapi id 15.20.5227.023; Tue, 17 May 2022
 09:25:19 +0000
Message-ID: <b77d43d5-4a50-3da2-67b4-65224a82a202@theobroma-systems.com>
Date:   Tue, 17 May 2022 11:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/4] media: i2c: ov5675: add .get_selection support
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-4-foss+kernel@0leil.net>
 <20220512090553.x7mzsj3ff3u5gqxq@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220512090553.x7mzsj3ff3u5gqxq@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0095.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::7) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeccf862-1b3a-4e9d-a071-08da37e728ee
X-MS-TrafficTypeDiagnostic: AS8PR04MB7893:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB789302C4B7008DFC52BC21FBC2CE9@AS8PR04MB7893.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfhyFf+pYwFb3xv98uV9crfMnEpjUJtN8hxD/TZ3wWDA+MvQ5zP10T547hRbId7U44HaSG08UHg6ffdUYKWz6GYV7DGp4+BAfcDafiNlX9p/W4Sj/b3YZHiprpkLSzTGnNg029Xb6UyOd4szEoz0eERN7zBNg2TvZTC6mNevzSITMkTEb8LtqXOmfGjl5iOKMJocMRdq9lMkUeLPbkjA7vvdy3kSS3rR9je9e3J9qVzny7vYXjD06UOimYNSo31YlOj0GGJA0esNhYDbhchVCAEfHH7NMIVuvl34dH3ns9PpA0zeRB8kTS3sXkRZ5pQw/Q5f4gGK7Qh0qTQplAKpGS+hofSZoHWssifhAbdRnQjd0oxGJVYxOtYhu51VuO2e4rheAJ9182LHhx+sFCwIeSUuY1wWDXcC1FNQPmaNEPcU5QfPRPQCxUatt+nAED1lpLUw2I8inQk0DkLDEJU9iFaPswjRZVF9plgtMpPKWZAvS+snD9l4hr6reXREZnQzsN4WxEfzSA0CWf0lxQD0bDjKyAa4JCqq3bNLGTlJd+ZMcXfo4ubLipj5GVwOBx1ItofdR1/FThB+vaq19OrqOEnng88NJri3+bA7YpFftZpkbXf4UShK3vHYG0LvAWQlBp3LrdgfYBFXPpevjGg/DaT3QWKgL6jH3Gx9cHrj8GnWhliGXkLumB70zhk5XYqTNDzUIEMs8wDR/7dHAD2ft1QicqEeAgTviPIjwF397ytC/M6Qv4cee2BPedNygTF6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(6512007)(83380400001)(31686004)(186003)(316002)(110136005)(31696002)(6486002)(508600001)(44832011)(66946007)(5660300002)(66556008)(4326008)(8676002)(8936002)(66476007)(26005)(6506007)(53546011)(2616005)(36756003)(86362001)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJxMTlyY1lXaDYzNytPSjlWSzhYOGRqRS9VL01abmFET2UvTGxmUXdqOTQr?=
 =?utf-8?B?U1llU2VMSjg4UHRhaDluZlZDRlc5VytUNnlhUm1JRmlNVzE5WDFXUFA2U0tt?=
 =?utf-8?B?WWhaMEJhZ1piTmViN1pxWlZNcEFJYjJkOEgyRi85NUh5eXIrS3ZVVWpUSnBV?=
 =?utf-8?B?Wm9RaHlZaXJZSHY5MHBxQUNmaXhYN3drWHRHTWgwejVidVc0VVJGdFRSL3RN?=
 =?utf-8?B?S1I5Q2p5Q1BSbEZ4eXNPYU1NTG9NSlFWR3B3Wkw1L1ArTWFHbThmWHZDS2Fo?=
 =?utf-8?B?ZllBQUJ1eGZJaFJoOG1pWnpOSTdzVzEvZ0RldXpjQWhTZWRrNkZDbkhJcTE1?=
 =?utf-8?B?OVpreFRjYm9PRC9PNGxlZXFRTWhmZHo3S0dIK3J5KzlOamNneGdWWklTRWtz?=
 =?utf-8?B?VnFNaWhGVnBGdFdJTDNZckUycCtzanFTdXI2aTBRQVhoUVFsQkVNN2ZTdzht?=
 =?utf-8?B?M0FETkdyZXI1c0xyS2dWVE8wb2RnbWNkbVl3R01nRXgzVy9jcGl4d0xrZENI?=
 =?utf-8?B?OE41SjNPRytwK3FOTGRjQk9VMVE0U0VVQWNkTUpkT2cwaEdoR3lHZnV6cE1u?=
 =?utf-8?B?dlJ4OVd4d3ViMHpmV1lWMUpPOUEwR1ZHb2thVW5haWRxay9KcVdSeFZIWmNM?=
 =?utf-8?B?bEgvOFZwYVYwcERIaFp0Z3hsdkM4K2x0YmwxV2thdWFrQ21UUjZiRG5odEpN?=
 =?utf-8?B?WDh6WFl2UnkvSWZsYk5zNWtNeHJxcXBEZFNwYi9QT2IzRlRMN2pnNVVSREE3?=
 =?utf-8?B?ZlVxajEvdXB5YjFVOGlZTkVPMnQzTERpeGFtZXQzeG1JTCtxQ0JEYVB2SGF1?=
 =?utf-8?B?OVU5WW1oYWVsYmpRQTJoY0FjUGZlUW5QWk8vZ3QwampJUkh0UFVIRmxtZ2RJ?=
 =?utf-8?B?TEQ2UnlYU2lMNHoyUGxYOUxpZ1JtSlBsVi96U1c1V2M4WlU3amhHL29uMGNn?=
 =?utf-8?B?V2M4WjF5Y3RXWUZwVm5WcDZLSjc5KzlvUExMSG1naG8xd2pFcFQzZ3hocTVO?=
 =?utf-8?B?Uk9CanVCMWI0LzllbzlFcHY0MzdvbnFHS1AzNmJOTUVuTWJ2MTljaVZneXB2?=
 =?utf-8?B?N0lnWXpzWlpvdTB0TC96OENKMEJmRlhDa01BY0wrenl4NjcvTHVCaEdNa09P?=
 =?utf-8?B?SStoQm5MWWhhWk5BWmdsa3VBdmxpUmJrcVI4QmxDaXpBaXRQQUJodVIwaFdR?=
 =?utf-8?B?OUxkalA4aU40dXlrQ0RxaEhGS05Gc1B3MmpuSGZHUS9SbmhqYUpTRldwZ0lL?=
 =?utf-8?B?dG44RUFDM3JNM0FHQ0xFUG40K3RQNEJ2U3lraHRGYng5SzVWeEZjM0ZqWjVm?=
 =?utf-8?B?Tjd0cU00bWZsWkN3U3k5OXg1dzhMa2d4QTFqc0NDUnlNam9JdHp2SHg1QVFJ?=
 =?utf-8?B?ckFBS3IzUUk2bzUyMlIzSFM2NTJrMFZDd2VBVEFmUHVkankydU9pUGxZUVlm?=
 =?utf-8?B?QkUzSFJXamx6QnlCeE9USm12eFlmUmJBZVkxVTZRUVMxcFAwRkFZOXV2M3kw?=
 =?utf-8?B?RTlUejltUmtUSWdreUpHQ2xZK2tCY2pSNGY3cmJCdENaUFpFcXI0MWpCM1hC?=
 =?utf-8?B?OVFDNnNsaHpqTFF3U21rNFVLeDJ3MkVNWmgwOTRhM2thRlRPTVFFbVhNdS9k?=
 =?utf-8?B?clR3L0ZibVdQMGw2NE5NQ2xkdzZia3VHV0ovVm44bXJwM3Q4UlMrNkkybHdj?=
 =?utf-8?B?cDMwbTg0anlTQU1JbmNHS2pySXp3b1grK3NjZXBwYXhnU0l2MXBNT0tKN1RY?=
 =?utf-8?B?SHFkSmdmVExJR3o0ZUlQbTVSalBXSmlncm9xbnQzanA5VUFHZGlqWE83SFZ3?=
 =?utf-8?B?S3dWMHVlT1ZsYjkvS051WlRDcHJDOUhDbzhmTEIyRXg3VUpNQVd0Z2FCSHVV?=
 =?utf-8?B?OWdhNFR2NFM5OEpHbStRTzQ2c2xqemZnemZxUjNEQkh2UzBxc3hEdG9wekhU?=
 =?utf-8?B?a2t5SEl1dUtJWjNZQnFqSEoyU2x3MUIrVlA3ZkFsU2Z5RTZTYTN5M000bHh5?=
 =?utf-8?B?SVdxVjZ1VDRQSGhIMGc5bmxoSWEzemZiNEtPdDM4czJmQThXWWVSc2ZzOWtC?=
 =?utf-8?B?WUxHM3RjSjZaVHlrOXUwOUtMTmdud2s1ZGZuZHlxTjI1SmR5WlNwWTNOS3Vr?=
 =?utf-8?B?VzZEamFIK3hYL0E2VVU1b3pGUkJ5eUtjVXVtNitNUmJvN1M2dkZKTEpZVHh4?=
 =?utf-8?B?OXlCWHo5cDRoaFk1ZUJZdGdiSElVdU1mRmhOZWxNNCtJUld5THV2UXM0N3Js?=
 =?utf-8?B?QU5WMEtha1hzd0RlWEZNWDY4Q090TFlrRVowdThUKzZkN0hGK3lDcW13cGVi?=
 =?utf-8?B?UlJoeHFxemhSKzI2Z29rbzJrRFNQdkg2UzZON05aRlQ3VjRybkRoZjk1N0xi?=
 =?utf-8?Q?dWk4mhlpY2OT4XeC29VfRHAn4RxDj8sIHL4df?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeccf862-1b3a-4e9d-a071-08da37e728ee
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 09:25:19.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXVrSd2/b2uIYHPeGSqEL7n70C8iZDnteVtrAWpu7ELojdimAw9SnD9vLDvzNV0kcU72Vjk0exmicOGmq3f79G2kvMMUd/XujPXNJFzUAUGRASZeRDDHyGEVvRFIn1Ob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7893
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 5/12/22 11:05, Jacopo Mondi wrote:
> Hi Quentin,
> 
> On Mon, May 09, 2022 at 04:32:26PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
>> pixels and there are an additional 24 black rows "at the bottom".
>>
>> As recommended in the SELECTION API documentation, let's put the first
>> useful active pixel at the top/left corner (0,0).
>>
>> This window is the default and maximal crop allowed by the sensor.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>
>> added in v3
>>
>>   drivers/media/i2c/ov5675.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>> index 5544e1ae444e..8e3a5bc6c027 100644
>> --- a/drivers/media/i2c/ov5675.c
>> +++ b/drivers/media/i2c/ov5675.c
>> @@ -78,6 +78,9 @@
>>   #define OV5675_REG_FORMAT1		0x3820
>>   #define OV5675_REG_FORMAT2		0x373d
>>
>> +#define OV5675_PIXEL_ARRAY_WIDTH	2592U
>> +#define OV5675_PIXEL_ARRAY_HEIGHT	1944U
>> +
>>   #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
>>
>>   static const char * const ov5675_supply_names[] = {
>> @@ -1115,6 +1118,27 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
>>   	return 0;
>>   }
>>
>> +static int ov5675_get_selection(struct v4l2_subdev *sd,
>> +				struct v4l2_subdev_state *state,
>> +				struct v4l2_subdev_selection *sel)
>> +{
>> +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
>> +		return -EINVAL;
>> +
>> +	switch (sel->target) {
>> +	case V4L2_SEL_TGT_CROP:
>> +	case V4L2_SEL_TGT_CROP_DEFAULT:
>> +	case V4L2_SEL_TGT_CROP_BOUNDS:
>> +		/* In HW, top/left corner is actually at (16,16) */
>> +		sel->r.top = 0;
>> +		sel->r.left = 0;
>> +		sel->r.width = OV5675_PIXEL_ARRAY_WIDTH;
>> +		sel->r.height = OV5675_PIXEL_ARRAY_HEIGHT;
>> +		return 0;
>> +	}
> 
> CROP_NATIVE = the full pixel array size = 2592x1944
> 
> CROP_BOUNDS = the rectangle that contains all possible crop
>                rectangles, aka the readable portion of your pixel array.
>                If in your case the sensor can read out dummy and non
>                active lines this is == NATIVE
> 
> CROP_DEFAULT = the active/valid pixel area. If there are any
>                 dummy/invalid lines the DEFAULT rectangle should not
>                 include them
> 
> CROP = the portion of the active pixel area cropped to produce the
>         final image. You should look into the modes definition and
>         inspect what values are programmed in register 0x380x (I don't
>         have a datasheet hence I don't know what corresponds to what)
> 
> Does this make any sense to you ?
> 

It's difficult to make sense of the datasheet to be honest.

There's a 3296x2480px "full-size" rectangle, then the sensor array 
output area called CROP and configurable through registers 0x380x, then 
another output area called WIN (for window) also configurable through 
registers 0x380x. The WIN area seems to be just a mask applied on top of 
CROP area ("timing is not affected").

On top of that, the schema shows 24 black lines - I assume - 
incorrectly, one after the start of the full-size rectangle, one after 
the end of the full-size rectangle.

Then the sensor array area region in another section explicitly 
specifies the sensor to be 2624x2000px, active dummy pixels (2 16-pixel 
rows and columns) and black lines (1 24-pixel line) included. Which 
makes the actual useful area 2592x1944px.

In the datasheet, the default size for the CROP area is
2624x1952px, offset (0,12) and for WIN it is 2592x1944px, offset (16,4) 
(assumed relative to CROP given the second coordinate).

In the kernel driver though, the 2592x1944px mode configures the CROP 
area to be 2624x1968px offset (0,4) and the WIN area to be 2592x1944px, 
offset (16,13).

The datasheet only ever mentions 2592x1944px as being the max resolution 
of the sensor though the sensor output area documentation and registers 
do not mention such a limitation.

Since we're not modifying the crop area at the moment, CROP_DEFAULT and 
CROP would be the same, which would both be 2592x1944px.

For the two others, I'm not sure. Any clue or hint with the info I just 
gave?

Cheers,
Quentin
