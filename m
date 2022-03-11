Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141F04D6A94
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiCKWxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiCKWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:53:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63722637E;
        Fri, 11 Mar 2022 14:26:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BIsbLq013670;
        Fri, 11 Mar 2022 22:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xpNNJUeOeoJ9zr6tGzNP8ER5r18VU9EATgPqRioqlaE=;
 b=ql1hDSYg4RTQqk3tyJzb7qvWhvVtOXJn6nwIFtj7CU+KHgj3fn5gh4mFgVEorPgITcbT
 ObLuMB0MXB0Fz/cvsEHe6/9jxvXqKmP/SSfY38vmWM+ER+uo+GGDOVo4bqGu7UXZIANn
 xS2GLRA4VAVA3Xv6w9LLt8cVWmQZcna2GeVi5rqbmlVfhOvzef3ROTyZW6KIYmbcyIRE
 BVRRG7uDDFyL5Z2XFfGFs5X0Pbu8hG+jSE8QCEL+gtvde0ZnfN+VBWzFsGTMLgaUzCtr
 BZfCro5KomzRasx0k/2I5kjmjar22K/RaYjikCCbHLA0vngc8FK09nac/j+ItZ9J7zdd sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cssgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 22:26:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BMG38k058017;
        Fri, 11 Mar 2022 22:26:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 3envvpjvne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 22:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9exSQn6EKcwC2nwbf9VXipJCXD8bC4OAfw1vyz03tEMKIRDe2Zh0rWHHrG/L5/xzfRrYfNHzM2zswl5Vpfje9Pb24/X/fJk8eLlfPeAhbNG58jMMqN3YXzAXjLqTDTAYc+3zrZJhuhUJkmhiYJuQg8UlJFsOYxDDGMy3ZBzT1yAKgXGwDiL/p1UiudSY2XcZB1YWz9rJrQ6FNTULzb4Lx5gvBwbaz6dehM43ekdmfdOXeRgxC7hq+jqTwa/b05rSYcuR+XceA8nPnfwCTQ3Ry5mmWnQi2VvblqgE2ObZNcg9Hz6qqx+8/kr6x8k32zMCJMMIBo2msOHnFu+5HqjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpNNJUeOeoJ9zr6tGzNP8ER5r18VU9EATgPqRioqlaE=;
 b=LS+BMI8FRy4/EVesIlxcaPLA25r6Da43nifqCh8UdadNkrgF2LCmBWdJYshyKsJr4RB13C0vyXJzuJw3G4qLg+wD6FmX15RMt5OIOAUb1sC4btSTGIKh/dcNDwiOy4MUPIqQFrCbtuZek3PPoRBXzPJ9zUyCZozVo6J1UdFEg+X9fpXziuykX4P6MRR+kY4B8R4oNW79HlBcg0cRcvLWdTWvuo1US+WRgS5a8vkgb9BlxFfnt696Wirnt/h/agD8+Hrz7ytVI2IAMpF9x9TnMJHMXuSPa7b7SMw95L/f51pf06/SOtgQEFoSGRLJ/jrL+S8hsH7evSsb8YducQ0kpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpNNJUeOeoJ9zr6tGzNP8ER5r18VU9EATgPqRioqlaE=;
 b=PPKWCkRU3Y3EPj4exUDX3GSoiHtrdO7eHC6IYe8lWryPXJPVIERUTybOvn3nxFJKaeAHqMejNECN4TEJF6KQRX4fWgcBUWhaXxjWQowrqrVrGcZuCSISZSkfO6sMAddzCAkH/hwWQBn1UdfMibWY/TRHW46Y8OOOxcZ0/+k8loY=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by BN8PR10MB3588.namprd10.prod.outlook.com (2603:10b6:408:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 22:26:04 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::b9d4:8912:7bf8:14fb]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::b9d4:8912:7bf8:14fb%9]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 22:26:04 +0000
Message-ID: <3508496a-59ea-2004-2917-2ffe712cc187@oracle.com>
Date:   Fri, 11 Mar 2022 22:25:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] perf/x86/amd: Don't touch the Host-only bit inside the
 guest hypervisor
Content-Language: en-GB
To:     Dongli Si <kvmx86@gmail.com>, peterz@infradead.org,
        joerg.roedel@amd.com
Cc:     kim.phillips@amd.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310183404.1291725-1-sidongli1997@gmail.com>
From:   Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20220310183404.1291725-1-sidongli1997@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0219.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::8) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825ae2ae-d4bd-4c01-6bb1-08da03ae2137
X-MS-TrafficTypeDiagnostic: BN8PR10MB3588:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3588C3FABFAF45CBC1856D46E80C9@BN8PR10MB3588.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEwapbw5ls6+atG2r4BnzLLhYKKjhP4hK87FWGkS5p9ARGesxWGCy5X7L0bMJVh4BU1KLPYTRR8j+ke2pE65/Y0xRWsh7iqkppZkPkWkNQEa1kpi7CkD3k6ZSklEWALu+8JwMNwV10lib0N5BsajlNr1IK0bT0yWdEb9E6CxTMCWc5uFe1bVPrhrmptMDqshwO5oAA56O17+qFydZGEEfyUYRowQb1tcm23l9AWQcSpQxpXSx9viO4SRP5e707Gwihjok+qtpii1xPdC0IE9l0F5l5LEXpe5IKqxlgSawDRGD58BFMGJT3qEjRdA3jNV/sOQY7QEbATmGwkanauFP1S0eUXgQQ6a7sG6qQvjoUwNptL3NzQAnPmzADR5X96PPTSPV28fgV2XJS8zeAMtjbsaQCJIa/6+WeGO1NMxqgHw9qvi4HKI5bZ5V2RE+j3OSIXkl/jryFFSsk6UPP/ttX+YrCCJ2FEhSVq1rNAkSGbf5ksgDFW+rFwfyKc00OufpJutH+pCqQsnOsNGCUJ9v1xY5UTCoFjrou+u1yqWWGr8VuaqHT39mzPizY5UN4tS5pOi6HRHvxi7emkOu0Ygedxr90jg7M8FW8pjaSrmn/jUoaHhZWYytmz1cBOsz6UXxs+k34tB4OE2RtAVaZOSavjRlOKbcMC16++trSsDWWQw5KvFxMb5pjHNszCsiINX1CvNrTgaO0Kf6GYZjosr/J7CCuSHmgu8c1rv7qQOBSAn0DnV2S/LIjrf9q9xQ8mbtoP7TV35uIVf4cxMx3z4opC4LbU5tvI39JTlt8pG5INt2DFwl/juo/f+ju88geXzvJU/SvVhbLyVnscEU9U4yq2bYVsenWE6d/suH4SsLfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(508600001)(316002)(66556008)(966005)(6486002)(66476007)(44832011)(31696002)(6512007)(86362001)(53546011)(52116002)(66946007)(38100700002)(38350700002)(31686004)(6666004)(36756003)(6506007)(5660300002)(4326008)(186003)(26005)(83380400001)(7416002)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdBNUlkS3RIbVJsb1NQek51NnU0ZXM4b3pLczBFK0JvendlRFBveUFieXMz?=
 =?utf-8?B?RnJSSlY1NzMzZjlBNmRzeVpoZ1hYdEYwbUNycTN6QXZpVWY1bnRxMkhYN0I1?=
 =?utf-8?B?dDd3NkY3ZXkwZTlOcGl5YXp6K1B2ZklXUG4vbHFqbER4ayttU0luWFNsV2xX?=
 =?utf-8?B?ZXc4N3E4OUswdUR0MU54ay80UjBlMkVRR0ZabURVWG5WUWYwZmg1TlJhVzRH?=
 =?utf-8?B?T1VkcktuMDZEZ2hDd2F5cVhCeWZqTlErTUVvVWNndTR3L3JoWTJYN29zNWZq?=
 =?utf-8?B?S3lnYmcwbWRJQlVpUENOTWpZY1ZwVlpDSVAwcjZVMVJUSnVhQmJoOEU1S1l3?=
 =?utf-8?B?d0pHUFBOSmh4c1ZRMEhXMVZZZDd3bC90SVNCTSsrN2VtRWJwWjVBSmdWRlp0?=
 =?utf-8?B?N2czanJla2R0cHdWU1VvRGJ6Y0NDV01Pd2pycVZ6Y1BaUUVNMnJsTlp2clF5?=
 =?utf-8?B?aTZubmQ0Wm94QVBhWGJ2KzVpR1FnOXZncnI4aFFnV3NPQVJLSUQ2NXVIRXNB?=
 =?utf-8?B?SklQTGdLRU9BVWRHTTVwZGJlbDRmUEVlWGdqc3Iwc3pBM1U2djJyKzhubEhI?=
 =?utf-8?B?VXJOUFZJTWlPOThXMXZKNXZxUXEyQTRhQi80NDBta2tnV245NWV5VCszcDFr?=
 =?utf-8?B?Y2lkS1lRQWhwS1lMRm9OZ1N0T3UySFFmYnZCNFFmTEhmQkFnUVV6YmtIeTlW?=
 =?utf-8?B?WGpoSnVZK210Z3RnNjhEVWtWbTFHT0xVYmJLZjBpdDhZeTRTblc1VUtlUmVw?=
 =?utf-8?B?RldicDZTcExXYjZSUGczOWcvWkx0R09BL0dsOVExZTBxSEVyREY3dEhuVDV2?=
 =?utf-8?B?K2g0SzhUNllQTmdpL05EMkxhVE9WYjh0UUlzRlVXanMyM1lLZWFoSm03MzZN?=
 =?utf-8?B?SGk1K1hRRHZqYktRVkZTN3dvSm4rWklWTXNQekgvbU93RjBNMkpvVmZMbUYy?=
 =?utf-8?B?dWlWWW9rS1RVWGtVZFhNYU9zNVcxcFZYc0ZNenpjTEJ6c0NUK2lubCtLT0RH?=
 =?utf-8?B?TXNwZ2RHOUNsaFlkY3d4aE14QjA3QURENzBXeHg2K29BcWcvWGFyZ1VZY1lG?=
 =?utf-8?B?TjQ2S3RoaG8rZTkwc0xpTmFjWEVSUENySFdsL250QjZjdVlWZGdKdjJ4UzBI?=
 =?utf-8?B?bUNuRmxCNEprMjJzWTNsNExtcDNUajY0NDdneGMzOE51MHQ3REVhYVJYNStY?=
 =?utf-8?B?WmRvUm92RFdOZjc3dW01MGRjNWJxWkpkdS9Na3Z4MGJMMFBtYm8rbVk3YWJ3?=
 =?utf-8?B?elQweFpHRzBYbllIUjV1aGtRdmFQMzM3ekk4dTdjSFJFTzR2MitUTEk1bzdC?=
 =?utf-8?B?Ym8zdFJSZjVyWlhIUXo3WEh4QVEwNkhzbGJaclFBaWIvQTdDRzNyMURnWVdx?=
 =?utf-8?B?UkZVWWRnRDBHSHVtTWltVGNUbVhhRnhmYUo4N091dGZ6V0NIM2N3Wkp2YkRr?=
 =?utf-8?B?emJpMzkvbkIwTC9kNmdTSHNNcVUybTcvK1E4bnVScnhZMmt3WU9LMlFKN3E1?=
 =?utf-8?B?bU5QN0JhN0pzN3RKbkxlanBHUXdHK29wTUxaeXVFVWZualVpQ2FMcHYwN0NU?=
 =?utf-8?B?cnVoa0hwL3V0TDhRZyt4VzZHRnZLS2RxQlRhaTFpT2xVMUpybnpEY0tmMEZC?=
 =?utf-8?B?QktCSmZHSjBjUXovZG5RRlFhTGpoODBXYzl5UXd2ZUxPWEY1ZWg0ZlllcWVW?=
 =?utf-8?B?VGx2cjBBVVhvMTUzd28reVdpcGtINmdVUUl2TWNVdW5RaEtzMk4yczBodXVt?=
 =?utf-8?B?d2VDV0xVdW1TMXI4NFhaM1lrQXlTN1l3MWFOSW5aeVBBeGVZdHh5bi91c3ow?=
 =?utf-8?B?d1BvUWk2RVEvMzJwdHFYMHRHcnZtTlQyU1I0bVJwM2FKYVBVSUEvUGxrZThQ?=
 =?utf-8?B?bXhoQmZ4S01GT0p2eTRMNHB3TlJFdUtENlovOVRKQmZDdGh5c3VFNUJEclVR?=
 =?utf-8?B?dHFvL2dwUnVYL1cxV2t4QnZmWGJWZVE4MG51Wm42Qks2bkZlRXQ5OGRicGlk?=
 =?utf-8?B?UHRZazBWd0hnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825ae2ae-d4bd-4c01-6bb1-08da03ae2137
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 22:26:04.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjViJSdMeA164K9TAu4n9ZJwILQRcOuoE+FckFphKVtq7m66GvD4qGlCiaaGHfKxxi/HU7zhEkGq1N7IEsINIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3588
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10283 signatures=693140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110113
X-Proofpoint-ORIG-GUID: AkD49i96GlfN5MMKUVMXVKigv5OJzNNA
X-Proofpoint-GUID: AkD49i96GlfN5MMKUVMXVKigv5OJzNNA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 18:34, Dongli Si wrote:
> From: Dongli Si <sidongli1997@gmail.com>
> 
> With nested virtualization, when the guest hypervisor runs a nested guest
> and if uses "perf record" in an AMD Milan guest hypervisor, the guest
> hypervisor dmesg will reports the following warning message:

I think it might be clearer with L0/L1/L2 terminology. Maybe something 
like the following?

"With nested virtualization on AMD Milan, if "perf record" is run in an
L1 hypervisor with an L2 guest, the following warning is emitted in
the L1 guest."


> 
> [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076)
> at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
> [] Call Trace:
> []  <IRQ>
> []  ? x86_pmu_enable+0x146/0x300
> []  __perf_install_in_context+0x150/0x170
> 
> The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host, while
> the guest hypervisor performance monitor unit should avoid such use.

"The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host (L0),
while the L1 hypervisor Performance Monitor Unit should avoid such use."



> 
> Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
> Signed-off-by: Dongli Si <sidongli1997@gmail.com>

Tested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
> v2: Add run_as_host function and improve description
> v1: https://lore.kernel.org/all/20220227132640.3-1-sidongli1997@gmail.com/
> 
>   arch/x86/events/amd/core.c        |  4 +++-
>   arch/x86/include/asm/hypervisor.h | 10 ++++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 9687a8aef01c..14cd079243a4 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -8,6 +8,7 @@
>   #include <linux/jiffies.h>
>   #include <asm/apicdef.h>
>   #include <asm/nmi.h>
> +#include <asm/hypervisor.h>
>   
>   #include "../perf_event.h"
>   
> @@ -1027,7 +1028,8 @@ void amd_pmu_enable_virt(void)
>   {
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>   
> -	cpuc->perf_ctr_virt_mask = 0;
> +	if (run_as_host())
> +		cpuc->perf_ctr_virt_mask = 0;
>   
>   	/* Reload all events */
>   	amd_pmu_disable_all();
> diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
> index e41cbf2ec41d..fcc66c23cc72 100644
> --- a/arch/x86/include/asm/hypervisor.h
> +++ b/arch/x86/include/asm/hypervisor.h
> @@ -73,11 +73,21 @@ static inline bool hypervisor_is_type(enum x86_hypervisor_type type)
>   {
>   	return x86_hyper_type == type;
>   }
> +
> +static inline bool run_as_host(void)
> +{
> +	return hypervisor_is_type(X86_HYPER_NATIVE);
> +}
>   #else
>   static inline void init_hypervisor_platform(void) { }
>   static inline bool hypervisor_is_type(enum x86_hypervisor_type type)
>   {
>   	return type == X86_HYPER_NATIVE;
>   }
> +
> +static inline bool run_as_host(void)
> +{
> +	return true;
> +}
>   #endif /* CONFIG_HYPERVISOR_GUEST */
>   #endif /* _ASM_X86_HYPERVISOR_H */

