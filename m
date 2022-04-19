Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094D65061D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiDSBzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbiDSBzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:55:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD8F27FE5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rad9Jm5LO5cOsARu2USY4tT1jTCLnazFGfzHKgtrVSBDIlUGdtww1KtELuEffeAM0q4n5wg+2yF7qWZkRII88VW81ZXNNkY4PY2a3WSyqpuVdqq5BLP2r8vYuuHUYnneNxWed7AAHkqoN61tCIpQTLFmhpsOuIMZRI+JL/ljpd5hFRfUiUwGSbBYrfbjngbD6rb0eFNUpviLyQunXR/s2kZZBYIc1ROjJaxMJWokkncIDzPIpJiJhMcJ7N5aS3yRXDUmOoyYgNegNff6oFrFmr+r3844bIHxg5gQo5yiMG7fSNYOeCrKEZVOb6VB1miGkQdcV0GsWcCauVPwoSui/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bPNNmaqv3X5JsYP1NY077LN2WePYETQL9o1TBGY1e0=;
 b=eiVhIe2RlvKVkmwWUl+rV/jpYgBpEkhcfjYK8TEzEQCmp6US7PVBF6/g1X9j/QLv32mom+R9a/SwM0ZSZn+3cUkNqh3q/bEFOYgh9ZfHZbfWLopOpfYP59+E5YZjviVcMNvKdyqd1nHvcMq6IhRKF4pHs+eKlcEc9zNq9pIdNZ+INTRZd5Dfpg9rg5SdbXoyz/AtfEEwYuePCxqG8pYsAlzD+NEUUnoXQK3kXqmY9fOEWpzoIMSs00d3GkC8Sx2Q1yJeFPPG4PLSrObPFB4DFe/fFnZqL/7mPGp58m2DGS7shLJJ3btkbKICECIDJkUMwIMePkYuUU/VBjIDT6XNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bPNNmaqv3X5JsYP1NY077LN2WePYETQL9o1TBGY1e0=;
 b=SGFiC+z3xv4rrZ0HzNDwe+34+6Fm9VJpiJiTvVceJlJRRM/48VgK0BxT2pqedAh2AKXa+AbJM9tioagk68If06Q0F7NjrRAckgWyhuYtpWCrK2TlGikm7bynF0VfjuGzUC2l6oJ/bikuMca/ab+g5xrnZjaMF3rdJvKEffAlV0d3Py62v8gQ8ztaS3ZRGy76WHqYqyIJNV8XwBMYqcjXHvmPseu/aAgCNPVr5P9UXOfufPCJ/p/5GgAsgJokYtG7Ondkv9jPvCYsma1R9ZEPVYdmJDb3rFZAyvKuUtIiGLd9drrCS6XWvOSh8QwymKDVY0LtGC1XD1YMGDGlxifFKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY4PR12MB1349.namprd12.prod.outlook.com (2603:10b6:903:40::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 01:53:08 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 01:53:08 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, christian.koenig@amd.com,
        jhubbard@nvidia.com, rcampbell@nvidia.com
Subject: Re: [PATCH] mm/mmu_notifier.c: Fix race in
 mmu_interval_notifier_remove()
Date:   Tue, 19 Apr 2022 11:51:58 +1000
References: <20220414031810.1787209-1-apopple@nvidia.com>
 <20220414135005.GJ64706@ziepe.ca>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220414135005.GJ64706@ziepe.ca>
Message-ID: <87v8v5kfem.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45057af2-0e07-42cb-f881-08da21a75a3e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1349:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13493DC9AA8ABABB78978C7BDFF29@CY4PR12MB1349.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcVXCGzsR/HF4OhZZ0Rz62zmWsLNMSb67tbFZhyBS21ElSXsgrDA9cgrwtUfJowY3klCrBzf4qh6iEOMi6HGNyk0MoU+lzbDBGDZ5jJ7xFrKvPj+t1w3QmeEXjLZ+67b0/4i7n4gSV0xZImuUy3PidT84Y88nxwvG2L1ppnTo6JgEpPGZoD5DXxVx6p8PHfIn2UUbhBogdC5dO0GgbgQL1U1BG+DUIqkPQy6Hm78IUw6g9SgEtC3tBqxUm9Y7HuxMG9WUk3jN8zshxvJ5rzAMMsHLVs6xY4bCE011Nm+JpAiBnxVxChrOL5mMgHKHg2tWf1HFbxgv5XkzsoebtmO3MyzJ9baRLdhmMufQTPeneSnC5yYjhFuQTmPIAAjYBG4LxtyiBDszLjASDKgeZLQ2srl413Rz0gpemZjklYcaOtGG9Pz9BdYcDEkoDsPueMZUxIkR8MJiiotkGbzTg7a5p2mkXxhg0wuCbkTId/yGGXry0ulXF0lRqkEa7FRS0exc4v3gV8SkD4zFj+xgtGSbHw+TY/b0QZSawOEHgKE1PfMTQ6aDNyoiyMhxQIiWBlnWnGJbupeJ/0fhIg30M8zGN41J0g/RiuzALSFSFgzLKCG3o1BCfBYl2yqzlk+4abkpAVNKmOktj8QHlY2H8H6GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(8936002)(5660300002)(6506007)(4326008)(6666004)(508600001)(316002)(66946007)(66476007)(66556008)(8676002)(9686003)(26005)(6486002)(86362001)(6916009)(107886003)(44144004)(2906002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NVyHCXH2eLy680pg1Xz73m0US2R8LGmCqndcMVEnq+E8dFnSH4OQolvEuuDC?=
 =?us-ascii?Q?WnUkWUWMqUpvlHZvo8+ToFytdx/xKN5hOqDhHxJ4HwGYpzN3XV4gjwinAXNW?=
 =?us-ascii?Q?HDaZSn1I8NE3QFrBKx5b7nmj7q/LMIvZZPkrlzYwRFdMEP+Sz85Bqn9OIV+I?=
 =?us-ascii?Q?yOzras6PWz/cauhjrvGSIp0sFMYNvT6SQAAbKIPtFwVKekw0RGoYNpWxYkMD?=
 =?us-ascii?Q?I3pa8undxS47hy428VluJhQRzvxkMPQKKACH5h9Qlxsz25Ok7EHFOioY68jZ?=
 =?us-ascii?Q?LabulEz8HtEwhd6pcWIAMLnkqgiHqEcQlRbNw/h0ci99LdC6JUGPSKxg++s0?=
 =?us-ascii?Q?OAnVosCyeD9cE/P/95s6Nn7AjacgSCZlZptd8mxZjg/7TA9gYzRcd/Orx0yv?=
 =?us-ascii?Q?fOIqENU5s2sv7b/drwKA4NJ2NmejQsZzspPLaIDdW7cx9AGdnmp/AdZD0Uyq?=
 =?us-ascii?Q?OHFQI4osMly3XjkW6S1iPI3sO9Nd+ywtqzyu4c/IrrC2gnQ9M/tlumj7E7Qv?=
 =?us-ascii?Q?Z4oIlwb9GJtDvAcAisu2x0i6Jj++pobk3ssGHXATLIy6NnlLRKXb4OsANAIj?=
 =?us-ascii?Q?6gnsi/hueWpwKaeCiZ9twjm7XMKEDnf0CPvN1xV1e9A7tHfYAd/a1bs6eWF6?=
 =?us-ascii?Q?bkL3EK6LrIzeYhhz0vYAhVlnP4C1P0vIS3gZMW7e5mERRkoQx/LJjkPOVc2F?=
 =?us-ascii?Q?LpOuSxhXQhNObCJ0XwZIVJ4uUg6iABFcosTC+8WZ2EZB81Uzp8y4QPZTk915?=
 =?us-ascii?Q?QUtlMkmME9izoi4BMWeQulFKtWTUKhvzw8kDbRmsYXpInXjBLXZJnPVBQslc?=
 =?us-ascii?Q?IzTtj/kyJGf3pt4+8MeNFHf/CIR/iGYAIwy0CoIxsTnjmvzFhXvNMgbaQty5?=
 =?us-ascii?Q?9eb7qlcLLxM01ATpUz5J2+RIqTyITsSoOsqyNCl9yjFVxD0wlnih10xqwRq+?=
 =?us-ascii?Q?Y2PW7EGJTOaJcoeasQGpVflZ+IzfxXE4yvgN0HV5Hlh+O2MuSQ9pm7/fV/Ie?=
 =?us-ascii?Q?zcDyJ9DFAIfFjc5nujHufmPeXA909O0I0I3DrUdfOlEZkOFBpjx2K4COYTgQ?=
 =?us-ascii?Q?SQAdZZAkbhb3ehTYRmDz8zDlAEjwF0A2OujjcWsjcwvBetN6065SixzBL3YS?=
 =?us-ascii?Q?s2TRf4VQ+RykWTCf9ohQxVnNYmr8Q2JNvoS1PN7W+D4d1ejEo55VRQ/DKBnT?=
 =?us-ascii?Q?Nlbj0yvmcQYhOzy+3H7R/va2LuLQJqtUJ/AgxbqZz/he4eG7iZuXL6Vo8ucv?=
 =?us-ascii?Q?GuiGcYpiN7fygJ92+QhGalsVFSYdUwQoCx8sz+QojYx6xp0HNqumC1V88J7C?=
 =?us-ascii?Q?wInD17APtkbrZ8ftZuhvdWtXkMfBxU/ae3B4zDlcA6o62NuR46hhKOtb8axQ?=
 =?us-ascii?Q?ru5ki7/meqqt0aSn3s7byM/0zHoPXGShYm/gb56O458PkqA5PDM9sthZmwmN?=
 =?us-ascii?Q?CGcjF4AcJKlb4RvFcrVHN+A4iQ0ZeiycODFY8hFSXM8snrVaqtsvH1qkN1xu?=
 =?us-ascii?Q?uJt/X9aG7kaMcpZ6u8jK03/QzRTDH6KyjXhG8+ubFCWThoFalzTdkdikxNZV?=
 =?us-ascii?Q?Xj/fnCImyPsTQDeU29iq5zUCeLkj9B2ZWOM5hhdtViff7l+6hx/5SVFzYTdq?=
 =?us-ascii?Q?a30DsJDhy6ixLmGuC8pu0QFfpZ5ZOtY7yrf6feevelBcucMpworwlaIag6my?=
 =?us-ascii?Q?84RyLiT2ZEgALniyOKux3DeNOIAz7rzi+IgDoiGPL5pavcnfWUicV2CnXG/U?=
 =?us-ascii?Q?0r2DupV9qA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45057af2-0e07-42cb-f881-08da21a75a3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 01:53:08.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bk79gXVw5H4XS9JLXI4/4iMDPGk/l7ciDLCzjKURCgihyQQnqiUJ6USCGktTvonRpGCVuxirWCJmprKxvPqofQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1349
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Thu, Apr 14, 2022 at 01:18:10PM +1000, Alistair Popple wrote:
>> In some cases it is possible for mmu_interval_notifier_remove() to race
>> with mn_tree_inv_end() allowing it to return while the notifier data
>> structure is still in use. Consider the following sequence:
>>
>> CPU0 - mn_tree_inv_end()            CPU1 - mmu_interval_notifier_remove()
>>                                     spin_lock(subscriptions->lock);
>>                                     seq = subscriptions->invalidate_seq;
>> spin_lock(subscriptions->lock);     spin_unlock(subscriptions->lock);
>> subscriptions->invalidate_seq++;
>>                                     wait_event(invalidate_seq != seq);
>>                                     return;
>> interval_tree_remove(interval_sub); kfree(interval_sub);
>> spin_unlock(subscriptions->lock);
>> wake_up_all();
>>
>> As the wait_event() condition is true it will return immediately. This
>> can lead to use-after-free type errors if the caller frees the data
>> structure containing the interval notifier subscription while it is
>> still on a deferred list. Fix this by changing invalidate_seq to an
>> atomic type as it is read outside of the lock and moving the increment
>> until after deferred lists have been updated.
>
> Oh, yes, that is a mistake.
>
> I would not solve it with more unlocked atomics though, this is just a
> simple case of a missing lock - can you look at this and if you like
> it post it as a patch please?

Yep, that looks good and is easier to understand. For some reason I had assumed
the lack of locking was intentional. Will post the below fix as v2.

> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 459d195d2ff64b..f45ff1b7626a62 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -1036,6 +1036,18 @@ int mmu_interval_notifier_insert_locked(
>  }
>  EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
>
> +static bool
> +mmu_interval_seq_released(struct mmu_notifier_subscriptions *subscriptions,
> +			  unsigned long seq)
> +{
> +	bool ret;
> +
> +	spin_lock(&subscriptions->lock);
> +	ret = subscriptions->invalidate_seq != seq;
> +	spin_unlock(&subscriptions->lock);
> +	return ret;
> +}
> +
>  /**
>   * mmu_interval_notifier_remove - Remove a interval notifier
>   * @interval_sub: Interval subscription to unregister
> @@ -1083,7 +1095,7 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
>  	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
>  	if (seq)
>  		wait_event(subscriptions->wq,
> -			   READ_ONCE(subscriptions->invalidate_seq) != seq);
> +			   mmu_interval_seq_released(subscriptions, seq));
>
>  	/* pairs with mmgrab in mmu_interval_notifier_insert() */
>  	mmdrop(mm);
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

--=-=-=--
