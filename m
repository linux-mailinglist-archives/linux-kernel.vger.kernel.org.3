Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63F9500582
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiDNFiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiDNFh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:37:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0903CFDF;
        Wed, 13 Apr 2022 22:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO3JPyu2qyB69cJIGwS+vsuNJAY1QYlwr7+neL3tyZ/QHYruA2H1MHP5o0E+V1t1ZeWqM2Ef2X2a2AzksLXAfiGngdEzRATPGAEXeKjLn/FOhPtuvcDd9NKiBhxvNftt+gEBfCwncSCupuvyNfaEL2YnR4TLMdhWkraXGvZsK3J7nBQoLZwypU77aeL+CJXVEUUVhRtQW4UaZ5WynU2J85vuvLATfgTHKNPS1o+IwfqvKskbjDhrUkzYkND1QUOaaTU2QBIV+LDyp8KhWDK0iJS8Nb+Q5PLVEZ8ZQeuv/hR6t418alrocsIH/j0xj8//YpB6weZRGgiPqhV4y48Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS88tHurR17nPzSXa+x2+3G+ZdShUqF+DwNUE0wTpQw=;
 b=dI/W9pC2Gvwnt7SUGBaOFekaiKa5URzPEQBfq8je03Q7sAteHMHb4HCbNmlTPZbsrAtVixEHGuvNkqFYwZlF8CFo35/lXlQtxkN6kzsM9VYE5BOsN0ApJAnNnDZnLt4Sw4/S3suGwkVLnS+nUYDstgSfk89FVhArPsicwZYHmuUjrHTSt0KOw2oYgOAuzj+Jm6vTrAwhZmN7RR/U98OfPZ/ie3cfBa54tIqLznIZtToUFZa6rM44Rb6DPYiv6iFHDZZsxa+vDq2hSk1WZDv4487vgJHz6Zg4JmEBKSUjg3yCwzRcz3UKv8oZmvGProeFkkTjE7bZ76qCJZB4bPZY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS88tHurR17nPzSXa+x2+3G+ZdShUqF+DwNUE0wTpQw=;
 b=csmNqkQkQf1zH2CEhI3cUUkYFhFMnXIscBFhgjk9Jgymb3YxJp+JXEKOnWUUbqMWa79fSl48H4IIfPIWRCjkOaoftgIoiIs0Es8slCGGxto0qTXmxc3Hi5Fb6NE2WeaTw9XHFIkOgk1wzpfRbI2eKB2htWYZVGHDvV4JOBAcYAwV+WenAx3moOHz47Q1U4+DLHnH+C30a3Czlm/5r8NPUHCtIiK96sLi8Otp/nUH7ktqrfgYIygNRvlrnxU/wWQTY/p0O2T+Bbs/qMe3pU7WMBhtiyQuRl0tcwsxkUkTB6wpX5WfAGKvjH+/ae5W1SKPXbQSVR4lY1JyJd8YKBBT1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 05:35:32 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 05:35:32 +0000
Message-ID: <aa8ff319-d80a-6810-ecd1-dcc9b64143db@nvidia.com>
Date:   Thu, 14 Apr 2022 11:05:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v7 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>, digetx@gmail.com,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-2-amhetre@nvidia.com>
 <7764e6b6-9f3a-42de-bc99-36975a4af5a9@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <7764e6b6-9f3a-42de-bc99-36975a4af5a9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::14) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d4cca4-0917-4e07-061b-08da1dd897a4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4130EF170040513CED284280CAEF9@BY5PR12MB4130.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpOxL+dEQw0mv7OSLvcGID3ujHUlRJGr0Zfr7rssuAXN0pjG8W2p1NYDPux30H9kDf0wVMhAKI0goMqPrKvwrCGOUzWHvB4WpqI7TUTAoyYMYWdYBAzrkgewVBdPFVuePFWH2xcUwnYpQnfHghl94gTCDWAwImyvBm9iZd0cmEO1wQX5Pj3SubwEn1RnLJ9m3YuwvEojl+3X2HpCYqe6MFiEiyX6nVydmgZMZ9VF8wG8yMOoHAWnHhVpFk8mYC1dkusb8qfMbshQwvGRbpgF84R+1KyRWot6wivCRZbHOXWMbypppvcDc0ZsHrFeBZkH+x7ZYTXBgFVMTJn86WHlSzU80miDL8Wbj5YSSnUq2r/lHOBXeqfeuFSr76OfTMwc9svudxcind90Cp+kVJPxXAin1o+nKkr/MixU9hhzIB6VdP1JhG9ViwNwITa9/x5YOg12BfWH+uoVUp43SEjPEJLODFU5QUUQ0qnhpzlJleSGP58FYOylb4Ae4bS0aR4LVuBTKAZE3K630PzExVU16jWTiEbvw32y/IQHopPdKALut4msrOrbiJIJyla1FnMLoY/ydIdrFQKA/aviuStfJ+vt+xJenZC+UNSzlK7dISrPLa65sodmE1j8VV09rZNPdSv2P+RgRr0xBMhxSYc6kJcOuh2eQVhtjH04TbwrwMjUcCKyIM6hRivfQdZNJGfSZbpigPBi8ach+LPC0mstvfybBX0+Ny3kKg1H/VyO11aaKBQLnKsyDsxRgRhoJ4+4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(53546011)(38100700002)(31696002)(2616005)(6512007)(26005)(6666004)(6506007)(31686004)(83380400001)(107886003)(186003)(921005)(8936002)(6486002)(2906002)(5660300002)(4326008)(316002)(86362001)(4744005)(508600001)(8676002)(66476007)(66556008)(66946007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUpnK3RIVlJsclh4K0VDL3hlbkhzWS82amlhYmFvdjZHZ2VvVSs2NWdZR2ZH?=
 =?utf-8?B?L0NIcU9UNHVORjJpcHJHU1QveGJNYThGeTZadS9SZGQ3VnJ2b3B3cGdVWXlk?=
 =?utf-8?B?OEpVUWtJMzkrUWFYM1hZYXlxNHg5T3ViWVNEV1Q2c1Exdkt4N3dNQVB4WE1T?=
 =?utf-8?B?TEFkSW0ydGsraktuUWpXalAwa21PUkZJVGw2azlJQ3dWaWl3dFZuck15OENy?=
 =?utf-8?B?RG9HQlV4REl1NWJWU2dFYzJLclAwTXNQVFo0Tm9FaTRidUthK1FBY2VXaW5q?=
 =?utf-8?B?eTVBVWswMjFKbVNodjd3T0Nkcjk1WnpoZlhXV2ZrdklzQXhYQWtvc0FSMWV4?=
 =?utf-8?B?N2Y5dm1lYVAyRi9IblZtQmlqcVpRKzViY244NkJ2M0lwY3JiQ1lMeTdNa2ZS?=
 =?utf-8?B?S0FDNDUxaU1BUmNObzIxRnFNSXNwcnhzd2JrNzdNVWI1ZWNPTGV2QS9NcjIv?=
 =?utf-8?B?RURJb3h6eFVzdXZqNVZ4MnFZdUFkSmFlemhwTjZtcXlrdFRVRUs4K3hFTFhI?=
 =?utf-8?B?anZjYUhUNTMrb3ZwL3hKeC8rV1Qyazh0VUc4UngvQmo5YUJBaFdpR3QxWXYr?=
 =?utf-8?B?OGM0dlluSno5N2RVdHdLV3pIYW9yajA5eW5yd0JYMS9naEMzL2htdWdvTlpJ?=
 =?utf-8?B?ejVJa1RGaDhnaFJKOC9kTmlLandaaXhWd2RJVEhQZnMrT21XLzhtbTR6b0tB?=
 =?utf-8?B?VzZsdjFEVjQvL1ZzSUNxL281YmRpRUFZMzRCWllnSTd1dzVaSVZiTmtWUTRm?=
 =?utf-8?B?L3FtQTRvSGpvWG5FWm5uUkdmL2dNZEhIYUJLK2lQODI4MFJMbTY4QVNJZ2ND?=
 =?utf-8?B?cG94WDFtWllsR0RUNjNQZHBkek5EbFA0Ymg1QkF6NitXL0p2SXAzVkxKbkxK?=
 =?utf-8?B?RWxvcHRxeXFhNFYzbldObm5VZE9CSEw4MEZkKzJoV2xmSUJiV2lGaUZWeUhL?=
 =?utf-8?B?akE5b3duRDZNS21ObmZwZmdIbmMvNjFIUWc2NlZ6MjY2ckF1MkcwSlhjd29y?=
 =?utf-8?B?S3pRdS9XYXdGMDJmNW5COW1MeUZxdWFjQlNzRUsrME8rOXRjV210SWoxem5I?=
 =?utf-8?B?ODZBUXpkZ2Q5bFJwVnRGeDVWdG1UQkkrNUJUTEFGNG93YWkzNjhaSkY2c0Nk?=
 =?utf-8?B?TkVUMi81Y3pqS0d1Y253UXhFMlRKWURTWUNuVGVXZXpnTzBvOHRkQll2dkkz?=
 =?utf-8?B?dlZNVk9kYkZWYnk2SHpPZnZHQ1UwTGppcnlhbk0vYUJpb0NHQThicUZJLzNy?=
 =?utf-8?B?UDlKc3JwalBFTTVPZzNtRkRqUmszcDFCUHdBSVlWV0VVZHdPV2t2Tk5jVm43?=
 =?utf-8?B?ZW9ETTYvV2hkVC9hdWdvUTZINU00SVRSMDR4THJZemZlN1lSaGhtRitCMlVn?=
 =?utf-8?B?NHB6em80eDlEQXR1MzFQSlBYQnVkTjNKZ0hDUnpWWUZSOUpvd2xUVnV1NWcw?=
 =?utf-8?B?NlBkL3JoRkFqSFl4MUpENU9Icm12Y011ZloraHoxODhjL1Mxem9WMDRGeWpt?=
 =?utf-8?B?cEhlZ2s0ZEo2TVRVK3U5K3BxejcwK1hIdEdIbDN0b0dIQU5rUFg1bTU1eGhQ?=
 =?utf-8?B?dWJjMFVVOUYwZnZoSXdCU21TendoQmR1Zm1CaXlLTldnMy9jU2VoeFk1SDR3?=
 =?utf-8?B?aUx4YXJ1SmpxZDd4YjgvcFZQYzNFUUhmVHZoZk8yVzJmR1B5K0U0eENlRUlC?=
 =?utf-8?B?MWZQMzQ0ZGtlYXQvTEhraXF6Nk5LaEh6VUo0OWlTSDFrSDZHVDdRa3BiZ2xk?=
 =?utf-8?B?b3FUTEVLZmlLTVI5Z2xEN3hqVjV0QkxoT21MTUkxWHc1Z3hBSDByN2ZNODBV?=
 =?utf-8?B?R3hQRkVEMFNhQWMrOXJEQ25Mdk9JV0RPekN4VEV4UjEvNGc1eStqdkNOcktJ?=
 =?utf-8?B?Ly9CSVk3WjZFamJxRWpHNkZQcDRPSWdCSnJvaHBRcmpLTUdtUUJuQ0pObWgr?=
 =?utf-8?B?WkJHUzBrOTBkckNBQ1ZKc1NERkxsZEpBUC9KdXpOck5GZzNEVmIyZlZBRHc1?=
 =?utf-8?B?akNEbGMvaDFqVjlMM01QWGVzRnVwNXpIa3A0dDlvTG94YmdZT3VSd2hMdThC?=
 =?utf-8?B?YUdqOGxmRHpVTTYxdHlxOC8xNUZ6eElEUUM3ZDZGN0g4NitqMCtZR1JKSE0x?=
 =?utf-8?B?TmRnR1NodnJ2S2NOWGV3Rmh5dnB2TVpGR0gyd2FPaGdHZTFnR0JkYUlnMW5a?=
 =?utf-8?B?QWRtMW40TGQvZXVJSTQzQVRycTRvUjQ3d1dxa0NTeUk0TUhnMjRWS05sQjhw?=
 =?utf-8?B?MHVxMWZJZzhYdldmYlFKdjRjc2U4aUVDdDV1M2txenBTNDdqZzhqWjlTeFpn?=
 =?utf-8?B?OWZwYS9IUU0wZ2svQUEwN0s2YTJPN1YyMEl0M2c2cmFib3NRZXozZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d4cca4-0917-4e07-061b-08da1dd897a4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 05:35:32.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UElZ6jJKU+1M7tdf7Bt6pmnbPvHbr/KYqXw08DIJmc7eNfV7PSiJn053uXinSK43yddgoxIgkozkPDKzVwOu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2022 2:47 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/13/22 12:40, Ashish Mhetre wrote:
>> +static int tegra186_mc_map_regs(struct tegra_mc *mc)
>> +{
>> +     struct platform_device *pdev = to_platform_device(mc->dev);
>> +     int i;
>> +
>> +     mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
>> +     if (IS_ERR(mc->bcast_ch_regs)) {
>> +             if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
>> +                     dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
> 
> Set mc->bcast_ch_regs=NULL on error.

It's not really necessary. If mc->bcast_ch_regs == -EINVAL, then
interrupts won't occur at all. I have added explanation in patch 2.
