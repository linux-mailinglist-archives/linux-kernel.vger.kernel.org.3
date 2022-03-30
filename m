Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96A4EBE80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbiC3KTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiC3KTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:19:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630C19F44C;
        Wed, 30 Mar 2022 03:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhkAO6TI8SWcZtMC32bTXuEv0QPO5O1o9hcZX3XMS+s2kz6Hf+a387mDbmsYO6biRywsa+7i3cSy+JT6FfCGEnzZNl73ObsSIXvlAicvSXxA9sS3ephQy35TW1/JDoeBdc+s5v5oMw9myH2Pts1xVflcHeRIPS50Mw9IlA06ny7e9dNKS3B1+Ph7C1gJWsBdlfj4kp+uIZQ6EgC3BPv+ybEhgLXANu1LI5x3/Tdv/HIwebJM5nqLdJgGzvT7Sr8ftUbRBcxfdVdtCkbEzzfRTYSoD8APMJSKR+j/toYtAsHgF5kMMbebrPrT+1EPYm8JuaC9yJ2JPAJ5Afc5nt4v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrGF/N7mnkiFGScelZ6IEi3LuaTgyhGinn/OKQ4C3uo=;
 b=MBG97WuhkVl3uY24AnIApjG4yA8J1Cn3AMj+3lT9Ip86ani6o12YftD0ONMe2PHxhye949zCMw5/Vd+0MOiA+8x17wb9iWnxffaux6Md8xnWbH2pQrwIwOljPxLh4aojOL//wVcOhsk/mX/1jc562wexfBJxdYdXOYtc81sMbUzoe/W8zVh/4hs/inbaqvIS5Tdm8jDQUHdhkUflbJCZP7XfEjDk8gGO4Nabl66++F/0bu6IUR9Rh5quxTLqHEON45NqAQNiEhrD1Gips0Jv4m6GaXrPefWYwVOa/CnEJcujuOTAds4eV5hrK/CjCG9FsoM3oG2IE2ioN+1S5CdBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrGF/N7mnkiFGScelZ6IEi3LuaTgyhGinn/OKQ4C3uo=;
 b=uVhWgB8ikT+2QTNTsw1zKvM1OjVjJqsWhDQIYmXMO+1OUV+5MViBpXi3eMbc+XI/AiDtQHTA+XpjVJBmOAZjtLqfG+VNVOLsCf/kOhfYbAZAoCeIBPLcuaU5jDHBdxLPF4iBFIBx0TQHc95Jn3w2osCjBCS9GDAQwKGdM3LexcuYgdsuLl9R1uk4dLg5uYC98LXEal8PYcbwugtFq5e40WtQ1gomQwgm32rw1y+Ttn7bCipS7wmaSf/aumpYT4HAtHxCPbFaoOLcy1a705rMvNshMMvYpRT0uZD8Ok+Avlwa0P+wgwGLPxILyXMXSOrHsPZAaccYtnkYF66wBqzfBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 10:17:14 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 10:17:14 +0000
Message-ID: <44235c65-160c-04c7-294d-16b13d25605c@nvidia.com>
Date:   Wed, 30 Mar 2022 15:46:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
 <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
 <4ea801f4-7929-148d-4e69-d4126a9dfbf7@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <4ea801f4-7929-148d-4e69-d4126a9dfbf7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::32) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3356f342-0657-464f-7470-08da12367552
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31269DDA316AD955F29DAE67CA1F9@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV3c6swsgvvEgO0FJ7dhcOUdxBkc3CGGP+JPCuNIADyYSYGEYgaSLSsqQgPJ+I5AW1KoBIzwJgrSjwcgvTurDarMmOfRiova7Kvq75uc8qCbT6Wk5DnFIJcuy09s0s+UCS41r8rsHIzV+zy0WOA+PELZ8+68cO6j2ujZ2pyHm5f4ZS5Jt9MjuVdNm5RoT0yF1ICioF+U7ocCCNYAuzOP1zhOe1JFCcRBapd74p9LxwOgiSjKw2H5XSsoo9NGn9MOhku2jN3dj73wa8ObJQP0ngxnLFp7N2DHOPmfabU5FHeOLWQNcTqqV9LrbY3HdoVJ29XLX4zBBipl/94ghA5ADvI0YH7qTqDSLdG1psdwBDpkMG3PozlmEmSxzGLRYkTCAhbwpFZ6Jg6McBJGw09k+a5GtKxT+x9UHCGgmA+p8ETgYmwD57KTMHoxJyGgh0szfAgslq1CpLvyrT2uOCdbA4ELpu5QQYh/hvzSrQjX86c2lHttBeJ6/ZLRHcCoJE2prS1xRYMWnhdQ+9xmbNHQfc50Gu5MKdDk/MgdQs7pWkQ4USblpDbH62Z78hrRkKsW7GXepDYR2YDRtiM3u9Av7rZTwxxVC7zDYWXRjesov+aTHHuiiDhe+XR0HqdQhLARXY+jzPAXA0+/77iYUAF63Lfpyzc4B7o6dnqSYhM0omc3v82rq4d1HbQBc2ZLWAlWjgIHjmcDTsJCrn/20APx4FnZ/VqlFrKa8S1cWX/30Zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66946007)(6512007)(2906002)(66476007)(8936002)(66556008)(55236004)(83380400001)(5660300002)(4326008)(86362001)(31696002)(110136005)(53546011)(6506007)(6666004)(2616005)(6486002)(31686004)(316002)(508600001)(36756003)(107886003)(8676002)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVQyYUd0RmwyVG15dEVPTU9DQWwyRk5JZWVaSFhDYkUzYUVyS1pLMEhEMm92?=
 =?utf-8?B?TDdqYXVRSU5hdm1DalZKay9VOVFMZjI0SlJhOFNMM1Aza2xhR2NZRi9nQ0t0?=
 =?utf-8?B?N3BoNWJlVnVqd29FMkNHZEwyTjFESU1OQi9qczA5SDdBSEE4QSsyYWQxeGlD?=
 =?utf-8?B?Z3VtWStYWG15VEkyZXhjdHRMUkNicVExZVE3NVEyK2pGZlgxNWQ4WHZ2eWQ2?=
 =?utf-8?B?RlpUUy9pVHFxQkl1MEVOL1JxY3IxZy9CZTUzcjJrck82VmpTRk5DMkZnRDZ3?=
 =?utf-8?B?MlhNZFNEL1YyRGI4c3YwdFFWS05SV1JkZFVUc3JzRklRM1ZkSEtQV2tpa09F?=
 =?utf-8?B?R3lQQStZMmlKY2hSMjBSLytaZUxHVENjbjB3b29udHIwbG5GR3p4MWFXenI3?=
 =?utf-8?B?K3NrVXAwV3ZSTVVCRldHdW5HVTYvdTR6eFNtMjUzRG9hNjU2aFdxZ3dRTldH?=
 =?utf-8?B?U1JKVGFYd1hTQWpCbWxIWjRpemMyMFNOb1pFVGJHeVErVCtDQ0xYcHRzdGFD?=
 =?utf-8?B?ais3RVJKK3dXeWJPVXh2RGJHSTZjbjVLblRSOGVOdzRpcERKVllpQUNuc2xw?=
 =?utf-8?B?a2tPUHo2ZVpvakhzcVJ2Q0J1Y3BCN1pTKzNTMFcwaUFqR3FiV3l3cXZhWGQy?=
 =?utf-8?B?N250Z25JVVp4bVYrK2ZJdWpXTjRBaGx4L3NTNXNNVEJMRFJ2dUp4VlJzSWF2?=
 =?utf-8?B?YzJ3TWZXVnVMdW1CRWYrRkMrZVQwNnBGOWpIK2VHWVZyR21ZZTQvaGdvS0tV?=
 =?utf-8?B?MG4rUWNDajZMaWREODdpYXJLM0twb3BHWk9nMG4xRitnckpKc1VHZFh6K3lx?=
 =?utf-8?B?OVdFbzROVVVOc2FGZGtOY0JGYVVyQjJLbE9jNEkrNkUxN1U3QkdjSm5pVjRp?=
 =?utf-8?B?VUtRMG04dklaWmFyUU1yUU03UmxZZzlYTEFhQm5rSXZha3Z2MXkxdU5WN1FX?=
 =?utf-8?B?QnhPWG1YRHRYR0tSUUl4bDFWWUJaNkxiRHJKVis3MjdBbzZYSUlMNkRlZzVR?=
 =?utf-8?B?TUw5eDdldzVzaDNWbkU0SE15MnA4K3dOTUc4dVl5d2RQOGxXS1JMdDJpc1hz?=
 =?utf-8?B?VTZadFZJeGdvWHVHdE50TWR2bjB4Zkppbm5KcE1zMHF2Tm9Lb3FnQnZra0NP?=
 =?utf-8?B?UjN5S0toNWh6WUZiZFlHdklFczAzb3N0Yk4ycG5ZUXdTTGhMd0ZQOXdTeE1i?=
 =?utf-8?B?a001SzI5NCtJMThodUR3TmwwMy9yaFpuQ3U3bGtVSWFBMzI3cnZOWlBTTldE?=
 =?utf-8?B?SU16RlpoZnV6M0pBQ2NzdmZTSldtWGplSWljZlFxdzMwNWtJeXBvamI5VWla?=
 =?utf-8?B?QXY2Uy9xcVRHWXJaV1QrMGNlTnFGeUQ0OVR1Vml4Wk1VcWpPRlNIaWFEVysv?=
 =?utf-8?B?YWdwWTM2dVpzdUR3d3F0VG9LZXRrdTVnMXNXekFxTWJUVEpDUVZOcVhZTUx5?=
 =?utf-8?B?QjBkQTRRckNXbFJ2Vmx3b3FRcnRDQlZMOStoN2FxYlcwbVBkSjFpb1BSNlo5?=
 =?utf-8?B?cmpTbEtKcjBxV0xOZG1ZbnJ1Wndod216K3ZaMzVzaFpzTFZsRncrdW1scmJX?=
 =?utf-8?B?VkNkRUhrdmN6RkFzbCs0SjBhMnMrRjQ1TzAxZnR5SFhkbThnTVNFL0xweW4y?=
 =?utf-8?B?bjh6LzFIUGp6eXJsbjViSUkzVy9nQ3JIYjhybHhxNVllZEhsSFZydFFUbC9t?=
 =?utf-8?B?VU8wdmNVTFFoc3ZvVFgzR0JtSFRxMFVaYms4dDdnTnplZjlVamJNVHdNVmp4?=
 =?utf-8?B?QVpKWnYzMmp0Q2N3eENRQVRVam5DQVE4Z0VlL3pQNXBYUmZIYzN5R3pLT1dI?=
 =?utf-8?B?NDBxRndyL2VGQUFBc2lpNVdvMXl6anYzb2xBZE5xam1UUkxKaStVYlRyNVNX?=
 =?utf-8?B?RFJZYW04Y0tWSjZXb1lBVDlKTlJBQlRHMWJadWR1N0U2K0wzcFlQQTFUTXZK?=
 =?utf-8?B?UzZyMWxlQ2pHak5KakR2THBqamdlZFJkcis1ejVsZlRhV3lKbnZzYnJON0RZ?=
 =?utf-8?B?RDNPeGgxNmJQVzNyV25Mdm1NWnFHL2JvQXlaSDZUS2lCNmxZZFRRU2xIQzFE?=
 =?utf-8?B?bW5QNnVqWDhsOEpYZTBlSkFmYS9TbkRUcldpUDF5NkhXWEZzMkFybTNpREVp?=
 =?utf-8?B?T3FOUERSTkJWYzJKbHRuSTZIQXJTQTBxcEZ6QWsvTmlnaDNEemFYejdqWVpO?=
 =?utf-8?B?Y2czdndwaWxobDBLTi80ZlBLMzU4alVkM2ZMaThYSGtFR2gya2lYWm52NWhL?=
 =?utf-8?B?Q0ZqVjlTUXZTRlpMUkU3bFl4OEFYWkxCNnNiRlluYkJwSzcvZEFuTTE5bGVM?=
 =?utf-8?B?SlNKemdLcUhyMGNVcUpRbnNrbjNJT3JLR1gyUkdFdW9tQ0EzRGQwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3356f342-0657-464f-7470-08da12367552
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 10:17:13.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lnFj/zIukqlFwAMo9DYK+xWiIEYzHgTeKAZp7WgHkqzUTYUmu+hxOF1K+QV95gQ/grCLT0y3Hs1rI5HKZKFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
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



On 3/30/2022 5:31 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/22/22 20:34, Ashish Mhetre wrote:
>>>> +     switch (status & mc->soc->int_channel_mask) {
>>>> +     case BIT(0):
>>>> +             *mc_channel = 0;
>>>> +             break;
>>>> +
>>>> +     case BIT(1):
>>>> +             *mc_channel = 1;
>>>> +             break;
>>>> +
>>>> +     case BIT(2):
>>>> +             *mc_channel = 2;
>>>> +             break;
>>>> +
>>>> +     case BIT(3):
>>>> +             *mc_channel = 3;
>>>> +             break;
>>>> +
>>>> +     case BIT(24):
>>>> +             *mc_channel = MC_BROADCAST_CHANNEL;
>>>> +             break;
>>>> +
>>>> +     default:
>>>> +             pr_err("Unknown interrupt source\n");
>>>
>>> dev_err_ratelimited("unknown interrupt channel 0x%08x\n", status) and
>>> should be moved to the common interrupt handler.
>>>
>> So return just error from default case and handle error in common
>> interrupt handler with this print, right? I'll update this in next
>> version.
> 
> Yes, just move out the common print.
> 
> Although, you could parameterize the shift per SoC and then have a
> common helper that does "status >> intmask_chan_shift", couldn't you?

Do you mean shift to get the channel, like
"channel = status >> intmask_chan_shift"?
So to get rid of this callback completely and adding a variable in
tegra_mc_soc for intmask_chan_shift, right? Or compute shift in this
callback and use it in common handler?
If we are to remove this callback then how to handle unknown interrupt
channel error?
Also we want to handle interrupts on one channel at a time and then
clear it from status register. There can be interrupts on multiple
channel. So multiple bits from status will be set. Hence it will be
hard to parameterize shift such that it gives appropriate channel.
So I think current approach is fine. Please correct me if I am wrong
somewhere.
