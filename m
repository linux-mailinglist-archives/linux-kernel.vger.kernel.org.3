Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4701A466EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377931AbhLCAwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:52:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377798AbhLCAwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:52:47 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2NlILW029286;
        Thu, 2 Dec 2021 16:49:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ol2kAdDvSnkVhCCfQ7nX9QrEdWXLW1s6kNYpwokefQ0=;
 b=MRZsBoEWnMUz4FFPmbqYJnNKKj4edfoaTgG7+xCsy9wb3mw0z0rjpG+e2YUwKxCLmDPB
 1BrjPtmgcZrQ4ECZd2GX7qVS/Gj71P4xJ/FY7r9bJ+0sX0eVl14wD/6laEhKVUmgxVlz
 +yipIBgZAGV7MYpcjFXdZ+rNGHvZbLetU70= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cpt15wj6d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Dec 2021 16:49:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 16:49:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4xVN5BDd/W/xL0RyYOXamZFpxkJ6OCykSpVaRUlzPPNKenc5hpmCIjWQO/3dh8SdQZtOrLnn6MRxue7lqW5obrRBQfMzTxkv1LHfXxjgidsjvjNDgXMX4p8bDWlBoghKVPGRRvyVF0dr510gbtA52YaY8pG8XnpfV3kdNJ6lpBh+BhjCZTiFmPmSjIV6qqUMVYChF+bxZf6uSFktOSijrWIFv9jT1H3Hax0IxuyiJS7URnfqMdUpyyXwjWKSQQ9gG7aYIeLjpZzfSdjMTzvvgzdIJ0wC3dCrxlo1XjpOcCUZvVfuRiNpgDPihIoBcwj1qx8X2OjNdYoRzIpJe4D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol2kAdDvSnkVhCCfQ7nX9QrEdWXLW1s6kNYpwokefQ0=;
 b=dqi1aZr+RUjCQa/GWD1zfur6L+xofepCTZlfxCV5tjHeH/FYpP/TjRhbrf/BC9fm2aKq5M31Ibx55sGtnNAVeEMpTAQKvNeZ1fhiYiSsxjPis9sM30TJmxkuZZ0RU/lyGv4bgq6UCPu21qrZ47laUziZnCXqfe2TScHq2d3SjRrutErRvtifyjtT33YT6W14HAfFWKEcpiRnsMlltkyekV8b8VukVvx/WwqECBtJKmH9loEPY3/0rwvtPB3uyeiSkv40S0T2iC12i1seqnuGrQtkZXb0lre817W9lSaZlpNdMMBMTgpThRGtFNQuOVinI7xZCjHwmgOUyelYEuGhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB3095.namprd15.prod.outlook.com (2603:10b6:a03:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 00:49:15 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 00:49:15 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
CC:     Michael Forney <forney@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Sedat Dilek" <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] kbuild: pass --stream-size --no-content-size to
 zstd
Thread-Topic: [PATCH v2 2/2] kbuild: pass --stream-size --no-content-size to
 zstd
Thread-Index: AQHX4UhKidKPr3kbgE2o2YP10PuuiKwf/KCA
Date:   Fri, 3 Dec 2021 00:49:15 +0000
Message-ID: <A5D1EDEE-8979-43A1-B36C-9216602150EA@fb.com>
References: <20211124153105.155739-1-alex_y_xu@yahoo.ca>
 <20211124153105.155739-2-alex_y_xu@yahoo.ca>
In-Reply-To: <20211124153105.155739-2-alex_y_xu@yahoo.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb7be305-9c59-4c24-2d5e-08d9b5f6bb42
x-ms-traffictypediagnostic: BYAPR15MB3095:
x-microsoft-antispam-prvs: <BYAPR15MB3095E2B67A15CC89867EBCA2AB6A9@BYAPR15MB3095.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VulVMFQfZokRBRUZ/5QuSrdznxWex/42uXXA6rkcEL19LSZLsslQESJ3Z27OJ4zxYz8SjLcrYfXdDJTTXu+7YPtVK2Tc/nEnkgNqD4ZEucamCZ6SA6m2lWyvKpZs0631IBMqB+CuporGkWJXomjddGH/G34hbBbCoXtx/JTMecMklLrt9ZoQHtE9l+uZ7jkJnt+57B6eeLuPqjptGlAjzBKhVPimsWXACJijESwrfsqwua/Xr263oVIYUt/Q5ti02+VoBjp/fZ3mMhQA6dcOihLOxgw8sRWVPz94wecNOfKPiy31wlyra8f7g80TL8+wQ45+A5gUDalk2Kv3iR2soSd1i4bD+GlUU4scrl03SBQp12FqeFGsemRb4W1z9zybRydxZNLgUiWg8ZnYL58y89k7WNHukznHrjE8DqNGaTuZGmqWQciL242i5UyRwNyhFWpQHPSqMk6z1G31w4LGgYr4svYvZs5C9k68mfy56fJDg4aDb/Q0txY9b5DPKihwQFFkru35v9UH3rpyucoZecoWmOsJjOraZeknynZ8SWLkFx5yWJkgVVwD36AvDK80LkvRnx/0+WUnL6hAyRM1UZWaWQH2ic4Wm1R896qwpBsNV8cJNcRpKFdG5PMkt9LYR8XJK3XgGZYNYpGAq4a8YpIf3vv5jcmc6253Cg038nnVqP9QYma6LylQ0ukBONTkmi1/DnyVIyW6mB2yLIO50Vs7K2EXLw7KII/363W9o5RrStLFf8ld2o00YGwvxwxB2buUV//yIHW07ILfzUJWfYpZNvSdfiia2FUGgp/l5yxET/dA/FaYvFE1HY5TXbN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(83380400001)(53546011)(966005)(71200400001)(316002)(7416002)(6506007)(38100700002)(508600001)(33656002)(5660300002)(186003)(66476007)(66556008)(91956017)(36756003)(122000001)(2906002)(66946007)(8676002)(86362001)(6916009)(6512007)(66446008)(76116006)(6486002)(8936002)(2616005)(38070700005)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ykketfHj9kKDZgQIzO12gGejCPKeDJxggcisZYOuiKicPQBfJhq+Jy2UsfcK?=
 =?us-ascii?Q?U5OoThKMHDDJc4fiYFrKENABcVukzV/pBzw4rkpsw1dwaNx+O0vu8fBwkyWf?=
 =?us-ascii?Q?XSoalV2mpm+Od/BOB4rllpyg4HjNWjwXJyXEEb3NX4OO9nQ+8j7BVmv0uNIO?=
 =?us-ascii?Q?ax8LL8kEcfBcoCL7PqQJ6mE0smPaVpXzKiFP+EfW0HxJ15oOAytY5bxJCDIB?=
 =?us-ascii?Q?VG4SKvteYnezF1I6gNc+INXclcqTOM2MAAlDMOy9ZSnFQGWw85fN47DrBSvF?=
 =?us-ascii?Q?1tDhR/mDyHJ1SojnWfVkNl8dOGuU+hJOjohNDi7JFuGGzlbr4qN/ch8bRKG5?=
 =?us-ascii?Q?thoCwjcJ1GkJ1k2AdF8n7ijVp8NpQbvTMSEiaIoWzm6zT9exZTFli7dP6D9x?=
 =?us-ascii?Q?T3RO5LcRKxw96PWMgfLczjVIt8o+XOHovnw5xDPmCxDN1yTmnCXR4SH3POSN?=
 =?us-ascii?Q?1ktHMXkZFNkhOr4g4tk6qqDJKV0ciW2TrabkusMHoIOhQBcOdOmOcRwCWWpk?=
 =?us-ascii?Q?bjXkUT/3Y29KsZUf5PjwQJlOTlglLq4V9Ig621F0/xPyIjWl7PE29r6v47qn?=
 =?us-ascii?Q?Bh9H35IHT3o5tC4IQNW+QacpdxFYKmKxLT19c5hxd+noHHZSKUPnv+ZidXK6?=
 =?us-ascii?Q?OXOTo+lINFITDUeO8Mu2zw2gjvTrh7AHAkttErmpELNcbdO7A+6MowsQg2dh?=
 =?us-ascii?Q?pS3ot+wswecHdZVOszVUyb9iT2g+n9BkihaWFtH1aDIiP/Vs3ag3xXRgKYSA?=
 =?us-ascii?Q?lufmsLa7y/dYhyv1ounEX4Wtd6z2JZ7VY8nQi40TW5TAA4sDcgucpmDKQQpv?=
 =?us-ascii?Q?4KL780scHNFdIQqn8vCU/XQ3KyYglezXO56TSE5bUFUsI6xNNKz8tUrk0UyC?=
 =?us-ascii?Q?lniuUwVA1nDNS/N9bjpI8SIKs+nuHCYNdSbyAA485FQaLwLCxq6Ou56TT//T?=
 =?us-ascii?Q?B+zm7rvlLCOQBwAeCiXb8swRal1rLuwvx0VUtCnLrvgXKxL/FghP4P6eqvYA?=
 =?us-ascii?Q?Ms+KTqXQI/rqqfmxMCdf9nj2ts97kEGOP+37wsxhBawGuCWN55ukNU2QLn1O?=
 =?us-ascii?Q?JLCQBjoUtDrMdOoPISvUl37R3MSfE7H+H/40e6B6BnjLDfrzWOM3r9NkJC7B?=
 =?us-ascii?Q?3bzDOwZAII7aQRljEyPXITfSD6xRRw7Q82+Qsa7a0JqgbAM1oGvUT1Tn3Ruu?=
 =?us-ascii?Q?b47jnjeK0tQEZOAJENoo3vl3r7cxgxLGARFMgI26wlqdZMRZsZadzCMkYsX6?=
 =?us-ascii?Q?TjNya9k5QfwnuhwPFJu9cU0tnh+l4uZnzDhZXra0FGAPEG5sUrM0UM2tIGuS?=
 =?us-ascii?Q?ZE16q1WEAQtF4C36SPsrMICsltu4NjmEOK/un6B0pOM7w6SPBBX8PFJorZOq?=
 =?us-ascii?Q?qV+oPlbAZ/T5ZgomT4Diip5TNkYQEe3VY8+QXoGZv12C65TQRmdXqplzgDHh?=
 =?us-ascii?Q?+X7hhEt12xYn1hLkkMLAuc0JF+R2BUVZ8JWzZG4oe91HzStYUbVUSwhv2PvP?=
 =?us-ascii?Q?BddXEfSwtoUE5uUTdbniStrBs5WoyLYaH0UgijxtbWfYxkVccdLo8CmJhDjY?=
 =?us-ascii?Q?ICplCZEaAQkk9mhfmJmNf798W2gHXqWu1llS8GzLAn1yQU7TVrf1LQ4MbD2B?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <127822EA6563EB4F92020D35FEC15355@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7be305-9c59-4c24-2d5e-08d9b5f6bb42
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 00:49:15.7474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rRbdAqoj4Al3wUrQ+BA7MFV3oqO2IETjrB4p4w0z5A1WzfjC1u1o5e70G2IBaEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3095
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hptTKVYwZcD1nxZnPMxpK8rjHaUt9QW0
X-Proofpoint-GUID: hptTKVYwZcD1nxZnPMxpK8rjHaUt9QW0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_16,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2021, at 7:31 AM, Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> 
> Otherwise, it allocates 2 GB of memory at once. Even though the majority
> of this memory is never touched, the default heuristic overcommit
> refuses this request if less than 2 GB of RAM+swap is currently
> available. This results in "zstd: error 11 : Allocation error : not
> enough memory" and the kernel failing to build.
> 
> When the size is specified, zstd will reduce the memory request
> appropriately. For typical kernel sizes of ~32 MB, the largest mmap
> request will be reduced to 512 MB, which will succeed on all but the
> smallest devices.
> 
> For inputs around this size, --stream-size --no-content-size may
> slightly decrease the compressed size, or slightly increase it:
> https://github.com/facebook/zstd/issues/2848.
> 
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---
> scripts/Makefile.lib | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index ca901814986a..c98a82ca38e6 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -466,12 +466,20 @@ quiet_cmd_xzmisc = XZMISC  $@
> # single pass, so zstd doesn't need to allocate a window buffer. When streaming
> # decompression is used, like initramfs decompression, zstd22 should likely not
> # be used because it would require zstd to allocate a 128 MB buffer.
> +#
> +# --stream-size to reduce zstd memory usage (otherwise zstd -22 --ultra
> +# allocates, but does not use, 2 GB) and potentially improve compression.
> +#
> +# --no-content-size to save three bytes which we do not use (we use size_append).
> +
> +# zstd --stream-size is only supported since 1.4.4
> +zstd_stream_size = $(shell $(ZSTD) -1c --stream-size=0 --no-content-size </dev/null >/dev/null 2>&1 && printf '%s' '--stream-size=$(total_size) --no-content-size')
> 
> quiet_cmd_zstd = ZSTD    $@
> -      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) -19; $(size_append); } > $@
> +      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -19; $(size_append); } > $@
> 
> quiet_cmd_zstd22 = ZSTD22  $@
> -      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
> +      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -22 --ultra; $(size_append); } > $@
> 
> # ASM offsets
> # ---------------------------------------------------------------------------
> -- 
> 2.34.0
> 

You can add:

Tested-by: Nick Terrell <terrelln@fb.com>
Reviewed-by: Nick Terrell <terrelln@fb.com>

Best,
Nick Terrell
