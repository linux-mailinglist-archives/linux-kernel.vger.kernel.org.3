Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342BF53427F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiEYRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiEYRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:53:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CFB63F1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf6aLAnXxqLJX9LkXL3fxbFqramyduOmpT9XIJwD4W/sCu5g3RvOXitymwKu0UqjvCIckTuBYxPngXnfFsFX20AEd+uK+u57CvOQi4tKL6G4G3eIu1WJsIFl9N7igAyC1RByZPrBdod45fyc6Z7+vLr4HAidy4a07ee8BTnq7CchnP6rplJQjvTQnHYnd/x6PHzu4Jl0V6lK388Ul6fV1BnnTBVnhTdt3O3a6hwsBaHaP88uIlwYqr5Q5q7hopGXCDYw5RCNHZuBo6Z00jwSd/LSrJNos8871mxv0DIJQmzLQVxwxY7Pe2zpqfaWFNZ8tvQBaGd4HjwTONEaMFtU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow8oY+VlgZUF6bT9p9ypbyebEp6FDG0yWh0T6lQFrE8=;
 b=VKl8Y6lXlZFjddyLN9nTLCC1gOd2VSmTvS5P1vfBRzF4jNOnpPLlbaDCphKUGEKJSDSu8HTo6zzinHaPKfot443rrbk+C55AanxQ26X6HfX+m0LeN6EmfetbkwkHpT6toZFz9fw2TeOBl4CzqMHmb+j9ZLBO+LBUaP7LvjJpV4P08WcK4UVh07j+NzoecTPd4NwLTV6kiUpEH19gECEsgmSDipS+msT9yzbKJ9HtyVhBJp5w7Y3Ucyf34Hb/kJ/6qEDo3wOTzWK950RyyCQcUWd/pGAq3gz5fCOFIAJhGPpf3+7s0U1/SGTWp/oCZ44F7UJlw2zuaTO3EkErwxlfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow8oY+VlgZUF6bT9p9ypbyebEp6FDG0yWh0T6lQFrE8=;
 b=BPZZJjr440gRfhvdnxhoVx2XEl5tMk4MgwBKOJetaJN/aDNFmHUIeJYqshQpw7jJvZHXtMsr+PwhDBV8HJiuZQkv9T2QdJkwxZvYm3kN4GSvZ5l409AAmDnqLODb2yYn9+nDQnwaw5h208ajbUgka2LB2xHSsCh1DWtzE0HXkzU8WsMWe3sZjZUAuWl28ZTg1d4etQG4zDJRrKWfqBY4lqLkO3x9VXzA50yXGJNZlmUsfYnafXqujy4/bJqM0R2XPytspx3+2Eg8OIyc/MXF/Q2PvZv7fDVB6SskVRM54bh9F6FmfLeLKc8SB/vP+r/WZLe4aq+0dg+at2Di33aaHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BYAPR12MB3381.namprd12.prod.outlook.com (2603:10b6:a03:df::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Wed, 25 May 2022 17:53:07 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 17:53:06 +0000
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
Date:   Wed, 25 May 2022 13:53:04 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <F80CEC0E-0EA8-4210-8730-57D4D0CF0B23@nvidia.com>
In-Reply-To: <180aaa57-28d8-30f0-e843-ea52e3a180a8@gmail.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-4-zi.yan@sent.com>
 <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
 <180aaa57-28d8-30f0-e843-ea52e3a180a8@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CCB04A1F-02E0-4B5A-AECB-32D468BD10C9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:208:120::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91252064-2723-4970-efa5-08da3e776c71
X-MS-TrafficTypeDiagnostic: BYAPR12MB3381:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3381AB37B6AFA871856CA9E2C2D69@BYAPR12MB3381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ckrrb3Ej7lkyhD9h5+ZgPDa+1RKSBbvdfp5tWmIk5fWoz8LW7P/r5QkKzlhwySsAp0lVQo5PFrfIPTrFlguvC5eDqBVp8uzh9t+EIzBsqNScGi2MPFR5idQwwzSJxznPxu6hI8NCdQy4jX+ijGfnWoKGEaZliSGwEued2plTZQPGTiJqehk6mNOQiQ4LiWWGS9Ud+PM/pFB5y4SePELPcLo9LYIiN7fcqpq9WUfWfsClcoeHAqVJOUPdWjQfR7i8fZWR95PjaRst8+NLP05yULlJIgey6hoCEDduQjooyvlSWWjsx1AA2XjYyTF9fbtIDh4GCtywNn7hgcIenhwLPCjyBxZo3LO5XVnjvYgYfvMaR3WvkRMW6WnVUyWhB0Qd4CC+Zjv9q8TMOv3y9DX8N8Au5A4YRdJudOG9ObDVdxnuP2UtBw1lOlzqr2pTXpyXKWAVkK1aeqjrqtisZHkZOWoseuqd21VhDHCKPmvl8fBDtqXnuhUygFxBRd2z9syIH7NRiu4e0PO4y7S3wm7A+NlMqwmK/GHJtcneMLxq5icJ3hEP5xcrIHdneCdgSvFmk2nYi+ezuHTamDARx9/T+2YNlCFFRlKEXRwBm/61xgETKLgxM0nZ/0ZBYlmJ/xv/Kl2mlZ+E2iQBTFJ6zkbXxgG0MJmAOy3PGZ5Qnj03q2rCHEdXDT8CYPdbsZicVLHmRbxAmSHvCAW8y6Cv+9WK5WbqhinB1UZgT5wP6vusVAKSOAs8ElrrXcs22Ye/gHHhGleNfTLggcYpXYril/orOuDELYzDih2xbhPVfLZaJKMOPeACFQXxXWJmLYKv2rB0SjznDTQeDJjcqXgZJahgh+iLgadW00LzO1pMPteWew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(53546011)(6486002)(36756003)(4326008)(66946007)(2616005)(83380400001)(6512007)(66556008)(6506007)(26005)(33656002)(508600001)(66476007)(186003)(8676002)(8936002)(235185007)(21480400003)(30864003)(2906002)(316002)(38100700002)(54906003)(6916009)(86362001)(5660300002)(7416002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?peOrTk80ExD8AFrtrr3xaumIQzj9rVbmmz/udSsYfGx8+u+HbnPGs0fuObVq?=
 =?us-ascii?Q?KE3tIFzLHBWM5h1uhZ1iPu+WbPv8sd+zSu9hT6A+TT8BgWgUIbBM01VTkZit?=
 =?us-ascii?Q?jpJ3ExVVfW8aJ/U1HuUT0pY2tG4e2VnV3nMaiCtGf2RWeELHa59U48TNl+sk?=
 =?us-ascii?Q?mPdL3508FPQJ5XBhTwAFU/kWgJz9fONJ3u6TFr/v+aHOj7BP++zCXh7ijANW?=
 =?us-ascii?Q?S7OppEaANLQf8KmTM4f0Tov4qEiZkDkKuLCirM70EewkzbGYsuNkDR5qEHrQ?=
 =?us-ascii?Q?hOsLgAdOVNRM+gWFxG2ct+AWjoKvut0sQA7VujTUgpOldbgnbZB/w1dlDEK2?=
 =?us-ascii?Q?hnS0R+BKrMm1QHPFUIful1TthgzA+TV+/nAwbds/yrAcnGD7o/27/koCgHVc?=
 =?us-ascii?Q?ETdEVgXvwmuvrEHUH5DXw5pLuh2ISarWa1h4+iNAip27WqPl2FWS5aIg90PK?=
 =?us-ascii?Q?MAxODKb656Rx6yBYQTunO8jvZYWtVKi29DKrow+QFZNdDvIlt3XuEqAEFpTf?=
 =?us-ascii?Q?x100zxrF6hwb8y40p3ibzGigZgrOUsyTDerhgq501LROzCG5dgned6PjKMHZ?=
 =?us-ascii?Q?Y7X5txVWFGu0fb9AVF8LcNpCERsJJ8AhbjyxmBq7LLvRHakAMIdE2k/AqCaS?=
 =?us-ascii?Q?j3K9TmiQ5khRNB0SW58gc5tu3ZffBT1LIa/lusQKQSaH/f49iDw99Jhn4wSs?=
 =?us-ascii?Q?EQEhgH0aA8aNRyRB0pp96wP/mLwlYFqs0tJR4rwOnrJj0i9qhVXwyKZ7qsZh?=
 =?us-ascii?Q?bK70cX28gP2/idAJtFCQCUBWNXs+hLqeLwd9XnbyXPdnyRl1G2bOTrnCjWVd?=
 =?us-ascii?Q?JDK1KIA1fTROTrw3Ludqg3DcHhxj1/pKNhZOaz0XGY0mAV510Blo/I9QcP+a?=
 =?us-ascii?Q?0PNBowa4LFq4NeWKRPfC1o17D5tJ3JYuMdFT50Omj72h5BQ1KNmyHorK2eZd?=
 =?us-ascii?Q?mfq/G06Nuy7+GBHV/DFhzEmZYPqpz8KQ6m2vMLaaB1r8DwtBPBpP7EOCXH5Y?=
 =?us-ascii?Q?cnX7sK0HfWMUSHuj7tG2QH6iveLctiB2y5p/DZpaNeOuO7nYkKCaC9h7Wvek?=
 =?us-ascii?Q?SpmxzS0NsN3s2ZtSVjM4MTjuH9Rmd3tpsNPgcaHHpqrBnYcyHoKGZkZ369Kf?=
 =?us-ascii?Q?F9zMOG7G0xCPFoe+ueiwQKC9letKnYwsQvypmWKFfK+dqXKWJj5o4l5FJrx3?=
 =?us-ascii?Q?yuALeBg1J3tLbIS+h+TL3tVb14yRP+xIX0g+1yysjn8WpKwVL2Nw+GsI4TsF?=
 =?us-ascii?Q?NgdfCo4n2QeVsaJq8yWPlnf6xwPz7f5DW9C/CkkQSc0dZINAMB5XhvfUzgz7?=
 =?us-ascii?Q?VOYWGKaiczO2kjVKNcqmUapUhxxiytz3eHoHuwcSxmkKx3qkaGHhVSZkAPUR?=
 =?us-ascii?Q?4WDZWZY3/4UhOtkN/HHYoXZUGJ0qyj1lFM39yYJ8BfGPpjH65RXYwsPYBWff?=
 =?us-ascii?Q?wJosYPnsWIqLemnhNsB9qiABg6RuRIfSZOqQseurAfwaB+QZ1Ox8qIHAV8KM?=
 =?us-ascii?Q?yyAbl4CRq7DsokgVLS6F6JfDN8NNr0hUP0hOCpo7UyfqBVghNbGANDUYwppn?=
 =?us-ascii?Q?pe34puA1ZbIja3Ia0nXi9tTh4GMNGz6baueTI6w59WZgxEiPzDfZciUqmyYm?=
 =?us-ascii?Q?TZdlYIP+aduUn1mGJAQ0Zv5TGdQaXmVfDO4aSUvcCJ7s08gJGw7CN6HURuc0?=
 =?us-ascii?Q?rVzze8kbm678ILvvAg8lelKVfrdJP7h8cW0B3lXsAslTKzV9ask2xJwxeWTM?=
 =?us-ascii?Q?WBgS35M6IQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91252064-2723-4970-efa5-08da3e776c71
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 17:53:06.9189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9LSu687FrSlRaH0mTCN6sTyI/yviNcp2Ews1rhYyFJV38SOtW7V+ieh0ZQhz4rq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3381
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CCB04A1F-02E0-4B5A-AECB-32D468BD10C9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 May 2022, at 13:41, Doug Berger wrote:

> I am seeing some free memory accounting problems with linux-next that I=
 have bisected to this commit (i.e. b2c9e2fbba32 ("mm: make alloc_contig_=
range work at pageblock granularity").
>
> On an arm64 SMP platform with 4GB total memory and the default 16MB def=
ault CMA pool, I am seeing the following after boot with a sysrq Show Mem=
ory (e.g. 'echo m > /proc/sysrq-trigger'):
>
> [   16.015906] sysrq: Show Memory
> [   16.019039] Mem-Info:
> [   16.021348] active_anon:14604 inactive_anon:919 isolated_anon:0
> [   16.021348]  active_file:0 inactive_file:0 isolated_file:0
> [   16.021348]  unevictable:0 dirty:0 writeback:0
> [   16.021348]  slab_reclaimable:3662 slab_unreclaimable:3333
> [   16.021348]  mapped:928 shmem:15146 pagetables:63 bounce:0
> [   16.021348]  kernel_misc_reclaimable:0
> [   16.021348]  free:976766 free_pcp:991 free_cma:7017
> [   16.056937] Node 0 active_anon:58416kB inactive_anon:3676kB active_f=
ile:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(fil=
e):0kB mapped:3712kB dirty:0kB writeback:0kB shmem:60584kB writeback_tmp:=
0kB kernel_stack:1200kB pagetables:252kB all_unreclaimable? no
> [   16.081526] DMA free:3041036kB boost:0kB min:6036kB low:9044kB high:=
12052kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_=
file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:31457=
28kB managed:3029992kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp:0k=
B free_cma:28068kB
> [   16.108650] lowmem_reserve[]: 0 0 944 944
> [   16.112746] Normal free:866028kB boost:0kB min:1936kB low:2900kB hig=
h:3864kB reserved_highatomic:0KB active_anon:58416kB inactive_anon:3676kB=
 active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB prese=
nt:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3328kB loca=
l_pcp:864kB free_cma:0kB
> [   16.140393] lowmem_reserve[]: 0 0 0 0
> [   16.144133] DMA: 7*4kB (UMC) 4*8kB (M) 3*16kB (M) 3*32kB (MC) 5*64kB=
 (M) 4*128kB (MC) 5*256kB (UMC) 7*512kB (UM) 5*1024kB (UM) 9*2048kB (UMC)=
 732*4096kB (MC) =3D 3027724kB
> [   16.159609] Normal: 149*4kB (UM) 95*8kB (UME) 26*16kB (UME) 8*32kB (=
ME) 2*64kB (UE) 1*128kB (M) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UM) 0*204=
8kB 210*4096kB (M) =3D 866028kB
> [   16.175165] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D1048576kB
> [   16.183937] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D32768kB
> [   16.192533] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D2048kB
> [   16.201040] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D64kB
> [   16.209374] 15146 total pagecache pages
> [   16.213246] 0 pages in swap cache
> [   16.216595] Swap cache stats: add 0, delete 0, find 0/0
> [   16.221867] Free swap  =3D 0kB
> [   16.224780] Total swap =3D 0kB
> [   16.227693] 1048576 pages RAM
> [   16.230694] 0 pages HighMem/MovableOnly
> [   16.234564] 49240 pages reserved
> [   16.237825] 4096 pages cma reserved
>
> Some anomolies in the above are:
> free_cma:7017 with only 4096 pages cma reserved
> DMA free:3041036kB with only managed:3029992kB
>
> I'm not sure what is going on here, but I am suspicious of split_free_p=
age() since del_page_from_free_list doesn't affect migrate_type accountin=
g, but __free_one_page() can.
> Also PageBuddy(page) is being checked without zone->lock in isolate_sin=
gle_pageblock().
>
> Please investigate this as well.


Can you try this patch https://lore.kernel.org/linux-mm/20220524194756.16=
98351-1-zi.yan@sent.com/
and see if it fixes the issue?

Thanks.

>
> Thanks!
>     Doug
>
> On 4/29/2022 6:54 AM, Zi Yan wrote:
>> On 25 Apr 2022, at 10:31, Zi Yan wrote:
>>
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> alloc_contig_range() worked at MAX_ORDER_NR_PAGES granularity to avoi=
d
>>> merging pageblocks with different migratetypes. It might unnecessaril=
y
>>> convert extra pageblocks at the beginning and at the end of the range=
=2E
>>> Change alloc_contig_range() to work at pageblock granularity.
>>>
>>> Special handling is needed for free pages and in-use pages across the=

>>> boundaries of the range specified by alloc_contig_range(). Because th=
ese
>>> partially isolated pages causes free page accounting issues. The free=

>>> pages will be split and freed into separate migratetype lists; the
>>> in-use pages will be migrated then the freed pages will be handled in=

>>> the aforementioned way.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>   include/linux/page-isolation.h |   4 +-
>>>   mm/internal.h                  |   6 ++
>>>   mm/memory_hotplug.c            |   3 +-
>>>   mm/page_alloc.c                |  54 ++++++++--
>>>   mm/page_isolation.c            | 184 ++++++++++++++++++++++++++++++=
++-
>>>   5 files changed, 233 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isol=
ation.h
>>> index e14eddf6741a..5456b7be38ae 100644
>>> --- a/include/linux/page-isolation.h
>>> +++ b/include/linux/page-isolation.h
>>> @@ -42,7 +42,7 @@ int move_freepages_block(struct zone *zone, struct =
page *page,
>>>    */
>>>   int
>>>   start_isolate_page_range(unsigned long start_pfn, unsigned long end=
_pfn,
>>> -			 unsigned migratetype, int flags);
>>> +			 int migratetype, int flags, gfp_t gfp_flags);
>>>
>>>   /*
>>>    * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
>>> @@ -50,7 +50,7 @@ start_isolate_page_range(unsigned long start_pfn, u=
nsigned long end_pfn,
>>>    */
>>>   void
>>>   undo_isolate_page_range(unsigned long start_pfn, unsigned long end_=
pfn,
>>> -			unsigned migratetype);
>>> +			int migratetype);
>>>
>>>   /*
>>>    * Test all pages in [start_pfn, end_pfn) are isolated or not.
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 919fa07e1031..0667abd57634 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -359,6 +359,9 @@ extern void *memmap_alloc(phys_addr_t size, phys_=
addr_t align,
>>>   			  phys_addr_t min_addr,
>>>   			  int nid, bool exact_nid);
>>>
>>> +void split_free_page(struct page *free_page,
>>> +				int order, unsigned long split_pfn_offset);
>>> +
>>>   #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>>>
>>>   /*
>>> @@ -422,6 +425,9 @@ isolate_freepages_range(struct compact_control *c=
c,
>>>   int
>>>   isolate_migratepages_range(struct compact_control *cc,
>>>   			   unsigned long low_pfn, unsigned long end_pfn);
>>> +
>>> +int __alloc_contig_migrate_range(struct compact_control *cc,
>>> +					unsigned long start, unsigned long end);
>>>   #endif
>>>   int find_suitable_fallback(struct free_area *area, unsigned int ord=
er,
>>>   			int migratetype, bool only_stealable, bool *can_steal);
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 4c6065e5d274..9f8ae4cb77ee 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1845,7 +1845,8 @@ int __ref offline_pages(unsigned long start_pfn=
, unsigned long nr_pages,
>>>   	/* set above range as isolated */
>>>   	ret =3D start_isolate_page_range(start_pfn, end_pfn,
>>>   				       MIGRATE_MOVABLE,
>>> -				       MEMORY_OFFLINE | REPORT_FAILURE);
>>> +				       MEMORY_OFFLINE | REPORT_FAILURE,
>>> +				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>>   	if (ret) {
>>>   		reason =3D "failure to isolate range";
>>>   		goto failed_removal_pcplists_disabled;
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index ce23ac8ad085..70ddd9a0bcf3 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1094,6 +1094,43 @@ static inline void __free_one_page(struct page=
 *page,
>>>   		page_reporting_notify_free(order);
>>>   }
>>>
>>> +/**
>>> + * split_free_page() -- split a free page at split_pfn_offset
>>> + * @free_page:		the original free page
>>> + * @order:		the order of the page
>>> + * @split_pfn_offset:	split offset within the page
>>> + *
>>> + * It is used when the free page crosses two pageblocks with differe=
nt migratetypes
>>> + * at split_pfn_offset within the page. The split free page will be =
put into
>>> + * separate migratetype lists afterwards. Otherwise, the function ac=
hieves
>>> + * nothing.
>>> + */
>>> +void split_free_page(struct page *free_page,
>>> +				int order, unsigned long split_pfn_offset)
>>> +{
>>> +	struct zone *zone =3D page_zone(free_page);
>>> +	unsigned long free_page_pfn =3D page_to_pfn(free_page);
>>> +	unsigned long pfn;
>>> +	unsigned long flags;
>>> +	int free_page_order;
>>> +
>>> +	spin_lock_irqsave(&zone->lock, flags);
>>> +	del_page_from_free_list(free_page, zone, order);
>>> +	for (pfn =3D free_page_pfn;
>>> +	     pfn < free_page_pfn + (1UL << order);) {
>>> +		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>>> +
>>> +		free_page_order =3D ffs(split_pfn_offset) - 1;
>>> +		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
>>> +				mt, FPI_NONE);
>>> +		pfn +=3D 1UL << free_page_order;
>>> +		split_pfn_offset -=3D (1UL << free_page_order);
>>> +		/* we have done the first part, now switch to second part */
>>> +		if (split_pfn_offset =3D=3D 0)
>>> +			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
>>> +	}
>>> +	spin_unlock_irqrestore(&zone->lock, flags);
>>> +}
>>>   /*
>>>    * A bad page could be due to a number of fields. Instead of multip=
le branches,
>>>    * try and check multiple fields with one check. The caller must do=
 a detailed
>>> @@ -8919,7 +8956,7 @@ static inline void alloc_contig_dump_pages(stru=
ct list_head *page_list)
>>>   #endif
>>>
>>>   /* [start, end) must belong to a single zone. */
>>> -static int __alloc_contig_migrate_range(struct compact_control *cc,
>>> +int __alloc_contig_migrate_range(struct compact_control *cc,
>>>   					unsigned long start, unsigned long end)
>>>   {
>>>   	/* This function is based on compact_zone() from compaction.c. */
>>> @@ -9002,7 +9039,7 @@ int alloc_contig_range(unsigned long start, uns=
igned long end,
>>>   		       unsigned migratetype, gfp_t gfp_mask)
>>>   {
>>>   	unsigned long outer_start, outer_end;
>>> -	unsigned int order;
>>> +	int order;
>>>   	int ret =3D 0;
>>>
>>>   	struct compact_control cc =3D {
>>> @@ -9021,14 +9058,11 @@ int alloc_contig_range(unsigned long start, u=
nsigned long end,
>>>   	 * What we do here is we mark all pageblocks in range as
>>>   	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
>>>   	 * have different sizes, and due to the way page allocator
>>> -	 * work, we align the range to biggest of the two pages so
>>> -	 * that page allocator won't try to merge buddies from
>>> -	 * different pageblocks and change MIGRATE_ISOLATE to some
>>> -	 * other migration type.
>>> +	 * work, start_isolate_page_range() has special handlings for this.=

>>>   	 *
>>>   	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
>>>   	 * migrate the pages from an unaligned range (ie. pages that
>>> -	 * we are interested in).  This will put all the pages in
>>> +	 * we are interested in). This will put all the pages in
>>>   	 * range back to page allocator as MIGRATE_ISOLATE.
>>>   	 *
>>>   	 * When this is done, we take the pages in range from page
>>> @@ -9042,9 +9076,9 @@ int alloc_contig_range(unsigned long start, uns=
igned long end,
>>>   	 */
>>>
>>>   	ret =3D start_isolate_page_range(pfn_max_align_down(start),
>>> -				       pfn_max_align_up(end), migratetype, 0);
>>> +				pfn_max_align_up(end), migratetype, 0, gfp_mask);
>>>   	if (ret)
>>> -		return ret;
>>> +		goto done;
>>>
>>>   	drain_all_pages(cc.zone);
>>>
>>> @@ -9064,7 +9098,7 @@ int alloc_contig_range(unsigned long start, uns=
igned long end,
>>>   	ret =3D 0;
>>>
>>>   	/*
>>> -	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
>>> +	 * Pages from [start, end) are within a pageblock_nr_pages
>>>   	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
>>>   	 * more, all pages in [start, end) are free in page allocator.
>>>   	 * What we are going to do is to allocate all pages from
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index c2f7a8bb634d..94b3467e5ba2 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -203,7 +203,7 @@ static int set_migratetype_isolate(struct page *p=
age, int migratetype, int isol_
>>>   	return -EBUSY;
>>>   }
>>>
>>> -static void unset_migratetype_isolate(struct page *page, unsigned mi=
gratetype)
>>> +static void unset_migratetype_isolate(struct page *page, int migrate=
type)
>>>   {
>>>   	struct zone *zone;
>>>   	unsigned long flags, nr_pages;
>>> @@ -279,6 +279,157 @@ __first_valid_page(unsigned long pfn, unsigned =
long nr_pages)
>>>   	return NULL;
>>>   }
>>>
>>> +/**
>>> + * isolate_single_pageblock() -- tries to isolate a pageblock that m=
ight be
>>> + * within a free or in-use page.
>>> + * @boundary_pfn:		pageblock-aligned pfn that a page might cross
>>> + * @gfp_flags:			GFP flags used for migrating pages
>>> + * @isolate_before:	isolate the pageblock before the boundary_pfn
>>> + *
>>> + * Free and in-use pages can be as big as MAX_ORDER-1 and contain mo=
re than one
>>> + * pageblock. When not all pageblocks within a page are isolated at =
the same
>>> + * time, free page accounting can go wrong. For example, in the case=
 of
>>> + * MAX_ORDER-1 =3D pageblock_order + 1, a MAX_ORDER-1 page has two p=
agelbocks.
>>> + * [         MAX_ORDER-1         ]
>>> + * [  pageblock0  |  pageblock1  ]
>>> + * When either pageblock is isolated, if it is a free page, the page=
 is not
>>> + * split into separate migratetype lists, which is supposed to; if i=
t is an
>>> + * in-use page and freed later, __free_one_page() does not split the=
 free page
>>> + * either. The function handles this by splitting the free page or m=
igrating
>>> + * the in-use page then splitting the free page.
>>> + */
>>> +static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_=
t gfp_flags,
>>> +			bool isolate_before)
>>> +{
>>> +	unsigned char saved_mt;
>>> +	unsigned long start_pfn;
>>> +	unsigned long isolate_pageblock;
>>> +	unsigned long pfn;
>>> +	struct zone *zone;
>>> +
>>> +	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
>>> +
>>> +	if (isolate_before)
>>> +		isolate_pageblock =3D boundary_pfn - pageblock_nr_pages;
>>> +	else
>>> +		isolate_pageblock =3D boundary_pfn;
>>> +
>>> +	/*
>>> +	 * scan at the beginning of MAX_ORDER_NR_PAGES aligned range to avo=
id
>>> +	 * only isolating a subset of pageblocks from a bigger than pageblo=
ck
>>> +	 * free or in-use page. Also make sure all to-be-isolated pageblock=
s
>>> +	 * are within the same zone.
>>> +	 */
>>> +	zone  =3D page_zone(pfn_to_page(isolate_pageblock));
>>> +	start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES=
),
>>> +				      zone->zone_start_pfn);
>>> +
>>> +	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pagebloc=
k));
>>> +	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_I=
SOLATE);
>>> +
>>> +	/*
>>> +	 * Bail out early when the to-be-isolated pageblock does not form
>>> +	 * a free or in-use page across boundary_pfn:
>>> +	 *
>>> +	 * 1. isolate before boundary_pfn: the page after is not online
>>> +	 * 2. isolate after boundary_pfn: the page before is not online
>>> +	 *
>>> +	 * This also ensures correctness. Without it, when isolate after
>>> +	 * boundary_pfn and [start_pfn, boundary_pfn) are not online,
>>> +	 * __first_valid_page() will return unexpected NULL in the for loop=

>>> +	 * below.
>>> +	 */
>>> +	if (isolate_before) {
>>> +		if (!pfn_to_online_page(boundary_pfn))
>>> +			return 0;
>>> +	} else {
>>> +		if (!pfn_to_online_page(boundary_pfn - 1))
>>> +			return 0;
>>> +	}
>>> +
>>> +	for (pfn =3D start_pfn; pfn < boundary_pfn;) {
>>> +		struct page *page =3D __first_valid_page(pfn, boundary_pfn - pfn);=

>>> +
>>> +		VM_BUG_ON(!page);
>>> +		pfn =3D page_to_pfn(page);
>>> +		/*
>>> +		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
>>> +		 * free pages in [start_pfn, boundary_pfn), its head page will
>>> +		 * always be in the range.
>>> +		 */
>>> +		if (PageBuddy(page)) {
>>> +			int order =3D buddy_order(page);
>>> +
>>> +			if (pfn + (1UL << order) > boundary_pfn)
>>> +				split_free_page(page, order, boundary_pfn - pfn);
>>> +			pfn +=3D (1UL << order);
>>> +			continue;
>>> +		}
>>> +		/*
>>> +		 * migrate compound pages then let the free page handling code
>>> +		 * above do the rest. If migration is not enabled, just fail.
>>> +		 */
>>> +		if (PageHuge(page) || PageTransCompound(page)) {
>>> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
>>> +			unsigned long nr_pages =3D compound_nr(page);
>>> +			int order =3D compound_order(page);
>>> +			struct page *head =3D compound_head(page);
>>> +			unsigned long head_pfn =3D page_to_pfn(head);
>>> +			int ret;
>>> +			struct compact_control cc =3D {
>>> +				.nr_migratepages =3D 0,
>>> +				.order =3D -1,
>>> +				.zone =3D page_zone(pfn_to_page(head_pfn)),
>>> +				.mode =3D MIGRATE_SYNC,
>>> +				.ignore_skip_hint =3D true,
>>> +				.no_set_skip_hint =3D true,
>>> +				.gfp_mask =3D gfp_flags,
>>> +				.alloc_contig =3D true,
>>> +			};
>>> +			INIT_LIST_HEAD(&cc.migratepages);
>>> +
>>> +			if (head_pfn + nr_pages < boundary_pfn) {
>>> +				pfn +=3D nr_pages;
>>> +				continue;
>>> +			}
>>> +
>>> +			ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
>>> +						head_pfn + nr_pages);
>>> +
>>> +			if (ret)
>>> +				goto failed;
>>> +			/*
>>> +			 * reset pfn, let the free page handling code above
>>> +			 * split the free page to the right migratetype list.
>>> +			 *
>>> +			 * head_pfn is not used here as a hugetlb page order
>>> +			 * can be bigger than MAX_ORDER-1, but after it is
>>> +			 * freed, the free page order is not. Use pfn within
>>> +			 * the range to find the head of the free page and
>>> +			 * reset order to 0 if a hugetlb page with
>>> +			 * >MAX_ORDER-1 order is encountered.
>>> +			 */
>>> +			if (order > MAX_ORDER-1)
>>> +				order =3D 0;
>>> +			while (!PageBuddy(pfn_to_page(pfn))) {
>>> +				order++;
>>> +				pfn &=3D ~0UL << order;
>>> +			}
>>> +			continue;
>>> +#else
>>> +			goto failed;
>>> +#endif
>>> +		}
>>> +
>>> +		pfn++;
>>> +	}
>>> +	return 0;
>>> +failed:
>>> +	/* restore the original migratetype */
>>> +	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt)=
;
>>> +	return -EBUSY;
>>> +}
>>> +
>>>   /**
>>>    * start_isolate_page_range() - make page-allocation-type of range =
of pages to
>>>    * be MIGRATE_ISOLATE.
>>> @@ -293,6 +444,8 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>>>    *					 and PageOffline() pages.
>>>    *			REPORT_FAILURE - report details about the failure to
>>>    *			isolate the range
>>> + * @gfp_flags:		GFP flags used for migrating pages that sit across t=
he
>>> + *			range boundaries.
>>>    *
>>>    * Making page-allocation-type to be MIGRATE_ISOLATE means free pag=
es in
>>>    * the range will never be allocated. Any free pages and pages free=
d in the
>>> @@ -301,6 +454,10 @@ __first_valid_page(unsigned long pfn, unsigned l=
ong nr_pages)
>>>    * pages in the range finally, the caller have to free all pages in=
 the range.
>>>    * test_page_isolated() can be used for test it.
>>>    *
>>> + * The function first tries to isolate the pageblocks at the beginni=
ng and end
>>> + * of the range, since there might be pages across the range boundar=
ies.
>>> + * Afterwards, it isolates the rest of the range.
>>> + *
>>>    * There is no high level synchronization mechanism that prevents t=
wo threads
>>>    * from trying to isolate overlapping ranges. If this happens, one =
thread
>>>    * will notice pageblocks in the overlapping range already set to i=
solate.
>>> @@ -321,21 +478,38 @@ __first_valid_page(unsigned long pfn, unsigned =
long nr_pages)
>>>    * Return: 0 on success and -EBUSY if any part of range cannot be i=
solated.
>>>    */
>>>   int start_isolate_page_range(unsigned long start_pfn, unsigned long=
 end_pfn,
>>> -			     unsigned migratetype, int flags)
>>> +			     int migratetype, int flags, gfp_t gfp_flags)
>>>   {
>>>   	unsigned long pfn;
>>>   	struct page *page;
>>> +	int ret;
>>>
>>>   	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>>>   	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>>>
>>> -	for (pfn =3D start_pfn;
>>> -	     pfn < end_pfn;
>>> +	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */=

>>> +	ret =3D isolate_single_pageblock(start_pfn, gfp_flags, false);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
>>> +	ret =3D isolate_single_pageblock(end_pfn, gfp_flags, true);
>>> +	if (ret) {
>>> +		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* skip isolated pageblocks at the beginning and end */
>>> +	for (pfn =3D start_pfn + pageblock_nr_pages;
>>> +	     pfn < end_pfn - pageblock_nr_pages;
>>>   	     pfn +=3D pageblock_nr_pages) {
>>>   		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>>>   		if (page && set_migratetype_isolate(page, migratetype, flags,
>>>   					start_pfn, end_pfn)) {
>>>   			undo_isolate_page_range(start_pfn, pfn, migratetype);
>>> +			unset_migratetype_isolate(
>>> +				pfn_to_page(end_pfn - pageblock_nr_pages),
>>> +				migratetype);
>>>   			return -EBUSY;
>>>   		}
>>>   	}
>>> @@ -346,7 +520,7 @@ int start_isolate_page_range(unsigned long start_=
pfn, unsigned long end_pfn,
>>>    * Make isolated pages available again.
>>>    */
>>>   void undo_isolate_page_range(unsigned long start_pfn, unsigned long=
 end_pfn,
>>> -			    unsigned migratetype)
>>> +			    int migratetype)
>>>   {
>>>   	unsigned long pfn;
>>>   	struct page *page;
>>> -- =

>>> 2.35.1
>>
>> Qian hit a bug caused by this series https://lore.kernel.org/linux-mm/=
20220426201855.GA1014@qian/
>> and the fix is:
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 75e454f5cf45..b3f074d1682e 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -367,58 +367,67 @@ static int isolate_single_pageblock(unsigned lon=
g boundary_pfn, gfp_t gfp_flags,
>>   		}
>>   		/*
>>   		 * migrate compound pages then let the free page handling code
>> -		 * above do the rest. If migration is not enabled, just fail.
>> +		 * above do the rest. If migration is not possible, just fail.
>>   		 */
>> -		if (PageHuge(page) || PageTransCompound(page)) {
>> -#if defined CONFIG_COMPACTION || defined CONFIG_CMA
>> +		if (PageCompound(page)) {
>>   			unsigned long nr_pages =3D compound_nr(page);
>> -			int order =3D compound_order(page);
>>   			struct page *head =3D compound_head(page);
>>   			unsigned long head_pfn =3D page_to_pfn(head);
>> -			int ret;
>> -			struct compact_control cc =3D {
>> -				.nr_migratepages =3D 0,
>> -				.order =3D -1,
>> -				.zone =3D page_zone(pfn_to_page(head_pfn)),
>> -				.mode =3D MIGRATE_SYNC,
>> -				.ignore_skip_hint =3D true,
>> -				.no_set_skip_hint =3D true,
>> -				.gfp_mask =3D gfp_flags,
>> -				.alloc_contig =3D true,
>> -			};
>> -			INIT_LIST_HEAD(&cc.migratepages);
>>
>>   			if (head_pfn + nr_pages < boundary_pfn) {
>> -				pfn +=3D nr_pages;
>> +				pfn =3D head_pfn + nr_pages;
>>   				continue;
>>   			}
>> -
>> -			ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
>> -						head_pfn + nr_pages);
>> -
>> -			if (ret)
>> -				goto failed;
>> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
>>   			/*
>> -			 * reset pfn, let the free page handling code above
>> -			 * split the free page to the right migratetype list.
>> -			 *
>> -			 * head_pfn is not used here as a hugetlb page order
>> -			 * can be bigger than MAX_ORDER-1, but after it is
>> -			 * freed, the free page order is not. Use pfn within
>> -			 * the range to find the head of the free page and
>> -			 * reset order to 0 if a hugetlb page with
>> -			 * >MAX_ORDER-1 order is encountered.
>> +			 * hugetlb, lru compound (THP), and movable compound pages
>> +			 * can be migrated. Otherwise, fail the isolation.
>>   			 */
>> -			if (order > MAX_ORDER-1)
>> +			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
>> +				int order;
>> +				unsigned long outer_pfn;
>> +				int ret;
>> +				struct compact_control cc =3D {
>> +					.nr_migratepages =3D 0,
>> +					.order =3D -1,
>> +					.zone =3D page_zone(pfn_to_page(head_pfn)),
>> +					.mode =3D MIGRATE_SYNC,
>> +					.ignore_skip_hint =3D true,
>> +					.no_set_skip_hint =3D true,
>> +					.gfp_mask =3D gfp_flags,
>> +					.alloc_contig =3D true,
>> +				};
>> +				INIT_LIST_HEAD(&cc.migratepages);
>> +
>> +				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
>> +							head_pfn + nr_pages);
>> +
>> +				if (ret)
>> +					goto failed;
>> +				/*
>> +				 * reset pfn to the head of the free page, so
>> +				 * that the free page handling code above can split
>> +				 * the free page to the right migratetype list.
>> +				 *
>> +				 * head_pfn is not used here as a hugetlb page order
>> +				 * can be bigger than MAX_ORDER-1, but after it is
>> +				 * freed, the free page order is not. Use pfn within
>> +				 * the range to find the head of the free page.
>> +				 */
>>   				order =3D 0;
>> -			while (!PageBuddy(pfn_to_page(pfn))) {
>> -				order++;
>> -				pfn &=3D ~0UL << order;
>> -			}
>> -			continue;
>> -#else
>> -			goto failed;
>> +				outer_pfn =3D pfn;
>> +				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>> +					if (++order >=3D MAX_ORDER) {
>> +						outer_pfn =3D pfn;
>> +						break;
>> +					}
>> +					outer_pfn &=3D ~0UL << order;
>> +				}
>> +				pfn =3D outer_pfn;
>> +				continue;
>> +			} else
>>   #endif
>> +				goto failed;
>>   		}
>>
>>   		pfn++;

--
Best Regards,
Yan, Zi

--=_MailMate_CCB04A1F-02E0-4B5A-AECB-32D468BD10C9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKObQAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUpy8QAKFSGv34mZ97bsc2WIxHVZJ7ZqkTEQxRYzrC
DD5owxk3qdYjkkZ+KlwzKVZbea4xWtVrWAtILg7Q+3+5mw95eNLBy/YXdMUPFq6w
j7doo5us5uEnMpUEBpeZ+oSSB4R+aTBvSM1Sl8og7G44Nda0ftc8GGfeu7gynb0b
mdqJ4wyALwZmDiL6goJd4YeFhrCtNE0KQOhmcta6CxwMDkLPrTSDthvxp/7HcZI+
IcRVZR9FGUKUiE5FrEgNcI9x+OT1uHLK5MQ3okDdMUfdVp+Plndixe2xeX9UlJzd
fg3G230DXqC42uEr5rqd0dAiqr3ZqFQJdoH2T6pHAe7miEY/InXlGnxUN00uOCJ5
JF9WUL3qwCEkEquG3CjLmZG+2CDOZ48ndHIQ5Nm+DOQU9KQ2QmvaUC9mUywSvPOV
Mdia5w8bxJiRoUJi+n832fM4hcwSDkYP2ipSTZAWQD3NXx/oCVhGbV3IrVbdNLKH
PsqAL6IFE5UI141LX0sq0re5Hgjlz3/Wmh8kcaf4bZwGF26x9mq7e61gRjs26ifT
UNFW5fjzLx4qq23s+0uw0Ufsmh8xEnrgzRB3QwTlqHiLxaTAqiU+SaGae5U0GfpF
xm8w2Hr01YkOslDXP5DlYoUmDZ7505BmHOrN4OZ9v7Bie1y5fIZzYw8KK1Gi8TLz
6k2O1RRk
=Unag
-----END PGP SIGNATURE-----

--=_MailMate_CCB04A1F-02E0-4B5A-AECB-32D468BD10C9_=--
