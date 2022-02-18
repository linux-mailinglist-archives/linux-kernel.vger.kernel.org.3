Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E14BAF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiBRBra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:47:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiBRBr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:47:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297BB253A;
        Thu, 17 Feb 2022 17:47:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HMO6CD014590;
        Fri, 18 Feb 2022 01:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6OAS7qQM2NqlhGLLGk9OyhYTpiiticv41wal5m1AElo=;
 b=K0j4rF226u79lpdyvpv5DN3XJU9Raq/Rl5Nu4a7FCtYiR8Gw3tqbLDVJrS2TjTmS61CL
 QP6xInTL/wxO5GtHHozqi3uZKcagmGuaplc5XcM0e9caQnG7dP0QVdcyiMLBvtCdXWuv
 BRFmpzNiHmgQoYps/K11IzUjK6wftWjMHbjxc2xYtsAi4XXMx0m2lOtAD2JDHB99VcPJ
 GTtQ01Mz1s5NZDBsBi4mpSR9U7A0Gq53vyj2bbHPKN/A5YEHnhzK1yOVTi9QF0JbDks3
 l3uBvB6HK6nj5ddXJNMD83KWAlnMszLBSRISpYciER9ICr/WVsIQUKsvgcUTqxofZAkh AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nb3qey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 01:46:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21I1kaAJ039405;
        Fri, 18 Feb 2022 01:46:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3e8n4wrh9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 01:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0GJxc+1hGjmjgvItg63FoFaeWUjPtNQ02MBta6EJjoygNdSMQG+IaqBi/hVBHDYbm0yWAFEyFUyDSbloS88YTQwzDBxdUeAryrMFcL2NYF2RElXFTrFUIOljlUXK4ifUdHnph02+EPxmeZsAkbweF82LREXomU4LmhOhV3ZWmVRbXRN386GiOwdSNw9miJqTC/dcWC8mQG9wiPH5ZTT0p2sZ2nLcHTVYzGVwZltip735R+u104k6tNy12a4+FfQIVwSaz5ebcm57QfZnUyl24/isdL+eaQce9vKisAhiJNMbBLv0i+88SlziXo4nlPKGJonvVT9MBPt2eei8d3+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OAS7qQM2NqlhGLLGk9OyhYTpiiticv41wal5m1AElo=;
 b=E56r0geknZav9zJEqT+5KOaxgDKmNx/Q+RbNY/+6MMMfgr1Cmwi9WiVkj9ATVweiNzDz4LX+mwm+klVZdDS7Xvm9stRMPjKGsE60l71tsskJRAocHFutf6NFphr2qfjnwo0rT2e5qa9KlxhEzheVmINmBAo+JkaSslwLf34brlizJyvJvGB8MZaGtyaJo4On7o5L2NZCr5PE93NnlXs1WFe+7QGpln1k8gZsPYdosrPhjQdhiu9zw5hEFVuXkyfp9r+xO1DW9E0DiEYjjM9SFpEWPVV2q9bxjxTh1Bhx3k3rKo4TrKT0jYagG9XS8ZXoS9ipDBiTtz4h5trUMr6F3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OAS7qQM2NqlhGLLGk9OyhYTpiiticv41wal5m1AElo=;
 b=XyBnKhIN5+pPxig2Ttlw6AzxSTPhQVZgjyvbYvdkgdR8VOVulSraa335jZH/9VuLXz8mJwGoS+JSCeTa8K155Ej0yF0LBT7cVDl+2diBnjVOSu6P26p6BWvAIr4NiIfXjreXZAiGT7Pvc27Vdubv2CuCxot4BnOVHnH+IwhR6FQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 01:46:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 01:46:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Will Deacon <will@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the maple tree
Thread-Topic: linux-next: build failure after merge of the maple tree
Thread-Index: AQHYI9cKUe+AXkzF0kC7IAJItfKxY6yYIFCAgABqwwA=
Date:   Fri, 18 Feb 2022 01:46:50 +0000
Message-ID: <20220218014642.lop2ohx4ov6fekyl@revolver>
References: <20220217191857.6d9917c2@canb.auug.org.au>
 <20220217192434.GA11800@willie-the-truck>
In-Reply-To: <20220217192434.GA11800@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dd52dfb-7ad1-4cf1-ad91-08d9f2808885
x-ms-traffictypediagnostic: SJ0PR10MB4446:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB4446B32A32D5FB92CA9F63ECFD379@SJ0PR10MB4446.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6clsIK3Uv4/5pu6gP78REdfJoHSnEDAGi4pinKE+uo9zRo/jMG/jER++nNF105aGLpvuKBWdGLGX64qB3C/t0YVCwm4FE6TDqROno94EExv4TQnDMsm62LRmgN3RJhIDgskTIUUHgfImk842ravFSzYG2UhHXlPjWeTVL9zedEAR7ub9MvkmMzCiN1a/HzN0RWsjzz9mdhIKXIruy7xGXxy94nEBaM7h2WhLR3oXISBBmdDwDropspc37epNfgXZ8RfIxLx+q7P6V7gX1qhniH2nNkFer4C9N7VHjpxxT4GA8r9jYtrxOvHPHxpsNc8hYNcPKa9feQgPYWB5OHySdZXs3mGBD6KiyHfcZzA+DCA/2JCirmpHNYxYmmQ58aJyQH/6IJYKabsmKSWM5ogeXO8254XjTUQHqtRIp9H/CiujNHAo8qVZXGu/0nXUZHYz4q5RxoO5vBo09YB0bNIFXjgkmJ1FLpxMxrG4/DnbKd9oFnEL+KhEE6tlKlGIaqbAGps8E/q6WYO64+UIBPZvOF988a0ZfROWWkAx+GBkXMNe1+7YPT9xS8P8/sOUqFT6vPoM+mPO3xA6JR3pbZUEC+kTirkDxB7vTZeQX2xqKxCPgcYqcqRVqWWGaROziXt5N7DpE5da++bMHR84SzD5fLat3xmQG0NtvXkSeARMYWifSoVTlXKad1Be5waQqeQuZpGLqUIQx0yUJT81ySnqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(26005)(186003)(8936002)(2906002)(5660300002)(64756008)(122000001)(86362001)(316002)(38100700002)(54906003)(6916009)(6486002)(6506007)(33716001)(44832011)(66556008)(4326008)(71200400001)(8676002)(1076003)(66446008)(66476007)(6512007)(38070700005)(66946007)(508600001)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?myv6/6l406zC45j/pprdTHkpw0GXsknmsVwWIBP22UDJha8WUtBOBWZYNkZx?=
 =?us-ascii?Q?9KxHWwNpRvtoGl00AhPo2YlWSAmQx3MnrNr28vUe4FUleZpDn9va9c3ee6KN?=
 =?us-ascii?Q?ZO9Nhso+BYh/S1i5unJXVk+hkHO4l31hXaw6ZlcI6Y7cGWESll9YbLltcy4s?=
 =?us-ascii?Q?wZnFdX/pglC2lvilhO5I53xcIM5fZsSp6bMw2SscoDKJoGWFe5HDgbduZjDw?=
 =?us-ascii?Q?UxZ7m0vnz7ychvd/+wEpVrXNFV//t56PtXSzWH4EweiAa9IESm+LotRPPlBH?=
 =?us-ascii?Q?x8+U9cDDF5d6Nm9EIAifrnCUYyEqmfPBp0+OfBEulRnxcsdkQDn0hAaKSaMO?=
 =?us-ascii?Q?OIScWjkZ+Nv8qBOUZh13rsI7HSzytYd0XbxBZZ6d60B+CS///uSQt6hkz+Qm?=
 =?us-ascii?Q?usBNmNJSCby0gSXEc264I4OPPgpkrSyEiRhRzKvp1/L9EAyP+lOQD+AEFvS9?=
 =?us-ascii?Q?TeID6+lOQPlYgo7jfM4cK7/7bpN2X4EZiaF1qa+tMlD5chcJfio8UeI4M9sl?=
 =?us-ascii?Q?fG1kjLZMWTJ0knuJ/mwarGpUUBRBSC9Z+ywEVl6H1UNvG9gLTGDFWSxzAfRe?=
 =?us-ascii?Q?3Ps+DMeaQGsmX4+LBBCFNeA5k0Ysj+b1NCnwE6KrnD2YWT26F2EMs2qMF0aI?=
 =?us-ascii?Q?N6aa7d+wKwyIWJKMeNCxbxKDNAIvnyj3x7VP3IKp7rMmPG3NAvEVlf0GJCs3?=
 =?us-ascii?Q?LZLmQ3W1g3qDqOgRAGLvWFCzTzeVth/B/e8tDhWlA+4g6OGs+Bf1mM3d68yU?=
 =?us-ascii?Q?NK2vQiFND4jH5VVgfByinl+D0rdH5i46d9OAvXZ3eQy04+4Abx18Hnpy1XJ0?=
 =?us-ascii?Q?bMs3ycW5p5bEWxZKvPaaRqgTCNnGhOERGM7U1JYvuCsr1fhaeS19C5EbiNym?=
 =?us-ascii?Q?U1GTGpwUhUPn7KTamgM+h57ehPww6Ryajg4N0W//04DFyGuKCsvd+lgpGSBX?=
 =?us-ascii?Q?Ee/ju6sxVNYnXkv1Hi32iwHGlKFq7L1CufXSFtgwW6fyajqnaUlATHFcPv07?=
 =?us-ascii?Q?cEsjKOChVr9i/5ZPIqnaIN6VYXFvQCWqK2FFJVN57oACGTFlNnXjHhfV5h8S?=
 =?us-ascii?Q?ONctNT5+NzuJo+2olwenv0wpriFtgwo+mJPNVg4xQXpyK7vJO16MMnHZuSSE?=
 =?us-ascii?Q?8X+Alr8jEQhQz0B7dCn3Hm8K6engS4aBEX0BPBb4Y/DaGQGSgHuGWox1fpXC?=
 =?us-ascii?Q?sXikdZ/MGlFrHHirWg8RImiManFFpyrTwXMFozLeqx8dTtrTwOblVX5h9cEH?=
 =?us-ascii?Q?1xI3hWLxO1YT2SicSNWTYfmIdnYK42hnyuQ//kSEf3/yCNj6uiz9dXSkMGda?=
 =?us-ascii?Q?IuywjTVsNpll7jKWq7OvVMWRmxVQ6GaycwkIkdvnjNYXIraD2+eNgz+C73do?=
 =?us-ascii?Q?jkxeosd4/kwyE2eBhwwXZhVW9dmPR4gytgCa0iVdnGW7FJepQwZL0uxsGk2O?=
 =?us-ascii?Q?ZMsEmkthEwKNrvf0eHKGun6T6QA/IUb0gfOKFmmVSFCYSIFmGmpqe5jPkfnX?=
 =?us-ascii?Q?/6xhY71s5nWn4VNJsNx47Z3HSFliso2hn0+7Hw+bT7j4nqmUCGgsp4hrsKkl?=
 =?us-ascii?Q?3lAsw5W1p7ziJMdSS9jligISqIo6ktoYqsS2lX2Bvu7I14OxCqpjNnk5JmxG?=
 =?us-ascii?Q?Z7dTe3mtrhlAgFht7thkris=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D662C716DB235240A43FA200C01BB2B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd52dfb-7ad1-4cf1-ad91-08d9f2808885
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 01:46:50.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haOxNaFLo6fgHyTeubPF7HQnaBTIqmx8TbbE39nQk3blzKvjc/NBSfTCGPHlnqXxfuozrMtmdftIpmxgEfqW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=956 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180009
X-Proofpoint-GUID: _vlreoiwXLDu6ig_RIq1rticu8AbgmGv
X-Proofpoint-ORIG-GUID: _vlreoiwXLDu6ig_RIq1rticu8AbgmGv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Will Deacon <will@kernel.org> [220217 14:24]:
> On Thu, Feb 17, 2022 at 07:18:57PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the maple tree, today's linux-next build (arm64 defconfig=
)
> > failed like this:
> >=20
> > arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_phdrs':
> > arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no mem=
ber named 'mmap'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                   ^~
> > arch/arm64/kernel/elfcore.c:69:9: note: in expansion of macro 'for_each=
_mte_vma'
> >    69 |         for_each_mte_vma(current, vma)
> >       |         ^~~~~~~~~~~~~~~~
> > arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has n=
o member named 'vm_next'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                                         ^~
> > arch/arm64/kernel/elfcore.c:69:9: note: in expansion of macro 'for_each=
_mte_vma'
> >    69 |         for_each_mte_vma(current, vma)
> >       |         ^~~~~~~~~~~~~~~~
> > arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_phdrs':
> > arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no mem=
ber named 'mmap'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                   ^~
> > arch/arm64/kernel/elfcore.c:79:9: note: in expansion of macro 'for_each=
_mte_vma'
> >    79 |         for_each_mte_vma(current, vma) {
> >       |         ^~~~~~~~~~~~~~~~
> > arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has n=
o member named 'vm_next'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                                         ^~
> > arch/arm64/kernel/elfcore.c:79:9: note: in expansion of macro 'for_each=
_mte_vma'
> >    79 |         for_each_mte_vma(current, vma) {
> >       |         ^~~~~~~~~~~~~~~~
> > arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_data_size':
> > arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no mem=
ber named 'mmap'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                   ^~
> > arch/arm64/kernel/elfcore.c:104:9: note: in expansion of macro 'for_eac=
h_mte_vma'
> >   104 |         for_each_mte_vma(current, vma)
> >       |         ^~~~~~~~~~~~~~~~
> > arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has n=
o member named 'vm_next'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                                         ^~
> > arch/arm64/kernel/elfcore.c:104:9: note: in expansion of macro 'for_eac=
h_mte_vma'
> >   104 |         for_each_mte_vma(current, vma)
> >       |         ^~~~~~~~~~~~~~~~
> > arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_data':
> > arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no mem=
ber named 'mmap'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                   ^~
> > arch/arm64/kernel/elfcore.c:114:9: note: in expansion of macro 'for_eac=
h_mte_vma'
> >   114 |         for_each_mte_vma(current, vma) {
> >       |         ^~~~~~~~~~~~~~~~
> > arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has n=
o member named 'vm_next'
> >    13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->v=
m_next)      \
> >       |                                                         ^~
> > arch/arm64/kernel/elfcore.c:114:9: note: in expansion of macro 'for_eac=
h_mte_vma'
> >   114 |         for_each_mte_vma(current, vma) {
> >       |         ^~~~~~~~~~~~~~~~
> >=20
> > Caused by commit
> >=20
> >   b09e8361a4c3 ("mm: Remove the vma linked list")
> >=20
> > interacting with commit
> >=20
> >   6dd8b1a0b6cb ("arm64: mte: Dump the MTE tags in the core file")
> >=20
> > from the arm64 tree.
>=20
> Yikes, this is quite a mess. Liam -- how would you like to resolve this?

The removal of the vma linked list means tsk->mm->mmap and vma->vm_next
are no longer usable.  for_each_mte_vma() could be altered to take a vma
iterator:

#define for_each_mte_vma(vmi, vma)					\
	if (system_supports_mte())					\
		for_each_vma(vmi, vma)					\
			if (vma->vm_flags & VM_MTE)


Then used as such:
 VMA_ITERATOR(vmi, tsk->mm, 0);
...

for_each_mte_vma(vmi, vma) {
...
}

Where might I find a branch containing this patch?  Is it a stand alone
or part of a larger series?

Liam=
