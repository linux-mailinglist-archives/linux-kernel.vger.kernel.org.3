Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657B4BE5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380180AbiBUQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:22:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243235AbiBUQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:22:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB351AF13;
        Mon, 21 Feb 2022 08:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5N4wks1Zdi1iAZwSbNACzr/rnEadM5N/iZbUY158ObZecnoUr4CDZs7WxEIWvKfuXSXkVnh2mb+NVtfJ0Za3o7hOCJ3BuU5q6Q+0e/PfpymJ2LWkJhSTvY+HVSuHzOTPDziEIRTUrUPUIhEknzRblI++1OA2BgsMhfzHpf/Wgwb2Iuby8fg6bF4PaaRkbdPkVWw5mCTr4ws9X7hN/2HU7+XNlY44hbJtW3di3HC5CxbVjyzttKLkQ+UcLLUbCs3iILajGb/aB5s97Z1Abh7A5z0AXwRRy20wgcyTOAG49+YSlYAtIzKUgu5e87+6MMhGpxO0Frimx2DSOQIPtjLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16jza2UL0H3ClJdzR9o7ty2Dz7+kJ2E/ocHl34acKgY=;
 b=aL2HEPCEVRyx1o03fUS2zWKeErG5JYx7hw/U/dkNx+iqxRkNUizgzxih7AQr+cOzWG5PL7eX20hRgB3soyxdy+KbIeE/rBdQJdpxKqe6Uh9dmfBfGkLGqMBCYR3qS/ddLpWC6GwFF1TSOnPZpa4cnruKvajM8j02vhC5cfcCCNIZWXusmoMWA6XQtRaks1o142C3DHsBurSFpL0UWyaz/ntfpx8fGZNMVWfAHVfm7fsJKQ5FTdE3IQn09mGe3AtV9p/UOGM5l/xc7c9wySbjuC5vogJgJsxvYVCg600TGzM/62oaP+Z/oOOvMp7ifkBQ7P4LodXu31FyJfGQqjk4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16jza2UL0H3ClJdzR9o7ty2Dz7+kJ2E/ocHl34acKgY=;
 b=H1xlhW7IRO9hpjq04XCqLcsjOgUhe5uVrolZcV3rbmeF6DbjnXAcAGIrBkugQPFItwQdHa6z5TZ2pIesxFZqmBABE6yFHwsfu5N1a7HTAXMT1dROI82nuSfZ0D9attBx2G/5LzwhejtkLgjY7PGnsBRCb1LGJm0X74J3S/53dMPWuEwStLFSKY5fYQd/48nlLCs5LmW7+BEGNKQz0m38Xdlw3+Iv5YkQQAI7N03GTerU2XpNGQ14uisHXEPG5UEKORJwkk1wh9RDyfK+Q9EuCLs+TrjU2md3C6T3twZguLqCVxDPXs1O713cS4eqoGrsYHHknlLFw5i1ON0FIjqEow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Mon, 21 Feb 2022 16:22:09 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 16:22:09 +0000
Message-ID: <6b5e4dfd-ca60-b934-527a-8ccc994047dc@nvidia.com>
Date:   Mon, 21 Feb 2022 16:22:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
 <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
 <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
In-Reply-To: <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::27) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcdd6e7b-bc8a-4ace-e021-08d9f5564f00
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2413A5987EAB7FCD1722DA82D93A9@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hkfJHNmgykzJtzxda/ueAXVbqC0fUShB6vtmBz930R1S8TOpBBOuk8etNRokjYdrz9DJtj9xKYMpPzLp7tB/P4jFtnFS9q5P3opYoyec0pZ2TGrud1Oyb846GNyqod4C9kDbtCss0DgdBwkXdgnl6Mshrp1YcZCKVoX2dibV7hGIp92gXuAl3/bHn8XAriqeeVXpHW/EBs9FIuV5toMSJbQ0fjkLLKvzHIFas4SCC+jDZZvLkUzP865eG4IvG12MGnKHjDAIbDbEfYIAmLTTADWhF+jkvDjlvYwP/s9CP2rKrv8Ywh+lK0nTL2b+N7XLLACb3Q6sNLayTSBfy+cqC1MDPCUei3ktmwCDb7kYixlh7vq35wIyuMoKU9DZi7sKy1XaQoV1oon7doBU6PUD+EKJrkXwrh22Vz3KTjiRCyQI9xktBVBnBjwVw2eDkSO8e53mfRsBZdEI5G0vtxcrJwT6XEDEH36NeWe2mxIwpgA2pMn7k4wT/oVwdjBA0o05Gl2xWX10EAN2Ud23i9MjMM4kepKCwX8WJHMsIxsB/teDkjqQ7aNwlFaEfGwIya5vDhTnHEwnZ1Yh4FLKFkdstZmI3haQRsLfcHf0GTPQL3LkUoRCkxqUcUcJV7uD+9bCaRB/JXMr7r7WBxugqQO5WK91nYQTi8kfsR70dTbADZ6792o1iWCdV1+wlOa1pZLi99QAgBIo5+2l2x3fArMKeanjcv5G26HTTo8yEBR7b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(110136005)(66946007)(4326008)(66556008)(316002)(8676002)(6486002)(508600001)(36756003)(38100700002)(31696002)(86362001)(31686004)(55236004)(186003)(8936002)(53546011)(6506007)(26005)(6666004)(2616005)(5660300002)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFxc1lJRzRseTR2ODFrK3Z4YUtYQkwvazQ3OTZrUzl5MmhMM2hZTWM4NXJG?=
 =?utf-8?B?V0pTZTRBUnlrSXNDOHliQkYzZ3ZJNWtnSitKRjNlejZMMVpud25yZnJIVGov?=
 =?utf-8?B?SjhkWHVmZnNWTVhsTzVHRDlQWkVZQ1ZGQUt4anFqZ0FMRnk1SUc3a1JRQkRW?=
 =?utf-8?B?Y2QzQ3hFemVTeVkwUVlBRmlGc0tqZm1pT3cyaE10VEhqczJCSFlKOTA2akFB?=
 =?utf-8?B?QWRLVXFPeWJFVzc5MkVYVmh0Vm5ZZmc2YzIyZ1pPcVE0VXZGb253by9vMlVQ?=
 =?utf-8?B?dVk1ZEt3WUc3RWN0b3QyaEFPVEYrQlVXbGxiSjFBNkJhR21uUDR6RFEzUk0x?=
 =?utf-8?B?YzhGOUJIWDgzRTdmbE9IeTFhWVJhWXpoOE90YmVBUmxmR0hjT0U4RHRwb2VC?=
 =?utf-8?B?dCt2U0pnOUpyWTVzYkFXdkFpM0FuUW02ZkJQY0xISzVzTXJJM0Uxd0dQaFFp?=
 =?utf-8?B?dGZibCtwZ3U0VXpZeG9odnMrOTJCQktVSVZvWnhvOHZxaUZVZDdvYzhSU1B6?=
 =?utf-8?B?OStDRis1aUhrS3l3TkNyZTBWajVlRFhham1HSHo0YVFZYnFWVnpidytjd0Jn?=
 =?utf-8?B?ZVlPekl5eWZyaTBsczBJWG1qQ1JxaFV3ZWFGZ3NNTjZJd092YisyS0hacDRa?=
 =?utf-8?B?MElxNE9FU3JMbENybzAzbng1UXRrS0czT2Z2V2xZRDRwOFpzc05Fbmt1VHZ5?=
 =?utf-8?B?UTlHY0srOHVZUlNyeFdBc2JMWFpzK3FUeVhjL0N1RkpJTU1HbXJIWk0vWjRO?=
 =?utf-8?B?VWpDZHVWRFRIdVJERWdOdjNJTXFac0VqK0VhMnlFL0FWTkdPTWdjdmhhSWVB?=
 =?utf-8?B?bmhIbFFZZ2V3TXd6eGtBeEFIV3NuUHFoUUdhbWVZSUlvZmxQODNoQ0hGRytW?=
 =?utf-8?B?Q0l1OHcyY25CS2YvVmwvUm01eUpJRUVjZEV5UU00VHViRy9pS05xbTkrSUYw?=
 =?utf-8?B?MEJtRkRiaU5taFZhTGc5NTEySHNOUWh1T0FLMExIb1k4RUViWC8zU1JubEpw?=
 =?utf-8?B?RFZ4VmprMkpxaUpkN1FQRmxYRFp3Zms5ZXkwSzd2dWNjaWdZVk5mR1M3NUxH?=
 =?utf-8?B?TThQRUtKSmVQd2ZZZFptZFY5Z3RJcUZSbFU5Y0VzQUVoMnZhbDNqVkZJc1F4?=
 =?utf-8?B?KzdiNXd5RVNSbFMybi9BelBxYVNGWThMMXVuSnlIQlFoL3c3ak8xdDg1QURQ?=
 =?utf-8?B?T2NXVXVtWU9vNkcxMmFWaGU0ejEyR1ByUHdjdjZSNks4d3dPTW1SMFJtTnFu?=
 =?utf-8?B?UnNWa1Uvb0hRdldTcHVnYkU5YmcwV3NHUE1lWmhQaTF0Q056NEhCSlFKekJQ?=
 =?utf-8?B?MDI5RlJyL0pKamEwSy9zcVo0cmtoeHdEd1VzNUxST0VZTE5nRkFSV0ltdS9C?=
 =?utf-8?B?T0x6RDM5cUo4WjNUZ1hjMVBXeThtZHdUMUZvOTRMNXZwUFUyZDZhOTBDTmwx?=
 =?utf-8?B?SVYreWRjZGNZdVJJbFF4OURQL3NrbjFrNEdScll2cDBJMmFyejBQZ044UStU?=
 =?utf-8?B?NTRkQXpGcmJCeTBBcG55UUtkcW5RcTl5Q1lnVXNDUUJwSmg3dkt1N1gwV0s4?=
 =?utf-8?B?aFJpSUZPVjh6bW5vdmliazVWYkg2NHZmS3N2cDFRWkFyaG9jU1FzVVVESWJG?=
 =?utf-8?B?eG1VODVnd2dFUG1iQlVaeFZ6OVlFOEM2MEFlWmp4dHRPK1FQNHZvSkxYUVhX?=
 =?utf-8?B?dkprMUVXU1hwaWNSUUR2WFlDUzdEZEJha3NleUswSm0yeWxmVnNMeklCc3pa?=
 =?utf-8?B?Q0dBQ2FSdWRheE45V2VwV2xlcmpHZ0gzTjhVSDF6aXNBUXdmN3lzTnYyZW82?=
 =?utf-8?B?b09PZkFKZG5LUnZXYnFWeGxxQ2RMYzc5K216amZLRVpKVnVwR3JiRCs2dEtj?=
 =?utf-8?B?UEpwbEVtSjNtTWE5V1g4ZWx1T2NLN1RqQlJseGtPUWZHaWRDblJTaEo4TTcv?=
 =?utf-8?B?dlNPTFlOL2JFVGFIK1dkUm9keU1DdERMbkloelBKdHo4U3NFQzlDelgzNzMr?=
 =?utf-8?B?UTlwOTJHMjhENjdYZUVYbUx0VnZDQ3VrRExiVDl3bzlLc2ZlMFBZdnQwVG9H?=
 =?utf-8?B?OHRVM3VpQ2hnb0xCbFNRbmpEZGMwOFBieDhHbitaeWpqOXpTY2pFUXZaa25r?=
 =?utf-8?B?VFRXUFVvUlNXZTZZWU02Qnp3VjNwd2FyVVlsdHRXOHlNbUtxeDhXdWpCMWdt?=
 =?utf-8?Q?VLu09vml5T2YDxjyKAvyhlg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdd6e7b-bc8a-4ace-e021-08d9f5564f00
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 16:22:09.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hznW09DTZO/L2ZrPiC82khTnVX6JV7wmObFbHPaltxulq5CoDdCqs9smr1HtxcN+XWKxuleiiYWcMB4CJjcDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/02/2022 16:16, Jon Hunter wrote:
> 
> On 21/02/2022 16:02, Guenter Roeck wrote:
> 
> ...
> 
>>> The platform I see this on does use device-tree and it does have a 
>>> node for the ti,tmp451 device which uses the lm90 device. This 
>>> platform uses the device-tree source 
>>> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451 
>>> node is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
>>>
>>
>> Interesting. It appears that the call to 
>> devm_thermal_zone_of_sensor_register()
>> in the hwmon core nevertheless returns -ENODEV which is not handled 
>> properly
>> in the hwmon core. I can see a number of reasons for this to happen:
>> - there is no devicetree node for the lm90 device
>> - there is no thermal-zones devicetree node
>> - there is no thermal zone entry in the thermal-zones node which matches
>>    the sensor
> 
> 
> So we definitely have the node for the lm90 device and a thermal-zones 
> node, but I do not see a thermal-sensor node. Maybe this is what we are 
> missing?

Actually, that is not true. We do have thermal-sensor nodes in 
arch/arm64/boot/dts/nvidia/tegra194.dtsi.

Jon

-- 
nvpublic
