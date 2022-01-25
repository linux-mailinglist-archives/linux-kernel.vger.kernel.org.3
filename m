Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D549B95E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbiAYQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:56:49 -0500
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:13350
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1444453AbiAYQyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:54:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2xyP9tNYRUuuIH8Ro/qWMA6Nwt7ERMwgiJ8JT97w7/5AlLYc/z0+gooWlLOvmwgjrf5rXtfxj5CA2z9eoSC6w19OaXDFLyW2V5aCm+h+0gpwHfQBybGHXrcFkmH5UP0O3om2ZQ1aZNoLeIkPZ2dFGfcG1niSES0Hn0txiCNe5LSmaLXk6gulAXsUDTU8KYqeJ4t0ZJQSzshavHlDrxHCOgsRoj9XLNqitgFhk7GGENztGm2SDz6AIeJ+S90797iMp0vyTpunt3YXJkL/pWXc2NGOD8O1ewUZU38oT3YWHT5aA9kOy+TQQANJNQ9z7aGz6xo/EcaxQ4QSMNCby1NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKHDI5ByEEJsJ9rLdD2cRU0lB0HefmlJI+YMk+/3OLY=;
 b=l9n8RnoLJ8CMaGmgFAQU5P1POKqQrwDMJU3rL5NANe5zcXMiegHvSry6ntkHzqcw6FrL4yDOoVTik+SWHLc8/Rw2NuH6moI28SYH5YnMA+5vkVDbQPkAObxFXreEL15yyNEnU1jaoMUZvHzzoh8h9x/DunKDfAVsr7n7hUTTtDEoMpLh3HOp/Jlm1bWyByNDHjF3oNCSn+gcVOn3M9YtO+KzC2d1Dl8PyDydloaEXVfafHlBzfsELHIknbOBXU2gzjjtWccbEGmeSiSiWBuHo5GVxkepUOOm6uNd5L7Qmcv9FMLQX9/Rcr5T0lQ1mDvRLvANOJBTCFMi2sjKX3Kf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKHDI5ByEEJsJ9rLdD2cRU0lB0HefmlJI+YMk+/3OLY=;
 b=k3J5dAOEcTVjozek51SVifPaRRwHGKDg4fEay7376gsGZJYSOu1ySuovZEkTCjyvWU0NtK/oXLv9UA2FC9KhfbzKyj+UimIQ6SCBlLS6wTFVDKqmZIZq9QpU4AdnmECs5hzZRAO8IYlTmygGrKe97c3iEDQQauyBiZX6kjT/7aUPTAEKbBaKjMKqG0Vf4CZZ4I6UwgBHZLgCPb5ato7TloQr6l7DKhwpCz7Rt6zzbIHK/fzS32aJCDdYr4UyBBoBgKxO0vVI2RBlArahiyTjcv5DyHYLEgEXcLssVT9c00+IoSsV/Zsxi04YnxD3k4waVmXMOyME0cdl1NPmHWpHqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB5000.eurprd03.prod.outlook.com (2603:10a6:20b:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 16:54:02 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 16:54:02 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/2] usb: ulpi: Call of_node_put correctly
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220124173344.874885-1-sean.anderson@seco.com>
 <20220124173344.874885-2-sean.anderson@seco.com>
 <Ye/AUUlnuHBoGxab@kuha.fi.intel.com>
Message-ID: <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com>
Date:   Tue, 25 Jan 2022 11:53:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <Ye/AUUlnuHBoGxab@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0051.namprd20.prod.outlook.com
 (2603:10b6:208:235::20) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e08869c3-d881-49bf-3e93-08d9e0234a0a
X-MS-TrafficTypeDiagnostic: AM6PR03MB5000:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB5000AF892D09D7E0C077086B965F9@AM6PR03MB5000.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h42kNRtxQ18Uv039GIHzfRg1OcozU/KIvm7bcwLNsBI7nyrxevP163nXf7+rTAENAo+NNOfcgmwd4djofQNbvd6OHU31+iOguhj9FZSrhL22hnPeb5eHInjrxs65ifF/PIvqiagI+gFHwwcp6bQNKTo7LMgU9cd4WAHK3Npkt2UdJ4d5jE4EDrm1l3BhHImXObApwQpBvPN/zqS0vKtpBZ/4OeuQaE88gh3KKz8/yoHxAryWNRpYHCaepsp1WsBtnwbdd0gDrJeJzCAE2KcXTngeqoLgDT1w2oE7ru85d+6LGmCi3YXREpopHbHQoG1SmSuqdNf1zB4MaYW6cUYedLDJ+ifxviuJPB5szWhaf5Hz3iNv4wfAQDCQUiPZ7QLzvN5CF9c8lkrQiG48qsdX39E+Ln2VLNhHfj8ZKFG7EFn/lQKJpi7JwWzRqs5lY1/ZohIaLZSjgVVIcfekGk8kl1jiug/09x00RRcr2tGBl20LOU27P+BbLZa+vQlgOB+UgQ/Z6Kck3uhF5Y5eLp4J3sJB9qU4RwCnQ7rzBEL95nctVe57drAZI+S9rJluSXUHENqZUe6bU+WSaBIGf0g5myAjRPdLwG4nlS9c+LJpNnBmrfBOOG/at6u5edfce75C+WAMkJEi/59wcpZW5zud9gp1cF3dPsRjfufOTTz+P3fXlz+jWIMQJ3cK/7qpg0M0pHSmqcoWElLM8IFX99kXcg3FKH6joWm+5hn/Cloj9OInwSfptcb6WJ20/1729OEmnNQUqml0gkR5z3d1ey+Ebw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(38350700002)(6666004)(2616005)(83380400001)(31686004)(66946007)(316002)(8676002)(6916009)(66556008)(66476007)(36756003)(6506007)(86362001)(6486002)(52116002)(2906002)(53546011)(31696002)(508600001)(186003)(8936002)(6512007)(5660300002)(4326008)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VZcUprMVZNWHNtV1pvb3lSc0RVMXdqWWpCMU44YzFHcUp1cTlxS01Hdmhu?=
 =?utf-8?B?Y2JWSGFydnljMExFdjJDeHpITWlUUzRBWjFMa3A4TlVXeW0xbjNrUVNNWTUy?=
 =?utf-8?B?eGxqZmtieDBvbVZoUEpCb2hRSUZkUHB5M1Mzcy9HQmJNNysyV0JVVGg3WFVW?=
 =?utf-8?B?NWZhVnNKaWdHYjZnQUVxTGR2cEo5WXRxN3lVeXgxdUpCQkJGQVJTVis0MS9a?=
 =?utf-8?B?TW5DTjZlZUlsZnFlTWIrcmRGOHV6YmF6QnVhdGdOamgvejN1cXhQT0NjM0pz?=
 =?utf-8?B?RFY2ZE5idHRsUjZKWUYzRDRsR1JyYmVJOXVwNlA3OHFNdkgyWHRwbXhvUHRM?=
 =?utf-8?B?bUJxWFpEcUhvNmVkY3ExUGsxMnFuenpOTnpaQVdoaG1SUnJCZnFGKzB0Wnhn?=
 =?utf-8?B?RmZxN2lkZVFDQ0oxcUVZam05T1Y0bWNnSWRwaFd3ZXlDa0RoV1Y5OE5QSHQ2?=
 =?utf-8?B?WjBxc1NkQ1BZRDRMb2w1S3YxcHRYRFcwOHJjSlE0UnV1MytGUkNIaDFVZThm?=
 =?utf-8?B?dlo4Z1V1bWVNS0gvZWREbnRTaHl2ckpEVkVscHdLTFFtdER0Q3lYNWFlUTVx?=
 =?utf-8?B?elZiRW9tU0lpVWZTK2d3TUxLUUl4d0pXeDdpQmFsZnIwWTJCNlFBMEI1VUJI?=
 =?utf-8?B?dVZEaUFDNks5eC9EUlFxbHBpZWNsNVRnend2Tlp0NUdwQ1kwT2h3RStjYlVS?=
 =?utf-8?B?VmdEdmVOSHZQYkxWSHg3TFh0KytsMFZyQkVtenFTc0RtWkg1S0hFTnN6REFw?=
 =?utf-8?B?dUQ3MFBFd3Q1QjhEU0xxRzg5UCtoSkZkVWRXeWZma1FJbms2WDE2Y0ZZL1k5?=
 =?utf-8?B?VmRUejRGRlpPS0szQkxuQ3ErczNvTmZrM1BCUWxGYzBqWjVHc25FK1o2TitV?=
 =?utf-8?B?U2VUQkVIVXk2VFZpN0IwdmdkSVEvWC8rRTA0TEo3MWhaazNZaURybmhnSTll?=
 =?utf-8?B?UVlESVRNU09YY1luZWtKVlNBNmE3N0NZRzQ2ME01N3J1NXhTK01ZeWh2dTJ0?=
 =?utf-8?B?b0xFcTBNYUNBdEp5cEhFZmwwSkdUd2F1dy8xV01NQW9lTXg4QUI5cTZwRzZz?=
 =?utf-8?B?eGJ4WDV2aU5tNlV0UlVsVHhBVWE3anN2RUpobmsyTzBEM0JPVFNwYmxlSlJZ?=
 =?utf-8?B?NHV6VU9TMGlobUtxSHpjMCtIdTdHalU0MUNyMDlNeWZhYU9ZL01DMkdPeUU5?=
 =?utf-8?B?dERSSFh2NGI0TC9VeUorcjZXdWdlOUE5dnFleGNlZ0xnOTNqRmd0M2IySHZY?=
 =?utf-8?B?M1BxUFBTRkdJSU4zb25CUzlGenVPL0Z4ei9ES1cvTk93K1Ztd2lGM25KZmJu?=
 =?utf-8?B?UkdmMkVVakpxNmtkeTNQcUl6a1I3TkJRN2dzcnlGN0ozSzAvS0Y4OFQ1NkRD?=
 =?utf-8?B?cUVzdFpYaXZwb3NQSndiMUgvRkVvRGg4S3U1MW5GODdzdWVmL1ZSZlRhNjRQ?=
 =?utf-8?B?d2RHN0JxR0NwNUJoTzFtV0hkcVE0U29tWkVKcTNsNWYzUUMwOW5SZ1hvLzBn?=
 =?utf-8?B?RWMrRGozOUpzMDJVckUxd2hKR0o1MkJiQ2tHbW9vdS9jWXVGbVNQWHk3bVky?=
 =?utf-8?B?bU1hMWJxRUx4ejBZTHAzRDZOSUxUaGlad0RQT2gyMFRJZXVaY0ZHQXlORUoz?=
 =?utf-8?B?Q2lEdFJyVk1VeG95Z1JXRitsK1A3ZGNBNUEya1ZXZzUvV2hsdEQxWFkxdGZN?=
 =?utf-8?B?UWd3VFZLN2dhVlExbmZ3UkdGOERsZ1RjL3hjNFZ4Qm5NeUVMaTZzRGF1SjhK?=
 =?utf-8?B?L3BVZ2JmM3J0d21xY093ZE9uT0dlOXJsVndPbmtRN1J6cmx2RlRyaXhkU1Z4?=
 =?utf-8?B?V2hnaXZaMHVRUEtpVSs5RFd0MVJLclFNZUdtdFhxN0tLcm1PTFo4NnBYNXJk?=
 =?utf-8?B?SU1JcU1uZkdTRUV0Rjl3MDBVUnpOamQyaGdRTEM0YTRERjE5aFJwVDFvV1p3?=
 =?utf-8?B?ZFJmT2ROMWpOUS9lQzB0M0tWQmFyTTVrZW01bDg2bkw1SUhCSDlUOU9BYjdG?=
 =?utf-8?B?dmlORHBnNFFLOTdPeENvbzdsOXhoS0R3cW56TVJNS1BLTVd6dExHT01lb0FG?=
 =?utf-8?B?ZDJ4eDhEVmJIcEsxd0F1ZUtQRC8wRjU1RnUzdmV5ZUswQUdrSWJiNjZubVFZ?=
 =?utf-8?B?dGN6VmRSTmRob3pUUit4cVp1RkRpU2ZtQng2endOOGo5b0VxU2l3b1laeEth?=
 =?utf-8?Q?6CLvjeYBkUJACha1JWUWwFk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08869c3-d881-49bf-3e93-08d9e0234a0a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 16:54:02.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgggH1wRST9qBjbBQtFAzI3GhJCNZvkWVKaYQ+b4I+7V/QYDQI+zV0J4oDDjPB6pKmeAF4RU7Wru3L3IqI+fAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 1/25/22 4:18 AM, Heikki Krogerus wrote:
> On Mon, Jan 24, 2022 at 12:33:44PM -0500, Sean Anderson wrote:
>> of_node_put should always be called on device nodes gotten from
>> of_get_*. Additionally, it should only be called after there are no
>> remaining users. To address the first issue, call of_node_put if later
>> steps in ulpi_register fail. To address the latter, call of_node_put
>> only after calling device_unregister.
> 
> This looks like a fix, but you don't have the fix tag.

You're right this should have

Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")

>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> Changes in v2:
>> - New
>> 
>>  drivers/usb/common/ulpi.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
>> index 87deb514eb78..c6ba72544f2b 100644
>> --- a/drivers/usb/common/ulpi.c
>> +++ b/drivers/usb/common/ulpi.c
>> @@ -301,11 +301,11 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>  
>>  	ret = ulpi_read_id(ulpi);
>>  	if (ret)
>> -		return ret;
>> +		goto err;
>>  
>>  	ret = device_register(&ulpi->dev);
>>  	if (ret)
>> -		return ret;
>> +		goto err;
> 
> I think there is another bug in the code here. Missing put_device().

So what is the correct way to create a device? Shouldn't device_register
be paired with device_unregister? And from what I can tell,
device_unregister does not put the of_node.

> If you first fix that, you should then be able to call
> fwnode_handle_put() (instead of of_node_put())

Well, we currently only have a ulpi_of_register, so I don't think we
will have a fwnode here. But I can use that if you wish.

--Sean

> from
> ulpi_dev_release(), and that should cover all cases.
> 
>>  	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
>>  	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
>> @@ -314,6 +314,10 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>  		ulpi->id.vendor, ulpi->id.product);
>>  
>>  	return 0;
>> +
>> +err:
>> +	of_node_put(ulpi->dev.of_node);
>> +	return ret;
> 
> So no need for that.
> 
>>  }
>>  
>>  /**
>> @@ -357,8 +361,8 @@ void ulpi_unregister_interface(struct ulpi *ulpi)
>>  {
>>  	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
>>  						ULPI_ROOT));
>> -	of_node_put(ulpi->dev.of_node);
>>  	device_unregister(&ulpi->dev);
>> +	of_node_put(ulpi->dev.of_node);
>>  }
> 
> And here you can just remove that of_node_put() call.
> 
> thanks,
> 
