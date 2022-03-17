Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2E54DC32C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiCQJqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiCQJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:46:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB81A6357;
        Thu, 17 Mar 2022 02:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKqmsjfaIxQhODQbK5PTuyIHjc7VFFUBYX2Ot/yeKr9t+EYMqxU8NnUuVdUpLDnlrwVqhnyT9UFcLk+i1LVzaUAKLPxtoGuR/Cj9dPUKcM/WNfyupuIc6fuVWYMys0APDJPwxr8Ik58qU5H5sHYLw99f8x1l+6j02uIECpEpIrZ/kvo5m0JcaAXlcRxQ9nxZKRYjFq/dU6KkP2NuUzw9qJL2x/JxVDV5P+c4+E/A1FiS0CbpRtk6ke/WbiU8GM7p1ztVPyrYaNEVmyD8FG4ZtWGvSaKv4GVbzLtbtUN7P5BzRQY7NhbcE5w8FvKtsJNrsm8436iCF97kl/Tcj3h8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw5+qCe91bvLgIqfxCSgkFRDIj/jgBMn3b1Dgy0nhZY=;
 b=RCZx9t5yoU7dR+yVTwwIxqjW5LyCxCM0lWXniBuHQqXI+oeBd1phS5gA0BYhSk5W814Z2JbyDhDYpAoNkSS7nn6tDBzAZmjWOU2kRtp/rT2wgKC8SaLYiaUf99Jz6Fxj/oNm8V/ptuhYy6WWVp1FfnZFgy6hvv7lF0nhLEiCdQvNeYoPZ0plSG61fvKIPJfYyQnWw5U6Fn8M3K9fHpgF+tkDzFZdri48ST3xMpAxbar0jHVnLIrR/UoRs8BC1QijIUP3picayTnRhtMLXnWW2arbFDsDDTG5yPYbIxF+XF03QNFrk+Jal10kRLnfxd5uV0RKE1jxshyJDa91uEJDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw5+qCe91bvLgIqfxCSgkFRDIj/jgBMn3b1Dgy0nhZY=;
 b=rberAeMNfq4dpA0DDypfh45OrmNtLc5v1q2pOS+L6+HAL5xCVR/uR7d1VJKuS004/E4jZ9EySyiLXf2ft7UCUGw8bbrbdOa/7302ODf7D46XSLc6tPqdCWbbxmbDn1H9i7gYkP6phBQ9jJ5/ckWMhfdExvaWi4VB83Q18pmSQRfEwrD8Dzmy5al8yfZSFt2csh3c8Y1aDUVcO080dfS9Q2WpZS1wnE8wFKPn3ltDh0QUhlBdCk8e10USpmq5kSrsn+p+xh+0mf9vFKyT7mXSy1cyQvnpAadph2EBE6UMfOHLEKtof6+lupQYTMYCmAtRgC97LnEyMpu5JypVtneksw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR1201MB2478.namprd12.prod.outlook.com (2603:10b6:300:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 09:44:42 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7%5]) with mapi id 15.20.5061.032; Thu, 17 Mar 2022
 09:44:42 +0000
Message-ID: <edcae0c1-a576-1560-5ecb-9dcf08d8ead3@nvidia.com>
Date:   Thu, 17 Mar 2022 09:44:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Ashish Singhal <ashishsingha@nvidia.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-3-kyarlagadda@nvidia.com>
 <391736bc-84c2-ec8b-9f04-614365953da3@nvidia.com>
 <DM4PR12MB57692EB17ABCA36E0515412EC3129@DM4PR12MB5769.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <DM4PR12MB57692EB17ABCA36E0515412EC3129@DM4PR12MB5769.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7506be7b-46ea-417a-c417-08da07fac2c0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2478A42EE608C19E8BE9AF46D9129@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UI5cKfjJPUDgaLaMVBSXpzSwJ+jdMGVFOkf+9YrTLzNKR4hoQRj+xtGofnZLgz+2LAzS/r6RGv/GQaE6+NUrwRLHubh979/yS5fF+gKcIew119VepnPncza6KoILy6NumnxSBo9LBR7uLqljNXTbBxtQFyzduYsNdMqscGFcRe7rag533ocsrN/kjOY6+PLVMC1RiKPPeWoGHldTPm4qD/xZjoYk0NAZ8lJ2StrBUYhjBAVtmK8CwNLrwFbksxEVKbrP8elgqFX5K1wti8Z532ofOrIsXhvJv5smDe2DNV5lRex1syoEdA34pD0gmTAnxuhD7vmyHFpp/lRm2V7pgE7pGKZVdbXLv6HnOtQ2ABIqWq6aDZM5FXbdMdflmwsTKFSonTCngAjZuNHmZLu27DJuyPw3zKAytOwbKzTGVZwQZvEpcelK5XgKdrsQb+STuUt9FOpxJ4S1KWOgR3D51R8Jxbab2FfLIPU8GauUSY+zSQgy4OIV9DMPiV0k211ZkMCmVeZJwjxLoGceiOBpaMVj5dQzu7DkU4t40TqS/k7IUCHdUC3V43irpRMqZjoz9ue1KKUAWPUIJXSDOgsN6CTrVt5dU+kXnfOJxZ+u0YAq0AaufKx9RydlqN58oeyYQyG7ssMZCZIaQEcQaeJjy2hh/+f9Mzn3gFI+fgmnb/AXoW3yc9mpYIipS/0IbsgQI9AAjZMy4kDf0799l1uStDTHY3noIheKkYux90yJkSrfnD9bW00bxu7EwsoWT4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(6506007)(6512007)(36756003)(31686004)(6636002)(316002)(508600001)(6486002)(5660300002)(8676002)(2906002)(53546011)(4326008)(6666004)(55236004)(66556008)(66476007)(38100700002)(54906003)(2616005)(186003)(66946007)(86362001)(31696002)(26005)(83380400001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1EzQ2xmejRvS0dGWStvdlNwMkFmWkJNOE1nd0s0WTlXUEExRDd0TGs3M3Vk?=
 =?utf-8?B?OUtZNUVrYkpqVDRKdDdTY005aFQ3OG95VHdXOEdkR2NYajM5MHBDZVlYQ3BC?=
 =?utf-8?B?NDFSOGs4bytnb2dyMXpOWUc1R2pwWnUzRjB2cDdKeTZZWmtJV1Q1ZXZITDN5?=
 =?utf-8?B?YU0xYXVRQ3pxK1JBSkJDM2Y3U0ptdng0aDVuYi9pclNqU0I3eXRqbnYxWWpT?=
 =?utf-8?B?c0FSdWJsM0o0TTVxTk4xTkhVWFlBcEFoRlN1NjdXODhDQ1IzVmgvRXNmS0pq?=
 =?utf-8?B?NFdFS3BoaUJ2NVcvVnQxT0dscFJzZFI2eTV5UENCNUsxZE1QTlc2QTg2dFFn?=
 =?utf-8?B?dGs1QmZYZ2FqZThwNFRDNFRXTFJtdHRaTHlOSkVScFBodWN5RGc1bUJyTHpv?=
 =?utf-8?B?Q3BBR1FYUG5DQTRYUWFZcjdqYnFoTlZqWDhydW1xdUZOZmV2LzBBRkVyM3pC?=
 =?utf-8?B?Q2lzZzYrcU9yK3ViaHl3WXFVQlhubmJ6OUJlQWI0eGJRemR1eVFqY2pyWnBx?=
 =?utf-8?B?ZlNnVzBka295QWtib0o5aHZVN2VzTUhMVzJpbEx6WmY5TXc5RDFaS2JaVzFs?=
 =?utf-8?B?eTZpZFQwQ1g0M3hGcnpmWVF5aXp6M2lxUTN2MWp0SW5TNDF1THVqSzBIZHRo?=
 =?utf-8?B?Mm5NdU1hWnpSNUtleVQrUmtrQlI0Rm9YTVJLNXBSVk9rdWprU3lycHlzWStr?=
 =?utf-8?B?M0RpNE5Wc1NLbnBVVkh4ZGM3WHBmcVh4dVVubDRZTkFpcThSbDJqemFOcWgw?=
 =?utf-8?B?Vzc2TWRxVWQ3OHNLTmVmdWpsbVQxRXJ2ZzlaTTdYSGo4TEhMbC9jd1ZqWStO?=
 =?utf-8?B?dTRFNm1WTUlVcnk3MmttQTRZdHJwckt1RE9ueGhQOGF4YjJnV3BUeEZSU1Mv?=
 =?utf-8?B?V3pTdTVEeER6N0JnTXZjcGRaMWhSVEhJOWFEZzdTcnZleU51WnZ4V0pwY0ky?=
 =?utf-8?B?WEJjS2VTN1RGM0FSUjE2Q3BiOVdyRjdSNFpnRzBVYXViYjZGMkdFRisySXhv?=
 =?utf-8?B?Ry9US0ZobGNxYVQxMjB6SEZuaHA5cysza3NXTXc1ZzJId04wUHpYcTNKQXEz?=
 =?utf-8?B?cGkrZEJxeEFKdGZZekNHUlJaTk1HdEZQZzZBY2xXczhhVWdsWHpYdng5a29v?=
 =?utf-8?B?MUxPS0NMZ1hVb2hkUkdPRnNzRkdVMVF1Y1JaN1FqRW1SaDcxak1ZZUpwd1F6?=
 =?utf-8?B?YlBLUzJOWEVNem1kakloSCtFUGowcndJWkVxT25Tclp1T0ZOZWo2Z0FVOHhU?=
 =?utf-8?B?RHU3SGV6dzdLWFkvZFpYTkRCZE1ZT1k3U2dPc0JieExBUmFSTXgreVVZUnhV?=
 =?utf-8?B?eG1aZXJ1SVpMaVhVWjVlb21VNzFXTnpHaWpLak50QlhSbkhPZko1ZHJmUE5O?=
 =?utf-8?B?VW5xUGpKYTgvMkNsa0cxczVtRjZNaDhmRmNiMG1UR3hybEwxK0ZoM2NrbnJN?=
 =?utf-8?B?RHYrUFFhWE1haTZiLzNjenNkQ0drbkdQRGdTTEFhTXJ4eGVKMmlVR3pQRDRq?=
 =?utf-8?B?RTlMWEd6SHFzbGVpRXcwQ29xZDVVWVFjOSttR2lGRkdXb205YVp2c1l5U3lV?=
 =?utf-8?B?VXZ1Mlh6dElUcEl1WldackxzNTd3UDdvMURGMU5QNE13MFNUVS9lcTlJVGRm?=
 =?utf-8?B?a2VsUTA5SW9VMnpSUU1USHVYZnpBWWswMjJOZFpaS2dpUC94ZGhrdnZJNDlp?=
 =?utf-8?B?eitzZ29BeTNzeUxBYzcrUTNiUTNCcVNjV2pEYm8vT0pLeGQ2MzR3cnpDemVB?=
 =?utf-8?B?MmpJdHEzNWVidlEwT25YQ0haMS9ZQSt0UDB5N09nVGwxQWV3ZElpcW1vUDk2?=
 =?utf-8?B?VGdkaWRVQVJCSHlkUFBic2UxZmx1U0c2MU1LMGdQajBvdjlzMW1pVWVFTFJl?=
 =?utf-8?B?UURUeWc0U1VFVTNjcnk4eVJCYmVpbFp4bkVKWDU2TEk5eThndEk2Y01VRmlq?=
 =?utf-8?B?ckRheTRkZVNWMjAxWGVjeGJDdDc0d00vM0trVXROUEJaV3Z1Yk4vcGRuNldR?=
 =?utf-8?B?K2hPb3FZdjhRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7506be7b-46ea-417a-c417-08da07fac2c0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 09:44:41.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG+9bExSmzTp1js5fIXmPjZz77ZYkRH9xDX9Ur5HPXilOW2AQCLYtEAirF5x+HpEGH9FJkrATjUbO+uur63pig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/03/2022 09:02, Krishna Yarlagadda wrote:
>> -----Original Message-----
>> From: Jonathan Hunter <jonathanh@nvidia.com>
>> Sent: 17 March 2022 14:25
>> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>; broonie@kernel.org; thierry.reding@gmail.com; linux-spi@vger.kernel.org; linux-
>> tegra@vger.kernel.org; Ashish Singhal <ashishsingha@nvidia.com>
>> Cc: Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>; robh+dt@kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
>>
>>
>> On 17/03/2022 01:20, Krishna Yarlagadda wrote:
>>> Controller can poll for wait state inserted by TPM device and
>>> handle it.
>>>
>>> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
>>> ---
>>>    drivers/spi/spi-tegra210-quad.c | 31 +++++++++++++++++++++++++++++++
>>>    1 file changed, 31 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
>>> index a2e225e8f7f0..ecf171bfcdce 100644
>>> --- a/drivers/spi/spi-tegra210-quad.c
>>> +++ b/drivers/spi/spi-tegra210-quad.c
>>> @@ -142,6 +142,7 @@
>>>
>>>    #define QSPI_GLOBAL_CONFIG			0X1a4
>>>    #define QSPI_CMB_SEQ_EN				BIT(0)
>>> +#define QSPI_TPM_WAIT_POLL_EN			BIT(1)
>>>
>>>    #define QSPI_CMB_SEQ_ADDR			0x1a8
>>>    #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
>>> @@ -165,11 +166,13 @@ struct tegra_qspi_soc_data {
>>>    	bool has_dma;
>>>    	bool cmb_xfer_capable;
>>>    	bool cs_count;
>>> +	bool has_wait_polling;
>>>    };
>>>
>>>    struct tegra_qspi_client_data {
>>>    	int tx_clk_tap_delay;
>>>    	int rx_clk_tap_delay;
>>> +	bool wait_polling;
>>>    };
>>>
>>>    struct tegra_qspi {
>>> @@ -833,6 +836,11 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
>>>    		else
>>>    			command1 |= QSPI_CONTROL_MODE_0;
>>>
>>> +		if (tqspi->soc_data->cmb_xfer_capable)
>>> +			command1 &= ~QSPI_CS_SW_HW;
>>> +		else
>>> +			command1 |= QSPI_CS_SW_HW;
>>> +
>>>    		if (spi->mode & SPI_CS_HIGH)
>>>    			command1 |= QSPI_CS_SW_VAL;
>>>    		else
>>> @@ -917,6 +925,7 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
>>>
>>>    static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
>>>    {
>>> +	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
>>>    	struct tegra_qspi_client_data *cdata;
>>>
>>>    	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
>>> @@ -927,6 +936,11 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
>>>    				 &cdata->tx_clk_tap_delay);
>>>    	device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
>>>    				 &cdata->rx_clk_tap_delay);
>>> +	if (tqspi->soc_data->has_wait_polling)
>>> +		cdata->wait_polling = device_property_read_bool
>>> +					(&spi->dev,
>>> +					 "nvidia,wait-polling");
>>> +
>>
>>
>> This looks odd. Why do we need this device-tree property if it is
>> already specified in the SoC data?
> Soc data specifies chip is capable of wait-polling.
> Wait polling still has to be selected on slave devices that can support it.
> I will add one line description for the properties in next version.


I can't say I am familiar with this, but it seems that the ideal 
solution would be able to detect if this needs to be enabled depending 
on the device connected. Is that not possible?

Jon

-- 
nvpublic
