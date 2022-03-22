Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547784E4536
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiCVRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiCVRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:35:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9B340D6;
        Tue, 22 Mar 2022 10:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jszx/pQW4cQnWKlBA5CwYz9OI8KeaEV9pDT+br5uTlHtgNAsAezCMjzSW5zLAKkMAfg5ecUdu7Ak5vlov55z9D/GvRndG9YcJ4H+YQjNx4g0iO54LNDRiay71qPxGpAfkwBL3PTPU2nM/OD501AMDhHPAyB7RoAC/1Sb45pvXZnCRLycTYp5AI91bWTNP1JaYeOXCe0vruLaGxjXN2Wq1bexl2ymzvHVXu/vJFr60EI3loZd/3sGP57NIHLx9K6YsF6H8NAIgd22ZpbfLjXUUab3tYKfrEs+mTW9pU8pLmdAh/CYecakz4zDiCot6oxpSY4p5SfWdQupSJhZ4UWM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjFxAmgZ9Quf+BszfoTDs6iVBP/23bwrzYzd0BE0PlA=;
 b=iXbpNseMtJ75QqT7amu0XR8HmFSSPOi9kf8nSZ9UVFwdJ2Oiu1lXsnn+tS/PjA0bJPoWdRof8qvCNfez/0nNyid86Eleoqt7B8hIux7fN44qTjcsF+7xBUmE8jnTFwEdx9Nq1Fsj9puUr1dkpMtP7Z1zqkQZ6m3RX4Vr+jZJTYi6rZGg+owmT01QX9jsmx8zNdGnCdCrwgQc3wWpqWYhZ6TFAaDQo2EYEIo1ueq9rnGI5xDYHBRqoEWz2ajP1QJZNi+HvjtYYWlAzuqWOL2zhlk/dYZfBToFjkOoLzCsM6Q2E93iK1Pf/9s2rTnM0FC3m30ByBXc1amoT1FZJJ8hTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjFxAmgZ9Quf+BszfoTDs6iVBP/23bwrzYzd0BE0PlA=;
 b=Yu91+G26zr0K14G20k7CH5SeMtsHFszWBB8i6KRsAXEV82vZOLZ4oDmtEKIdgK9wVeshzjFjYHN02ky93ZJiKB9nFCLaMntShrD9spo1bQDMA4yvagl+P1+po24zm8MGgdNqsIwYX3aeUmLa3pxf2LMmovGS7gzyEAxngM78rn1K0a5RKxxKbKTbaHhzG5ku4G6mqteyIzAWlbSGev0DQ8cV+9IOkB0dzA6r0oySB2YpQIzlB3b16TXYqLgd+tvI5oNiBaIKB5/X6NEl7baLGuC9yCYJMOD3/QCvB5v1Ab3dM+G/qi90TIDLualSbyOfdnJkCC75DL10p/l88WXWlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by DM6PR12MB3050.namprd12.prod.outlook.com (2603:10b6:5:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Tue, 22 Mar
 2022 17:34:13 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:34:13 +0000
Message-ID: <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
Date:   Tue, 22 Mar 2022 23:04:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::19) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9670f145-e064-4063-9b69-08da0c2a2e78
X-MS-TrafficTypeDiagnostic: DM6PR12MB3050:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30507091FEF4DA61C58A26EFCA179@DM6PR12MB3050.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxTkwUypWbMZII0wPanHZFkcQrCNRwfgQ91aCPThMh/XtldOuLb4esoV5Sm2loDtwfO7/+MORw97/apxQtbZOgpDxMaMLfSlTtlE6Hqvchs2CPDQXZ2tIblbCPHyotmHSAA7jkW9nNNNDu0qTwU/bQDRLXjuzgWGMF/ph86+JJ1FkMjbxVS4Sf+08LqWtU3mP7iS2BU9jYkOzIWRuu5kPEn1gxFfQCh+mQRigzRffM3PysDMudOXcIEAenG994TgiCHs/PfDQeQCUuV22VMpjNfIMVWvJzJs2uleryxGTn6QtUBJQcUPoS7bs+Orl7iATHwQOMqLZNwzCDyJQXaAIP6tX/YGqwKD8Hyzvs++QL5w8dppooekdC67uUEn+iSm5blXvqKsU3bKCLLMS6QLI1X7hL840SgavK92PNPPh8KqHitKwWjAykcCbwPkq1sLCtDu29bTCWkaEYfxmfvIH8mrHIrztL4xoq92I/5EPcYW3Ahuh+ToPuVrZxqG48MB2rGViSpWUmEbJRwaa3f2vgMQPb5KB5+cC6moLkfPUbJV+jEep8PqSnBTQmD2UDmI4BEY+hFgqfniOIgV+0Nj5TcYcWyLyVOHJzL0nyks+6oeW/ip4cu5Htv5chICmfzxZXiMfh20K1aTp0mESWYa+315cGi4UEuOfXpx5hrVkhzsziCPgZ7NDJ9zQ+5sj+LNrPO1dcdYcJKXdCX/z1UMl2sbGWSRMvgqoIzQt9CM9/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(86362001)(31696002)(107886003)(2906002)(66556008)(66476007)(4326008)(8676002)(316002)(6486002)(31686004)(66946007)(55236004)(6512007)(186003)(53546011)(26005)(6506007)(83380400001)(8936002)(508600001)(5660300002)(38100700002)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC80YTFzcHRyellxV01qK3dOa011M1BwNldmTEJ6WHgybHlqUEZwK3R2TzA4?=
 =?utf-8?B?OStYN3R3MkFTRHpUWmE1TVdxZE8wZURmVDV6djJ4V0Mvck56YXVuNVdDUndU?=
 =?utf-8?B?MTR4R3Y4RTBVd3U3SG81SC9XMUh5TnNZalZDdjZ5MWtRcnU4NHY0TU92WWpR?=
 =?utf-8?B?cnJaVEdERnRkczk4YlJCR290cjhiK1lLRHJTTittZ3JCWkh4TldJK3Q0UHlU?=
 =?utf-8?B?Z2JkUVJaTDhNcFl6U29WMW56UG1yTEJab1IyZjNsM2lGS1ZTY1ppWnZHSENZ?=
 =?utf-8?B?c1BFNzJDbnk3QTd5QWFwOFFUOE5nb0JFMVp2bGZuendKUndGaWlmRDBMemdr?=
 =?utf-8?B?Ly9sVmIzK0ZpSzlJM0NRY3ZONVdDbFE2SDY1RzFKdktlN2hRL090RTRSamtu?=
 =?utf-8?B?ZnJvU0MybFlRdUUwd0FNR1hXYzFmQzdPSjhCUUFKeDViSVFrcllINnRrbGgw?=
 =?utf-8?B?QlNJNXhMLzZoeVo5djkxWXBQZGhYZ1F4WHpTOVlFOEdZT3hvY0FWZ0dJcFVG?=
 =?utf-8?B?b0wrNlJsMlpuUkpMUzg0T0xpUU94dTVHMm9mRlRFSHFQVzlWVGhHYy9TUG5w?=
 =?utf-8?B?Y2xwVHJUMk1WZlE0cXlTYmk4Y0w1S29JNFY3T05uTVJlU0hTR2RJUm5NR1N4?=
 =?utf-8?B?SzJ5L1BodE10bHV4QVU2alpZUVNHRjZTcndIbTNCeTBRSWRnenZ5R3RvbEdK?=
 =?utf-8?B?UjQ0T0VVN01oZTNNdm8xQllVUGhJY2ppNWN1b09LWXg1S2NpWXZDNmNSbFpj?=
 =?utf-8?B?Mm5NSS91NVlzUlpndVZ5Ympic2VmRXUxcnhoeXlScGdQd25IelNrR1FhQzVR?=
 =?utf-8?B?TUVPQnlZR2RwMnp0cjROalE3ZEhKeHBiNGNQZENURjBWcFg4Qy9vcjIrUzl6?=
 =?utf-8?B?M0tlZ3UrTm9uK1lMTEVyM2lpSGhTYjVtaWk3cHpibWxxYWZvaHJOTzZHaVlv?=
 =?utf-8?B?NnFQdXhIRjdjdlp6Q3JDeTFCYkk5RmtzMUR6T3VNOHpNYmtTbXN1TzBwYjhE?=
 =?utf-8?B?aFk1VzhrY0tQYWVrR1QxMkF2WjZWcCtWaUdITWh1T1YyVGg1bjNyZXRTQnhl?=
 =?utf-8?B?a295alAxTC9LNGNKV0I5RVB2WHZBTEk5ZWRqRzJYcFQxdGx4UHppR0N3L2JT?=
 =?utf-8?B?b3ZscEJtT0VwcnBxT2FsTitKSVRKenlreWJ4cnZ4TERiVkI4ZXJPRVBvSWRG?=
 =?utf-8?B?UEdEcXJBaGdxdldPQno2QlExbFJWVEtjcEdZb2xtK2I2M1c0RTVWU0VJMU5s?=
 =?utf-8?B?WHR2RTdOWUR6WnNPOFdQZnE5RzJZTEhOVDhvd0VIc2xHb3p6akoyUTJENmlD?=
 =?utf-8?B?eGIwK2s2UGxSVXIwdk5Ba2hZTWdZRjREVCtoQ3RNcStHczFhdkVCN2xxcGdo?=
 =?utf-8?B?NWo3WVQ4VUYydGdCOUdCZU9ydmxweVNqNjFlMlMzS1luOEI5RjBJamgxS2J6?=
 =?utf-8?B?cFVBZTRTQS9Sb0R3ME1WOGdkVXJwd2F4aGJqSEVLOUo1ajNCcFlZM1c3WHd1?=
 =?utf-8?B?KzdwNUZ2Nk0zK0JvZy9pOG8rV3MreHNlMFljSDRwVk5NcWovOHFjSlpjVVVB?=
 =?utf-8?B?TXplbW1sNUthdWtkdW94eHBSd3Uva2NQeWdyN1R0eUhoY05Bb1ZMVnVPUkVa?=
 =?utf-8?B?RXQzS1lUeVhNN052cExFNnk0QmlweXBQUE52R1ord2ZvQnhuYnZ5SExOazdG?=
 =?utf-8?B?MTgzVnhxK2lWNWxFZ21RdEVRVDdrYk9MS3ZYQnNkY2lWNGRHTjk3TnpzSllQ?=
 =?utf-8?B?a2Q1MDdjUFdELzVHdWFCcktpdytTQnpwaVlSV3FWOTZyUTcrV01weWZRc2lt?=
 =?utf-8?B?UW1wWEVUdHIyYWpzb0VOR1licjEydU5MZE8yK2VFQllpcmFiNXVVT3BQNCtu?=
 =?utf-8?B?QkNwU2Evc1k4WUx4a2RXTE0reGxwa3ZqQTVTcEZYcXVOSkxQTFYzR0JEM2NG?=
 =?utf-8?Q?elTIyibOG1R4IzT7CdoCtXNv41gvZWIo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9670f145-e064-4063-9b69-08da0c2a2e78
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 17:34:13.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2koRLbNnyHwf8rPuE3dmtFgrHiFq1gdgIn3SYnoSJIQfAac6PK1KtD6TeQisTDg5E0mAeuc9xdjvno0CqTUIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3050
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2022 9:44 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 16.03.2022 12:25, Ashish Mhetre пишет:
>> +static int tegra186_mc_get_channel(const struct tegra_mc *mc, int *mc_channel)
>> +{
>> +     u32 status;
>> +
>> +     status = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, MC_GLOBAL_INTSTATUS);
> 
> This mc_ch_readl(MC_GLOBAL_INTSTATUS) is replicated by every
> tegraxxx_mc_get_channel(), it should be a part of common interrupt
> handler, IMO.
> 
> And then I'd rename that callback to global_intstatus_to_channel().
> 
Okay, I'll do that in next version.

>> +     switch (status & mc->soc->int_channel_mask) {
>> +     case BIT(0):
>> +             *mc_channel = 0;
>> +             break;
>> +
>> +     case BIT(1):
>> +             *mc_channel = 1;
>> +             break;
>> +
>> +     case BIT(2):
>> +             *mc_channel = 2;
>> +             break;
>> +
>> +     case BIT(3):
>> +             *mc_channel = 3;
>> +             break;
>> +
>> +     case BIT(24):
>> +             *mc_channel = MC_BROADCAST_CHANNEL;
>> +             break;
>> +
>> +     default:
>> +             pr_err("Unknown interrupt source\n");
> 
> dev_err_ratelimited("unknown interrupt channel 0x%08x\n", status) and
> should be moved to the common interrupt handler.
> 
So return just error from default case and handle error in common
interrupt handler with this print, right? I'll update this in next
version.

