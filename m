Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA385876FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiHBGKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiHBGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:10:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A26321
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df7OOeRf2E5iLYYa4Axtn6GvHhL9IfuMO++shrFO5QQ1+lEP2XXGTm9wNWMKcTEbs+bkU42bWvcdp8AztlCcghI5qXNG3G8skRd2L1lcUCPW2q4+FlWueK6lQFsHvZGBnZ6UHkjoBi7HL3IT9v7zuitIHpxpCXQl521owWJXzwyqkUabuxPCJHKAqIzRVmKwNbY9GFhDhdiivo/T4KbMCegWQroEzZatg/ErcG8OENVL6HaJbSFmo3XZzbZrpV53LvBAmAuZ3d/Tn4IB6PgIJZRsCmEXUk5yaUMzmqEMyi2W4VE3KbCmizRS8/gNCkjDU2oDfWTpYNt5014THoDCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc/34UIQVFBImIo5M8hbAFTVF/3Sdbxm5PKwkP4HICo=;
 b=FWOjQXxK0JKbSvzrJWoWmhkf/GsM98ohDb8GNumQCV1qPTYiXK3Utr1smyp184zBHiPfmj3l8ra3j9uVKPYgLt7xtThQEUvBvCmxYaneipdJ50kUs1gXfubwJlhODVrrXuzoYOujAiluVelbJmRMTMv5vyvnHyIyVO5rUXOeKZvdkh2t4nMbhinIQTLV2FljHpZoqvOD4LzojhMGeiQtjmmXoq6iK0e4g8awMGNVXjOEh2vDGXC1WWPUg+GnobQ5DVS/PYr3/Ksfj1v29l0Ra7H0c6eXoQKJePTsuGd3pTdA+NAISAx49us152FN/7ELUIViRMyyC/O62lV9+9bGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc/34UIQVFBImIo5M8hbAFTVF/3Sdbxm5PKwkP4HICo=;
 b=fUHbyoW9AlSmk+rnKlgLM5zoywN4Kd0Z8uRXhBcIBOrjhkxpsO2oJ0q3N2PHr0hTKYXeLlCP89iWS1ri0kGAf++ArevOrIm8ulW3nsdezoPJSU1Vwj72QkRQlKGZQyBDRs3B0ugA5Z0ng6hEnzYAyJJ3gs1U/Ttl7yCsXUSo2v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:10:49 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 06:10:49 +0000
Message-ID: <35394cb7-a490-5aeb-b3a8-0f46e3c8ca28@amd.com>
Date:   Tue, 2 Aug 2022 11:40:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC v2] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdP4NExuwOHdC0G@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YqdP4NExuwOHdC0G@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c57023-ebb3-4a4a-b37c-08da744dbeef
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWh7Tq7glQMkk6LpoaZfr8hFGLinslpsNNlimF7zVH7LEt5jkTnRwLpfgdw6la63bqkDssX8eCBBBm7QeY745/PSr9yqeQyN3vWGcxHWLfwARk5XdJtZK7pzhbpsS7r18mxPBD6Dvmgv/VY4Yvx6XUKPi3uZC2AxY5hoV/uKUzS2F3CYbbEwEJ3VLmV6Q5zhtc3rXO6KyHGVjk9c3JJKKl0mf7yhIlK+qKS3m0ukiXSlv+5uFq91lCavnCuQkDSD09aq6h4zpPrQdNxtdNoICvbtgdi5qYEs63lAqW0oMNXL1Uw0YrIWvmAWk/DibKD8Qm+lBwWCMw00SDpoBEbz6wtRMn0LjEZBhfDX3gKHa2puGCYUEXocKa3xaWR/KTeOPzxuQxbHagonjTOSloJAssZTHFj/wNqdnAuhDx0bhQng7ImnZsasmk8hsYYWF+0MVIc4OdCGN31BI3n494OguC/UOtwI6AFuFp3dux49l8MnbjFY9Ijy49ilzlSeCTgfDMFMBj2PAyNr39Bt5SgEPOJbiF3k4CF/obrcGSfM6MEZyClhvGQrACOYdhbOgjaLSRsPROa1aFFSg17bA3vMrqubVqsVClOnDHZ/BQQsfYT29ml0lrann+0HHCuC5kpUWesRnZoYWbiDtcyrBGOtJmSp7TcK62YckzeR+3nDar0XzSfmKFhFWXw2AG0m1XyLjg4yrhjQin53xI+XaeGTC2UDs9xpr01bbMfHXd+Q+wZf4xFnVh9aana0ttgOfsmIMSastZDZaDsp2WrgRneXMKGaduNY74IwnTyc6roKDeuhbbEp+jOkklW0vHnCZUDQqirDDMnjvbMSxqxEJW4drjlzVe7Du6fXWxQhqy/3CoAlccRK9jOF6RRZJ9kHdCjz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(53546011)(6512007)(26005)(6506007)(31696002)(6666004)(41300700001)(86362001)(6916009)(316002)(6486002)(966005)(478600001)(38100700002)(2616005)(186003)(83380400001)(2906002)(66946007)(66556008)(8676002)(4326008)(66476007)(8936002)(44832011)(31686004)(5660300002)(7416002)(36756003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJQWVVGTDBiRjhLQ2cxMlVKdGErcUVDTzl0TC9NQkI3UDVFN3FHZy8yU0hJ?=
 =?utf-8?B?d1owMEp2NTJlb0VpeTFvS0NwSUk2SitpL0pnMGtRYys0Sktzd0NsVkU5U3hw?=
 =?utf-8?B?UFUvZno3LzJCOXJBUXRjS2IwOFVJTHBBa0hDOFBZaWtxT0ZoU0FCVDU5Mmkx?=
 =?utf-8?B?NXcyMWhLVmdCaHY5V1ZNanRKQ1lIVW5ZTEF4dWhIaFVwOElRdUpkeXp6MkRV?=
 =?utf-8?B?L1lITDFYTnp0TUJSRC9NUFhZdmZ2c2ZKN3djVnp3MEgxU3pxUWNPd1l5ZEF4?=
 =?utf-8?B?a2tqZGJucTlyOFQ4cmxWNzlzaUM2QmVSQm1ITlhBRWZER0lWUGNFb1U3bkRP?=
 =?utf-8?B?bXUrTmxBVEJ2angzdTgrbHFhcGowMG5adUp0YzhHNlAzdjN1MFh3WTBUY2FL?=
 =?utf-8?B?Y2puaEUwNW1Gb3hJN0hTekszZTl1UzdpNThISmV2OHR6N3NYRkoyZTF0dFRr?=
 =?utf-8?B?dXJPZ0llMlpKaFVLS0RIek1FSVZXbHNsTVFFT1JPeWxlZStBQTdqaFJMNVJI?=
 =?utf-8?B?YStabHc5QWlORkhFYk13R3JFQmZwUkxWcys5SThaZ2Fsa1F1cU11VHh3MThS?=
 =?utf-8?B?U1lhTno4eDJFVU15UlJZSFlmNEYwbnVIZlU5NEcvMm1jblZGQ1JlSzNHNmlx?=
 =?utf-8?B?b1pSd2xGZE1ZSVdoeUNrcENtOTZqQmhlT015a2ZXWHRVVVZ4ZkFsOS84SU5O?=
 =?utf-8?B?bURkWkFqNFI3WGY1bzVBbDdQUENGdklQS0ZOWDY2UXlBUXc4ZzBoZ2lwcFJT?=
 =?utf-8?B?b1JnSjhqdUJPWTNDYUcySDRyV2sxcW42Z21uZHVta29pZWlGMXE1UmpZc2lr?=
 =?utf-8?B?MVFiM3BQUVUxREwvZnhxeVRPK0xvVnpMaEhwMVdJeU9GQVFLM2tqSmpqeUgy?=
 =?utf-8?B?V3FQMFBpZ0FKMExHbmg3eHFCMWxiRk54aUZOSVpmeTlSTHZ0U3dhN1JSZXNx?=
 =?utf-8?B?dXFIbzJDb204a01vbWxocmM1WGU4RStJMXhkK3cvMHZuVTRIaDlLcUJ0azJk?=
 =?utf-8?B?MURMaTRjS2NaSUdSVGFrNjZpRGdUdmN0MmM4dTNkSlVhT3FlMmlFakdhK0gw?=
 =?utf-8?B?d0pZaExNdEJ3Z1FudGNYd3dLeVI1alNZNGZtcytsb1JuZWFnejN2ajBMaW9n?=
 =?utf-8?B?czVoR3lNQUptK0c5M3ErSkZFNEpHcldFUWNRS3llWE1BUVZaeDRQS3VmU2Rj?=
 =?utf-8?B?bW5Ha09xbHlXc2VUN0hxYmxCUGtZTnc5RldiQno4b3c3RGl6Q2hFbi9YenF4?=
 =?utf-8?B?N25vcjdDalZ4b0JCQjFVQzN1MTlSOUFXdWt4REpUSlVyTWlneHJ5czVTQVBR?=
 =?utf-8?B?QmRPVlBQcG5UcDJZU2N2T0hUSXdkNXNGRE9odmQ5QWVCejQ4WUhJNEtHYjYv?=
 =?utf-8?B?aUxGWlJVMHluaUpOaWdnQUIwVXdnbGI0WkNyL3k3V2g4VzZURlRUOXhDZjNv?=
 =?utf-8?B?T05CT1YyM1FEZHMxWGxjUEYyWVYxaG9MeEpnWUpWVUM1cTJHWFZWc2s3SmpV?=
 =?utf-8?B?VTFuNVVBS2VwdVR0THB2TmljRThBYm1xbHk1QWNGT0xiUkkyakJKNlZZS1Nv?=
 =?utf-8?B?ZUpxTUpYR2Q0SkxhUjhRVm5jWGFvdUpMdERZb1ljdEU3bkcwOW5teFZBaGZk?=
 =?utf-8?B?b3c2aXB3ZVJJZ0sxR09xbzB4MzBEQjMwYm42ajYzYmpjN2JVNGpZTWJEL3Np?=
 =?utf-8?B?ZDU2RU9IcVFuWFdlb0FyYTdGQlZlZktIaDAwYmxZb0dUM0dsNDZpSEx0TW1z?=
 =?utf-8?B?eFFmbDFPbkxFYVZXR3BHQkdyM01PRjlIbXk4MmZEeFEvdmxLMFh4Y3FyQ1U1?=
 =?utf-8?B?Qmw5Q0Fwc2NIUStpZnNMM0hxOVZvMml2c0lnS3hYRE9PQ2dreDlQQ0lVWGR5?=
 =?utf-8?B?SEtEaGhYZk5iNW9peDhRQiszZTVwQWNaQk1lZW1BY0NqMWhHdDM0KzE0ZWM4?=
 =?utf-8?B?QlJZdm5KTENYaWUvSWxoOXZhTkp2U0g1czczcmpVbzhpaDhGR25OaTRZdXpW?=
 =?utf-8?B?elhuSXFES05TcTduNG9GNEVGZmNnakZlSmkwWldVZytsaW94UUFNRk5UK2JN?=
 =?utf-8?B?Z2VqSGZwbUVwVzBhaDBFOXJsSVV5S2pSdllNbU0rS2xFZDM2UmFnMkx4S1M3?=
 =?utf-8?Q?sC/YT+oyor2xzBaNBaqO7ZQG4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c57023-ebb3-4a4a-b37c-08da744dbeef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:10:49.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFJXIi8fT1IsZckgxW3Y7SDhVOu5fElDdJDu2SGBNv93z7ggHZherlE9YTS8UDj0OowbWlgwRhc618d6fo3TQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Jun-22 8:25 PM, Peter Zijlstra wrote:
> On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
>> @@ -12125,6 +12232,8 @@ SYSCALL_DEFINE5(perf_event_open,
>>  		goto err_task;
>>  	}
>>  
>> +	// XXX premature; what if this is allowed, but we get moved to a PMU
>> +	// that doesn't have this.
>>  	if (is_sampling_event(event)) {
>>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>>  			err = -EOPNOTSUPP;
> 
> No; this really should be against the event's native PMU. If the event
> can't natively sample, it can't sample when placed in another group
> either.

Right. But IIUC, the question was, would there be any issue if we allow
grouping of perf_sw_context sampling event as group leader and
perf_{hw|invalid}_context counting event as group member. I think no. It
should just work fine. And, there could be real usecases of it as you
described in one old thread[1].

TL;DR

Although I can't find any such pmu combination on AMD(not considering real
sw pmus), I just tried opposite scenario:

    Group leader: msr/tsc/ as counting event (perf_sw_context)
    Group member: ibs_op/cnt_ctl=1/ as sampling event (perf_invalid_context)

And a simple test program seems to work fine:

  #include <unistd.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <errno.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <string.h>
  #include <linux/perf_event.h>
  #include <sys/types.h>
  #include <sys/mman.h>
  #include <sys/syscall.h>
  #include <sys/ioctl.h>
  
  #define PAGE_SIZE               sysconf(_SC_PAGESIZE)
  
  #define PERF_MMAP_DATA_PAGES    256
  #define PERF_MMAP_DATA_SIZE     (PERF_MMAP_DATA_PAGES * PAGE_SIZE)
  #define PERF_MMAP_DATA_MASK     (PERF_MMAP_DATA_SIZE - 1)
  #define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
  #define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * PAGE_SIZE)
  
  #define rmb()   asm volatile("lfence":::"memory")
  
  struct perf_event {
          int fd;
          void *p;
  };
  
  static int perf_event_open(struct perf_event_attr *attr, pid_t pid,
                             int cpu, int group_fd, unsigned long flags)
  {
          int fd = syscall(__NR_perf_event_open, attr, pid, cpu,
                          group_fd, flags);
          if (fd < 0)
                  perror("perf_event_open() failed.");
          return fd;
  }
  
  static void *perf_event_mmap(int fd)
  {
          void *p = mmap(NULL, PERF_MMAP_TOTAL_SIZE,
                          PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
          if (p == MAP_FAILED)
                  perror("mmap() failed.");
          return p;
  }
  
  static void
  copy_event_data(void *src, unsigned long offset, void *dest, size_t size)
  {
          size_t chunk1_size, chunk2_size;
  
          if ((offset + size) < PERF_MMAP_DATA_SIZE) {
                  memcpy(dest, src + offset, size);
          } else {
                  chunk1_size = PERF_MMAP_DATA_SIZE - offset;
                  chunk2_size = size - chunk1_size;
  
                  memcpy(dest, src + offset, chunk1_size);
                  memcpy(dest + chunk1_size, src, chunk2_size);
          }
  }
  
  static int mmap_read(struct perf_event_mmap_page *p, void *dest, size_t size)
  {
          void *base;
          unsigned long data_tail, data_head;
  
          /* Casting to (void *) is needed. */
          base = (void *)p + PAGE_SIZE;
  
          data_head = p->data_head;
          rmb();
          data_tail = p->data_tail;
  
          if ((data_head - data_tail) < size)
                  return -1;
  
          data_tail &= PERF_MMAP_DATA_MASK;
          copy_event_data(base, data_tail, dest, size);
          p->data_tail += size;
          return 0;
  }
  
  static void mmap_skip(struct perf_event_mmap_page *p, size_t size)
  {
          int data_head = p->data_head;
  
          rmb();
  
          if ((p->data_tail + size) > data_head)
                  p->data_tail = data_head;
          else
                  p->data_tail += size;
  }
  
  static void perf_read_event_details(struct perf_event_mmap_page *p)
  {
          struct perf_event_header hdr;
          unsigned int pid, tid;
  
          /*
           * PERF_RECORD_SAMPLE:
           * struct {
           *     struct perf_event_header hdr;
           *     u32 pid;                         // PERF_SAMPLE_TID
           *     u32 tid;                         // PERF_SAMPLE_TID
           * };
           */
          while(1) {
                  if (mmap_read(p, &hdr, sizeof(hdr)))
                          return;
  
                  if (hdr.type == PERF_RECORD_SAMPLE) {
                          if (mmap_read(p, &pid, sizeof(pid)))
                                  perror("Error reading pid.");
  
                          if (mmap_read(p, &tid, sizeof(tid)))
                                  perror("Error reading tid.");
  
                          printf("pid: %d, tid: %d\n", pid, tid);
                  } else {
                          mmap_skip(p, hdr.size - sizeof(hdr));
                  }
          }
  }
  
  int main(int argc, char *argv[])
  {
          struct perf_event_attr attr;
          struct perf_event events[2];
          int i;
          long long count1, count2;
  
          memset(&attr, 0, sizeof(struct perf_event_attr));
          attr.size = sizeof(struct perf_event_attr);
  
          attr.type = 16; /* /sys/bus/event_source/devices/msr/type */
          attr.config = 0x0; /* /sys/bus/event_source/devices/msr/events/tsc */
          attr.disabled = 1;
          events[0].fd = perf_event_open(&attr, -1, 0, -1, 0);
  
          attr.type = 9; /* /sys/bus/event_source/devices/ibs_op/type */
          attr.config = (0x1 << 19); /* /sys/bus/event_source/devices/ibs_op/format/cnt_ctl */
          attr.disabled = 1;
          /* perf_read_event_details() can parse PERF_SAMPLE_TID only */
          attr.sample_type = PERF_SAMPLE_TID;
          attr.sample_period = 10000000;
          events[1].fd = perf_event_open(&attr, -1, 0, events[0].fd, 0);
          events[1].p = perf_event_mmap(events[1].fd);
  
          ioctl(events[0].fd, PERF_EVENT_IOC_RESET, 0);
          ioctl(events[1].fd, PERF_EVENT_IOC_RESET, 0);
          ioctl(events[0].fd, PERF_EVENT_IOC_ENABLE, 0);
          ioctl(events[1].fd, PERF_EVENT_IOC_ENABLE, 0);
  
          i = 5;
          while(i--) {
                  sleep(1);
                  read(events[0].fd, &count1, sizeof(long long));
                  read(events[1].fd, &count2, sizeof(long long));
                  perf_read_event_details(events[1].p);
                  ioctl(events[0].fd, PERF_EVENT_IOC_RESET, 0);
                  ioctl(events[1].fd, PERF_EVENT_IOC_RESET, 0);
  
                  printf("%lld, %lld\n", count1, count2);
          }
  
          close(events[1].fd);
          close(events[0].fd);
  }

Example run:

  [term1~]$ taskset -c 0 top

  [term2~]$ pgrep top
  85747

  [term2~]$ sudo ./perf-group-sample-count
  1996319080, 0
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 0, tid: 0
  1996510960, 150000000
  1996325400, 0
  1996348600, 0
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 85747, tid: 85747
  pid: 0, tid: 0
  1996341420, 130000000

Thanks,
Ravi

[1] https://lore.kernel.org/all/20150204125954.GL21418@twins.programming.kicks-ass.net
