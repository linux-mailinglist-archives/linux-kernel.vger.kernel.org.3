Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9F5A2EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbiHZSiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345161AbiHZSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:37:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B822E7A530
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:35:05 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27QIP7TD024845
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-id : content-type
 : mime-version; s=facebook;
 bh=oiuzCVt+PyuZVqKM1sK/+c//uGBcy8iRc3h564nd1OM=;
 b=aToYDOfNWejB9JvP5o7b88jwtq3m153KdWZ5w3nYPynU2oFYaKF1vQ+K38IJNWd1Xm/i
 UIK1N0dsmqtmW38gdLlU3QJ5J7VWDGXTkE0vmiS11pu0vR8RV0cafzTTu3rkJEYjxnm1
 c8Zxb85GEG/mMbnDEkLEGu8SYASz2OmSkfI= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j6s714181-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:34:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPqm3XSBoLpOYtMPsst9L89kQN6tXHmn/opHmMecPjoL+R8bl8PC6xU2jQXNyyWNrn2hOzsJn7ipfKvYKr5euYc8Wv46IQmCFbRQSXw6WsD9NOjy7414AmT/OTsKdL4Ym+Kb17CsRZCKJTiHQa1oXyvF+x7j+ZUU31zwAhSby3tyWt3IYOnHmtkLZhh1znrfmy5pKhux9vcM4MzX9Mt+ZXVQFb5PmN6fjItVw5cmdjk4YsA7brvMBjnHyP3OnuJjNhc75sLdzLU2Tvsd+btxkV3WD3BSXE27Voaf9FVq8aywz7JEhAdmR6qRDP1z1sJdpmXwuefkrz0Eq2k3lnryKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiuzCVt+PyuZVqKM1sK/+c//uGBcy8iRc3h564nd1OM=;
 b=KMZOHMBgFL5LqSbqZduFNgpGLwwetpyG5TH4u7as3jfCbBS/RkPHfTos4uD8UMjmBeak8SUBTwjrMWCBukynkqQ8UA315yGa2sYEsNNz88UgZS6eNGKeVFLUqP/yIPTj+LkUVbHc5dySqkKSxxzYKdw0lUpTCwjcfHIk7VzTU1qjmXmnoWw2YWMx1JxteiW6kYbjiU6DWZz1wF/vDPyuhIOUlBQSRVUXXC6JohYc9QHUjl0BHQHjtIuIDGSL4c8v9ziAloszpPOejmrp9oCPXhuMIrpY/1PEOICY+QXhVyhunJ5jpMaI+p5QwzLQ7PFkDboVgxP1Yzfz8TejqbBPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by MN2PR15MB3022.namprd15.prod.outlook.com (2603:10b6:208:e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:34:40 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.019; Fri, 26 Aug
 2022 18:34:40 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "riel@surriel.com" <riel@surriel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Thread-Topic: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Thread-Index: AQHYuMfP12/URiDwn0CzT9+YyQULcK3A+PIAgACKfoA=
Date:   Fri, 26 Aug 2022 18:34:40 +0000
Message-ID: <9AF37F8E-27FB-4DF4-B745-36CB87E39D91@fb.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
 <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
 <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
In-Reply-To: <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1748fb14-c34d-474e-c3d5-08da8791a30c
x-ms-traffictypediagnostic: MN2PR15MB3022:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOmlYM9dnRFKTHE7Dfy3pba5MAGJEyNqHgRafTtfrDLSwlCrHTbqeyR2K0vxTSvtPvnvFeoqq2MtKw5YWnfYa+TTgbvLYHD6A9q0z2URS07AIJ4s5WC0gxw3/I1Dni7ZNpvzRQ8iwaTVeQ0mUMm1QmCSrc3/oS5iJZt2waSAd2cTCrw9Az/bnrONWWn7GC4TN791uo9eykLSLwHsDMgh6rppnL7XEfCmPf+LgY0TuHB74aqC424AoqCtzbrR+57dFG1CikVjPZz9TLsC0yHsCtM8coMBvSVT8M1obzIWVtlYGX/+GGEoYzPXox1KqXA4sN4pKJFA+jXT9hRP8446ievDtqH06NpQj+8JqZ5xVtAJDJwKiYN+bjX+9Jb1mckCF3mk4NTngI9utkSljaBzb7XN4o+7pDrfII2XC3dJB/9Xy7JDqvgPdlon+1BY8le+N3VWvqICydi0SNj8uo+T0UV9bY1HNOe3z3a2cdGl4f5RzOeURi3VvSpBuir9t3GYOojQSAcmp2xG5B4qRTvGrXd4KKg2WBcTtU54+RUtBzPnaSsALd2INc05WmHsnsbyZNEoVrpHc13+uFMifNT4qQgb5LGOJDncN/FHg/dgyYTMGXwgzRTazpKi30chfHvu9nzeUIfmzVMCmXiVAsw5dlVG9eHZ22BOIdHHC23Y9/bGh7ICSq76Vnm20GWWYZ7bwvuvTzSAYWcHFvnc/Y5DQ4kNPnYH9TWRwKmAwJCfgN6mduifJwuVaiu0f2gN00I4/k/VyODqI0Vp3CZYlNaT0QXVE57zPiP6s3ydFd3X9SLka0lu7ZwlZwDntAzmZw10sUL9i0AZi/m4VY+a6HoYc/y+8+GJKEkdtkvqtq3mayFDIE83M7HiHIA2Ifa22D/qFEsgaJxOxlhCJhu6gwl3eA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(122000001)(38070700005)(66556008)(6506007)(64756008)(8676002)(66476007)(4326008)(76116006)(66446008)(66946007)(6512007)(6486002)(38100700002)(53546011)(41300700001)(478600001)(71200400001)(316002)(966005)(54906003)(6916009)(91956017)(2616005)(83380400001)(186003)(5660300002)(86362001)(8936002)(2906002)(33656002)(36756003)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZmdL9hIJR2I33D8d6PDn+rHM9/btVulBksdtCSsgnBL/mnKRzxwgJ07qovH?=
 =?us-ascii?Q?UsrBQLRQWtzV6sZ0bN6hjbBCxio7HM4G5PF/gD6yVdQcAO+h6SBYuSdKAGz4?=
 =?us-ascii?Q?U3ZASH7+0mv42cVrxg5nmpRf3bf+BDUspSLaa5glnq9gQHT/oTAgjODXKEoU?=
 =?us-ascii?Q?mnhM0yZhdlnIiMmGALr9q/ZJtnTKPkQVxB84ci3tlaxo5/pzOCBqfJgJiqiY?=
 =?us-ascii?Q?gEaP4yb95NGP1deUmZ20dv1GheFx9qg2gptqjydwQlRauJaI1hKx2NSP/tP6?=
 =?us-ascii?Q?jbW2Fk1HZEuD0RUfPh7dmsCl5GOPBo+WCTV4QTSHZghdATv8mY2nOUaQv7MC?=
 =?us-ascii?Q?bY5+QW2B56uVnLETPTi1vWXaFycX/Wfms0b96xUYZG6lzK9bU8P9FeVa5zHO?=
 =?us-ascii?Q?RNrViFhkb/oq9H18SL/ad4GSWGXSukOfK6a7g6OqFmZrphxGcvnFku6s1rnq?=
 =?us-ascii?Q?XJP6YN+D7RGPgUzeUpEh6nPRaZh5yq9r1morfdkFFHjHl+GKNh8twHXZ8u1q?=
 =?us-ascii?Q?sdRFJSbyZft84wkINxxAwqGBAbpHtQuCGIXbhjzmpg3hBJXePks50VgElZwY?=
 =?us-ascii?Q?a9uwjk/+Lel5aua7juY23cCNXlHOVO4mLAuMyDHqUzu+WXVi0PEFzsqvO7qJ?=
 =?us-ascii?Q?IhPBFhSybXWcsh4TdqNLtjpmAO+AW6QsQ5Ldyx7lTiYzvQhZC2MyTit2jVvQ?=
 =?us-ascii?Q?wzP1t393/T2VPJId/U8+kB3r2ciqgVT95AOvVIZCHiTk9jUm7wx84jXbPsEd?=
 =?us-ascii?Q?DesO21eP64FT9UMbg4jj80MZc4bzYcawgx+f8/1yxWSqm7jGV9/lSrpSbE4g?=
 =?us-ascii?Q?3gU81PhDQqZocLOnaq5s3KpOEzGtuh9+brVHivxD4yfFoAVnxWwI1RPvNsr0?=
 =?us-ascii?Q?ezsgArPMWN1D3vaIESx1fTkBXTDxM02gW2wZ1FsDeI3l2IiPs8heB0MsIyNR?=
 =?us-ascii?Q?raeYPYxmc4fjVHs6QkvSWvIrH5RroGTUphc51XdmuGPje5e5OJh38PzcBafW?=
 =?us-ascii?Q?UlwYdVylJxrNKEaOgN7eawgpWDEmZ4Hy4QADnj4F6cz/zzhHfklRlZhww7cX?=
 =?us-ascii?Q?mTt33aXXp0OobdSYLgS5cd/d4PS94r+CL9caGYYHVudny2ZPmAfI8oynUgf1?=
 =?us-ascii?Q?Mqj7JjPIHcIJ9mhaRccqGMdRs5YzIQeGy953uWd5HIO+4cLQRU4m9HTRsstG?=
 =?us-ascii?Q?KR5VXGNn7VSJzYOKPicweoxdBSZaVzucBS0Vc6In6TTwcgsy5i0e+i+iHH/2?=
 =?us-ascii?Q?Q/iB0spWoInee4/nhToxT2iSpjj97ua8rEjvuvTMkrwirNPxFHdePyYoBv4x?=
 =?us-ascii?Q?IfkuvyJlgEqm903BhmhLzqxTd/clrtqbR7TJ9xeiwkm2SMSjY0kXI6sz7dxy?=
 =?us-ascii?Q?yLe461E147haJwbJu1aLcwDp05DQTpqnyT6qkZ6GLF0O6cJnYCdKnH+bGT7o?=
 =?us-ascii?Q?kFY2o8i2H/qRPHrFyktCr+HSEv3HW1qmwhK+qU4OwX46TlJvHSAw25VIIpq9?=
 =?us-ascii?Q?EIrAQztZuX8T7m70qWTrnEIOFOTQmXzchXHCejzaHlXQcGeHOIY24KZIHIDi?=
 =?us-ascii?Q?emRo5XgKTEt7s2kXtpUU9AFjYnJ2bd5UvpAoA9U6yorbELf82dv0FHxI8SU+?=
 =?us-ascii?Q?MgGCJZfjEtN6E53kfd2wXBU=3D?=
Content-ID: <0B27765C8F0E954DA3745CE57EC83BDD@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748fb14-c34d-474e-c3d5-08da8791a30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 18:34:40.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LedvFSQIzinxi8+ecre/EfgoLNb2O1VzNyZawJB1t7FhxPhWOtyKoSbZxy2IImRY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3022
X-Proofpoint-GUID: qIO0X5wgF0jPf104_nleH9LFJwMGJgWk
X-Proofpoint-ORIG-GUID: qIO0X5wgF0jPf104_nleH9LFJwMGJgWk
Content-Type: text/plain; charset="us-ascii"
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2022, at 3:18 AM, David Hildenbrand <david@redhat.com> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> On 25.08.22 23:30, alexlzhu@fb.com wrote:
>> From: Alexander Zhu <alexlzhu@fb.com>
>> 
>> Currently, when /sys/kernel/mm/transparent_hugepage/enabled=always is set
>> there are a large number of transparent hugepages that are almost entirely
>> zero filled.  This is mentioned in a number of previous patchsets
>> including:
>> https://lore.kernel.org/all/20210731063938.1391602-1-yuzhao@google.com/
>> https://lore.kernel.org/all/
>> 1635422215-99394-1-git-send-email-ningzhang@linux.alibaba.com/
>> 
>> Currently, split_huge_page() does not have a way to identify zero filled
>> pages within the THP. Thus these zero pages get remapped and continue to
>> create memory waste. In this patch, we identify and free tail pages that
>> are zero filled in split_huge_page(). In this way, we avoid mapping these
>> pages back into page table entries and can free up unused memory within
>> THPs. This is based off the previously mentioned patchset by Yu Zhao.
>> However, we chose to free zero tail pages whenever they are encountered
>> instead of only on reclaim or migration. We also add a self test to verify
>> the RssAnon value to make sure zero pages are not remapped.
>> 
> 
> Isn't this to some degree splitting the THP (PMDs->PTEs + dissolve
> compound page) and then letting KSM replace the zero-filled page by the
> shared zeropage?
> 
> -- 
> Thanks,
> 
> David / dhildenb

AFAICT KSM may or may not replace the zero filled page with the shared zero page depending on whether the VMA is mergeable. Whether
or not the VMA is mergeable comes from madvise. Madvise only applies to certain memory regions. Here we have THP always enabled rather than on madvise, and the end goal is to deprecate madvise entirely.

These THPs would previously not have been split at all, as we could not identify which THPs were underutilized, and would thus
have just been memory waste when THP was always enabled. 

In split_huge_page() we chose the most straightforward approach to free (zap) the zero page immediately to get rid of the memory waste. It does not seem to me that KSM is necessary here.

Thanks,
Alex

