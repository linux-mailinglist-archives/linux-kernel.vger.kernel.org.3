Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DF535139
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347853AbiEZPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEZPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:08:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD51A828;
        Thu, 26 May 2022 08:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex1tQ17nYzhtkn5kHVJns3C+lgF8QfVhKBpjDevhTUadpggZcKJBo9ZERJitMK5zKX9Cw9MBaC6BYJ6cYSpw+lXqLYw2/eoIn+ay5SqahDDVLkWq0x0cFFpxwqXl+MVdUGa8hevnoLBj/szWGhgGPFO7MNcB6zNHcSrdEQ8fY1DjdiLimXa2Z5e9/lyZWsa1L1ztSvlXil4WG4b0cdDNJX8fOlUVEHi3it3HNKOlJaubJJDyw+aR1B7Yz67S6JV2dXS5agoXh8vHKITHYeSFbpUddbIEBk5H5NLip437/dfgQ1eaaHaO4qIUArepuU2F/oxnY4CGXd9XfbZfOfob9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w77/2ShLHHeiz1X6B54L1MHPnMtHg4JBENX0xfSmdds=;
 b=D+HxpAQw8vLMhXDr6/NQdNZ/7XvDBlcwQaO210Co2O1XJtb1s7Y/t77nRDOQUfqJn6rkZvCFskwD3yjrK5TQQFa7ihJ0DgAqfF7aVQzK4sRZb6aDu3G3EJ/6yqXLhmV2MQqd+bHyoNuJP+XHQhoCIhTJQ12wvteLkqFSnwSUa4/HJSRVSMZmkkY3vqOAXOD6fkrJHUug+lDkqodCR0YTSrXNUqQlYhv77XRpXPfhSZA9bia9m5xsmTU/IDWh4ZBsBhdgn/ZFY59GOszAT8G9mAty/cegF87mfMkof3l8ScMse/+54tH+nSwhWprLH1hENLYh/2BIjqu5cuwolz0OyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w77/2ShLHHeiz1X6B54L1MHPnMtHg4JBENX0xfSmdds=;
 b=OXWqtdKmC6xHW4bZE8tzG080B45rzYIrrZMoCCfOKD8zg9VULQRFDKacxNr8CUWWkAC+GMHGgEKV6FziGl0qtecYQoMjV07fGHXBESb/7z5pTjFOXtD+juF2FJOixLJaJjsm0EBv7NibT/espKeyQhMVhdRUTwzdfX/xrNOs8RA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BYAPR12MB3077.namprd12.prod.outlook.com (2603:10b6:a03:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Thu, 26 May
 2022 15:08:20 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 15:08:20 +0000
Message-ID: <4f7239e2-c065-0800-f679-d4ed797fdecd@amd.com>
Date:   Thu, 26 May 2022 20:38:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 2/5] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, james.clark@arm.com, leo.yan@linaro.org,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-3-ravi.bangoria@amd.com>
 <7c072dd2-de6f-e083-a400-17467d6fe6e8@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <7c072dd2-de6f-e083-a400-17467d6fe6e8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25804639-d5a4-4704-a476-08da3f2991c5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3077:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB307765F7C3D76A4FC55D8E3DE0D99@BYAPR12MB3077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpUCbD2O2fI3xS9/badFfgOhijt8R0iodJW9/bP59GsmcK1i6Uji6KyXtAj9Bt4layOCsKG4Yb5UY5BCigLzikqcPp04EdgdnLRClgOVBe/cuCcq89SFI1NdvIvv7nNzfALgFroUbrZ6xLV/aRnJsVgcYvMrNo7e8AS9Gr2+LVdyH9FLunNKfR41dg/kmwJv5VDWRlLLxEvQB9wXP829YzAc/MzYiYBJQD2L8Cl7SoIsyB0DDHHqLMHDiTXQ8p/xaIVEp4W8/QKhYru9gmI5XUX7viJavPfNOiel37SjfJMns/78Xsy/cEqEp6F+Lg44R9KaUn3cW4ALaRemPcmXTSo2F/xUJ27s4VCMCNVPFAICPy+ETCrlKmUWfcTwW64FuXxUiAIh1njbNNhuKzujzC77gcN66beFEi+wwsITWOCz+wMZqFHrrK47Z49/Yot2bL/1w32ryfQPFhkFRc4Eiml6LQX9wW4frj2Fl+Na71Abaf4EOOqNEGn7/xVI5op5fEwSb3eXRmc350eQQVHf9Ui2F69dSYQ4RahtHA+qKawRhfei4cg1F+jOUgq9rP7PO0mGnjbR4+t0Dw3zYEStlOHSNZObUOxceDnbtD12yQZXLQbMEC23qk71FJfMebc4B2JRORwVQ9h0RqSif5QqnAyxRbkQ33pcRmzR//mAHc21KWhue27axUFHhls6dC7E0Z8aPoL1266ooOS+HRWLHeDenAnN++8BsEt1jwDirMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(6512007)(86362001)(31696002)(8676002)(66946007)(4326008)(66556008)(2616005)(6666004)(26005)(66476007)(6506007)(508600001)(38100700002)(6486002)(36756003)(5660300002)(7416002)(2906002)(44832011)(8936002)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU90ZFQ5b1JBMmNYSnNESGZOcE9qQitIczZ2VHYyL2tkZng0eVFqUlNQZ3dm?=
 =?utf-8?B?NTI1bDNXbWJKNzQ0SUFTR05FT0daWUxRdWllYThiWUxzdmdHRWw2SUJmTVJN?=
 =?utf-8?B?N3ZSZWhpRE0vSUg5ZEQ2ZmRYNkRNaXAwcnJLcU9tNGZiVUc3NTdMV2NCeFpa?=
 =?utf-8?B?MXZ4U3c2aXlVNXJCc2gxNDBlTWpNcXdXeUlWTElmOVRSdGtmelk3bGMrVEhj?=
 =?utf-8?B?eXpDbmozUzg5dU1HQ3VhYVRZTy9kWTQxTXBMOXp0MlZxaFNEYnd3eVFJd0cx?=
 =?utf-8?B?ZEVFdkprOGxIVWhzY3VLNUc1OXRkOFErZS9wWEdqZy8waHQ3M21obEpYbFl1?=
 =?utf-8?B?MG55MlIrdGZ5SmFXQ1N2MlIxSzBWMmVKNHNnNVd2NjZQVVN5ZWYyRlV4bmZP?=
 =?utf-8?B?MENUVTIvVFNIbnJUNmg0Q0hjRko3Q1VKcXdHbEZ2ZS9OSFgzaElGakZtVVBW?=
 =?utf-8?B?a3lXNHBaVDRZQTExSzhabUpyaElxb2tucGtOTml6QTdRaTFQMmp4TEQraTAy?=
 =?utf-8?B?a094QWZIY2ZiVXhDTzllMUI0R3dCUVBzL1NIa1pOS1ZyVWxsSmdkYTNTNXNj?=
 =?utf-8?B?RnhjcjJXNFBNZzNVT2VlWXUrMldPNnpxMU1PVkd4Si9FbkpYdG1sZkRmaVFQ?=
 =?utf-8?B?SUQwQXNQb2ZuVmtPcDd1NEZMeHRxZk41cnZ3alJIdjNTbTlRMmxSUmVkWDhT?=
 =?utf-8?B?YUVJcXpNL2JSaTlBb0VuM0dQMUtCNHJqVGpsekdWQ3U4V2RkNTNxci9nb1o5?=
 =?utf-8?B?YlhMREY4ZVIzVUY0S2tuSkluZDdLSTNwd0pVQXF1djBYWG1STXF2YUxTSWky?=
 =?utf-8?B?ZkRIbVhXcytHNndwUTlDbEJLUFFkbHZTN3BaQ21HTGRVOHRnSEcvdnl5akxQ?=
 =?utf-8?B?Mm9CZG9oMnVFK3hwY3VsU3VRTHpyc2VySWhtQVlmWkxORnBaSzVZOFozOGFW?=
 =?utf-8?B?cnQvWnhEa2ZTbUpZRGVhWG9KdXJ2YWFkVFJNaXJOQTZjdjdScWZLaklmRkZ3?=
 =?utf-8?B?OUxKNFdROEdyLzVQdWVwK1h5YnZUdXdmY055U0t3MWhxejFlcWx1U2RNMmlR?=
 =?utf-8?B?NzN6NnptL0NUdUdicE8vb1JXNFZyK1lDMllPblk0U3lRdUxGWDdEZGlUR0tv?=
 =?utf-8?B?czVvdE1xVWxKR3lQYTEydXdJQzUzbXU4YVpXZzJHYnkyenpRVFE2dUoybWEr?=
 =?utf-8?B?RkREdVEzUm9PUzVjdHNNV2NPeXQ5bXo0cjVWUHZPbTJLMTdtV2hHMXdESjlR?=
 =?utf-8?B?THF5eU9sUTFNVUJhN2Rsd3ZQSW41NjAySURCQUEwRnd6c1FrQ0dUc29ORUps?=
 =?utf-8?B?QjNGbzdiTlhUSHVXbVdOQi9nNU5oWHNVNmZENHBtSW96aThBOFE5Rk51TU40?=
 =?utf-8?B?enExMklLR1FtVldCakdqZDJ2dk02UHhnc3E0STVleU4rblV4RkpWWUFNamFW?=
 =?utf-8?B?QVE2c2ROdjgyVkNCWnB6ckRmSFhsMENYc3BLc1dMWDYzcGNTWEtHMkJ6YW5G?=
 =?utf-8?B?TjVBcTloSGFNY2F0ZkJ0eU93YXJMcDhET1NJZHZyN3dybkFyYXJ0N3dJa3VH?=
 =?utf-8?B?VWFSYkE4SU0yK0JqU3ZveUtTRlZhbXhzb2pwbVF4VWpUeW53eXRlb1lxenNH?=
 =?utf-8?B?czFncGx1bDVsYndaUXczQWdLMjdwRGVJS3VHU2JVRE5iTU5wMEp1ZDU5Uzd4?=
 =?utf-8?B?enUzY1VQTndockx5Rm1QcERVMWpBV2F3ZldjVXBWa3c3SkQ4WExtTlgxRHhj?=
 =?utf-8?B?VHYzQ3lKS29EQUJlQ3gxb01YZDJLbG1rU1owMFhRSElzVmlQWFVKSlE1QTZn?=
 =?utf-8?B?akhEcWNiMkdLKzNpYXQ5Q0htb3UrWlRldy9GRzMyZWJycDFuVUxxRS9ZZ05S?=
 =?utf-8?B?YTNmdnlvSnJKbm9RcTJnbzFxanpVN0Z1My8rcWp2eVVRM1F6UVhwSWEyMUhL?=
 =?utf-8?B?aXVuZnRweHpnQzdtR3VoL3lNa1krMlorWnBxdmNjY0FEZ3VEcS9MNmsyMC9Y?=
 =?utf-8?B?TS9PSVQxUG11ajkycTVJc3pEQUNUcjdnMG9oTEdnaG92NmxCblRjRjZ0cHRx?=
 =?utf-8?B?aHBCY2ZGdVFTN0FHOGlaS2NPSlFVT1J3L3NsSEhLdGZudVdRd2wwK0JlTENM?=
 =?utf-8?B?WlRXL2JJemVuY2VSMVdOUXZmWnorTng1Zk9uYUtsUU9oeDBrREU0NndVdUsr?=
 =?utf-8?B?WkFyWmlLU0ZKcGxhZWowQXZVTW4vZ00wcjZ1L1dla2RDV0pyMmNvOEt1YWFn?=
 =?utf-8?B?UExRU09ONElOSlQvenNNOGxYaGRjYzFuZ2Y5dndmTzBOUFptV2FFYmpURU9i?=
 =?utf-8?B?elUwNkdhSEV2SEF1b3dlSy9aL2RSM3hHVUp2VzBaeG91bnhUeS9tQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25804639-d5a4-4704-a476-08da3f2991c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 15:08:20.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSfd/8T8Iz5h0TbPG4vzxCDTf4yvZGgPZvpsuTfYZndkCALhc9JFMSSAsRsyPsWmRBJLXklui/DRsnUwn+UwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3077
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

[...]

>> +static int write_pmu_caps(struct feat_fd *ff, struct evlist *evlist __maybe_unused)
>> +{
>> +    struct perf_pmu_caps *caps = NULL;
>> +    struct perf_pmu *pmu = NULL;
>> +    u32 nr_pmus = 0;
>> +    int ret;
>> +
>> +    while ((pmu = perf_pmu__scan(pmu))) {
>> +        if (!pmu->name || !strncmp(pmu->name, "cpu", 3) ||
>> +            perf_pmu__caps_parse(pmu) <= 0)
>> +            continue;
>> +        nr_pmus++;
>> +    }
>> +
>> +    ret = do_write(ff, &nr_pmus, sizeof(nr_pmus));
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    if (!nr_pmus)
>> +        return 0;
>> +
>> +    while ((pmu = perf_pmu__scan(pmu))) {
>> +        if (!pmu->name || !strncmp(pmu->name, "cpu", 3) || !pmu->nr_caps)
>> +            continue;
>> +
>> +        ret = do_write_string(ff, pmu->name);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        ret = do_write(ff, &pmu->nr_caps, sizeof(pmu->nr_caps));
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        list_for_each_entry(caps, &pmu->caps, list) {
>> +            ret = do_write_string(ff, caps->name);
>> +            if (ret < 0)
>> +                return ret;
>> +
>> +            ret = do_write_string(ff, caps->value);
>> +            if (ret < 0)
>> +                return ret;
>> +        }
>> +    }
> 
> The write_per_cpu_pmu_caps() also does a similar thing. Can we factor out a generic write_pmu_caps() which works for both cpu and non-cpu pmu capabilities?

I might be able to do this but..

> It seems the print_pmu_caps()/process_pmu_caps() can also does similar factor out.

not this, see below..

> Actually, more aggressively, why not use the HEADER_PMU_CAPS to replace the HEADER_HYBRID_CPU_PMU_CAPS? The HEADER_HYBRID_CPU_PMU_CAPS is the last header feature. It seems doable. We can always write/print the "cpu_" kind of PMU first to be compatible with the old tools.

There are some differences in how capabilities are stored in perf.data header
as well as perf_env. In case of HEADER_CPU_PMU_CAPS or
HEADER_HYBRID_CPU_PMU_CAPS, all capabilities are stored in a single string
separated by NULL character. Whereas, in case of HEADER_PMU_CAPS, they are
stored as an array of strings. The reason for this difference is, searching
in an array is far easier compared to searching in a NULL separated string.
So, I don't think I can extend HEADER_HYBRID_CPU_PMU_CAPS as HEADER_PMU_CAPS
without adding complexity in perf_env__find_pmu_cap().

Thanks for the review,
Ravi
