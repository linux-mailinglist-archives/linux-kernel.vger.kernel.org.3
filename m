Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A284254D8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350915AbiFPC4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350135AbiFPC4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:56:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A711C117
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:56:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLYVMi032735;
        Thu, 16 Jun 2022 02:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b2TfZLIdK82sxHdeA5qkeRD0Ztm69Hd7Gl3A2LNJosY=;
 b=HfUtMwCUZIqMYB/SJqqddtpMJUG5FxbPGX0j6cDbMrcIqK8ckX2N5pxzKrF/N7rGfIWI
 JN7Kc1DuXt0yv0+dxJhNcfMsgiVKT8hNnxco74nGdPN8MIaLbrEkfMKddb/ezdGORtPO
 qe3getbDYxIiymXjlfwPug99R+JK1hgEWpvQ5+o/zM2QEmSPQ/KfJUI5xsBAu2lCCcCi
 QBORJxBhlzNR/o2Prs2OH1w7DHR974NgJi3CUVZyr4y4DX9ZBtSjcordsl/ZodadKxom
 EkD6TrPyefufVoQOGa0wcSfl0gnhvZp/RL3CQGrfIySo2wzwluSD2dLT9WNSzsZQQ3E/ LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2t5j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 02:56:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G2fkov004007;
        Thu, 16 Jun 2022 02:56:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwbkjn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 02:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps1Ay25UEkCUkijBoi26BrWOeJlqk8Iaufe3r95CHH+E47MWDjK69h1oWZfQhayKW8DS73mzAM5UhuN5enqokNjsXd5BJPQOg8thQPBHjrBUweCWsh4yh5bjUwjRS63KQRn7ecCjRi7AcUxE6sh3lbQnXDkk/7eQ/9PEJGA91pFXTaHgsD46XStq66TfoDygg4vi9xEZnwRC2/MIh5+LXdVq8w695EipSFGsb11exkqZ2TOm/XKipZm4Z0soJem5jFppmqo7yTTyRNVIE7dsvERYlioSM/DfkQHbd5fTcvpM5p3gTdJ7/p4/vMXr/QxIaf7JkLm2ec30K3QRIU3+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2TfZLIdK82sxHdeA5qkeRD0Ztm69Hd7Gl3A2LNJosY=;
 b=kGYfPzshWZJycwbGoxQ2yG5w3ZtMs+sfzLN22VXzN1elLPcoWmD5mlHqjf1bI+Kc02t/mMZAPe0eIsXrwKwR8Ssr2DYu/jAlCUFV3LVc3d4JsX9zvWRoWpleovy62PcUV3Vn3ogLG81ndXKIhGoSq0w5hlz8L7YYkokYjXYxoJ8Hl5n5rXREPGtXgtKcif6V/FbUfS7w6xQILIX09FnUmkTovOZcRNr8ETZ1GJyyuOEKOjKkbaZoKMCAyE0jid+t7VP0sqF+u/AQYIO4hxoRJ7kz76tBI9duhZhiIh4pQcWZn6toOrMltjFsUBv/rTAEuA/imokUfak3ooKfKZV77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2TfZLIdK82sxHdeA5qkeRD0Ztm69Hd7Gl3A2LNJosY=;
 b=lcI8XIX5Jgfoz2lD9VL+VfrLAFtQ4wE5cZraTHYTZpxlD1up24Yhr/B2Y6GuXyuNW9v7LPIPb8wAwB0fUbxQR+BxQMk9+x6so0T27FTlp5TwhZwNlIhgGRXXD1xaP6+kCYK55jZJE9saKtJK3CIEa5sBN/PXoR4uP3jzYZIk0vE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2461.namprd10.prod.outlook.com (2603:10b6:805:4f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Thu, 16 Jun
 2022 02:56:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 02:56:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YCAAAXagIAIFpmAgAAbWQCABc0jAIAAPjyAgAANPQCAAALVAIAAJMOAgABMQwCAAAJqAIAAEAiA
Date:   Thu, 16 Jun 2022 02:56:04 +0000
Message-ID: <20220616025557.euz6z5rlh7fqewy2@revolver>
References: <Yp4uD8uWB3rit/Ee@qian>
 <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
 <20220615142508.mtp65w6tdiurtvcn@revolver>
 <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver>
 <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
 <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
 <20220616014956.6jgxvbzh4ld3c32q@revolver>
 <CAOUHufZtq0PDiGXBvLV=POraK-4dfnQ9UNmsafHhJmzxAhzrfw@mail.gmail.com>
In-Reply-To: <CAOUHufZtq0PDiGXBvLV=POraK-4dfnQ9UNmsafHhJmzxAhzrfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b99d3d95-e6c9-45aa-d575-08da4f43c10d
x-ms-traffictypediagnostic: SN6PR10MB2461:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2461029B0D75DEE8E3C3FE38FDAC9@SN6PR10MB2461.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8vL5+WzDY0UXosJkibpyloDBfcXn3JSs9cWiaF5SQAxuPRJgLbrq3b8kn5H6xq1o+W0BxUoy59QUrrnsYscnum9WJwml9vui2H7TgcsLPaKtTX9fHCpVGSzMgCA9mQgXJoZ8M4lZTeULs0SHy5/2qGaxZAw95pV5EFw9Pedj48V4Ht0E64deplYHjhZ9CmZbuL0VWLAHQAypZeieKMSUEK3ImOswBe5bIQnSncyphDL7SGUDuYI4dzwzlzfww3MFv7dq7YuF+ai7/K+kgIEO/mS/BoO8SZl6UBfpeCfqOfIrHPEggODbWoLO3SSShXE+w2pYOpWBap30grLeChj+UUDT+0VR5mKAFDBSnC5RBW7vpfVhSQ++LFRS46faiM3u5GNRM01IgdOX4BIam3h4uezTrSwdgNn2fQnACVVAJ6I1iplocsk3T4qlyVKQgGDNu3RjO67OEhBGmNTjF+hx3oEmFcbK7yPQp+AK9qKQeBhwX16eR7iX41qxGdzNMUZzVzfncrT5md/Zh99229zGCSvZS2RMvw3ZhdQSZee7IaXahGTqRvRZpcS2gPSUiKotbvfmVY/p2kdO8OAt5VXf5WlE2ZeBEg4fyZUrKuFVXQ2oSzUSIBO2qfLz0+KyyiCN5gCrV4fgl8yCryJPocDcrU6PYLMRqXxyq5HYl6nCc0iAYQob9LmHfRWFFIFz2UE1cufnRV+07ivd9GdPpc5oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(38070700005)(91956017)(66946007)(4326008)(83380400001)(64756008)(76116006)(66446008)(66556008)(66476007)(38100700002)(2906002)(53546011)(122000001)(54906003)(71200400001)(6916009)(508600001)(186003)(316002)(86362001)(6486002)(9686003)(8676002)(33716001)(6506007)(5660300002)(1076003)(26005)(44832011)(8936002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MP+r54IVl4f/xbTRdgcCtCeI7FIWu6bN7zqjtPWHBBFc6C0vRwg6qEKGPlpf?=
 =?us-ascii?Q?yw3P+FthdSZW/PSy/lisW0+Gm3XvHE4Xj9fqpGZvoFzJjldkNZOcAXfVh57v?=
 =?us-ascii?Q?o0GSoQxr2G3KEEb3ziZTvgUG1i5fNYfG+0hBeckSTkYA+dUcsYAaFt/EluTs?=
 =?us-ascii?Q?JrCcy8FplfzBRaeUJsx3sWPAcOTXjbRzqmeLdBUl0Uwk//UncEQvL4eAyp1H?=
 =?us-ascii?Q?fu7Hsbb5f7whFYUCtNONPZj2s2gNiiozCZ/ESOFyPEQ4a6lOl/+W8z7fPDHZ?=
 =?us-ascii?Q?s1JxZOjX41Zk3N0IuT36ENgp22IeZiT7h/7iRk6Eawn+UegGR9j2olNg79Cw?=
 =?us-ascii?Q?bweMYmJj7khF30JfctSUlcU5l1i6lAH5r+TEBttP40o6vPPvB+BEc40N01DH?=
 =?us-ascii?Q?yid1Mzk6KhLajXK0LVmpAsynEIR3/LoUvaOV95KSPVl9O4Yxvj0kEH/KvfR4?=
 =?us-ascii?Q?xSJaLcAEVSPPqpdbLSFvZJvUWr+2Hjp2R5RSJVv6/YSkBGv5z3P0brmiXuEg?=
 =?us-ascii?Q?W2Q2E/1DItaFousw/EyItHhbjNwUYRSgObw6ny1WRMmHwGeWGe9pg1q62n/I?=
 =?us-ascii?Q?R7HlTnVLfmXMrd5hDACPJCIRCrZS5H5JbJDv7MpBJqK5hmGVDlfTNfcc+Qcy?=
 =?us-ascii?Q?M+gUH5kVkG3Gcc1a/Z69kZcFqOclNVZGXZBkSWprrrBRnJvkp4dIi7MP+ksS?=
 =?us-ascii?Q?gPUR/2KADNpDXXpwA/hE72AypqcYMu6gfls3LK2Lljjrk/VUqJnmBG7sAmXY?=
 =?us-ascii?Q?4YJcKxeomF1R8wJyVK8gYisLaAqGaXpRzVnED5XA/MNsvfn2tHj/ji6iVylz?=
 =?us-ascii?Q?WW2+FFPIDaansQS/QC9FmcbXNx19ksyuKJ4YE7gP8KQJd9aNxFXqP64AUa3M?=
 =?us-ascii?Q?VsGjRJyG4UhnYckspPr9NiEgIyuEI9bxk7VidjxiHm58YgVQNfEVZ9hoRjep?=
 =?us-ascii?Q?hVSkSrqDpfP9VYAY3WHXaqbtTG7CJxJ1IdgQgBoT8bjsAmOZ+UXVArmsnUdb?=
 =?us-ascii?Q?cL6nehHgZAphqrSadTGZR5At/T+LYhFONJ4GC9hJibF4dJ0bYeBbJUCwqJM9?=
 =?us-ascii?Q?PmwWJOSH66ZppAJMBkAhU8DSnhNjasOpGnIFenHNq25jSnq8YsZVkq9pxc5o?=
 =?us-ascii?Q?0WGdXtZw0F2Ai1ESAaSprz0TlTh6p/cRXIQ1NY0yckByBWjTca6fhW99iJ5z?=
 =?us-ascii?Q?LiwU2m5Syo1DG+RCVQtgefzhPOjTGVncjsw9m+mLnC71sFN38wG5GFD1fjRp?=
 =?us-ascii?Q?XFDNzvWgbGzeN/i9D1CXhXMujVkgvvQbx4i21IEdXqILEwg10QR57XaySfYa?=
 =?us-ascii?Q?E9WAfZjhNOZp2JIwz9Sc8x2s2W5fSlqa1xJRtk7Ch4sIRgFjOm4Yrg6DBPeu?=
 =?us-ascii?Q?moWoqxQUpdmRiPP0JbK8plreGRYEFZlbUB0qtweO6d+cD/td+IF70s8TsmVs?=
 =?us-ascii?Q?HFGuRaRKyPfePlFEzPOrmI7ZwlOR+b0YgYEQQyH79GzRXUyL0FLP7Htt2w5p?=
 =?us-ascii?Q?sJsj1jYwH47DWbv2lOfB/LCcxL4X6IiBXhsv3tFwOhYs1GRLCt9BhMIl/cmb?=
 =?us-ascii?Q?HawS0BqpKGMs/wbRgLLWsmsl90L0tHlT9Q6AprRyxpyaeZeGXty4rO2RQ2tr?=
 =?us-ascii?Q?hhxN67SnGCtXg6t8GD3jMOy2HB5Fbnh9GYwhkGVFuKG52laT5RHmIL/0P0UF?=
 =?us-ascii?Q?wzeafY+bQt7XPU/pTwFn9/aVJtMV81hpYP2s9pUgMVtJupvBtIwXQsGm4xSb?=
 =?us-ascii?Q?D+cleNAOpKDoCQkeBukeBSq1ZF1Ne6g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FB2566FAA7C2341BEB3859CAC239BF6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99d3d95-e6c9-45aa-d575-08da4f43c10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 02:56:04.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lM0lrdeyKBvcaJHC17t1/7vWNGrLzYkT6yXiKdNbqMutIfu/qPpQFxNsGLDgoNBA9cxoxB4wrVrHHsJrOQkqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2461
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-16_01:2022-06-15,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=863 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160009
X-Proofpoint-GUID: M-3D_bvfWk4uenCvhgSnnpRM7TOkR4EZ
X-Proofpoint-ORIG-GUID: M-3D_bvfWk4uenCvhgSnnpRM7TOkR4EZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220615 21:59]:
> On Wed, Jun 15, 2022 at 7:50 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Yu Zhao <yuzhao@google.com> [220615 17:17]:
> >
> > ...
> >
> > > > Yes, I used the same parameters with 512GB of RAM, and the kernel w=
ith
> > > > KASAN and other debug options.
> > >
> > > Sorry, Liam. I got the same crash :(
> >
> > Thanks for running this promptly.  I am trying to get my own server
> > setup now.
> >
> > >
> > > 9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/mm-everything=
)
> > > 00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for_each() loop
> > > 55140693394d maple_tree: Make mas_prealloc() error checking more gene=
ric
> > > 2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full non-leaf non-a=
lloc nodes
> > > 4d4472148ccd maple_tree: Change spanning store to work on larger tree=
s
> > > ea36bcc14c00 test_maple_tree: Add tests for preallocations and large
> > > spanning writes
> > > 0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked_page_nr()
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > Write of size 136 at addr ffff88c35a3b9e80 by task stress-ng/19303
> > >
> > > CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I       5.19.0=
-smp-DEV #1
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0xc5/0xf4
> > >  print_address_description+0x7f/0x460
> > >  print_report+0x10b/0x240
> > >  ? mab_mas_cp+0x2d9/0x6c0
> > >  kasan_report+0xe6/0x110
> > >  ? mast_spanning_rebalance+0x2634/0x29b0
> > >  ? mab_mas_cp+0x2d9/0x6c0
> > >  kasan_check_range+0x2ef/0x310
> > >  ? mab_mas_cp+0x2d9/0x6c0
> > >  ? mab_mas_cp+0x2d9/0x6c0
> > >  memcpy+0x44/0x70
> > >  mab_mas_cp+0x2d9/0x6c0
> > >  mas_spanning_rebalance+0x1a3e/0x4f90
> >
> > Does this translate to an inline around line 2997?
> > And then probably around 2808?
>=20
> $ ./scripts/faddr2line vmlinux mab_mas_cp+0x2d9
> mab_mas_cp+0x2d9/0x6c0:
> mab_mas_cp at lib/maple_tree.c:1988
> $ ./scripts/faddr2line vmlinux mas_spanning_rebalance+0x1a3e
> mas_spanning_rebalance+0x1a3e/0x4f90:
> mast_cp_to_nodes at lib/maple_tree.c:?
> (inlined by) mas_spanning_rebalance at lib/maple_tree.c:2997
> $ ./scripts/faddr2line vmlinux mas_wr_spanning_store+0x16c5
> mas_wr_spanning_store+0x16c5/0x1b80:
> mas_wr_spanning_store at lib/maple_tree.c:?
>=20
> No idea why faddr2line didn't work for the last two addresses. GDB
> seems more reliable.
>=20
> (gdb) li *(mab_mas_cp+0x2d9)
> 0xffffffff8226b049 is in mab_mas_cp (lib/maple_tree.c:1988).
> (gdb) li *(mas_spanning_rebalance+0x1a3e)
> 0xffffffff822633ce is in mas_spanning_rebalance (lib/maple_tree.c:2801).
> quit)
> (gdb) li *(mas_wr_spanning_store+0x16c5)
> 0xffffffff8225cfb5 is in mas_wr_spanning_store (lib/maple_tree.c:4030).


Thanks.  I am not having luck recreating it.  I am hitting what looks
like an unrelated issue in the unstable mm, "scheduling while atomic".
I will try the git commit you indicate above.

