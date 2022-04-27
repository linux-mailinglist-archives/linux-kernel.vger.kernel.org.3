Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C11512236
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiD0TPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiD0TPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:15:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BBDA1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:06:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RIu8kf003699;
        Wed, 27 Apr 2022 19:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gQ9oPPGmw8dHievlfOUOnpm5xZoxgLHSYup8ISp8XoU=;
 b=D8fiivLCSoiKDso10iEzpopQcjnXCskiBjQjPt/5VNR8ATDGfmXhO47d7c9yehPe0XBC
 hEyOKOBYotzlMAdbTtRGDPD/kgV6ryFjQAq1nv4KMcb8m3SiQ8dNY5fSmQ9mBzH4jXhe
 kjhGVHS0ghBMpUGTlOBXdLu4FB0ulshDs+KLxSOinslRl/HL3jSGOVRJ3sMWihfvjYBG
 /KEdC4KY+jA8TJIv+p5qDWupM8dyYaKIg8cwmawDV7v3H63AmGeQXWuMlVTmMz4WzaQZ
 YNyyevuX1zpQ0QpUddriAXAfnF+r7BtNgp6cu7Pu4Gtv6QsAxT+sSs6FXcxbM0y4btYT 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4snkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 19:06:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RJ18J1037537;
        Wed, 27 Apr 2022 19:06:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5cujn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 19:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apvhLW4Ii+mEaQ2v0VObWiRjjWp6xcSY3BNPE+NgXLq8mK2I6BHgOisrP3BfHAG63pdbV5eL4iiwvgq3kYio3KFZkgRm4ZyAjJjg74jp/75QMuhAuICfouO6wPiAsLihYu7eKIczPTjwV4TVaUFi856chHRO5XHSDlWR3pBybmpzdB7UqfFK/TZqA7i5wGpoIjrHxWEgClmxB+2NtHVArOVLbQuqCIr+2t44rozYQoz1yAiHSMNi8y5UzORn2VwuEc9c2O0ZFG6ToibDiPdFhWqVQI9/it1oZKNBvN8JX92pUuObo9s2Ud5SE1Ry33UWHXy3CEr0FvAu47QPX2EHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ9oPPGmw8dHievlfOUOnpm5xZoxgLHSYup8ISp8XoU=;
 b=nlDNk26cKiI2sEAFVA4woLmbnB+sMCJBN6fzWLzvnFUwxE0jYVTsZckylHcugQpKYOmtqceSH7H67R7RLzUgETujXVI2Bbeh7SaEtSGfNtQXDAQM2y0FR2T9svDH9474EVtf64K2qG56ANlbSFE9z9Ly2FTgQiJaznonjjef7gh/lV6/m7rrVxwGmCnCekpYBhn9SqAXh6ljWO0Mog94T3ZxTy2WQnT5+gf8D1mq3qFfWLM4f6seT0GBTX5uwXrfUDObLHWpja90wu2xnEcGkUL27lhFFmIpGSrM0uGFx7gkmQsOGzZaBUko/gdujuYqgbBiqNpVpG08+oJXgan1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ9oPPGmw8dHievlfOUOnpm5xZoxgLHSYup8ISp8XoU=;
 b=pLDJJ9/BHpDgC11k3usf891q77rvph18rZd9pQvOsh1H8orjk6xjMMWzbqAYffks3oLY79opIgeT0sklJAAjgHJhgHRUHGfblIZcrWZRPqLRQaBVlMAqULpoRDtZCb6086jxY+LNkalNlezHcY6XAMVwff8LHk6RD4N7KIRaiOI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 19:06:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 19:06:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Peter Xu <peterx@redhat.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [syzbot] WARNING in vma_merge
Thread-Topic: [syzbot] WARNING in vma_merge
Thread-Index: AQHYWjRmy9YwbzHJ/0e8lY/ldotJ+K0DvUcAgABEggCAAAjgAIAAFLIA
Date:   Wed, 27 Apr 2022 19:06:30 +0000
Message-ID: <20220427190622.wgoxjjbmphdo3xxw@revolver>
References: <000000000000a23c8505dda227eb@google.com>
 <000000000000f28f0005dda29992@google.com>
 <20220427102032.5a87283eb64d06c1a6d682fd@linux-foundation.org>
 <20220427175218.cazytgdlpc6lpn45@revolver>
In-Reply-To: <20220427175218.cazytgdlpc6lpn45@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de56beaa-583b-46a2-9bca-08da2881099a
x-ms-traffictypediagnostic: SJ0PR10MB4527:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB45277AD5FD6C8566D77AF2C7FDFA9@SJ0PR10MB4527.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAWU6HhXald1fH1ealAU6WT4op/OHUv1hDK8tvft/0WCgLIasroL6UXbvTYnePHpfq637cgdHw516nOKwyYX/i64ZwvNSrbmNa/jvbFzMiJR2L9/nThaffk6thJCC1wpkZhxBQ03r0xrkMHi1e2+N9Q+4ot0g0oFx3WoyZjg5M0d40d6m8VKDCjMYrHutWngiOFBPZeyoOAfs0Es9U3l9Tqa7a3tq72JaxK/igghq+b7ryUlMWt7PD2SOVpnikM2syt0gcqz0lpiF404CVwpzjYz5K3B8nz5w+///kaf5Fn0E/ivTV9ExWO/0yupOdJbbAPqWarSASDweU/xqurT31UGCJdAxnWyaWCkWdXXWeIeI9DyqUc8FWc1PBtHPnuLqkB3GoztpRx072ZTWcf12rVCtU3gdC+MIiFE9eraR8c7mqRZk2JOoPk8tTNrgJAIzhxKR3XFt3a36HZ/owBx1WAORpCz+mlwQOEFcaf6xfM+bxI6LDGAdGStRuKhXdVhDygtSQZTKAmade3vTK9ictFPDIumpSAikfZeVdtKJIWpluk7t2FHqw6j8CGMckFglj6kiGpwIy6npsiwVeyUYc/1KyqNZGin0P0QZjUANeJJEChqbLFrwORRLEX8jGwFXAwdnkAttLOM1hRxDG7/YT2SkeK/aBg1s4q9iBPG5qWXW9xLnbeVg5QmJQbJWWO2bwGAQlh8jOSIHEwUtsd47MwTGmWjf6bRI/Ih7HkMNRRR5ACljQNICa2zCZ6sM5K4Xg3wNNhIctsEiUV2MC1s18tqS4idr8m8AKMHcy5ONo2cxlwmJsFssnSRigQn7Vv0Q65oYx6deAys5sasGoHvF0WoXXMfpBf4Qvo5ULYm8uA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66446008)(66556008)(66476007)(6512007)(26005)(8676002)(9686003)(8936002)(64756008)(2906002)(6506007)(83380400001)(186003)(5660300002)(91956017)(76116006)(66946007)(1076003)(86362001)(508600001)(966005)(38070700005)(110136005)(38100700002)(6486002)(71200400001)(316002)(44832011)(33716001)(122000001)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?87sjV7XuYIhMUX4Ar42XmpZgAWS9NB5k0l097pzSYsAGaNDTmmdajFDXASIG?=
 =?us-ascii?Q?kn9dOHB0Ts+Q5GA/raORNo9WINn4928ko88Am/vUiuD+b1WJFW8RLO2dSm1i?=
 =?us-ascii?Q?LHuZCjUlq/Xto0/WW28ECzsFOejIoOM8CTy1V3SrFwvPdLzJA8JQz2f0CAAT?=
 =?us-ascii?Q?Rj8ffxidGDJKmhGB9KgetB3s6vOpBgmOU0FMTvGmMqvkOjGScSQy4qAJ2kRf?=
 =?us-ascii?Q?AcYFbtPltSDnXLxSq7hGNT8XVyvSU9YXOz/c+bwIZPIWnZsn3ZkBY8A0VrFm?=
 =?us-ascii?Q?17UsrGC6E+NBDcyvuFpbnv4MZsjnHk2/TRDnz6mOyi9RzvsTFvG0DhnUiy7Z?=
 =?us-ascii?Q?DUPpqkqTOXEB1nPSrx0y09ZqiUM6zVqP0c5BFFJ8s43AET1UbtCt/HRJHCRp?=
 =?us-ascii?Q?KdMakxLXY9PZGkzox3NVuezO5xQGQSueMTBgaKrmhSRs0K/vUZD5YC3qI+jl?=
 =?us-ascii?Q?D5QoPDKAX89qXF4cW1nRzxT0qmEmTPMLYpIzM0dHuHxngOWQwDcqY4+u7EaV?=
 =?us-ascii?Q?nnrX8dLXqZIzuQeJGHfPqN2+5HYso3rnGCBao1CtaR3JNpDGouizNtIspJ2Q?=
 =?us-ascii?Q?TYadwx4SbWR7I1b3TFBjMO6l9kU11Ce4yr3zNCLsb6WKIued+f38P4JhZTuU?=
 =?us-ascii?Q?JTZvFnLd0MtPqFNfsLiMI34w/MtGNtoMHE82FKq+x6ZNu/4pJ5GLuZr7Cj4O?=
 =?us-ascii?Q?8yldQeixRZk1BoiGv6e7OIecyMdG+bG15W7ONd/YmnRoC1cpn0NCOIeYaVb/?=
 =?us-ascii?Q?zl2yWv8Ug8hfbqeaqGCG5KpMRI27ejXKmIKGqaeah5bk8kSlJkU4rQ4HxGQf?=
 =?us-ascii?Q?QetgABjeOQg19wswpxuoNgCrA9gUi+a8gKgSh+4ACniKQSOyNIhWWghcegAA?=
 =?us-ascii?Q?JvmV034oBVNkb5veGrj654yp2S8XDETNQI1Zq3lyfZ9LqConKmxuoLE64DD1?=
 =?us-ascii?Q?KDxGV9a39i4OELXbKn9iFIh0xP1V6KcuKaDV27lfFCyjUR5m8bW+9oDQt7fb?=
 =?us-ascii?Q?My3o2QTOQs1iX4xfnVZJ+B+G/Tks/+rsNVpi2Xd5CTQMQpMiiweZ/UJjgocy?=
 =?us-ascii?Q?lPKbL6LjSzMoqg3uHQ2kPttfWpjzY5ZVLEvQbpnKxAel/eHJDiiQgZmg3wO/?=
 =?us-ascii?Q?OS6WmUWV/mEj/C42FlKv8+KSTHXUgIao2tIPzjklMBX+IM8c2O6MMSGnqTUJ?=
 =?us-ascii?Q?0u8IgtQ05HHKk14UQxun6yLfbdNIBanu3dytggH21bU939WDC7UCjSfR9ooC?=
 =?us-ascii?Q?JsTJeEIcWRuW7utIPECqRMO3Khd/r1BhOc3L7P2Jz9DAWnQNuXinePzxKw/o?=
 =?us-ascii?Q?CzKiKQH5d529IS7LjnIoJ2t+fV+DYf7y9QXBueD0T8BajRi65nDxqWY3M/Mv?=
 =?us-ascii?Q?0RJ6kxyHjcGNCjRxuUZL2Ys1dhssdc4Qt/x+V/v5SpRXpfSOHOfzLOZQ6vRT?=
 =?us-ascii?Q?YrKAANL/RBmSX8B2sRXdgBawcCx4h9MvTDWUUE0+8BLvfsmF4PlpKiZ88+JB?=
 =?us-ascii?Q?gqvF8tMUo2gMcJpBuGye2b3a4Kd4pY4dewMMz9JZM5BUxv4TPG7veEjexBpD?=
 =?us-ascii?Q?GuG5pPRgRdx6oDIw/DWodVRvObkaaZ9QmRVfAezwnYQKxChfBMzd05Qj36+g?=
 =?us-ascii?Q?cAy/wVQUKtwng+2PHjgiWeul7gITIf89kyQTQSCvieBLP5567WmhXml09REF?=
 =?us-ascii?Q?aIWahcanlLTfSmlFrI4MRexzBPQ3LLw3fOYyqS9YUfCpETKHhg4TO3QacHsP?=
 =?us-ascii?Q?ySXVrdC0a6UPkha+AzeKaoGapJXOXIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <656234611C030C4F847A4F0C11434E13@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de56beaa-583b-46a2-9bca-08da2881099a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 19:06:30.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWJ1AEXF+WbU+PX5vAaF+hPfHq6OcKG4+OwdWtfZhIFYXWBLWM/kbSYi47537RZsPLdTJI07VHBP0xgUMQ25Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270119
X-Proofpoint-ORIG-GUID: 2rDahGICLYyB3ODGhqTSkg4KkgCLcMv3
X-Proofpoint-GUID: 2rDahGICLYyB3ODGhqTSkg4KkgCLcMv3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220427 13:52]:
> * Andrew Morton <akpm@linux-foundation.org> [220427 13:20]:
> > On Wed, 27 Apr 2022 06:15:20 -0700 syzbot <syzbot+7728e4ab5371cebc9c00@=
syzkaller.appspotmail.com> wrote:
> >=20
> > > syzbot has found a reproducer for the following issue on:
> >=20
> > Thanks.
> >=20
> > userfaultfd_release() appears to have offended vma_merge().
>=20
> Potentially apply_mlockall_flags() and not userfaultfd_release(). There
> is a potential that the vma iterator is stale if a split/merge succeeds,
> although KASAN should pick this up and KASAN is active according to the
> config below. I've sent a patch for the mlockall issue after Qian Cai's
> reported it to linux-mm.
>=20
> >=20
> > I'm not seeing any changes in that area from Peter, but Liam's
> > mapletree work changed things around a bit.  Gents, could you please
> > take a look?
> >=20
> >=20
> > > HEAD commit:    f02ac5c95dfd Add linux-next specific files for 202204=
27
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D105a33a2f=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De9256c70f=
586da8a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7728e4ab537=
1cebc9c00
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15f76f8=
2f00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12b42c3cf=
00000
> > >=20
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com
> > >=20

...

>=20
> I cannot get this issue to trigger with the given tree and git repo with
> my config.  I will try again with the kernel config above.


I was able to reproduce the issue using the config from syzkaller in my
VM and can confirm it was the apply_mlockall_flags() bug also reported
by Qian Cai [1].  The patch I sent earlier [2] fixes this issue as well.


1. https://lore.kernel.org/linux-mm/20220427161033.GA1935@qian/
2. https://lore.kernel.org/linux-mm/20220427165139.5s3qcj2u5vqrvwlc@revolve=
r/

Thanks,
Liam=
