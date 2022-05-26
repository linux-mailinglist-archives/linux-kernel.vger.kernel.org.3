Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41299534EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbiEZMPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiEZMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:15:17 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9878B36F9;
        Thu, 26 May 2022 05:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVlT64rEox+6k4br912vt+cM++X7tIJjrKEkkk4mC1fau0wKOfBDKJhupkbfB1zO9vMixhuuj5a51F+cWu/A200in4eaz6yuwidI4jazms5nqAk+3YHTU5XS+GgJSoWL6P+AKBEa3XfuD6dDuecqB4ETihEOAEfxct4saDhWyeCLVF6kkjA2iY6zKI2F/fCoNhRQ4uiC7GRJKj/pjY15mg90ttKmRNnVjOghmkpbtwd4kOduIqT4uV8KGasU25nr3WH+J1dIInwg7MxgX59hUCxbkcqlCg93MVFN/19OqNIrJF+7xPbOYFuHDFr6CunxH8JyyezRxmGeuT6k6uw8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/njkY1jT3r0Z0KtcroeajeKHeomvSvaFy7FnvjmAts=;
 b=Qompk/RrtObcdhw0bUbrC5SpOuMSJwl5I2cyKcXABOA7sdZJGWWYMuZWPEytgauPf9/cmef3SGGdoWPjnAPPaDZLhphz8Vh/hIf9lP3aVsf8la0Z3GZTX/OF4Cs1owTRMGE+RYkr8GntE6qdkIXv54e7k/14ZT5+8VKEk2bimVByr5I45O3+x7Pyv4Nbg153xe91ygglTwjAVvAPs8O8R4VNKqvNgxtPvSc+1DXU0Mpz5lFtkHSLaEge2gbD3C3fQOcjaVr63qLVG9aVx4j65RdNG1B3h2uGLlr1o67m55r1/PNTcXdDz08cNnVElHceQagI7CjxbmZbscOahXqavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/njkY1jT3r0Z0KtcroeajeKHeomvSvaFy7FnvjmAts=;
 b=dcsjht3F08JvUchZJ7YcQ8RfXsmgq2ohWFkYA9MhKttfkOEGDxTQnPOvZQyXAUVvVEASZ9JgeTMxRCbsyEs1XyJHhzlygu+0cx3EHz3+ZLBa5hlRHpONcjE6O7XQtT+Elhc15K1nl2akoI4SwVImS3zYMX1LlbeWpzq+OFujcPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN6PR12MB1345.namprd12.prod.outlook.com (2603:10b6:404:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:15:13 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 12:15:13 +0000
Message-ID: <8b124340-a89b-bd7a-240c-c7f58fffd877@amd.com>
Date:   Thu, 26 May 2022 17:44:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 04/13] perf/x86/amd: Support PERF_SAMPLE_WEIGHT using IBS
 OP_DATA3[IbsDcMissLat]
To:     Stephane Eranian <eranian@google.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
 <20220525093938.4101-5-ravi.bangoria@amd.com>
 <CABPqkBQ-4vpG_d-u-Q-pTQ_wDg_HhqNNC3dSLFE6MS5Bp3qTDw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPqkBQ-4vpG_d-u-Q-pTQ_wDg_HhqNNC3dSLFE6MS5Bp3qTDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10efc61b-0604-4120-e3ee-08da3f1162d8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1345:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13459BD7AEC656D14D45F5A6E0D99@BN6PR12MB1345.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnWKtbaRg41A0ymVxbTrnYsjYHsFcn09tA0a9mNav1Gq5otrbg2zEnsxjk2AHQ59DtIYm4Xcn+24l2QoonrUuNw3UOv8j1DBE7JtQuLlToGWBw5CNEQUbf6v/Kt0M7+UU1xqma3BcRPJ6RodgZYt7H8eo13hLdUzL5a2BvgVSXgUp+Dc4/3t5EmcMzQw7MSdPy94wRNeUjKMa16iLcONaCU3n7+Ztb+QQfyo4HxrGgdRFiOKlk4/a4GAL+RhJZFnfcS9L3fB7tgctn6ZLRlzmJp8EoqdsKC4zK9+vKWw2ooi2wpvkbXMNdQSOflM4IQX8Yv0jBKaacVCAFWYrCGi7u86ZbQ76YPf3yLPCb7ZcGZEXEN7l+78n2IX4oQsySIG7BoMZqZz+DcBLgIAraYeBudSFVv/HyNjkvF806vvB4oBydMn/cNAeLvn3OmDeNd9O9xb0ozauDgv9wI9yroBPNO364Pg0zzuj/nIoB7cupBp7bkDM0h8O2dUwceSkv6/u5weYE1R5u7YfFmFtWmcVezwjeQLaTrVl1meh+h31pQS4iKYFm/EtyeiIxssm+QtR+Ef5CtKGOZT4QMNKHW9aSBL9K4BdYUAUOo2UUeGOSm1Fvpy1MPr3ZK6fSWowbsRh99nq3LVKnbypfNG4zAvy7TggDrrT5bN3+CogtCL1elSNXbJhPs/pPBcf/LIhcWdqaqO1rjggwmByM+Pitkx3DWeETQPqNoxZvTA2uY6wLgVizU8VM4kUuHcAScFPTufvwZVFeTvHlDgtSuDSZBTFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(6666004)(38100700002)(6486002)(36756003)(316002)(53546011)(31686004)(8676002)(6512007)(26005)(6506007)(508600001)(6916009)(186003)(66556008)(66946007)(86362001)(66476007)(31696002)(2616005)(4326008)(2906002)(44832011)(8936002)(7416002)(5660300002)(16393002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpnRVIvNHNTcFhvemFsYlhFK1VhNFZDU3RGbEYrU0RWTmxTSXhEYzZpbVpG?=
 =?utf-8?B?cVVTemFpODhndmx6bFZTNlIyQ3FKNDhNM09yUWhtUVNpQ0dxYjNPcWVURmJ5?=
 =?utf-8?B?SmtNaDhqNW1OK25WK25jS2FrZ1BUcHNNNnM5OTYwRlRiQ1M3akQ0Z0JSSmZZ?=
 =?utf-8?B?a3BKNE5JWEl5VFZuSXRBTmFHbUpyZkhWMVZpZHNGZ2FEWnBOU24xTzE0K2Vm?=
 =?utf-8?B?bUIzNk9KOHUxQXlobjZLUytqM3gxM2NMQVlDQmJtTkVTS1V2Q0tMb0NWUE0y?=
 =?utf-8?B?WGxGU3lleEpyNzdhdEczNEEwanJxTTVOUEh2clpYZ2FYcTJqSlNaVWVXYmh2?=
 =?utf-8?B?bTJTM3l2S2hJa3pvYXB5QWxYYlpQZlVwYVcyTHBnNVo2a0x1bllkcmhiUkp5?=
 =?utf-8?B?UUZISmdLZFB6SUJCV1VDb0VMcExTNllZbUJEcnBMMm5uaHgrNk9PUTd0ay9N?=
 =?utf-8?B?eWZxdnllM29Pd1VEeERxU2JCUjhmQ1pZSzRrNEIxRDR6N2Rxd2tWcHFLdkxK?=
 =?utf-8?B?ZGFxWHZmWjEyQ0toVUJ0SXA1enB6bTJjNE1pS0duU1lRRFdCTzRKamJSa0FK?=
 =?utf-8?B?R0N2cDRySXAzQ2dwYmFQa2xzcHIwcnl1VnZQenVqVDF1WS9tcm5RRDVrSm5V?=
 =?utf-8?B?MzB4VlRRUkVPWVlpaEwwbGhXT2YwVjZDYjRXQUYrRmI2bjNFTjdOUU9vRG9I?=
 =?utf-8?B?ejI2elNMTDMvdUZHRnZSWGxoNmNwaXlnUXFtbDBNOGRiT1ZxNUk2VE8vMnpF?=
 =?utf-8?B?aDd0SEdKeldReS9hcGEzNnRFQ0pUQWx2bDBRcG1HZGpnZW9YbmVGNkl1L3FY?=
 =?utf-8?B?V1ZmRnkxSExvNXlSUVJ6Y2dIbEVLTzVGRUZTdVkzOWRsbVI3UnFqV0kxMHVF?=
 =?utf-8?B?NVN6THFGaEhRV1dBeFBSWDhhTVdzaFd5TGZyT1hySy9yc2VjMXJ4NjJheUps?=
 =?utf-8?B?MWZGTVVmMC81QndiMDk2VGE1anZORXVjcUdObGE4R1A4cG5pSmJodklKZ2F3?=
 =?utf-8?B?RSszbTlrYnE2ZDNjQ0JaN0RtR3VWZjZ1L3VEYk5aUDg5UG51ekFFWW5GVWN4?=
 =?utf-8?B?czR3WmIvdVlYd2QvQjZPSXRNT01PemVtSlZNSldyS0VMbGduNEtRbG1HZWFL?=
 =?utf-8?B?aDhIZXJIa0ZQYlNNUy9LMXlsUHlieGxnWXFWb25aM2hYUDNXVVpSRkxKMm52?=
 =?utf-8?B?QlVUUEFkQ3oxUzEyOVk5UDVOdE9NUDlnbkJEQjhmUjdMdHFYU1V2NXZGSkRR?=
 =?utf-8?B?RkRyUXhZMHZ0aTRNck1zTzY1U1BXN3haUHczSzVoMmZGNVk3OURJbmw1R2tv?=
 =?utf-8?B?MmZTR0pUK3lySzZGRkpGOGJlWGRkQ05PUnFDOUNyNmdvdDA5bjNNY0Q4Q1hC?=
 =?utf-8?B?TytUaGdjY09ESkJ3WnUwQVNwcmRYMFZRa01GaW4zOVJnL1pkeUg5bTJWaUVU?=
 =?utf-8?B?REZFM1NmeHV0a1hBSHRFZUpQUnNzZlZaM2h0SXVvS1FZdGFpTVpnU3hFSXdp?=
 =?utf-8?B?VU1Ub3BDRW5UckJtRXc4VkpDbWtyTVdYM1ZaYXQ5eEZmOTdqV0dMMFM1ZUxk?=
 =?utf-8?B?TmJJdmt5U3QyaE80VXJGUXJhU0ZyVVBSVHN0OTFTeWVYaVp1ZEd3emVEN0J5?=
 =?utf-8?B?S0sxcmJDRGZWa1NUV0x3OVpZdG1EZC9lMnVxRGNyRmUxK1FVMU0zcTRFbVJX?=
 =?utf-8?B?RDF5SWxXalBPeFBKMnNxTmRkWGFLRDhKdEQwZkVucjM2bTFCVTdzU0pDaGZY?=
 =?utf-8?B?UmZYWlhWSGZXTUwrd2xvdFM4N3poR0xKSnVOUXYrcXUyZkZra09URW9CODlk?=
 =?utf-8?B?SnFqRXovVDZMRnhuNi8xc08zaVJNYzErYUcwUXYxRGRLM3lkRDdvSk5jbmFt?=
 =?utf-8?B?WExneFh0ZGQ5dmtxTk15YUptSGJpcXJIMEM0WnNMUGhrQkcwWXJ0clBtSDNV?=
 =?utf-8?B?cGNHajRkSjBneU5zbTRoUmgycXZRU28ySzRkVldTSE5hVnpVdFZPSjJlWEZz?=
 =?utf-8?B?VVI3VTA4STdEUy9qWkxvMEt0dmxjazlZa2UxWnNNSENHWkpZdytHZFQ5SGpn?=
 =?utf-8?B?WVJ0SW10RFJpa21NS2czdm9DalJQck5hS2hzQS9VVVNsbXh0SUhwVDF0cHc0?=
 =?utf-8?B?SExib3N6UVVBYXZNbitFQmlKNVNQaHdvSjRFeVFVYmx1S1hhQk45ZVlacm5k?=
 =?utf-8?B?SnEzcWg2UnA1ODdLSVg0WTdSaDduazcyRDdXQUtSNVozRW5ocWdFUGl0eWov?=
 =?utf-8?B?RUlzZmRnVXBsQ2pVaVlvRlkxekc4YjlFWlBXeWx5Wml5akd2bUduRE5IU2JV?=
 =?utf-8?B?WkRKbUpwU2srR2F3Nko3Q0x6WWFWSXMxY3ZVSGp1cXFhSE5VY3plQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10efc61b-0604-4120-e3ee-08da3f1162d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:15:13.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: revF0HshM5ba42n9X/0UUMISKzRBve67gTk4coqCkpHyOK/nf2yay/K2KnTcnSGki1kcdEBDPVswAR7nH4Jd4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1345
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-May-22 6:28 PM, Stephane Eranian wrote:
> On Wed, May 25, 2022 at 12:42 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> IBS Op data3 provides data cache miss latency which can be passed as
>> sample->weight along with perf_mem_data_src. Note that sample->weight
>> will be populated only when PERF_SAMPLE_DATA_SRC is also set, although
>> both sample types are independent.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index 6626caeed6a1..5a6e278713f4 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -738,6 +738,12 @@ static void perf_ibs_get_mem_lvl(struct perf_event *event, u64 op_data2,
>>                 return;
>>         }
>>
>> +       /* Load latency (Data cache miss latency) */
>> +       if (data_src->mem_op == PERF_MEM_OP_LOAD &&
>> +           event->attr.sample_type & PERF_SAMPLE_WEIGHT) {
>> +               data->weight.full = (op_data3 & IBS_DC_MISS_LAT_MASK) >> IBS_DC_MISS_LAT_SHIFT;
>> +       }
>> +
> I think here you also need to handle the WEIGHT_STRUCT case and put
> the cache miss latency in the right
> field. This IBS field covers the cache line movement and not the whole
> instruction latency which is the tag to ret field.
> In the case of WEIGHT_STRUCT you need to fill out the two fields.

Yeah, will do. Thanks for pointing it.

-Ravi
