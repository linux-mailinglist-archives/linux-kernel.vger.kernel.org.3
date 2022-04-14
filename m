Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66855005FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 08:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiDNGZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 02:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiDNGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:24:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A29C4E391
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 23:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8Pftm9fQWOQBqKXTuePPTGp0HmxovbRnhOmgQ/IP45SN9tflDWDyTV3ZhNhJT7yKIIHG7h+/UoM/n2JsTtMNYUadB4INqSnnzG3jKIfJCoHeba9lUcNoWQwcqbb9QdxkhVUMabL+ZyX/W3zBzYxjyLVfUdrmBF6Yac0LXRbBD4yU/8+RFo4qT57NgWE6V4dlNTRphCTtIWcRjpPAnv2pMqnclvBhMHWxtvIgyhBdIkmYQBSii4KUoxA+TH8dW6WQo8iealKOa35yNVch7xBeGp28t9mmr0A5C1vqzE3E/1Ewh6Ry8XubEq44+ZQCeuN6kgF56su2UnXeYTqrL63Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eFOByyCoyroKu4xZeYyPYJ+1rLsJJTnNUjkE2PvVpI=;
 b=V1Rs5mqu7pR2x6J2uF7aMZQmiPf5eKe+vdVl2sHTs2DGjQVFGIQS155ExvVMTMbzfIiXbFWtLwq+TNMVhAwmAbV9K29Mrg0xmKbFDLpkV1csWiHtB/jRd6b7uNL7fOKEKA++WeqfzFT/SFIfGm0S/agD1AnKIPhZ9/ScoiFvWIaepZBzVkagd3N3nJHFCoafybtsFZfcLeJ3qLD3iWtEBL+mkdbW/y66MbJ1T88SCWvdkZTop0I2DxvFMC+Nu8e1dl2BPO1W0p/aDeB6ixjeX1YnqLuKQrlFmFOa5EQssYMubI2QuG/BI+EZH+pty1WgjgjykPeyRunfqmU0b2H8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eFOByyCoyroKu4xZeYyPYJ+1rLsJJTnNUjkE2PvVpI=;
 b=moddgmop0kWl1AEPdknaT8c/k7N3hmwvU8XnBh1mf7y9KgBgWdLQE6Kph/gsh+0I7yB5bOYBh/OEokuZLWbLAHefvEu46RigbSQn34PAb1PC0Kw8VBx3QW35fHz92asgMX3VT/UVooQTlKOQsqvkIEHgLzmF9ml8L+CvDnTbfnrp1xaLgDCJXCqsrYzjRuCDVHdtzkHwZQM1TQbnvcllq8GYq8q3YxYLZz9cVb01w/0trFMP/YlsNaHH+3VzMgKYvaySf2LYouStlkQxFwLVEJPuwHe1+xcnAzc+esZC2iLVJcko8V9jFrj4li3YikYX0AIjgNuVApBJrqE48JFZsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 06:22:24 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 06:22:24 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Remove stub for non_swap_entry()
Date:   Thu, 14 Apr 2022 15:48:33 +1000
References: <20220413191147.66645-1-peterx@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220413191147.66645-1-peterx@redhat.com>
Message-ID: <87zgko9obm.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d979ff2-0619-4678-10e7-08da1ddf23e5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1581:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1581172AD79DF99328028E16DFEF9@MWHPR12MB1581.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBtYtLLYQu4YKfNglAgL4CNPUqF5lQT+vvJvKwRsKcxXpfUG/W59L/Y1gIoD8nJ1yxoEIu5QxBt9Lp0XWxV8ccR0Z8if6t7+qz4E/TzsUao8ovS5kbU0kwFIk7MSVafuwMyCvhnWbFN/Oz7QgGPq6wN7bst4TyoNjPxulaHLcKZSC+Et/mjwWvquFXLuhJ1BUlCugrt965v82rei5FTRon8GqFLbMi9phWVN69vw5knG7vU4VrfKIMRCdpkktA6CbGyOdCWI4HuOCgGl/sCFxKN0RkU7HaUFKgrqwZCvIGADK9yngYQR9mnwQCpGTaAf+4wd25xhqSXR7jICmhxwkhACFvD/ClKZM0bOTwpNdRM6YHCebr8tI6wUgwEWjD1QtnHPFtBNUrDvKk5yKu1h7lO+Sb/+FQT2fo/V9dMmOIl3EPOKt5SMv51HXV0uXnhA73M90bJwbKKGMYUWpzAVPCLMCvLIm7ExF9/ABUY/Ve9ahwyXgVpkZ13a3Ec7aaD+V9t3tTKRp170w0KK24UEncFxSqHl0ihaDgBwnuzEZlYrEAr+M3qPajq3t6ROunTNAxgpzFCc8DKYsjHWu/NK4Tj7r7/smozjoBmmYRsWOO+bdUZjpseFHtgqqooeZYQGCT+Rl8s1s/IZOoPEoL3Qp0JR56edFE05I10/j9Y6a1IrEr1E86xeLNDsY7p74XeRWb5NmFK0zEUMdPSarXpDkvfSepZMjtX3wxYytRvJ9zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66476007)(38100700002)(186003)(6916009)(4326008)(26005)(316002)(66946007)(83380400001)(86362001)(6666004)(508600001)(6486002)(6512007)(9686003)(44144004)(6506007)(8936002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGhLpirSLGqJEe/ZhfZpbCavQ9Ub+7oQDWjFLurNwEMlT8a+/CXdLNBEVFHn?=
 =?us-ascii?Q?lrmJLl/6CmoSprpy45taG9fILJ8ojDeBF8PzxU60t+WtGGUKotiXv8awEcyg?=
 =?us-ascii?Q?XbyVMuVCh0Fe0eN6k66rWIyXaydEUDQRvAPD6bIIp7JT93vV5Pe3cvJz4Ums?=
 =?us-ascii?Q?KsJtvx8o1qTWYuE+24ODxFseKd8C7CYkxyCOJAAi84qCczKzy8L620S1RHxw?=
 =?us-ascii?Q?CRsxoXR7plU5Xd/C0e1lEpcCAFcqmxn/+n4gYkUbduAW8we7pzTvF6QbW1ss?=
 =?us-ascii?Q?hpZSeRHYh8O2Jytz0EAj11sY4wv0Vqa02iYpXhx1N3vEOjLZ0T7aOYk+8Ucc?=
 =?us-ascii?Q?T56x3lsdr5JzbwUTJKfWhVJB0QvocwlLJxlqSKgwXBHM6Tde0SXfqLOAiRkf?=
 =?us-ascii?Q?cUF54RRBpnRuq18FIj5L/IJcQGsq66nmTFX5U0zMOlJA/tsert/LPhgh3apZ?=
 =?us-ascii?Q?ff9Dn1KX+Lpd8t5TR9RbxySvz+k+8KCJrp2rTo66e4bRF5wG6WgqHleH7LjZ?=
 =?us-ascii?Q?PgCEC1IIejNmFFQ5PUc8DmAbXMMkMT424Td761TNnz8RyOc5ee3WdwvSYYS1?=
 =?us-ascii?Q?Xg7WnzcJhwVyQgOc7gSuYKEhO+OzXypmDaSZGml5ZmSxsDRpGy26zbRlyljI?=
 =?us-ascii?Q?GyDBx/u7CPShNqHk2cHOpkMR9kQw1AkaG6ubmbSRSDLYciajI7+RmDbpwHsl?=
 =?us-ascii?Q?DlNyZNV/ns1UIqxAj1H1ig1+B7PPpD/b0kmyLoJrCGMWUgb5RhQ5kIH51ksq?=
 =?us-ascii?Q?eoE+03m1mzK0c4fbiPZLqLf4AKkC8QHjldFJAlpDhcTRiDTqayJaUlswCTPw?=
 =?us-ascii?Q?P7zBhEVBVEvx1GkJtfuBAmDJG3bUR/+0xjIVC6UX3uh9VxJIvoRa+njb96CB?=
 =?us-ascii?Q?SZqRVv39rqAgPKsSuSA9QYg2Ot4xbqOqpfTDceJsEOp3StC2buyBpFGE0iLG?=
 =?us-ascii?Q?JnEooFQ0RWSL9hWOCPtOpxLuvcFXC9vzZqwKVXw7VjUwc8UtgZN7JrUx0xdR?=
 =?us-ascii?Q?3VN4tv+k5d42vSH+NjMKY7T0qJsYWl9bGbWrw4y9ZrUKsdRjKyLOEbYhiE2e?=
 =?us-ascii?Q?NYYOs/FDXbouHkngyJ02eETG2hIyVpfX+qcZJYtyG1Vi6z0aK2vzPosiZGs3?=
 =?us-ascii?Q?CUzGqBucAo0GBC4M9Cx77iQy8Pep2w98qlz2Yxz5UC9r5EXniCRX91E/dXx0?=
 =?us-ascii?Q?e09zgslroge5ydRSQkipcXr1UBJZZk8TYT9FCjk96vEkJ9g7Ppehu2WaJdnD?=
 =?us-ascii?Q?yGujYRCst45AirajU8476ZuYJkyjwmaDn6oSvSzzOtF9zCHMpTAyihZ3j/bp?=
 =?us-ascii?Q?rQfudxYEi1I9h4A8ilkmPAXOiq+lTdzum2CeU5BrfyitS5RRW72sKm9M/s9z?=
 =?us-ascii?Q?dGT7/AIyh8HJZeFyWF2EOieGbPwkKqQA9Y8N7PZuCjhbvqZ5RL0S2iPhVXIl?=
 =?us-ascii?Q?hyajvUiI2jNH0Uz/I0dtQk2IoS5GMhb8UFGMBeVS9a+B6A1dB006fEA6Rj1o?=
 =?us-ascii?Q?U64CIJsMt5RCHdCzJksT/IEFbtu53Esc8xQC1DnTEB3bWkUsMNty2tM20PGL?=
 =?us-ascii?Q?dFftFvy6DIYZfx7K+mkXG/qxtth2+xaBBvqTj7/DHhsWyXPJHPTyYEHRO3Pp?=
 =?us-ascii?Q?2ILL6JMYzG8R785dt7WOIxPKd0mZnAd0SRcxR4f6sATWLgF+111hrWTS13OG?=
 =?us-ascii?Q?fL9pvrIDIcsBu0n3ekdldOgGBzwSr2ugbvKzMT4P7fNY/ZuAdXvKgZWlw+vY?=
 =?us-ascii?Q?C+AVf+d78A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d979ff2-0619-4678-10e7-08da1ddf23e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 06:22:24.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seTmHwlF3LwruQs2iPiOYftW0o8Qh0QnoSMx8jjBKZMncc6ykqYs6m65ffb1w2/iQ5bdJNT9L1aoXTC8kM4lBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Peter Xu <peterx@redhat.com> writes:

> The stub for non_swap_entry() may not help much, because MAX_SWAPFILES has
> already contained all the information to decide whether a swap entry is
> real swap entry of pesudo ones (migrations, ...).
>
> There can be some performance influences on non_swap_entry() with below
> conditions all met:
>
>   !CONFIG_MIGRATION && !CONFIG_MEMORY_FAILURE && !CONFIG_DEVICE_PRIVATE
>
> But that's definitely not the major config most machines will use, at the
> meantime it's already in a slow path of swap entry (being parsed from a
> swap pte), so IMHO it shouldn't be a major issue.  Also according to the
> analysis from Alistair, somehow the stub didn't do the job right [1].

I wasn't so much concerned about execution speed given it's on the slow path
anyway but overall code size, which is one reason all those config options might
be disabled. However in practice it made little to no difference as those config
options already remove most of the extra code so I agree we can drop the stub.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> To make the code cleaner, let's drop the stub.
>
> [1] <https://lore.kernel.org/lkml/8735ihbw6g.fsf@nvdebian.thelocal/>
>
> Cc: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> Note: the uffd-wp shmem & hugetlbfs series will need this patch to make
> sure swap entries work as expected with below config as spotted by
> Alistair:
>
>   !CONFIG_MIGRATION &&
>   !CONFIG_MEMORY_FAILURE &&
>   !CONFIG_DEVICE_PRIVATE &&
>   CONFIG_PTE_MARKER
>
> (PS: this config should mostly never gonna happen, though, afaict..)
>
> Quoting the same thread [1] as above.
>
> Please review, thanks.
> ---
>  include/linux/swapops.h | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index fffbba0036f6..a291f210e7f8 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -493,18 +493,10 @@ static inline void num_poisoned_pages_inc(void)
>  }
>  #endif
>
> -#if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
> -    defined(CONFIG_DEVICE_PRIVATE)
>  static inline int non_swap_entry(swp_entry_t entry)
>  {
>  	return swp_type(entry) >= MAX_SWAPFILES;
>  }
> -#else
> -static inline int non_swap_entry(swp_entry_t entry)
> -{
> -	return 0;
> -}
> -#endif
>
>  #endif /* CONFIG_MMU */
>  #endif /* _LINUX_SWAPOPS_H */

--=-=-=--
