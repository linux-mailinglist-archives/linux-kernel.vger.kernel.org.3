Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50D5606E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiF2RDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiF2RDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:03:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23717A9B;
        Wed, 29 Jun 2022 10:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fht4WHe4+QqcHRvK+GgzwwvggCOOWXF0VG/XvioDLDudSQMkYdtsCHOg6eaw1BLpOWAB8xfB2t/mq7IZoWOBCrDP8TnDRTu8fEn5605fcz1KvmHA0927xTi64LsVZIa5U8xnZT6+oMwXaaeQKqA24QhAZZ4ZG6IT9fWM9zMiDBjPfg1+w90RYwBDSrO7cc880EeX2ny0a/9vES4434aVi1ynm9GwNHtImxFdeUQ9ex/l1R0LHY51dchDXtgEKHDwI7vZp4YntYjl+rsBnqZdbMdM4XIJMouSrAhefcy0OyisLfp8mrfexqWyySFrtIXq0rvhtONa87spovHpwjddug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F55DjJkS5S+BjW2C0WuaO5fxeJCMfWr4ggqvQ/tm/To=;
 b=ETczobMu5OKd1xRAP1HV/wAytM3RmdMgtLBjGhpEIsh7hm7h//4MXwfQprPF8U3AaB/UhDgLu7XR8jDQAU1OSNOIeHLnAa8JX7EzBdp2dldN/kKOkg53bkNFTknq+msINU1nFUU7oyEXETjWbLa7518mIeqUvGAOkAnoyEqYn+jJdLmrPoLpXiimRraHBiHmbVsL2wwfkeVf36YzWmxS2UPNC00a+lrkqu3gExHGyWeVcP6omgaKakw08tpYgfM6IusATSNh0JpjKRStyl4sEePJPy69jKLF/iS5hYBLeFCrCBy/Ky7nL2WfAzNPOVhelBtfDUF0jobNrFprcmpK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F55DjJkS5S+BjW2C0WuaO5fxeJCMfWr4ggqvQ/tm/To=;
 b=ZYOoJpq1RlmnT87iVLSya0cWg/Dd1NeZ4OLIeG7s0XL5O+Ivir167w52dUTyh3n0FyKh/F2g5Ua8RRCTy3YxYKMjYYCHpjAiH7rwnLhHRyoS4YzmwUnbU90ofR7fUN93s+5ek61zwd4KEy8h5b/uv9x9a/pFVbk5NqeW6M6rh8WuHLL64A9Npi2KNK74iMSY9GjiZmk4UA05bah3VQ7o2zZBU2BL+oKUZFWdk3olwaDXMlma5LkFQOAdl2krqepHae/KsYe5xiF1X9TFBjO7AWfkxuaBGYMqfBXgerNZD6Oi5OTVt/cRt6dc/NGyV3Km/leZ1xHXZRoKjgA3vRLpVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 17:03:09 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 17:03:09 +0000
Message-ID: <f2acd51e-24f6-aa84-cfd4-372dd5e30aa0@nvidia.com>
Date:   Wed, 29 Jun 2022 18:03:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
 <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
 <ecc72279-0892-d5ab-689d-87b8fba5147e@gmail.com>
 <20220627072104.ir7kujhezxhzl6a7@vireshk-i7>
 <20220628070943.5tfyad63rh6niq6x@vireshk-i7>
 <a0155aeb-b209-07e1-747a-594a755f54fc@collabora.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <a0155aeb-b209-07e1-747a-594a755f54fc@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::29) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8881c501-e81a-4485-1592-08da59f13e61
X-MS-TrafficTypeDiagnostic: IA1PR12MB6284:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur8XjW8S4WLEh7Dg4SVU9GoArPT3xlDfUZkkswMCdGDPRYPzfebHuwn426jKDTUBVAOlb2jTr/1Tb9e3BWEQy8WCDi97zJIUuFuiPHl+XUV/7+rCZW8JYnj+I7I8VMYyVl9k8Qm75m4jKCbJ6Pp5cYR/xDWvsu4UAKAE0p+IVbtUPj6KlxZXz/NTYGw0ceLzCt1kT4f2BVae0Euy91jU6bdDXE+zZ3SG+aJae5hhFNqxOk1GzE1KyCW08gSvpfLUYicnkWa9kwEfzZW3LfjFa6kqWuPSy2PlsMGRshVEtdnLQDMxmBtSIn916Ypwc/q+HMdjbwQgceqCannnDZsdSs4AyM9Q/oxN6Oy9d61cLufcL6wj3fGhXD6RN0EujIxsLjdciRI1iktJxZsUAyuqavsgU1+if7hTfbs6e45NWjfnswP++7GLOCeEnfLAqPklYMdAEG1/ngKmram11v5NUUraepC794gTlsToQFI0U4/nUPwZjbZRj841xuDV9VIZxUAFTiQE+j3KSpcBE/SgQbp+3USAlTcJP3q5pxM7w/hpL7qIjWW7fwOiVwiI8S1h8WBX6i9yULKJa+Imq1TZhZL9wMxGSjvoOhOpMEdLNvk2QF2j79edF6WxMcEDQAPJ2/DG0EcXrwvDzovS6EiMeESuv5PDEyoGfL+z4Y60TVswfzCiU2XGi2nsOiYKNBzvJnd8X7Jxbm3DeotvW/WWa2pneFoEtmgswnhxKlOmza5RIKCZulI3WCrEskE+VNl2AyVvac0YOuW+Rsaxu04+zuQ/2gsnAULrkCrJlL6CVWIadn33ApcG1loi8fZoIU5pu6+o1c457rK/iWice7Cl1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(38100700002)(41300700001)(316002)(5660300002)(31696002)(66556008)(66946007)(186003)(31686004)(2616005)(54906003)(110136005)(66476007)(26005)(36756003)(6506007)(2906002)(6486002)(4326008)(8676002)(6512007)(55236004)(83380400001)(6666004)(7416002)(478600001)(8936002)(53546011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdZRVFKVUhEUUM3VHVteFFJazRxaUlKczV2MllSSHYvY2JKUEYvT1ZHRWZv?=
 =?utf-8?B?OHRvWFVVZmkxdVR3QjdzUHpZWEdOeXRKejVDZmJVY2ZIc0pEMnZkRW84MW5B?=
 =?utf-8?B?OUxkK2FUZVYvZkwyYldXNmE0OVNpWnptTlZZVWZ4enNnWEJ1UXg3OHNudnU2?=
 =?utf-8?B?NHNPM0FSV0MxbjNVQVpMUk9ZTGRJejVYUG9wdFoxZW80d3hLWU5BVkF4VStz?=
 =?utf-8?B?ZXJVb0xKQjc2akJ0cjgxSU1TM0RHa0JTTFIrMXNzUnZEcGp1NjUrRkxlM3Jo?=
 =?utf-8?B?czdwSHBGckpGck9jdVFodkptKzBIS2VoOTB4TGZaTDNBUzM1QXExc2hwMGpX?=
 =?utf-8?B?bGVmNnVZZTlkVUhwRWZzTlk3N2taZXVXdmxqTE5nQlIrTTNleXZuQ3VOV2V6?=
 =?utf-8?B?eXRFK2pkalg5ajh3NENuVXVKTkI0dDlQMFJIS1ZPcnZhMG1yUUlzUnVNdkNz?=
 =?utf-8?B?b09CNUN5UE9FNTFWMmt5aU9uSGVjQys1TVArSlY2S2xPUm1RQm5pUy9oRFJB?=
 =?utf-8?B?RmIzbEpTV2ZoYUtBdEY2VVVqM3daWTFnZGtFNzE1ZzI0Q2hBcUdZMDFYbGxU?=
 =?utf-8?B?SjBrR2t3clE1U0tzS0RXampnQ3FiUTRnUEVuTHlxM3pqeDdHT3VNd2IzTXNw?=
 =?utf-8?B?eWNwUGlrRDFZelZ1U2NjeCtnTHhxSllONTN6RGpFZFZmdmIrTDdZeE4wMnJt?=
 =?utf-8?B?YTAzNVdYS3ZTRy9mK0dwR0dCYjhvaHJKUHNWbEU4MVRLbmc3NDBlYkoyMTdn?=
 =?utf-8?B?VFBpNzh3d1J0YVBDN1FUQnJLVm5oM21YWVM2dkg0SHRXM3RSSWZuWEdYNkMv?=
 =?utf-8?B?VmxGa2dWZlJhUHhnU2p6bWpEUGs3aTZJRmFpMGVpMTBndXd5ZjZRZEVqdDNQ?=
 =?utf-8?B?QjU4Q1RuVlpBUDhCZk9GVmN5ZGszMTY2cDBPVWxRa085eUZ2VUk4Q29WeHNP?=
 =?utf-8?B?ck8zRDk5R0syb0oxcUZUbFVjUHpBVHc2YTZMc3NvUXM3aWs4SVFmSVVLUG1h?=
 =?utf-8?B?MVloTnBCSHpVdERJMU5yNFc3NTR0dVRabHU0UGwrSGFkRFp3aVlKTTdBYnpY?=
 =?utf-8?B?Qzg1Q2F6QXlPTS9GdEgxdm1ZbzZHQVJsNlZ1STZ5M3hGeWxnM3Y3eUI4WlZa?=
 =?utf-8?B?R2VjTUtzUmhERitNTWJoUnFNNDVDRUsvOEcxa1V5Y2FOdGs4T0lFbnl3aEli?=
 =?utf-8?B?d0FtQSt6K1AvYXdaQk45MW9lL0dKVkVVVElSQkJkb0VkbENSYkhYckxsK0Fm?=
 =?utf-8?B?RWl1M2FYTlNZR0E5UE1sRExYUzhGWEZuQXpMUE41Ly90eUZEd1Q2S3NvYjBw?=
 =?utf-8?B?MXY5YjUzTVBWOTc0Z1paU2FUTitQTjRhS1dGbHBqaVNucncrTGp5VHE0SUx0?=
 =?utf-8?B?UXZtcXJKNmRRdEt4c0x1VWJkcStTT2JkUXo2L2pvemtKWXhWTHZLeVNGcUp6?=
 =?utf-8?B?M3dVS2FvMUljSlpCRkxJODcvSTZCNVpUNW9SMG1JUUhvaVZpNGlBTUUxTkR4?=
 =?utf-8?B?VDFFQ2NmajZvOVhVRmZGRGt6Y3p4b0g0dnY0bmhON2oxMnNWY25WdUhZMHZS?=
 =?utf-8?B?THQxeHZUMnBkcUtYVFFlZzNiYkZkR3JUNUlZNENpYXprUFQ1OEZqN3JIaDNG?=
 =?utf-8?B?UjlZU08wMGlWQ1dWSWtUZk9veXdGbndvUjI0Tzh0SEVMWFNDUjM0TTcrdEdy?=
 =?utf-8?B?Wld5TGI1aE12a0RsUEd5Z0tXa0drUmdHcWsrMDhvblpxemc4ajBEYVp6OUQw?=
 =?utf-8?B?SFB4K0NEakEzK2x3WEpueHloUHFVemlFY24zNEJSS2N4dG5Gejk4cjZsdEdk?=
 =?utf-8?B?clRJV3J6cUZLbEpGOXY4QUljeVNBcTlTczdCVjNVU2ZGOC96NStBSjlBT1NI?=
 =?utf-8?B?c1FCT0p0bk9FdkY1Q1hyUnhVM1R6SkNDNDVjV1VYbWhpVzZqd1Y5VVhKUUM4?=
 =?utf-8?B?REM0N3lKUUcyVlJXdFY4NTE2VlpQclFaU1NaWHQvOGlyY0Ziam9zKzhpM2l1?=
 =?utf-8?B?aUFzekY5QXhaNmQzcWpVU3dBcFpFcDZoOUVQSmZCdjJJcmxMZllmRnRvUVBo?=
 =?utf-8?B?Q2ZYSUx5V2pWZXhvUktPVktRSXd5WlB1Zk1UcWFUaVZxMldHWEtGcWJoa1pn?=
 =?utf-8?B?bjVWTlVrUUZ3L3lXNmMydGw0czRoMldVMGpFZTRZOWFxQ3BlTVNGY3E4TzZS?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8881c501-e81a-4485-1592-08da59f13e61
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 17:03:09.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igvy9VL0hC36NiS927zpTUwxi6MSenTFo9NxMYu480+Me5cyOzs6WCC4GnRKw7VkhmZur+ASCeLq1FSIHWfB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/06/2022 11:08, Dmitry Osipenko wrote:
> On 6/28/22 10:09, Viresh Kumar wrote:
>> On 27-06-22, 12:51, Viresh Kumar wrote:
>>> On 27-06-22, 10:14, Dmitry Osipenko wrote:
>>>> 27.06.2022 09:45, Viresh Kumar пишет:
>>>>>> Looks okay. If you'll solve the cpufreq problem where OPP config is set
>>>>>> by two drivers for the same cpu device
>>>>> This is supported, there is some early freeing of resources on the
>>>>> removal path though, the reasoning for which I already gave in another
>>>>> email. Though, I am open to sorting that out as well, but nothing
>>>>> breaks the code for now AFAICT.
>>>>>
>>>>
>>>> In case of Tegra, we use tegra-cpufreq driver that sets supported_hw and
>>>> registers cpufreq-dt. If cpufreq-dt driver defers the probe, then the
>>>> supported_hw will be lost on the re-probe. I haven't checked yet, but I
>>>> suppose that cpufreq-dt driver defers on Tegra30 because of the CPU
>>>> regulator and that's why we get the "OPP table is missing" error.
>>>
>>> Aha, I get it now. I see, this is a real problem. Will fix it. Give me
>>> some time to think. Thanks.
>>
>> Okay, I fixed this in opp/linux-next, can you or Jon please give it a
>> go on tegra30 to see if the issue is fixed ?
>>
>> FWIW, I have fixed this with the IDR API and the OPP core will only
>> free the resources in clear-config, that the corresponding set-config
>> has configured. I have tested it with the clk API only though.
>>
>> Once you confirm, I will resend all the patches and hope no issues are
>> left here.
>>
>> Thanks for helping out guys. Really appreciate it.
>>
> 
> The opp/linux-next works fine, thank you.
> 
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>


Today's -next is also working fine for me too!

Thanks
Jon

-- 
nvpublic
