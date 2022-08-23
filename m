Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294FB59E9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiHWRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiHWRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:34:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA374372
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAufvEtpS7peOv1Ban4SjkEbCsf8+2irCjBhLWaNbPzmkMmotQsOMp+78tCEUStqyFfJQdk6I/F/pIk6P/ifESqGMlXGmPE5kKkd9bjuolzO8j5jQqzwFRZPBtmf3q/VpczmTc84pVPL0JTVkvAnzdEP/wWCN1zZpT2VcXjCIqLmQrIMq71cj44uWzAWg/3QxV7yYHZ5MknyN05QQfz6bfrePSWc7UPqOUN3W5vO59y9vEgyJJq/zQ0UfqWOyAlUxMYw76OTncbgYNbcXPMGS1l/BSkjb2V5ioegg9b9D+DFlzHEFbfCIwFU/71vJ+loBTgSymQ9FKdTONYOkeFvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZFj11UWp/3PiGewqG+h/7Nyvelif7oJ2VZ1QHPPT0E=;
 b=Et+3v0r7bsEd4PXjhMdrMFXf6UQCWfekE/yaMKj3XUChUgOdiQc1rs0mZW6I6E8oEozPV1bobCIF3G0po2VDWc5xT42yMsU0aT1D4GPBbIE4nFQI90Lh12izlv1/RPqkS1yFRxquA7e6Hi4nAkCjIXoGb1FeZVUoKKx49njQzb6E6CI8VRp4sC/WYM8YNuNaGr2ZGEtGT4LpSIt7n6EaaYECQirW/P1JMLYQzZaSVOxhvNacpk0clEFuYgP5iuoTyKx1e0inSZmh67znvwP98lJS3MaXjSvhF8IvMlt5rNKHdMt+e6uGCFSjY/4Wrv6m+smLt/IXb4HzeoNj6uIitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZFj11UWp/3PiGewqG+h/7Nyvelif7oJ2VZ1QHPPT0E=;
 b=QdnnONyhws4PZeU36sR88tDE1dVj/OlLBZvC8amhCv6SUcthoCfXunwte3vq4kqL4xLeo0VZwawhBRYhM1zyX3jnKwJgOSH9FgbRJ55E8VnCUaovrOwUvMwc0FlL8X99AWT10xbOcZjj6sJTP5w9TKTrDeHfGU4QxPU09DfTxFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) by
 MWHPR1201MB0239.namprd12.prod.outlook.com (2603:10b6:301:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Tue, 23 Aug
 2022 15:15:03 +0000
Received: from DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::4146:e411:541d:1e4]) by DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::4146:e411:541d:1e4%4]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 15:15:03 +0000
Message-ID: <b39d0bd3-aa6f-c044-c668-2108878fd004@amd.com>
Date:   Tue, 23 Aug 2022 20:44:51 +0530
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
 <a7b87da8-cd78-77ef-dd93-7886d4197050@amd.com>
 <YwSBHL4xxTqz0F9f@worktop.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YwSBHL4xxTqz0F9f@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87abac9b-0230-4957-31cc-08da851a40e2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0239:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nAnYl11lXVziPl8bNDvQHjsJwfV8hS8cKUjSAfFBq/xKyMzUxQfEuN2gHlZHewrK6tdhnLsarG3LE4YEiP0seXSOJ2Gc7H0+B8RoD06v1LCDpQqbNdwb9dckOs5nkI67X+rOoJ+B5puNSmcQlGGXzvfrBAXgiyvkZOhXJsan7qli05EFBw71w5pnH0NQ6iRHh0aiWG4XRLX5CTSaZJflVqiAKE/INztkjjN7ad9J+pRu+BS6eZKtMQCIUpzRSeRfkyd8oDPSXWtpji+lHs3vUmyq2l0e3Q4HTvUfcK5jOPfMm9ZaxT1g7kMhpKIHv5+LrgfEvTBMXoVomEiBXjZRd2yEfFuxnyzQ2Kn2jyvQXG83/YPCzycjv76xwKCjqYm3Ixx2tLkLg/iA4xW/B5/9gVQUp7B1gcWb3iE7X5AfWCr5f6OT3fzzGSnZLwvkJvEYPH9LvuHlNIy4TVsyUv/S5wXs+kjJHGrkCfq8PoeL8kzeEEG9/d89eTCLDrEHq1qRBr6DA+lydINiRWxP2apjzJQv+BYVTTt0I3tlt4FN0rV69BRsozThBAv0RRJLmSQycBNhirTseY4f7weN/x/joILDSV64w4RidlVBZv0ummqw46j8zDnq04ggrLwFNQwrHDAtGLsMyJzXNo/jngZ6g1jB3AEr5nsjiRfpHWzMOEsFufNEKu0nJySdN8KwZOW31pecH7lfOl/pU/TT2hfh4yh0a/ZCckppOhQSnPdPu5qFiFxbLK2hmq6dFC+geqz1xiNqHAHJWzXj+BDvLHP0hQbqw4W6s0itFmB8cSxxhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6584.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(6486002)(478600001)(83380400001)(316002)(26005)(6512007)(6916009)(36756003)(31686004)(2616005)(186003)(4326008)(66946007)(38100700002)(8676002)(66476007)(66556008)(7416002)(2906002)(41300700001)(6506007)(6666004)(86362001)(44832011)(31696002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHJkZUhFbFVWVk1VWUJCSkt0d21jMHhTZXd1aXMwL1Z0Yzh4U0NQWHlmRTBE?=
 =?utf-8?B?SmFPOFNlYlZFR0FEeHd1VmdpR29LaWwxU0kyZzVXSW9sTWh0ajBNaGFQZ2h6?=
 =?utf-8?B?QTFlMWQveEF3YStuT3ZPWWV1a0hoakFPMDZWQmZ1VHdJekM0NXQ0TjUrcms2?=
 =?utf-8?B?cnkzM0lTZ3JFZXR2ejlya08yamxFU2tibnZxWE1tWGEzNDNDM0dhZVVaZGNl?=
 =?utf-8?B?V3NZZXdGZGhMeG5iK1NtanMrWEJDT1hKY3YrZjNiTGFzaVg4cGNWR2daSnVP?=
 =?utf-8?B?YTlFNDNmSnZZcVFZbmdJYWU4MlprVU9rdzI0Y2Nhck41K3FtdVFWTU9kTmh0?=
 =?utf-8?B?TW9kZktxMzl6N3kvV1lGNDBidkFCNTF4eHlGZ0lSZGp0bk8veGR1WkNHKzhW?=
 =?utf-8?B?N0V1VlVFUVpGbmdnL0k4alFTNk40ejNSNk5XZGFnUzdYT0ZyY3lSUWhHUm9U?=
 =?utf-8?B?WTF5VTFoNHZKQ01EcXBaYmdVQVM1ZjBGdHFicGp3VzRaUVpXZ3d1cTY2QVV3?=
 =?utf-8?B?UkpETkVYV3JKVHM0eXVxaG1qUXZ6OHl0SXBqU1ZqaCsxRDIrZHBtTnNBTzlR?=
 =?utf-8?B?eEl6bXRWelFwcDUyeGtBVjJUOEFlMjloekV0aXhENEpaaGNKRzRQMmlzUU9N?=
 =?utf-8?B?eSs4OU04Z2lFQTFxY2U2cG1kdDUwZmpIdW1lczhsZW5QeDRhWEREbHdDQ2xZ?=
 =?utf-8?B?YXUvbG1QRlJ3aDMvWHZ3REY1QWZLdzFpY1FtbjViOFord0VPT3htTC8yODM2?=
 =?utf-8?B?cUJ0NDBvWE14dE9YTmxiNHNQK3hxdUVSc1l3cWtzeHRkZTdmTEhXR1lPUXcy?=
 =?utf-8?B?d083RDNvbW1jTmZNOW5QOFNpZHdhaDNMQ3c5T3JlSEswRGVKZ1NDZW0vTHNh?=
 =?utf-8?B?OE9YU3JwVG9wUVJyT0V5cHlIbXRZdVFiVWJWVTdjZkthSGpDSXlRTk1LNEp6?=
 =?utf-8?B?ZGY0aWJoeEI4TUloS3NQYUE3Z3ZWUHNibzhCejg4R3NaVW85TVJtRjNBdWJJ?=
 =?utf-8?B?d0I4bUhvSjFNcEtkWDAvVmxUV0JxZ0IrV1M2d21iMUZKVWFDOGovZVdOdk5R?=
 =?utf-8?B?U1h4L0h1RmhETUJYTzk2MkZIOWlsV1pZUXVFb3F1NytUSUROalI3aHlBVVZM?=
 =?utf-8?B?ZnNoMnNwcjlGbHFXQUpXVGY2bGRrZGpBWjE2QWRCb0R2TWpkRkxpN1lwbW5q?=
 =?utf-8?B?VFJwajdBdHRiem51b2FJQkY4QURwOUpmUHdEekJ6dm5GR1d0dUgyYjlkd2hM?=
 =?utf-8?B?QW9aWU9kU2RVTGlrUEZuNHhtaXhpeGxneWQyc2JBN1dDdzF4VFZyY3VidzJ2?=
 =?utf-8?B?SDlOTUFjMkN1eWR4bktRRXhYRCs3Ni9TV1Z0YTMzaEZZbzRSd2lRcTdEaHlZ?=
 =?utf-8?B?VWt4MG1lS0hRMk5IeFdZU3ZzWEljVkkzdFdHcTFzbzZDUVhrRDU2eFJKcHFN?=
 =?utf-8?B?VVZjWTlXMUYxVjl4SjRJTDZMK1BpOGRXcjBxSUlFcnhsUUVKS3JmdmtqaS9S?=
 =?utf-8?B?S1VxWVQrZytiRDVoaENVZmlSdmFmQitES1pocm5CWUpwN3dLaDE3WmRwMzhB?=
 =?utf-8?B?cU1UbTRuRmlEMktHYzZ0c0dCWUtKVHlONlpwS1cyRUhDTXhhVGdBMGIzOWE3?=
 =?utf-8?B?dlo2RXoxR1QyNmhSbE41dWVxUUJHckVuSDFJUDZ3am95MHh0VlhTUVZkcW9a?=
 =?utf-8?B?TSt4QlNpV1drZ1JFZ0tEN1l0aFNJcE1MaEROUUFUWW1Mc1FhYzZ6a2cweFRF?=
 =?utf-8?B?VUg1MzVhdHZGTjVwYUxxeDFoWlV3V2lDRDM4cnpnb2FhY0t4eGJab201SzIv?=
 =?utf-8?B?Ykpzd2xZRnRhNXlNdnZsTmJyN1BINkxJMmpNN1U2cDVQaEkxcGtLR1pNNW5H?=
 =?utf-8?B?Q0NXTktxSGJKUWVoVjY0OEdxWHMraFQwM3RCSVdRVXhTNFh5dmlCTVhsZXBj?=
 =?utf-8?B?RSt4WTY0SFZRcGdtRVcwa0hUOU5PcXVaVGxCYmVNVUFNNVc4UTd5anhaL2J0?=
 =?utf-8?B?NTBKZ2FQbXNQK0l4SEZQNzVmT08vclpCM3NVckNLdSt6b1FNUzAzZ2R5eUhr?=
 =?utf-8?B?NDZTUEJJdElWNGpMeEovN2NTTGxmOU1KdGw3aTFISG9tWm8xUjh3TEJvTVpB?=
 =?utf-8?Q?R1PtCvOh5h3OjlhtkSh3PqOry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87abac9b-0230-4957-31cc-08da851a40e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 15:15:03.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K68KLKYNsMTKkbklqm16q2cIuSM8R/FJgX+bV/DGy+sLP4ILM3Qs7Bj2gZrVJnP6/Zxy3/BgJ8sUWuWUwKlyDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Also, this hunk is under if (is_active ^ EVENT_TIME), which effectively is
>> (is_active != EVENT_TIME). I'm assuming it should be (is_active & EVENT_TIME)?
> 
> So that code is identical to what it currently is upstream; but yes that
> looks somewhat dodgy.
> 
> So the code itself (does as the comment says) starts time.

Got it.

> This should only be done if EVENT_TIME is not set.

Does that mean context time should be started only when context is getting
scheduled I.e. ctx->is_active is 0 ?

> That is, I'm thinking it should be something like:
> 
> 	!(is_active & EVENT_TIME)
> 
> which happens to be the same as:
> 
> 	is_active ^ EVENT_TIME
> 
> under the assumption is_active contains no other bits -- which I don't
> think is a valid assumption.

Correct, we can't assume that. There are cases where we call
ctx_sched_out(EVENT_TIME) followed by ctx_sched_in(EVENT_TIME) when PINNED /
FLEXIBLE are also set in ctx->is_active. For ex, perf_event_enable_on_exec().
In such cases, we will not advance ctx->time. Example:

  child()
  {
      ...
      execv();
  }

  main()
  {
      pid = fork();

      attr.enable_on_exec = 0;
      fd0 = perf_event_open(&attr, pid, -1, -1, 0);
      ...
      wait(NULL);
  }

Here execv() will cause call to ctx_sched_in() --> __update_context_time()
with adv=false. I think that's fine. Sometime later we will anyway advance
ctx->time.

Sorry, I've not spend enough time with this time keeping code. Please let
me know if I'm talking nonsense.

Thanks,
Ravi
