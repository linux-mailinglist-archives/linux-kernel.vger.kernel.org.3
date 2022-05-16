Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3695285C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiEPNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiEPNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A30439147;
        Mon, 16 May 2022 06:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeLXfw9kJCvgOQ2OKQq3E/nuLDZx2i0nXVKyJAsTn6fgrNz311HIxM2ODzVInd8mwvGLo4xjhlAB7fmDBzTf3pFec6Wq133V+KyjpO7RSZbjWFdlfD6ZvH3ROYSmf3MEpJJ+Q0I02yqQDpjURRipSFTHC5+GcdHJYLQi4bUoWj6oeHgoTukUySzGZ57es6q3TgSKQnWhw0bzAvpyW7V7Mx+wvqcamzEVU2mk+tPFXFWxA2jWIAsrIzz2Rki4K2V8Pm9W3rYFJ2xFJKGRQEE+G+UvJDXlPK1ZvKVtmAIbtawbImX80n5GWzlRYaREUXmKl1YPh0MPr8EvAi265lfGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P692o4zGrRNIWcGNgggwVih2ktoX9VC5vRS1ih3j2o=;
 b=TGrKq/GBcm+ff1bhofFdC2RBxTcUw1eVbcRGXorxnVZ/yeZGFn5wTyAMNNN3NQSEQWrwXR0ggyVD7VUhCy3fO073njlDiA22CJvd8NfciN+v7J4cg6BPrKZggG9UAAeNg3er7QcscQiq252lw3hWyHc2n+W8FwXU1X5TlRojXjZ2JELX4qQe/TM378GCDbS4lXPYxI+QmFbLFEPFGqRnOUT211k4yZ3RHCW7US4hoFTCVnHNI6PvuU6P8C6y//VJp31FcTq3lAHH2FEbEVkbxaVPc9vtetIeeWGsxJ09lFdiBX0Hy81ezjLHYpJMlxABncfd4YgmI8mBmduNa/fOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P692o4zGrRNIWcGNgggwVih2ktoX9VC5vRS1ih3j2o=;
 b=yAK90SHtbtwa5sqv5Bj0ijyVqp560h8FWNvkCMHzmUOWNpYUpgd+ctjx+m3FHnUlfRmWMUlMGdphPyGBIG4QauDUqmTC+y6BZe4U26JIhBlqPv6JOaX6FpW0xUMnVFWm69LxkVrMlz+cJiQ04nh84qPGqZbzzbc21j9YrtXwgBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 13:47:56 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770%6]) with mapi id 15.20.5250.013; Mon, 16 May 2022
 13:47:56 +0000
Message-ID: <712c1aa2-c44d-5b32-b5fd-f6b2316b965a@amd.com>
Date:   Mon, 16 May 2022 19:17:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 7/8] perf script ibs: Support new IBS bits in raw trace
 dump
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-8-ravi.bangoria@amd.com> <YoJRnfASHY+uq1f/@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YoJRnfASHY+uq1f/@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d29c9b69-9368-4e08-5ee5-08da3742ae77
X-MS-TrafficTypeDiagnostic: PH7PR12MB5709:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5709E6E3D07035199F5DE24CE0CF9@PH7PR12MB5709.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmmLUC/3mf5yFCjHK/sq7v7Pk125PER+SrYHHVht47M42QWrAD/CeFoMAPrEbaOmhF0x+MVbOhyqJryyFnsU6jY2RsOcOepNBfkkoyw+R2Ere7+mxTZO0Sv+/TIpuqeRoiKl98oz8ewtUWkGmINBYqumRt2lNkTuSNr9MEv0VkKj/rd80O3wV7seIgCP03myvwQIFfIDXUcam3VjT9NpSE7fegnw/PxfEgQrCJDtgNU04mNaW2sNXnKozKF8Sjue9bOvtLT5VbwzzA6lrxn9Ml389QW4NM9hoOOKp8Nq0etjv/7xFA2rQSgQJir2W0/gTaV8xCSsnZzf87qv3fymcDexfcKLCZk7XkjpFyittiiP9Ws+Ydz/vmjF6x9IFJntS8X6VaaM3O0Fs3dlu388kqLwHq29wLRWfP5QnALE+7vnMLEmf8RnYq0qPtKIlbsmagbryKu6ItrFh7ByYvb7HxBqFLH2OBjYCqsTvtfg0X8LYzcuGtt4CS0r8NJyOI2aafF3YBCafWoV6Oq9VjnDLvoiy17X+ELwmS5HmGK0N23SOvXEAdZJE26xdYK9dxFWZkZu8s39sTuD9DJmqLXeJ7D21yPWrDqvRr/V0G8NZ6sEKmfp80E0CeoykUZb6yAGcM9iNyf8r4Jz3Zz+zgVtezaIlQSZNb3kaIU9jVxOujLzoRvmo8X8cHcGlbFVrW1W9j/kENNR9kioPrKG6OX4JW5uJSpiDybDCTI8MVlQ4vU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(5660300002)(83380400001)(186003)(7416002)(8676002)(8936002)(44832011)(316002)(66476007)(66946007)(6506007)(86362001)(66556008)(6666004)(31696002)(26005)(6512007)(4326008)(2906002)(2616005)(4744005)(6916009)(36756003)(6486002)(508600001)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjZwRmVuYzlPc2tvVERhMjBYelV6bkc3TUpqSFJnUDB3N0pIaVNFVGhlMkhP?=
 =?utf-8?B?TWViOHVPQkhmQURzU3Y2YlQ4OHRIVnVMd3RIWGM3dHAyc2NObUxiRnBmd21Z?=
 =?utf-8?B?U0kvdysvV1ZnTXFVK1JzUnpjNjJxSVBGeXpyZ2xmbUdWNGVmSUx3Uy9KY0RG?=
 =?utf-8?B?eDE4dDJvTVUrTDM1akhGWUZaKzJlbVhBZTBIZWVJaFlqcVhqV1MydFMzandi?=
 =?utf-8?B?eFVGQno0VW91TmhHSGozTldNbUR4NE1SV1NQV2Y5eUM1UFl3U2JIWTYrMzIz?=
 =?utf-8?B?T0dHUm9PTXNLdXlHa0VkWVNaSXdvbFptUFhUVkdnNVVUMkFSc0VXRzRZMWZG?=
 =?utf-8?B?MldlS0c5SjVaSm5mSC9jUGpIZ3luK2FKNUZQTjBJbUNQOFNYOTRDdjJ3T2VZ?=
 =?utf-8?B?NGhWSElnN0NzV2VWM0RNQUcxcEx3akxiZEZyNjA4OXBJRnZrREd3SC9NOFlD?=
 =?utf-8?B?OVZUUUQwYjA0OW5KYXZwZDFVV0pqK1ZkWDJyd0c4bDlHMTZHM0pXRFdUcHNW?=
 =?utf-8?B?SUpoZ2NaeTZPb0JyZ3AyS3JSbzk0UlhieGtsdFRucmdiVnRsdUkwbTV0bEZr?=
 =?utf-8?B?cjhJTVdBeldoZWM5cmdDRExpSUZ6NGpPenh0TGpFZllvQnVVYVo4MnZDbzZx?=
 =?utf-8?B?cDhrWTYyRml1SzZuUFN1aTZUSjBidHd0YVhWTGtSK25aempPdlFYemtHdUNF?=
 =?utf-8?B?SWVtZUk5WHR5K0NyR2thczVtZjNpc3RlY1doeXhUanM4OVg0VXJBcnJVcmRJ?=
 =?utf-8?B?aDNFNVhWOUVFaExyRDFRZWtucXlRdUorZzFOeitVLzdJZy9XUjVtMHR4S0dQ?=
 =?utf-8?B?MWtxQWZFSGVMYnZTVFdZc1RLYVgyMWI2a1RkcUFyQ0t6WTFhYUlXTFVtWEZr?=
 =?utf-8?B?bGxLUENybU9uaGlad0dyUjZNUE5Gc2EwYTFoV0tqNGg2dHRKNTlrTzlrZTds?=
 =?utf-8?B?UHh6TElwd3AxSmZEeWtBNWt1clIvdlBOVVlOSWVWWU5JK3JoNnlSQStXZGJs?=
 =?utf-8?B?aDVteHVIRUg2MkNMV09YRE1KcVRVdmNVbDk2S1A2YS83WVpWeTA3RTR1Y1d3?=
 =?utf-8?B?RHB5UnBlZ0lYd0xkN0tWUnRlY3NPK1NncDlqZSt2QjRHTUREbEhDR2FjSjRn?=
 =?utf-8?B?d0NVb0NyVnlVZ2l3bllPKzVjWkQ2WGlQanUydFlNblVVQW9qMVo3N1BDaHE4?=
 =?utf-8?B?bC9VaUxzRnE3OG5Zazd4R1doMDJPc1hQMnZvaWM4V0lMUjdRSHg5U0R5dnRy?=
 =?utf-8?B?UG9mcmdiNUIzOGE1V0xpQjVHYUJtZkhNQ0cxd1BRREJUU1FZWCt2RkNaWHA2?=
 =?utf-8?B?bUlaLzBuR0pMWU1rdDRyWDlOa01PNFJwVFpHUkhyNTRyeUxoRFd1bTMrd2N5?=
 =?utf-8?B?WGFGN3pjWGs4dlllYjhNOHkwY29YK0xVUXNZdEk4MDdxNW45WUJEZzYrZndJ?=
 =?utf-8?B?VmFxRkRqUW0wNnRrRUpKdDBhaWtvUlQySndKeStwVHpLZUhvQ3pvVFBFUEpT?=
 =?utf-8?B?L3REUk1BcXJzRFZ5MW5sMlpKZHd2dHpacVVURGtSc29melo0blEveStBQkdz?=
 =?utf-8?B?NlpyT2d5aGFjdTlhcGd2d1ZlMlM5MGhPUU5nbXBnaFAvc1k1eitHYmZEMWIr?=
 =?utf-8?B?clNsc0lldjFQaTdpZU4xUUk0WUpiaVlWaU9xTHpVYjlZVG1lM3hTa2dxMncz?=
 =?utf-8?B?WXVjYWt1VEl5blczWDRVaEVCb0pWTUN2ZWp5eXduTnNlRlVnbVU2S1JDK3NH?=
 =?utf-8?B?KzNSZUoyODZ4OEIzMW9SdFhlOGhNYm5nOG45YzlKRmJ5aUtBbUd0bG5uSmlw?=
 =?utf-8?B?M1pEUEtuT3YzK2xwdkdQNGF5WVRCQXNjaEVOMWw4VFVONVM5QWxyNHphM2Zi?=
 =?utf-8?B?ZmloeXFuYW1QRW8vNDZPQzMvU2d3Z1o2ZVpmQVVSZlltbC9waXFBZTNqelRD?=
 =?utf-8?B?Q2NPd0dxMjUxTkhZWFBKUjFBZ2xnTVlDV201REZTYkdpQ0NZaElQMW8wdjYx?=
 =?utf-8?B?ajd1czVRMUpPSDhieWs0cWtXSk0wdGN2NzBXYWpIZWNjMUppYnRwc3I5S2Rk?=
 =?utf-8?B?N2M3RGlGTHFKREo3ZWt4OTlqbk8vZ29UTkZGcnhSbjdnWElWSlBNZHh3Wm5D?=
 =?utf-8?B?bG9NWnVQdTVaTUUrY05Yek80R09nemlqc2U5c0JEUVRPM3ppNmFUUnNDOGcv?=
 =?utf-8?B?VE5xclJ0UVlYVXRlcEZnQmtHbXFZSVNGNHh5SHlVSjYxalRtUm4zZ3Q4NWJE?=
 =?utf-8?B?dnRsOWhnREpsZVdMd1RWT1I5MDg2Tkx6bVdOcml1VlUrYkhuaU1JcEpRaUYw?=
 =?utf-8?B?MGFsOU5hK0dyUU1DcldUUk1mdHI2elpHQTQxK25Gb3J6dGpoQVo4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29c9b69-9368-4e08-5ee5-08da3742ae77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:47:56.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuAq9pCCO5myXxHl/7tU+PiYBcCWTXR/EkpdBLPAADV4T5ICRnhK+z8iUuQfXMAcOHIA5ZY44OwAKeF0XwRBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-May-22 6:59 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 09, 2022 at 10:19:13AM +0530, Ravi Bangoria escreveu:
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/include/asm/amd-ibs.h       | 16 ++++---
>>  tools/arch/x86/include/asm/amd-ibs.h | 16 ++++---
>>  tools/perf/util/amd-sample-raw.c     | 68 ++++++++++++++++++++++++----
>>  3 files changed, 80 insertions(+), 20 deletions(-)
> 
> Please separate the tooling part on a separate patch.

Sure.

Thanks,
Ravi
