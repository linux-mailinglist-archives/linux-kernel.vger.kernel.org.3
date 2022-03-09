Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092524D2B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiCII5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCII5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:57:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FE013D577;
        Wed,  9 Mar 2022 00:56:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THfbM9W3urHKdhJ8eOpMpyd2qi12lvEf1ADZcxDT8HoAQz2NXUcioDdyyPxdEjp9RZ0/cL7gXY7dNRopLrwwEG4RraIArcmNQDoHTfSX+xA5Xtb3rbqvoz0+kLQdDu/iHVT9++0qa+Pxa0VlPBhbhW88c0lKIrtqbrcM2qjboBSwDuAhFhygM5JA6BazwgQp/zREDlPePnwVachAXoh/NZr9NQulB85Q+F4iAQnlSpAylk63sifX7xfGxtu4zjEdTxHwGkr/Izx1EG2gbv+T6YrNVDHp3SPf8kbKp0xp4kFhERPH8nhIBeuv3lK8n/BW+9tdvNAjhMQ8V9tTiThtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCPnAu1c6L1z5hG78hBGDJP9VeAoq0K96vtcV+6iimw=;
 b=MTTv7uLk/A8xqwMWf/rb+jXDmWWF0o5q6O6GzGZ5P/4MF2FO0wiEAvsOvecdcCO0pMFOsoGs7gFcrvbAT9jnHu7j1PNpiUYnKS+NKMUlzEH1o8tSqYrrFwhYQoiW7z53CzrISI4NTaom8TXGoSdguKSi4YaafSS77lcVxYaR/bNmpe40UqwfpQk6H/gr+onjBziHKf24xOWAK2VEOrkl13XrTSa6yKNgD3RqGYrdQF8ID0Nplcp14DGOpwf4FeCuk9YXeYuwHwqzHrzZuzp+RfeJvPWa6UzN94cUCfsxzJiluFHOjJtqixML+X0/UaM/DbUQRHDX4b/nbi9aKb25PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCPnAu1c6L1z5hG78hBGDJP9VeAoq0K96vtcV+6iimw=;
 b=bmJMS+79zk56Z+l5HKJklvNf4UaiR/TOEtwAcQxswv7gFJV28UiqUQ0W+PwynY5D3bSbe8OHcfLpy6aFPDNVIckmwB32OuvOIf4Bj20aj/izYdnc9ZZJzhFjn1y4RAp6IZUVuaCRWE3PVhzDwTulzJPu3ZuNNXSdixmVOKCKHAqBR0SS08OmQOdE4pitNfT4FdJZ9fq0WdGKRx2ZZo6/v4pIfUlo1ecWFvpvZDBZ6FdCreIpDv7pPtqBL+3TmTLxlKVcz6KwOc1Yi8plU6PzDfqoY58pTqEvmYqdweDPWOP5iK2FzFndshh3UsPdLUMF6YX0kL3sebYzppFJIr96cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB5293.namprd12.prod.outlook.com (2603:10b6:5:390::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 08:56:09 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 08:56:09 +0000
Message-ID: <876010c1-0558-bd1e-e133-05403e5a167b@nvidia.com>
Date:   Wed, 9 Mar 2022 08:56:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v4 3/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
 <1646210609-21943-4-git-send-email-amhetre@nvidia.com>
 <34646ebd-2c37-65ec-ecfe-cfbfa4bd29d2@canonical.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <34646ebd-2c37-65ec-ecfe-cfbfa4bd29d2@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24acbbcb-4a3f-43c8-7ac6-08da01aaa755
X-MS-TrafficTypeDiagnostic: DM4PR12MB5293:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52936FF5CA6E021EEE266AC0D90A9@DM4PR12MB5293.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1g6TKMNKuIlNAGpfVIhGkBc3jza8+W70lk6e/PEcvBxWchWZfqQG6H4ePWTDAQlM8PSlinPlGfLHgeEQ515vAQAveJGGKb4jvbhd0JE1dpokA9QBXxAGdQXW8FYIB1P+nN6pk3pID2mpD55K27BQn9fTE6L7A+DMB3xEzWv/JWD7WWfXNu0g2PZFJsB7RYWoG3S+ELbtrr3pF4yrr5YO1oqFDYcP6XFpICNK0kLb4WNTcsfDF0ofjMTZfIUaQc4Z1QOYcdoC+45ivVoYTXufpituz+w60DwDiCnJ7DmCMUtu/ZsZhnVE0azqcNcxULE9y9R1NAqxV4VlLf86tk01DYFEkkiF7y6a3E58AN8vhp1cLg3hg+zjO2TAuaa8v/LU4HKxyTol0JQrfomVC2qg35F+m9qmViDGjMy2UeD/NDkA/+tUssv4KD/q2O7COpw3TmoNCZp9Jfe4ARv2rsr1p7U4LRrmqwHU/F7ze4VsyIt1PVhGcwvu1hxy7yjeGOJ+C5CFbhsW+KsCfYPwTCQl58jiIBYdJfhFcnGnZadgKs/B5HEGAs+qEI9DzNzVrtukbqkx7zoZrEGWvlJoHsK0F+uqPZMGwQVPo1nDl67l1990ZzOp3L3Gk3O/c2YhA6DyeIviA7y3rHFeQ8BxkEEbAm2MKiuy7JfTzNPcIudAdaCiJ29k8iUTd1RET1NT0/tn2pgHT1M7cG3av3XRE9mhjVCJstj5GqmTwsMkTjy1gXpLXRP/zXv6GMN1qyMW8kd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(6512007)(107886003)(31686004)(6486002)(316002)(110136005)(86362001)(53546011)(186003)(2616005)(5660300002)(36756003)(83380400001)(8936002)(6506007)(508600001)(2906002)(38100700002)(4326008)(8676002)(66556008)(66476007)(66946007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE5JcEpwWmVzcVBhdUM4MWhpTHZEN2YxN0paclVja0hFMGZmQk8vZHlGSXVv?=
 =?utf-8?B?WHVGWjJQaW1zRDhYYUlpeWpzTWh6TGU2eDF3UjArdU0wS25uYWtyOGR2U2FB?=
 =?utf-8?B?OHQ3THRNUHhNMUo3a3JLNTFQeSsvT1BNQUZZZHVBR1JJZzkreVBHbUE3R0lr?=
 =?utf-8?B?N2lsbDBWTUYrNlVtSGI2RXpvWTdVWTdNdzhnNmdRUEZuY0F2VkhLZ3lPQXpI?=
 =?utf-8?B?eEJBNTRQdnNwcy9tUnNiYVFEaUlrY0JzajQwUUIxTXVycWtaVUQxdlZLd2ln?=
 =?utf-8?B?V0FZU1VSTVlDYkc0ek9oTytabStCZkhjbzF4QnRYSW4vSitKZmJwUzdkVExk?=
 =?utf-8?B?dmZUU0JSM3lKUS9jaWgyR2M0VlJHU0VQTnQ0MUMzRE1hOS96MFA3Y2p2SEdH?=
 =?utf-8?B?Y2wrNVgwTFZjeGpZRjVnd3dWWVE5VTl2NE1HVlE3VG4vaWZCRmErd0JUZFdY?=
 =?utf-8?B?dzFvajdla0VSRmoyRCtraytCVUoyei91OEJNK2JMUGpVNXdCekdPTG5JZ1Av?=
 =?utf-8?B?ZXJGeWRqY0FJWkpWMHJEb1RuNExYcjBidkxuaE4yTjhSNWw0SHJtc0JSb3E2?=
 =?utf-8?B?VFNaY3VlSlV4ck1zVVR2T0dWay9rczhrbm5wN2E4b2t0NlZ2UW9oNC9wQXhO?=
 =?utf-8?B?cVgzbjBvZHNacStDa2VXOS90L0VqNmtYY2V6WHV5VHp1NkQ5VENtdkJScTcr?=
 =?utf-8?B?RjR4Q2dTb0srUUU0WnFvK3BicUR3d2ZLZ1E5bWNDRjQ1VTFTYVlHNCtaV3pU?=
 =?utf-8?B?L2JVR3lza0dhb3JJR0pHeTVSbWNMc0hiWkFyY2FReWh3djI1by8wNFZVV3VW?=
 =?utf-8?B?RkQyZ3dxejdjQU1HT3ZqYVhFR3JEK1pmb2pra3VFNVlMZUR1S3VuK2JXUmdw?=
 =?utf-8?B?OWJEaGMxcndaa2YveWxTUnNBM2Uxc1RJSExLTDBmTi8wUGVubndRWE04WUM2?=
 =?utf-8?B?SVBVZTduMWE3Ykw1c3BOVG1jaTVWckg4Lys5TktLZjhNMXBnRVRGdmdyL0sz?=
 =?utf-8?B?eDluT0dOVTY5OGkzaGhqVVd6T0NWZmsvS3NhVVJJd2dsbnY3VmxCRnlqM29T?=
 =?utf-8?B?OWR0bVNXM25NL2x6Y3l0TkY2SXY1aUJwcFBYYnc5SU4zYjBHc2R1ZDhYcVJy?=
 =?utf-8?B?S0RzeG9xSGFpdjMyTXZreG05SzBEK2pJRlpRNlNHd3lBbUhDVm1zR3dnME9a?=
 =?utf-8?B?RzNCWmJvOTltQ3psT2RuUkJleUY0c2VMWTBlUVIxVncwcjlSOVNpMUxpdTlY?=
 =?utf-8?B?MWlId2M5RUVCb3JHYVBINnhnVUNpbFFKeHZQaVg5akEzUHpqUWhtZTdXSllO?=
 =?utf-8?B?R0FqUmd1MFdCU08vOG1TRlJrc0VQK0NFTHRkZCtkcms1eG8wQ1NoQ2crYy9V?=
 =?utf-8?B?Rm1KMnJkeTMxRStSN2NZeU1HOWMzdFJBdmc2aUNrcStCRU5Mbm5PMmtuM3gx?=
 =?utf-8?B?dkE0Y3BFU1dTS0MrVUZHU3BnejJKR2JwVVIzQUdQYVV3TEZ5WmlUNEdjbzE2?=
 =?utf-8?B?bDhmTklBRERJR2x0WjZrRDJRdnFJSERRcGFqNk5iT25HZS80SU5KSWl3N25s?=
 =?utf-8?B?aVh0Z1hIcXNoK2VOL1pDWmRjdXQ5dzVwZWJsdENTMkpFeTJqY1F2L285REhL?=
 =?utf-8?B?MHljVVF0MkhTMHRTR21ybkRrazNQTHB0eG16WlpPZmFiZXVQYmxVQS8xaU5q?=
 =?utf-8?B?K2RvQlFPUi81UkYrWW9LaVlxR0wxNXJ3Rzl4R2VmRmMwdjM5d2VId25ULzN5?=
 =?utf-8?B?RllUY2UvaUtCb1crOFJ1MWNOREIvajlUUm5oN09pRWxxSlNCbjJVSm5YL2sy?=
 =?utf-8?B?bFUyN0xER3c1U2JBaVk4bTFHdFZadk8xWmt0TE43SFY3Yjc5dkw0cFFtcVRG?=
 =?utf-8?B?MVozdnJZUVlzdjFvU3k2Vk4rRm1uMnhzWVRmUEVPbTFlRHR3TTdmUkN6ZlhL?=
 =?utf-8?B?R0Y2aW9tcE9nZ0l4cnZQZXVDM1RvcXJFRHY3MDdwQysxRkI1eHNrRmxad1VT?=
 =?utf-8?B?RE5UWGM0M1pobytlbHcwYlB2eHQweGNHeWQwcmg2akZ0eG5XK1RwRVdoU0Vu?=
 =?utf-8?B?dVJGOGJ0MDBKalZuSGFHZ0FCQnNBQ3FrY1N1Zm44WVdXUDR0NWkzTWs2U05Z?=
 =?utf-8?B?czkwd0VVOG94Q0hBb3dGOHlydEpCNWJ5RTcrRGQ2a1BidlBXMUlZQlR4NFJ5?=
 =?utf-8?B?RmNTMDhJR2VRTHZzNkpFWVVhOHNXWFk4U3NtZ3h0MHNBbEQyNFh1VjVqRWR4?=
 =?utf-8?Q?j/1j5UnaQYqL7I01/zl3CQ8lN30WwZ+KlTmJVOU6vI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24acbbcb-4a3f-43c8-7ac6-08da01aaa755
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:56:09.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B01plCcybB5uQCnNQi0ZZRq71Tby4YMpNVHQaMlY9N5Juc5rF589lFWu281ClmYpBhFcA7CzJmLN98WbwGNtYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5293
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/03/2022 19:35, Krzysztof Kozlowski wrote:
> On 02/03/2022 09:43, Ashish Mhetre wrote:
>>  From tegra186 onwards, memory controller support multiple channels.
>> Add support for mapping address spaces of these channels.
>> During error interrupts from memory controller, appropriate registers
>> from these channels need to be accessed for logging error info.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.c       |  6 ++++++
>>   drivers/memory/tegra/tegra186.c | 21 +++++++++++++++++++++
>>   drivers/memory/tegra/tegra194.c |  1 +
>>   drivers/memory/tegra/tegra234.c |  1 +
>>   include/soc/tegra/mc.h          |  7 +++++++
>>   5 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index bf3abb6..3cda1d9 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>   	if (IS_ERR(mc->regs))
>>   		return PTR_ERR(mc->regs);
>>   
>> +	if (mc->soc->ops && mc->soc->ops->map_regs) {
>> +		err = mc->soc->ops->map_regs(mc, pdev);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
>>   	mc->debugfs.root = debugfs_create_dir("mc", NULL);
>>   
>>   	if (mc->soc->ops && mc->soc->ops->probe) {
>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>> index 3d15388..59a4425 100644
>> --- a/drivers/memory/tegra/tegra186.c
>> +++ b/drivers/memory/tegra/tegra186.c
>> @@ -139,11 +139,31 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>>   	return 0;
>>   }
>>   
>> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
>> +				struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	int i;
>> +
>> +	mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
>> +	if (IS_ERR(mc->mcb_regs))
>> +		return PTR_ERR(mc->mcb_regs);
>> +
>> +	for (i = 0; i < mc->soc->num_channels; i++) {
>> +		mc->mc_regs[i] = devm_platform_get_and_ioremap_resource(pdev, i + 2, &res);
>> +		if (IS_ERR(mc->mc_regs[i]))
>> +			return PTR_ERR(mc->mc_regs[i]);
> 
> This breaks the ABI, so I need Thierry's ack that such ABI break is
> perfectly ok.


We should not break the DT ABI and so if all the reg entries it should 
still be able to work.

Jon

-- 
nvpublic
