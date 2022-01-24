Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C0C49A6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3422371AbiAYCbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:31:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356367AbiAXUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:18:30 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OHW9w6007654
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:18:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=1W89byoUA/iERbHyrC3/UGbstopC9l9VpPyyEpU5k4Y=;
 b=G0xRSUJ682O2SUEUVB+ijuGS7DtLhbqsrCw6gWxVHfuB6ZGhsYVAsvlUsMPM01R505lG
 9S8eJCh8H9lCpiK0xCxc1D7DbYAOpNK45rSodAXmobaNgt+Ekf/3/vTxksmOJhWhHfiT
 npN6u9lTDmrWn8kcYP4z53tj59ljZRMVHGU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dsqgn4r8w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:18:29 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 12:18:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BigaQHAZaU6QsunPM33AcMf9xHmE8FhaH6Al0aTXELGLUUi61Gu0YuYnRJBzlFiRFoRzw0zONdmoNkYC0IxlPikwy6S/9EP+ZVhLJ++v6cCIbRliY/7zlp9a2BMobfAF3aIiymNfGySGpa6gfa/TZrpyuZK8mMRWQm66GXWxVfj9MT0D3mte3CQCmYrlvi7Rr5xCqEMcCM590xQbfLefRQzbdQGb7rmhkXpnoLK89+bskyh56kNNONPvTaZbLYpYK/Us2Lh+1j06G0nl1nH8qs+jdVvsUpCYN39zfi2pHFMEZnsAhGH9KFsUPHhITaL/U2y+FtO0BwssiNiaOi3+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W89byoUA/iERbHyrC3/UGbstopC9l9VpPyyEpU5k4Y=;
 b=b7qJWxehGmeDac+trOTPayuAc+QmrWJa8NvOOA1qt+VANIiVyZGcCsiN4vHOB3tWLSvqjqn4wsQ6OlsoKCoDvYn2Bm/f2umYADWp+KaKyaVlBgc9nnEGc7wogyBIOVxaTe04F5jz2vBBt0bGRbiD9ssvUZrmViUCd/9JZJZhKQ/VU/r3X+DYVFDvS0tXomokZrfHACR42LgdeCLfjhUl6RU8e4uV1vuhHrTYcLeWaOlmGW+We9XUrSStaWG4GPagQJH/C5w1yLDi1Wu/YaVRDSm7oal+jHtj0GzrE2rtT6ImSR5qmX0cguf3B9Lp5KMBbTLkIQcrx82tvknSFczFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by MW2PR1501MB1996.namprd15.prod.outlook.com (2603:10b6:302:3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 20:18:27 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 20:18:27 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     "trix@redhat.com" <trix@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: zstd: clean up double word in comment.
Thread-Topic: [PATCH] lib: zstd: clean up double word in comment.
Thread-Index: AQHYDgCFZGbuS3SgUE2sqPL7ZC4PyaxyoxUA
Date:   Mon, 24 Jan 2022 20:18:27 +0000
Message-ID: <BFE23560-5B80-4876-9FAA-726E0E9AADC1@fb.com>
References: <20220120132006.749016-1-trix@redhat.com>
In-Reply-To: <20220120132006.749016-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f739f530-6ea3-4757-e03f-08d9df76ae64
x-ms-traffictypediagnostic: MW2PR1501MB1996:EE_
x-microsoft-antispam-prvs: <MW2PR1501MB19963DA3A30582C0053A763FAB5E9@MW2PR1501MB1996.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ut126Y7tyPJ1otv4wkU4xjoYJnwZ9UF5WZQhb1BckFA/m2nRVUDicmMKWSVAik1MWu9kgTQPpgo/aCi9B3P5kbvoSOHMOAa/LCkAVOeVNmYI7vQ+qnFmijqnlihwo+UJX+xdd9ew5aYGKT9Ug+JItkLY9um2VvNb4iYnLSuN5qNdGB4NMNuZR8y/7ZFMsN3rU6H3D2KM87jnP1IfN/RHnkCF7W2ijA1woEJpxg/MoAdeFpqvEby8DN1n4zn6PY+LZikjaaUViU1/i63+/GDuaFiCOYyqhG4T2d1Qpcdj1q2CWu+Fv713Pay7U8StgoqUzHYfywZXceIH2h3zygXh8Ph83ejqiOGTBmNAYSJRKt1n1NfsXFuyvCBQ2yaIx3TO7LwSOGWtfi1yhaPf33azNLVrfjc2tOy6QgQhJGoQdHtAPHQVEsZCR+Q8IP/MyEaTg2g5McIHbrLXQKjiSFl+8rI97cZaKBuF1grwxqnNFymgjvmcTvsJjL5HkzdlA16IBKRTA8bSU+A0V97B7/3Ryoef22WVprij0ztMowYwc2D+wljGwoquqDNfNZtlmWIWGKoqpIXJR9vw56ZOzWPe4/kGohJA8PCyMPMqx3nk7gQTAGGxLDmdALQGSJrRygkPzmpRDzbNM/GFj2WIfQyMllVO/I8q49P0Q3WuEbbFM6YkbUZIhZKVmTjB3vR4dFmSr2j/sABREr1j8NtSCWp2JAyaOCp/6YPw0rRiDN5N5rTmOd3TARpZxf7h15mgstsQ5Ja13zKJNgRZebAA0hiQTT2aWMUp7ADqg7UpqlsetHGpu+Gz3wJ/hzFU4CL4dK72tMwIOnEiW2cTCopwgoD11Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(186003)(508600001)(2906002)(6512007)(38070700005)(26005)(38100700002)(36756003)(83380400001)(71200400001)(53546011)(966005)(2616005)(6916009)(6506007)(76116006)(5660300002)(4326008)(66946007)(66476007)(66556008)(64756008)(66446008)(8936002)(33656002)(8676002)(316002)(6486002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CmHGaC5413CiPgwrK0wDG6spVdWtUGZVlUneyg0VXE6LD1xvPOQfusApnCSA?=
 =?us-ascii?Q?pv/+Hlnntab6Ier2/6UrIR7BEkGYTG+MZMaREf3ofa0/APvABVAF8N+i4L9l?=
 =?us-ascii?Q?bMBNWGt17qHQGwch+eqKkRMeW78gWdAUaX0ekRpC9ZrBb59z5DrmJbRzAQLd?=
 =?us-ascii?Q?W16pyHGpY26JKoLmwwPpPJgfREwQIFY6ZvyoVAjXtZ6MU4JvzEsvPnIT7YJY?=
 =?us-ascii?Q?PbsETLqQskS66fPF5qgecmL8YFVoDGsiaBX2gJFdl70y+YwchHHq8GhkFc0G?=
 =?us-ascii?Q?NRqKtKEaiYgXTxee7kDw1NUyT9iwcx7JtoQO3/9JOLBNkEN2jeOUm8DBUwbh?=
 =?us-ascii?Q?56YNPbLpgdjWQQEP/snltEHY5TRIMpWT0z/Hb7cMJTds0EImxPgagt82j1V0?=
 =?us-ascii?Q?FGbCH8j2kXTrMa9GGK5CKqaFC3YVjayKosljtJqIK/V3qBhjP/Mahp9enzCe?=
 =?us-ascii?Q?VatacIMwyCt1HwrsCOeqfwp0fwC0wgKq3o4+ox8Tp4L5r72cBecIbtF9j5ah?=
 =?us-ascii?Q?V5iYdhfgxxzETRZ+QDxu4PypMA5VKLUmiYFZHMjHHK1GKPC87GhF8LfH477S?=
 =?us-ascii?Q?4JWdA6TRTkNXA+kdzZysG6q+ZWyXP8WsZS7bhToWWqRR+Oh3iAE+rbidvp+3?=
 =?us-ascii?Q?W0j/lfv/M5K8A3hADSeiWgnfkf2ctdmacYqtKlqyQaOG1UoEam1UGVjgERfQ?=
 =?us-ascii?Q?fjbG4alm26F/UoGNhTlMJhhz8g+KrWNrd9AbWTAWG56K7ccgr9gDF2r+0NM8?=
 =?us-ascii?Q?rvIShXxinjZ6uP92cblI/DlT9AAwePP/jTN4bOpb0cImZzX8R5g1ml+F/Huc?=
 =?us-ascii?Q?irBkiztVSdmO6w8tfLsZcT5+uOX8eIKkeOVqqjCkjz9N2zik74pAE27JDFfz?=
 =?us-ascii?Q?uoXzMSOk5DpHF9+27gkbgtGk+veCyDqxl8ahjsBH1TOo5SYiiRkfr9RZ+Ajs?=
 =?us-ascii?Q?Ru88jIc20jP7aChlfbazs73eF2WrXjOoAB+A19mfVzAUVt3s13gC03KujfEj?=
 =?us-ascii?Q?LAa2j49Kc2U0Mb45W6QMrXto2uT7BRNxO2KLvkYSKKbjZjq/ELZ1TEDbqhMo?=
 =?us-ascii?Q?kA6aVsWiKd3vz33PP6IhWXQYdUR0CN7szgW0VekvODHa6Yf654nRnFgoKZSK?=
 =?us-ascii?Q?cvGAb51f7J5oa5gdL2X9FzbRyoWGRewIbmosc5tDMwpvXLexOY+vY4t9XG0x?=
 =?us-ascii?Q?Skvzwt9ECtOAEpdcV3RSiqk0o+Yf1PRZ7T4LoIymQBUxHv8wYv7cp/LNGHAx?=
 =?us-ascii?Q?rU1Z0cu+LFRL6iNPyvt7cUwdkasdtkd7n/teF2nq/p3ZHCWLnzjrXYImUpB0?=
 =?us-ascii?Q?yQ/hjz+VIB0IE3GdJ6saBznwpyvn3wQIbCjtlUvmOAUTSVPfaBwfFHuerpz8?=
 =?us-ascii?Q?IXFdgLp/gBHLJ0V8o6NEXrmO9cSGSWo0T8Rek3Eyzc0T+YppkqgDFVrL9WQW?=
 =?us-ascii?Q?9a9hy1oj51wLHFieY9BbtNfXOR/0+8hE15rKuA5dZQtAGoNxD8aFuIaI+pUO?=
 =?us-ascii?Q?g1XV2CPyM1GbitjMzDmfSHuKA0CtiPGu2ENuOAo0uxICMrPoI3Npfb/MgC+N?=
 =?us-ascii?Q?sOdeqwJWekx/mqZSzzs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADBF98114E1AA24A9E8FBE387A620597@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f739f530-6ea3-4757-e03f-08d9df76ae64
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 20:18:27.3992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3t45dPxGVKktBblyrT2DxVUnk2qppz+pEsC3JAhUNI4JcsPedEpziFl1TZ9nH5mV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB1996
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: okKHJCrShdYjZuNvRnQxgIvuW8qSYh0w
X-Proofpoint-GUID: okKHJCrShdYjZuNvRnQxgIvuW8qSYh0w
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2022, at 5:20 AM, trix@redhat.com wrote:
> 
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'a' and 'into'.

Thanks for the patch!

I'll merge this into my tree and get this into the 5.18 merge window.

If you are able to, can you please submit this patch as a PR upstream [0]?
Else, I will backport it before my next update. Either way I'll merge this patch.

Best,
Nick Terrell

[0] https://github.com/facebook/zstd/blob/dev/lib/zstd.h#L1396-L1407

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> include/linux/zstd_lib.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
> index b8c7dbf98390f..6b91758b61af9 100644
> --- a/include/linux/zstd_lib.h
> +++ b/include/linux/zstd_lib.h
> @@ -1330,7 +1330,7 @@ ZSTDLIB_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Sequence* outSeqs,
> 
> /*! ZSTD_mergeBlockDelimiters() :
>  * Given an array of ZSTD_Sequence, remove all sequences that represent block delimiters/last literals
> - * by merging them into into the literals of the next sequence.
> + * by merging them into the literals of the next sequence.
>  *
>  * As such, the final generated result has no explicit representation of block boundaries,
>  * and the final last literals segment is not represented in the sequences.
> @@ -1377,7 +1377,7 @@ ZSTDLIB_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size
> /*! ZSTD_writeSkippableFrame() :
>  * Generates a zstd skippable frame containing data given by src, and writes it to dst buffer.
>  *
> - * Skippable frames begin with a a 4-byte magic number. There are 16 possible choices of magic number,
> + * Skippable frames begin with a 4-byte magic number. There are 16 possible choices of magic number,
>  * ranging from ZSTD_MAGIC_SKIPPABLE_START to ZSTD_MAGIC_SKIPPABLE_START+15.
>  * As such, the parameter magicVariant controls the exact skippable frame magic number variant used, so
>  * the magic number used will be ZSTD_MAGIC_SKIPPABLE_START + magicVariant.
> -- 
> 2.26.3
> 

