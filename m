Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64B2530D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiEWJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiEWJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:46:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0536710F6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpwBDUTX76Gs//SzJeg5hR7OR4BbF4G3yLkhzCke9D+VE6mUfWHYQOtnujyF5GkWQhVSoCv+2v67dg735czaKSvZ/W0LqdrLMSC5V05qOSriCWlw6RNb9IEiArjAaBbBTWjK1EU0KFuW8vIKqf9Q0cPCUqtKBJ4TiLROog3UOE0gLd9XNMQ/0Hqy+FOODbKNzYhSj8TmzXEG4AcQiVdh0BBuzfLmmgmRtOIMnLOho0LjcLAaPm2uKfHq6i1WjawQyXQli04dKcasTk8vNQRJkX9B8QkTV/YL0JDgjxWLTEkYZzm7kH21y50vfaGBQ+wM/4bZ63zXD0bX7vk716uOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt7NtK4Vt9Okj6sNuFiU5SGCTOZMQN1fv7r4ZEQfhwI=;
 b=WBlvK87ILxPkwSTyrmoIdv8d/YlIPkNMVgvBrmxgv4SFeMep4Fs7sLL6WonPaKPYJuWQUh57dd2lqCZ6LLbGue3MisOm/l8Oe7CKD5ML1QUGUSdLHwhXo7/r8dh6Srvh5lfT+SK2Fb6+8HUjXCugtQWV526/FS97wup870pFykmiB/lgGUcQCiJduFYift0RmnNqDyu01DvXhA74qW910fFh1bUgBWy65vrHB7Lrylb5fghbPGdRJQQQ/EGwV0DEmva+MkVPRoTr0oSaSk53xdoOn+tA+EDX0qL61l18aoO73ADixlrj0xY7AYUwgmjG8Xo71aktyRBWTEG9on+ipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt7NtK4Vt9Okj6sNuFiU5SGCTOZMQN1fv7r4ZEQfhwI=;
 b=1u2Gg2jksdRAEuwi2Ww7q5HjOHhrt8rtDQEkPhKuBXkhqgoDModFEdEnTsFhUitz8s4qC1ejE2usw5XsNWYjj4F4nEL2+nWBb3zwIvdJqbI09aablfo9+bsuHmeKACMlegtyvFY2InO0x/b6R7p5dY+yZG2w/mqYETfqldgW5FQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 09:46:25 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4ddb:baf3:4391:d58a]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4ddb:baf3:4391:d58a%7]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 09:46:25 +0000
Date:   Mon, 23 May 2022 15:16:11 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 4/9] idle: Fix rcu_idle_*() usage
Message-ID: <YotX4ywdUPJt0lNW@BLR-5CG11610CF.amd.com>
References: <20220519212750.656413111@infradead.org>
 <20220519213421.808983977@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519213421.808983977@infradead.org>
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2fce3ea-9105-42a2-72c6-08da3ca119db
X-MS-TrafficTypeDiagnostic: CH2PR12MB4069:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4069AC95A183CFA338B4F64796D49@CH2PR12MB4069.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXAAPwhnz4v3CWGx6u/wQyMm0tlKj9e0/CQq/WVxo2e6HHJzWNTKki8G+1NeXLcfNvoPrWxHZEhe7euv/yf4tH/js6tEJ5nUPNGohJ+lKllXOQ2GN0eWmhvBDwr3/4o31f23yB3Fznjz0XsSB8ZfIApDEGnGMs/N3T64rsK3VshgWh6AYKPf8AeYGFEVEw3UZYrhJRA1KKhpENBIjZ7dClB7uVdJsWI6ObgfMwsts90GaKYeHJr7siJkwyOM3U2/W41rskXWs9Q+hYJ0dwQd+TZ43WXgl19cOYoAA2n5NwZW00tUXTLhjJrkNjKIHNasA9JFZGepOk4eVRyr8ttUKPB7g8Kl5Ul8SEEzdQHo7fhIqb9u696/qS4daBYxXwNAhQdBlW1Y7r8E31UEe95DlqfURyTv5NmQ9h2esYfnA7cOMygdutYS69HFOBAMlxsCmF3T67msxGv3dgz4bJdCL/KfARqvvKVvDnmvxx1w9oApp8XdaEN7PKumqBN1zzxM7FdfwYP5JbBg0KdyptRk84gvavKwIkfYOmTZ1kI0MqpLwJjmYTYzNLKAVm5MSUcTzrxnQtBCgQR0lQLpOwKPV8W8RMp16dI9Aoo0U4XD8soibqdtxqNALn8DujCOvgAzVtl+fP+EvP2aSE2RkKaGjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(6916009)(2906002)(38100700002)(508600001)(6486002)(83380400001)(6666004)(6506007)(66946007)(66476007)(66556008)(8936002)(5660300002)(6512007)(26005)(8676002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vPjrqCd8Lh4fAKaSP45TTxFFgaHfzDH+fwQK4wFJ1ioEpRPTgg2D29qX8MnF?=
 =?us-ascii?Q?5MG76vdj+yujZh/oaLVvJzYIOgETIQgsy6BhhzEVSGo7MFxG3Mhvn1MUfI6j?=
 =?us-ascii?Q?OhI0GtU59e09Ze4/TOuSLcY5L8GEqcQekWIUrJXGc8ueddQal+8k1Nli5LJr?=
 =?us-ascii?Q?sP51bfkVsEoCNseMipMkDgWAzJpQdP4THCjbnzRoH5ELOzkptNwcag0s5Taz?=
 =?us-ascii?Q?qQ4wx5g7fMLcc2/liKMBkYh2y4RmGM4JsJBMM2N/JbFqFSlST6FsA0XQWpNI?=
 =?us-ascii?Q?TXlZt6hXF1gIvRjcnbOje4Wi5ZCt8cQgWRqJ2XmQWBptK9L9Gu1AVyy/AwlL?=
 =?us-ascii?Q?EP+FefgZ7idrWFf55LlxQUZYFSQPAxDVLpHyy0GUkZJLUAiIv6DBqvsyQKLb?=
 =?us-ascii?Q?asdc/PCvPxfs3YAfZWV5cpJ5zbd+EQg/r3UkfiJsfL5fKxL4CFdJreakYRxI?=
 =?us-ascii?Q?/v96yf+kD0kH/JLJGgkaeO910LMe0I8aLHdh3G17oFyDqLXOnM0p+i8HLJOY?=
 =?us-ascii?Q?SPQ4022caWrhxwWOBkig5DC7tQWtJWnA1vZeEEtutBeWWpJAua7f3N8L+Wsz?=
 =?us-ascii?Q?lyksbZeQ53//Ue7SWP1IJ97nDj0oMaQh4RCCdilcaEdqSut8n+dVRVJ8anc+?=
 =?us-ascii?Q?agCDNBEWOFQr+tKPMzBUUdy3GnJeT4++KSzjFNAFWUEQSRTRKXB50cs5SWVw?=
 =?us-ascii?Q?kC6KTqcf/dV3jCWfk9yig40P2vXZT4/yFQCI0XsgM3I31lIAEVRBL9ttAet2?=
 =?us-ascii?Q?yBHZNz3cKnKCXkZkxWinObC65gAV2ZlXjmU+W6vAm0N8S/qYsvToCfhdRccB?=
 =?us-ascii?Q?whQFYi1HhVby1OD7111Sevc1un0Nw7EquyFbsfmeLdT+TzL6OpkBi3BteBeh?=
 =?us-ascii?Q?lh6AjR4XlDEgMka7pruzLOZWvrh5vUAwP+6oIIeF5yLQMTbCnz8UWr8W9Pq3?=
 =?us-ascii?Q?EQIAU1AmHJnJGeNgdVLu/0jx7TMU6+VjXODIoxrXHeRYGIz5lcfSiL/dyPNM?=
 =?us-ascii?Q?vLSQcCP3YZt3g3vlCBbXDl2Tg2T23MwejMxxdKAYzggUVLWmTY1TCgI6Hvcz?=
 =?us-ascii?Q?u7tmp24Kje71NfrrUy6Q4W9137m//jPLtU1aFTTFD9j9QWdJYs+dH9AaSjpG?=
 =?us-ascii?Q?1V3QNg8JJFp1k4ABP6bb0Gpxvnz5kMfrCldcdWnZq4fIReFgWKeiOvfQxMKh?=
 =?us-ascii?Q?pXLYD8lTazeZh940/lLxvdKUKI48tf+BmtcJ9WQG1Vs+Zn60GKrKJgqeWyWR?=
 =?us-ascii?Q?DkLQev3c8LJlO64ZOZY4wl3/rOnOEhfZFEp16Ti/S9VuiTBAWkL3SHx0v2JR?=
 =?us-ascii?Q?+eaoXik9YDK6RjPbooyEb1nwDAzKyfBtB2emspKv+3Y530aKkm7if/zMOFfh?=
 =?us-ascii?Q?+j7uCTD0Vdw3J5EIT5nkzG5MwyowPLjzFvcO6mnE6I2dUuo6pcODCUlM0qzu?=
 =?us-ascii?Q?8V3ZMEihCITC48B36sCzD4phe9idZSwUxb5sS03OmYCNURfq5pkwrtLophO2?=
 =?us-ascii?Q?vwJ3KwZmsaOdU0vDhH5/Q+H/GYDMzBv5SQ+OnZ2TnjTRWFq1k9ItV3HbQUUn?=
 =?us-ascii?Q?Zww4wZ9szORGcei99GMZ/c4sTDwk2fhRBItXOvDr/PMQO9L19EjkTs/3Lfpm?=
 =?us-ascii?Q?C8cGSPfizVhQjOfBWjTLUpoTQa2m8ebIvMkXDan2F4E89lwqy4cPjDI5cuiq?=
 =?us-ascii?Q?BBGqnPQ79fDYXhVzC2G5jkwF6VZRiWKqNbQ52PBeHvlJdjYA6bvKMO88dLv4?=
 =?us-ascii?Q?k+0D+UNWEA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fce3ea-9105-42a2-72c6-08da3ca119db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 09:46:25.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiuKjuODbg+/5wJaaLAKcCVuNBnL85DOzASGrCZ7UPB8UOS/+9cZC/A6E4JOPgpeK4tGcsweMuMx+mrLKwXZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:27:54PM +0200, Peter Zijlstra wrote:
> The whole disable-RCU, enable-IRQS dance is very intricate since
> changing IRQ state is traced, which depends on RCU.
> 
> Add two helpers for the cpuidle case that mirror the entry code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

[...]
>  
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -13,6 +13,7 @@
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
> +#include <linux/sched/idle.h>
>  #include <linux/notifier.h>
>  #include <linux/pm_qos.h>
>  #include <linux/cpu.h>
> @@ -150,12 +151,12 @@ static void enter_s2idle_proper(struct c
>  	 */
>  	stop_critical_timings();
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> -		rcu_idle_enter();
> +		cpuidle_rcu_enter();
>  	target_state->enter_s2idle(dev, drv, index);
>  	if (WARN_ON_ONCE(!irqs_disabled()))
> -		local_irq_disable();
> +		raw_local_irq_disable();
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> -		rcu_idle_exit();
> +		cpuidle_rcu_enter();

Shouldn't this be cpuidle_rcu_exit() ?


>  	tick_unfreeze();
>  	start_critical_timings();
>  

--
Thanks and Regards
gautham.
