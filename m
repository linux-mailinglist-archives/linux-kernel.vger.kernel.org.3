Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461814D958B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345611AbiCOHrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiCOHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:47:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1F4B857
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZlix7ftm475tc6uCpA9pCzDe4X04gjXHEYd5w/uOuFKh4KMJa25YAqtb46a8dBm+AEzTzprQMaC8d7eBtZpRlUbpqU6EgZIP09mUxplFImocw0vwr8iTav6ZfYig9Z5uSfCfRpA4COWjcGqWHQnzodmCKXwzmSWjllackYfcfKZmGKE6KVclAO7escP0nR1K7nCHu9RnQSF7l0B4Yc6ySRLFYYYHu6p7qqjfyxNeZPfb1+teQ42X7QgufsdajjGS75wlIq/c+sjZ9ZV7wmdih+nrCaPRJGJ/0HAM2MQXTwB10KkorlAp49CD2UGZjsi0r3NAAGsi4tvUwYB5GSWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uexN9cNhq5OH/h0uM9Wm8mO/wSFnM017dTs6SOWiaiI=;
 b=Ei4A+Sxght7wComfaRDCA5PBcDYVgOuq2zXKrzDFYoOrboqJMvOqHHQM0HH9dic3FkkxTwJvHoNHUbpA6HX/6vV4AuZ67co0KVwNFjXZ180LCVOc7OVFs0+nYxAup9B38T8MqlSnNg3MrGIAdZcn2/drMcenqDqK+Nc1kafWwEsCPwbC38aAFF/O8Ywl3CzbJz8P19AZ6qzuhY5we7ohUNsI7OKZPcNwg+tMVq3NPRpQd4NwQ+WeKqqvvgb2k6xGerCmFMHK0VyRpzyH47fzseCOqPeHx8Td6mPTcb9uzH3QANLfNRGh/erGLeL/u4KjqepSNpz2FYD8zAe0J01icQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uexN9cNhq5OH/h0uM9Wm8mO/wSFnM017dTs6SOWiaiI=;
 b=AUd4Jd6oyTr55mbiQTfZ3ZSbQRb7xaNnrme8l4Ccv0uZ9vDLUC7wo4NXTRiSsIlhR+XJWhu+mAvnPOUvBdoCdRLLih16WtB+iOlYFRNkHBtH2CINUyoPH9ygYJoDsB+hEkwsBTJXBfkZC2GTUsjz/F8mnBHOXURRZzW8nNuYG3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by DM6PR12MB2762.namprd12.prod.outlook.com (2603:10b6:5:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 07:46:07 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::9117:ca88:805a:6d5b]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::9117:ca88:805a:6d5b%4]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:46:06 +0000
Message-ID: <aa641092-98e6-114d-b423-13e0bff248fa@amd.com>
Date:   Tue, 15 Mar 2022 13:15:52 +0530
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
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220208211637.2221872-11-eranian@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::18) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10597c64-8c09-4866-5519-08da0657dcd8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2762:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27621B1615F6CD63F3E4B489E0109@DM6PR12MB2762.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rKE/RepYh/+fCAxu6xAujFFYiEZq4hYpBEqWu7XYdiNXtfsvLRm48YEmGkuCwVfkUSXMCJ/HLoKWrnJyjb2gPo2mZ+38oTfGYq2gHd0KKkQRqnvd8WRJw0Co3ZXq45kFVp3AluMfjesjrIgeRQp6NBXkxtuoWJDImL51K9FhMJ4HhYb+Qx6rOeY9xwzlwk/Vt3AblmA4yaZ+tbimr4XPcqlCvNlHUxHz/xYVp5cB1y0ImFLVZdJKGyYcU5itNZVDP8p1zRUohm62XORegFPe3hnmgu6qt0QgLPjxJMyQyhASCwlMpmhaT+WquraEIJqxOheNMOh+J/gIiPhP7iRYC1YPQ5GijJrksxwYqebmSnbeM7HNm8k5cTKh3fKJOSM6ZCWDymEAF6IbKuLtPjYlpfVHotlli4xt6e7lfTlF/l3fAFbkFCJUBiIl+dUVok3MQEtlDRoFmwxuAA4+AaJBR3SxVfrXzrGsBxeRIiPmdEykLcU5JjyH7NHLEfc0FqMB3pHM2G8zoqO0KCtHpVnm9EsWBPjLf5SgWFZY907Vbc2enEyx0F7OHpDTOMjq9z5PLpKAg5TjXLp6rEiKlfVqVj0gX6VI9i9wFZLS9wuWdptblZxBAxVPE3Ts7aRD0tcj1siBl/Y4dPlngKHhIcJMEWTXaU8p74CS8EwGGsSQxtBmFMjmvFtgKlTCL2ylC9R41ZVo5hqZvsUnhkl0yNRWmPAErSPKrEe7bSW5a4+IwGF+em0jHCMFo565IpjVm30
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(31696002)(6486002)(316002)(2616005)(6916009)(53546011)(6512007)(66476007)(6506007)(66556008)(66946007)(4326008)(38100700002)(8676002)(86362001)(31686004)(5660300002)(6666004)(508600001)(2906002)(44832011)(8936002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZRVS9ZS0xVaXlTaWIzeHNIQUlnZ3RhOW9aMjVLem1pL2FXWUFiMGlvdnhH?=
 =?utf-8?B?dFJpRnEwdGpvRkJUQ2RuTVZuR1pXN1hkeDBzMmYyVWtsWnJkK20yMTN2QU1p?=
 =?utf-8?B?NDdKTGxHVU1OaXB5Y3ZPREIzazBBTHJzY2pCdXRyVzRVck40Vk4vNVFBN1FL?=
 =?utf-8?B?U3NPY09Fbzg2Und3b0xLMktOM01MRVFRNWMvSCtLc0dwU0hCTXZyUXFrbmdu?=
 =?utf-8?B?SEM5RGViVWEwcnlmdlZuajk3ZU51dUVIMXc1cnpLZC9BdXBRZ3RsdnkzZ3BE?=
 =?utf-8?B?cVFMOEZUVnBnekZVMWVKL21JZCtQaStxZ240S2FQbjF1VmdSUzFLN0hJaG5I?=
 =?utf-8?B?THJSZS9ES2xnZkFuaS9nYkQ1dVFJdlBqd3Bib2xSU08xZFpiTklWS25pNlJz?=
 =?utf-8?B?VDl0UjZvSUxKV2JrdCtqOUNwZ0pLaUN6dUJ3R2REem5hVkJ2SmVZRnVEQlRh?=
 =?utf-8?B?NG5jcC85M0l2WDVUdjJjbGFidmhoQnVRTEFoakIwVVhwZjRMVlVvRjVOVHlP?=
 =?utf-8?B?MnBUZGdkWTRDUXNNQytZLzI3WFlyTHZXUkZBN3pjZlNUTXVNWG5kYTV1K2w0?=
 =?utf-8?B?OHc0cjVPK1NWcTdGME1JZE5PQWlKVzNucTVSdFZzRUtCWnllL1hQdTJQOUo5?=
 =?utf-8?B?cVplV2krUlFtanFMSnU4SzEwTVRtelA2WFVTVWdoR3lFbVhZUVJGSXhiTHc5?=
 =?utf-8?B?bWxyS2VUbVhlWnJ6QXZSVVJkYVhvckpxektiaXFOalRhZGdWaytRZ0ExNmQ3?=
 =?utf-8?B?VGxoMFFVY1FaNmJrR0dKdlZSVTZ0cXJFZUFyTDhIYllHL25PMjRFaUxHWHJ1?=
 =?utf-8?B?S254cGNWMXlwaC81eHkrNy9xTFNqTHQwSURlMzQ5MzRmL0hlUldZK1VDSkp0?=
 =?utf-8?B?bTdkdXpDNkgxMnM2aElPQ0lBZ0VQQVlIcHlEQ0ZJY1EwOW9yNW4vNG9vb1BI?=
 =?utf-8?B?VEZLalJ0bXo4VGFhZGpUeTZqVUl3bk9VN1FxYXoxVEx5aHNnSm5TdzhWWlow?=
 =?utf-8?B?ZjR4WFUyVU8xRVdqQmZMeEh3WC9CcTU4ZUZnRnc1NnlDVis5Y2tZQ1p6b1Nw?=
 =?utf-8?B?dStpYit1WWh1L3RaakhJWGtlSTRVU0JFRWlRZGJtbXlOd3BPMjJqdUcxVURY?=
 =?utf-8?B?cEpoTjZuL2djR3Q3SURscnF4bTFpRm1RL1ZmVlZkNWF5WnlmalhlbGtwLzJO?=
 =?utf-8?B?ZHplWXFTc0NBMytBZVdUNWRGdWlocXlkVkdEN0s2Q2xRUkZLdEdyTUlaSHEy?=
 =?utf-8?B?enc2M0o5N2dyTnVUNzkxSGlXZkZJWHEzaDNSakN0Ny9HUFBUdE1Wb3NLdVpV?=
 =?utf-8?B?bzFGU05TV2ovQ011RnVXSDh4WWN5MWY1VXpWUWxyaVhac2tQQ3djbFdtTjYr?=
 =?utf-8?B?clFPdW5UYW8vWndOUmFLS3N3dlFNMHJpcGxuSW1xZkQzdkk2dk5aTEFvSno2?=
 =?utf-8?B?WE85b3grQmVsNGNSVTFwS05SNklTR0ROZG5WdEdYMFVGTkpZb3VFRkpDd0la?=
 =?utf-8?B?b3hvN1hVcVYvSzNtWVg2dWVhM1hiRzJYM3hNUXNzcGthUVR5djRUQ2VtSlpq?=
 =?utf-8?B?VEo1RU5xRDRrZ3QyaGIrWCtjc3E3akF6c1BvU0ZGenQyak9WR3NMN2NSUUdt?=
 =?utf-8?B?eDdodWo0Sko3K2VpN2FPMFE4QStLZlBvb2t5TVFVSTlQeVdxeVVMbXo5bHBp?=
 =?utf-8?B?bWJCUkFuclZvRGwvY0hqMFdHUWxEVXpKK2tuZXhWMlpmbGFIMnMyRFpaQldq?=
 =?utf-8?B?bjNVM2dSOHZIUFN6RlkraFZ4R0s5VWoyT3luT0pVdm5wOEdOeElPMDU5eUov?=
 =?utf-8?B?YWZ2Tm1SblAzaG5Fbi8zQUwyUjlqaURyU3dScHkwZDRsQnVpenRSQ1JjNGpt?=
 =?utf-8?B?TEJ2NURiTVRGQlB5VTZKU1Exd3p2Zk55d3RDZGZiZ25DNjhmNXNTZjdMSGpk?=
 =?utf-8?Q?dD8E815zQ6UjzjUahiNwXr94WBs3ETMM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10597c64-8c09-4866-5519-08da0657dcd8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:46:06.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eioXNsIK0Mqp9o+IUlAeFBOksckvFmzRuCVNP9kwPHRtsZQgQHUkD2PuMra68EH5a1yta9NG1y6rOx/qJkJwow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2762
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

On 09-Feb-22 2:46 AM, Stephane Eranian wrote:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> improve the error message returned on failed perf_event_open() on AMD when
> using IBS.
> 
> Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
> 
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> Output after:
> 
> AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.
> 
> Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:
> 
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> Output after:
> 
> Error:
> AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity

This patch seems to be causing regression to perf python test.

Without this patch:

  $ sudo ./perf test -vvv 19
   19: 'import perf' in python                                         :
  --- start ---
  test child forked, pid 145391
  python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
  test child finished with 0
  ---- end ----
  'import perf' in python: Ok

With this patch:

  $ sudo ./perf test -vvv 19
   19: 'import perf' in python                                         :
  --- start ---
  test child forked, pid 144415
  python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: python/perf.so: undefined symbol: perf_env__cpuid
  test child finished with -1
  ---- end ----
  'import perf' in python: FAILED!

Thanks,
Ravi
