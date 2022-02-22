Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC81D4BFED2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiBVQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiBVQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:33:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8C78067
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:32:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUNxUjlfgozREInkhROu+Q0KtQ1g3/tlDbdm1Uh/bnAEDdCTXP+AC6ywYDBAe7UwE3OjNWQPGnNbZGIb4MALafKw91hl0Kbdw9tg9EXKlJmYlV1dbVSrnGM4XTdSduEHiseX86gTfXgmYu0QEq0JQMGX5nkDdW9SV1gF8H0KTGzVKKo3PHBac3s4U8roNhlRWb+yor3yN5e1HguIOISeozKGt/NswokNsCXRdhSlLSvJSL8+91HxRvNpzJkJtFe48qpO6BiPk/U753g2V9knm3M0b6+bfKo/lhgvmjhcKuR7DAkCEL5v8zHfanhaF640meGJKtRid4nEMNxlNvWGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUrD48/lKf99g7pxXn2ANNtaUcqrgcLYXES05dtmjUg=;
 b=CluUeqSSnpWra59DXFSo12pw2myReklj8uPbnP3tqVsAY1Ka1SL+9kQSIf/bk9JVAtkZqUkkVpIJixWaJDdPS8gES5TtH81riHyJlzHYY+QqEH/sz9FcTj/3pDzHNETPnUg+P3dPFbBXHAMpAgNwhm2G5nMfZNPp0PnRbdMEb0dj+tzoQF524eQXYc7rAYLmrinrxIaqO7togjTtWsRUHhZt0coIjQ1q6vZX8ZQJKyxTg+zj0DiPI1bB6gPGDojTiIDnKs5a28Io8MGwTzT+j/jwpsw4qzLgUX1I/fXPdRRAgmaqX0YW8+FJvku6lqKYeo6mc+lZkHuVtBeey7/RCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUrD48/lKf99g7pxXn2ANNtaUcqrgcLYXES05dtmjUg=;
 b=p2lxVNLGNyLsfKi95L2kudOu7X77jQ5X8UuF4FlG/wj88ZKu47DJJm28SilhVRO6TUBNuAyqBvam0/LGRUb6wgmpTWJPvEpGANJaNRFvETRf8BPuaT0AWUoYlh223slermLCQUTxpGoIkJfpz8MiYYA88WfmrRZsAjc7wdtYBQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BN7PR12MB2690.namprd12.prod.outlook.com (2603:10b6:408:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 16:32:35 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:32:34 +0000
Message-ID: <6b4d8615-4c60-3d89-5210-b495344cabd4@amd.com>
Date:   Tue, 22 Feb 2022 10:32:32 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] kernel/sched: Update schedstats when migrating threads
Content-Language: en-US
To:     peterz@infradead.org, juri.lelli@redhat.com
Cc:     vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20220126152222.5429-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601e52e4-8abe-4d37-cd46-08d9f620ee49
X-MS-TrafficTypeDiagnostic: BN7PR12MB2690:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB269081086E6A4A352C6AD72FF83B9@BN7PR12MB2690.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBnI4kK/13Cl76qITBysSbaHN2tYqEBaiRHt2a9+eUfJSajBNaiavtq3ncPJ4g5WnEybRbTvFhrnuj6BBVOnPXBNotc0DW4nFOWDn99jYByyvs7M2YDRW/TQ3LIKYY1bD0nnqVi0nDmvxY4boYpZ7T/v2keam0fjo0FYvokUAxuaei/SyWTewvFdc+ps0wWaP4HcWl3ua8EEL1vGPmqyv1aHCHhT22ZN6hd5AFEpD4XyqTWZDBRe7gIe7cFntAbsyRIftsAxWhFHHjECcFzp3apBxC9jY5oGnA28AhOA7Z7fu4uUEGpJUHY2w83EKDKSgh2QkCGDsjPnBNVzObbWirREWR+BRaibLA1i68BtnHmJtFUnTiIvgf6fBJO0x9v58yo/npn+ZkuGIRo+D0gbh15wKhXOYl2hCL70erxIyXvCYFdQrsMPRJH29b5+Yb4Cf1JeluEzdk2P2cQbIIyRTEnHDUB72wtVRBI4S6bzfvtVLcfdEs5d/RhAWtp+L5P3CtqO2RcwsCilD10uQu6WHdGy0N0m19pyONK27eCQPiiF20ma90uCYh3Y9YhFOJMO6oI/xzj+AM39WrTEdW2HXqvQujiKAMG6yFCzoQgDafYqa5DJVkoi87Uq31+SPZvZAe+B6kvr/Eb+vKnFmUYKFjLpjr09pmmaAE9vl2pSCbZByA5rjHnRFio4MylTynce4kq3KwFwTDY3F1J+KSOdr7u0x2DW8MgEC/SMClwf3WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(83380400001)(508600001)(4326008)(53546011)(8676002)(66556008)(6486002)(66476007)(31686004)(36756003)(6506007)(7416002)(26005)(8936002)(86362001)(44832011)(316002)(31696002)(38100700002)(6512007)(2906002)(5660300002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5lYkpabXlFWlF2Q0srMVE4TVc5eHJrcWZQdUlVT0xha01vS3R1eStqYWF5?=
 =?utf-8?B?cmNJRUE5OHBSNDFyN3Vua1BUUDNFMFpYVkpFd0dDMFc5ZlpQaVEzVXFJYWQz?=
 =?utf-8?B?N01NcDZlcE1xZkxqSEcveGxsaDZqYjVOays5dGQ3OWJkVFN1M2hYQm5Za1ZS?=
 =?utf-8?B?MThaWVVtdTJTOFRpcXYyQjlYTktUUElqaUt6RzNtdlNBRXh2WkVzMnVwMVZk?=
 =?utf-8?B?ZVZCbmc3MFE1UnJqOVB6M3VZVW1mMzFOajc4UmxUWnI0dlAvYnRvUXZONDVW?=
 =?utf-8?B?NGdCQUx1UEVadXEyQ0JMaFd1L1FMbC9WeHVrRGJ1dlF1Q2I0Z0ZVWENFL1p6?=
 =?utf-8?B?ZFBUNXZvakp2VzdQbHRzUXZzeXNvRlQzR1RrVzdmdUYzSDl4cVpEc2VLVlY4?=
 =?utf-8?B?Y0dERlZrdEo0OUNmTFg0a2d3NFFKVjVoM256QkpsOE1uVWpCK01HbGdWcjZL?=
 =?utf-8?B?VW8rclZYRlZiVFJBK0p1OWNJRTg0cmtvcGxKR3piMm5Vb1JRRXkvTVMzS3Zy?=
 =?utf-8?B?U2lNVDc2a1gySXlsQ1p1aGxGVUJpSFV3aGtReFlvSTNISzBWM2pyZU80bDdI?=
 =?utf-8?B?bmZuSGpwRlJwWFNickJGalE0QmlQamFMT05BeXdhcGtzMmx4b3FvcDY5cG84?=
 =?utf-8?B?RGx1a0VsR1pjOGV0dW5URGx3RDRNeXlpdEFHQlF4MmdkazY5ZHFPTlFadEh6?=
 =?utf-8?B?cGxpdGcyQzFwL3owaGNKY3JsNFpOM1Y5RFNxUWFvVEhNU2RyTmZBNUVUZjEy?=
 =?utf-8?B?dFF0TkpYcjZiOVNua0dvRWNmTDNjc2Vac1hZQUVEdXhwYlNiYjloTjNxOGxX?=
 =?utf-8?B?dmhYbnNPRVlka1VqVUVkb0IxejdrOExhbS9uNGdLOVRWcy80R0t4MXNmTE0y?=
 =?utf-8?B?anhQdmJkZ3c1VHc3cXpYVkNkeDM0Um1kSjlDaUZFTE1LVGYwY3dUMkJIRlpI?=
 =?utf-8?B?NEsrNnQ5MlpGS3A2cTVPZlZwdlRRK2NXOE80WUZYa01UdTFleStjRjJuc29U?=
 =?utf-8?B?Y3dRbDNSMHB3aWF0N0JMVU5jQ1hXRk1LcFNvMXZsY2thZ0FTWWE0MjE5QXkv?=
 =?utf-8?B?MVJXd1JEOTIwQy9wRnpmRGh6dFlPK3Y4UFA3anhFMUs5a3EvZTlkMHJYK3Zr?=
 =?utf-8?B?TVpOSGZQSGhKSW9Ua0F1ZVdqYW1jSzRNZXp0SDlvZWZuWGw0a21MZVJHVWJO?=
 =?utf-8?B?Mk9rcHJQMTdwUHNXamhXdGlxRmZSV1N6SUR0eXN6REYzSjNGYkMxczIvZ0J1?=
 =?utf-8?B?ZnhoK2Zya2lIUXF0NnRyLzQ0U3NDSnJERUE4REdQK0l5akplKzk3YUNBU1NO?=
 =?utf-8?B?Q3RKaGJpS1lQb3RzMEJEZ0gxUTd1MGJlODlRWExPbHhyMW1IZnVVaDd3T2Js?=
 =?utf-8?B?UzZxSUEwMEF1Z3pOSmUwazUzK0QwMjgvZ0RDMXBYaFlrMjZDTGVVbHJ1dkd5?=
 =?utf-8?B?OG0vUUcxVXc2VjZOSWRaUldrWWlIbzNPZ0tIV3dxSTNkOGRUVjB3MnBVWHR1?=
 =?utf-8?B?NE12OVFvZWVnaEpsRk82a09XU1pXSGhxd1M1WmhEOGY1cG9lMHBVd21DTmNW?=
 =?utf-8?B?aUl1NDlNeDlscHlpOUlVYUg0UlF0UnFTRXh5R1k0dEkwUDEwWkdvMUpqUmtm?=
 =?utf-8?B?SUJJMVk1RnBvbStVV2Y1cE42VjY5ZGNTNEN0VGR3SGdQMFhxZGI2Nk5XMSty?=
 =?utf-8?B?TStYczZlUDErblByd3cwK2dOWlJMd0JibytId01Za1pTMGRXK00wYzd6RHNQ?=
 =?utf-8?B?a3c0WGpqcGJTNXFsTGtTaUlkdjQ0UDNVU3JFaGljZDVCRmZGOU1NU21WWlk4?=
 =?utf-8?B?Z25aQ0hEUDVRWnZKNFBIRHFnbXJKZloyMTlnZHZLd1B3V09mSStoRjFhdTBq?=
 =?utf-8?B?dzdYTmE0KzZ2QXlkVzRwbzFHYlN0MUs0RCszUStOUERFZGlDcmM1SHBlc05F?=
 =?utf-8?B?RWJ5eU1WZXQzaWsyY2EveDVjU2ZnVjk4WnlkSUJzTlY0QytlWTZSZUt0S3pN?=
 =?utf-8?B?ZkN6T01EcElQcmxoVVdYZFpZc2U1Ti9saVJHZmpzaGhGd3VnbTNNSlB3dnZC?=
 =?utf-8?B?R3d1aFRITzVlOWtHdDhKbzhiQnpWTndET3NsTmpLRitxZXVRSFlUbDl5Zytn?=
 =?utf-8?B?T2I5N2JNT2h1Y080ams0UTRkSS92aUpwY1oxUFc2WUllTFhpak0vZHVrdE52?=
 =?utf-8?Q?7GtWm6yfeUgnrPHWkEmcGf4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601e52e4-8abe-4d37-cd46-08d9f620ee49
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:32:34.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1lKFaJxguEIbxOEB09dxfVkWmaXHuOg5WV8pGysmiP1yNKOSFbA03CkPKyJng1CQZvhXAnT0CpRWk6GnPOw3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/26/2022 9:22 AM, Carlos Bilbao wrote:
> The kernel manages per-task scheduler statistics or schedstats. Such
> counters should be reinitialized when the thread is migrated to a
> different core rq, except for the values recording number of migrations.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  kernel/sched/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fe53e510e711..d64c2a290176 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8757,6 +8757,7 @@ bool sched_smp_initialized __read_mostly;
>  int migrate_task_to(struct task_struct *p, int target_cpu)
>  {
>  	struct migration_arg arg = { p, target_cpu };
> +	uint64_t forced_migrations, migrations_cold;
>  	int curr_cpu = task_cpu(p);
>  
>  	if (curr_cpu == target_cpu)
> @@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>  		return -EINVAL;
>  
> -	/* TODO: This is not properly updating schedstats */
> +	if (schedstat_enabled()) {
> +		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
> +		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
> +		memset(&p->stats, 0, sizeof(p->stats));
> +		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
> +		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
> +		schedstat_inc(p->stats.nr_migrations_cold);
> +	}
>  
>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);


I would love to hear some thoughts on this. 

Thanks,
Carlos
