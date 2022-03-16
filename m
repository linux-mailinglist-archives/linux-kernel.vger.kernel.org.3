Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADF4DAEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355220AbiCPLIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348000AbiCPLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:08:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D163BCF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw09Ai74s3l6HB+LWja0/h3d2Nh8GBIjbJEpeUSRONl0Ns2PJrZ14yZAoqCoHHCajyzhxXB6/oRXSgFkgFW34h1wE4fp+TG8oN1euTDxxkqkabMTedsgilB+iDsKhRv0Jg6sjscypKZh1WmaYDjIpJg9eTlTPDnbR6Z7+tXCzYUiCNfvwwgkFYN4Nxl3l9GiLkGRsT5q9O9hkO+zPEF3UFPc1bSqJRtL5V7nxhFi8SJvUhBH58iYHfR17jRb2PmclfndUV0GbH/3wU1zgQlfWwpsNs5cmSvSZobAet/U2rvgaUdTbPxtiSR+1swmb62Dj7oOeifMjLlLA7+XtOMpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I94o8Z4WS2/8BzQMEKJEKalgkYr2jlRSkKoOqIf+FlE=;
 b=Pf6vHW6sqMtWaUt5uJ7fCIjtmaTiEwc3+a3NwyQuoxP8hYLG1dsmFNGmnGB5j1A0SYInhqCHV7s5869oTE/C5k4zY7lB53AermLDecIeXi4SkmppOQ/QR/4UejN07Rivt6oW0mmRUboRkkwvULNJcREwpowbhkkiIEAXrnH8GINBXWezmsO8tRIy7+c4deqH4LwPIcDvrGQwRzccWCsx+OovIlKp8uq2ZPryfcy8y0bmJffscN6ikAndVC/fC1VVkJFPEquN/6kCcu6KLjRKyD6voU6IzSbmTJioMwfai81LMTOxKv8etzRU+szmLr3tlUKIOPvbSkCTEFOWhmG8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I94o8Z4WS2/8BzQMEKJEKalgkYr2jlRSkKoOqIf+FlE=;
 b=N8zZfCk2SSSRFtd2v6TYTBDOgUJK5CUA18Syr/6APZ2J0ME1DpH8liDu1/3UuPZRCaswEQpv8cyWUob9+I3VtFhaZy6+4j6/emqfrasdWZmvCK3b+Hdis7XkhZJvtFKS/2DAsaQnKWJ6RtC5gbMJnOQnVLeIU6fwtbNK9otbCsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3051.namprd12.prod.outlook.com (2603:10b6:5:119::29)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 11:07:20 +0000
Received: from DM6PR12MB3051.namprd12.prod.outlook.com
 ([fe80::7166:2b70:c084:359f]) by DM6PR12MB3051.namprd12.prod.outlook.com
 ([fe80::7166:2b70:c084:359f%4]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 11:07:20 +0000
Message-ID: <d32a5a9f-f634-ea3e-d68e-b07c9bab9add@amd.com>
Date:   Wed, 16 Mar 2022 16:37:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-11-eranian@google.com>
 <aa641092-98e6-114d-b423-13e0bff248fa@amd.com>
 <CABPqkBQZRVqWPFG0Dvc6HGxNcDDb0raaRw4Ur27CvR5O8vwALg@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CABPqkBQZRVqWPFG0Dvc6HGxNcDDb0raaRw4Ur27CvR5O8vwALg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::20) To DM6PR12MB3051.namprd12.prod.outlook.com
 (2603:10b6:5:119::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea82f60-bab7-4113-cf09-08da073d2390
X-MS-TrafficTypeDiagnostic: CH0PR12MB5203:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52034467C7327EF34B6B70EFE0119@CH0PR12MB5203.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WC9TlcS3Qe3AQwvqvltAbqg1+fKZItd0+VbKfUlH8NHR5DTogBjtinyY7RrpTA1aAT6xf3V1rxYDAgA9/7sxW0feMyJErVmBll4N7Dr0d7+AYkM2614q2uEFSE7fT2GL2hfs3PPMfVOmf6dwI+zDfpMzgf+B8bTGquRjT7lQZkXlla8VMv8fPsKCFIJfXBA9dzvTm3FCIvdIIh8ybCE/U15xjrbpxAEf7pkJJh98GxCSwFb8WoffdKVIMypNgaVqqv5jNfxM5TTpfPYzIr/QtwTsOcNTXoRDOV6ZsDGrYRKSYG0C2BlxlI/ETOUNEP5lnuSgJdeXHr8zUmBNRJuSp/xLUUDibnFUzPuvmXJ5jWod1uHF1+MsYaNuq6mDb20SNxWBcYtOrtpQthJ/qLxCtlAD3WnAqYJfVEJbdTspjEGB7xYgbLpiMVA8R82n+PHWtlNeGf4JkIDISjDPynwhKPt9Wyoz82Hs/unHPwOsgigBvIBtMhUw24IMM5Qgw0uwmSnuPLNBqwCuXw7bfNX5GaSLBBwQT1VoJJCtAEbc0wNp+DaG2p+N/F3E6pL4P4068X3Ihm4mvOuW1YMIJbJiiMLBBTEkUPc4XLqlLbSPtrdKqRW850uzz2j6N11lZyss1a1NYbvTahWBI/h9hdf0fNneRz462A2ct4tpPqG0yMHA00i13YI1PxScUbQwoCO4uobs5O54Sa3DtIlbRHS3MNSv9VJysrTfDSEdp7rZqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(38100700002)(83380400001)(6512007)(2616005)(186003)(26005)(31696002)(508600001)(6486002)(6506007)(86362001)(53546011)(6666004)(2906002)(36756003)(31686004)(4326008)(66476007)(8676002)(66556008)(66946007)(5660300002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVQ2bFJyQnQ3WFJRVS8vYm5HNlh1Tmh0OVBXMU1nMjdjMGJYSzBua3VYb1pK?=
 =?utf-8?B?bkt1M3RxWXBvSnZxUExjVnpXVFNCakFYVkxUSEtnam5QbUd3a1ZkOFRJa0x1?=
 =?utf-8?B?YXF0eVJiSDdBL2hRWGQrKzJXdlBiaWVBbFVXTzlPVmRyMW11VEpnbVFkcHJD?=
 =?utf-8?B?aE5rcm9xbnMvdE83Q1BJS2pIN1pUNWl3aTNXVTZkcHp6b0JkOVh1Y01sbmR1?=
 =?utf-8?B?K0QySVRRZ3JjOGZEa0VFeUE0SnVyNHA2OHQ5ZXVzU2NkdERWMmJac2NBUmlo?=
 =?utf-8?B?L3hmZzJDMXR5VTh3c0hyMnNVT2oza3JmSFcxVWFZK1F4bUMyN1VBZUY1Vklv?=
 =?utf-8?B?RlNtMStEdnZXb0QzUUJmM2RBVldwam1USUZMNHVTWWpMSlQxMjdSUXo2OFNE?=
 =?utf-8?B?dVVwVU83aDNlbWpiMDNUdFdUREVFV0FlNkZRTW9zVXNIeEZibXpZeXJ5YXE1?=
 =?utf-8?B?ODlld1VzbW55NTNwR0hPeW00S29NblpuR2I0NE9zYy9jaFB6Nkd2V0VLYVhS?=
 =?utf-8?B?RkFWbEp1SDFIN0N5bTB4R2pqcU03clpSdEowZWFXWmQwQUY0MWtyR3dXME96?=
 =?utf-8?B?WDFreUp0RlIrQkE3YVZiNXgxQVZJSDlEb1pHRSt5eStGNTllWUgyZnZXbUQz?=
 =?utf-8?B?a2owUzdvOFQxNmZXNmQ1amVNWm96bjlwelU3ZnJEQU9VV2V5L3NucFIyUXE5?=
 =?utf-8?B?Y1kxanZkVC91UFFqTVIvYXpZZkllS0ZqUlRBSG12dEYyUDR3amxyK1hDSUs0?=
 =?utf-8?B?ZWZTRTkrcEV6NlhoZkZoeTVYK2lrQnQzMFdjTTZkc21ZNnFyZHpBZHc1ODho?=
 =?utf-8?B?OWtHc0dvOExhSEg4Z1NFOWdEZXpHcEJ2WU90OWp1NThmT3ZQWnIwM1g4UkxY?=
 =?utf-8?B?RkdFTmIyL2lhekUxcW8vWmpjUFFVZU9MZk9ybEV6MVpLWjRHVHNsUWp6YUNm?=
 =?utf-8?B?bDcreUpZVDAxdWlNZllzR2sydWFnTGV0aHRDUFI2WmNMSXJoOE9YUERwenla?=
 =?utf-8?B?VFJNNFVaZzdsMXljeUZUTUlYRjJzVlc0MDlKZ2pZeW5RN1VaK1FTZTNaSHNz?=
 =?utf-8?B?V1VxRW04WTlBekNpcDZFSkpzTVRFREZrQnp3NXA1OVJMamtRcmxHWGVqVzg0?=
 =?utf-8?B?eTUyZC90RG5URy93ajBqa1NSQjcySS9WRk5tUHZHak1VVitzTlJrOUNpL0V2?=
 =?utf-8?B?eHlGZjc3UllKWW9teFJrbDZXZjRKOFIxSnY0eGxZVXBuWEFJWWdQaDZiVEdJ?=
 =?utf-8?B?RWF2Q2w3b1gzVC9RekcyQitDYldNR0MrTkgrRTh0SnlCQlI1UExlcG1UaWdz?=
 =?utf-8?B?dGdOcVlYTnNoZHYraHNIMzVDZWhxWUNhNGE3b2pRaitYdFhQenJ1a2h3NTJC?=
 =?utf-8?B?V054VXZOV3VydHVRYVJmWTEzK2pJMnlieGxENUlIcXNtMWl6NFcvRHJ1TlV3?=
 =?utf-8?B?VWVYbTNZUVUzVC84UlZtT3o0aUg5V1RlMnA2Q2J3d0xKZHJzeXkrREp1SzJq?=
 =?utf-8?B?K1A3a2h4UlZkays3bVFUSUlEYWkzN1YvZjFPYkUxZ2NKR1U5RjI2LzNsQXBF?=
 =?utf-8?B?TE03WDNGOHdaayt1TG9yS2xXV2JVbHFjcHhHN1RtYUdCTnc5MlJmR0MrbHJP?=
 =?utf-8?B?Vkh4QmsvRnZWbkIrTW1pblVINGpkUVdqQmtLc1Vrckx5aDJIQzJBTm5PRUZP?=
 =?utf-8?B?bHVRNUFhZklhcUs1dElRSmpLN0VkSVdJbUxNZGREMmIyTTBOUW9KNEo5bFJH?=
 =?utf-8?B?TjFCWlNoWkMxdndudFFNeDh4b1pZcVovRjAxNGN4cWFhSlRlWU9SejhFL0V1?=
 =?utf-8?B?ZXJrdEtFMm5telRMdlJISjhIS04yUUszeXFpMlQ2L0ZxdUMrMmNoS0ZxSWk3?=
 =?utf-8?B?bGxaaFBtRzZVZU0yRDNReU9JMEhpdkxmRlA3NEhMT21SN2NtTG95VU53UzJ1?=
 =?utf-8?Q?0gFmISKcDlN5Ek/DInXfZznM9BkeZ2SS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea82f60-bab7-4113-cf09-08da073d2390
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 11:07:20.4313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CB3LzGd8NaY3CLNxCIDR007PPoSnEtgHlLkRsFjiHOnYICFYUBTVBOaNhatstO9yByu5Z/0KR0afPgAtKXRb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane,

On 16-Mar-22 5:33 AM, Stephane Eranian wrote:
> On Tue, Mar 15, 2022 at 12:46 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Stephane,
>>
>> On 09-Feb-22 2:46 AM, Stephane Eranian wrote:
>>> From: Kim Phillips <kim.phillips@amd.com>
>>>
>>> improve the error message returned on failed perf_event_open() on AMD when
>>> using IBS.
>>>
>>> Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
>>>
>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
>>> /bin/dmesg | grep -i perf may provide additional information.
>>>
>>> Output after:
>>>
>>> AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.
>>>
>>> Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:
>>>
>>> Error:
>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
>>> /bin/dmesg | grep -i perf may provide additional information.
>>>
>>> Output after:
>>>
>>> Error:
>>> AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity
>>
>> This patch seems to be causing regression to perf python test.
>>
>> Without this patch:
>>
>>   $ sudo ./perf test -vvv 19
>>    19: 'import perf' in python                                         :
>>   --- start ---
>>   test child forked, pid 145391
>>   python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
>>   test child finished with 0
>>   ---- end ----
>>   'import perf' in python: Ok
>>
>> With this patch:
>>
>>   $ sudo ./perf test -vvv 19
>>    19: 'import perf' in python                                         :
>>   --- start ---
>>   test child forked, pid 144415
>>   python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
>>   Traceback (most recent call last):
>>     File "<stdin>", line 1, in <module>
>>   ImportError: python/perf.so: undefined symbol: perf_env__cpuid
>>   test child finished with -1
>>   ---- end ----
>>   'import perf' in python: FAILED!
>>
> 
> The fix I sent you is just to prevent a potential SEGFAULT in
> is_amd_ibs(). I bet the test fails some perf_event_open()
> and ends up in strerror function and from there I don't see how the
> patch could impact the test, given you'd segfault
> otherwise.
> 
> I tried on my side and with or without this patch this test fails. I
> think this looks like an unrelated issue.

That's strange. IIUC, python/perf.so needs to know about util/evsel.c
which can be done by adding an entry in util/python-ext-sources.

In any case, do we really need this patch now? For both the example given
in description, I see no difference with or without patch:

Without patch:

  $ sudo ./perf record -e ibs_op// true
  Error:
  Invalid event (ibs_op//) in per-thread mode, enable system wide with '-a'.

  $ ./perf record -e ibs_op// true
  Error:
  Invalid event (ibs_op//u) in per-thread mode, enable system wide with '-a'.

Same o/p with the patch as well.

Thanks,
Ravi
