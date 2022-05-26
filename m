Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E544535290
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiEZRed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348292AbiEZReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:34:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9376D4EB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz5wALT5XHHDMyiIEUARB+RKbWRfLBxHX0o3kRSt5j4/1bu8Nkgqc5Yo4d3zUvLtKua01f8J5ej6/MxAkM8Ya7aJ2WU/0wDwgcBx1RYSRhO9xUO76mR+VRStdO4XHNYiRiniQF2zJrSo27075IZqv2wJAB4FpfoZyahFkyIdqMwJwbAeIidaRd6h2GtQMfr5KzYv0QjYneGJLiJRhQTOthp9T6buIajiobHd8d/q/WfJNLG7Fjhs+L0iVkzcGnD7vEicMY8BQaLqArheWu/UnwUUC6U2fo75DvQB6T21wVvhrQPGCX1GmEaXPOM0CbPt6KoKMno+LD6dMSCB/23TiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1x5blK0JoVk62SVTvnBWDkhPYWOf5r/kG0nl3VwjK0=;
 b=cHTNiUSb/qG2AqVtB75+I5XR/XyILskzBLLx9AinXZ767jmc9+GZnSMKS/FTA9veMYO0CbRApLyGLh9yiIu1KMWa8phXxt5aABRJb5YUknad45rp0U+gNfw9g6bYJPXx2cw1D4tN5jnqKyM2uWq3H3MAsozfrXGqg7jD8gNcTjO8J5oeFhIqYiK+GUia3Yba+4WZ74VVg/g8zIYj1B9RYOLuxvClz5lCe/DfsUtplivHVxeN8vrvlGfMldRxpCrci3Hyl8Cxf4oGbFPXj5f5spTwpsGgpAYfTjUPFsCm7aLap1tXEbIO2wyR7+aidW1kixf81RE2EgFEduw/9ZawDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1x5blK0JoVk62SVTvnBWDkhPYWOf5r/kG0nl3VwjK0=;
 b=JW2bY6ZQQXmzU7rPMG8pfPzquouRgXkhHj4Fkgjv08J32TWnZ4HtNLYgSPbnSfgeKjIq/Pi4vULhyj25X8KCkmHkafPULHWwnXL5AyYYDRSgSRALRzXjgBXVVH9Y3zpSN3OJr8UFTjiNZz59mBQpTu3FB2ZB2qwlkxmkDGd2+FXvMXCc+lD7Rjp0moW8gY8cpz5bO8aqnB8bSiHwo+NdynEEhYqJxngpSvSORFzKsWwAUfd07+2YpoZNA4bUDKcKPFSsUlieWIUjrW07zSnsejkTS5Gqf/aP/QCxYYtp3zSI4mC8nIWHLWmA45YSRkLtMBbJgNJNZ4lXHzd8M7f+7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 17:34:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 17:34:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH v11 3/6] mm: make alloc_contig_range work at pageblock granularity
Date:   Thu, 26 May 2022 13:34:24 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <805CA8E8-9216-4CB3-BC8E-DC89456FDF3C@nvidia.com>
In-Reply-To: <ABD35D2B-58CB-4050-8B45-17F34B360573@nvidia.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-4-zi.yan@sent.com>
 <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
 <180aaa57-28d8-30f0-e843-ea52e3a180a8@gmail.com>
 <F80CEC0E-0EA8-4210-8730-57D4D0CF0B23@nvidia.com>
 <fcac3340-31b5-8536-fd4e-ecb8a9aee2ae@gmail.com>
 <ABD35D2B-58CB-4050-8B45-17F34B360573@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_615B2FAB-BB7E-40BA-8FAA-F734621CCD52_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae985b9d-3e18-4a7b-9f93-08da3f3dfb72
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4289F15218301BB55BAE2CA9C2D99@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCMkMgYQn+/y0pmUGOJIu0zXjeRAla91KRsBrSQly0zvsJPITy+W/dUBuT2tlqwAUPj47FRKkKnQa0WGJiTFx1l+mj1QbWQNX6OhrVRsce7LbDpoMO0mBRAbBXRvjYAlFJ568+5rr36RKOviC3upQ0UnimKUcOAYtXvlVd9TpWVPQerx7Y386rd9W1l7VDU5RFoUUWlNSd41MZXY2jxnmmObMTacE0gtHHW4h6FQqgOtNf7flXUxl7EOiX2AwDS17R2ky5iDR5VRGMJeLUGBdYZgvDCsM8vj8FwY6Dl8NRSK5K1IAcCNDVkbYqWbklzjMb4EUzopgjOozgs26c3CVq4kmMMKMNzhn8Iep4XTmND3CGCmpPUwnKQhD1j2gRezDaK1jzaB0F1U1KfIqHmFOdWvYpyhDVyy2fn6GuoRnnS7wapP65QlkGRBjplLhRO7N3n5cLuirz0c3m96WV4q2gRdC1wM+ERyVjSj1wcFSgYSr4YL3SxgQA07+HPirrUiN3Ck6E0gAanQuTEzWbcUc9Tq93gIvMUUGGz/I712wTIJ2gNacuhJ1kRExuFi/Z4/mjvG8YrSq3Zp7INZPMo5wdHK1dZEr56i22OgKdUKBCOaejNAUED9wFcKG52KYL1PYz1XHdl0Q2lMWCtirp2cZXR8QxSxwhJr7L9Cr4fWYvvm7lR9gM38gldIZzMWVQijrdp03p55H+6UNrPGabxQ369o/HKlNJPRYv8ur+p0WkTtyNmS9NEkkAP8NJPxFkprDB0z9ilVht3yoeuIcRrFWqvr1M15gDbCYKPpxnjFXYbLglmRtfGoeigg0wzqbuKo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(316002)(2616005)(6512007)(53546011)(6506007)(26005)(8676002)(4326008)(66556008)(66946007)(508600001)(86362001)(6486002)(966005)(66476007)(33656002)(6916009)(21480400003)(54906003)(38100700002)(83380400001)(30864003)(7416002)(8936002)(5660300002)(36756003)(235185007)(2906002)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lnV+V3xNGjCGIXXuzP1mgemwCbhUn/WqX/Vc49KWweAEGh26qE63WSfe4769?=
 =?us-ascii?Q?ENGt9UpKyWgN1AnJTDF+yjnAO25tBvMrxi4eQMIqQEsT2doOwbPnq+kSYoIc?=
 =?us-ascii?Q?DOUCrLHe9T/EXTQnZbKlNQPN7PdKUN7aXWV/suVIqQKICDYArIBbQ09+LwKS?=
 =?us-ascii?Q?QbxbEctscRsoV/v233WcbyxYfI0lZfdlaEr8c084u8yLRuq2YwW639FPNqdf?=
 =?us-ascii?Q?c6a41Aw20hoantLXQi/Mopkx6PCxoYq++ONwVlHfsaMYHKagrTiczhr47a5N?=
 =?us-ascii?Q?V+c8U+ge5HzGv/wRbznNMJ9m10EjD7K7SHUXQ0jcWITr0Fr445EMJ/gSNke8?=
 =?us-ascii?Q?hNkrHQjVw74lZTNDtCJf+qi3EPjsbG4HxXPTsFIdDdm8/J7L8t+qSL5/PwIT?=
 =?us-ascii?Q?M5NGVBbmFelCyKSyp0Qh4J8O6UdogzloYJoK/ds4S/Ifv/Z6d+MTQ/JlVOFu?=
 =?us-ascii?Q?aPfa3Y1CjUTF4X9h00hTfArwtyH1mZX2MATWvZS4S4Z2txHkF/nacEGgVFql?=
 =?us-ascii?Q?HdCvGiTRBGIVD0dgphG58enTMEPDmnVcq8l4F5n6ixqMzFClSAgzFL/yNkH6?=
 =?us-ascii?Q?s7d8hhal8VMtb8HwktpLxzzCfklgTKv8XxWo9vT31R7ULL8zwfcNNMy3GQTx?=
 =?us-ascii?Q?hLG8vh/43B09iNwbcsMJPa7JwyBK+XtRDkRD9tRp55oysGaSsLnbJhzRlCUQ?=
 =?us-ascii?Q?315gPO/OLK37w+kAxlRPyEptAVFOpGAPll0vUQVvJEOOmXyMNJa/GmlRm3OS?=
 =?us-ascii?Q?H9WK4ZJq1GtOS7aROT2s042BSsMNQjdZoi7bHyUipSFkPH3RyUHNcvaK/2Yw?=
 =?us-ascii?Q?HnutjMOSmNl1KyuqCeCkdcSN5BtO3H5tNj5wim/BE4g0UoQFzuHop3lXUlne?=
 =?us-ascii?Q?rv2MscFIcgcH4ccszwWKyaScq9Ft9pa/tRxgXxYARijkvQFgxKPytMj5AZvy?=
 =?us-ascii?Q?+BjTNMJcB3EGa7tj0VyJ5/uqGAXReG4WezRWt5puVWIxDOjWORxWoi7sBOGQ?=
 =?us-ascii?Q?3Mk17R93viyQZ2JainwBqjwThhA2KMOH8XusD3d2b2Zuf3gK7gsX8wqriDf4?=
 =?us-ascii?Q?a+W3qLz5gbGBRq9wNhuGy00nhC4+X+Nd6/mH8ywlpvQP9MKqjdm+47DkNwoW?=
 =?us-ascii?Q?XWhBvnvjT1VL1xTGjGM6YKd0aQxea4plTZ6XnKgRnBGXCEeSduoMBU7lsnCW?=
 =?us-ascii?Q?0+aUEnEs7k2e8fZIOA/PgmNuvL8HPKZZlFQuu/tY+tsdKr8tDU6D/Ga6N0qp?=
 =?us-ascii?Q?zEbc01qBDEKs1/n9eBm5nx+VtGcm4Y7pwyV6xWZvD9IQKDcxCgaxhZGuplbQ?=
 =?us-ascii?Q?liP4XMFLCPNx8i4FzFHdh6IsruGXETEIpu59J9hK24icU4fRCiMxnBXEvw1m?=
 =?us-ascii?Q?3Cbj34nbruqcIsmFMY5gLVLATDDxmRElfQCi08gGSoZOJ5AQuJzD+S7yGl1k?=
 =?us-ascii?Q?W0O+W7yREysprIz31YZO2XLAw7oLb6p/+oCfhGVgi84C0U0w5xb6tW8GECAv?=
 =?us-ascii?Q?c1YVryHmEeoptmoqv/+g8bOlGqvqkOhhXgsc5chqM110BwrWV45r5Mh2GLrX?=
 =?us-ascii?Q?o+S0cCVULS51CTmG1x/3M3AjYpY3LTGtNZTwaJeGaioX8EUD/Qx0Kpt8YWpk?=
 =?us-ascii?Q?4HvBvUiMhP9VTw5q6sbdVP+Gr+3/T/w3YktBvkf2atbEWcKD8iG+sXkuZvTH?=
 =?us-ascii?Q?LqpWgPIXqWwaJFx3QPdhlG9coXzj/bFsGIsttVapHcLoHS5YNDgrXNb4SlsS?=
 =?us-ascii?Q?ihzCrhblKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae985b9d-3e18-4a7b-9f93-08da3f3dfb72
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 17:34:27.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68bWQAl3TLKzEMmVyEnhfkf9xXbPF3n+0dM1UTaVSi3ltvXEZrq3yHsk/Zqq6UOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_615B2FAB-BB7E-40BA-8FAA-F734621CCD52_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 May 2022, at 17:11, Zi Yan wrote:

> On 25 May 2022, at 17:03, Doug Berger wrote:
>
>> On 5/25/2022 10:53 AM, Zi Yan wrote:
>>> On 25 May 2022, at 13:41, Doug Berger wrote:
>>>
>>>> I am seeing some free memory accounting problems with linux-next tha=
t I have bisected to this commit (i.e. b2c9e2fbba32 ("mm: make alloc_cont=
ig_range work at pageblock granularity").
>>>>
>>>> On an arm64 SMP platform with 4GB total memory and the default 16MB =
default CMA pool, I am seeing the following after boot with a sysrq Show =
Memory (e.g. 'echo m > /proc/sysrq-trigger'):
>>>>
>>>> [   16.015906] sysrq: Show Memory
>>>> [   16.019039] Mem-Info:
>>>> [   16.021348] active_anon:14604 inactive_anon:919 isolated_anon:0
>>>> [   16.021348]  active_file:0 inactive_file:0 isolated_file:0
>>>> [   16.021348]  unevictable:0 dirty:0 writeback:0
>>>> [   16.021348]  slab_reclaimable:3662 slab_unreclaimable:3333
>>>> [   16.021348]  mapped:928 shmem:15146 pagetables:63 bounce:0
>>>> [   16.021348]  kernel_misc_reclaimable:0
>>>> [   16.021348]  free:976766 free_pcp:991 free_cma:7017
>>>> [   16.056937] Node 0 active_anon:58416kB inactive_anon:3676kB activ=
e_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(=
file):0kB mapped:3712kB dirty:0kB writeback:0kB shmem:60584kB writeback_t=
mp:0kB kernel_stack:1200kB pagetables:252kB all_unreclaimable? no
>>>> [   16.081526] DMA free:3041036kB boost:0kB min:6036kB low:9044kB hi=
gh:12052kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB acti=
ve_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:31=
45728kB managed:3029992kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp=
:0kB free_cma:28068kB
>>>> [   16.108650] lowmem_reserve[]: 0 0 944 944
>>>> [   16.112746] Normal free:866028kB boost:0kB min:1936kB low:2900kB =
high:3864kB reserved_highatomic:0KB active_anon:58416kB inactive_anon:367=
6kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB pr=
esent:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3328kB l=
ocal_pcp:864kB free_cma:0kB
>>>> [   16.140393] lowmem_reserve[]: 0 0 0 0
>>>> [   16.144133] DMA: 7*4kB (UMC) 4*8kB (M) 3*16kB (M) 3*32kB (MC) 5*6=
4kB (M) 4*128kB (MC) 5*256kB (UMC) 7*512kB (UM) 5*1024kB (UM) 9*2048kB (U=
MC) 732*4096kB (MC) =3D 3027724kB
>>>> [   16.159609] Normal: 149*4kB (UM) 95*8kB (UME) 26*16kB (UME) 8*32k=
B (ME) 2*64kB (UE) 1*128kB (M) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UM) 0*=
2048kB 210*4096kB (M) =3D 866028kB
>>>> [   16.175165] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepag=
es_surp=3D0 hugepages_size=3D1048576kB
>>>> [   16.183937] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepag=
es_surp=3D0 hugepages_size=3D32768kB
>>>> [   16.192533] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepag=
es_surp=3D0 hugepages_size=3D2048kB
>>>> [   16.201040] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepag=
es_surp=3D0 hugepages_size=3D64kB
>>>> [   16.209374] 15146 total pagecache pages
>>>> [   16.213246] 0 pages in swap cache
>>>> [   16.216595] Swap cache stats: add 0, delete 0, find 0/0
>>>> [   16.221867] Free swap  =3D 0kB
>>>> [   16.224780] Total swap =3D 0kB
>>>> [   16.227693] 1048576 pages RAM
>>>> [   16.230694] 0 pages HighMem/MovableOnly
>>>> [   16.234564] 49240 pages reserved
>>>> [   16.237825] 4096 pages cma reserved
>>>>
>>>> Some anomolies in the above are:
>>>> free_cma:7017 with only 4096 pages cma reserved
>>>> DMA free:3041036kB with only managed:3029992kB
>>>>
>>>> I'm not sure what is going on here, but I am suspicious of split_fre=
e_page() since del_page_from_free_list doesn't affect migrate_type accoun=
ting, but __free_one_page() can.
>>>> Also PageBuddy(page) is being checked without zone->lock in isolate_=
single_pageblock().
>>>>
>>>> Please investigate this as well.
>>>
>>>
>>> Can you try this patch https://lore.kernel.org/linux-mm/2022052419475=
6.1698351-1-zi.yan@sent.com/
>>> and see if it fixes the issue?
>>>
>>> Thanks.
>>>
>> The last hunk didn't apply directly to this commit, but I was able to =
apply the patch to linux-next/master with no improvement to the free memo=
ry accounting (actually anecdotaly worse):
>>
>> [    6.236828] sysrq: Show Memory
>> [    6.239973] Mem-Info:
>> [    6.242290] active_anon:14594 inactive_anon:924 isolated_anon:0
>> [    6.242290]  active_file:0 inactive_file:0 isolated_file:0
>> [    6.242290]  unevictable:0 dirty:0 writeback:0
>> [    6.242290]  slab_reclaimable:3671 slab_unreclaimable:3575
>> [    6.242290]  mapped:935 shmem:15147 pagetables:63 bounce:0
>> [    6.242290]  kernel_misc_reclaimable:0
>> [    6.242290]  free:1059009 free_pcp:1067 free_cma:90112
>> [    6.278048] Node 0 active_anon:58376kB inactive_anon:3844kB active_=
file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(fi=
le):0kB mapped:3740kB dirty:0kB writeback:0kB shmem:60588kB writeback_tmp=
:0kB kernel_stack:1216kB pagetables:252kB all_unreclaimable? no
>> [    6.279422] arm-scmi brcm_scmi@0: timed out in resp(caller: scmi_pe=
rf_level_set+0xe0/0x110)
>> [    6.302501] DMA free:3372200kB boost:0kB min:6032kB low:9040kB high=
:12048kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active=
_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3145=
728kB managed:3029800kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp:0=
kB free_cma:360448kB
>> [    6.302515] lowmem_reserve[]: 0 0 944
>> [    6.310894] cpufreq: __target_index: Failed to change cpu frequency=
: -110
>> [    6.337920]  944
>> [    6.337925] Normal free:863584kB boost:0kB min:1940kB low:2904kB hi=
gh:3868kB reserved_highatomic:0KB active_anon:58376kB inactive_anon:3896k=
B active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB pres=
ent:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3492kB loc=
al_pcp:828kB free_cma:0kB
>> [    6.377782] lowmem_reserve[]: 0 0 0 0
>> [    6.381461] DMA: 4*4kB (UM) 5*8kB (M) 3*16kB (M) 2*32kB (M) 6*64kB =
(M) 5*128kB (M) 6*256kB (UM) 5*512kB (UM) 4*1024kB (M) 10*2048kB (UMC) 73=
2*4096kB (MC) =3D 3028136kB
>> [    6.396324] Normal: 84*4kB (U) 94*8kB (UM) 260*16kB (UME) 149*32kB =
(UM) 99*64kB (UME) 39*128kB (UM) 12*256kB (U) 3*512kB (UME) 2*1024kB (UM)=
 0*2048kB 204*4096kB (M) =3D 863584kB
>> [    6.412054] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages=
_surp=3D0 hugepages_size=3D1048576kB
>> [    6.420770] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages=
_surp=3D0 hugepages_size=3D32768kB
>> [    6.429312] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages=
_surp=3D0 hugepages_size=3D2048kB
>> [    6.437767] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages=
_surp=3D0 hugepages_size=3D64kB
>> [    6.446047] 15147 total pagecache pages
>> [    6.449890] 0 pages in swap cache
>> [    6.453210] Swap cache stats: add 0, delete 0, find 0/0
>> [    6.458445] Free swap  =3D 0kB
>> [    6.461331] Total swap =3D 0kB
>> [    6.464217] 1048576 pages RAM
>> [    6.467190] 0 pages HighMem/MovableOnly
>> [    6.471032] 49288 pages reserved
>> [    6.474267] 4096 pages cma reserved
>>
>> Regards,
>>     Doug
>
> I will look into it. Thanks for reporting it.

Hi Doug,

Can you try the patch below? It takes out free pages under zone lock now
and modifies page stats properly. Thanks.


diff --git a/mm/internal.h b/mm/internal.h
index 64e61b032dac..c0f8fbe0445b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -374,8 +374,8 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr=
_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);

-void split_free_page(struct page *free_page,
-				int order, unsigned long split_pfn_offset);
+int split_free_page(struct page *free_page,
+			unsigned int order, unsigned long split_pfn_offset);

 #if defined CONFIG_COMPACTION || defined CONFIG_CMA

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc93a82e51e6..6f6e4649ac21 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1100,30 +1100,44 @@ static inline void __free_one_page(struct page *p=
age,
  * @order:		the order of the page
  * @split_pfn_offset:	split offset within the page
  *
+ * Return -ENOENT if the free page is changed, otherwise 0
+ *
  * It is used when the free page crosses two pageblocks with different m=
igratetypes
  * at split_pfn_offset within the page. The split free page will be put =
into
  * separate migratetype lists afterwards. Otherwise, the function achiev=
es
  * nothing.
  */
-void split_free_page(struct page *free_page,
-				int order, unsigned long split_pfn_offset)
+int split_free_page(struct page *free_page,
+			unsigned int order, unsigned long split_pfn_offset)
 {
 	struct zone *zone =3D page_zone(free_page);
 	unsigned long free_page_pfn =3D page_to_pfn(free_page);
 	unsigned long pfn;
 	unsigned long flags;
 	int free_page_order;
+	int mt;
+	int ret =3D 0;

 	if (split_pfn_offset =3D=3D 0)
-		return;
+		return ret;

 	spin_lock_irqsave(&zone->lock, flags);
+
+	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	mt =3D get_pageblock_migratetype(free_page);
+	if (likely(!is_migrate_isolate(mt)))
+		__mod_zone_freepage_state(zone, -(1UL << order), mt);
+
 	del_page_from_free_list(free_page, zone, order);
 	for (pfn =3D free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);

-		free_page_order =3D min_t(int,
+		free_page_order =3D min_t(unsigned int,
 					pfn ? __ffs(pfn) : order,
 					__fls(split_pfn_offset));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
@@ -1134,7 +1148,9 @@ void split_free_page(struct page *free_page,
 		if (split_pfn_offset =3D=3D 0)
 			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
 	}
+out:
 	spin_unlock_irqrestore(&zone->lock, flags);
+	return ret;
 }
 /*
  * A bad page could be due to a number of fields. Instead of multiple br=
anches,
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c643c8420809..f539ccf7fb44 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -300,7 +300,7 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flag=
s,
-			gfp_t gfp_flags, bool isolate_before)
+			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
 {
 	unsigned char saved_mt;
 	unsigned long start_pfn;
@@ -327,11 +327,16 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, int flags,
 				      zone->zone_start_pfn);

 	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));=

-	ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_m=
t, flags,
-			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);

-	if (ret)
-		return ret;
+	if (skip_isolation)
+		VM_BUG_ON(!is_migrate_isolate(saved_mt));
+	else {
+		ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_=
mt, flags,
+				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
+
+		if (ret)
+			return ret;
+	}

 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
@@ -367,8 +372,11 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 			int order =3D buddy_order(page);

 			if (pfn + (1UL << order) > boundary_pfn)
-				split_free_page(page, order, boundary_pfn - pfn);
-			pfn +=3D (1UL << order);
+				/* free page changed before split, check it again */
+				if (split_free_page(page, order, boundary_pfn - pfn))
+				    continue;
+
+			pfn +=3D 1UL << order;
 			continue;
 		}
 		/*
@@ -463,7 +471,8 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
 	return 0;
 failed:
 	/* restore the original migratetype */
-	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
+	if (!skip_isolation)
+		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
 	return -EBUSY;
 }

@@ -522,14 +531,18 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
 	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_page=
s);
 	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;
+	bool skip_isolation =3D false;

 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pagebloc=
k */
-	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false=
);
+	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false=
, skip_isolation);
 	if (ret)
 		return ret;

+	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
+		skip_isolation =3D true;
+
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */=

-	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
+	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true, s=
kip_isolation);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;


--
Best Regards,
Yan, Zi

--=_MailMate_615B2FAB-BB7E-40BA-8FAA-F734621CCD52_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKPuiAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUCxAP/2rHcFgh25Ds/sD0C3BmTQ3lt2FidNryPfoQ
dTSuahipxCloTxHrfsb0A8Vu1iVx8KaarTnLkKjJ8fTXVSPYoaGvKGsyrWkM8tDi
JHXjOIHZXvoQi4RKgSxBxeZEs1ILF2bPi6qKz6pibuNZPpdz+/aUc1KT6UsrQTjx
GDM4hbQ6RkEPqjY436Xt10zDMkTk0eXoTq9mBDEEVzxHHxVV8+RSTEOEe2X7X9VC
QDTfJg6ZqvVBNk5SbmmDARookgs+k8RpFJk1ZJC6E/qYF5X6vzsNoUOGHsWtEOmp
dCCn7GN4YpXeEo/wVgmH7+zP0R3orutXoTfIbWUTBceyxLq8BzygH7HtJ2G5H4gR
el05ctA+mOqsSUHKRDLUJhRmUEF7EEk8WoYq9lbnZW0HvjhJZ1S+EwKhJateCvrx
1mliMlkp8kaCN5IWiUL7PedIKKnzv/hViFsd56u6VLmCZ3wattNZiisGweTjIecN
YCt68WvwYixEy1zvzKFeK2U/BJmWK81ga2CVX3wVnSweLKcHuxqtIlXkooV6zbTC
g4TEXWMI5X6NNpfV8tRNz6ezrh6jvFnYdIr5TEZSN7HnJRuzPF8nQOzwmEM6RgMk
l0AZTv1byVSlTSoZ8jTelCMteeV9b7HUdz0nimeZOUQ1wRwM1l7l7aa4sAjG1iTr
+RK8oZKu
=VJ9w
-----END PGP SIGNATURE-----

--=_MailMate_615B2FAB-BB7E-40BA-8FAA-F734621CCD52_=--
