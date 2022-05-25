Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8775E5345A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbiEYVL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiEYVLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:11:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB4736141
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn7bO0HC2xZxnpokDhU34CDAtaCMBK7jjQ8XbLgUJ++aBfedo6lSwjViVcxJ0tkyHz5dxd+8COgA+gs/jwBgecLgGDlUptb42wqhwnL+2N+7lQIgg5rQQ/0cHgwH1xM7UYbokMol0lHQiPlIWIwFGf+rCJdK2trUHv2JmdQbPsrdGin7Ti/rpVOkgAw1Fwid0pQDSY+B3+E1Tansko9yN4NVbOZLGJN9zG6wIrrMeDITrZavsqB8U6Y80QT3N2ojQeF/VbagapPOfr2bPnoYcEDDetnsiIYCXjH84OJb3/HaRBcG/rIeaKcDx1CnyvHg8ONXhYob16353jlzXYZCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlECKKhPBIy7ikdl63IzY7sl9uXQ/sJfEzXafBcr5/o=;
 b=L8xUV/X82qmdF7y6CsGY/i47mMp/k1Bf41UUds0OO2oUEQeXbF4Mtzb/pq3NcutGiIKquajWHFUfibb5z1smc1ZkCJWrtIxRoKPUu9wvLuaHKK8PnV9eJKFSa2lGkIDgI3d18qr8kKr4THhr4OSbw1I2A99+IQJEiKHB3KID1y/cqKuBIZvebttsvHbh+reMqczthaZ5vni/OTyRPsTSeZwTViBJei290vIFkC9FNujMn3gvAKMU4eAT6FUC+6SNStVdIImqY6noHs8mFwzol5No1fdU3N3Ox14f/T4FpYrxeGDJG8xj/ZwMsbia25JnRSinQL+ASPMcsen23hxhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlECKKhPBIy7ikdl63IzY7sl9uXQ/sJfEzXafBcr5/o=;
 b=JYii5mlP7f77mvn8TMbaTGWj0kl9HMRQKKrG0zlXgfrSb/y3Su6PEb6nXRFiD6GP5Js3YS1UhC9r0JjIvKuNWbJ1mj3lPhrypvRPHeTCamEWXZ2iEJe1K4x6be8iv0NDNqpwPapeeESLt862sUy9Fxrxd0smg2SyBRr3b0Qwmge6bzTMG99FUN4ZlSjwTodfMox/kY6qy7c8Lc52Fwru77zwEDTw9aoyrjNAo12LzSWHV1m1cHMSFluCHVrstUa08uETk97NatRvdjtzW/oF/+FKAuryfEufrxTTy19Y13aDb852e5Y3nokoL5D0VGCh4t25TQk5XonTR361iIUXUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 21:11:15 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 21:11:15 +0000
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
Date:   Wed, 25 May 2022 17:11:12 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <ABD35D2B-58CB-4050-8B45-17F34B360573@nvidia.com>
In-Reply-To: <fcac3340-31b5-8536-fd4e-ecb8a9aee2ae@gmail.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-4-zi.yan@sent.com>
 <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
 <180aaa57-28d8-30f0-e843-ea52e3a180a8@gmail.com>
 <F80CEC0E-0EA8-4210-8730-57D4D0CF0B23@nvidia.com>
 <fcac3340-31b5-8536-fd4e-ecb8a9aee2ae@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BFB74625-6981-4BD3-92F7-8F4B3436DBEA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5fa0f6-887e-464f-905b-08da3e931a96
X-MS-TrafficTypeDiagnostic: IA1PR12MB6234:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6234E3AABA5D2093A92F9D42C2D69@IA1PR12MB6234.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2TENMkchv1QRrf6/OTetTH0TASK+A4Wo21MozD34R2tPH2kw1oLV5vOxIFbey+q7yBwcwzTP0tFBD8kgVnz8u44q1bw0WwvsHb80SD6WmdpkQge5TAD7Qp11JEQIDU5DURcMGXyh/lKZ46ewX6tC+sUsg6nizNp35cPLqAqVzUv8Vs1lDghEag5RSonnlSazefUuuIRZiJq43xBVUjANIBL94O/afN0HpRqCx/WsNTq5cHHDW5tEQhVfKLkcUyEnG0KIPhf6KzFhZimXf4363J2IUsM1jyxVXDf6S0mO58XkF7PWDbhLTwTBWxnRkOX3cLZevaCWkCveI5QW7lL8GMVmeC5lEtf+AGH64aJxQn+AB2sWw2BzlE0KGb3LLlbuihD4xSWIa5AqTjBizBSKVGQ5u0Ir0/raPk5R8IbjOZFzF+/LzxNRsscPQdUN1+ddsSTso9Vyd0T0J8ZSH1ad+gXAc8epgpikNlnrykIny7iMtQJ2HRGtSC/rh/rZnyg2860hGyNNiPMJ9vuUrjA0Paa7JFTVTwkG/OmeCusH9Xu662UVYzuw4IcVH98xA6YGa37qzs15S+7H2BgYRgaJa9+2e9G9loKNrl+QtdkSbPo6ud43HNeaHC3QGkjySpTzcTaurOc9jXLrdmC4fpFvJy7dMR7Zj0F6BOBMYiI9WT5qt0YMibfGYuq9Lev4pdfDX3IVMYF2HNamLpdGs8AFsktt3yOPJB73Hgnl1Ilj90Aow9hH4r8d+5/JlhTFvulXcD2DQG7Vk7bcFmTjeSoc8Sirz/60ihTG3z8US9de68xdpsMwMqQh4A9l0EZjteC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(33656002)(53546011)(21480400003)(26005)(6512007)(6506007)(508600001)(2906002)(36756003)(6916009)(2616005)(83380400001)(966005)(186003)(6666004)(38100700002)(5660300002)(8676002)(66946007)(86362001)(4326008)(66476007)(66556008)(7416002)(8936002)(235185007)(316002)(54906003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s7AiAPOrj2JMqDR/6RTCshWer4baRizJ4iecxHFSlRzgggTARa9gxK07Tz9S?=
 =?us-ascii?Q?84ybXqoMQlE+YfG9erraw785dDClerqDUhnxPhVzvqdjtZhS6LZb9XfcEngr?=
 =?us-ascii?Q?Yrr2kDvuC9WZPKyKhgV2QwNLMsFmlEew7M35k38+NZxsViR7aAGUm+QaUHjX?=
 =?us-ascii?Q?G0jb+H2MQIakVrpipPlBtN9rn3psiCRW13mxuz7oQpKaB6V/LCxuwD3p20Wt?=
 =?us-ascii?Q?XPyNk4KVe7WYerQXfGa808nyprO2PcaKD3WaxZ3iZF6q6YTooE1rp5aQbEf2?=
 =?us-ascii?Q?gYTG+WcCzX5OF4tju8LOFSwRzu+IGj5IGBZUbWwYlrRVNBuohPi4RXtkUKhi?=
 =?us-ascii?Q?uOiqs2UJ7rmwthV4x1ZmqowDVQxMpOPqlMu7UEMDzH5+OsLewAnAAI03Gd53?=
 =?us-ascii?Q?PKM46XQRYw2psM6d1C7bONhFHJK+EjCRryIRLK1ozBz+hGGKeuhSFxdIdYCv?=
 =?us-ascii?Q?aXU17GPNjT4gYTM4g04Sfy5nT7t/8vDbMud/+DZJNub7XP7gomK+AIatlZ+l?=
 =?us-ascii?Q?Ve4tyt4/mJaU9emSWMrS23Pbyld3wMltRBVAuNMChnzdS5J0aNxZxDWCMus6?=
 =?us-ascii?Q?lKEqDSz+S8DVHg/FTrlZ6UqxfeK0/w3ra2ZUSpwopzWINCw8wNqEyi02j5Oi?=
 =?us-ascii?Q?4JI1v9uTYkv2ltsbCjIpXusKG4nrCaw47oK/OtL1wP9Ps2TH7x+/jWeKKE8j?=
 =?us-ascii?Q?lBqnaj2TMBD7tD0D2wBJ0z1HkxhknZErdzfO3H4pChuZgB5tCOjW6+7c2V0n?=
 =?us-ascii?Q?84WddEwuvPRUm2SGymuIxCz7MbQuT0+GPQ473sKCFIQS965XDCvkOL67j8G7?=
 =?us-ascii?Q?F3Y1Y+m/42veLHqeGo16Ns+NXMeXhlem2EgoWWTAMo82GQ6GEg0vdNrgdM4L?=
 =?us-ascii?Q?o2htXCnaHKy0M8akjQbD19pyqEmWtkOhfp0HcyWdj2Ab/uIa3gcY6EAQVSXs?=
 =?us-ascii?Q?z4bd07OdPfl+0EvhLAOKbPDr7raYknnfgJax3hJSRJAQa1Lj7gSBpAoCE6Sj?=
 =?us-ascii?Q?BEhEE23bW/ZtAfNquH2erbBx1lGmJevAanwloqywMjOTbXX8wSPkR0h+YxFy?=
 =?us-ascii?Q?FAbwQ0/C1Otl0s9ksU1Qm8luffSEAi4A/BHDpZdffFoSyWfnWGK+69PSUPGS?=
 =?us-ascii?Q?ibknh7181mJiSR6dzX8de+VKZd3Ip8avcZ5EyDJL2Akm1CSzO7iveanNW9a2?=
 =?us-ascii?Q?TGhTiQaB3Rs9YAxE50DoxPiwF7tRUSTk9RnyJYcEDr+2guTbsOPXpr/R50Be?=
 =?us-ascii?Q?Y0S3jYjB/LBb5ohC2qnCUuNQvdUgjrPt8UMNszSl1QbvJkWHoWzlVMwu2E7L?=
 =?us-ascii?Q?oN7/Gzf2ks5XDAAxjZxa/9HichbAmgOm28ee3puaOGSoeJDHk4KDJsRuTj5k?=
 =?us-ascii?Q?7Tdn2k4Vc/uj8+Hgm/G2cyY7yhj+OXy441dOXj4Wywcyu7uQc3RSt5YrA534?=
 =?us-ascii?Q?LH3RjjHre2Lv3VktU9hVR0gzOaSoehBhu0Ehe+IEELNVcuo5rBkWxTVtQc2B?=
 =?us-ascii?Q?Mh3+2uhE6ulgkLZ7lHHDj86+iOpSj+VSgyR8qtn9JIpx+/NHAPmSS0c5s+l+?=
 =?us-ascii?Q?Bql1hWjVtMtXnYgTzMyRXvOpbPDXIDabkWGWqGKcy2LT3AbkZU/lJGZG9POv?=
 =?us-ascii?Q?ezhMlYz+t3Mj+Pt4lo4HZACMr9LJZ7KLiQCnxM9fjZN2rp8tcohd2J6ZBrCD?=
 =?us-ascii?Q?oUYZclyFZqzBqUyRmc6oPwrvcwNXVzfAmhrGuGgcTyxDtEW9HakfuRJ0Ggq1?=
 =?us-ascii?Q?oF9TIYxY9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5fa0f6-887e-464f-905b-08da3e931a96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 21:11:15.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FGiBt1eenxHgDW/DtGCWjfKshqapG5yaHkk6C35je8KRAfrr6wNt2KmjIFS3Kky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_BFB74625-6981-4BD3-92F7-8F4B3436DBEA_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 May 2022, at 17:03, Doug Berger wrote:

> On 5/25/2022 10:53 AM, Zi Yan wrote:
>> On 25 May 2022, at 13:41, Doug Berger wrote:
>>
>>> I am seeing some free memory accounting problems with linux-next that=
 I have bisected to this commit (i.e. b2c9e2fbba32 ("mm: make alloc_conti=
g_range work at pageblock granularity").
>>>
>>> On an arm64 SMP platform with 4GB total memory and the default 16MB d=
efault CMA pool, I am seeing the following after boot with a sysrq Show M=
emory (e.g. 'echo m > /proc/sysrq-trigger'):
>>>
>>> [   16.015906] sysrq: Show Memory
>>> [   16.019039] Mem-Info:
>>> [   16.021348] active_anon:14604 inactive_anon:919 isolated_anon:0
>>> [   16.021348]  active_file:0 inactive_file:0 isolated_file:0
>>> [   16.021348]  unevictable:0 dirty:0 writeback:0
>>> [   16.021348]  slab_reclaimable:3662 slab_unreclaimable:3333
>>> [   16.021348]  mapped:928 shmem:15146 pagetables:63 bounce:0
>>> [   16.021348]  kernel_misc_reclaimable:0
>>> [   16.021348]  free:976766 free_pcp:991 free_cma:7017
>>> [   16.056937] Node 0 active_anon:58416kB inactive_anon:3676kB active=
_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(f=
ile):0kB mapped:3712kB dirty:0kB writeback:0kB shmem:60584kB writeback_tm=
p:0kB kernel_stack:1200kB pagetables:252kB all_unreclaimable? no
>>> [   16.081526] DMA free:3041036kB boost:0kB min:6036kB low:9044kB hig=
h:12052kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB activ=
e_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:314=
5728kB managed:3029992kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp:=
0kB free_cma:28068kB
>>> [   16.108650] lowmem_reserve[]: 0 0 944 944
>>> [   16.112746] Normal free:866028kB boost:0kB min:1936kB low:2900kB h=
igh:3864kB reserved_highatomic:0KB active_anon:58416kB inactive_anon:3676=
kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB pre=
sent:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3328kB lo=
cal_pcp:864kB free_cma:0kB
>>> [   16.140393] lowmem_reserve[]: 0 0 0 0
>>> [   16.144133] DMA: 7*4kB (UMC) 4*8kB (M) 3*16kB (M) 3*32kB (MC) 5*64=
kB (M) 4*128kB (MC) 5*256kB (UMC) 7*512kB (UM) 5*1024kB (UM) 9*2048kB (UM=
C) 732*4096kB (MC) =3D 3027724kB
>>> [   16.159609] Normal: 149*4kB (UM) 95*8kB (UME) 26*16kB (UME) 8*32kB=
 (ME) 2*64kB (UE) 1*128kB (M) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UM) 0*2=
048kB 210*4096kB (M) =3D 866028kB
>>> [   16.175165] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepage=
s_surp=3D0 hugepages_size=3D1048576kB
>>> [   16.183937] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepage=
s_surp=3D0 hugepages_size=3D32768kB
>>> [   16.192533] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepage=
s_surp=3D0 hugepages_size=3D2048kB
>>> [   16.201040] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepage=
s_surp=3D0 hugepages_size=3D64kB
>>> [   16.209374] 15146 total pagecache pages
>>> [   16.213246] 0 pages in swap cache
>>> [   16.216595] Swap cache stats: add 0, delete 0, find 0/0
>>> [   16.221867] Free swap  =3D 0kB
>>> [   16.224780] Total swap =3D 0kB
>>> [   16.227693] 1048576 pages RAM
>>> [   16.230694] 0 pages HighMem/MovableOnly
>>> [   16.234564] 49240 pages reserved
>>> [   16.237825] 4096 pages cma reserved
>>>
>>> Some anomolies in the above are:
>>> free_cma:7017 with only 4096 pages cma reserved
>>> DMA free:3041036kB with only managed:3029992kB
>>>
>>> I'm not sure what is going on here, but I am suspicious of split_free=
_page() since del_page_from_free_list doesn't affect migrate_type account=
ing, but __free_one_page() can.
>>> Also PageBuddy(page) is being checked without zone->lock in isolate_s=
ingle_pageblock().
>>>
>>> Please investigate this as well.
>>
>>
>> Can you try this patch https://lore.kernel.org/linux-mm/20220524194756=
=2E1698351-1-zi.yan@sent.com/
>> and see if it fixes the issue?
>>
>> Thanks.
>>
> The last hunk didn't apply directly to this commit, but I was able to a=
pply the patch to linux-next/master with no improvement to the free memor=
y accounting (actually anecdotaly worse):
>
> [    6.236828] sysrq: Show Memory
> [    6.239973] Mem-Info:
> [    6.242290] active_anon:14594 inactive_anon:924 isolated_anon:0
> [    6.242290]  active_file:0 inactive_file:0 isolated_file:0
> [    6.242290]  unevictable:0 dirty:0 writeback:0
> [    6.242290]  slab_reclaimable:3671 slab_unreclaimable:3575
> [    6.242290]  mapped:935 shmem:15147 pagetables:63 bounce:0
> [    6.242290]  kernel_misc_reclaimable:0
> [    6.242290]  free:1059009 free_pcp:1067 free_cma:90112
> [    6.278048] Node 0 active_anon:58376kB inactive_anon:3844kB active_f=
ile:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(fil=
e):0kB mapped:3740kB dirty:0kB writeback:0kB shmem:60588kB writeback_tmp:=
0kB kernel_stack:1216kB pagetables:252kB all_unreclaimable? no
> [    6.279422] arm-scmi brcm_scmi@0: timed out in resp(caller: scmi_per=
f_level_set+0xe0/0x110)
> [    6.302501] DMA free:3372200kB boost:0kB min:6032kB low:9040kB high:=
12048kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_=
file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:31457=
28kB managed:3029800kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp:0k=
B free_cma:360448kB
> [    6.302515] lowmem_reserve[]: 0 0 944
> [    6.310894] cpufreq: __target_index: Failed to change cpu frequency:=
 -110
> [    6.337920]  944
> [    6.337925] Normal free:863584kB boost:0kB min:1940kB low:2904kB hig=
h:3868kB reserved_highatomic:0KB active_anon:58376kB inactive_anon:3896kB=
 active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB prese=
nt:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3492kB loca=
l_pcp:828kB free_cma:0kB
> [    6.377782] lowmem_reserve[]: 0 0 0 0
> [    6.381461] DMA: 4*4kB (UM) 5*8kB (M) 3*16kB (M) 2*32kB (M) 6*64kB (=
M) 5*128kB (M) 6*256kB (UM) 5*512kB (UM) 4*1024kB (M) 10*2048kB (UMC) 732=
*4096kB (MC) =3D 3028136kB
> [    6.396324] Normal: 84*4kB (U) 94*8kB (UM) 260*16kB (UME) 149*32kB (=
UM) 99*64kB (UME) 39*128kB (UM) 12*256kB (U) 3*512kB (UME) 2*1024kB (UM) =
0*2048kB 204*4096kB (M) =3D 863584kB
> [    6.412054] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D1048576kB
> [    6.420770] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D32768kB
> [    6.429312] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D2048kB
> [    6.437767] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_=
surp=3D0 hugepages_size=3D64kB
> [    6.446047] 15147 total pagecache pages
> [    6.449890] 0 pages in swap cache
> [    6.453210] Swap cache stats: add 0, delete 0, find 0/0
> [    6.458445] Free swap  =3D 0kB
> [    6.461331] Total swap =3D 0kB
> [    6.464217] 1048576 pages RAM
> [    6.467190] 0 pages HighMem/MovableOnly
> [    6.471032] 49288 pages reserved
> [    6.474267] 4096 pages cma reserved
>
> Regards,
>     Doug

I will look into it. Thanks for reporting it.

--
Best Regards,
Yan, Zi

--=_MailMate_BFB74625-6981-4BD3-92F7-8F4B3436DBEA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKOm3APHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUZ78P/RlGoiYOmoji0K2uO1oiN4eD5hgsxTXZXcjB
IyqZvfCbKF+SAoZ+cItNxyZQeqZBIXHga7Yy3YABCoqhgBMxc22/+LNamGETn47V
zHXf72IJW9zLk723JOj3QsxLVt9HTZmyCRP/N0Puuu5Nh+kl45kSNfgPB8Re3CnR
cBDVmbXPJ3zo/70wroBgiOJh5maf0XxQXLMY4uFxTHdpzJGy6/dR1YbSfxLsg1xr
tJa9viSsFqS3HCFQG4mGpTr+RKktqP20H8cbZvB4j00pa8vvKHw5OhgodofzRuu8
dW7Q02pqVoq8CQR0wX1/lrIBEpIOn/xhDjHWdvOra7aZoaPgh0di4vkrC00qshR3
8yWaBxXjg/C1Wk8Xk/W7Osh46sJEQsTZbdWmYfWAc1dBLbgx6pPu/Qs0GHQ3pWrz
0h3xztBUr+oQkvK5072cytnyY9Ov+AcM1Yo9LaAl0dENixDT9cZcfUbJH54eVzOs
Gm/CPKhUfrjoHPULA2iu6yWtrQsvnhlWFalGs4Fju5va1hoElUWFKH/AGaYFDuYt
9OHLBkmVGJA2MlwGB84rg7Riff9fuhLbp9Pj4yMRzVs1bi0szvsEWLy9jOjZyiyP
lv8sRD2Fhkm8izNaszctF5QlRETUb+d4QuKTCTvJGbx4gGmir+D5tWG/MU19HuKH
hpJXvkDG
=VPH/
-----END PGP SIGNATURE-----

--=_MailMate_BFB74625-6981-4BD3-92F7-8F4B3436DBEA_=--
