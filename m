Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3925222E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348304AbiEJRkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348250AbiEJRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:39:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59E92AC48
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:35:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLmHa027467;
        Tue, 10 May 2022 17:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QiSXegfv0KNKYkz8Tag65+Aa/zYE9aNLprkfbZjc8vM=;
 b=ywD+5BTTmr6ZM25/aOV2I1o1fFfGWEaZ4pt5GLtGMp4cRQPPRQCN73I7KHDVYNpDCtv0
 j8iE+awPEIWj3DEBlmLQQ0yNCxTP2TghHlb1ByQgHaibpc1C2zu4wl1RRaunv7QvNR9o
 m3Ckn21QtFMvISITSP/eRSyY3AWHYl5jGzy6JYfvoueqz+H1LBb9Ue6Nuo1kOksKKFlk
 AmonWnaJY+qnj0ZArfoWHc4k7wUalro9bEPB8y6oDPZll7aMt8Jm9STpd8tc7n43iwMl
 0gXTa/lwuDiid81Eq4A6M/5qXO/jHFaOIuzX5noSmqP2g5tY5fDcZ5q45eerLv0DVS7q Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2fh7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 17:35:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AHZN6g016824;
        Tue, 10 May 2022 17:35:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf72k3fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 17:35:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSrL9wAHyo1d84rgfpbonr/wYhgqfXH7Ff0N+J+yCSkLQgi3l4U4vjzYGXRPKArGeMj3s6YxYm6hdxii/GnpzqM/PbcKoNek7IsZosDkvSXo8w69qQ/BaDlYIDHgZM+SL2SZ4xvwCh8lLkdQb0MlXkhWSvPewIvJ3DF07Fm7i9PuqjePdUHDCSqaqwlnrp5foYYeV1MpqCYIuc7d/+aOaF5AIUR4IU07IOVADw6J4AftAeY2IcMiGq4i2hRUWjQL/c0anwYO+CilOZFY+mNWpQhNVdPn8w6wBvyfgyAmYEgaOPogtzSmHpol/QDrtCSk73WdixY13M5BvSDPoKiNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiSXegfv0KNKYkz8Tag65+Aa/zYE9aNLprkfbZjc8vM=;
 b=F/hN8Dcw48502ivI+GnXpOfKdU3MfcwxXZKzlqWNMx7no65DCedNMMhZa1vAYp36xtNpVPdjzWugiZnkkSYuuFj5uv4pRK5joFbdLrslOsM9otEHJ6rdtlvJx9PIvcGn5YwoMg5zK+m1xcjhxsOri0qdcOZjIG/rquL3Objdh5s1vJK3AY8HKdivlisImxAY+0qg966Ypie7LAQm4CgNeAQUSZ6qOnITkMvr9RCM82+xIXYA7Dhr6dDUDQTmaDuIPnjs1JRov0wlpW4DRI4xy9LXVgnN8Uw3P0nwIK3ZHUpxqH7jAnXwjH/gKUcEIgZI46KZV8ZQ+Qddx/m9IIf5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiSXegfv0KNKYkz8Tag65+Aa/zYE9aNLprkfbZjc8vM=;
 b=t6c+RYv3POXAZIw9pAwWg2IMt4ZKRWNnGU0Vewv/Z1VX9QT8B7RGev4yAh4WTOHvZRvmJgSXd7YJi1Oq5Idn7EF9pUg4qb5+qvX3FCuS509wEM+e5BfBaoymz1hj0lU6OSznMZvBotLVjZ7ISlRUPu5Xh51JDipKr5ZDn7TXseA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3226.namprd10.prod.outlook.com (2603:10b6:5:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 17:35:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 17:35:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [akpm-mm:mm-unstable 338/431] mm/nommu.c:579:2: error: call to
 undeclared function 'vma_mas_store'; ISO C99 and later do not support
 implicit function declarations
Thread-Topic: [akpm-mm:mm-unstable 338/431] mm/nommu.c:579:2: error: call to
 undeclared function 'vma_mas_store'; ISO C99 and later do not support
 implicit function declarations
Thread-Index: AQHYZGzcLoOvwAbW8U2cmZ1bZLmega0YWFYAgAAHX4A=
Date:   Tue, 10 May 2022 17:35:18 +0000
Message-ID: <20220510173503.abz4t3y3nyg4ndmz@revolver>
References: <202205102024.jnJMagOr-lkp@intel.com>
 <20220510100840.2914b21473ac5fe774a5d44a@linux-foundation.org>
In-Reply-To: <20220510100840.2914b21473ac5fe774a5d44a@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb7f4db2-4308-4a08-af9f-08da32ab736c
x-ms-traffictypediagnostic: DM6PR10MB3226:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3226BAE889FF03C3FBC86E27FDC99@DM6PR10MB3226.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ItoH2QgBoonI2OTwH7zVd7wyUYTxUmjNebsnTJwCN8PDFG+U0FknEyY9w92ErBvASeMWFDm0zyh4binbyglM3FcNUkhFA5LBim4Wb+pfyatZsX+4VHd4VUfxNsUEDnXBW5qh00tIa89masS4qUE7MJaqx25jXBB/nGOjqJX59FsfrcVVl8pP/ji2ccjxBmHNbFhAAR2KaqjvuI9z7K0jBa1HtWOCNcUHm2xdyI7uBMKJzBe0u9caMJttjKe4xfMh8vPHkSLV27ZKmBCFxpWFdz/PJQKtIoXvG+gdOUvqGVeV7yKf+hBIkyteFjbeAN6Meo42S+QNjwWey7RVmwbjZBy7k5sGYIKaLvz2fdluqXiPrkxvmNasNx1sRBi/lK/GGSlKYfoht5YEVGov4wi3iLjNHzl1j72+YkA8bTGRpa94nSQF9xgAFoHD0thbcBuULl99JClLupv2JwlIso4NfbSM+efHy6Ru6F+YHlIju8/Cpzmn5sV0617pCPigLFR0/fuvIpduSQibDrs/8CIasB5AR1Lkg+nSay3nw7n2bEKPTbfXQk7WR7+E1/iLFSUVA00xYxrgEZPheCmYrekIkba75n8hhWxv5ZctAWk2IGHInGCcyhpquhbQ7VjiTejyOTDozAkcJjl+LZobpUzSQBcOQYGyT4dbC6LEfiiQLy2l4vH5t6WM+xDU0ng114XG+0a921I9EuiWt980hvxKgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(33716001)(91956017)(6486002)(122000001)(8676002)(8936002)(316002)(66556008)(6916009)(64756008)(54906003)(66946007)(66446008)(66476007)(4326008)(76116006)(38070700005)(38100700002)(83380400001)(9686003)(26005)(6512007)(508600001)(71200400001)(2906002)(5660300002)(186003)(1076003)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YgTgR3FHlUjnKAAOHeuc8MQzR0PCMnn/eTgQt1LhePgnqRQcuvi8BVAtbCnY?=
 =?us-ascii?Q?DvyT9PcBfVSauSLdFHddwAB3+8UuPItoVGCmCY0jKg45TdesboQgECjmXEx4?=
 =?us-ascii?Q?LPMVpxV63vWlHlA8RLI7AYh6wnLoGl7HFdSC/Y3b5yzm2x8ombKXuNRbbxvI?=
 =?us-ascii?Q?5F4JOS7S5APAybQDzZlVwLPS5YD7DBydefEoDDDbd4EJzgWm4MN1djBsd4rE?=
 =?us-ascii?Q?ERTBtQeGfT35DcLbxY0b1DoCmLXi01k/WWzTMVi16HTYfEcKot8zm1Hf1BjG?=
 =?us-ascii?Q?i/gR1yHJgyirOFOLUGPpUSzbxkqCL5GDJyKcI8+c4Ffh08ZFltFg+hk2X+vl?=
 =?us-ascii?Q?FvOYkCloy34gXaTZbG3ADMfu5fz8XBDV3gUUGcqnLHbDP0ZpTuNDyuEpQDRk?=
 =?us-ascii?Q?MNAFinZiGZNA7bsiLmgOYjtwA9ijCKNQzrklkVWAhKyH6p0up31mOxXYGJKC?=
 =?us-ascii?Q?00H2J+QsUhzEzexUvcQQG55dUUXwMWJ1vhkfqAdVQ9o9Ibd6ij2kL40dMcjV?=
 =?us-ascii?Q?wzEldu5bqdPmgqPrkNPM02Qgi8vOekeiwIXL4b2fe2hBctJKf7ym6GafxOGH?=
 =?us-ascii?Q?H9kD85AKeFhoQNuRE1BU+3ej0BB5R+BuMO/IOmDucwhPHRnsUOv3XnI7mhDr?=
 =?us-ascii?Q?yonZS2E5Hq7ZTJO2wzSmMsKRgvOup4ffPdp9fQnpomCp8NGkanWysbZTPUI7?=
 =?us-ascii?Q?v8RCU/jp+Rlv0lMugnrKp/ZfUboyIdVSsmIe9D/vqVJU9z1iT/OEmNIqbTo8?=
 =?us-ascii?Q?RB5MwnVuMhBogx5gdsN03/FboqR/lcG4RU43p0xBJ8EaY3EgXaMXrq085SDG?=
 =?us-ascii?Q?xGDYmPBUCDJwSeo+TaJTg4fLQFSanJHLYqySVxkD9spUoWf3gwCgYM6tATOE?=
 =?us-ascii?Q?VWVsGRFuJBKnW+B1KPNt8DhJe18IuN8fNW88CWmauXmyZe6o45Km+fzGlys7?=
 =?us-ascii?Q?LkhSb8GykXQTWRni2QNajUEn+81As+oGlqTxxEcMnfwWjGRlUoA6YxVqQsJx?=
 =?us-ascii?Q?LKzZzMl0aMxcO8xIPTeKrfX9coVS9yPq410T6Jz4zoSM1tNo+cFe881fSdOt?=
 =?us-ascii?Q?U9vB+MacMZkPMRCSpxsbp345GI8gpOV9d1NjzoXULcZpkxXtEmIH6ZzMvhLm?=
 =?us-ascii?Q?c6V1vcGiKOvkiZ2jgJM/l9dHvJFE4rCYdnQERHfmdR+rKxTsQZQQIH+oQ3JM?=
 =?us-ascii?Q?J4LS92vMWA6Z5IkCzfcsMq+T7vbUUFqrJmG3v2dyRj3ydchqkRSuAeGAEpvZ?=
 =?us-ascii?Q?qGtD910nVz/3UkPD0KzKrbAm9SwXMfMzluw8tymCfRQR+icHTmpDgViORtv7?=
 =?us-ascii?Q?lSnRrNkmuAs1f1uK/VOJ+g/sL7xFHIFZWp22ABSuwGV5Xery3jr+Udaham0b?=
 =?us-ascii?Q?GCrrtxtOV/s9VKGaGIqSL1EufdTNPSoTQQsMCOSeQdtEdbhtT0iaW7Yw8w9W?=
 =?us-ascii?Q?l57TjOvApKGHmN4vuUEBeuCaNyxIaWZPnTcsVZAKDyh0QVrRxl8SOCziCBiO?=
 =?us-ascii?Q?8HFEBb8GVHb29zI1QGNyN+Y+d6QmoHjoyBWje96X7UpqQMm5GmceyNL6zUSl?=
 =?us-ascii?Q?sl1uIKX/PMsGQKEegwwmht2GJm4aXR8j23A9VZXgz7lai0LcNytU3MwgzQKI?=
 =?us-ascii?Q?UWGvulQ1jjZaEiN9UzDAUTgTawDMp1SMRwKYzIZL6eUsHNL4c/z3couSHYoq?=
 =?us-ascii?Q?XVFGaUrW9ely4kmOALJWfYT1ZsfqTnoJijbPppoqGNL2SXTyG2Z08FKUGYqF?=
 =?us-ascii?Q?zgPY0GT8QslImItnbcr5tDhrMJzxYto=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <975F33B6DAC1DB4E901529CFA88DFD30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7f4db2-4308-4a08-af9f-08da32ab736c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 17:35:18.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2cMY94FQBPExL4T5N6qYsWKPHwvKLoFemp7CBEx3B1DRIlIc/i5zXmWx9aJ594xUZEHjayIUNubl8c2gV2g0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3226
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_05:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100076
X-Proofpoint-ORIG-GUID: Qlbf716GavT-riuwUw-8zXyAgrR5PFJX
X-Proofpoint-GUID: Qlbf716GavT-riuwUw-8zXyAgrR5PFJX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220510 10:08]:
> On Tue, 10 May 2022 20:52:04 +0800 kernel test robot <lkp@intel.com> wrot=
e:
>=20
> > >> mm/nommu.c:579:2: error: call to undeclared function 'vma_mas_store'=
; ISO C99 and later do not support implicit function declarations [-Wimplic=
it-function-declaration]
> >            vma_mas_store(vma, &mas);
>=20
> Thanks.
>=20
> I queued the below temp fix for now.   Hopefully it makes sense for nommu=
.

Yes that works.  I'm trying to figure out the best way to keep my
tracepoints in the mmap.c version and I think this is probably better
than yet-another-underscore or dropping tracepoints all together.

I think in the long run, it might be better to put these prototypes into
mm/internal.h to limit the users.

>=20
>=20
>=20
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mapletree: build fix
>=20
> Fix the vma_mas_store/vma_mas_remove issues.  Missing prototypes, missing
> implementation on nommu.
>=20
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
>  include/linux/mm.h |    3 +++
>  mm/mmap.c          |    4 ++--
>  mm/nommu.c         |   13 +++++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>=20
> --- a/mm/nommu.c~mapletree-build-fix
> +++ a/mm/nommu.c
> @@ -544,6 +544,19 @@ static void put_nommu_region(struct vm_r
>  	__put_nommu_region(region);
>  }
> =20
> +void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
> +{
> +	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
> +	mas_store_prealloc(mas, vma);
> +}
> +
> +void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
> +{
> +	mas->index =3D vma->vm_start;
> +	mas->last =3D vma->vm_end - 1;
> +	mas_store_prealloc(mas, NULL);
> +}
> +
>  /*
>   * add a VMA into a process's mm_struct in the appropriate place in the =
list
>   * and tree and add to the address space's page tree also if not an anon=
ymous
> --- a/mm/mmap.c~mapletree-build-fix
> +++ a/mm/mmap.c
> @@ -475,7 +475,7 @@ static void __vma_link_file(struct vm_ar
>   *
>   * Note: the end address is inclusive in the maple tree.
>   */
> -inline void vma_mas_store(struct vm_area_struct *vma, struct ma_state *m=
as)
> +void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
>  {
>  	trace_vma_store(mas->tree, vma);
>  	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
> @@ -491,7 +491,7 @@ inline void vma_mas_store(struct vm_area
>   * been established and points to the correct location.
>   * Note: the end address is inclusive in the maple tree.
>   */
> -static inline void vma_mas_remove(struct vm_area_struct *vma, struct ma_=
state *mas)
> +void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
>  {
>  	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
>  	mas->index =3D vma->vm_start;
> --- a/include/linux/mm.h~mapletree-build-fix
> +++ a/include/linux/mm.h
> @@ -2669,6 +2669,9 @@ extern struct vm_area_struct *copy_vma(s
>  	bool *need_rmap_locks);
>  extern void exit_mmap(struct mm_struct *);
> =20
> +void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
> +void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
> +
>  static inline int check_data_rlimit(unsigned long rlim,
>  				    unsigned long new,
>  				    unsigned long start,
> _
> =
