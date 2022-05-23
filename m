Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3EF530E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiEWKdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiEWKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:33:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2069.outbound.protection.outlook.com [40.107.101.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D948D85
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/PlkYyE48kqrMQ28TwmeBg8Aw44VS3FlREbx5/FAwdU9O/k/KvOER6YqrBDAOHwShzPONlSXE0dzS8eSfQUkIzklQ/LPCakeRGjDY4gCT6phwWJixwG67dlV0wW0ZAn7qPpGVqzlMO/z+ZJWMLgQ+W4wgIosp2Zz7AKFbOyhZWXtdeynkcuQItRqv5xRzHRWK0gYMJ2PQCVnU0XwFfuM3ms6MPPObP0sy0olOFkQ0jw6RFW7DdW62j6vn1e6H8UetTyTkb3vIm8d1lCpuRkenThyelX1VUPHqL4PN+JwW7WdQErFnzfFDrj7wgvB5ulTA2r72e5zP2xVYIbA3guig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWQ6DSNTWsUA2OC/91xu4XKfLtvCVB5UGZPXgR04srk=;
 b=ZYXCJhQ4EM/8/YqRte7zQQt3yB/nlXhoqq04b4cE1rip5q9Ic/mr51UiKSiguMzJN/BA4qsmWvTPubzzcResVcWhqcx5aycZvuFipG53eGe9kTfbDGUHdSqeEQJyFo6RBkTD+zsixMQioMpY4ppX+0hQbR3yO9kBcQuc4f0rtd1ECKj1fwmGLpZbvuYu0Lb2onkAkNSwJPpX0ozD3zJJjHDEvVrbVNm653HTn6s8jUNo/QEiByA20FBaFQRL1F7EUPa8QswmbhEn2fGpNWdfx5ZBp4I8M9t+OXyz9tmKHGAnZDGFViye3jmPyDtDMVWlh2vf4KX56w1GUJr2o+TtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWQ6DSNTWsUA2OC/91xu4XKfLtvCVB5UGZPXgR04srk=;
 b=T7JwecbE3Hnfdw/2T2gIvKUX9B3NZjIxvtXcmD1bsjaXTgLk90o0zAW/8/Cb5PK1OnMvPM+Meihvjd2mMPxKNRtOlPFkC33bxnAqaR8V0IKpguqQXxnLxik92iZLNOm1Hwp4+FnCbRIU9NxxvLj+rW7a4mkXkA1YWvgdyMTDFpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL0PR12MB4658.namprd12.prod.outlook.com (2603:10b6:207:32::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.20; Mon, 23 May
 2022 10:33:38 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 10:33:38 +0000
Message-ID: <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com>
Date:   Mon, 23 May 2022 16:03:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     nslusarek@gmx.net, Linus Torvalds <torvalds@linux-foundation.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d662bf6-fa30-4d3a-d486-08da3ca7b2cc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4658:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4658A8421D520D1066B92CCCE0D49@BL0PR12MB4658.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJf1ddkP49oO2e9bLSCL3DV90pM+INB4HdtOkfbElWPJVp16Jt5VPBO6NSq+ijk23ga6VhmgpFxjfHOaUIZRG4CBo+oXVOqKWZVxqaahjbwmCxwq3f/zdNjMu7ceBOWrCbVAoHhTmtZ05dx/y5X07vp1sgnGqEQGIAcsK/NFBS0UadjauaMkCo/XaUHNkaknLFwAu4nNgh9Xz8XNEASzR4PXgyMHLVYpYIMs3OWGHLOGZ6MrtHV9GUr4mZYF3PYshryISwlJ0vhudVgWtVK/HOw3TNblaLnWk4vnX+kRy5JsFI1c1lc1on1BjIKJVR6wdgqXaX+TGFzQFLZPDWp8xb+sxRRTeYaMwpzKvyV12CZBxPpTs21e7KfCDsm5b3ysFvGoRWKq+IZLTb0ZUdMBKkZ8SXLMoYeaN/6G1pSdji2EmfEF1l5+HPIWcG2JzzFFzn/fTwSpWJT4kcF4amccrus2FaJbSlAdBCDNZR14BW46kFutN3DMMCNS6fSr7gGMtpE+RB8tAPA9ArnFLctHNhCvCIGSLFEPTVdjs3yVBc6tk8hJ7lvieePZznUYEFK3KISzKapar5Jr8UGlA+GUJvJHG7Fe9uLKexNfTSd9u+90FKYRjnrxOkL/PWyegfnw21odQ1koaFNfcFrYyj3coNNabliMeQSxySmFLhmfloeg4lcPFl9L3bLRtoD4KJt7psq//w7l+hMODiJ6HPCcRwSpXc4vG6ezPkTdKItVC6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(36756003)(316002)(44832011)(6666004)(8936002)(6486002)(508600001)(53546011)(31686004)(8676002)(4326008)(83380400001)(86362001)(66556008)(186003)(38100700002)(26005)(2616005)(31696002)(6916009)(54906003)(66946007)(66476007)(6506007)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxJYnowelQ3OXkyWnZyT3BRS0JXY2RNSjlGdk9oTUp4SldTN2ZMLy9odDR0?=
 =?utf-8?B?YmFNRHdLd29LTlJ5ZTRPTjZvSGRPeHlvT1lKOGdGa2ZITTdxcnpWK2lVV0tE?=
 =?utf-8?B?RjRGN1BWTzdxWlVUV0R5RCtRcGlncTJZVEJyNlNvckV3Zk5oOVhJSDkxNG1G?=
 =?utf-8?B?NVdlVmp0bFB4bXhDYUVNR3FZcUJnMFpOVjFnNXBGOTc2WHI3dmYxWWhTSm5M?=
 =?utf-8?B?Z0U0dzhOUHQrRWozSDRwcGRjUVpFOFd3WTNReDBNS2p4MmJSZmJwRk9KbnI3?=
 =?utf-8?B?Z29YMWZBNjFkeHN3WVMxUFBjQW5xeXNvcHJMamNDUThxS3cvVE5ZMHdiOGJj?=
 =?utf-8?B?bG5lRUludVJUWUttcUt1MzdlTEpUU1JFdk16bmRodWhINTdhd244SmtkUTZ4?=
 =?utf-8?B?OGhhMC9DaStTbk52dFpaY2creURsWTltWEtoSkNsRDM4VEM1TTVXN3NlaU1a?=
 =?utf-8?B?VFZBenNXTXBvQkZjTlY1b2NrQXYzUWlWSzFLR1pqc0orNUg0aFNtenZZRzhm?=
 =?utf-8?B?SUFVMFpvREcyb0tYV3RkcnJhYkRZUkVMRk4raGNHbFhTQjJGQ3BQa0hjTHlu?=
 =?utf-8?B?c21iRFZnbkNla1l6UlBQYjVrOHVWU1VtbzdhNXdzcW4za1JEMDMvbEJnTlRu?=
 =?utf-8?B?a3FEVVVQanNrZXlvTmlSZmNyeWlEV1VVUWFYcmJvbjlWL1JoVXkxWERvZXpl?=
 =?utf-8?B?WUNBaEpnd3IyWW9KT1o5Mk8wd09vTU82Y3lvWEswaTNVdTJxZHc2bnl6UnBK?=
 =?utf-8?B?U1BhYmVmbjBFalVHaUxxT21aRWFXd1BIS0p1L05SeHUxUi9TSldSZEIwd25C?=
 =?utf-8?B?TE9idEJ2WklBNG1LTWR4aGM3QlRic2dBYzFjN21UQ09ZQWR5TE1oTEw0TjBv?=
 =?utf-8?B?TWxWNzhYVmhZV3o5SDNiU2ZjSGZmU214Sk80NWJ2RVRYbGo1bmZnQTRmZ2pi?=
 =?utf-8?B?Z0VzYmM5VklCK09xcHVyNlRCR3g5MG1jVTBnNnRKUDVDWXRkR2tjSzBzcGxD?=
 =?utf-8?B?dEtCbXJSaVM0RktPVGpjaVpsUmVvYU5nKzZyelpLWStsOE9tRVYwaFpscDZK?=
 =?utf-8?B?TXRrYjhhUkZsSTRHMVRoMld5YjNBdS9DWkpCVXU3VHNKYjlRajQwWDBGRzlG?=
 =?utf-8?B?dzE0YkpUTkg5TFJ1RXV6ai9iN0E2eVVIN1hzdDNQMFN6bE5oRXNHTUNLVno5?=
 =?utf-8?B?M2U2ak90ZHhSVThBTFZ5Q2NVMVRESFRHRVB6eW5SMjNFdjhrRG12em9VM1A4?=
 =?utf-8?B?a1Y2dXRsaEMrNktQbHRIUFhRamtkT05QSUsweFNWcTlIQWpFVGhNYmFMVXpr?=
 =?utf-8?B?SnVRUS8yZTZ2aU85bERmRW8rUExFanhuZi9TUXh6ZGQrMll2dnNTZTBPTFhS?=
 =?utf-8?B?OXFWb1Y4K3BSWVd1UmZnTTZNODFwOVY4ME04RWZHZWhIL3ZKQlVkMGhlc0k0?=
 =?utf-8?B?aGh3b0d0bzVXWGlGUG9HMHFiaHdac2JLUlp2RDdoNmhjTnJ4dzhhUzVRRHVI?=
 =?utf-8?B?TTQ0OUYzNFpZM1ROVjNZTktqdG1adUxqMHE1N1g1RVVNeGtWd3JwcUxhVXM5?=
 =?utf-8?B?Tzk1Y3J5QlFVNjZYamRTSmlPVTFwOHZzaytIamJPa21GVzE2WG56d3ZTa1RP?=
 =?utf-8?B?VXNSaVpXUDFXbmN0ZmRYc1N3QUdTclh2OWYvY1hiRXRoUU9KQ0krUUd6MU9B?=
 =?utf-8?B?dVJSYlVVNElFOGN3c2hDdDExOFRQbFVTRHNSNEM2MTdsRUxJNXIyMm1qNUJX?=
 =?utf-8?B?aThIai9NQWVnUjA4N2hsQ2lhdjlQQU03bVNzWGhzbGFZQkFvcTFLQVFRNXpr?=
 =?utf-8?B?bW1qMW9lUzJBOGd5OTUzZnJIQUZxV3JXNmNXYjNWeDdWb2l1dlFuR2lNa3VJ?=
 =?utf-8?B?WVNxRHVaeFpYSGhqNWViVnpPeUVSS3l2WUZaSnVOWXBxN2tOSWwzTThYb1Vs?=
 =?utf-8?B?US9kbnEyMFB4NFdCOWhhN2xQY1RkaDh5REZlZU5TMEpCV0lzMTY1UUdRaitz?=
 =?utf-8?B?UjgwQjNzRzRqL1ZvM0dERUpOUFI3WHpRazErQU9FWjNRd3BzZTJYOHRZZTUw?=
 =?utf-8?B?K0htRXE2ZXJZWlo1OExKK014TkZPNytsNjNJaXpLVmdoZktYQm51RHg5S0xN?=
 =?utf-8?B?ZllMazdOdGpKU2FPV2l1ajNJRldNbkcxb0MrYlg4RHp2MVNXa3IxTmNFcE5u?=
 =?utf-8?B?VmFjVkU4VXozU2RCRmQ3MkUvMmdyS3lRVGZOTGdHczdRYm9ZbUcxdjFkUDZn?=
 =?utf-8?B?dnFPNUlOZFJvMlgvbkliLzNIYVRPRkFPN3lLdTVuNUZadVRIeWNvV2pIenV4?=
 =?utf-8?B?NzBvS2FHNHpOa3d2VE1NQ2xwRHNFMzRXalJLUDNETXByeXlKUlp6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d662bf6-fa30-4d3a-d486-08da3ca7b2cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 10:33:38.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOKI1KREVXbjoSA5bFI/u7H1zhYyj/0acaevjvCprEG0hkNZCsmudHobdSlBZxtGdmGegYR2LLs5YEVQml0nEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4658
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-May-22 12:08 AM, Peter Zijlstra wrote:
> 
> Norbert reported that it's possible to race sys_perf_event_open() such
> that the looser ends up in another context from the group leader,
> triggering many WARNs.
> 
> The move_group case checks for races against itself, but the
> !move_group case doesn't, seemingly relying on the previous
> group_leader->ctx == ctx check. However, that check is racy due to not
> holding any locks at that time.
> 
> Therefore, re-check the result after acquiring locks and bailing
> if they no longer match.
> 
> Additionally, clarify the not_move_group case from the
> move_group-vs-move_group race.

Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Below is a quick test to reproduce the issue. It triggers WARN_ON()
as normal user. No warnings with the patch.

  $ cat perf-event-open-race.c
  #define _GNU_SOURCE
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <pthread.h>
  #include <linux/perf_event.h>
  #include <sys/ioctl.h>
  #include <linux/perf_event.h>
  #include <asm/unistd.h>
  #include <string.h>
  #include <errno.h>
  
  struct thread_args {
          int group_leader;
          int type;
          unsigned long config;
          pid_t target;
  };
  
  static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
                              int cpu, int group_fd, unsigned long flags)
  {
          int ret;
          ret = syscall(__NR_perf_event_open, hw_event, pid, cpu,
                          group_fd, flags);
          return ret;
  }
  
  static void
  perf_attr_prepare(struct perf_event_attr *pe, int type, unsigned long config)
  {
          memset(pe, 0, sizeof(struct perf_event_attr));
          pe->type = type;
          pe->size = sizeof(struct perf_event_attr);
          pe->config = config;
          pe->exclude_kernel = 1;
          pe->exclude_hv = 1;
  }
  
  void *thread(void *arg)
  {
          struct thread_args *args = arg;
          int group_leader = args->group_leader;
          unsigned long config = args->config;
          struct perf_event_attr pe;
          int type = args->type;
          pid_t target = args->target;
          int fd;
  
          perf_attr_prepare(&pe, type, config);
          fd = perf_event_open(&pe, target, -1, group_leader, 0);
          if (fd <= 0)
                  printf("Failed to open %d type event(err: %d)\n", type, -errno);
          else
                  close(fd);
  
          pthread_exit(NULL);
  }
  
  int main(int argc, char *argv[])
  {
          struct thread_args thread_1_args;
          struct thread_args thread_2_args;
          pthread_t t[2];
          struct perf_event_attr pe;
          int group_leader;
  
          perf_attr_prepare(&pe, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CONTEXT_SWITCHES);
          group_leader = perf_event_open(&pe, 0, -1, -1, 0);
          if (group_leader <= 0) {
                  printf("Failed to open group leader (err: %d)\n", -errno);
                  exit(EXIT_FAILURE);
          }
  
          thread_1_args.group_leader = group_leader;
          thread_1_args.type = PERF_TYPE_SOFTWARE;
          thread_1_args.config = PERF_COUNT_SW_CONTEXT_SWITCHES;
          thread_1_args.target = getpid();
          thread_2_args.group_leader = group_leader;
          thread_2_args.type = PERF_TYPE_HARDWARE;
          thread_2_args.config = PERF_COUNT_HW_CPU_CYCLES;
          thread_2_args.target = getpid();
  
          if (pthread_create(&t[0], NULL, thread, (void *)&thread_1_args) != 0) {
                  perror("pthread_create(t1) error");
                  exit(1);
          }
  
          if (pthread_create(&t[1], NULL, thread, (void *)&thread_2_args) != 0) {
                  perror("pthread_create(t2) error");
                  exit(1);
          }
  
          if (pthread_join(t[0], NULL) != 0) {
                  perror("pthread_join(t1) error");
                  exit(1);
          }
  
          if (pthread_join(t[1], NULL) != 0) {
                  perror("pthread_join(t2) error");
                  exit(1);
          }
  
          close(group_leader);
  }

  $ while true; do ./perf-event-open-race; done
  
  $ dmesg
  WARNING: CPU: 121 PID: 7304 at kernel/events/core.c:1948 perf_group_attach+0xfb/0x110
  [...]
  RIP: 0010:perf_group_attach+0xfb/0x110
  [...]
  RSP: 0018:ffff9fec0fa87dc8 EFLAGS: 00010006
  RAX: ffff8f988b3d0000 RBX: ffff8f98872bc0f8 RCX: 0000000000000002
  RDX: 0000000000000001 RSI: ffffffffb571c83b RDI: ffffffffb5793126
  RBP: ffff8f9887514830 R08: ffff8f988b3d0120 R09: 0000000000000000
  R10: 0000000000000001 R11: 0000000000000001 R12: ffff8f988b3d0000
  R13: ffff8f988b3d0008 R14: ffff8f988b3d0000 R15: ffff8f988b3d0000
  FS:  00007f30c5bff700(0000) GS:ffff8fb7f6800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f719bf4f130 CR3: 000000208c010003 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   perf_install_in_context+0x1af/0x210
   __do_sys_perf_event_open+0xcb6/0x12b0
   do_syscall_64+0x3a/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x7f30c5c398cd
  [...]

Thanks,
Ravi
