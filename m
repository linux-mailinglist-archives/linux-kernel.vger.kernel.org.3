Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDB521D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbiEJPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345192AbiEJPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:05:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE782CE200
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSqvkLp6aVlf4baW0fx9CkTnvm2zFbmfVVwFG1+YMdoKVSHkr59mv8jbxk8g/PkIW6wKxld7NDHqEb1kbUw+JrtBdjhqcK/Wx2WyovPxag8PB/OwtDmNGUkJXnMrkMed4UHW55VIrUxdCWgL9F84r2ZYPd2qLameGby63o6qN/RCr17muaRVI0pWb3+c5/mr+VJYVlvKI5i+bZKvYuxKsrHFOh7C4O97nVGvgv8y02GCsdcdVXcoKQcMx6EDhdSYqgGQ0nviW87N4r0kbNXGVsnBNfGrS3m5UrP37BQv7WT0qRUtrHCFdg+YWMc/pRQOiN5pLiJO8XmtOtHRgmmhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1nNIbnV+DINGItxdQAUUBigP7KlsJNolEH5y/Mu7HU=;
 b=VonmlRW1C7cnUZn8u4ml/6nC8a2CPrphUTcqziYXnItoU/EoZURQ/606uNoFW/IQLNjSp628HCJPHdDSMft8MTvDvVWC21QitqeC7Qw0wN43jhuqeNgA5ArhTikJX3ILtHjeZmhNXG3qhV38N52zhSkCeynoE1Epgnll2wvS5p8xCqYUZmOSUHoi6gSN8OwhT/1rP91nJS6ie9Z4FsaEbZOdTxpl+/2npVVdWNhnUKOXzQPDSqdtP8Zo1Z673Vpl/I8Hf9SSKwvNe1D91BKGrDbgFXkJB7T28x8Fi1kjG18lTt05b7SRaUveGz3kLcEKyNB9YiALv+5npApIQLjG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1nNIbnV+DINGItxdQAUUBigP7KlsJNolEH5y/Mu7HU=;
 b=W7qiw1ieaXtpV5KJjpty/MPSw3oDFs8IAYtblAWnPOJchTQX2w+bEW6k3AZbBIBxixNmGC9QvzU2dsI9h+RLMVAmfh74PyPg6pl20JeH3inJSWstG97wOSaGt7o0jKycHkdqrbOXOxQICTVxHI2PCpVQFLiDOXFQ1nOg3d88xX8XP4P68uSteR88WYapLu1y1orGPU3dXXMTnk1E58BcbwHKirbSZVjapOZ5V8TN4p8f9M9GAyhaXOn2QcAZroZVyyaSY765WSYT/JRv1SDZmpPT3M+P8+OZVPaYCeOiRG/WRwn/fPSgB5gK7lzeSMvmiHIaPtakxQ0raZLwtHCFVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 14:30:36 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:30:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [mm] 23e12fc477: UBSAN:shift-out-of-bounds_in_mm/page_isolation.c
Date:   Tue, 10 May 2022 10:30:33 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <06E9A7A4-AEF9-43CC-8AD5-B7B6263ADF73@nvidia.com>
In-Reply-To: <20220510095824.GB3969@xsang-OptiPlex-9020>
References: <20220510095824.GB3969@xsang-OptiPlex-9020>
Content-Type: multipart/signed;
 boundary="=_MailMate_03AF8A98-5AB6-468B-AE6B-BD8D6379549E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6411f498-a91f-4a06-aa05-08da3291a5e2
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54385301CE38EA9B298FEEE6C2C99@SJ0PR12MB5438.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZhL9Ewkv6GT55/fo7UoVMU6+n6zQtZlSe9kZDYquTCvK0bIA0dkK8nstBJK6wRo8V6aXMHC7eZjc0e/IxqlMf5AQRyEIx5Y1RJ/Y4PYzWeoN0zIffMcECuzRczOy0/mdavI/mbFscFtnOfGHNgF1tc4G9dHg3iWjCjAp71qzJuzZhfY45m/1ToKuAxB8ZfpzK1h3SHxFJ4XkQbAnk6gIj+I3egCNBbY0kevGU9ZsiKwiuZQT10hnZSVSKZBZ2/h3N26fIufai3bsgZwQqmyjiZAyttiriSmXnkxxvJPCnBQhlpWmKx820zAzmvjyBk1eW4SFamUmRqj6rwSPKu2JGxugzf8EhX2/Vgtc75S5a6fI0K/JJ7nK6ufP1RYcq5D1ktm2F//LJWiWXZj2UnLL823IV4RXNM4KNvVE5u4fHcgy5Z+k7V19iw9/yYuedv1DvR2IgZgL4NnKfqU9iWtnyfG08QEEW9K3OvLcvgr7FAP9GdrJg4axNMVHZ/1bXH4VujNj17AOUUHkx6mlZW1OKGTQQqL85YW8vxyF3T00PeRwPLv/2Lgd2tWoODgfIXkUtXf8HN8OWj92CdGdSnFnACzE8ROgA9NXT3vDH2uXZvthzIQPHG3KAAIo96+1YzEyulShqxwsVAUcWKnmYaBsgukKg8q5IMHdexqjEU5P737S7jGZGurxArffqDMq45FeLv3UvajAV9dquuFDMXySojeJKQwTp9kIcRPhaYq5fa6EN8F1vjVtumTjBHOmesy45wkFjhsqTeLIF91ucp6dRlCrcWP06WXcd80RvOSKPvAPbTHGO6FuONoPyZXdmIVhAkeRdCFBls9h8ajSplNodQ3mu7mJt8631X/c8VqffQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6666004)(21480400003)(316002)(36756003)(2616005)(6916009)(186003)(83380400001)(8676002)(6506007)(66946007)(4326008)(235185007)(26005)(66476007)(66556008)(6512007)(86362001)(8936002)(38100700002)(53546011)(508600001)(2906002)(7416002)(33656002)(6486002)(966005)(5660300002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clK2VR1DHtdvlndUrWrlxMDrcUfLr/YIht/S5pfoCjcDWacyhW68Zz5DOqp/?=
 =?us-ascii?Q?FVV0r6LS7p55y9Q5FkqOntv2Zsp8yW/qRolZzi2xBtjftg+cigD9b2mQVh+u?=
 =?us-ascii?Q?Z9GNsRD/uI+8iw1C4QSJvbaPFPaLLxSJnA1ITOwpZcKrAIydco90L3dr0iSy?=
 =?us-ascii?Q?IPJ6G7ohaoI8Ubscu5IcV2+jwPjX9bCXva5f7hCoehlU0nZGBV9qJ31UH8jR?=
 =?us-ascii?Q?T7pyj79+j+gTV00S1mtZ0oBXldNzPMVYnmbwgDJtoGSEHkq8l4T2IOelocGd?=
 =?us-ascii?Q?kjnE0zV1HW4GOhimGZWVUIuSw+HLo7GqNB/sm49NAsUtLlxb4DwswN1hUQsv?=
 =?us-ascii?Q?SFZcsMAxYhKShL5kWKdcWREjUj2vssLiNZF+zVtYXnvfkQe5N9gH6TD+9Xi9?=
 =?us-ascii?Q?vHjLNkFuEqeGyjjnOTyZMXhmuz0/9mBUXli+6uV/63jKkcGNW5TBzmU1FOx6?=
 =?us-ascii?Q?gKa4LO7sdf/H6528KXx1T4tDHqzupB2obptKa1deDbqLD6QvT7CqX5BOlmN4?=
 =?us-ascii?Q?TIi6vSlz1J/1SJsR4kDpfd8XzJ2R4mHIpaMpcCTX03eE7QZqf3L83iZEy8ky?=
 =?us-ascii?Q?E72vOgrv8gYvxxkYGUKXK7o7TQS7ybbpHLiOHmw6MI8YHFxnEeqEr5+4S05/?=
 =?us-ascii?Q?DHnnGNb8oNyjkLbC+L6fjOdzLFCIxVB2VNxNDXvfuy3rstMh9Tqh9J++9iCu?=
 =?us-ascii?Q?QsxbfIv/j0tsXAYGW2YieVLhoq1xkyyA0P7qpVG2JQ2TW7rB2g/UbON+STmD?=
 =?us-ascii?Q?5tlLXKHHzAWqzGOcdvjXDTGXQ9/N1einEHe5ZVWH+bVcPlZ7zdpJfHxxxZDc?=
 =?us-ascii?Q?R17zaLjHz0gpJy5f2aw1rSq9dCjpZJ1qiGwnC8b3vdIjWYqYUuNKxBFI7bzI?=
 =?us-ascii?Q?tn04rXzjP3mJf7A3OEiABblkcvX8dVuf17pZFjUGJcDo5XJrprtAeZiW5oXN?=
 =?us-ascii?Q?PCNVr8J7UIHoe3hhfmeRAdg0GJrYziuRMSxy/w14UHxWs5/nCsDFKRfa7D0u?=
 =?us-ascii?Q?AKG4nTRh7bT3KDuLLT2SFlKjYOE8kJdWIGc0UZexLWxaMWTvVuDQiDqnagN2?=
 =?us-ascii?Q?3jwyopJ2M9P5SzIuVCJuZeP8LQ9Eo46lS+c4Jb/qvYl3lJCsCmBHTS7b4OA+?=
 =?us-ascii?Q?ZNeVFqlYkNNOEbotASd9UocO0Podpg/bUEJqi+dnJQQd8b0wobXKLLYVMD78?=
 =?us-ascii?Q?JrPIkV6rTWGHVJPwFhOvhjfFqCh2WkutD9ECbjgKtftqzDfCoP6uhzaoiTmo?=
 =?us-ascii?Q?bOh1v4nLY+nTbfdQwhxC60Uzla0MSpKFBLh4eq6K7azwzlKUZwYBHPwsoQVc?=
 =?us-ascii?Q?NNGhjbqTE10FoUR/8ZiRYkQ+VR8+JFB+x4ikkRWDmo7cjGGbVluie92xOU1K?=
 =?us-ascii?Q?2uk9he0lI56bA1rc0Sv6AWrz7ij0784efsayGFVd57xFJc5FJ7Do4RQ/nU6D?=
 =?us-ascii?Q?16KUnvtgavr+J+5e2X6Cpwts1RsOV5jEyNKh47Yo3xQfaXErVEHcmfSMmzD1?=
 =?us-ascii?Q?guqHBy+zgJuX9aITF9TMhaUSt/anWnrwThOnHd+arSgCweGABYSNNiaqO6df?=
 =?us-ascii?Q?SpvuYVv8pl3U7oQ7NhmSvc+QPZ8+OqzJEJIrsvwcjw04iFBFckn0eHmyjM4z?=
 =?us-ascii?Q?FRjJSZsXIKQ57hGwXS2Ol1GHU5j3swizEfCN0XMxhvHwq2jbnVyVb4sp0Q4x?=
 =?us-ascii?Q?c0mF+NRcOTzcMchn0Gjwbdh4JPLbC1w/r4S7SmJYFLLwpC55cVs2t/MX0E1G?=
 =?us-ascii?Q?S/skOlviYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6411f498-a91f-4a06-aa05-08da3291a5e2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:30:36.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzQ7eoQEzjSW8+T3EEm3rihX6mXwt/2uGbp5XpsMgxEr586y5BqqE9C7XAi4eQUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_03AF8A98-5AB6-468B-AE6B-BD8D6379549E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi kernel test robot,

There is a fixup patch for the commit: https://git.kernel.org/pub/scm/lin=
ux/kernel/git/akpm/25-new.git/tree/patches/mm-make-alloc_contig_range-wor=
k-at-pageblock-granularity-fix.patch
It fixed the issue as I verified it by following the steps below. No more=
 boot hang.

--
Best Regards,
Yan, Zi

On 10 May 2022, at 5:58, kernel test robot wrote:

> Greeting,
>
> FYI, we noticed the following commit (built with clang-15):
>
> commit: 23e12fc477f1c2729af51c427087e777d6e63803 ("mm: make alloc_conti=
g_range work at pageblock granularity")
> https://github.com/hnaz/linux-mm master
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [  103.625478][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  103.628487][    T1] UBSAN: shift-out-of-bounds in mm/page_isolation.=
c:416:17
> [  103.631041][    T1] shift exponent 64 is too large for 64-bit type '=
unsigned long'
> [  103.633539][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0-r=
c4-mm1-00249-g23e12fc477f1 #1 4cafac2312e666eae49f8458f1d93cbe9d5338b2
> [  103.637394][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.12.0-1 04/01/2014
> [  103.640378][    T1] Call Trace:
> [  103.641583][    T1]  <TASK>
> [  103.642670][    T1]  __ubsan_handle_shift_out_of_bounds+0x356/0x3a0
> [  103.644703][    T1]  isolate_single_pageblock+0x683/0x870
> [  103.646498][    T1]  start_isolate_page_range+0x69/0xb10
> [  103.648349][    T1]  alloc_contig_range+0x27b/0x680
> [  103.650010][    T1]  alloc_contig_pages+0x413/0x550
> [  103.651549][    T1]  debug_vm_pgtable_alloc_huge_page+0x27/0xc1
> [  103.653486][    T1]  init_args+0xa5f/0xe06
> [  103.654924][    T1]  ? __hugetlb_cgroup_file_legacy_init+0x61f/0x61f=

> [  103.656949][    T1]  debug_vm_pgtable+0x56/0x3e0
> [  103.658484][    T1]  ? __hugetlb_cgroup_file_legacy_init+0x61f/0x61f=

> [  103.660556][    T1]  do_one_initcall+0x2bd/0x740
> [  103.662132][    T1]  ? __hugetlb_cgroup_file_legacy_init+0x61f/0x61f=

> [  103.664179][    T1]  ? __llvm_gcov_reset+0x740/0x1320
> [  103.665837][    T1]  do_initcall_level+0x13c/0x284
> [  103.667460][    T1]  do_initcalls+0x75/0xb7
> [  103.668995][    T1]  kernel_init_freeable+0x158/0x1f6
> [  103.670678][    T1]  ? rest_init+0x2f0/0x2f0
> [  103.672143][    T1]  kernel_init+0x18/0x2a0
> [  103.673544][    T1]  ? rest_init+0x2f0/0x2f0
> [  103.675026][    T1]  ret_from_fork+0x22/0x30
> [  103.676494][    T1]  </TASK>
> [  103.677587][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  140.018114][    C0] BUG: workqueue lockup - pool cpus=3D0 node=3D0 f=
lags=3D0x0 nice=3D0 stuck for 32s!
> [  140.021174][    C0] Showing busy workqueues and worker pools:
> [  140.022912][    C0] workqueue events_power_efficient: flags=3D0x80
> [  140.024730][    C0]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 =
active=3D6/256 refcnt=3D7
> [  140.024759][    C0]     pending: neigh_managed_work, neigh_managed_w=
ork, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_=
periodic_work
>
>
>
>
> To reproduce:
>
>         # build kernel
> 	cd linux
> 	cp config-5.18.0-rc4-mm1-00249-g23e12fc477f1 .config
> 	make HOSTCC=3Dclang-15 CC=3Dclang-15 ARCH=3Dx86_64 olddefconfig prepar=
e modules_prepare bzImage modules
> 	make HOSTCC=3Dclang-15 CC=3Dclang-15 ARCH=3Dx86_64 INSTALL_MOD_PATH=3D=
<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-scrip=
t is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> -- =

> 0-DAY CI Kernel Test Service
> https://01.org/lkp
--=_MailMate_03AF8A98-5AB6-468B-AE6B-BD8D6379549E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJ6dwkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUMjUP/j7aOBMZaHxHIdXlhm+nYzId2RJl8tUlA/S2
hMeF/SEYFdTmQPt1QdZyZ7JwejOKgH8Lt7jjfuekfaSJSU7b48Txci3iDNoFEn3R
SAxlR2z2f4GLEn1nSrKXSZTE8qwttLab9XQISbNtMKqqp1Wf6J5fUNzo2dyHNtOi
/gOpb3l22odrYf9Ypz49xkLioqUSJpuhpsFhfngMBz4B35T4yW5/CFHCsj57QCMz
CPmfzXlrFzy7BXbfQjjsyg+GTZmYZkw2VbyYisyQmIypUDnFrCw3CX7tRlE5DRWX
IuOH4372xyH8myIHh+N6h5OJIlGndko3cMXJbYO0oH1+/gxRA1a8FBVwF+z6rK8j
VL+P74A8rakVnJbK2sjVS2iyEtqFKqGa1aVQ5uCo25oMVBueB4WSXX4/MK7RgzFD
JMkrV6AAUZXKN/FUl9wocn1ayRE8DsxLhJoM+5ucsMq81ls91faNV6u1qdbzl4vi
jrvR8Ie7DtDPvGtGZLs8sVAam5o7EO+k1nyB9sNnQTYzyI9/RkNS05aWhC/A8F3x
A4qB+ZUeYfZO27IBfwz1EbrOIWRgPTdKe+dbMpNfaCzDhw7KjLuStggu3Jvw9Bhs
8GpC4POEAg9azzLUuj2HfvVLX4J/j+YdDRQazBvVWSPSMDB/4aEpKBJ3ExiJNZ+K
lodsKESP
=LSdH
-----END PGP SIGNATURE-----

--=_MailMate_03AF8A98-5AB6-468B-AE6B-BD8D6379549E_=--
