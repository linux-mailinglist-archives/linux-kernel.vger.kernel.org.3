Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C046530CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiEWKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiEWKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:02:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A368255A0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBgrL05DPusUo0puB1hua8Q1opBXyjvdH3pyBEec28wCGmEbwVe/OoAFs2+l/NVzH4YuP7a+rjWVy7luHPq9lGakWikh3x34aP+2wgTfwdMJgTOL02h1BQ0fDgr+BV7uPRZnpS/h+u3Ab/VM9ASYbgbwNH4ePgprbIKMYz6fwcwFsl+iKKfp6ELJXXyiWAQyCQgQJ7AmwLIsML+XhfWMRYUoHa5rpczO05yow9SYXz+G8JdTIkBj2ICa4fM4o3hlmlbaIRVWziozGcrK+Gv6pRF5RqbOcjNlFevHjLv8AY4FGPL1ClsExdIcNtctFNLC80HD5dczm/ovHxMcdzdTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Isqkx1g4K9adnlR0bhhpU1+HzPoCTDSULciv3+TISQ=;
 b=kBVSSI0br0q9DVh7PvD5tdXDA4HOvfH5yPVuYiqUFeUaTq5S0nwg7mD8eHo5Erv0bNToW/E16e+PEWz5E6Ru+DbLMPXd982/a2DK2+jfXB3Be/lWYKLZbcD79irR199kTwHzITHN4Gk7pl/OA3lm0WJND7N6w38M/E1fqpuYZV/ZFyOBIC0xXQ6L5yEsK3wZIc+tJDMsmrlHFhKh7D0EMem0Uo/7E3wFxf4MUBDJCySfmP+a4b74HXDS9IXfuWvi/d0GK+6amoQFfU19/mvYeUAZkcvyKwclWv9FQzzJuMple1VmjmW41muX7f6bvd89Xrf166gMwbjm9Ku31Ukrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Isqkx1g4K9adnlR0bhhpU1+HzPoCTDSULciv3+TISQ=;
 b=iTqgR9tj1viXveQnVjDEFn/PQsZJqNaMGn0zuPDRniDWk4xcGHtzHqku1y4QL66aaDQixdnRoXxialXy421e0f0ts3fu7kOdzA6e3gVir3lls6nQaS0Zq/A8BqGEzhEtH8aX6e7NbkZMBQSu46mkLRYGubqnEDXoSqH/G5jlFL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 10:02:45 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4ddb:baf3:4391:d58a]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4ddb:baf3:4391:d58a%7]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 10:02:45 +0000
Date:   Mon, 23 May 2022 15:32:32 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <YotbuODSnj+M+KaY@BLR-5CG11610CF.amd.com>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519213422.119695559@infradead.org>
X-ClientProxiedBy: PN0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::15) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebf34ccd-be0b-4888-5b01-08da3ca3623b
X-MS-TrafficTypeDiagnostic: BL3PR12MB6547:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB654705BC6BC0F2F1795466B896D49@BL3PR12MB6547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkiF95KM0/C99qKs0t/WkRte7aXsCgtvYHGOpOP6nYt/9JiA1HiUSV5QQYew8sxH8qtIs5dCzXIAPYZTdHzKUVD9vI6tAOsB8sI8rqvD+eqbgnD5SHsjwCroVCsUBWk1zUuwQnPH1sMCKJ0G2eVcjIseDt4RRSB5ns7icSXC910ej3SKTlljEbvQpBJCUOx46fpp8FpEfjKrD7N0WziUVn+uz9sjQmXC4dnAceXQCaCcZ2QFyKW4ik8YvMqh4y6yYc/TF7Usk5zUl48dwApU2qEbb8cM4dZlun3NpwgmjXxc+UXrG0VAiFmgsuFaH6N/7r1klRr0oGt/xfAJCtxYDYdtkkp3QGoVALRWtamjlUFtq9rhsVc6T9KLMJ586eZu6b2Vc7GchhxVXKNQpDnhvMIwVk1MpHT/avp7Awm25jiTJGxZFp3eIa0zqoKWl8MlTzXifxT9o0KDH6zHU3g0ScIIDL7qwHzjMRVI0PwjNI9DNiV8G5BWq2wsYl6t2/xnHGzHp81pR/k/vhH4YlRHb0n+OtAFeP0Vs/58klWaZiT17/OBJMKHAzwO0Fc2Bj9RxtmqWq8zMCMBfnif8JwLQg/onxmvFweXQeZN+1phc/94RioKwyiuS8HVWTEGMD13akLLAD8ym9N/2SzHuKv34w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(316002)(6916009)(86362001)(2906002)(66946007)(4326008)(66556008)(66476007)(186003)(6666004)(83380400001)(6486002)(5660300002)(508600001)(38100700002)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJUu8Id8Ytkf3mCheZ36oMcSQJHu00mUDt/cm9uLGyqrcVMISP2LcL1GSt3a?=
 =?us-ascii?Q?9YCr1HxMfFY3fu08C+gADnPkUwHEM0B8ZfosRAQiNfhdkdko37OV9ab3usjB?=
 =?us-ascii?Q?BCcTcEM04WTQE1iKlveQHZqJBytY0xVcQIZRFJBBP4qhNPbjSS4RWR43hMZm?=
 =?us-ascii?Q?qo7mOEy+TC/nxSA5YRJun1gV0l6mzhBYVekc7ojdow2Z+07giGnPYxIw+h7X?=
 =?us-ascii?Q?gas5vbP8w+1Eod4MAqG9dN+6/kMNSAF75xKKJ2KFnzef2cN/cmGgc7l0V1dX?=
 =?us-ascii?Q?A8UgwbKz1xW1Y0bL7KC+VaGYwpJEz4alV8gJXO0ONh6lu+WLVqx5MNEAXoZf?=
 =?us-ascii?Q?lqBE5TrolkCt7C+5Tb0VRHp92W4nR/pQexJa3/KaC5kSHtGE71gKobs4Mkv0?=
 =?us-ascii?Q?Q7KV0Uw8XpuIAt47wWDs3SkbXrN2/4g+c8Xg1t7AR4n/fbthwYMZxMPSSPdM?=
 =?us-ascii?Q?Ixi6/OVd50L2kxp+8N0VyNs2BaXz4IxAGPe3sGsI1CUbv3Km/ipoohqpyux6?=
 =?us-ascii?Q?YK+95LkPPlypzj65FzHWEvEazeHOaNEvYbA6KB8A/gJuZOvMFP/5aSXGi/TV?=
 =?us-ascii?Q?1SKf98iQ3dG9qAW/oAI/UqO/ZEkMiCSobDiyfV6VEFClvxwAs5En1a2Os7hX?=
 =?us-ascii?Q?F91ME+2QE2xEWZ2/Ap8izhjH2EFGiH45HQ5xwv3P/nNOFwCHoLm2NtIOCbo9?=
 =?us-ascii?Q?07lh1CO2RMwCf+W3MKoU4LbltibwFsICDWFoKLU1W9VJ/01JtUCD+dDSxshz?=
 =?us-ascii?Q?IznnkJZhPK3J0ggCcHoV9foaz6ACLAmNAJunHs6HOlJqwF4hQySmmbljMxrc?=
 =?us-ascii?Q?zBIwg0rsazMVO3MLyPpYD0eHGMaYAhc7fgJJWFSJ/rSEXyP6Aq8IryMwJm37?=
 =?us-ascii?Q?7y5y4SIFeZUwSTW+OT53ANBOJqA/CdXDpmwrhfLzbtkKhHfpb93z8OeszMQt?=
 =?us-ascii?Q?7coB3PLQ48r6HDUFfLGP63IhacXyiEXIFk3AT46tQfeAk1/jzd14xO3jwUmV?=
 =?us-ascii?Q?LsFBuqpXw+pp8Rx2J9yFaS5J9YnlMjxCCgkonv+B5QBR4S9qqr5zG8wbuFtC?=
 =?us-ascii?Q?7nNv1jQ82CEDngBzZNI/u6fJLWG+RmgqYSOBVKbPjalbcsjECmV97VcMwIAS?=
 =?us-ascii?Q?YeYi5o8apKJYPe/MHdVwiYvgGf20GMZ3/m9pt2N1di0gWt9sPJK53upfCyz6?=
 =?us-ascii?Q?iaD6uFkFRBTXVwTod87UiSSluL1Ain3f2kUzentAVOTUu9RqI3pDwPXhN5m4?=
 =?us-ascii?Q?6jqfB7rdsaar/WA/EkpXqFxyD5h61PM1/aShdfk9lbDrhV2DJP7ehTNUwlZ0?=
 =?us-ascii?Q?pzKQIQYn3oiArGm2v2bWLUGBnHzp+yuszCL9hmThGgI1zeYhpQTfmpNURKr1?=
 =?us-ascii?Q?nSEHbZyXI8aKSkTHejYCp5b09K7jLMNAx1wMGS6RXJBZV6rrL2ZPI90LzoAK?=
 =?us-ascii?Q?XqnSPg74YMVpZSWt/wqPUDqlgn5X5oW3ELP4f1DB3PZO1+ImVnf8M3KkUv6k?=
 =?us-ascii?Q?l+mKr+lOMbM5XWnUreE59mvrZ/6egcm+Hm9NUeBatlPIdsD9f0jpVpNnMh35?=
 =?us-ascii?Q?iLsr8l1/plHgyAB6l3XcIHUTTPLzlL3UXcWcM074m6TC4uHRn4cVRDi/4qjj?=
 =?us-ascii?Q?K+RQuN1UBQxH7vkbsPjg76UyhIEKVWOY4ThR299jLW6CvuCjXe/eKfkFob0T?=
 =?us-ascii?Q?yPiKAIhUsxf7YHdTZqJst8SAUDRsoAB43n06PmTuoBF8Q0KmKxczgKrAH62x?=
 =?us-ascii?Q?LGsSNJkVXQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf34ccd-be0b-4888-5b01-08da3ca3623b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 10:02:45.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfBpy9TQ2LVBJOexx0Ib99tCIhQgt/fsiibI6KWmjbhX2ylZ9R4h3DPImDPVcGIlhF/8xzxl6NSf6zWNsMkUxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:27:59PM +0200, Peter Zijlstra wrote:
> Current arch_cpu_idle() is called with IRQs disabled, but will return
> with IRQs enabled.
> 
> However, the very first thing the generic code does after calling
> arch_cpu_idle() is raw_local_irq_disable(). This means that
> architectures that can idle with IRQs disabled end up doing a
> pointless 'enable-disable' dance.
> 
> Therefore, push this IRQ disabling into the idle function, meaning
> that those architectures can avoid the pointless IRQ state flipping.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

[...]

> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -699,6 +699,7 @@ EXPORT_SYMBOL(boot_option_idle_override)
>  void __cpuidle default_idle(void)
>  {
>  	raw_safe_halt();
> +	raw_local_irq_disable();
>  }
>  #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
>  EXPORT_SYMBOL(default_idle);
> @@ -804,13 +805,7 @@ static void amd_e400_idle(void)
>  
>  	default_idle();
>  
> -	/*
> -	 * The switch back from broadcast mode needs to be called with
> -	 * interrupts disabled.
> -	 */
> -	raw_local_irq_disable();
>  	tick_broadcast_exit();
> -	raw_local_irq_enable();
>  }
>  
>  /*
> @@ -849,12 +844,11 @@ static __cpuidle void mwait_idle(void)
>  		}
>  
>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> -		if (!need_resched())
> +		if (!need_resched()) {
>  			__sti_mwait(0, 0);
> -		else
> -			raw_local_irq_enable();
> +			raw_local_irq_disable();
> +		}
>  	} else {
> -		raw_local_irq_enable();
>  	}


We don't need the outer else clause anymore.

>  	__current_clr_polling();
>  }


--
Thanks and Regards
gautham.
