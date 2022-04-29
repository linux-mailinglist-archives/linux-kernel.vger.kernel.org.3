Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B8514ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347892AbiD2NmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376265AbiD2NlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:41:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59313CB033
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGNWNGdJcxTAtCo/d1Bbok6E9XM4sCwsSLg8rXeC470lMoDxhP5WBerc3ll2lM5fdwLM0dmUY/+JGRDVb42ZzdyED2SDLLF1imZasQhC+0tMLYd3tV+jr3BgLaVmthKQouINrengHAmIyMyZqwvurYzTnU1fHRTAEYjdaNRPJuqQlU4lfuIN9j7MpqbIm2ntlV3AruElkuEHQpjuCO/IGJ7DXKEzXZ9/VgLjB4D1fdP6o3f9aFABlQ7V1P1oC138siO9gP4+EKuINz41MngNfAZls0VZ0dIB6XPcHQtpmz3LukHraRhbc/lwd5e0HPF0lgkD6hj+dIR6+t5kWa+Csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9aWTbm3ivjq4JBGrYYuhxzN85rtxIoQexFYnI9K+f0=;
 b=LkRPPGmKD/9eJB2E3nrbW46P8J0SkVKD+4TaG5bkOXXZIq4Z2Kw0CX7wqjOq+BMrBJ7YQzoQXqU6Vx9KYkApEEKjWTNP+ZKJhqokpayVlicH5UeXg8PPNIll6wXcNAkeXiTr9Rhv/NzCw7N64b39YkXbsvtr0NKvgA5YDBFi3/aVnkVr5fBlxtzWnyd15aHMhcHWN/cTs/W79iwmbkHLcscor9WJU9xtsSy+2IRlyQ3rDONFQ/ntJ/4SwfICW9jchmELZFADRsyYkPGkWyFTb5wju3FZLAspVFsLVeTpeGt28KUE73ThDRZ+oxYDhMdlj1X++2wIJbFu7lYnN6rmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9aWTbm3ivjq4JBGrYYuhxzN85rtxIoQexFYnI9K+f0=;
 b=f+QxZgF6pg51Gfwgegg7dvshB7RTkyeitIAs5fFaTZo6unZONBPGEpyjzE8BaV1aTdQUbvRjZ0r0nqkzsu1NlvzalHl+81C3RC1UFwqIRyS37Rf7pJNuHpCPWufit5UlO4YkmhmZ+EDjF/2WAKmuMOY38dnA91/lauvPbMecNLO3eXMvIS58izj//OH2CbSXAZhDNU0EfDTe0HIj6VM9mUnLhhiduzpjocXmT2aAzn3NtGQtU2c3DceM6Y9BKwFbIaByM23ndc00I0U01i5AZ5L+8+b6ZjTzhgaUiotkn5ey3aRbrwMkiyMAV8nkBnMMHn637ZEXd+N3bZYEpSo8Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 13:38:04 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 13:38:04 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Fri, 29 Apr 2022 09:38:01 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <8A0F8444-FF62-44EF-88C1-AFAE66D29E2A@nvidia.com>
In-Reply-To: <20220428161911.GB182@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com> <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com> <20220428161911.GB182@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_5A946B81-8ED6-4577-952C-246CC3288DC4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a66d8c2-fddc-4f97-9d81-08da29e57c9d
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB622281D76E3D9BBCA268BED3C2FC9@MN0PR12MB6222.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJudHPtjILMUTjd83J2azYu6hooF2/Kv5QtcfPUV13A+5K5UE3l+kxvxax0qY5rkrJQ+JpaM3sz7zOioLyfB2uXGIHDhm5Qs6KSp8FXbMFAo1dUMuWZJiOrJQjFdPYONy6Di1Tsazql+Y2O6VKPgUm+80Nwgk3htvfFuSpHge7G20pVKACrF5ErjuA2tzsWWcY2txw1FpMENwW+MRKj22mtZW1hfk5rc9bZGBzuvWR2gHY1qalIs8d2QA9Xvo/IkjUGli/L38HzHmAqB2ZAQsMnc985zO+naH7rwSFLYA92HWQzeKUv4r2DI9jIjv2XCVRZnGg2n0fC0ex4r/ZjYSWemqoi0Qwa+oFVZRkV8RIFAZ3g0qGly2g6lOYSoTxvpd2hUIsbrM/X7M7Nhk1e4SQ3k7SjPBf1KBB3quiXeaV+uvUoz9dkSYiPsvLOqyxNoDAHVIvhtA+dWvTDZ8iXNsLC0umZ99Pig5YnRErYz9Ugo8naUfh+oe/QNTJ2j7XLmKfMd9S7vSpKFl+wDDzvaYq9jFmUXdm1pafPeZR2oo+7BA9DoVZzDkbKZ3fV8L642QyoCuI0hW+o0RU7IFAkGXpvt2jcjae+LiXKcAzqKUUz9JxfL9a3I6nvYin+ab7lrlitkULeJGIE0C8M80rKQ2wA+/PYAwpzkgV0qJMllnXqG9B/z8ZuYk+yuz2L6Ya5MJeJezB766QeRgaCmSGSk1E4ibIq0qJAcBhk0fpPKH/BQzUT8zElugooxPNjXl0fklz5h8gVBjpEeWO3gkOpGDmhbhpBAAPBDhRm5Dg2q9C2QX2NB2DR1z8JNaZdZBTjw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(316002)(6506007)(8936002)(21480400003)(2616005)(235185007)(66946007)(26005)(966005)(7416002)(83380400001)(508600001)(6486002)(66476007)(36756003)(38100700002)(6512007)(66556008)(4326008)(8676002)(6666004)(186003)(86362001)(2906002)(54906003)(6916009)(53546011)(5660300002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jXnFf+ym/jT63xrf3Z1JNwOREXMhRZrA35IYWuCozVHtRwzYN4DI1Cj01NTB?=
 =?us-ascii?Q?yyVGoNeKJlrt5VOxCRtr4cVUKnU+AsaF62FCa/aAIFYkXXg13htbSZWXMJJ3?=
 =?us-ascii?Q?JyccfQlkpEka9Hd4u4TuaJbB66pBhQviQ8AnvNX1+YnNisGsK+j7a5QHi397?=
 =?us-ascii?Q?/NL0HQYo8mtJlibhzv5M82zS/Oh0HDKBGaPanmuKn9TyVONz1KZhFWfRgyPS?=
 =?us-ascii?Q?riV4UjyaF74hJigLH7WlKeMF0VvilOC24KdbXP0sr8jC7OJ4r1grKgPFgqu4?=
 =?us-ascii?Q?wxM/WiP55gC1p73qAKqvXihXHENPNJIOhIue5sdrYM8hdPTXpFzi3YLxo6Nh?=
 =?us-ascii?Q?EXX9H9tgwsqgx5Sz5iptoZI/dn+hJ57L82C3bdmQknChEL+fwMdtsYCipaIY?=
 =?us-ascii?Q?ElEQVV/BuraYYv8r8CfKe6eIcB353T/Az1pvhL65vn/iY5qS/Yt45ZS0B58w?=
 =?us-ascii?Q?loc1uub7XGCuLuzPIaOIMNAfbKy4B61KiofJSTuNqxfvp1Dp25llKWLcUvfp?=
 =?us-ascii?Q?Z7EkPC0ji7HrlVLEsmXKcsMUwki6ZuXl8IqHHpXQxoEqOySpvACjhcTxk/GR?=
 =?us-ascii?Q?ppHegQmMIRpO/bcL/oMhb+cuBzOGrH4pCGDCIaLfTPwzHY83UnwXhgW+vuZT?=
 =?us-ascii?Q?HJeV5hmBenaegrmMcIP/7oCOsgPM0MwpEzw6qMFh7M9d3Hm68PNp1YpnEhOA?=
 =?us-ascii?Q?apfBP/nG0XyH4IZFWG2JZ/f62gS2HIgojDxWTd8trqCfXCOJ/fd2QMplSsTp?=
 =?us-ascii?Q?G/uBVKY4xdaux1b0mkwhBKhDyKmKpGmwcjem1r8qQmWoF2PUKP61cenhPghK?=
 =?us-ascii?Q?BVLkyurIzyhHDCQSyFTA27kModDG9yYnVjCswm14ie4xMPdiBSp6rTa2bPKM?=
 =?us-ascii?Q?MhQLtpgZ1dg8LqT8g2Ywn/CDJuXyHNOnQ9pXvWNnHGcCYVSp4/aaBJQ9xi5o?=
 =?us-ascii?Q?Q3mWqd8QX5uazwsJvbYVnLnAJ1NrjFvuFRTos8wb4ngylm9hPXTWvTM/hb34?=
 =?us-ascii?Q?HwWkHieoKj5JznN/lXEAKDxAhUJUOKW/0zObeUittnXp0wVGX/uHZrNLCnCu?=
 =?us-ascii?Q?Rb9hkmJpsl7EKNnH4O3C4dbfKG9UbRoy+eYgltwZigRXwfK9V45z8+h//5JG?=
 =?us-ascii?Q?d5qLSd61L8MnGn7PuafzHMKHqbiTyu4AqIiUO2I7PCHTPSUVZyZUpzPprLVB?=
 =?us-ascii?Q?8n7BkgTVJBXMR6ZrRzzlkTeYk3QHXA+amWnJ4XN7FM9AMacKSkeFOpkhkl0M?=
 =?us-ascii?Q?zFIV9xYN/SSQL4gU1L2h0pdoWeecmP+P2T9k7wU/o9V2cRinRD4QNNmN8MIY?=
 =?us-ascii?Q?lsmf5Q3XHFNI0gIKR2MqZ85r9uX6fe+GpJwZgMIh3lRZG/P3pStmCRbnEdHh?=
 =?us-ascii?Q?uBDjIKx8385i3cY7Py8pp99c0jKlY7l06fKIXkFUDpRf/NRq0Uwl78tZkZcu?=
 =?us-ascii?Q?MxMdpgPzGksnUROyvjSRWq5yHoe0YkF0wSrdH4tYSw6MF1vzr2VN3RmCcL5y?=
 =?us-ascii?Q?ij4nKwHqPhFjOANCwxR2yj5mXjPN8vVC2y7zuqWLqKH5jPqhkHirU9PZH/bR?=
 =?us-ascii?Q?RGRmPlRhR/RcuheFs7F0N4fWMd0WzenzUzRkRS/AKNyKaGnByjTvFQohDm6o?=
 =?us-ascii?Q?TYNoAbl+Jo5oD2WvndKBmEMgb9Ejbb8QoFgetoDM/UIsAwE7F6Hm9W0I2Qxt?=
 =?us-ascii?Q?2eawCnoA5quI0D8ho2AChcXMxBdiWlkjo3xJnhNdD7i0Sz1vyevTTd/ZsVQj?=
 =?us-ascii?Q?DBQMuta+TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a66d8c2-fddc-4f97-9d81-08da29e57c9d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 13:38:04.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14ZN+d934frjiyKIqH2g+7SMy81fX/w4XWaH8LC7um0zqe6jIU6tl0CMu0ZmyiL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5A946B81-8ED6-4577-952C-246CC3288DC4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 28 Apr 2022, at 12:19, Qian Cai wrote:

> On Thu, Apr 28, 2022 at 08:39:06AM -0400, Zi Yan wrote:
>> How about the one attached? I can apply it to next-20220428. Let me kn=
ow
>> if you are using a different branch. Thanks.
>
> The original endless loop is gone, but running some syscall fuzzer

Thanks for the confirmation.

> afterwards for a while would trigger the warning here. I have yet to
> figure out if this is related to this series.
>
>         /*
>          * There are several places where we assume that the order valu=
e is sane
>          * so bail out early if the request is out of bound.
>          */
>         if (unlikely(order >=3D MAX_ORDER)) {
>                 WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
>                 return NULL;
>         }
>
>  WARNING: CPU: 26 PID: 172874 at mm/page_alloc.c:5368 __alloc_pages
>  CPU: 26 PID: 172874 Comm: trinity-main Not tainted 5.18.0-rc4-next-202=
20428-dirty #67
>  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  tpidr_el2 : ffff28cf80a61000
>  pc : __alloc_pages
>  lr : alloc_pages
>  sp : ffff8000597b70f0
>  x29: ffff8000597b70f0 x28: ffff0801e68d34c0 x27: 0000000000000000
>  x26: 1ffff0000b2f6ea2 x25: ffff8000597b7510 x24: 0000000000000dc0
>  x23: ffff28cf80a61000 x22: 000000000000000e x21: 1ffff0000b2f6e28
>  x20: 0000000000040dc0 x19: ffffdf670d4a6fe0 x18: ffffdf66fa017d1c
>  x17: ffffdf66f42f8348 x16: 1fffe1003cd1a7b3 x15: 000000000000001a
>  x14: 1fffe1003cd1a7a6 x13: 0000000000000004 x12: ffff70000b2f6e05
>  x11: 1ffff0000b2f6e04 x10: 00000000f204f1f1 x9 : 000000000000f204
>  x8 : dfff800000000000 x7 : 00000000f3000000 x6 : 00000000f3f3f3f3
>  x5 : ffff70000b2f6e28 x4 : ffff0801e68d34c0 x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
>  Call trace:
>   __alloc_pages
>   alloc_pages
>   kmalloc_order
>   kmalloc_order_trace
>   __kmalloc
>   __regset_get
>   regset_get_alloc
>   fill_thread_core_info
>   fill_note_info
>   elf_core_dump
>   do_coredump
>   get_signal
>   do_signal
>   do_notify_resume
>   el0_svc
>   el0t_64_sync_handler
>   el0t_64_sync
>  irq event stamp: 3614
>  hardirqs last  enabled at (3613):  _raw_spin_unlock_irqrestore
>  hardirqs last disabled at (3614):  el1_dbg
>  softirqs last  enabled at (2988):  fpsimd_preserve_current_state
>  softirqs last disabled at (2986):  fpsimd_preserve_current_state

I got an email this morning reporting a warning with the same call trace:=

https://lore.kernel.org/linux-mm/CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuD=
rJyN9mNScJg@mail.gmail.com/

The email says the warning appeared from next-20220427, but my
patchset was in linux-next since next-20220426. In addition,
my patches do not touch any function in the call trace. I assume
this warning is not related to my patchset. But let me know
if my patchset is related.

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_5A946B81-8ED6-4577-952C-246CC3288DC4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJr6joPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUfLUP/RIRsH63mgD1OMLB4Q6PbDP1cyf8dajw85SG
WUnMUWeqq34tiSYGSgIKmauiDGDoehBqUuzaQDwLM0Kcs2yfYojSHGnQ2i4Zviqb
mzLIUPEU+asMsbgb4mNQnYrKFoJH45uo5W3otaFzmRuEQ3E97wAoC3G+BzspfEXd
Ad42RRwCW+DJvFLtdUBYn7J9in1LQeWskUP7bEi6nEv9JFctnyhWlvvRSLIOk839
i8qjn1bEctr+293m75owO3jQYh8sv5nX0jnuJIp5r4Z2q2wEWxPiVGBK3hoQBZY/
TK2WsmkPn9531mPOfWA40Ees6fUo5GZukwKcjFaQY97rncqKuVrRESr54GtoAt1b
nkZ8TMDiJf5PH9VRp7WZx65WW1Tj0rUfmunghwVaQaL4egNqZ6r7Hg5QyevGzuUU
bbMVZHIAGcVRwagFjTcaURWs2P8qnfwpsLN8vq8FC+uMPQwdndvg1dZgxjJ2OgQ6
ddgk3af+L4OIZ/fccZJf4FAtj5XpWW0kKFtXvXvlQ5YoA3hrfClCrGXCoaFekkTJ
wGX8AKb75GJJWXT7CzBALOHK27mAd0c3/FeOAj3wx1jC8X8IDQQTN8/O/1iipPpq
qNQxVb8hkDWODp/18WNNsh7SEH9/6TkCvxufDsb/lOU7GihNyQb9KqW4uogAWu85
R7M+vXME
=z+9+
-----END PGP SIGNATURE-----

--=_MailMate_5A946B81-8ED6-4577-952C-246CC3288DC4_=--
