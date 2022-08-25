Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE55A0EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiHYLEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiHYLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:04:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B3AD9BB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXrqVUP4GteciTUVSTLM734LVCGiU9j/k2+6ZxHfvR6SIoSohMCw0ZEMma1WUWKdfRy+yxp3Xzy70FLAzcJVbIvQaZPv+k/ncSljgkyT2aBOfwTFmolBPqCVEeYUTBIcyuTcU/QOmKk2WdN25ZIVdUKsndp0Ss+hyB7yKU9ZnvBBGsaOI1hCN//UNyQQMhIA8K/vEoXbU8eo2e5aKdUyRmaBQEuT9KuBL5fbw1/NvLG8eTR8DSKm+JWb4LjsZ+li5zGGBT5rI9UjsEC6I2E3aP12UtRb0MqJqJSSL9VR/yzgNBpsglh2ZEDeRnzZq5U9s7Z9zFGbI09rwfEJocd0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYOQwAcwIkeb1EHXSYC4vAbLSSSuP04wfDdIY2XG1rw=;
 b=eEccZvpKwvMzSwjMfLqelSPYNK6SbVO4yPZ+BBRbZikFv48AQRRO5srZPjD6EkdhykAjbxgJMuUCbNVFxHjD30epL/goSsCTH5onhW8Pr4n56vGrWRHx1F5Q9Q8FBLNULq8Rd63hCArQ6wEdUpp9MzSkximUtuEOZq07JnAhg+LE6kKtk7fpy29OAOOPCk+kPlmJINPynSpCTIeWwzGSnjx5YIFG8NSX3ij/+gpFM4xhxcmwJmw/mlmmh5508nHT1FEuAIh4nZylJHNztGs8kEpjT6EiLj27QkYTI84LkvOS78gPoCZLIJ5/2zJjhx9aR1EG5YcfEP0D+/rp5IbUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYOQwAcwIkeb1EHXSYC4vAbLSSSuP04wfDdIY2XG1rw=;
 b=avSGn8EgxyFt71Eief/3Z9CqF90T/mC8uzc2MR7dmb7rWdkZLh2kKTOPxunqED1k+KqRcyPt2jW21pysSGg7TRRFgqvtzNg/U/teLEej4sxrYXTJMW3+ihQh/Ey2dZq592iZgw4tR2z4XXgozFC6BNg7tu6H5KSCv6spFcEMQMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 11:04:06 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 11:04:06 +0000
Message-ID: <05ba363d-12e4-83ca-fb20-203c93a27f3d@amd.com>
Date:   Thu, 25 Aug 2022 16:33:51 +0530
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
 <YwYWUbVvSAYseDaO@worktop.programming.kicks-ass.net>
 <YwY8u7gx6bO+RBcg@worktop.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YwY8u7gx6bO+RBcg@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d97b6911-af4f-496c-4534-08da868986f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrF9gmalA4BDT6YN8E0MqamUzp2d+Vqa6cISrRllLASMA+8fIC8WMb6NvaDiT/k/ZT9nn9QR3pnERxw8/OAPX6Iwh1H62YJYMW3wWsL9CLFRoOoEsKze9Q8y8snpxoopq+PvPG6DA0Camzk/cbELWuAneC/vqhtOwpBuJXllz64lwNidEWT7dDGGE4jJXsn4B4I0p4UdIGgkHDmfZzO5WXTCnTb+aMe+if9fxDmA/+1Y5YKxBTT+3ejpT5MFRWHKfStZqFU6BIc1sHkkusT9D7aRlZAg1hzTCae8+8itE4gBoZTO9uV15wxf8CX5OT6apMlMeHy2e2/PWfUHVynQWYWgyB43NsvZXgpWv/6moj64jXWVIEZrA2J7yxKaIoENaTCGb+wJAnBFt7F09CBY996U2D35UEIFfKVCKxy9msTd2Ax9KiEDdixNJMYKyGViu6yOVZmi/gclsasuapnvdoh43ss2rel7c6DnZPUmhSzJVI88fVm2pUuoNiHWmHpluyVm0m1UbHOygd2r15I0j/5vWa/3qCgA4hmFa4YPw3ox80XeNzK/XKqJYKnKhaW++aiFBfvQej88q10KFK5rBjxPkzc6Nk00YrHBLwbwWzN7eXM7qVq1srdvcrIONbLEzzbIjbcR5BKYmef2KoLxU7esQxqDrmpja6PW9qxG+QLHkbmP1hG52moIev+nvPea67eqzo8r5za6pLIY5nFt5mNcj6X3lJet9+6AA+N+sUu3f+OCHM+ybaCIO8fDGPZW/LSVyFwmYr48CEp5D31BMoGuSjRcVo6QCw53zG3BmvNJv9joFiV/qQnrWl5U6PHE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(5660300002)(4326008)(8676002)(66476007)(66946007)(66556008)(478600001)(6486002)(83380400001)(86362001)(31696002)(26005)(38100700002)(6666004)(53546011)(6506007)(6512007)(8936002)(7416002)(41300700001)(44832011)(2906002)(6916009)(31686004)(2616005)(316002)(36756003)(186003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHc0U2xoUzg3L291NTZnTzkwVk5ISFVPMHI3MVhOUk5VQWg0OHo3cGU3WlE1?=
 =?utf-8?B?Mnk4OXNZbVdxV1ZhS01FTU1nbm9WeG8rcmZjYzJ3Z21sdGJBSnFxSHAvdU5q?=
 =?utf-8?B?cUtwVGYvWlBiTGwxRk5vaXhpZ3dJNmJIYS8rM2tJbXN6TVJHT3VVOGZLTHNX?=
 =?utf-8?B?THNETkVVelI3UnMvSmkxK3VTcG44THYzVC9ocFJ5NVJRNmRJYnFaUngrbHpT?=
 =?utf-8?B?S29JUytQM0xIb29GUkdqZ3hlS3NHYkZ4Q2FVcldFRzZ1TEZQZGx6bDJBcTM1?=
 =?utf-8?B?VDdQUU1sWFBHYTRVRS91dnpuVnZtZkpsVm9qcnhVbUVtelJ6V2VYZHZOeWNw?=
 =?utf-8?B?bTlRRGhyNG5VaXE0V0JjWXNqZ2RWNzVwOFFWLzNsa1ZSUG9MZExqeHJXMWR2?=
 =?utf-8?B?V3lPbkU1S3VIcVVGeWtETkQ2UzdzOWpYTm1Za2JseG9NRFFKMzVCNjZOcFRs?=
 =?utf-8?B?SU9vbENaUU9LWlp6TVYvaHJ5bjI2NERRRW1FN2s5VUpaMVZYcGs4dUNqdHdJ?=
 =?utf-8?B?ZURxcW82c1RKMlpaSldQRVBaVzd4MTJBV1NsMnBBeEszUGRnSDMvOURaNGJ0?=
 =?utf-8?B?Z1JTSnNoQzdHcUFYQTc2bEc5U3RSeWk4MFNNSHVDKzRadGRNWVNLY3RySXgv?=
 =?utf-8?B?M1lMbkhSeXIyaUJ2V3NrdDdGT2loWkF2V2ZyOWZMNld3OHYzWCtXaEsyWnF0?=
 =?utf-8?B?TVVWMDdVaERSODMrMk1EWUpTaEdjMG1XYWd3S3BKMk1OWUtuVlZURkN3dzVQ?=
 =?utf-8?B?ZHEwckRSK29PZ29DWmZmT20yQU0zK2xoeGF2QzNtWVZaNWJ3KzMxNzA1b1VF?=
 =?utf-8?B?eFBRMTVrVUR4ZDhVdDdzaGxCam1hVjV0OUx2L2R5Wkt3eTVSV3BPZVJ0WmVp?=
 =?utf-8?B?UjJPQkVMTlkzNnNNaDgvMnJNYzNZcURTcnlXaHMwTHY2U3oyYjFUaU9WS2RU?=
 =?utf-8?B?TFNSWFliRDlqT1Vac3V1YmhsR2FoSk10T2lpa0JjOWFXcGY1b2pvV1dvTkhq?=
 =?utf-8?B?QkNhZEE4V2pDUlVhV3VmZUJwbUNiMXJjTjY2Vy8wUUsxd1cwd1dsbUM2Q0xP?=
 =?utf-8?B?UkJZblkrVDRGZ3ZnSjZHdmpJYVgzN0wwNzZtYm5FYVRianFVQmsyNW80RzNN?=
 =?utf-8?B?TFBCbWNqOVNEVWNSaFFOUTlOWmp1SDk3S3JJRjFJWEc0UkJtQkc4WGE4K21O?=
 =?utf-8?B?cVhGaWsvNVBMSHpzN2gwaGpUYjBMSGdwdzlJdGJDZkw1WndSek5GSW9zYXZ5?=
 =?utf-8?B?NTlZMEJFcVdha1NmczdDQ21rMjVHc0drWUUzajBrYkR1YkI5Y2IydlhNK3JJ?=
 =?utf-8?B?eFlnSGdWYW1QYndFWjRFRDF2dEwxMzIrQjVHand4R2VHcHpIdzlCZ2lyUjgr?=
 =?utf-8?B?MC9hSzBJczBLMUgvTUExbWEvUFRSdGpzZmtnRXB4TjFrYjVJUmZEOVd5QlA4?=
 =?utf-8?B?UFN5bTVTaExvaU9UdWZOSXJORDB0ZnJnR0Q4SHZSdzhubHhscWdIZTBBNWF4?=
 =?utf-8?B?QnJVT0Y5Uy9ZZTIvdzh5MUZ1UldYUDlSc0N1ZWt5Y2xMSERuK1ZpMlJyeDNu?=
 =?utf-8?B?U2R3SlVXOGc5Tkp4bXE3Y1pjWXYwWCtkYTdKSFRNZE11aTh2ZlFjTjZHUHl1?=
 =?utf-8?B?RTNPWHFZK2ErSVRYR1VaQ1F0TS9idm1pUGVRUDg2QWVaQ21uYUlYWkxRNDQ5?=
 =?utf-8?B?M2NVY3lieW9vYVFsMnNHLzM4V2tnUDY1QVQySThLUHFEWklZT0M0ajJ0RGYy?=
 =?utf-8?B?eDcrRDlHVG9LdnZCZHBsckNtM0Q4dFhQNGVjanpDd2RhbWdpRkZ6dnk3ODBl?=
 =?utf-8?B?b0VXcitRa2lyN1pxRys2aHVrS0wva0ZRZ25vY29zTndyWGRYbjI4M3V0WWxa?=
 =?utf-8?B?MW52K3ZEQlE5bitmUFpxNWcyS2t3YWlHK2JYUmJrb1NLcVNLK2F1Ykt1Z2RW?=
 =?utf-8?B?d2lWVU1pbU9VcHg1eTBtbGs4czhCVHdhRTd1T2x4bTVHV2dCY29MQm1QS09v?=
 =?utf-8?B?VnFUQ1FpTzl4OUIxcmNLM0paNHBZdUtrTTdvRkw3MjVtcW03VnE2RW95eEhN?=
 =?utf-8?B?K2gzR0R2TkhnaEpwZEV4WlVjRGUvUnhsdW1NS0s5UzRqSHcwMlhmQ1Z0OWc4?=
 =?utf-8?Q?zVpssVITA4hA1qI8I/sYHQnkM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97b6911-af4f-496c-4534-08da868986f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 11:04:06.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eyRCQG+uzfZI/8+6oEZJqBAkv9CobPKtmFllgYEGrVbb4PQ0IOFBxSUVmjiePvmXDKwERlWaB3qEYhfuROK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Aug-22 8:29 PM, Peter Zijlstra wrote:
> On Wed, Aug 24, 2022 at 02:15:13PM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
>>>  void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
>>>  {
>>> -	struct perf_cpu_context *cpuctx;
>>> +	/* XXX: Don't need this quirk anymore */
>>> +	/*struct perf_cpu_context *cpuctx;
>>>  
>>>  	if (!pmu->pmu_cpu_context)
>>>  		return;
>>>  
>>>  	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
>>> -	cpuctx->ctx.pmu = pmu;
>>> +	cpuctx->ctx.pmu = pmu;*/
>>>  }
>>
>> Confirmed; my ADL seems to work fine without all that.
> 
> Additionally; this doesn't insta crash.

While collating this I came across armv8pmu_start() which does:

	struct perf_event_context *task_ctx =
		this_cpu_ptr(cpu_pmu->pmu.pmu_cpu_context)->task_ctx;

	if (sysctl_perf_user_access && task_ctx && task_ctx->nr_user)

Not sure why it does not lock task_ctx. Should it be changed to
something like below? Untested:

---
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 016072a89f8f..747415a5f2b2 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -806,10 +806,19 @@ static void armv8pmu_disable_event(struct perf_event *event)
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 {
-	struct perf_event_context *task_ctx =
-		this_cpu_ptr(cpu_pmu->pmu.pmu_cpu_context)->task_ctx;
+	struct perf_event_context *ctx;
+	int nr_user = 0;
+
+	rcu_read_lock();
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx) {
+		raw_spin_lock(&ctx->lock);
+		nr_user = ctx->nr_user;
+		raw_spin_unlock(&ctx->lock);
+	}
+	rcu_read_unlock();
 
-	if (sysctl_perf_user_access && task_ctx && task_ctx->nr_user)
+	if (sysctl_perf_user_access && nr_user)
 		armv8pmu_enable_user_access(cpu_pmu);
 	else
 		armv8pmu_disable_user_access();
---

Thanks,
Ravi
