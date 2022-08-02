Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431E4587708
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiHBGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:17:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638AF5A0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4/fnrxTsDWbjA7Ku8qnZtIw6myTOD+pBIlHKRxvVG7DNBstSGkMaPF3X6tlR+XiDuTo6aX4er1b2zUm6amw9QjvucK2z+rnKrXhbcXHjF4GuknVAFhcYsGXKkML9nz+z2InHsEEnYsNC1VvcA06xctZnQnfqFuM5Owiw0006W7yWoMLFaM0tgMo7JLxOtP/Bke8z6LfV/B3MhGQPpnOVnmIk1VKofgzGqPIMi4vgy3lUyAqDbq4Ws93UEerRJb3IExNsAyp6CiahvHbHXJ+TK2IKRF3ePjY36Q8j+Nv8sq/+p1PG8DI3NqH3Ug9pFxwafxKxF98E1M8mbwRt/yBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/c+0ja1qPuzmoI0jbFE9RT79+saqPLx/PQ4cRxJldA=;
 b=hpsdtZWs2WZ1n9x+WE8I+CKM7gnty77Xdqoj2V7RjP4wCJT6OWe1/LiDDQ5GMmVijdLlkPuhvl8Jd3tXP0XLquV1Nzc1YUJfhgMEPJ4nx6vVaFqJOl+gGzXLgwHDnydHEQi+XYta6pOVFYXyYPgfbk8X9Mz56ogu0x0Y1Y/4BMqoHXocOLNlWDMylj0g9/jsPGCM0xPxSqaTx1AUEvlhPpfuOlmAMtqSYSuJG9zh4GcNyK8UVzyJ2JUaSGYOHFGJHpLsjA4UmrHWKP0Vd07SnmeV+fzqNuiZJiUh8LrzjDuetT7pkjP3Qam/hWOp4FeboOilqMaJF61dmJplmPx11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/c+0ja1qPuzmoI0jbFE9RT79+saqPLx/PQ4cRxJldA=;
 b=oEYXIhJKg9C6WBbTeZpmXdxovh42L3mOv9gSwId7fsEsKLDV1hwyXIpy+s+UCuA9otl8KgBKdpz1REdBQZehCMy3HCQPgkD5av0tsav++az+GsWpECyXLoeXaCVuQWRoOFfFpT3F37qhtYV6TP8/yDhCODa9LmY2KHtjddcwy2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:17:39 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 06:17:39 +0000
Message-ID: <a7b87da8-cd78-77ef-dd93-7886d4197050@amd.com>
Date:   Tue, 2 Aug 2022 11:47:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC v2] perf: Rewrite core context handling
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
Content-Language: en-US
In-Reply-To: <20220113134743.1292-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc285aa7-8a51-4c24-1e6c-08da744eb30d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tK3RZ6/w8UDhkTYIRKCxcVxqI93gfC+FY/4qIKCdONPBJA5ZslAt+7F7rmKnxo4DMUgA5pO4xJjoSYsb3aVU7OjFuarU2cRZDYIPXURHSfnNAThPG0zbSw/3qdOBEAOurJQnVFEKc8MCI2YOkkC7KBzbgTkKw+YpVSWg3ptC0Dy7IJIa3YA4BMQ3+Z3xfA6RIebHbMGdhr5QoARMOBrABNAu1Ci+f1G2Fp3RoqnIcpr66ENJX2VyrhBN/J9LAwlsrEy8kL1YQ6tBEUkKfryaVlodk/jquvWVt3JFxmWRaBTFiikgojtZmmzWUJ1AL25HiV4mrSetKLvKDeWYZTIO5l9L9AepU7+esqKMfQ3cgHe8/7kd4cWLLMicGO5Zz+aZNc4mzo3A5swMQ5Dx+DXjKlvH8lZejk26Y9JFAShWHARzQiztxW3QFJPk2ev/popECQiYuljqJtzD7y0doQQASKpui+FJL/KdcrNyE9zqziBhRL8BeibqVBVewdMti7xcAQXlrOuT4qgML3HyLLgQlYcfIhMa5ZORYMXdcunqeS5Llr9LYJA69m6MxCgIRAoQz/rPKh7XRWZ5WCfPIYvYwKhgdbl37qOes/1F2U3fxEL/92eRGFQj8JacPNiXCi0xH/kpHLnkShQGQuRsDGRCs+vck9lxkEFsX3thhsjtmMLlyBbIPdGJ+EBQKbk1GZRYWBQezq+j0J3Z6i7nyFjK5Ag15WjqzFlWRPoqlsVI9c/iJpxdH56Y+u3S6zkLntQphYVL51gn+GTEivloS0zTplO/26M7YwTtzxC7+93sdazxw4dbfGVOD79J6oFUZyDZvKTI5NYRJP+LvXvw+wTuvY+JK++2bKya8p7F5urRArI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(4744005)(6666004)(41300700001)(478600001)(5660300002)(7416002)(2906002)(6916009)(6486002)(316002)(8936002)(44832011)(38100700002)(2616005)(66946007)(66556008)(66476007)(31696002)(86362001)(186003)(36756003)(8676002)(26005)(6512007)(4326008)(31686004)(6506007)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1VFY0tCaXc5UEJnQ2taMDBuS0FQVEc2aTlnMjd1K3pJVjdCZFd0bGN4MzhT?=
 =?utf-8?B?aVJmdjZPUTAvWG1LRThrOFhMSEpYT09VbVN0K1lmOHZEV0FJRm83blhUQlNv?=
 =?utf-8?B?elh5d3lhbkJXak1FVHA4cWdPTms2UVVTOWNNQkJVajNOajlnM3VKRlBjOXQ5?=
 =?utf-8?B?MVU0RnU2V2EwWjFkK1BFZkJGQVZqb2tjNlh3R1VQeXFpMDhzelBqMWtMekxs?=
 =?utf-8?B?emhJSmxSZ1ZkSUdpT3A2TGNtY01ZR1pTSG1PWTl1cDFFemJiZU1uTzBwbXpm?=
 =?utf-8?B?R3FSVHpIU09zNTlzc0MzV2VsZXlYY0pDcC9NcTJzS0xtZkZQRkRBSXJVd0Vj?=
 =?utf-8?B?MHdvZUJtK0x6NVZhK1IwY0F6RllqQ1FSUW0rOEszd052Tk1jUVZsL012SjNF?=
 =?utf-8?B?WVJjWjdESFRoRk1veXpZT2loWWRscEJjSkZLdStCQXBpZHFUVU96M2NCaEtn?=
 =?utf-8?B?UFhFL2o3QTk2bXA0U09IYUxzeUNqbGN0ZWR6ZTh0aGF3MHZiNlNSTUlvNS81?=
 =?utf-8?B?RDhQME00MWg3YTRSNVBLaEUwMDE0dmpkQytrTjBKSGNDQ2JabjZTOS95dGZk?=
 =?utf-8?B?NDd2dG90NkpIeHV4QnBXRjFwbGp1bkJXQ3U2NUU1bkRrL0RRY1dCd2hxcGps?=
 =?utf-8?B?NDMxeVNxK3B0QlY1ME13SG5MOW5vc1NEWk1ULzhraDFOM1g1L0pJb2hCRi85?=
 =?utf-8?B?cWFxTGsxL3pmMmUyTjdKc1g2TXJZN2s5Q0c0RVgvT3FLcGx2cFJiNFBML1Rs?=
 =?utf-8?B?bklDL3JOdk93aWtSRGRZZ28rQklIVmtvaVVDSjgyQ0R2dFh3K2pOcnZXck4y?=
 =?utf-8?B?OFdiNUFuWFoyUHJEOWVCR2hoSDF5bFRTNUtoMHA2UlEwenZwTDVxQnN5WGkw?=
 =?utf-8?B?OVRRalVZRHV1K2NFMitpMnVxU1pDYy96bVNCblc1K0s0RjBXdVNpTDdsSDJW?=
 =?utf-8?B?aHNtemsxSGl4VmdGbUdPL05QWXNpbk5MTENDMHJ1NWYrVndiWEFNcmpzQ0Qr?=
 =?utf-8?B?Y2FhT1d2UEFEUEs0K0ZzRnpFYWsvQUg1VEV2Yit4NW80U2x6NFhNcWhoc3hN?=
 =?utf-8?B?bmloT3hIcXhGNk85VjBNUDZZWk84Y09xMTJvS0NPaXJGOVFJeDJDbFl0UHp5?=
 =?utf-8?B?UnBFQUlkRTRQcUZ2SkNsRU4zL0FrY3VpTWZiU2pxN2ZyWS91N2Z1ditjZjBP?=
 =?utf-8?B?cjVlcjdEcm8zOUMxeDF1UXhrU2d4UmRYdXRwZSs4WjVQUURLTVRzTU1TQllN?=
 =?utf-8?B?Z1NPN0lOc1BvRm94Slh0Mm9iU3VTZmJoZEtTTDhyTmNCSStWNkhSUlZXaXZm?=
 =?utf-8?B?Q0FwWUpRdGtCNmhRV0FHSHZHKzhsNUhSNDl4SFRLc3VlZ3Y5UmQ1RzBKMlFs?=
 =?utf-8?B?ZzVtcWZ0WHlrb2lEenUrYnVlZm9XZytuSUg0U2NVU3huRFdzRDg0aDdnQytY?=
 =?utf-8?B?ZzNEV3k3WWZobXRPWmtRRGJ6TmRtREUwNlNhNUZ0STVEMmJQRWpaOWg1eHdu?=
 =?utf-8?B?dHdtWUtFRWZVN3pwK1hmZjJHbC9RTlJySFk1YTdmNmx6cEsvNnBnQm4wSDRy?=
 =?utf-8?B?Q2phUzY0UzJrVFFGMlVPRG5tdGVNaGNmR0o5SHJlUm11Ly91aXN1d1RMMHoz?=
 =?utf-8?B?bk5SblBMdWdHNy9PV2UwbWEzaGV0N3RPY3JMZ0ZPTHREY055aEE1MHBBMVJM?=
 =?utf-8?B?ZFNOYkczbGxla2VjNm0vMXV5VWd2UXhocU55aiswZ3RMalJpNFQ3SEhBNmVx?=
 =?utf-8?B?ekEwbHZiRllMSHkrN2F0K2NWT0JRYVpIaG1KcVJKRzFjQS9HL0RVeUN4NDFK?=
 =?utf-8?B?R0g5MEhMcnBHL0l4MGRGQTRCNTVKVC9vNVJyVUFYTGVmQ0lhUjhCY09RQnpX?=
 =?utf-8?B?eWdybEp0WjdNQ2Q1UERRcHRLNzFjcjlFeG1OOXI5UGFQZUYwd29tdUZGMzhE?=
 =?utf-8?B?Q2dFbzdiUktDNzhXMWdvVW0wUmdsL3FhL0RNbityY0lULzJXaFR5SWp6VWlT?=
 =?utf-8?B?VzFIRHAzSkR3cllUVmNCbkF0dVo0eTNZcDRreEtYQVJTQVNDMmR6MDRpVTUw?=
 =?utf-8?B?dnBDNzJvaWNGMHdQODlXRGphdTB6R1VkZWJqbGdtdjNqeWVYYXdKYmtxc1N2?=
 =?utf-8?Q?Jqytwf4VlgnyaUxfAZFHRwNSg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc285aa7-8a51-4c24-1e6c-08da744eb30d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:17:38.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvJekPAB052SzBXS9jm1QeXfRCEm2+08p2qsAmYld1xCfh8jidGbo6XgeKlleCOF4OQsNYL+o/70KHIM2veGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>  static void
> -ctx_sched_in(struct perf_event_context *ctx,
> -	     struct perf_cpu_context *cpuctx,
> -	     enum event_type_t event_type,
> +ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type,
>  	     struct task_struct *task)
>  {
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
>  	int is_active = ctx->is_active;
>  	u64 now;
>  
> @@ -3818,6 +3905,7 @@ ctx_sched_in(struct perf_event_context *ctx,
>  		/* start ctx time */
>  		now = perf_clock();
>  		ctx->timestamp = now;
> +		// XXX ctx->task =? task

Couldn't get this XXX, it's from your original patch. If you can recall, it
would be helpful.

>  		perf_cgroup_set_timestamp(task, ctx);
>  	}

Also, this hunk is under if (is_active ^ EVENT_TIME), which effectively is
(is_active != EVENT_TIME). I'm assuming it should be (is_active & EVENT_TIME)?

Thanks,
Ravi
