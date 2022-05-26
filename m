Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA8534BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbiEZIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbiEZIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:46:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA045EBE7;
        Thu, 26 May 2022 01:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPog+osdcpqoxgjxu1h0CluW7syzBEAO4jNpOfprJtPN35+E6hisiJZRZvMjFmwEdJ1HCtWeW8roNLiJshGRZ9sOTe3hZuO04mZ/aV5dj6OXhRayEeri4sIgpZXuBrHtYYCg50IzSLC9rRWtxe7jto4u5r3q+j5HHdbn0/A7ESW4dXNGufBPkWnsgqmkqZgl4nS0kcpUohuS/44ojkzPe3kG+KfAvlHoOMmMIOzByfWw6rG9SZcPuJBkip6IkIZGFhHAms1Lw7a7tlPBLnJPlwkidedrZwvQ7/xas+74Kzvix1ueCGF1c8BfHA2tFX//m2leC1onCQKURbjTM3F0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ1wHgYEXJsAoOG75Ib1m5P0n6NL5zZ/aco2/Ju3cys=;
 b=Ls06oL2WBagwFZy9kIJDT49ISJN4GDXnIfKC6cYI0VgWiiSxSNifJ5FhKvPfkWrxsKb9Wb51DHfyt1D2JqnzXv4pMLVZPnJtGxjnKMSYDK259Ns5LWLmTLL0SswyYl2WgK9bLUfUNCywFISM3v7sxgkBp7woEdXClaplCJ0dVqIclxmL/BBplyTqcz5XTCYFgqubBy4jm99QeZC/dIebIn1vH5Z7CB9RD1EhpK+AaY7u1/tlkb7uyeS1tCNtrZqAGqfc9cNsqbrSRvj7Dp7BupS8oluiR7u5IH1ovoQ3mkMrvf2F4ZS9DYWb9+qBfpJfAfWPSxsjhvDv0gQb2LMnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ1wHgYEXJsAoOG75Ib1m5P0n6NL5zZ/aco2/Ju3cys=;
 b=qIP89NKUhO99DXGKpUqR4zzBFFWU7THSMOQh+TICABAYdmRw1L2J4dU3+fciAXmL6kOa+wZUWhWxIKMBz95c5+8n8QQmIYRZGVQ4jp7ifwZ41HbQih5y2FEIHzIVamLgAfkUQFCGgGICOPKiGrYL5gjWFRF2YdwJ2BqYQ+IDx90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MWHPR12MB1455.namprd12.prod.outlook.com (2603:10b6:301:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 08:46:50 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 08:46:49 +0000
Message-ID: <e10c3d1b-90a9-2f14-987b-9c0d2471ee53@amd.com>
Date:   Thu, 26 May 2022 14:16:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 06/13] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR using
 IBS_DC_PHYSADDR
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        eranian@google.com, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
 <20220525093938.4101-7-ravi.bangoria@amd.com>
 <Yo4RSY2L80N5muJ9@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Yo4RSY2L80N5muJ9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 606b6280-c4d7-4366-8759-08da3ef445f9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14553CE08025E37E3A0131EAE0D99@MWHPR12MB1455.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtYsHr/GvUdWCkz1UAmA4omklP2VA7GnPcJJ6lZnJpwzbKsIY9d17K+Fx5Lfq7ucX/yzJ9LBahKP5JD/yq6YY+vx4wFsaURM+zl8U6o3hCne40qt8jEwKITw8RD2uEzQEEi3ll1i7Cm25t5VPinOP1ph9OOUZpiVADP2vzthiayLRqa9YgylsTZrFOQxaEwcHvDswcKA160LvU/0g9qSY9MzMPcutr3DLojMNbqGliZObbVuafdTFHZG2gKqnQRo+pyvbPkVozrUg8oiH+eFqnZzoWNSOztkQI2aSXhB50YwBLjLdb+NTMNI8BqQhZhYqX0URhaZiMTJT4i62UgsF4h5gPdjPTG7Sv4UNUZ5MG7Zxb82NqC3CczuTVtY6Ti3KF8oSNMx/jCT56hkYbHWpYosKiiICIvg8IAMOYWr2JxMrycOGIOd1mYrXlYnuS65Gc0YAy+gn6HwN+xPBLDh4TvPysW9K+kOaqtd1o/k6pIcpseESHhh0luHdePKLqToZDxaPtBf8gYXXcPWIj9WdszSB20GLuj3VXCxDWsefbp2MV+HpHNlQvM8uAcq37iSkyH2FlJwkn579+AqS7STMYr1bUgxkXO0uotjR6GqhYItbM0jK5NFVTqGt5jxinIlKIwC5Kynh7Peln4fr+1UJOZhnJ6VPpnTiKS+r/TW94MA6+gJ+h3GqVa5VKc7iYgOj8x7AJNW49Op+MCAsTYXKAFbyANEGBZ5UgTuyqVra+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66476007)(66946007)(31686004)(66556008)(2906002)(316002)(6916009)(44832011)(6486002)(7416002)(4326008)(5660300002)(508600001)(8676002)(6506007)(6666004)(83380400001)(26005)(86362001)(6512007)(31696002)(186003)(38100700002)(2616005)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmt6MDQ4T2JGMHpEZ29hc1Z2VkEwNThzYjJZU1E5eUVZOTlFeGdyeXUrcEVQ?=
 =?utf-8?B?cGNpRzFwNlQ2UTNRZGEyZURudHlSRi90R2lMdFd0Ri94UjNoYmNhYTBld1Bs?=
 =?utf-8?B?VFJYVUZkTHYzakg5OERzTHkzOHRCQWhxRWVXTUtlZm9FZ3FxeXNsTWpQdnlQ?=
 =?utf-8?B?QzFYcUdjalZPVWdPeG1wRC9tazdSMVBwdHhqWVZyMDVIbjJndWFrNzFzaERD?=
 =?utf-8?B?TDk4TStXY2lpVktuSzF3SHpCeXptRG9QbzVpRDM1WXBqZUNyMFA1NEdWWDZi?=
 =?utf-8?B?L1RHZTFSZDJJeTJEcWUxdzlHdlljVGNOelJhMWxZdTJzd0JNWTVSZVJNaFB1?=
 =?utf-8?B?aDFRcThWMVUzZ2Rxbk0yc3IwNTYxMjAzR2l2OXZldTJFbEJOMHZtcVFJejZw?=
 =?utf-8?B?WFVqSHpSVUFBNnBuVjIyQlZwM052YkZheDRMTUs3SG12eU03dVkzK2FOa040?=
 =?utf-8?B?a1FnY21IQmVzSGt1K2ExKzJPQzlKck9rcWJ1dFZlT0lZczdUbmNRWkxnZG9U?=
 =?utf-8?B?Z3JQb3g0dXdldy9DREdWa2xKcW1qN3BZMGtUbC9LM3BtZTg4UFpBS3VjUmQz?=
 =?utf-8?B?U2g3eSswK2N4NkMvV1BjWVBVK2RCS3RoVW5scVY4WGZUUFpXODFZbUVENDc3?=
 =?utf-8?B?M21OcXhGQzhscFU0cGJmRXczejJxL2F6aDJPKzA5WTRtNUt0SkRyWlFHd0Y2?=
 =?utf-8?B?QVNZOHl3Q2xNRlYrc2JQaFZjSzlIcFg0USt0UTJEM2FadStaNEtxYnQ0SXdI?=
 =?utf-8?B?QUZaK2JnOUI1OFdYaGJLUnFEdStxYmRDWTdMZVVwMDd0MGRLV0wrcjIrcTlW?=
 =?utf-8?B?YUF2RjJaZmVjLzQwQmkxWU9ZZHp3L0JCTWlEQlhuY01iLy9DWFdWTkk0N2hx?=
 =?utf-8?B?WGhrSnUwb045WTVnSGVFemJTQ2xveCtzRjBob0pPemhyZmRtNzNtS216RUF5?=
 =?utf-8?B?MTlYNXAxSU52ZkhtS3FjU3V5TXFld014K0s2WGxkNnNpTkNjZVV4ZjhGeGNO?=
 =?utf-8?B?OGoxMG5jWFJFRVFkQnArMjNYeklPb0p4bXFyRXdOSjlvV3pVeHdhUko3RkJQ?=
 =?utf-8?B?VU9GUjVjRzhwaWxRdUtKcUVrV0lUQzJJdG14SzVNdG53cWpzbGxyMk1sWmFx?=
 =?utf-8?B?NG5RNjV6T2tnNDZkU3dBOHVrSldhUEhiTmFacFRtTlZKZmI2Kzdmc0F4Q3Jo?=
 =?utf-8?B?Kzh1MWJmQ3NDVzlUVG8rYk03cVdNOS9UYXk5dnRYTEhYc2FWTUVZTnBzUHl6?=
 =?utf-8?B?K21RWGNLaSt5K2ZUc2R2b1lrTVo3SDVoaVRUT1AxUUVyVmhWVTRobGJmNUl6?=
 =?utf-8?B?Qy9SMnVSZFQxbHltVkRvaGx3eFYzRVpnL0JodUM4OW1mMVFiVGo5c0svZ01G?=
 =?utf-8?B?cURlb0VFN3k3QXBSN0JNUm9xU1Z0Y2dnUXh0NElTaWtvTlJ0bmZBNDM3OU1x?=
 =?utf-8?B?NGFXWlRNVzNXa010dFMrVlBFYXcwb1JHdmJvZ2VmYVlDL2dGcW9MWk4zMXdt?=
 =?utf-8?B?M0Z3ZkFJMmhIcVhIS0xKLzRybHJ6c2cwdlBwajIza1k4S0o1ZEdNeWlpR1Fi?=
 =?utf-8?B?dnhjcGlCWnlnNDdRRUU2YWpTdDZYSzdHZDRGMW1TbWRseWZzeExSQzlET2s0?=
 =?utf-8?B?SHVIWVdXVXI4dDgvZnYvZ1l5aCtydEo0aXRNK1BnVnltdk1hVTlBUVBvejJm?=
 =?utf-8?B?cDgxSUpPSTdLQUhvMHJTcEJNdnRUT1J3U0NOQ2lNeXFDbXUvWnUxa3lZSjY5?=
 =?utf-8?B?ZldhanlWczFkRjBXYTREQXJlWFR0Z0c2bWN1ZE42ajlNSXAvU3VvekVNamJz?=
 =?utf-8?B?VGNZd0NsNDFPQ3hJdFZ0ZlJJZVlFZUNsdVEya2wrRG5wRlJmYWJ2SXNRVkhn?=
 =?utf-8?B?Z1dpY3cyYVFIaFBMeDNEYVNmYUE1SitKVlRuQ3dmRHVZS2dvbTU2RkFXQWNI?=
 =?utf-8?B?dDRWMFB6c05hNkhxRmIydnFmWlBaRzRFNWRUM0NlYUpEMnZPeUI2Y0FPOCt0?=
 =?utf-8?B?UGFkMVpQTHgvOG9DOUlNWlhYMzZnTzBvMURsNHVvMmJEMzRWWXhIWlpkNWV2?=
 =?utf-8?B?N3RFdmc1UTlXL0hVbllnTnRzMG5oQm9SY3BRTWV1cVpvd0I4NkpiaXZEUmpm?=
 =?utf-8?B?S3FDZnNQdUxFR1pQakMvakdoemlMUlh3TVN0WjN1S29ZdVlzZ0FIemNUWkxB?=
 =?utf-8?B?VTVrRjg2eVB0WTZEQlFyd3V2VDM3OG9LQ3JvMDBOZ3NJM3BtMmpUVEJCbVB3?=
 =?utf-8?B?UFBJT2dmRG5YVEVKM3g4RnVZbXZ4RUUwc3p5WU15cXljM1pReVpPbTllNGVC?=
 =?utf-8?B?SnFnai9tcWl6eGl2K0JMekwyVk5neHpSamczcGI0MGk3QnpURjFXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606b6280-c4d7-4366-8759-08da3ef445f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 08:46:49.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGJlY1cIEhbLJRFQIYtYDxhbloNSQFreFMVhE9tkdCLwqSf74ekPVJs+WqsOG0buG8q+bgRsWiRcR3d7GfQWsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-May-22 4:51 PM, Peter Zijlstra wrote:
> On Wed, May 25, 2022 at 03:09:31PM +0530, Ravi Bangoria wrote:
>> IBS_DC_PHYSADDR provides the physical data address for the tagged load/
>> store operation. Populate perf sample physical address using it.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index b57736357e25..c719020c0e83 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -986,13 +986,35 @@ static void perf_ibs_get_data_addr(struct perf_event *event,
>>  	data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
>>  }
>>  
>> +static void perf_ibs_get_phy_addr(struct perf_event *event,
>> +				  struct perf_ibs_data *ibs_data,
>> +				  struct perf_sample_data *data)
>> +{
>> +	union perf_mem_data_src *data_src = &data->data_src;
>> +	u64 op_data3 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
>> +	u64 phy_addr_valid = op_data3 & IBS_DC_PHY_ADDR_VALID_MASK;
>> +
>> +	if (!(event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
>> +		perf_ibs_get_mem_op(op_data3, data);
>> +
>> +	if ((data_src->mem_op != PERF_MEM_OP_LOAD &&
>> +	    data_src->mem_op != PERF_MEM_OP_STORE) ||
>> +	    !phy_addr_valid) {
>> +		data->phys_addr = 0x0;
>> +		return;
>> +	}
>> +
>> +	data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
>> +}
> 
> perf_prepare_sample() will unconditionally overwrite data->phys_addr.
> There is currently no facility to let the driver set this field.

Thanks for pointing it Peter. Would you mind if I add:

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c719020c0e83..fbd1f4e94d47 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -986,6 +986,19 @@ static void perf_ibs_get_data_addr(struct perf_event *event,
        data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
 }

+/* data_src->mem_op should have been set by perf_ibs_get_phy_addr() */
+bool perf_arch_phys_addr_set(struct perf_event *event,
+                            struct perf_sample_data *data)
+{
+       union perf_mem_data_src *data_src = &data->data_src;
+
+       if (event->pmu != &perf_ibs_op.pmu)
+               return false;
+
+       return (data_src->mem_op == PERF_MEM_OP_LOAD ||
+               data_src->mem_op == PERF_MEM_OP_STORE);
+}
+
 static void perf_ibs_get_phy_addr(struct perf_event *event,
                                  struct perf_ibs_data *ibs_data,
                                  struct perf_sample_data *data)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index da759560eec5..67402af3b70f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1477,6 +1477,8 @@ extern void perf_event_task_tick(void);
 extern int perf_event_account_interrupt(struct perf_event *event);
 extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
+bool perf_arch_phys_addr_set(struct perf_event *event,
+                            struct perf_sample_data *data);
 #else /* !CONFIG_PERF_EVENTS: */
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7699be46f3a1..9baeb2d21bc0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7283,6 +7283,12 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
        return callchain ?: &__empty_callchain;
 }

+bool __weak perf_arch_phys_addr_set(struct perf_event *event,
+                                   struct perf_sample_data *data)
+{
+       return false;
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
                         struct perf_sample_data *data,
                         struct perf_event *event,
@@ -7404,8 +7410,10 @@ void perf_prepare_sample(struct perf_event_header *header,
                header->size += size;
        }

-       if (sample_type & PERF_SAMPLE_PHYS_ADDR)
+       if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
+           !perf_arch_phys_addr_set(event, data)) {
                data->phys_addr = perf_virt_to_phys(data->addr);
+       }

 #ifdef CONFIG_CGROUP_PERF
        if (sample_type & PERF_SAMPLE_CGROUP) {

Thanks,
Ravi
