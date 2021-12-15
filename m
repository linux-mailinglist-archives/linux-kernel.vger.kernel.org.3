Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9F4759B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhLONd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:33:28 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:59278 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237423AbhLONd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:33:27 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFC5osT013675;
        Wed, 15 Dec 2021 13:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=3QGxGSBbj6V47n81QRT6T2W8fAaJHgS2hu5pE/5Zv/s=;
 b=NboTlP3R/jgwXBeBsAqgInH95b7DJhuH0bjojCxvlz9KgRwEYO77KW5TKMnW9pa78Qu+
 F4W+dRTcZQSChholsFeLpK8dG3RQUTd2gF8f4qSyzw/pJiQ+pF41TrvF8aDfEk0a2REt
 bVuUnx7A106k6+5ZRqk5raFnX6S4uD5da9JaPYpLIPH2cDV28m85PInJl06dRTjbGTPl
 JV663aFXSvXyoJnIopcR728tDIp6tNt+4RRMgRBHKQaksXlXwCZuCH3jft731JmpuAyG
 CXntkhNrh6p09Ufb50HlLiDVBtY0qSyinXLPTNovl1kBPjdyy+JFfIx1UZlZc7/O39qt 6A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cxhsgh9b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 13:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtW7XFLqn2GFP3S5Oo2nYJyvXehopEA1gepy9ErBv1Ibq/lMRHxXJQ710e9vFt1BEm8pLTQQVPyOHmWm+MkrRz7yMqiYe2BZaVq88vFoe3+I+nN4xOVVoLr3KDeUgV2/xtn7SOBYGFslJoss9VeNgzgTYVp9Uz74dOkbNbCu/oKLW74EtFCRRZ6ryNnqlubFl2BUnqqODPf+geDYtTfXSJM4X78j1HOT4A4B0vN8hFJU164ETONLPjI79PcF233hz4H2qu+MqCvVV4n8JfKg5IaXUKLLwVHlJauV9EzntMMiXJAI6uyRJa7R2kS8iWxs3LsmE+QWQ1Q8fIYYyFTBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QGxGSBbj6V47n81QRT6T2W8fAaJHgS2hu5pE/5Zv/s=;
 b=klMELrbGr4Xm+JZ5Vs3PgKRL58KcgKnRsdh7KJc/+MjqPyJPkp1HHE/WSX17pXLsrc5X4R5i2J/fwBvlQyaLV0XGr9fylywnp+yyFOLQ26dYgFCh7rpRHGbYRIBTSKu4v0xh49cQc/q/4IBa2q5qYSUSJ7pA3Ho811C87M4jJfhFG4Se841S7QPYUDLG78oBDjQjcmhnAxsNKbEi/NTuxRgVPCHziwpW8kaP/Q8yJvbNq0c6aLIXggxecs326wjXzEgpn39Vp2qD2hsQzMtknrP9AKOKgEYMCVbtlBZarVkxEvbRRzOSOo8ynyD+plE0n7+hGL3VYxNfSem7AeGqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 13:33:23 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6%9]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 13:33:23 +0000
Message-ID: <38e37106-90a4-56e5-a34a-073c1c26467c@windriver.com>
Date:   Wed, 15 Dec 2021 21:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <20211215122912.GA1874103@jade>
From:   "Wang, Xiaolei" <xiaolei.wang@windriver.com>
In-Reply-To: <20211215122912.GA1874103@jade>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6847721c-c9cc-4498-06a6-08d9bfcf76f0
X-MS-TrafficTypeDiagnostic: PH0PR11MB5045:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB50450538CEA6F82AECDE2BBC95769@PH0PR11MB5045.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNTYY11FeftXzRPgwH1YmuAWI5GbaXJcVFfV0VkBdnDK4BM/6lDHzp3zeeAEY8efODuvBzgyA5Sl5NfVZj/aR8Ua0UNBjUKoRBBuH/cajc4b9rjy+KV0gJS2mberUkDGoxMBBGwTqhVyOTIZ1BfDHK8zAiWy3oLnt9nWWxbehcqOkwAnv66v/RZTL/8TB88nqZQSxJo+hZ2hwQDgVqQtLSY0Qfze+oV5VyN9DyZibUV5/WAkfPIwYhbIxYb04wlKt2s6oYBZhDJIS2gdzBZMwZ3xG80AaO4xZQvsWn8r/vY0T2hcNzwkY+eDi3BcsjBy15o0dAFZxk/Lp3WG/FOFg8vM1C86QvIOAemlsU5Qh5temQ3Tbw1Hu7Xqy5zzSWH3tOdfLSp7ejlGxtvN8UALwjWXKVkj/7yHAcxO2FTMWgD2gctnGerZ1Ax9YY2HlN6PrTTcjJAM28AnCEH2JGbF/7K3owAF1yLh4gv0mqoHDEBdOJNhMILmnEQf/a6dC0cyJe8o1MoLBnZYvLpvP/TpGvmZifKheci1Vm3Br0clNJOQcdzI+Rs0Tj2kHSpI44Y4ZkZiWe1Isyp3btos+6zuLMjsOBv80maqxVCl7ej7L+RgrhFiYPeTWfReCp5OtVEA3TswmgRsIzDZ1efi3dOCeG7fHfg7LC6pe9IOhuy5U8KWn780cmps0T9y3w2DOAr+FBwIQBY78CifziNGegw6R+qvYEeyKT2c6bWDZNYhO0oNiCUJhQO6FvaTgTAgnXU6d5VoxGBS1AdcAA3+p58nLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(36756003)(83380400001)(8936002)(66556008)(2616005)(4326008)(6916009)(31686004)(6666004)(316002)(66946007)(66476007)(5660300002)(26005)(86362001)(6512007)(31696002)(186003)(8676002)(508600001)(52116002)(6506007)(6486002)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRwZmpZYnBZZlZtSzBFdTlxMEt2eEh0WUFTL25qaXRyNXVSSGRJZHZobmJB?=
 =?utf-8?B?dFRNeGE3bFlKNFJkYWdqUWFGMmZCNjdydm0zeE9NTTBpWkdJQTNhUVVyczBv?=
 =?utf-8?B?ZjBDdEh4dHZYdGwyUWRDaEc0OUtITjhHNDZwUFE4bVpuT3c3Y3pwOWlRT2ww?=
 =?utf-8?B?TW8xWlovRC9iMFAwM21sQzlDcFJpaCtGcFVVTU5QL1hJQVZZQ2doekFNZHlH?=
 =?utf-8?B?SHVZdUc2ejB5UzFpSHRBMW50ZHdyVmpXS1JmWDIxeDd5ekxUU01XQ0c4dzlo?=
 =?utf-8?B?MHMrMWJ1dU9vUjEzS2NTQ1JoSUZQU2hRS0kzclpJOUtjejNFTUxoM2ZFeHh5?=
 =?utf-8?B?SHQyeTdSSjdHL2VkN21EeVdEd04rcjVJeVgvU3VhY2VlV0JrRlpuVWl5ZUpJ?=
 =?utf-8?B?NW1zOWVOcWJ2YTlodXAwMGNEbDlIOHNTKy9nTjZiVVp3YVNEWHdTQWh5eHBj?=
 =?utf-8?B?aU8ydm5QcElNTmN4ZFRVdStmY0U1VDRwZG1KMVJmakJ1UjQyNzJIWHhSRUcv?=
 =?utf-8?B?QVp2NE9tUWR3ekFqYWc1MzE2ZFNNWi9TZ3JnVDB0L1hLNU9iaGNSWGdZZ0Nz?=
 =?utf-8?B?c3crWmF4bzdGUUNXYXhSTG9xY0hFMU1NYjRWUEM1RXZtNUdoWC9qa01QTlkz?=
 =?utf-8?B?T0hta1BWNnRNK3hORGdTa0xQd3Z3Y3JIamRzK3Q4SndCekxMY1J2U3h0TGo3?=
 =?utf-8?B?SW8zL0krN2poNkU1eWkwbU1tekw2V1BCYnprajd5djZtTG1OU1FZUVhNMzgy?=
 =?utf-8?B?SVFxQWpMdjYwS0NlK2kySDl6R1Jic0VxTm8rNXpZMkYvL1k3QzZ1WkNDa25R?=
 =?utf-8?B?ZVpPZTF4dC9OeXd4WUhBSmxZc1JXUWRpZkxmczcxbVc4ZEtqWENUZGY4dEVi?=
 =?utf-8?B?VmdEejJYSXV1RXZ6ZUxJa3hNMWhtdEdvL29YcGxpeUhJSW5GMzBJWkRScDFi?=
 =?utf-8?B?N0ZIRXova0JvMkJ4WHZEdTQ4MTcyMnJwb0JwcHhYaTJOY1d6ZEZCUGF5Wlor?=
 =?utf-8?B?S1NlS1dSaytZRWE1Si9wUHVzTmlEZCtVZWJ4cjF6MGlSNEhSc28wb3g0c3gy?=
 =?utf-8?B?cEFRSW1acnlmdGU1amFPa0RZYVVZNzlyMENKTStnRkpyQXhOb1dnV2NhNFEx?=
 =?utf-8?B?Y2RFWWNCaUJsamkrUkVOb0srT2lneEcvTjJ6QjR2NEdialdBc1doNHpvUlB5?=
 =?utf-8?B?TktpZTI5ckxBUGxNMFZXb1YvQm1IVkY1VXFEUit5WW0xcU1uQWEzcWVqRVJp?=
 =?utf-8?B?TC9wUjJjNVNrUEhDTlU4Z3k2ODEyelE1UVJLc3haQU5VbEVmeTYzK292NVYy?=
 =?utf-8?B?SzZMK1htTTZuRXFRNHVJeDllMTQrUzNPUmFSWlprQWU2Q09TU1VFQi9jWmdw?=
 =?utf-8?B?bEdaUk1LUC9RNUtzdnJBSzdYVVVaVlBieFhRU2YvakpNUUE2NllsY3ZqeW1K?=
 =?utf-8?B?L2lwb2cwdGo4QWdvQS84MFlZR3NBZndvclRCOTJaSDR0OTdEYS9oSmp5OExE?=
 =?utf-8?B?Z21xWEliNk5KZG9pS25UYnFaR0V6K2ZLZ21OZUxkbVVseFhTbHlZRWd3OFZM?=
 =?utf-8?B?VXVwd2c1RWN4SDRZYlJiOHZTMWNZM2xwYWVGR1dOOWxHOTlDbnU4MDRWRG90?=
 =?utf-8?B?ZkROY3gwM0crU0tGdFg0WTdaRHN5bXJQRERDYTlOaU92bVl4UGxYZkRCUWtI?=
 =?utf-8?B?Y2svaHJwQm82SFRVZEZjM3FSeEYwdjg3NE9qTGRPbWphemVta3QxZWtOWW5w?=
 =?utf-8?B?QzFHaytTNU9OdFd5NE9UNXhCemxmeS9lRGZDOGVwNzNsTi9zc0VuZXhadjBn?=
 =?utf-8?B?UVFOYkxpZVYwMzU1Lzljb2p2VVEvNUx1MnhqYy8rRFVWOUpRRzgyN1UwaUV5?=
 =?utf-8?B?b3o0cWdzT1NKeENrTFNmdzNab3cvNFhjbWI4eTlURkM4TW1FTGZtOVBldEVD?=
 =?utf-8?B?M1psMW1NYjdQUjVFaW0vMGlQd3ZzT01KRjFlZ2JDaEptcy9XT09tVkVDbzZ6?=
 =?utf-8?B?U2VDdWxRMWZXQlQrSVNsY2ZQZFc0QjgxZEtUclg3K0lJMGNlQjBSdi9IOWor?=
 =?utf-8?B?ZENNaVRNbk11elBGUzNXU01EZE5aNnNRNkwyTUcyK0trVFN0VjV5RUFES3Q2?=
 =?utf-8?B?Wi81Y1RwWUpYODYxQytwSkh5c0Z1dXBYWDlPTkg2S3R6dUI5MTRIT1gzYXNN?=
 =?utf-8?B?TGwyVTNyWjRCZ3ZmcU5sUTQ5NVZTbWdZK0VqdVU0T2E3cG1NL29LTFFYaEF2?=
 =?utf-8?B?R1RiYzBoRjEyWEcxdEtlZGlxY2pRPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6847721c-c9cc-4498-06a6-08d9bfcf76f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:33:22.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFFws3zrMHd3XS0N26m/pj/pRovxkweLUcqs+8c9cciIybT0J6D21JU8BXFRymzdVCJrUMLvheJsZmw1UWNZmdR8d9Xbqk7S/ZyOakXbJ6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-Proofpoint-GUID: OKTeJTHpjTwwWQpnK8lH6CpU8UZZ7Azu
X-Proofpoint-ORIG-GUID: OKTeJTHpjTwwWQpnK8lH6CpU8UZZ7Azu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_09,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 12/15/2021 8:29 PM, Jens Wiklander 写道:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Mon, Dec 06, 2021 at 08:05:33PM +0800, Xiaolei Wang wrote:
>> We observed the following kmemleak report:
>> unreferenced object 0xffff000007904500 (size 128):
>>    comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>>    hex dump (first 32 bytes):
>>      00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>>      60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>>    backtrace:
>>      [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>>      [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>>      [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>>      [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>>      [<00000000c35884da>] optee_open_session+0x128/0x1ec
>>      [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>>      [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>>      [<000000003df18bf1>] optee_probe+0x674/0x6cc
>>      [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>>      [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>>      [<000000002f04c865>] driver_probe_device+0x58/0xc0
>>      [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>>      [<00000000c835f0df>] __driver_attach+0x84/0x124
>>      [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>>      [<000000001735e8a8>] driver_attach+0x24/0x30
>>      [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>>
>> This is not a memory leak because we pass the share memory pointer
>> to secure world and would get it from secure world before releasing it.
>>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   drivers/tee/optee/smc_abi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> index 6196d7c3888f..cf2e3293567d 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -23,6 +23,7 @@
>>   #include "optee_private.h"
>>   #include "optee_smc.h"
>>   #include "optee_rpc_cmd.h"
>> +#include <linux/kmemleak.h>
>>   #define CREATE_TRACE_POINTS
>>   #include "optee_trace.h"
>>
>> @@ -783,6 +784,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>>                        param->a4 = 0;
>>                        param->a5 = 0;
>>                }
>> +             kmemleak_not_leak(shm);
> Eventually this pointer will be freed below with the call to tee_shm_free().
> I assume than once the memory is freed it's not execused from being a leak
> any longer. Is that correct?

Yes, it is the correct way to release memory through tee_shm_free, but 
if a memory leak is detected by the kernel before free memory, it is 
obviously a false alarm.

thanks

xiaolei

>
> Thanks,
> Jens
>
>>                break;
>>        case OPTEE_SMC_RPC_FUNC_FREE:
>>                shm = reg_pair_to_ptr(param->a1, param->a2);
>> --
>> 2.25.1
>>
