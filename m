Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3770B4EA4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiC2BpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiC2BpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:45:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0727B0B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:43:32 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22SNeSDo003819
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:43:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=laeGHeI/g8z/DMakaj8nfdmSSuDCHKaw+vAN//OVW7A=;
 b=il817L7ii6bgT/sxGs6vPGeaFaWGVBvv23QV2dHybQC/jVviw0dilcIS/iV/1aaqExfV
 lU1GK97g3SA+3ztA9/haRCtWm8SIq5mOmugnQCGswC81exK2VYOnTofEKBk+dqwo6HGA
 iap/eqIGatoCRnwZFlB+49mVMeB6xEIh2jA= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f1yxtq2sb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgRuwWn+KdT97TwXjVI7dKH2DNwdrakKwHudE+ZDqq5f6MiDvqHCouqZi7UdYQdwL5CojICLpOaGaFRrmMI+ppt8ouHcVhxoIrygZswbB7YMPjZPb4BMaiuphx1x/hj3TmTMwsbnZzqE6BqA0VJQh6NbjKd/t8uNBoLzuZfuDodefMrhjP5wJJmlbcSg0T5DH9mJI9sTZUsDWH1ByM05HsK4tvzftrrDrd+gtl7ab6bHcFXYaSr2nguL3lPlwefpA0OPSiJrwJy3ZDMvtKuhx1Zhq3f+/hbwaiVB7l+6oMapK2wBwTmaD+7RtdHhlLgmv9RXNfjBaJMPtb51wZfFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKB5v4zTDAqfa6Dr/h/XNRBCv2jPh9pZXa85Vfp1O+w=;
 b=BcR9JqkrA+wQ+pmC3soa9tjYRBIQmSY615zvZ0c34DniBD/udF0+3tm3fNJZ5Ek5t02S/MY2rbFoJOK5SY8sG0dvV1sQLKzZtrFY89OqUBA09bf9ANJ5l8HRY80v4rHQoNABCcT54PvhnJhvekWoHCFKlfFOo4AeiH8mgKX5JTFhrEN3OiPfgTq03HcR97J3vGQ4t38cZIaJVghh7dqeOnVyPJco49f9Ix/rcT+BaeGWDzzv4IIdshKxQArPezwJozuoK42zbGsOBBN+wm481cU2MCzU2FXTw4EgZ96ZVqPHBanyrZjmXERDCXaZkSxLx0m1Zf/v4nccrhW4yIHYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SA0PR15MB3789.namprd15.prod.outlook.com (2603:10b6:806:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 01:43:30 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::19c8:a3f2:1fa6:e36e]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::19c8:a3f2:1fa6:e36e%5]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 01:43:30 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: lib/zstd/common/debug.h: zstd_deps.h is included more than once.
Thread-Topic: lib/zstd/common/debug.h: zstd_deps.h is included more than once.
Thread-Index: AQHYQWCSn77DE/3wx0iUlXnq7gQxdqzVmgaA
Date:   Tue, 29 Mar 2022 01:43:30 +0000
Message-ID: <6F25888B-F700-4DFD-A60F-7A542D2DFF5F@fb.com>
References: <202203270632.BdIMZ4Zs-lkp@intel.com>
In-Reply-To: <202203270632.BdIMZ4Zs-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ca93568-0488-4f74-a8e7-08da1125870d
x-ms-traffictypediagnostic: SA0PR15MB3789:EE_
x-microsoft-antispam-prvs: <SA0PR15MB3789F150C158724FC032CA17AB1E9@SA0PR15MB3789.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYOURzFlTMyYFEuVjwfu0xeSh7swPnlq8YsRCBbSdxT64asw4W10ACynTNzl4dM4843JoZiJaml82jVc5PUMpPJF6YQn7SCEWA3+R9QkMKutVUCl4doiAlh6LtFWxh8ZuG9Qzs3L86iDKjw9zQ1DDmND9R9zDL+Uv0vv67vm64QBlh/CJWIXRLf06KXIh95QknqPkxhgzkRuyRzkmjXT3mnS4JjB6BGUCH1FyjVWl9cL6dxjS646KWckNskLRkYWXSLKQ/pZc1T9jdX9ieunlXcKBZlvCgSnqtCadnoaXvt23sQ8L4r7G7u4+JpG57FaeuJnaCkmMdc3vrxF4MryXwlg+JOdvwhHY4BUrN9xWfQEe+9Z6gbvKI0rMtursqnW4qJb8WAdyv9AyeDnx9UdQ14B5zzCSRKGz8QK7qHvhoVrjcuh5V+NK3dGuAhkPgR474CMHlZmvxGpomaDGbDjGuVMwcRgLvuquKjZtwkNS3fY+C34JCytb3Dn/D9Vo6UQaYjK1o89IANK+TjD7VAezK1oy3RCQRs9zf+tt9Ms2JYl/aHWnv9j7vuWFhrLncgxFW7c+/X2xr1A5ypZlP6JQnnbWY+xvH9yIHmrdE0QL/42lc+QFtNBnelEW/bhXXkuSYPnUqBB0Vhzb4ymJaUO8xQeeguXvmnQOJJAObV+e/FrtrdODVIkuQ78kp/zOC0+HOQdK92cUWo6zwwUD2Co3HUyuAKFFCAar5ydgaXGN9dDd9h8Zsl+NyZzHalo8Y/8a9dAcf6sStxbbKElSBKho2kk9f+0EjOl1q9JS0lpNnRSX9jThzlPTPIprGKM6bqK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(6506007)(53546011)(6512007)(4326008)(36756003)(54906003)(186003)(508600001)(83380400001)(91956017)(66556008)(2616005)(64756008)(66446008)(66476007)(76116006)(66946007)(8676002)(38100700002)(8936002)(86362001)(4744005)(5660300002)(38070700005)(6486002)(966005)(2906002)(6916009)(33656002)(122000001)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VBhvOBGYns1cQPu6gs3PWmNob2ceQ8exx+1+GJ6CETac39qwJ0pJ19EcJzFL?=
 =?us-ascii?Q?kDcOThm0cDyKH4uIRneNh8A3onSOWxKa88h44hbFVLSCHgCGDhnXCqbKJU//?=
 =?us-ascii?Q?BVVJaAZPLf6BCJRdQbgaMjm+7k500YSn+U5X3vasBlVHyOgxjlQCn35QSL4r?=
 =?us-ascii?Q?GTdBr2OHNLdphT3Z/pS0pUk3TbHI7vRDCBRRCUYbrwCUeK/hbWbicC5Zfp08?=
 =?us-ascii?Q?loBC2GzZzeKOI0Svkez4ryuoYWiFl6lPls/wmDtW1HVcqChE2x59Q/XDb3ht?=
 =?us-ascii?Q?PyyoyruetzYA4BokHmglB9LLMwjnJoS66J5ytCYYrAgSAWP1BN/mtR5Kht4P?=
 =?us-ascii?Q?a/mR24hRt/OxcpPJu8Z7BD/WJxZCjNYYJGDmTa6fblDHj/gIvxvvfI7gp1Is?=
 =?us-ascii?Q?G6lxnby67tUarj1Hgp/RzZDwyk+85aS/SMxUZ03w+O/r66OsQ4gY70u5EzkC?=
 =?us-ascii?Q?TEKQzdsozz2P0k9bJWCtita8gwQJ7A0DHvg+nL35nOG0beNYXT1faBUONybI?=
 =?us-ascii?Q?ORfOhG5/2YdRdiId1xPdT4wIG2HfRDUGQoDUHUT/Ag32Tm7C6Vjku1tnk6AI?=
 =?us-ascii?Q?nBqhCyunzP46AprDEhU0lj27xCoXORpXn4MUkUzjiN3qIsI7fpdC+7vkAgs9?=
 =?us-ascii?Q?wh9PKUE0ksPyRlzEazoBbaxcl8NyJPJHmy6h1JIkR/dIoBWMCbx8U4QzlO8x?=
 =?us-ascii?Q?H84zmtEgwJkH3wq+BY1358Pk395yaQ8b0EuQi42Wiw14Yu/jB7xqnepjV+Ky?=
 =?us-ascii?Q?BXVvxcJgspnpjdVhOrH7eFAhZ/7msDn5fEKEW+1C30kyZhu7hBH3fr6PdyCR?=
 =?us-ascii?Q?c39wPN4MoWXZ1gwKaWApOfj0kWNLQ1k3OF/nLGoJJFzXt37SPfmiMprt2qzI?=
 =?us-ascii?Q?Losa+Iughr3NTJZXakJPnrjJKSmzFcebGk29c3erD1NQB+cfFAPFoONMzykW?=
 =?us-ascii?Q?PYXrlxJLQCKqRWcxGRzfgWzBUvfIex2pPfzEvCG35rIioV9LqEdmFinsTn1Y?=
 =?us-ascii?Q?iXoz2j2TYUcWWj5zkgp4x/fq+OmwZV/KZtfSJvVqNAWa0JPmsEuM1OkBt+tc?=
 =?us-ascii?Q?Hdci64AHSaRkjIKkTumdKbc/G22KX2ry1ytrJv8vtHI6OGBDD8za0FLc+E0E?=
 =?us-ascii?Q?GHxiu9X73UDWlmKBt7Avv21g1T0NJvdH+mmHXnanvaS8puDSpEjlRSXV9Awi?=
 =?us-ascii?Q?cMv7A777XDa4ZvSizni3YNETndEeOdI2TzFLnya/iO0d7RCu1VWqVb6Ozpsa?=
 =?us-ascii?Q?LZFMXn2adkem33+G1bvsnqPtNFTjyT4teD0/v+sur3xzG0gwv7T36t0I2Oit?=
 =?us-ascii?Q?OWGnFNW2ztRVZGCZ9XwdgbM0wWy6dLS/x/L1ZVwwcMrb7Dq3e7pAlQzSe/PY?=
 =?us-ascii?Q?Aq47uq9PyIYbZDqup1OmQccZI38jYdY2CwMwGBUjIkmDhd92lFHxaJ1bfnw7?=
 =?us-ascii?Q?q5NX+DHrXSxBgTVlWqlSDTjrgqquF4pOFTt3Eiq7zXmdLy/V9BwIV//eHfKh?=
 =?us-ascii?Q?JcMQEr2wZ3IkZUypSfbnGp90D+PdOBQlvHAcu3pNBfXtqRsTCdWaJwYhsd+B?=
 =?us-ascii?Q?t831B0uDBJjodYQrKp272/93bG14heVfh/XTCSE7ixsJtFutRT7hhqP4hxSB?=
 =?us-ascii?Q?deEi1716QNeEt5/de25MDIOX/qz3LgfuKZQPd0eFIR4hgqtdfUOZuEIQJ6Kn?=
 =?us-ascii?Q?c4GNTrZeEtoSE63A1VmakPL+Zc0DCU6PbKxV+OJzcEvlB3F20kfhN/OB6emG?=
 =?us-ascii?Q?KrHVDIj9ndv4APNJWiLesN3Asw7S6SGJVWX4STNEkPjvh/9M0uxg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06B4E9D56889BD4F9C3049DBD3753311@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca93568-0488-4f74-a8e7-08da1125870d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 01:43:30.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVflNnh5ZDtrNilmys+p80uR7dI5LRy31Tx7NNIMpmExnPMKQaIa103o175Gzvag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3789
X-Proofpoint-GUID: CY-guOjifWfft_19F5Rs6dfqJpbjeM5A
X-Proofpoint-ORIG-GUID: CY-guOjifWfft_19F5Rs6dfqJpbjeM5A
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_11,2022-03-28_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 26, 2022, at 3:26 PM, kernel test robot <lkp@intel.com> wrote:
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   710f5d627a98e86f821aceb840b8f2f1fcc6cf75
> commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
> date:   5 months ago
> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> includecheck warnings: (new ones prefixed by >>)
>>> lib/zstd/common/debug.h: zstd_deps.h is included more than once.

This is intentional, and working as expected.

Best,
Nick Terrell

> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp 

