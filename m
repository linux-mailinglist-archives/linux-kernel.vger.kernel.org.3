Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E14E4486
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiCVQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiCVQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:50:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F534BA5;
        Tue, 22 Mar 2022 09:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2GqPk1cC7oTvGFoDRjMy/HTEq0eDOZbPLYRXOA9Xb+nw/A7jFmAum+CoNT8x/LZq3ZJDgzASwQTYwB3wTOqGQt6wAzBG61WEGcEElVsDnQ7mtUMoJpTtfoXazXJvCut3CDSyJTWmrKy2N8eCxysKVgdwKJ10mnIGymBaGokdsBZ41rNaUQQ6EINtbc0zK4T6H2ZoDM5ncpAkzGYNU13jhH3DPc8VlNp7ZGf7s6uPtuQ+ZQL4mkTy8fnta1be54lWiP7fenH7pMcbuzxWQcl281ha3oP2qf6j/nY4x7YStIPXaLWUs+lkW9Lz10Nvrs0fq8P4WILs0RKYo3wmylfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0u1ecMhYcPBodsRDuyj92eTCcuElpTe4hYcekvqZS0=;
 b=dY+RxVwZx2bKo66kI75pu+jFJhX1ig7j7WkN+fKr6sqYFe64FV+lkE1Tq7T/rrh2v9JKVp7Wm9qlsH9VlyfmyvT22pvCvQB1Bhw1vzqTn9AUREAAwjILYiBh2SgXuJ/iuf4a3UBpWbyvKXIYHgm6LXx2nkK+WfAuD2HQJDymsjCfW7AP/pOjXh8j1Fi+9icCzjkE1lIlP6ilQxSyagy6wCHBhxn0GM2ST/nsc6sS6CxX48mJ7eOZGrZc8WcQXVvzTT+O8vxNI092bPZiG4yCfRPwuTtYT0DeTZljsxPSuNGhTgUxabsO/Eh4AquyrZH/ci1SWyp3rzTD+ckOoGH5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0u1ecMhYcPBodsRDuyj92eTCcuElpTe4hYcekvqZS0=;
 b=OSNuJIApkTNxI4WVbWsLAMVn0+QnN3Fcu9MfdyzrnN9u/AjBzaCO6WQ1SlAki3MLTt1IsRc0NHcng/gx0xysm7SCeh5MF8CNQzdSZhYfFYFffIStrhZukkvl0YItLWxIYUx7M3Q3DZReAmAe0G81ksUmzsQc3p8rrRq7VTEqCQ4xinrtzZHuV6F34e/q9nCN7USAsDJtSsARXFXRdnsfzxs+BiP+tuSZUec1/s9lmnR7Deix/yu+HNm8o7sUpIVTpcI+qe0v5ElgoUJo2cykIPPYhuQS4pcaFh/kF0DtcJj78w3cSwDp1yz6R73lnqHjzlmA72EV5FmO2m5Ld5Fh3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 16:49:02 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 16:49:02 +0000
Message-ID: <b3527362-8cc4-3435-7d06-0df57839ef82@nvidia.com>
Date:   Tue, 22 Mar 2022 22:18:51 +0530
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
 <fc8f35f8-ccc5-e847-e988-c4b882e53a44@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <fc8f35f8-ccc5-e847-e988-c4b882e53a44@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::11) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a96e0f6-b4f6-4bf4-73a8-08da0c23de38
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18670898AF4A3CFD07E9A036CA179@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CwYewLxYgf8sRR6OZcmOaQEIk5bDPM+VWB3oTIScG3jvbYuC9PL7XA0Q/glH7XJkMRfSLwneMG3NeJpdltZyCaLHo5R7Ik2YWNq1LxyFr/RKGTAQOCik6cMV0uCZK+uQi46s2U7W9CfeGfpLI3lQ2SvtFiyP4zCxaSkV9tr0fGES4vjs2ljJUTXKFO9IK5fwybTEaNLo/N13BF6NdSK2Sc3eN6cDJSPSoYruHT1d+t5o0J2po9V8SI7am7T7yKrEEw7UBIU9JewX1It30EedH9ulCsUwE/nUV3BZqCjGMDtQ1NRJFY+DF1+xV5BfTLg2rstwfoItqKootBSWHznKx0v2dMhrZ+SUhGcPXKknRY1AValhEq+EGXERBozhRVMs39dJuDP5DzmrZHja3Gqxg2PZzCN4W2+QLGIp4AxlNsirfsnJhqm70xyZa3oBUtKBQQI6bWY0UzO15+zyxVmsa0oTlWw/FFdO+pxYX6EGl3TISJ8yFWfwUMcJGfu9oKcHoGhOAyEHTeRACRsN1yH3kBNhcgTqg5goXPcCrNitWXKgFc6pX5+tDE5cCzlFzfa6qbFnwdPNVhBM0yPESOwg6OPrp2wIPFO+tLg3ALj1ZvHVm4UACwwPqoFQNBKD/2Ri1MuPXVNRNZfeei8m9FqRtmpb3p3CGB1b9jeqJVTOz+vBRxrtfxvmmisPqEZyJKFZjS0FyovMm3U1EvDYdSD5i3Yj9JjV97slEKKTCbzpsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(31696002)(36756003)(107886003)(55236004)(508600001)(2616005)(53546011)(316002)(83380400001)(186003)(26005)(5660300002)(31686004)(8936002)(6512007)(6506007)(4326008)(6666004)(66946007)(66556008)(66476007)(8676002)(6486002)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9Sb2tDVW8rNGFnd3RTbE5mWnpwQVN1Q3FGc25WVXlFUE1KdDZmZ0UzMDVB?=
 =?utf-8?B?TUpXR1QwcjEwUGNoaGhRZnkzK0hpUUtpZXByQ0hFNDQ5bkdVTWVTY1FFM05w?=
 =?utf-8?B?WUJ4VXNjTGJPWjhUMU12ZWt2SFhZU2kzYkkxZno2dml3d0UzNUtUOHJORmNY?=
 =?utf-8?B?SnBpSHdCRW9iNlg3NnI5a2VhZDdLNFNRRi9RZXZHWnZxd3JqVEEvakk5Z0dU?=
 =?utf-8?B?b0t1bFV1YlRQZkxYSGUyYitsaVJNMnJMZW0xWWFrZGR4TVpyVWdNNmpodjMx?=
 =?utf-8?B?ZjJFT2g2c3ZzWkRield1MXRwQzdUUmlhMG5rUS96MldEVEc5alBLVmw2ekdM?=
 =?utf-8?B?akEyVWR0elNZNmZRQ1FsbmE5WDNRZmFiN1h2djNWVmpnQUtxRDdsMm42RHBw?=
 =?utf-8?B?UW1CVTh6a1JaNHdVeEJDck9kUCt3Yk1maDQ1Qk8xNFdQbmRmV0toMnhhc0JH?=
 =?utf-8?B?VXY0U0lyRk96OG5tWFJ4aFR6K3p0eHdMYzYwaUxHQmpsaDBzbk9WTDd6QlF0?=
 =?utf-8?B?TllqRm8xdHVNaWVvS2IxMEtVVU9UaElteWI1d2E3c2w0cThmbng0Qmkvclc2?=
 =?utf-8?B?cG0zcTA0amZrYk5sZEMrbHg5dFB2WWEzN0t2MTh1b3FtT0xWMHl3ZTQ2cTdU?=
 =?utf-8?B?TzRleGJ3QU4vZnRCd2VTbDNld3ZXaWhBWFVzUGFKQ2ZxYWkwNXJrTy94Z0py?=
 =?utf-8?B?VmNTNk5DQXlhSTZ4T2ladUgvVmxMTkVYV2FXbDFhSUtqZkJNUUVqUEFYaEJT?=
 =?utf-8?B?VklGbk9INWszQTU3YlN0T0VlblcwNTBQdURUaUNFbWJRbjdlZldsd1FqK2pV?=
 =?utf-8?B?Uy9NQTdPTmJ0blZqdndOVDdHUnhlVHZJSmdIQS8rK1AwLzNmY0ZNaXBKNTd1?=
 =?utf-8?B?OVJTNms4V1NUaldYMnBJeVZDUktORUUzMHRIdVF4amZwdFRvZ0xla3N3ejhE?=
 =?utf-8?B?RnRBYmRuOGtYaDRRSTFEQ3hGQm5ldXkvcTR6RzNIVExpV2tUT3pCNUVmODRj?=
 =?utf-8?B?ZGhqS085VFhyMm9HYWhCb1YrWUlZRjlDSzVMQ0RmM1VZaUhjZUhCRXg3REVO?=
 =?utf-8?B?WTNlSURULzF5bGNUa1pDRUh3eFZ2ZDF6c0RwcWlPMGhMNGNUWGRVVHZqV3Fo?=
 =?utf-8?B?bS9FcjRzVVV2Mk16bm1BNVcyVU95VDdURjlHRnAwNjZhYjNNN1VxQWFTdWJC?=
 =?utf-8?B?eEJjMHhYNXJFQnMzT3diajFzbFBFeEZIcTRWY2dWRG1iS2lHODlSMU40YUtQ?=
 =?utf-8?B?dTBTVVhpMHZLRHRYdkhVeUloVlpuMmF2ZURQcnNFcm1yc01XcEM3b0d5MVYy?=
 =?utf-8?B?Tys5elhERTBuU0pZakZPMUE2N05rMHJnOFNtTlEwdks5d0ZCekZtS3M5dTRB?=
 =?utf-8?B?U0Y1UEJkMjhqbGNzOHRsdzdTendubnMrOWx2cjhQRGxpb0ViK0VYaHQvYklC?=
 =?utf-8?B?dGZjMkRONTNYcHlsVnNoVWpxM1hzVlRZZE9FR1BHOGlQYlVmWWNMd1hCd1RQ?=
 =?utf-8?B?SExVZTdQNG1HaTRDdnRtSGpmUUE0VzVaZU1UcTZhM1lhTkEzenV2eEhDWTlM?=
 =?utf-8?B?Q3pWaUFheHZlMDRVQ3BXdHRaZ2E4Vlo1N2lWdkZPVmYyeXRHWThJdmNma2xu?=
 =?utf-8?B?MkhYN0l4S25LNk14c2hZeml1WnFQTmJKL3U2c3JtUitwdktJNFVCQkhLKzdu?=
 =?utf-8?B?WTdORlY2b01CWXFRWEhXVk14cEdwUDJrR0FwUXRqblZPenlkcERqUG0weUxZ?=
 =?utf-8?B?cDN5Q25qam0xMXRzRWhMN0RydUVNQlFUdUZIaUNBSlFEd0hDd3ZHMm1aWDZt?=
 =?utf-8?B?ckdaYnZSUGZOd1V3bi9JZFA2aEliVmlzb1FuVjdOMytYT05KZktkelpWZ2ZO?=
 =?utf-8?B?ZThmV2llU0krT1Z4TEdKeFpvL25paFdWQlY1QTluaEd2UmdDU1hBRitva2tP?=
 =?utf-8?Q?oi+fM+zS17lJ2T1GM+oBqOI9FpZmeNUq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a96e0f6-b4f6-4bf4-73a8-08da0c23de38
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 16:49:02.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASXHInKfhXZfoTlEEgoYLkJwxu22c+f0HSM5FLwJLb9JOIHVCww0hktzLoLPszId6b42P58qd0JpgW36dOhJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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



On 3/19/2022 9:20 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 16.03.2022 12:25, Ashish Mhetre пишет:
>> +irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>   {
>>        struct tegra_mc *mc = data;
>>        unsigned long status;
>> +     bool mc_has_channels;
>>        unsigned int bit;
>> +     int channel;
> 
> unsigned int
> 
Okay, I will update in next version.

>> +     mc_has_channels = mc->soc->num_channels && mc->soc->get_int_channel;
>> +     if (mc_has_channels) {
>> +             int err;
>> +
>> +             err = mc->soc->get_int_channel(mc, &channel);
>> +             if (err < 0)
>> +                     return IRQ_NONE;
>> +
>> +             /* mask all interrupts to avoid flooding */
>> +             status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
>> +     } else {
>> +             status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
>> +     }
> 
> So if mc_has_channels=false, while it should be true, then you're going
> to handle interrupt incorrectly?

I am not able to understand the case where this can happen?
num_channels and get_int_channels are both getting defined on T186
onwards where mc_has_channels is expected to be true.
Do you mean to say that we need to add more chip specific checks
in case of mc_has_channels is false?
