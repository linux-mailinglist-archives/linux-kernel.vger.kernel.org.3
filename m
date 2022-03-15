Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341AC4D9C55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348742AbiCONf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiCONfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:35:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794A6444;
        Tue, 15 Mar 2022 06:34:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FD59P5029145;
        Tue, 15 Mar 2022 13:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bJyKRxrsWBrEaTs2XgivE6722sehR8jqUmVbpWTq8Dw=;
 b=ksMm2OWhjs7WzikbpZ3VGTpfMqV+Ss+8jHj3GFIaBJlM0pOK/aDDQqdnIlgmcvkSrv5H
 Ldsaa6aPweU9H2hS30GaTNq5+02dYSaCyzDIsH/pQWYaufJIYZDu72lcZ0lgulKUdbF9
 91x5h+PUXJplGPvngjR8J+lVGLW9va4SrVZbIbV15oUnGXLXKAlgM+TMgOaW/V3Jr+CP
 soFvb0ydjatyV1YUe3Th+m8pgiu8LtPsBjLxLHLcWkrJ/hxJwbj6NBODX4iCHuiDk/9o
 7GCgKFtc2q+UzNTffq6aZs7izenZ0Z6JPA88mz6mN1556UCb6MvsLvaNbCLixaysdKe7 wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwk1mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 13:33:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FDW0oe173617;
        Tue, 15 Mar 2022 13:33:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3et64jyc9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 13:33:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4C6OIevE2aZ/vg4Dz2/YRXgJ0aXReq0yBpkXZs1ctsIF1DRFeOLkAmWDvun3unwVNwu9du1DYSgAlr9UmEHfSpFJovEawme1Tj9IUFdu/746QXOCEIiS/xo/S9lyqhOKhaBkoWkrs1JUDuIusqIE1QVb0y6H0uqX4J6JTcSwPcrwQK3PvH4XUWhx9DE8SKRj1CsSGS2rpp7IqzKaY+oI6FxHdlhUzHXcwniADPyyb34jc7oYxhBug0qtecwxY4vCEtBMAIwXI3LASEixkq9I9SQFUusXSXs8qaRtQha5nMjoq9iAHK/dQwSqAxV5VmBL8j0f5ZZBWyxNe6C0cIcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJyKRxrsWBrEaTs2XgivE6722sehR8jqUmVbpWTq8Dw=;
 b=NE36GSzjEXjxSoUcgGM1kaJT6iuBwyuFlyzU8hmuN8QYn1XPWhjSXPirnIB+OGgOxfXvIesa52+ti5zOcn5fyMTHVjWW/7jPkVQzpNfwPZRHoB/XPGdPNQNoMfrYBAOpz1TZ7rrqNJiyz71UrM3WKTB/tpNwrS7qDj726LyIVQw+24/F9pp9yhLEN+c0VgKK9FChgRqejqYXDB3RcEfx4pdcF39zUpwf0WtE1x0lYlhITfA/pceEUO3Q3Wcx+uP/H1EHMgnX3VvW4uSe/4xyLi6yDDIZXktqmfuXY3cS7iMq2qpocyYOukImI/lebL/kroOF1KqTYlQLRcEFQErsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJyKRxrsWBrEaTs2XgivE6722sehR8jqUmVbpWTq8Dw=;
 b=QM44Ygk2Q3BE4yn4+Ep4xUi6rh34xhr3e4utz9vQFNbJGmN5vK0rnIPByJIXwabuE5HNtHDlQuK/Xc3B5+rqJFsnbOTvsPRCDFcdpeihl+RFfWt/MnxaMm5+kHFkjcSdH9LmCp1Mt8zQVB98+JQqKkXqnUVaxXPWiRIqiJh/8p0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1352.namprd10.prod.outlook.com (2603:10b6:903:28::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 13:33:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 13:33:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the ftrace tree with the nfsd tree
Thread-Topic: linux-next: manual merge of the ftrace tree with the nfsd tree
Thread-Index: AQHYOCERC/ggh9jrUkKI/LHpz3zN0qzAckGA
Date:   Tue, 15 Mar 2022 13:33:30 +0000
Message-ID: <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
References: <20220315145828.413e9301@canb.auug.org.au>
In-Reply-To: <20220315145828.413e9301@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1783db4b-36b9-4808-fd0a-08da068864fe
x-ms-traffictypediagnostic: CY4PR10MB1352:EE_
x-microsoft-antispam-prvs: <CY4PR10MB135218D4FFA8EB170484EB2793109@CY4PR10MB1352.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/I3RVY/BMVAnbSqCmXwTd6Bi62eNPuFXCMhTBojTGE0+01OhDIY6/l7mHj7O3l4Ii3PYRxvNwn4B6Uvo5Qw11EX+OlXtdLMOz33gnIzE+/zwfU1BqQjik7ObtJooh+SZxxbmIdaXBJqPS0B16KqA532kmtWrNY3GJxMUQKUkYVUe6FhlMJkU624kvgrOgYclF8KB1uo0GdBX1OftLU8UfV6eyOOFph9STKdLgx8qmBxFYFHuIfm4ewHpYvsUtQ8+I1DsENFSJKkIF/hfRAKLjRk2mriECJH2CyUxzI1If5cQhCfN390iqAC1yAYDpMEL5YLUQlvy7WqDlTeXeMtVIudl0D0JAnXUQE/NB5vbi/4F26/wiceUULke9kwuyV7BaOgExJNk04ZGX4mk1iCdw7rNcTFAlXwZSa+J2K7wle486n7wjBvVnsgvpjiLX/ST6jN59quK18mp/iYINvgmCihAzs1dJGsXMAyTB5spiQ9brGMxGX+fhnWvCS7YE0RtEYbcLFVSXye9wqFOk834L7I6iObVTjBXESh/3+J0BJq8E91Z04Y2fSIUloAm/frLL7WBbFtJk2TyMOzXCPlp6xtYgFXZSLXxYcgPSMSp1npWYRF8rrORa8lyy6Vp35ksAkgRHsRPoKBgC9d/bovmprNYdWf/mLBq+/WTQk1cP8sJ2pyDGF5z65Z4ovKYucIJ8vEZ6IK6ZEWRUbgE+LFjLLfaStS39JshpiKWry+mzsF6kEKXyih7WApiB6L86bb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(91956017)(66476007)(66946007)(76116006)(64756008)(8676002)(38100700002)(66446008)(122000001)(316002)(66556008)(186003)(26005)(2616005)(5660300002)(8936002)(2906002)(86362001)(38070700005)(83380400001)(6506007)(6512007)(53546011)(54906003)(6916009)(508600001)(6486002)(71200400001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Q1Ba9SqW5KYZG3SUryhmKwnf4K7OF8h2VNY3layJ2YRSJ+ixHoJZYqV2rtr?=
 =?us-ascii?Q?jbsIa5NQkRIyGVdyV6WFar+1A66GDALit5Sc2G0W1TLDyjg6c0ivoYqUGGgr?=
 =?us-ascii?Q?WK5lGwvQWltLAXvC1cDeCKn2i1GGvGzrussNQ2x9Vtl1ZPyzQ45K3yRsuuZK?=
 =?us-ascii?Q?/0dxKMRnUtTb6oD6lGcLcHTKNAWcM6u3oW9i2hYWtkQ39aVJFbJcHtekBQ6j?=
 =?us-ascii?Q?Hd3dqk1iPRDlfKWH4p8Qj28Xiqjs527/u+ycGA4FFd54WG5niLPAJfeIjNHV?=
 =?us-ascii?Q?oxX+QDMnCGTyS/NECVE/YxjNJRTn0FEcLlloT4VgBDaCPCf2JXa0lWmHLEed?=
 =?us-ascii?Q?K+VCl3XYSaRikRkkCJFH+atlUs6t0nml5IA2CMnEDIQru5qGIO6q5kmXGjsX?=
 =?us-ascii?Q?dhOa6YYjdbnJ1FQ66RqbcCRidMHKmsf27u4ZRjLSJpOuu8WxnIY9jmw4kl5D?=
 =?us-ascii?Q?zqGAmoqcxAf8YJlDbwlSyY0auwb/CqGkcYPx2IhiHBDBtCWDK6iuanDusVvq?=
 =?us-ascii?Q?r6bCBMoCqS2adJ0KaGhFf+LqJmXngEfnLyGCd+oLbPhQsQZut7ZyLmSc9GrR?=
 =?us-ascii?Q?O7QmtWIIVObs5jfzBx7EO6brL5dIaYYU1Vhc+pe1ZKO5ZaSgRwRaDnt9bdP7?=
 =?us-ascii?Q?BtCR/Aarh5AKb3mDmzNUevEMTeFqnS1/wu7Y6ahpnas2SLf10CultPj0f5xi?=
 =?us-ascii?Q?u/fSbv4t44qAUaBUF47g4y9lGWw06h3+dMEz36tCH7GF9cUkYG4OdGV3r2ls?=
 =?us-ascii?Q?FHzR0+ma4kpUCcmkSqCkHf1iUR0dbHd9jfrUoiI0MtqQyAjmnp+at55tca0z?=
 =?us-ascii?Q?3pVIc8TbpEIa5wQ1J5CWN/8QE5xpjRqd96mpzn1egi+0RP6nQmYnGYU9+5yT?=
 =?us-ascii?Q?e+pcvtWw2CawsQ6JSHw9ye/WdYs3xJ/Ezhwi1cQv2VPt85azHiaC30JrQxOF?=
 =?us-ascii?Q?k2RQoxkAq2e4PeLj5kifWlJ/w4T/xFGphDm+QDM3QuanYlD7DCMUj7+GKnv+?=
 =?us-ascii?Q?LQM+P0QSCYM155ebkBQIWeuE4ipX04EwxDUQzfnoroHC59bEz4qAkHyAGsey?=
 =?us-ascii?Q?KcieQZi5PF0v5vE9NeeIgLT9HY6aZPFyVqsz7YvlTBTQ+Nc1l+2QbRD5Y9Wi?=
 =?us-ascii?Q?VwueiB9Aj/v4WKwBngivJ5fHpkL1GcCKeOwLFrroBpZ8Cd1mTEnqqf3NdMsV?=
 =?us-ascii?Q?oUqrb4arZM/tCZYvU3nJi7JQPJafXs+bxUBT2Yvf9k0si4sfCuBER+TFyt/D?=
 =?us-ascii?Q?iSw6Xmr9lgcFi0SaC9u/IVs8Ls9+EFaYSAL5pPLWpDpRI72U7Bew5THasTq6?=
 =?us-ascii?Q?l2SMpommzcbcXAl6ujSq3naYEz4VAmu+QC8lUUR1bKn+EX/lGlPsxT/3QOCj?=
 =?us-ascii?Q?xXlxyRlyFSBDZX1L8sawcLaVnPfSJbU6FcsTwAjLT/7NTwL7U8tdEtzrksn4?=
 =?us-ascii?Q?xsFIXyAOIda71/M4UtRWD/V9ip4oZgfIKA2tUUNsl5kUNtcPrLbwjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFD37D45A5396744A221E1ED3E1C2B00@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1783db4b-36b9-4808-fd0a-08da068864fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 13:33:30.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXGqwUuLPMqWUPhTPOrOOUOBQyyW/Sx3DgXlqU5jI99uPmTeO9LjQh+2E9rQacrL0mIttbGQSM0Fz1GGM+Tzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1352
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150088
X-Proofpoint-GUID: OkPHSgjcou8glhN-5VN9XBPLFpZCBlDK
X-Proofpoint-ORIG-GUID: OkPHSgjcou8glhN-5VN9XBPLFpZCBlDK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 14, 2022, at 11:58 PM, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
>=20
> Hi all,
>=20
> Today's linux-next merge of the ftrace tree got a conflict in:
>=20
>  include/trace/trace_events.h
>=20
> between commit:
>=20
>  d07c9ad62247 ("tracing: Introduce helpers to safely handle dynamic-sized=
 sockaddrs")
>=20
> from the nfsd tree and commit:
>=20
>  af6b9668e85f ("tracing: Move the defines to create TRACE_EVENTS into the=
ir own files")
>=20
> from the ftrace tree.
>=20
> Well, this is a pain :-(

Apologies. Steven, can you take the sockaddr patches in your tree
and resolve the x86_64 build issue?


> I fixed it up (I used the latter version of this file and then added
> the following merge fix patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 15 Mar 2022 14:47:18 +1100
> Subject: [PATCH] fix up for "tracing: Move the defines to create TRACE_EV=
ENTS into their own files"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> include/trace/stages/stage1_defines.h |  6 ++++++
> include/trace/stages/stage2_defines.h | 10 ++++++++--
> include/trace/stages/stage3_defines.h |  6 ++++++
> include/trace/stages/stage4_defines.h |  6 ++++++
> include/trace/stages/stage5_defines.h |  6 ++++++
> include/trace/stages/stage6_defines.h | 18 ++++++++++++++++++
> include/trace/stages/stage7_defines.h |  2 ++
> 7 files changed, 52 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/trace/stages/stage1_defines.h b/include/trace/stages=
/stage1_defines.h
> index 8ab88c766d2b..a16783419687 100644
> --- a/include/trace/stages/stage1_defines.h
> +++ b/include/trace/stages/stage1_defines.h
> @@ -29,6 +29,9 @@
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
>=20
> +#undef __sockaddr
> +#define __sockaddr(field, len) __dynamic_array(u8, field, len)
> +
> #undef __rel_dynamic_array
> #define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
>=20
> @@ -41,5 +44,8 @@
> #undef __rel_bitmask
> #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
>=20
> +#undef __rel_sockaddr
> +#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
> +
> #undef TP_STRUCT__entry
> #define TP_STRUCT__entry(args...) args
> diff --git a/include/trace/stages/stage2_defines.h b/include/trace/stages=
/stage2_defines.h
> index 9f2341df40da..42fd1e8813ec 100644
> --- a/include/trace/stages/stage2_defines.h
> +++ b/include/trace/stages/stage2_defines.h
> @@ -29,11 +29,14 @@
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
> -#undef __string_len
> -#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +#undef __sockaddr
> +#define __sockaddr(field, len) __dynamic_array(u8, field, len)
>=20
> #undef __rel_dynamic_array
> #define __rel_dynamic_array(type, item, len)	u32 item;
> @@ -46,3 +49,6 @@
>=20
> #undef __rel_bitmask
> #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, i=
tem, -1)
> +
> +#undef __rel_sockaddr
> +#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
> diff --git a/include/trace/stages/stage3_defines.h b/include/trace/stages=
/stage3_defines.h
> index 0bc131993b7a..e3b183e9d18e 100644
> --- a/include/trace/stages/stage3_defines.h
> +++ b/include/trace/stages/stage3_defines.h
> @@ -51,6 +51,12 @@
> 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
> 	})
>=20
> +#undef __get_sockaddr
> +#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(fi=
eld))
> +
> +#undef __get_rel_sockaddr
> +#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_=
array(field))
> +
> #undef __print_flags
> #define __print_flags(flag, delim, flag_array...)			\
> 	({								\
> diff --git a/include/trace/stages/stage4_defines.h b/include/trace/stages=
/stage4_defines.h
> index 780a10fa5279..e80cdc397a43 100644
> --- a/include/trace/stages/stage4_defines.h
> +++ b/include/trace/stages/stage4_defines.h
> @@ -41,6 +41,9 @@
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
> +#undef __sockaddr
> +#define __sockaddr(field, len) __dynamic_array(u8, field, len)
> +
> #undef __rel_dynamic_array
> #define __rel_dynamic_array(_type, _item, _len) {			\
> 	.type =3D "__rel_loc " #_type "[]", .name =3D #_item,		\
> @@ -55,3 +58,6 @@
>=20
> #undef __rel_bitmask
> #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, i=
tem, -1)
> +
> +#undef __rel_sockaddr
> +#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
> diff --git a/include/trace/stages/stage5_defines.h b/include/trace/stages=
/stage5_defines.h
> index fb15394aae31..7ee5931300e6 100644
> --- a/include/trace/stages/stage5_defines.h
> +++ b/include/trace/stages/stage5_defines.h
> @@ -81,3 +81,9 @@
> #undef __rel_bitmask
> #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, i=
tem,	\
> 					 __bitmask_size_in_longs(nr_bits))
> +
> +#undef __sockaddr
> +#define __sockaddr(field, len) __dynamic_array(u8, field, len)
> +
> +#undef __rel_sockaddr
> +#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
> diff --git a/include/trace/stages/stage6_defines.h b/include/trace/stages=
/stage6_defines.h
> index b3a1f26026be..2ac88e1a7677 100644
> --- a/include/trace/stages/stage6_defines.h
> +++ b/include/trace/stages/stage6_defines.h
> @@ -45,6 +45,15 @@
> #define __assign_bitmask(dst, src, nr_bits)					\
> 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
>=20
> +#undef __sockaddr
> +#define __sockaddr(field, len) __dynamic_array(u8, field, len)
> +
> +#undef __get_sockaddr
> +#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(fi=
eld))
> +
> +#define __assign_sockaddr(dest, src, len)					\
> +	memcpy(__get_dynamic_array(dest), src, len)
> +
> #undef __rel_dynamic_array
> #define __rel_dynamic_array(type, item, len)				\
> 	__entry->__rel_loc_##item =3D __data_offsets.item;
> @@ -76,6 +85,15 @@
> #define __assign_rel_bitmask(dst, src, nr_bits)					\
> 	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
>=20
> +#undef __rel_sockaddr
> +#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
> +
> +#undef __get_rel_sockaddr
> +#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_=
array(field))
> +
> +#define __assign_rel_sockaddr(dest, src, len)					\
> +	memcpy(__get_rel_dynamic_array(dest), src, len)
> +
> #undef TP_fast_assign
> #define TP_fast_assign(args...) args
>=20
> diff --git a/include/trace/stages/stage7_defines.h b/include/trace/stages=
/stage7_defines.h
> index d65445328f18..8a7ec24c246d 100644
> --- a/include/trace/stages/stage7_defines.h
> +++ b/include/trace/stages/stage7_defines.h
> @@ -13,10 +13,12 @@
> #undef __get_dynamic_array_len
> #undef __get_str
> #undef __get_bitmask
> +#undef __get_sockaddr
> #undef __get_rel_dynamic_array
> #undef __get_rel_dynamic_array_len
> #undef __get_rel_str
> #undef __get_rel_bitmask
> +#undef __get_rel_sockaddr
> #undef __print_array
> #undef __print_hex_dump
>=20
> --=20
> 2.34.1
>=20
> However, my x86_64 allmodconfig build then failed like this:
>=20
> In file included from include/trace/define_custom_trace.h:55,
>                 from samples/trace_events/trace_custom_sched.h:95,
>                 from samples/trace_events/trace_custom_sched.c:24:
> samples/trace_events/./trace_custom_sched.h: In function 'ftrace_test_cus=
tom_probe_sched_switch':
> include/trace/trace_custom_events.h:178:42: error: passing argument 1 of =
'check_trace_callback_type_sched_switch' from incompatible pointer type [-W=
error=3Dincompatible-pointer-types]
>  178 |         check_trace_callback_type_##call(trace_custom_event_raw_ev=
ent_##template); \
>      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>      |                                          |
>      |                                          void (*)(void *, bool,  s=
truct task_struct *, struct task_struct *) {aka void (*)(void *, _Bool,  st=
ruct task_struct *, struct task_struct *)}
> include/trace/trace_custom_events.h:34:9: note: in expansion of macro 'DE=
FINE_CUSTOM_EVENT'
>   34 |         DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(args=
));
>      |         ^~~~~~~~~~~~~~~~~~~
> samples/trace_events/./trace_custom_sched.h:21:1: note: in expansion of m=
acro 'TRACE_CUSTOM_EVENT'
>   21 | TRACE_CUSTOM_EVENT(sched_switch,
>      | ^~~~~~~~~~~~~~~~~~
> In file included from include/linux/trace_events.h:11,
>                 from samples/trace_events/trace_custom_sched.c:10:
> include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, bool,=
  unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void (*=
)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *=
)'} but argument is of type 'void (*)(void *, bool,  struct task_struct *, =
struct task_struct *)' {aka 'void (*)(void *, _Bool,  struct task_struct *,=
 struct task_struct *)'}
>  279 |         check_trace_callback_type_##name(void (*cb)(data_proto))  =
      \
>      |                                          ~~~~~~~^~~~~~~~~~~~~~~
> include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_=
TRACE'
>  419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),        =
      \
>      |         ^~~~~~~~~~~~~~~
> include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_TR=
ACE'
>  553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>      |         ^~~~~~~~~~~~~
> include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_EV=
ENT'
>  222 | TRACE_EVENT(sched_switch,
>      | ^~~~~~~~~~~
>=20
> So I gave up and uses the ftrace tree from next-20220310 for today.
>=20
> I am going to need some help with this mess, please.
> --=20
> Cheers,
> Stephen Rothwell

--
Chuck Lever



