Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD559CDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiHWBWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbiHWBVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:21:49 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC25A160
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM0dT3QvHJLceiKFVn2Ks/RyKwZLrbc5/t2OucIaAMG7NmnQwdoZncPTDhOLD7n+ct8KsQ7s0V1Q6SrrL9pR+IeaCZ34rAPRsq0AAbXdyA6QPVsUfJgQMvzx+TOMNSSTdcwadfUgoulJ0/+ozymMCp8hpsLQ7yWeYEgfrVgmTk+o+mB4oBS/4EjAxK8Pzwtt9wk66n5U88sl4ExXxLZwm80r8X/K6B5hVz5z1pwWhdfg+ZlTH89eTXWNLBmVS43gzSIDVzzARq5PSFMW8gOornIyjHJYjVYAIG32RfGykbusTyGYsNZ/es7/F0OsCKC6/g0s3wRgTKFLHJZZH4FAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaD2zujuCSeYasIBxOf4U8cK3jHIv+PwP3wRNkw00As=;
 b=JRUycvpPwDrBLW4oWmTxNMtTVcwnL4ohxeGOaqTafuZFUwl1ye4McDyD9mJ7G8WiRh1V1KXVdkR7B4eNTChzx7+wOBJN890suoOdoeqig0kwl9KZrg2DeO+HZN5aVCEz5KRLMsSPJSTpgD5Ib6/kYZux7xA+sQPMDiDGxTuQrjHWbpvd+lloNCySnxz3ASl6k8TEpCl2W603kZ/bt7/HZVmoLZCsfwM+4CEcgsxDSjp+05mivSEf5kZDH2xeIWA4oLk1RMEZu0zYpUgWpQX6akWHeYFRKVDoIRTwCzvWq8B8PgebcGPkgfOKifvzRPqtHacm9JSEDKZ2q2r6d9BlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaD2zujuCSeYasIBxOf4U8cK3jHIv+PwP3wRNkw00As=;
 b=PLioIzOcZmlzWm6OYtgW1WC3nVopB+Bc/c+jXf3xe2MdR9gTQwqRLcE+o7lsCel8hi9pKnYyPIFcH1UufcDQYaMGkOF/gBgOCz9nDEWXNmDcyq5YDVkoMF/rM1QV6zF5g+8edZs7uW5v2L1F8od+V2ocLdG+iwiaJIFiqDpkiwL2fGVYnIl8x8cZofS1aGoin/VgYUzPomPxZxEJ1QTTdkakuFghI0GleOMy2/le2J+sUcAMoLtGlPiKT+0gPn7LE1IerwUpWz1t7PKMkzR6uge+2OkEvZwgolcfuvHybhUdPDs+091Jw+48P0oc31pOedNwCdoyBeE4KbQoox5onw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Tue, 23 Aug 2022 01:21:42 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c%7]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 01:21:42 +0000
References: <20220822153713.962904-1-syoshida@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2] mm/gup.c: Fix return value for __gup_longterm_locked()
Date:   Tue, 23 Aug 2022 11:15:29 +1000
In-reply-to: <20220822153713.962904-1-syoshida@redhat.com>
Message-ID: <8735dnu53w.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be4314d7-2374-428b-6fce-08da84a5d608
X-MS-TrafficTypeDiagnostic: DM4PR12MB6400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5l0msSiyIy4MKpU5QXVAKBjGRYHlcJ04m1hKkCjcysXv99FRIuLHK3hR/RuLWbqygwjUufGx64YyI8KrM8ojpGwiyYdiftsE6Ife0x/Erk2OahOz08mYPwAdKUsrPXvFZkyF1Bj8pT1M76fOCwPGaVdu7rPUh+tKwkV1pN2QYPqC7T/nfr4a5JxtszphAB/tB0gAnkoP4IJqvDvexW/y7Ey4zLoeMkTTaSRXYqDXBl8EKnR4NUxeAU4PEl64eJviUEXWsnvmsN0fwcYS39FDBNddqSrl4rJ8Mw3UHZa6s0vNJNhF/ECfS4BSYE+mUjk0kcxwA0OdWNwdwMhb4TYwp3GFO4yRYAE4a6CXRDQlHVoqyG03dPXPUMEA07z1HBaaJPYue5ZM+NEcubKDK5TP6ckgGUzx7Tj8ed4IiG+BnhRL8ViHL0CaiHHjqh73i+HAe5N/jLdbMRcTC0QFl7kYLIdYb7BrF9cQYEd9VtixgCHxETUUT+eTx71qzfvn/LQm4oDcbkI/FlRiZulZcXUfQuZ+6dbxOzmv+AQMJ1NqkAz+pUTlHn/MHe2AJ30MQdtWwN+r1Mdy3ELQsUUE/KX0Dv8NUWmWO8QL7sTuL4SS8rWkDFpfEZLJyQ7kGxmiDj6TBuM72OdwnvrwugbZnUOg1VOKJkIH54aUL80cSddL+ObIh9rFr4veBQLQ1zsJTLikQWGbTwt47KtqEkuGz+LqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(107886003)(6486002)(41300700001)(6666004)(478600001)(186003)(83380400001)(6512007)(26005)(9686003)(8936002)(2906002)(6506007)(5660300002)(316002)(6916009)(38100700002)(4326008)(66946007)(8676002)(66476007)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXioCg+O3DteWVDIhfFCzCQCWHDH82Uh8Ihb0LPqd1kSY0npAz21jYX2F2/S?=
 =?us-ascii?Q?irqclsat81IP5q6crxKdNg1NxdkZ0DG+WX7gMw6mRJFdO36w2zPb8GqSNbNv?=
 =?us-ascii?Q?jTYhuiS0MVoqrz1qjRYrNicd3XLnI8YTafXCNkOefdl3vbNij5zoHp4Gz/gr?=
 =?us-ascii?Q?VkrroDnxz025PQx1A9r3f2CKugUENd7Nqwb5KAADMfVDH1c3iBaCfAf6+OHE?=
 =?us-ascii?Q?Khvmdr/4lvfiwLJaZS43deg91LTAVrqPzdoCiSe+bdnIpdrKvjik6CA5hdOk?=
 =?us-ascii?Q?YC7wqlXB6wa3m5isOFTGaPx5hg3q7PAyDLyRQS+zX/VEn/d+5F/DlZ5nwSqz?=
 =?us-ascii?Q?TnPR5oEvSA5hS05lZFk4oLTtg8wf3vztoXS3HznzyL3q6OfKa6/oONHP7P98?=
 =?us-ascii?Q?t60PuykMpg9LsOH5CI1Jk7uV3LnKL2GBFPHXcLYj8pwzImY+MGIw8hDu8jSK?=
 =?us-ascii?Q?qodVUz0Oorsq4gIKVcYNbHaJoskGIQ2FhPwsNsG38AX/vT36OftBkwSACuP8?=
 =?us-ascii?Q?K/CFF2rdL/fIXScmrJxv8dgVEsJu4aCjwvxPUthrrUsngepQIv++v1dh83+0?=
 =?us-ascii?Q?GPyM1HaTxxardudZ0UqREDmd01Xj1jq+hP1BR/C7gNuV487wpRIWknxl/a0/?=
 =?us-ascii?Q?mstITckWIdXMVfJfc0o5b39A1ueMNMEor61IPjmrsBH/ERs3bTT2KGBSTrDr?=
 =?us-ascii?Q?dWrR6Yq2Hpr+nxdzksRdpMgw0f8MHw5qX2D3grFC7ilA28LjEX5yOGU/lZHf?=
 =?us-ascii?Q?r/iRQybG+dtWTywSm/cGrcB85TDc+sTF/LKMiS55gK6wJcjqHBPnPSYLRiu1?=
 =?us-ascii?Q?gvhRxQpGlu/VpnJBf4lesEAwaquWEqjuQ10r8M4zWcFyQoBZo8a/Y4X+6Txf?=
 =?us-ascii?Q?CnVxd+h0nRizcsOgE7rbEn0+crjsH2t8y+S8msimjTmkGAJ4PlhnU+omqfa/?=
 =?us-ascii?Q?q54Yfm4rXivdkfxn0uwUDaT1Q8EikGm7LD9Hc560RFHuTFk/u1rjEhVOe0Ef?=
 =?us-ascii?Q?Btoj5vcbZ/CI4HT/iQUAbhlZWtJGAkY4w9iTKvpEleTnMnQeFRWifrZfXDvV?=
 =?us-ascii?Q?sCDNcUe+kN78OEUIW6p34LAnej9yIoZK0sswS/CKJfXWrcg7eZ5qA9kRmBq4?=
 =?us-ascii?Q?KVu+YT1mrtB8wWOjBGckdVuBtZv7acHQ3YAyicZoBEhAqGf750rFbdW8t4Uw?=
 =?us-ascii?Q?VshSKShrWH9NaXvMrYf3harWLCQePtoy83YUxopizQT7viHLF6VcxsnSYkWG?=
 =?us-ascii?Q?b/0msTbW1qAW13yxNHVQTGTs6jqZCPm+cUQx4kAwmhczXqt75FBIrFtF+JYl?=
 =?us-ascii?Q?J5feAJFBfCGD/Qr9mqswd8a6DbseQdMWSkby5IPXxN/2RK9pjcq9nu9u10Wx?=
 =?us-ascii?Q?OU/ALoLFXFpYivDzUe9R7+wJelin3eI40f4Z6vCz1GODR9bZgN20fRE5GuWb?=
 =?us-ascii?Q?JgK3cpdyw8Cf7xkf8gbZ2bAvVWvBy6ZyK7gtPfLwRq7t9TO8XaRDNkIqAcJg?=
 =?us-ascii?Q?R6e5+PLVE2aU5/tVBd5Eof026sJOukFx6XoDWian6+pTmlK3m2AFfHFaQivH?=
 =?us-ascii?Q?k0nJyFFQ8A2D1qVxWtdYAbAqDFM0zaWcCiE1eIk7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4314d7-2374-428b-6fce-08da84a5d608
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 01:21:42.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Disx+eI21tIZchhm//xyxY4Ea2LGhxr0xNeJ+8vYUX8Krf+/Lk6U9Hlf61KvZSiVlcrEFg6/6/tGXekZLOzxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shigeru Yoshida <syoshida@redhat.com> writes:

> __get_user_pages_locked() may return the number of pages less than
> nr_pages.  So __gup_longterm_locked() have to return the number of
> pages __get_user_pages_locked() returns if it succeeded, not nr_pages
> requested.

Thanks for fixing this, I've been out the last few days so just catching
up. I think I missed that 'rc' was passed as nr_pages into
check_and_migrate_movable_pages(). Will double check that I don't make
the same mistake in my latest series.

> Fixes: 61c63c2076d9 (mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes)

I couldn't find that SHA1, I'm guessing due to rebasing, etc. of
mm-unstable? Not sure how that is dealt with, but feel free to also add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> CC: Alistair Popple <apopple@nvidia.com>
> Reported-by: syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  mm/gup.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 5aa7531a703b..66582203220a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2068,22 +2068,24 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  				  unsigned int gup_flags)
>  {
>  	unsigned int flags;
> -	long rc;
> +	long rc, nr_pinned_pages;
>
>  	if (!(gup_flags & FOLL_LONGTERM))
>  		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
>  					       NULL, gup_flags);
>  	flags = memalloc_pin_save();
>  	do {
> -		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> -					     NULL, gup_flags);
> -		if (rc <= 0)
> +		nr_pinned_pages =
> +			__get_user_pages_locked(mm, start, nr_pages, pages,
> +						vmas, NULL, gup_flags);
> +		if (nr_pinned_pages <= 0)
>  			break;
> -		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
> +		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages,
> +						     gup_flags);
>  	} while (rc == -EAGAIN);
>  	memalloc_pin_restore(flags);
>
> -	return rc ? rc : nr_pages;
> +	return rc ? rc : nr_pinned_pages;
>  }
>
>  static bool is_valid_gup_flags(unsigned int gup_flags)
