Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB64859EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbiAEUT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:19:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19384 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243950AbiAEUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:19:17 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2059kZdv030082;
        Wed, 5 Jan 2022 12:19:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=YaY3aXl6ekLxR/1BVdPwvrqiv2MQjuuA6buPrmv97WQ=;
 b=pSxKdZIojpVl+8WBNLCz1Ten80ynzoToZ0/znd/90wpfNT3Ehcq6kGS7D1PQMzz3kTrJ
 XgLrHMOtRAul/6SNVklpU9+gFEHCFi67CFagQ9glVcWE7TZGVe8COdCflS7MOjhW1qY8
 wn5bOY2WzEFDfnW5VtL+6oqt9ktYlJQY0FU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dd15ndewg-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jan 2022 12:19:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 12:18:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp4NVtsszk4dTRLW5OkDxYJUqcP1u8gbohtvFPNbGvbHKN6aYj4i9CfznBvEtBrEktAsoKWpNTXDT0jwI6kL45/5PumjKLNl0z5Sgh6bgVB3Nh+cdxhY8VXyYbfmabqB9QkHQ+99YuO2cwLtzAj3xifwDzvQn/JbL+iaQQh6BUhkHfS8AXZiuEwO9CoeofZ+/QdffV0F3ZB/juKHfSejCKft9xLKxtnpfm3e1+26mBbfhzLel0KCIyCr4winY3JOX0/6xUUws6nICeUdaIi53mAADXdxT9eBQZEkCkCyig6QP91IPgWiiHQ9ZJFfyG0TuaFGQLTjEtMQd1urGC2OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN7kkhk75HtZdlJofKGRj8RY7GvsbMBod0kdNouYClg=;
 b=US3D7U58EwSRcDMpfb3lfObiRz4vM7/NBvVDLZml/+FBXoyiA4O7aeE689FLoXFv9co2hP3sU4D7KcyGY+JMrCcSzo2lOFc/oqaXwwGidY+X8Xd6QfphjhR6BTzmo3OM82HbXWvQif/Dq9lyl/H2TMEg4iUN9fK04zU3smsyxEepuxNVAeKXmxlyOIHkmQduYIBeTPHYX5J+kpb4sDUYWUzydoJ1AQh8fIEGz4v28G16Ur97WVfq2A7k2QfLs154wjIdrxRbRlRF9dl0oupKPiOLYYxsPjLjTIisIbAMfL4+6yiugyAPlBNFT3dB7MjPJXdt0KohvIMq6mz8z5OB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CH2PR15MB3672.namprd15.prod.outlook.com (2603:10b6:610:5::14)
 by CH2PR15MB4310.namprd15.prod.outlook.com (2603:10b6:610:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 20:18:27 +0000
Received: from CH2PR15MB3672.namprd15.prod.outlook.com
 ([fe80::1514:b3bb:7b18:571e]) by CH2PR15MB3672.namprd15.prod.outlook.com
 ([fe80::1514:b3bb:7b18:571e%3]) with mapi id 15.20.4844.017; Wed, 5 Jan 2022
 20:18:27 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined
 reference to `__clzdi2'
Thread-Topic: decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined
 reference to `__clzdi2'
Thread-Index: AQHYAmcabTSWH66kA0Sr/lR5EN3QMqxU3fwA
Date:   Wed, 5 Jan 2022 20:18:27 +0000
Message-ID: <AAD37797-0EC4-47FC-939E-F855F2E9954C@fb.com>
References: <202201060233.mO6P39bM-lkp@intel.com>
In-Reply-To: <202201060233.mO6P39bM-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efff61b6-d627-4d34-6109-08d9d08888a3
x-ms-traffictypediagnostic: CH2PR15MB4310:EE_
x-microsoft-antispam-prvs: <CH2PR15MB43105B870C662BDB95657D78AB4B9@CH2PR15MB4310.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3Y/s+IFL+7v9G+TxBAxz64kT9rdDeQYMPTvpN8UvDTLpwg+pfFjzj1Md8SzY31W7B+j7QDK7WPrWa3T7II1V43DHgzKWxny8ZYbT4ox0bBA1cj4ODNfN7weTTms3dafrpYu5YXb8wqEF8NQ2C7a6Z7Bn/uQqxHcqv9fwWdjmNJ1/APmFhLHZk0mf10QJ2iYIOpgRb00C7sxA1RrU9SI3Ih6RpuSAcFHB657lXjPjgTB23Rk3LD0Zde1YzakSJ4Ogq/0PZMfITFTq/bR42uvUJeE660YfK6dJ0De2b1AodJAS5kQ1pm+d8vAYaGE+WQwNmB9IrF3C0ijWVlapX4ufmkqCHW92zi6HT9K22WKAAdpmZ0QQALFmicFOVe6YG5kLtQK2hsB5JeWhJGMkThsuZVaOLcDLy0R2FKZ4pW41f0dLJ2z53TB4nz2FHTlyBXQLJFV117HiSbce+8cs4+vbV19zhmUDR9iZBBZhY7uEB71XubA+XUKSu1KuDejF4x8xFgOsAvAIKlTvrj63odwu1PveedFlEJG15SI1LYbKVd0JWgdGk0I81Ztdly/uUIE8BKruvWpGwmEjIKKJj/Jr8Js1SyxUyXafCI962M3ay6CkFctXyIjvfyVcarTfNsrmXaJIvqy8eieJyBEzfyo9aEjTtONr6ZW3dhAjt0TJvBlEMijYm55sWQHx6q8OFcYkj/5ExERyKPQr6K6cfmxl3ikSQbypnaAoDFEZXWlzBr9X43VZ7wISHhdPjumiQkQUHnhWoHC63l4MKOiqzEOZ65XWkJkNFPyXbOdJYYEY8R+/b1klX3UrpRX5E0k9gTO9bljGQFqCwQYYVhNSHWJBBzg5XAbPpv+vxeQuJ+W8Rc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3672.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(6512007)(6506007)(6916009)(66446008)(76116006)(316002)(53546011)(2616005)(83380400001)(186003)(36756003)(5660300002)(2906002)(64756008)(86362001)(6486002)(54906003)(4326008)(66556008)(71200400001)(966005)(91956017)(66946007)(38100700002)(33656002)(38070700005)(8676002)(8936002)(508600001)(66476007)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qeXsXkmmzUkwUyVDY4rooGnm3AF8VHTp9wBCYXsLBvkDErDAbnIxT5XAVl3L?=
 =?us-ascii?Q?QYQDhnC0zMdK4D7CZQYGIoVdpk/GgRphxro7/p8eMAnywlEQpZA8xfxi41Jw?=
 =?us-ascii?Q?4w15OJGmlqLYHYL9FFuxbZCkzN49/hsjCt/PqOKfooAX75WIkEsiaIWsdPpH?=
 =?us-ascii?Q?Fi5d2udNRS94XvgDFtvuB2UB5bucXDoNPoWRIDMtR/STya9TSVHmUl+HON+/?=
 =?us-ascii?Q?rFFFV0+Fq6bTAsVuFvhRpyv/xkNN4j3Qe9UBYzpYfTW4Ts4/QqO+BwPUyX2B?=
 =?us-ascii?Q?LbPwaWHkDuWb8rXJ667qbB0Y4jJmLZKqLlJcmZV1TCL68d4ff27726Jbv7Xa?=
 =?us-ascii?Q?v4MJ4+5Cj3/l+KXOi+DSQm6fRpJV6c03+KW+mB0lV2WWb1Usd7AR31gjXgWB?=
 =?us-ascii?Q?qPCoPFPnGd0AtzA/rugjtNfrWyBRjHJSq71apxoh1F7emrSGfav/yOsHjNuk?=
 =?us-ascii?Q?sNN0plka+M09GYlH36hS6n6buBOFFICZaN2vkyIpCgp1fZBHEmrF0Q5pDyIW?=
 =?us-ascii?Q?ygZJRAa2pFJRaDhhyfwETcmrwVtfVghsPX17Or3waKBOpxSonaD6buDn+dRz?=
 =?us-ascii?Q?wK5N6qwGoILY2VmgiF5dm71tsLID3bPRVIz2ixEPb5y3HsR3d61WK4e58I6r?=
 =?us-ascii?Q?zb0rmOgLUI9tejQhcLsa/F25kjNKDXbEEg8JRPWo4Vu3W6ybOIBNay+dfZgT?=
 =?us-ascii?Q?WOxpQYevP4ggmAk1FycUSMlMbPNVIzrCVpJAXTgLZZlD1i6HKIhWZcsSdDeA?=
 =?us-ascii?Q?6IE+EgUTeHSCKuNC4IYswwn86Wh0BWNxXXzuEkv3mXCy54tDWQq+dC/Mdcu9?=
 =?us-ascii?Q?smTgq+WKorn2T832PSNDZDL2VPwEkzPPbEchIS6X8iYngRGu7Enh1t8EjBJO?=
 =?us-ascii?Q?Sr3JUPbAmZpUbZaPszuqF8ooDBf1y1zMXD9ArmGtWnETKLgS8kmk10wrz96Y?=
 =?us-ascii?Q?uq1gooZS89uCiF5WN9SH9EKwEwfrK0c+EcwlqiU8+mLb8hnM69ESgYlofFEw?=
 =?us-ascii?Q?Vq2t84LxY8pwsUyObnpu7TX5upp7hgx6Ad4KiGHMcdGTae0gOK2HvZDTzfYR?=
 =?us-ascii?Q?O999gnGHf/1TN+QhzB+EJ2OknXsZFjpmuOK79+mFDQrs489BRa/HLhHbSAqh?=
 =?us-ascii?Q?FCc8pFuFNphWqRw4WtNI1BPDvpPuBDvAxQCHg5lDQ7XTjD0l0ZigrgaCHD4o?=
 =?us-ascii?Q?Zjly3f1ImYasW4FoyM6+idi0eEKRz3jbliF94Dfwd6aNZ4ggRt/oSd5bcRCF?=
 =?us-ascii?Q?VJyqVlckuSwz9glFCUZcOOKODCdkwobYjrvbjvBKid4mbtQk30tlNgIwtAFj?=
 =?us-ascii?Q?j7Uce1B/kVrubNHD5PNaoWL2D3w2m4WlV/6sgu2cxC9Vouz4nJpEdh85ag8T?=
 =?us-ascii?Q?y8o2R1gYH7B7zYOEito/q3eHQ9iB63MEvJgH96n10WFvFoIO550A9VgHuNdy?=
 =?us-ascii?Q?Eo/SU2KNsYXO2DoCnkrAFPFqezBZSaxF848QC6wBMt9Pz01PXnNnUjs3DZWe?=
 =?us-ascii?Q?uCrM+0C2ERTgwDNg2qG4uTQJOv/kkkwxX3oFNVEidamhDq8GZ+U3ANoK+1GC?=
 =?us-ascii?Q?75Ys13ttSq7xRe6q5co=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F35DFBB925630743BCA60E1B4763B66F@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3672.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efff61b6-d627-4d34-6109-08d9d08888a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 20:18:27.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWt5LwI6rF+jnn13ucc9rKyCPkggOPh8CviAdk0NrZQ0RVkKlhAu70keirR8u1F6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB4310
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: N89jbv7V9JjH59IFTxMuF5u6iiYoySBl
X-Proofpoint-GUID: N89jbv7V9JjH59IFTxMuF5u6iiYoySBl
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_06,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 spamscore=0 clxscore=1011 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201050131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 5, 2022, at 11:02 AM, kernel test robot <lkp@intel.com> wrote:
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
> commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
> date:   8 weeks ago
> config: mips-randconfig-r025-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060233.mO6P39bM-lkp@intel.com/config )
> compiler: mips64el-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
>        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>        git fetch --no-tags linus master
>        git checkout e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
>        # save the config file to linux build tree
>        mkdir build_dir
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `FSE_buildDTable_internal':
>>> decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined reference to `__clzdi2'
>   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `BIT_initDStream':
>   decompress.c:(.text.BIT_initDStream+0x7c): undefined reference to `__clzdi2'
>   mips64el-linux-ld: decompress.c:(.text.BIT_initDStream+0x158): undefined reference to `__clzdi2'
>   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `ZSTD_buildFSETable_body_default.constprop.0':
>>> decompress.c:(.text.ZSTD_buildFSETable_body_default.constprop.0+0x2a8): undefined reference to `__clzdi2'
>   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `FSE_readNCount_body_default':
>>> decompress.c:(.text.FSE_readNCount_body_default+0x130): undefined reference to `__ctzdi2'
>>> mips64el-linux-ld: decompress.c:(.text.FSE_readNCount_body_default+0x1a4): undefined reference to `__ctzdi2'
>>> mips64el-linux-ld: decompress.c:(.text.FSE_readNCount_body_default+0x2e4): undefined reference to `__clzdi2'
>   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `HUF_readStats_body_default':
>>> decompress.c:(.text.HUF_readStats_body_default+0x184): undefined reference to `__clzdi2'
>>> mips64el-linux-ld: decompress.c:(.text.HUF_readStats_body_default+0x1b4): undefined reference to `__clzdi2'
>   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `ZSTD_DCtx_getParameter':
>>> decompress.c:(.text.ZSTD_DCtx_getParameter+0x60): undefined reference to `__clzdi2'

These are complaining about usage of __builtin_c{l,t}z(). The code before this change also used
__builtin_clz(), so this isn't new. E.g. the call in BIT_initDStream() is present before the change,
it just moved locations. So these errors aren't new.

This is breaking the MIPS boot code when zstd compressed kernels are enabled, and was
Introduced in commit a510b61613 [0][1]. The fix is to include the definitions from `lib/clz_ctz.c` [2].
The same problem was fixed for s390 in this patch [3].

CC: Paul Cercueil

Best,
Nick Terrell

[0] https://lore.kernel.org/lkml/20200901142651.1165237-3-paul@crapouillou.net/
[1] https://github.com/torvalds/linux/commit/a510b616131f85215ba156ed67e5ed1c0701f80f
[2] https://github.com/torvalds/linux/blob/master/lib/clz_ctz.c
[3] https://lore.kernel.org/all/patch-1.thread-f0f589.git-f0f58936888f.your-ad-here.call-01627564869-ext-2765@work.hours/

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

