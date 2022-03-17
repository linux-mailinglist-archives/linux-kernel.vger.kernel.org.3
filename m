Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2450F4DC9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiCQP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiCQP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:28:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86376208241;
        Thu, 17 Mar 2022 08:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4NkN8J8gQwm0kymE2Ju/1Qpcm6hgUwXhSchJCc9INZBOOJVBjp5H+5zjcWjktALJ54wwZSheZ3GAfI91mseWDSftNPYD+pMRliR5ot359R7Z55HK+A0gYxl4KAEIHrA/tBIMZwAAPcyun3UbqAXU3p9sGJlBsZni0euOYW2SERlK+KG18C+xXCjy5wy3G+jwU6f5Q9DMWirNxGdOkq6a8sJzLuEqtUNMyAUDs1eAGnGliB4RSsocVngUDeIEzgnnAqCswgsJd2Sz6mA7QIu/f+EAiqVHNbQuYoKqwRIqSSIBZEdIgFkMEKndl0TWiT/IVn8PiCALM7hfGQh5YB8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP/E54fVj4G87Oh7Kxy9WgZ/LQCDunggvy2pJOwYN9g=;
 b=Ab61hzbJHj9OkLpU+UtmC2/Y9vGTatjP9gsz6TvCO7D/1C42bSBkKaRmg7iF5XUwIl+pZsa2/A1MSia+YM61iRajhuq4LAS0CrONiTyWV3prjvYDBavVRJFNL6r4s1VKAJAo63yq/WLO1SRrPBuNixrNh6d63TXDuhh4ZaUajqnAg4Iicjr1EtF5ickTNl+a+4NQ9NCTcMw4gltCnhB5mtIEfUldUmVh+h3/uurbuzlzdLS9fyeT6qKtbVMVB2O4aq1zL0Rm5L1FpYv4McWsq3BK3Tt7c+5Ndzfl1x0JXgzqiYZaDLVe+Q66ErsMzHZ8ieiTWHQTaiXKT/IF9dXyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP/E54fVj4G87Oh7Kxy9WgZ/LQCDunggvy2pJOwYN9g=;
 b=Ma6AhPZbAxI9R4sCp+Y7P1GX9QEfvDCyqVmd6HRHpR5O/IL49/if9cM3d8didw45jiOd/7NnrtAIZs1Kt8PRObcmn6fHu/L+ccJ7EmZ0dofMv6bvhokhtaSVzNc7Wnd+BfTnUjkQPlYUbLo1hKxC+tY47X6Yto1jYjyqnOGx05G8gWryvUqhkiIOdmmeKABgp8w6fjpPgStGN8sFTkuDoiqNvyH0bt9n0PuZl96csH6eTE6auN+cgM8AdFnnNFdJFm5k0LvskBkPAH0BQgnNA8TM5N4txdeFj4t/H7enZCOndsDogB5drxh0acN9Yk1VrQhpEfY4sxHB1H5ud8dKLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR12MB1312.namprd12.prod.outlook.com (2603:10b6:300:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Thu, 17 Mar 2022 15:26:36 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7%5]) with mapi id 15.20.5061.032; Thu, 17 Mar 2022
 15:26:35 +0000
Message-ID: <7032fbfb-8899-d00b-a7fa-811e19d38ce2@nvidia.com>
Date:   Thu, 17 Mar 2022 15:26:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
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
 <edcae0c1-a576-1560-5ecb-9dcf08d8ead3@nvidia.com>
In-Reply-To: <edcae0c1-a576-1560-5ecb-9dcf08d8ead3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f99f77-5357-4f16-45c3-08da082a85ef
X-MS-TrafficTypeDiagnostic: MWHPR12MB1312:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB131262A3FE6E549927DD005ED9129@MWHPR12MB1312.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyZpD/dSp1T66RmbnvE+48uqjYnJcKqeCwIrmjgxboMbIyA64Qkj7uWze3b4mapN2ai00r7ogW4pfylYxg/m7htQImUg7em19YNLPF7JG1UGIzjN1lF6VKkuGEHu7gEvzsNGHW4kKjfYkhSL8fETDH17m11LgyOub331TlrdQeIQ7ZPDH2T9L+MTaBev1aQCeRkBrY/qVGHvQoqdrYfs4c1is1wvqhWzfXoT5wEF2Y5nr9eviQxCLC/Z0TD7GPp3dNNwD7J7a3XW+anqtIQ5hUfKB21LsLkoiCTbP0T+SWKOxe+oO1BFznNVlIB/bSG1IM73jWi6KpDPNYp3vWJwuWPaMOPdnKHSIDR2AXfnVwTjwUO/zF9LqCVqXcrCfTvBYvoUFpPFPBSNmqpHnGZ9ozJs1FY8eiOaezLAflUSS4W6wEidNL7qKWzeo3eRW5sWtWfchbruaJEMG5YKSEr59iqPQujYysQ2+WfLLRSNw7RQRSEO+CWfGjwu9Stfn+mk3aNi05MEkxv9WhwF6utC96KzFslavElvhp+jZiocroEXUSKcqCEMR5J/kfrLqCUNDsuH3Es4JjtlSFy/jjmP02leS+p1kAQyQH8H487I9MswxCl1bRHrJWRbUnkEHKlHXGEecwaO5YhRp9Wx8hrSdLLXAgG2n78NXDKX+gZO9T4KaQtecyvvc6LrOg3I6zBJ977Md692wN2K52/gWEa0qmKb8wA+RYAG7Sk+DxYy2cQgSU4dPIwS6/4OCSSWumcj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(26005)(316002)(2906002)(66476007)(66946007)(66556008)(8676002)(36756003)(6636002)(186003)(110136005)(54906003)(31686004)(86362001)(31696002)(4326008)(508600001)(6666004)(83380400001)(6506007)(53546011)(55236004)(8936002)(6486002)(6512007)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhKeC8zWFFqYm1QdjZsUXUvZ2R6TjV1OGpDNzJtbXJHR2NwOFh0bmFuMVoy?=
 =?utf-8?B?M29hNE5jazZ2YjdpYTBhVDIxYlpoUVh0M3NBcFZzTHdPOFQ5dnJBTXpOZDhM?=
 =?utf-8?B?ZUVTckZ2MlkrSHpoWk1yU1BDWmlZU3VMQVZWNnpVMEJoQWYwZklWUWlIaUhj?=
 =?utf-8?B?SUo3T2xqdlJRRm54VFROd3MwYnk2M1VKL3NFaWNKS3Q2NE1KNGkwNlRuci9s?=
 =?utf-8?B?YWhJOFpjUjVzbVJjYTd1VWFDMll2Sm1IRkFxWUh1K0R1dldubUI5ZVlkUVlR?=
 =?utf-8?B?NEE0OEwwZW5qakxlelA5OHZSamh1Y3BTNC9ucTFxRUoyWHdHbGhXV2NrUzFt?=
 =?utf-8?B?ZW5iQUNORW1OeXNsU0UzTGc2dGFhSEl3QzhxblJ2bHpScGp1cjVnMHVBT0d3?=
 =?utf-8?B?TnFrN043UmJOaUFrRm85T254Ri9Uc2t6RE9QTFR6TTMvdHEwUHh2VEFmYUZP?=
 =?utf-8?B?T0orb0ljL2tCeFN6b1VZMGJLUHR4azY2a0k3Qk9MN09GZFRQREZsVHBCbmpE?=
 =?utf-8?B?MGRkdjU3M1BVOWxBbFlWb2VYeG5sdGt0ZXNlU0kvb3BrRmdVQXBTVFl0Mlhs?=
 =?utf-8?B?OEF2bHlWNTlCL1Jsb0dVN0pXc1N4UnNiYUFIKzV0L1BjL1phcDZ5RFprTXVU?=
 =?utf-8?B?bnpYYnRXdjR2ZUNUeG9rLzBUTUxOWmpOMlRzRURCQ28rd3lqUnQ2d0RreHNH?=
 =?utf-8?B?dkpTN1NNclBGbW1CSUE5NUFOSUMwODFKMjVTcnNXYkJHWktTK2xhK1c3UGVh?=
 =?utf-8?B?RHY2OXFrYVJodGNFZTdHNi9IalJtbzRPbEV3N3A1VUtFOEMybkU5TTErQndT?=
 =?utf-8?B?VzNuSlM4V3FzYTg3aHNvQWJ4MDFqcndiZG1PUmVWb2pRWUNQelo0MmUyeHhC?=
 =?utf-8?B?RU9wRHhmUTNUc3NOMTlVRkYrMnRHVE5sZmNHYzNDSWhuOUFkOWE3M0FvSTA1?=
 =?utf-8?B?TGpVMDNxSWpyb1pFT1Q1V2h5VmVQQVFUUWZMbEU5dm5tdVFJbXllWldpYmtQ?=
 =?utf-8?B?bituQTlybGFPa2xmS25PSmFTYUs4UE5SYk43ZDZ0SlAvdUF4aDZXdjlEQVRM?=
 =?utf-8?B?aW9leExTUnZtS1AwUXJBTTVsaTkxTTBKQmIvSkF3dUMyVU5DcENtdUw5aWpL?=
 =?utf-8?B?VEN3bUVva0czd0hHWktENDh2T3E0VmkvRGtXdzhWT1N2NlMyNEJHbkJoaVdh?=
 =?utf-8?B?Vm51b2ZyWXIralBiS2x1d2NBTGp5NzN3R29aSlhRVTBLOWhsZFNpTmJUMlMv?=
 =?utf-8?B?SGVuQ1FlbDVueFVoOEYzRXZkWFNBRFc5cDFJbWZzUzFnK2toNXFyRm5icjhO?=
 =?utf-8?B?bGE1OFg4MGJFWmwvMyszbUtJWFE5MFA2U0EybFVXcDBiRzhPbjhOcWliQ2xN?=
 =?utf-8?B?SjdnSXYxTjVHVDdQNzc2Z1RCOFc4ZlM4dXMwTnl4UXdHWUVPcUx0cnFiZmRF?=
 =?utf-8?B?UWhWMVF2ZUZSeUJ4NjFvWlRFb0E1bzN4VzFMU0xmczYyMWIxdTFwUysvZloy?=
 =?utf-8?B?aVl1SEZNb3dicmlvQ2RqdG85endDTnJWQ2wvaUdwcE5lbENwOXpMQjJSVTRQ?=
 =?utf-8?B?NnZsZkdGbE5vK2h6MlZ5UDBSdDFvNWtBeHNERVZGMGlTNU5wVk9QbGp2WVV4?=
 =?utf-8?B?RHhIaldKckhxUjBZRjByTkU1RVJiZ3VIZURRbGJtQXB2TjV4U29xUnJGTjFP?=
 =?utf-8?B?OFRKbFdwZzB3cSs1K1ZwNnk2bmFvaWpqRlIrbll4Yy9nMDM2UTg2UllodVN4?=
 =?utf-8?B?VUVrWFdmNFlVRUVoSnY1aTdXR25yTFA4em5FeEdES3VaZThUbUVQcVdhRy9K?=
 =?utf-8?B?K0VCTmp1V29hOHhxY3UvYmo4UEh0UDd2S0ZuOVdWRE1oSUxVcUM0OHd5Z09J?=
 =?utf-8?B?Sk9lRk9tSHBJNHI5UXNLVzdrQmRodEJ3L05obk9DRFVCZ2trYkR3aG9tY0ha?=
 =?utf-8?B?YmhMMnRFalliYWd3OHNxeFRtNU1kZjlMekI3TFovZWIxN2RMUVUyL2JWSTJS?=
 =?utf-8?B?b1RvZ0JRbW9BPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f99f77-5357-4f16-45c3-08da082a85ef
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 15:26:35.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DKqFmTKinnAKnmyWzYCDm5TEaU+cAT5bdQrvUv6/6LC7+Gne8LY4QugkPDvoDBEK3TQCcHP0uFAnHs9os7ChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1312
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/03/2022 09:44, Jon Hunter wrote:
> 
> On 17/03/2022 09:02, Krishna Yarlagadda wrote:
>>> -----Original Message-----
>>> From: Jonathan Hunter <jonathanh@nvidia.com>
>>> Sent: 17 March 2022 14:25
>>> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>; broonie@kernel.org; 
>>> thierry.reding@gmail.com; linux-spi@vger.kernel.org; linux-
>>> tegra@vger.kernel.org; Ashish Singhal <ashishsingha@nvidia.com>
>>> Cc: Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan 
>>> <ldewangan@nvidia.com>; robh+dt@kernel.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
>>>
>>>
>>> On 17/03/2022 01:20, Krishna Yarlagadda wrote:
>>>> Controller can poll for wait state inserted by TPM device and
>>>> handle it.
>>>>
>>>> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
>>>> ---
>>>>    drivers/spi/spi-tegra210-quad.c | 31 +++++++++++++++++++++++++++++++
>>>>    1 file changed, 31 insertions(+)
>>>>
>>>> diff --git a/drivers/spi/spi-tegra210-quad.c 
>>>> b/drivers/spi/spi-tegra210-quad.c
>>>> index a2e225e8f7f0..ecf171bfcdce 100644
>>>> --- a/drivers/spi/spi-tegra210-quad.c
>>>> +++ b/drivers/spi/spi-tegra210-quad.c
>>>> @@ -142,6 +142,7 @@
>>>>
>>>>    #define QSPI_GLOBAL_CONFIG            0X1a4
>>>>    #define QSPI_CMB_SEQ_EN                BIT(0)
>>>> +#define QSPI_TPM_WAIT_POLL_EN            BIT(1)
>>>>
>>>>    #define QSPI_CMB_SEQ_ADDR            0x1a8
>>>>    #define QSPI_ADDRESS_VALUE_SET(X)        (((x) & 0xFFFF) << 0)
>>>> @@ -165,11 +166,13 @@ struct tegra_qspi_soc_data {
>>>>        bool has_dma;
>>>>        bool cmb_xfer_capable;
>>>>        bool cs_count;
>>>> +    bool has_wait_polling;
>>>>    };
>>>>
>>>>    struct tegra_qspi_client_data {
>>>>        int tx_clk_tap_delay;
>>>>        int rx_clk_tap_delay;
>>>> +    bool wait_polling;
>>>>    };
>>>>
>>>>    struct tegra_qspi {
>>>> @@ -833,6 +836,11 @@ static u32 tegra_qspi_setup_transfer_one(struct 
>>>> spi_device *spi, struct spi_tran
>>>>            else
>>>>                command1 |= QSPI_CONTROL_MODE_0;
>>>>
>>>> +        if (tqspi->soc_data->cmb_xfer_capable)
>>>> +            command1 &= ~QSPI_CS_SW_HW;
>>>> +        else
>>>> +            command1 |= QSPI_CS_SW_HW;
>>>> +
>>>>            if (spi->mode & SPI_CS_HIGH)
>>>>                command1 |= QSPI_CS_SW_VAL;
>>>>            else
>>>> @@ -917,6 +925,7 @@ static int tegra_qspi_start_transfer_one(struct 
>>>> spi_device *spi,
>>>>
>>>>    static struct tegra_qspi_client_data 
>>>> *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
>>>>    {
>>>> +    struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
>>>>        struct tegra_qspi_client_data *cdata;
>>>>
>>>>        cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
>>>> @@ -927,6 +936,11 @@ static struct tegra_qspi_client_data 
>>>> *tegra_qspi_parse_cdata_dt(struct spi_devic
>>>>                     &cdata->tx_clk_tap_delay);
>>>>        device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
>>>>                     &cdata->rx_clk_tap_delay);
>>>> +    if (tqspi->soc_data->has_wait_polling)
>>>> +        cdata->wait_polling = device_property_read_bool
>>>> +                    (&spi->dev,
>>>> +                     "nvidia,wait-polling");
>>>> +
>>>
>>>
>>> This looks odd. Why do we need this device-tree property if it is
>>> already specified in the SoC data?
>> Soc data specifies chip is capable of wait-polling.
>> Wait polling still has to be selected on slave devices that can 
>> support it.
>> I will add one line description for the properties in next version.
> 
> 
> I can't say I am familiar with this, but it seems that the ideal 
> solution would be able to detect if this needs to be enabled depending 
> on the device connected. Is that not possible?

Also, given that Grace supports 4 chip-selects per device, how does this 
work if there is TPM connected to one chip-select and something else 
connected to another?

Jon

-- 
nvpublic
