Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0104467E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382860AbhLCTgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:36:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15904 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343888AbhLCTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:36:01 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3Hko2m020079;
        Fri, 3 Dec 2021 11:32:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=5EFbd8pxdDM1mUyTFJ1KvSOzU9wHtMdPWzW2g6j+7ww=;
 b=iMk5OGOFSiircb5AALnvTFx6rlyMyyjm/QxhzozsctC4jYrIYILtxDcXkOOXdjT5Ow2F
 vW0X0+9Urh3+Kg4z+ntVqlZWJEln07YVOy1KigJlcBSMTyduBqCYVQcjuoowpykNK6mP
 O9vU5wfJ56A1jUokLcJ1+OR092TSoW3F+m0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqnf01wh1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Dec 2021 11:32:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 11:32:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAFHF6b6mEWmZw9HDDfcNQHSAYylbK5Mn/uA68qecbl+SjBVyNKia34ZbzUoMW0kTLSM9xohxEsn6/tUiboNkkp+e6KEuuzTy1J6dLhkCLonQyl9+kQyIOQlyFyrkssyF0st6iR5sWJ9I842tZNXT8yJT9yAc5YdwidZ55D3YY1tXhgzAd87QTpfMrRy+kml/GdKzyVFgkRcnW62TiUmwmBqsG89MlnWDt6LJldbmjLk9sSEjf/6Vz8ert2KZaJwTiVtR/bRy5REtN2XYpIIx0CzRSuR28ptpXCBKdrAdAQ2Q+yJApwsMFkNgdguFagIzIOwwYuFUN7m+gOUHEqVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EFbd8pxdDM1mUyTFJ1KvSOzU9wHtMdPWzW2g6j+7ww=;
 b=SPUBO99/QeaaUNjIZSlrpffTlD86RoIkoRtvZjPzWk91mbYQhNvgjYDXL7A+Y4xv+KkuNAJGyxyFby3GODFyB5XI+e155SUSX4pM5TEzdikTyJ9HtCDlNw8m6p99hOEozx3y/uYfT+rjhxGvjPIzfCFl4tjae4nwpgmnBgKXtbie4BlncqLL/mlg9pZUM36M3yXuDSezI5iFvByDSVdn1YCBaJHYnWPmFtGQgmRYLPI24b4Yk1aXGXaPvqB5hSXTgoPaPzN6VFAAYFt1HAbvbXEH9k/O9otpGA/6l4gf6QleGSjXPRryeAeIe3QJIEhrugcB09JlnhTu3sd9TvIhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5297.namprd15.prod.outlook.com (2603:10b6:806:235::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 19:32:34 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%5]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 19:32:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Topic: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Index: AQHX6EczClIG2E5d9UOz/2n0HlwT/KwhKHqA
Date:   Fri, 3 Dec 2021 19:32:34 +0000
Message-ID: <CF175681-8101-43D1-ABDB-449E644BE986@fb.com>
References: <YaoXUrLUZt1scVb0@kernel.org>
In-Reply-To: <YaoXUrLUZt1scVb0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89025157-5a21-4d73-3cd8-08d9b693a7fc
x-ms-traffictypediagnostic: SA1PR15MB5297:
x-microsoft-antispam-prvs: <SA1PR15MB52976204FEA584FBF05FB4AFB36A9@SA1PR15MB5297.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QCi6sIyy09sA0y3cQ9/XUlGGzg8a79Nke7YBr9DTvYIdADNh3Qc0GESpYyTy1l3BALsDmOIBiDPxatXbgW5T3RC18KgZXNy6t4XDU3wmbV6hHA3G7uK+7H14504MvQOO5ZB4qqlZyxKVcwgA/56iKdAuCejWGwFsEdmLmP1CuxuT674ot/6YSlez9GESKsgUj21GTHENQ6TpKwZ5ahFk1tKj9+rTIa5+4e4i/EAEgCNDBWrhdroLr9MKHfzMT2R4+0JfF7t4u/pvJo/9oPiaVrfSYdaEihycZnCOp7TDje2DS825aHYDU0+1aodkXP+9ZH1h4XHsp3Cb3KR2Xp0Jjx6nZA31rRhKSgkW8baCr8y/PGioa/DRv1cfc0kTZjgrrZMuBXdnLUtZW2k7THZCvyE51aFHuYLgV5CXF9Ddn33gRI3xTdHTTf1Gx1t13V1dBArw30Zj6uBzfaLtV65sMnPxMogCUsXUsUS+In1rT+tnX5Alg3bA4Vtean/dkhgZeFCs/EIEFGitT5Z+fy095BuS95DRKTPPM0Zk3hGu3GCrxuH0SFOrfjRY/5t8/+II3LoCIyEoLayyWMzGMUwFjcUj5Fd0HkAJnq7FT4+Nqf5AyGXDikQtY/+UGbkdHep3ZxP4zXkfhGYtqCLa9Z3yjs0OmtVCNuafDP/wQ5jI+YzQd6+W0JezT6DGzkEbjWwnC5Yxy7nONrxcO25MpheTfT+PWrllx/BVqSu/GTzDtCs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(33656002)(5660300002)(54906003)(6916009)(6486002)(2616005)(8936002)(186003)(122000001)(508600001)(6506007)(2906002)(71200400001)(316002)(4326008)(38070700005)(91956017)(76116006)(66476007)(66556008)(6512007)(66946007)(66446008)(36756003)(38100700002)(64756008)(8676002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nquil+8qB7m5i14ZpNi3tEy5erAJpjWIs42x1FD9fUwm7LklMwGrJOC01IrV?=
 =?us-ascii?Q?97RlNqcJbXjsl2eIqJUiQBrIJ6d139zXDCTuKTPJ0tQSoS+byIkJzLuPmyfT?=
 =?us-ascii?Q?Oq2rfDlyOj2fyekV9L8XiqrbbuF+TcoEkqefnXL4j6USaYbnAYhEIwGPxXM/?=
 =?us-ascii?Q?jcPpiwovZkmCDGMMLys1pjjDuQ+3R3tCzc8lbKtji6VTZeB3srDp9M89w2Bi?=
 =?us-ascii?Q?YIee3dVLlFYwmvMGZ+03PjBtKfvo+irus7JRdkoWaBL7y+7HZ1K9qMLhWJ2h?=
 =?us-ascii?Q?/ZdhifHhWSkn7Lou+gt7dh/Rpu7t/pc24A8kdbu8AKWnKV8zvjeflTVEpeKV?=
 =?us-ascii?Q?vieeEUDEGodXoZsCQSREQ7869DfvRj/dCwDjQZN7lXKnmB9RZIWRYh2ehWbi?=
 =?us-ascii?Q?ePSHwwsjN7cr+qLjspCPedYFb5MEb1KlEhM++V3t/UpL53d8ExnN2/3RW7OA?=
 =?us-ascii?Q?phCC7uzzK2Ul4g1iwNwqfOrMr8rdrYbf8cKPl2klCyFU1RekxvsW2CW2GxVx?=
 =?us-ascii?Q?ojuCUx4tdlMyCt28LtesDqJGfBFRafyuVLpdyeis27WxHU3pqsq3Ca2+POI1?=
 =?us-ascii?Q?qtKWjxWa08lh8sIcswTVoPjJk/D9Srz+NuJNmJMWCLmdFVLXLNUErT0hcJPp?=
 =?us-ascii?Q?Ql4wYT4cOnvbasK2/CL+BmZ27UKifStiynlJAictQpZwIXMcD3yM5kgXKiAk?=
 =?us-ascii?Q?BbV5pnb6qrF4uI24pElVltvVfB84/mvOb5zWEQ6iOGxp5bp40RiF4flEImMD?=
 =?us-ascii?Q?Jy2wyntLqBKFyfVb0X290HqcL9hwSD0hugbUGfSFvmufBN7Y06XSVEG4Qf2S?=
 =?us-ascii?Q?Nu6ABh5AC5KL3/d9dABLNyq296QV/9TbXK8Gmq9D3SEV/097xja9Y4k65LYP?=
 =?us-ascii?Q?J7cmYI7AIT7RzH02XD4qdmxy8lqfH3d2sY8VPL5o4PWeFtjE/ztLWMqZmOHv?=
 =?us-ascii?Q?Xpm50LHl1tk0AGFYtdK6afT7WHATg8rBTWylahuYlgJfoEQFUzlQO5yNL5fX?=
 =?us-ascii?Q?MyMnf6qUtgI+VMfZTRvjdjx3JklA5BprENmoXXIaVIwclQuLfPdyDHVmW/sx?=
 =?us-ascii?Q?MHIunyW1W733/tXuzemNnkPUilHGfG5e1yLMhA1fUFRI5aTz2JLRHwK7ffmk?=
 =?us-ascii?Q?vwT8zNnejIr/xtqX8owRaqNW6uk1JtSNEBUqOQRp9u//cxt+nrQnMnsGnAun?=
 =?us-ascii?Q?W+z7NZ/RpnuCYHfIjT3cAD9l4i/fIiUeNdgg31YaZqnbLFf/oVYvpeuN+Gdv?=
 =?us-ascii?Q?VKiWMHyHgYCAZrxX3P9lB30EDsAYfibd6SZa2VrAlLAT4eEc6Bb0P8vheyvO?=
 =?us-ascii?Q?3UKDNaZz6dOy7LqioMwhucO4KP6nMKoZNoadCdsA6Hnp9ti5AyasrQmjxpoi?=
 =?us-ascii?Q?WuYWbBJSSI4GkxT5DDbgqq4GHDRnYybBsFRcGVRO6mkhaTw3zEX6QVNDN3QS?=
 =?us-ascii?Q?14OuzBaNeFU7dvkF4nS8Dt3O7wty2sCAGfMDeoeP4HbCfiKucx7oZw0IJxnV?=
 =?us-ascii?Q?Lmy+jWmmLE2zDsxUs9Sj/35vh+9zGE0Di/5ORslEsglycnwQGPVmLkBT5hcV?=
 =?us-ascii?Q?rUo8/DMdZZBhl+/oxrhIetdgbh5L0vClFkt5GzIE3YVBQQXu0TwePF1HrRSV?=
 =?us-ascii?Q?ZYYH/Cf12mAgWY7V/j+J/SotP5VkWTHbHKeGxF9F09peeGoJd4REP22yo1B0?=
 =?us-ascii?Q?xACoqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <629B7D02EB41AC409D0C0A68B79F0EBE@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89025157-5a21-4d73-3cd8-08d9b693a7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 19:32:34.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5daOWX0zxz/G/HnJb9aYLT6jiSN78rf1/REvEGBzvVKyuLl2yhtJKUBfxQSusxbV3DlC+YFcfWCJ6Dz6FacyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5297
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -qLpsM1CKFR5GPGdStK1kZ-LBy5752m-
X-Proofpoint-ORIG-GUID: -qLpsM1CKFR5GPGdStK1kZ-LBy5752m-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 mlxlogscore=879 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2021, at 5:10 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Hi Song,
> 
> 	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
> to then make this the default, so far older containers fail either
> because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
> env var to disable that in those containers and then there is this other
> case where clang is recent enough but:
> 
>    util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
>            __uint(map_flags, BPF_F_PRESERVE_ELEMS);
> 
> Because the system's /usr/include/linux/bpf.h doesn't have that
> BPF_F_PRESERVE_ELEMS enum entry.
> 
> These are enums to make them available via BTF, but then I can't use
> the:
> 
> #ifdef BPF_F_PRESERVE_ELEMS
> #define BPF_F_PRESERVE_ELEMS (1U << 11)
> #endif
> 
> approach.
> 
> But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
> 
> $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
> 	BPF_F_PRESERVE_ELEMS	= (1U << 11),
> $
> 
> so we need to switch to using it somehow, this way we can build in more
> systems and make bperf and other BPF enabled features.
> 
> From a quick look I couldn't find where to add
> $(sourcedir)/tools/include/uapi/ to the include path used to build
> util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?
> 
> Thanks,
> 
> - Arnaldo

I think the following should fix it

Thanks,
Song


diff --git i/tools/perf/util/bpf_skel/bperf_follower.bpf.c w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index b8fa3cb2da230..4a6acfde14937 100644
--- i/tools/perf/util/bpf_skel/bperf_follower.bpf.c
+++ w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
-#include <linux/bpf.h>
-#include <linux/perf_event.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bperf.h"
diff --git i/tools/perf/util/bpf_skel/bperf_leader.bpf.c w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
index 4f70d1459e86c..40d962b058634 100644
--- i/tools/perf/util/bpf_skel/bperf_leader.bpf.c
+++ w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
-#include <linux/bpf.h>
-#include <linux/perf_event.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bperf.h"
diff --git i/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c w/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
index ab12b4c4ece21..97037d3b3d9fa 100644
--- i/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
+++ w/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2020 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>


